From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 07/10] t5100-mailinfo.sh: use the $( ... ) construct for
 command substitution
Date: Mon, 28 Dec 2015 08:44:20 +0100
Message-ID: <5680E854.7050001@kdbg.org>
References: <1450798073-22811-1-git-send-email-gitter.spiros@gmail.com>
 <1450798073-22811-8-git-send-email-gitter.spiros@gmail.com>
 <567997E4.1000700@kdbg.org> <5679B3E2.7090406@kdbg.org>
 <xmqq7fjzbgkr.fsf@gitster.mtv.corp.google.com>
 <xmqq37unbaff.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 08:45:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDSUI-0005DT-2y
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 08:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbbL1HoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 02:44:24 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:13243 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbbL1HoX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 02:44:23 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pTW9J5WXKz5tl9;
	Mon, 28 Dec 2015 08:44:20 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 3BDB653B7;
	Mon, 28 Dec 2015 08:44:20 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <xmqq37unbaff.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283030>

Am 28.12.2015 um 02:59 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Very true.  Let's leave that kind of things as separate clean-ups
>> after these patches settle, as mixing manual and mechanical changes
>> in a single patch makes it harder to review.
>>
>> Thanks.
>
> So that I won't forget (I'll need to amend with your sign-off even
> if this one is satisfactory to you).
>
> -- >8 --
> From: Johannes Sixt <j6t@kdbg.org>
> Date: Tue, 22 Dec 2015 19:35:16 +0100
> Subject: [PATCH] t5100: no need to use 'echo' command substitutions for globbing
>
> Instead of making the shell expand 00* and invoke 'echo' with it,
> and then capturing its output as command substitution, just use
> the result of expanding 00* directly.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   t/t5100-mailinfo.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
> index 4e52b3b..85b3df5 100755
> --- a/t/t5100-mailinfo.sh
> +++ b/t/t5100-mailinfo.sh
> @@ -23,7 +23,7 @@ check_mailinfo () {
>   }
>
>
> -for mail in $(echo 00*)
> +for mail in 00*
>   do
>   	test_expect_success "mailinfo $mail" '
>   		check_mailinfo $mail "" &&
> @@ -51,7 +51,7 @@ test_expect_success 'split box with rfc2047 samples' \
>   	echo total is $last &&
>   	test $(cat rfc2047/last) = 11'
>
> -for mail in $(echo rfc2047/00*)
> +for mail in rfc2047/00*
>   do
>   	test_expect_success "mailinfo $mail" '
>   		git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Thank you for making a proper patch!

-- Hannes
