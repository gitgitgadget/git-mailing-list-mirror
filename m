From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] submodule deinit test: fix broken && chain in subshell
Date: Tue, 03 May 2016 09:19:07 -0700
Message-ID: <xmqqvb2vnmh0.fsf@gitster.mtv.corp.google.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
	<1462227844-10624-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens.Lehmann@web.de, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 18:19:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axd2a-0008AC-Ir
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606AbcECQTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 12:19:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933513AbcECQTL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 12:19:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 516C217A1E;
	Tue,  3 May 2016 12:19:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DKmJpdlB09huXXYZxn0RQbVnXls=; b=aM3VTY
	5C+SQEb4XFVl+4sLoYzYh7xNLKDGyOu3jTZmUrnF6WAmS31wRj0JJ0TwpPhcOYVm
	c8sTNk3xfA7r5QAXswhtZH8UdtuTUoxu62hvbKnGHSMV1LJE1MsPMN3xX1p97YWJ
	QtO6BLE2H6wNDdzSpa1B0Ka1CFTwqbaVtFqXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R2AAqzw0XUZ6bLaheO2A8nBuLHYc1hab
	f8sAeUg5K8ibGwjRc2O08wHBf/ZV2PHk3MyFMj1bZ5NqAIBiSHIJ5fqThEnF7wjT
	cqFjOF5SCW5K4eotz8rDPDafAmyIQZEvKkRltnrXQzl6RJ5CeznLubr6Mb/hcsOn
	FZc5B0EPJPc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 496B817A1C;
	Tue,  3 May 2016 12:19:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8495417A1B;
	Tue,  3 May 2016 12:19:09 -0400 (EDT)
In-Reply-To: <1462227844-10624-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 2 May 2016 15:24:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C408DB8C-114A-11E6-A6EE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293411>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t7400-submodule-basic.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 814ee63..90d80d3 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -914,7 +914,7 @@ test_expect_success 'submodule deinit works on repository without submodules' '
>  		git init &&
>  		>file &&
>  		git add file &&
> -		git commit -m "repo should not be empty"
> +		git commit -m "repo should not be empty" &&
>  		git submodule deinit .
>  	)
>  '

Thanks.

As this was introduced by 84ba959b (submodule: fix regression for
deinit without submodules, 2016-03-22), which was merged to the
mainline at v2.8.0-rc4-8-g2a4c8c3 and applies there, let's queue it
there.
