From: Andrew Garber <andrew@andrewgarber.com>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 16:12:49 -0400
Message-ID: <AANLkTim+iQ89b49nC8NRtoUobV4tMVL+bCoW-vg3+rLD@mail.gmail.com>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
 <AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>
 <4D909DD1.2050904@viscovery.net> <AANLkTinC9Lr9uCTUZSVxVR56+FQm2NGRpPu90fm9OHF5@mail.gmail.com>
 <vpq62r3i1z4.fsf@bauges.imag.fr> <AANLkTimT+WN2F-BmQzQrAs3uizHig9cCXDUdc7nQ-vC5@mail.gmail.com>
 <vpqr59r6sg5.fsf@bauges.imag.fr> <AANLkTinuH4Ut+jtdqRfFrNeXA6JmBK2i0ddCcz4vV6JC@mail.gmail.com>
 <vpqvcz35cjk.fsf@bauges.imag.fr> <AANLkTikADLZvN0N==_H47O1vcrap1_Mcf7vW69d5sh0d@mail.gmail.com>
 <AANLkTimR5XfOV-0RZjdyu72E9JdBfr1B+wc=q55V4qH5@mail.gmail.com> <vpqbp0v2fve.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: demerphq <demerphq@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 28 22:13:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4IoW-0005Zy-9y
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 22:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911Ab1C1UNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 16:13:11 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57027 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab1C1UNK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 16:13:10 -0400
Received: by ewy4 with SMTP id 4so1296054ewy.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 13:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=dGmlZXRXPr0xL4+fOut/gQvOUCEKmOY2hn6FH+/bT58=;
        b=cX/GmyFieLVQTsNA2H7stud34t1Ex7Iz4njsThv2Q0/7ttLshwH+kK+ZTKAMFrGMva
         x6vrggLi08OUH9wmjcuYzDPekBh04Dv6x7ddto+giSU/VWYTU47qhSOHrL4d3qTPsO2D
         z3HKmeQhBo9Ie3ax8YB5lXyU2nMT5np+nVrt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=Ph+RhpmLZr/7HLXhP6efiMwBpUWPjCrYeKNV1cEF/83WMQe+cYVgQjR7tQ6o802D/s
         lhqb+20QzZ4GeJ17jWCogVRpahaLzprYP35i0vX3JUPCFMra7g0lJXm29ejx0uuQfQv+
         sDb2tZ7HOnMvEqEGg8dHq6Ck3gRIHlbdwZQFM=
Received: by 10.213.8.203 with SMTP id i11mr1529112ebi.106.1301343189158; Mon,
 28 Mar 2011 13:13:09 -0700 (PDT)
Received: by 10.213.105.76 with HTTP; Mon, 28 Mar 2011 13:12:49 -0700 (PDT)
In-Reply-To: <vpqbp0v2fve.fsf@bauges.imag.fr>
X-Google-Sender-Auth: gGzQDWUgm37raUU4Ky_bXXn7wLc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170182>

> Suppose you have a bug in git.git that you see in pu, but not in next.
> Try finding the common ancestor with your command, and see how long it
> takes.

Fair enough.

> Yes, you'll be able to do it, but you still didn't tell us what was
> wrong with
>
> git bisect start
> git bisect good origin/next
> git bisect bad origin/pu
> ...
>
> which is _way_ faster. And my example took git.git which isn't a very
> large project, so real-life examples could be much worse.

But what about demerphq's example? (see below)

>      Bx--B--B--B*
>     /
>  --Gz--By--B--Gx--G*
>
> How does knowing that G* is good help you to find that Bx broke the
> code in the B* branch again?
>
> Presumably 'By' broke the G* branch which was then fixed by Gx and
> none of this information helps you at all identify that Bx broke the
> B* branch.
>
> Whereas a plain binary search on the B* branch would eventually find
> that Bx was responsible.
