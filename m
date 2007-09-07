From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 16:13:24 +0200
Message-ID: <03C31350-67A5-4B94-A841-5CEB37E78DE8@wincent.com>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <46E0EEC6.4020004@op5.se> <Pine.LNX.4.64.0709071155570.28586@racer.site> <46E13C0F.8040203@op5.se> <E4A6490A-ABA9-4383-978E-C7F2E4BC9C23@wincent.com> <46E1590A.4060504@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Sep 07 16:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITebK-0007Sg-I7
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 16:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965453AbXIGOOT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Sep 2007 10:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965444AbXIGOOT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 10:14:19 -0400
Received: from wincent.com ([72.3.236.74]:48741 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965434AbXIGOOS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 10:14:18 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l87EDVVo002025;
	Fri, 7 Sep 2007 09:13:32 -0500
In-Reply-To: <46E1590A.4060504@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58039>

El 7/9/2007, a las 15:58, Andreas Ericsson escribi=F3:

> Yes, but that's what I said in the original email as well. C is =20
> just so
> much more pleasant to write in that the only place you'd (sanely) use
> asm is in exactly these tight loops, where the code is likely to be =20
> used
> and reused until the algorithm it describes is no longer a viable =20
> option
> for doing what it was originally designed to do.
>
> It still proves the point though, as surely as n+1 > n for any =20
> value of n:
> Hand-optimized assembly is faster than compiler-optimized C code.

In a theoretical ideal world, yes; no one would argue that C is =20
faster than fine-tuned assembly.

But in the *real world* rewriting Git in assembly would be like =20
painting a house using a single horse hair instead of a paint brush =20
or roller. Your SHA-1 example is a perfect example of where you =20
benefit from doing a tiny embellished detail using the single hair =20
(assembly) and leave all the rest in C.

In the real world and not the theoretical ideal world, it's not just =20
about the diminishing returns you get from writing more and more of a =20
code base in assembly instead of just the performance-critical =20
bottlenecks; it's that you're more likely to make subtle mistakes or =20
even make things slower. GCC does a remarkable job of optimizing in a =20
huge number of use cases, and best of all, it does it for free. =20
Personal opinion, of course, but that's the way I think it is.

Cheers,
Wincent
