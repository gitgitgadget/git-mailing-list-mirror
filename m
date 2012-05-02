From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Wed, 2 May 2012 12:42:17 -0700
Message-ID: <CAE1pOi1SLU5_eLr3ahiUjzQqPUnVPX70CPq=OW-o-85Lk43GwA@mail.gmail.com>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
	<CAE1pOi0_ETdSYsuT0Udhbr6rDvmEcuTA157d6aKUosgi7w28jw@mail.gmail.com>
	<vpqfwbjnl4a.fsf@bauges.imag.fr>
	<CAE1pOi3RZ+x7YcVZ-dLt70=wwRsvY9D6GQR-T+JZ9S7x8CFjPw@mail.gmail.com>
	<7v1un2idt0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 21:42:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPfRP-0001si-Cn
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 21:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549Ab2EBTmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 15:42:19 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46721 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196Ab2EBTmS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 15:42:18 -0400
Received: by yhmm54 with SMTP id m54so1080950yhm.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z4r4JbefdmotSQr/5r8AGn/rM042ac8wu2X15kGPoE0=;
        b=A93YIdLq/5412FRW6dVGhZ/6eNzgT5zBSw0uyO/I9fpGFKcCR6vgJEYUmEhKfzmu1/
         xdMHs++zgza8Va1V2lEYdhvGhIKqZ6bA8VrcP/32WR9Qo63SAc9Q28QF1hpERKtYs26f
         w6OBk4FAZmvo0geLkRy7+V6W6fgrYpKwPvbI5SPER6K58HMFQR5cfE9NBW+FI6rEaOjE
         h7vEfqXOt/XrTi/ruymICLHYwf0D9EFO3R0MNex0Tm4Pg3TyuZA2BBcQN2GJERcOIMxT
         KHjbQrJA3oR8Z/zSEifFIpz/+fWrXSafFCF/73kn7t6mVDckJN7VNJsGfCR3axbVcPMP
         xtrQ==
Received: by 10.236.116.169 with SMTP id g29mr32221789yhh.54.1335987737972;
 Wed, 02 May 2012 12:42:17 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Wed, 2 May 2012 12:42:17 -0700 (PDT)
In-Reply-To: <7v1un2idt0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196855>

On 2 May 2012 12:27, Junio C Hamano <gitster@pobox.com> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> On 1 May 2012 23:38, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> ...
>>> Yes, but at least, you have the opportunity to examine the other places
>>> before they are ran. Hooks would be really, really nasty security-wise.
>>> For example, "git clone" does a checkout, so should probably run the
>>> checkout hooks.
>>
>> There is (or, rather, should be) absolutely no difference between code
>> changes and hook changes. Both would go through the same review
>> process.
>
> Matthieu is *not* talking about auditing nastiness going into the
> project's repository; he is talking is about a chance to audit whatever
> comes from the project's repository that *could* potentially contain some
> nastiness before it causes harm to your working environment. In other
> words, not *having* to trust what is in the project's repository, but
> having a way to verify.
>
> Read what he wrote again with that in mind, and you will understand his
> point.

Yes, I understand.

Perhaps these automatic hooks should only be applicable for "outgoing"
changes like commit and push? That way you can review the hooks before
they run but you still have a chance to prevent developer errors from
getting to the server/other people (which is really all I care about,
I am looking for a way to protect developers from making silly
mistakes).
