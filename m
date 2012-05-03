From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Thu, 3 May 2012 10:05:11 -0700
Message-ID: <CAE1pOi39i4hg_bTuigq15ifuKtXVW7F-NukMP57E_4e=s0fMdQ@mail.gmail.com>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
	<CAE1pOi0_ETdSYsuT0Udhbr6rDvmEcuTA157d6aKUosgi7w28jw@mail.gmail.com>
	<vpqfwbjnl4a.fsf@bauges.imag.fr>
	<CAE1pOi3RZ+x7YcVZ-dLt70=wwRsvY9D6GQR-T+JZ9S7x8CFjPw@mail.gmail.com>
	<7v1un2idt0.fsf@alter.siamese.dyndns.org>
	<CAE1pOi1SLU5_eLr3ahiUjzQqPUnVPX70CPq=OW-o-85Lk43GwA@mail.gmail.com>
	<87ipgdskpx.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Users <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 03 19:05:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPzSy-0003iM-HP
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 19:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab2ECRFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 13:05:14 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:38009 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab2ECRFM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 13:05:12 -0400
Received: by gghe5 with SMTP id e5so252516ggh.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FbwRH1wZrtZzdkMHumDYDiZ0vaiF3s7BGGAXsSGjpLs=;
        b=Zq4HhirWAUvI2VSY+OO/67yBulHxCK41RbTOxwlXWbw16ygkKRJgdkP9N1SXn5UC9K
         gTl80nAvryJQwTH7MwXRR1NWE9JzIwVq/8V2wwPSET5giubMz32akcPxBlbJN4oIPKw2
         7Ws6+XpubosfhP7q9GyLxWD+BVif9yLCccYMGZL3vqtDsBvdTuv9BYP8C+GktAsdzIXV
         d26gHGBatplrNpLUhQ5cOHGGKHYOFbhTh4qDmkDwoeaOAcaFPG9N2byyX/4MsjKFplLE
         XGWjebEADE9NINK2aaQzp+dhBsp4lgZT4TbXnxER3nJaaqfsvOCCKQ3IEdA7PBSFuW+g
         OhNg==
Received: by 10.236.78.37 with SMTP id f25mr3793772yhe.114.1336064712016; Thu,
 03 May 2012 10:05:12 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Thu, 3 May 2012 10:05:11 -0700 (PDT)
In-Reply-To: <87ipgdskpx.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196922>

On 3 May 2012 02:00, Thomas Rast <trast@student.ethz.ch> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>>> Matthieu is *not* talking about auditing nastiness going into the
>>> project's repository; he is talking is about a chance to audit whatever
>>> comes from the project's repository that *could* potentially contain some
>>> nastiness before it causes harm to your working environment. In other
>>> words, not *having* to trust what is in the project's repository, but
>>> having a way to verify.
>>
>> Perhaps these automatic hooks should only be applicable for "outgoing"
>> changes like commit and push? That way you can review the hooks before
>> they run but you still have a chance to prevent developer errors from
>> getting to the server/other people (which is really all I care about,
>> I am looking for a way to protect developers from making silly
>> mistakes).
>
> Shouldn't those checks be made server-side with a pre-receive hook?

Firstly, see my original email: we have no such access to the server.
Secondly, (now that I've thought about it a bit more), it makes more
sense to do it on the "client" instead of having the server do all the
work for everybody. (Fail early, fail fast.)
