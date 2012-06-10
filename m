From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-status: Show empty directories
Date: Sun, 10 Jun 2012 11:01:22 +0200
Message-ID: <87haujr15p.fsf@thomas.inf.ethz.ch>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
	<20120609221315.Horde.fN5FP3wdC4BP065b3FviijA@webmail.minatec.grenoble-inp.fr>
	<CAA3EhHJ9WnisF21iFfsjQKYFSY0t0jFvNV3aBjx0eGFPm8aoGg@mail.gmail.com>
	<877gvgrxw7.fsf@thomas.inf.ethz.ch>
	<20120609234717.Horde.I9rYUXwdC4BP08RlFRO2w_A@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Leila <muhtasib@gmail.com>, <git@vger.kernel.org>
To: <konglu@minatec.inpg.fr>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:01:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sde1c-0001bJ-CJ
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 11:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab2FJJB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 05:01:28 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:49739 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab2FJJB1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 05:01:27 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 10 Jun
 2012 11:01:21 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 10 Jun
 2012 11:01:24 +0200
In-Reply-To: <20120609234717.Horde.I9rYUXwdC4BP08RlFRO2w_A@webmail.minatec.grenoble-inp.fr>
	(konglu@minatec.inpg.fr's message of "Sat, 09 Jun 2012 23:47:17
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199578>

konglu@minatec.inpg.fr writes:

> Thomas Rast <trast@student.ethz.ch> a =C3=A9crit=C2=A0:
>
>> Leila <muhtasib@gmail.com> writes:
>>
>>>> The structure is
>>>> =C2=A0 =C2=A0 =C2=A0if (...) {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*code*/
>>>> =C2=A0 =C2=A0 =C2=A0} else {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*code*/
>>>> =C2=A0 =C2=A0 =C2=A0}
>>>>
>>>> Do not forget braces in the "else" part as the firt block needs it=
=2E
>>>
>>> I was under the impression that one liners didn't require parenthes=
is
>>> according to the style guidelines. I didn't realize that if the 'if=
'
>>> required it, then the else required it. I will make that change and
>>> remember it for the future. Thanks!
>>
>> It's not required, there's plenty of precedent, even one case within
>> wt-status.c, of '} else'.  Try running
>>
>>   git grep '} else$'
>
> It's not because "there's plenty of precedent" that we should not try
> to improve the format of the code. That's why there're coding style
> rules so that we can keep the improvements consistent.

Yeah, and the rules (Documentation/CodingGuidelines) say

 - We avoid using braces unnecessarily.  I.e.

	if (bla) {
		x =3D 1;
	}

   is frowned upon.  A gray area is when the statement extends
   over a few lines, and/or you have a lengthy comment atop of
   it.  Also, like in the Linux kernel, if there is a long list
   of "else if" statements, it can make sense to add braces to
   single line blocks.

I'm not the one who wrote them, but I'm taking the last sentence to mea=
n
that you should not put the braces unless the omission will break the
vertical alignment of the 'else if' chain.


BTW, there are plenty of cases in git where it is better to stick to th=
e
existing style of the file instead of the CodingGuidelines, unless you
are willing to clean up the file first (and nobody else works on it).

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
