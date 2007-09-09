From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Sun, 09 Sep 2007 02:09:33 +0200
Message-ID: <46E339BD.1090201@op5.se>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <46E0EEC6.4020004@op5.se> <Pine.LNX.4.64.0709071155570.28586@racer.site> <46E13C0F.8040203@op5.se> <E4A6490A-ABA9-4383-978E-C7F2E4BC9C23@wincent.com> <46E1590A.4060504@op5.se> <03C31350-67A5-4B94-A841-5CEB37E78DE8@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 10:55:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOZ-0003oI-Ad
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:55 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUANA-0006k2-NH
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:56 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAN5-0003zs-6p
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318AbXIIAJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 8 Sep 2007 20:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308AbXIIAJh
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:09:37 -0400
Received: from mail.op5.se ([193.201.96.20]:43279 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755235AbXIIAJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:09:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id AC3D5194414;
	Sun,  9 Sep 2007 02:09:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6c6KQltnHlv; Sun,  9 Sep 2007 02:09:35 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id AB5021943B6;
	Sun,  9 Sep 2007 02:09:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <03C31350-67A5-4B94-A841-5CEB37E78DE8@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.6, required=12.0, autolearn=disabled, AWL=0.375,UIO_VGER=-3)
X-UiO-Scanned: 8D125A03ABCC9B59F0E3B5561F6B114B94E7EF77
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -25 maxlevel 200 minaction 2 bait 0 mail/h: 9 total 517795 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58155>

Wincent Colaiuta wrote:
> El 7/9/2007, a las 15:58, Andreas Ericsson escribi=F3:
>=20
>> Yes, but that's what I said in the original email as well. C is just=
 so
>> much more pleasant to write in that the only place you'd (sanely) us=
e
>> asm is in exactly these tight loops, where the code is likely to be =
used
>> and reused until the algorithm it describes is no longer a viable op=
tion
>> for doing what it was originally designed to do.
>>
>> It still proves the point though, as surely as n+1 > n for any value=
=20
>> of n:
>> Hand-optimized assembly is faster than compiler-optimized C code.
>=20
> In a theoretical ideal world, yes; no one would argue that C is faste=
r=20
> than fine-tuned assembly.
>=20
> But in the *real world* rewriting Git in assembly would be like paint=
ing=20
> a house using a single horse hair instead of a paint brush or roller.=
=20
> Your SHA-1 example is a perfect example of where you benefit from doi=
ng=20
> a tiny embellished detail using the single hair (assembly) and leave =
all=20
> the rest in C.
>=20
> In the real world and not the theoretical ideal world, it's not just=20
> about the diminishing returns you get from writing more and more of a=
=20
> code base in assembly instead of just the performance-critical=20
> bottlenecks; it's that you're more likely to make subtle mistakes or=20
> even make things slower. GCC does a remarkable job of optimizing in a=
=20
> huge number of use cases, and best of all, it does it for free. Perso=
nal=20
> opinion, of course, but that's the way I think it is.
>=20

The discussion was theoretical from the beginning. Nobody's arguing tha=
t
git should be rewritten in asm, and you've been preaching to the choir =
far
too long now. I'll just drop this thread.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
