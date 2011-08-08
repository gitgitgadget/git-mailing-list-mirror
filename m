From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the
 operation
Date: Mon, 08 Aug 2011 09:28:32 -0700
Message-ID: <7vobzzwvug.fsf@alter.siamese.dyndns.org>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
 <1312454356-3070-18-git-send-email-artagnon@gmail.com>
 <CAP8UFD0izFOW0xHQB8ZT3+bbTjGtSm-ZWHs6AWdJoEneRX32mw@mail.gmail.com>
 <CALkWK0mKTXUxW=PT_wHEVAzUSgPdZ1s18-9ndZKJqSf6NwVH7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 21:24:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqVQk-00059y-9s
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 21:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab1HHTXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 15:23:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830Ab1HHTXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 15:23:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C8C03AE1;
	Mon,  8 Aug 2011 15:23:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=p3MFIJCQEubrllQLBOeF45GpcjY=; b=vtBh7W7Idn20232JPpzG
	jKsipkCnKdzZsNdGJZTnoYBKrRa9/rdzue0JLjReUk2TQDV/VJ2zQpAaxqrl9Hwk
	tXmDRir1EQEu4D4rhKzvPlhb/PFdrogwYSM/s1cwXf+jTIZToOoxwtR97a45Aqib
	ssFmoB1UDCsoj5xeL+7slw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ZS2gp4u7dsFjcgdb5Im1p5DFw5XFLFVk00d5neWV4b7DKy
	WIJ0gXvYPZpUHvVQaOXb/WAV0WpyxNYEq93ER1AqyoeVfcHAwB9DWwjF/i1oAevj
	uPyVS9QQ6rglQUvEOjfZlVv/PWKmsSRKoz59BSHzXqxfeMsMWp8WtGzEOiRgo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 150733AE0;
	Mon,  8 Aug 2011 15:23:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 620383ADE; Mon,  8 Aug 2011
 15:23:52 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3501BFE-C1F3-11E0-9D98-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178977>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio: Here's another small fixup patch for your convenience.

Not very convenient I am afraid ;-)

> --8<--

This seems to be too short for "am -c"; have you tried applying it
yourself first before sending it out?

> Subject: [PATCH] fixup! revert: Introduce --continue to continue the
>  operation
>
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t3510-cherry-pick-sequence.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 78f3f01..3bca2b3 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -171,7 +171,7 @@ test_expect_success '--continue respects opts' '
>         grep "cherry picked from" anotherpick_msg
>  '
>
> -test_expect_success '--signoff is not automatically propogated to
> resolved conflict' '
> +test_expect_success '--signoff is not automatically propagated to
> resolved conflict' '

Linewrapped.

I'll squash this manually, so no need to resend. Thanks.
