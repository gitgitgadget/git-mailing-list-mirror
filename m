From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7500: fix flipped actual/expect
Date: Mon, 01 Jul 2013 09:52:05 -0700
Message-ID: <7vwqpagr4a.fsf@alter.siamese.dyndns.org>
References: <1372695636-10768-1-git-send-email-andrew@pimlott.net>
	<1372695636-10768-2-git-send-email-andrew@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Mon Jul 01 18:52:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UthKo-0002By-K1
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 18:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab3GAQwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 12:52:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197Ab3GAQwI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 12:52:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD3F72D7CA;
	Mon,  1 Jul 2013 16:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eh/eyYNfsOrF5iodtUhMEDxmSPw=; b=KBPEyR
	b0I5rEvMyUvSLpsrQ+tP0Ylt2zLWoMGG9ua7nIrns43tuKDr1lbT2JAfPe1bwf49
	CXiHN/CmJaOch9xebkjLacBsHkt8jKiy/1V8AQlkTbMEL99GoD+6WFLga0ccdA/y
	M2iU7rPH8f29Rs7DLFUM0c1dMcVjVzwKtbRTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T1hbE9dwPRBD4EmOi/IOQP2ReyE9GqCC
	4CqtrFeFVDwPZrPhXS2/6gHm+wcjBDvPDgoa0qWrGx90A69kzRkDwB2KDrGEMAkO
	vAfwVrGGG49dRCXXDrdHEr7W9aVGkmIUDtZuA1yArNBmdor98pxl9yeV9iaFeMa6
	Uz+WYTQXplw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74F632D7C8;
	Mon,  1 Jul 2013 16:52:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7C582D7C5;
	Mon,  1 Jul 2013 16:52:06 +0000 (UTC)
In-Reply-To: <1372695636-10768-2-git-send-email-andrew@pimlott.net> (Andrew
	Pimlott's message of "Mon, 1 Jul 2013 09:20:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 902BF848-E26E-11E2-87FA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229312>

Andrew Pimlott <andrew@pimlott.net> writes:

> Signed-off-by: Andrew Pimlott <andrew@pimlott.net>
> ---
>  t/t7500-commit.sh |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
> index 436b7b6..e166ac8 100755
> --- a/t/t7500-commit.sh
> +++ b/t/t7500-commit.sh
> @@ -13,8 +13,8 @@ commit_msg_is () {
>  	expect=commit_msg_is.expect
>  	actual=commit_msg_is.actual
>  
> -	printf "%s" "$(git log --pretty=format:%s%b -1)" >$expect &&
> -	printf "%s" "$1" >$actual &&
> +	printf "%s" "$(git log --pretty=format:%s%b -1)" >$actual &&
> +	printf "%s" "$1" >$expect &&
>  	test_i18ncmp $expect $actual
>  }

Wow.  How could all of us missed this for a long time?

Thanks, the change obviously looks good.
