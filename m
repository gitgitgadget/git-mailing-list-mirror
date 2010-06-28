From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [PATCH] Add known breakage for 'git notes copy'
Date: Mon, 28 Jun 2010 08:44:44 -0700
Message-ID: <AANLkTilitBVovB0kzSmGGE0TIQB_u1M9nIESIRvkmigh@mail.gmail.com>
References: <41768aafce7a581e8b601e70826ce77381458a23.1277708369.git.bert.wesarg@googlemail.com> 
	<20100628085907.GA14014@coredump.intra.peff.net> <AANLkTimap7ziJ-NuAV6h7bGP3cX2cDY7rqEbgJ2unQSP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 17:45:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTGWI-0003TQ-Ky
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 17:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491Ab0F1PpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 11:45:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57377 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab0F1PpG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 11:45:06 -0400
Received: by gxk23 with SMTP id 23so146239gxk.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mWkTzqLQ/hjq2Lgrt/ItA2w45LzxrMpJ1yZ789iq1gE=;
        b=KAKMcBvY7NVxlwT6tbBhrZAS2joue8Hnzm3xvOkJAePf2u4qFg7CUhVNGR1CyTIRrI
         5A3C1GkZBL7L2Cx7pM9BujMk1Y/8d0mYtL8za2SopLN76B0feRMhYtmXZ5IDixIC66rl
         i3QDBGSpTdi9CKIH5qncxRykQyhGqetxfbEPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UiejZY3OoNow4I0M8015UKY8zVHT7iKtWD1PIjIVR6gLGmj2DTMsDHnBfqcwdA/o8Q
         GV6ENH6+S0pUP+BZZ7+96cXTdHL4v6amU2TI014kijWHdrq+h2pouBKpINEcj/DlNUJ6
         cfB8JrswzI+3GTi3NSN+Lv85Ett9cmEVQas4Y=
Received: by 10.229.214.10 with SMTP id gy10mr2788218qcb.195.1277739904321; 
	Mon, 28 Jun 2010 08:45:04 -0700 (PDT)
Received: by 10.229.222.72 with HTTP; Mon, 28 Jun 2010 08:44:44 -0700 (PDT)
In-Reply-To: <AANLkTimap7ziJ-NuAV6h7bGP3cX2cDY7rqEbgJ2unQSP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149832>

On Mon, Jun 28, 2010 at 02:12, Bert Wesarg <bert.wesarg@googlemail.com>=
 wrote:
> On Mon, Jun 28, 2010 at 10:59, Jeff King <peff@peff.net> wrote:
>> On Mon, Jun 28, 2010 at 09:01:57AM +0200, Bert Wesarg wrote:
>>
>>> 'git notes copy' dumps core when no arguments are given.
>>
>> How about:
>
> Thanks.
>
> Tested-by: Bert Wesarg <Bert.Wesarg@googlemail.com>
>
> FWIW, here is the correct and updated test for this:
>
> -- >8 --
> Subject: [PATCH] notes: add test for git-notes copy with too few argu=
ments
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
> =C2=A0t/t3301-notes.sh | =C2=A0 =C2=A05 +++++
> =C2=A01 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 64f32ad..dcd962a 100755 t/t3301-notes.sh
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1044,4 +1044,9 @@ test_expect_success 'GIT_NOTES_REWRITE_REF
> overrides config' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log -1 > output &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expect output
> =C2=A0'
> +
> +test_expect_success 'git notes copy does not segfaults with too few
> arguments' '
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git notes copy
> +'
> +
> =C2=A0test_done
>

Minor nit: s/does not segfaults/does not segfault/
