From: martin f krafft <madduck@madduck.net>
Subject: Re: Storing additional information in commit headers
Date: Tue, 2 Aug 2011 21:06:45 +0200
Message-ID: <20110802190645.GB17322@fishbowl.rw.madduck.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
 <20110801211104.GC15401@fishbowl.rw.madduck.net>
 <20110802035056.GB17494@sigill.intra.peff.net>
 <20110802082810.GC29887@fishbowl.rw.madduck.net>
 <20110802185154.GA2499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
To: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Aug 02 21:07:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoKJ1-0006l2-Qm
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 21:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038Ab1HBTHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 15:07:03 -0400
Received: from seamus.madduck.net ([213.203.238.82]:43622 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027Ab1HBTHB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 15:07:01 -0400
Received: from fishbowl.rw.madduck.net (28-193.78-83.cust.bluewin.ch [83.78.193.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id C90FF407D3B;
	Tue,  2 Aug 2011 21:06:46 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 941701FE57; Tue,  2 Aug 2011 21:06:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110802185154.GA2499@sigill.intra.peff.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.1 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178500>


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Jeff King <peff@peff.net> [2011.08.02.2051 +0200]:
> I agree that is an annoyance, but it is one we can deal with. In the
> near term, I wonder if a "tg clone" would be appropriate to add the
> extra fetch refspecs when cloning (or even a "tg init" inside an
> existing git repo -- I don't actually use topgit, so I'm not sure what
> the usual initialization process, if any, is).

Hey Jeff, thanks for your response.

TopGit does come with these commands to do the setup for you, but
that does not ensure that a new contributor without any idea about
TopGit won't forget to run them.

The argument against tg-clone is mainly that I really do not want to
encapsulate/abstract functionality, but rather stay as close as
possible to pure Git, and never to mandate anyone to use anything
else.

> In the longer term, it might be nice if git was better at sharing
> third-party refs. The problem is that we don't know what the refs
> mean, so we don't know which ones are appropriate for sharing.
> Maybe we could do something like "refs/shared/topgit/*", and git
> by default would push and pull items under refs/shared?

This could be an interesting and viable approach.

> > Therefore I thought it would be sensible to store these data in
> > commit. When the data change, there will always be a new commit to
> > store these data, and we do *not* want to update the data in
> > previous commits. Finding the data then becomes backtracking the
> > branch history until a commit is found containing them.
>
> That seems to me like you are sticking information in a commit that is
> not actually about the commit, but about the ref that happens to point
> to the commit. What if I have two refs that point to the same commit,
> but with two different topgit bases?

I don't think this can happen, but the point is valid.

> What about years later, when that information isn't interesting
> anymore? You're still carrying the cruft inside your commit
> objects.
[=E2=80=A6]
> I'm still not 100% convinced you want per-commit storage, though,
> and not per-ref storage.

Yes, I do want per-ref storage. Your arguments against my orphan
parent pointer approach (which could later be a x-*-ref approach)
are valid.

It just seems to me that per-ref storage is a lot further away than
per-commit storage, and I'd really like to move forward with TopGit=E2=80=A6

Thank you,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"one should never trust a woman who tells her real age.
 if she tells that, she will tell anything."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJOOErFwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xANE
D/49V71zp3sTRB+u4F9KYju92tU7ui9xV/cbT3Muh5dggPvxUFXakCKoIQfNzrYc
s4akcFkSfaH8l6WuCbEslLOsvBL34H0dnPwGjdzJHxl2mkpXTn2VIuPnJhxgWDOO
gB4NhWjnO+g395CAIjxNHZ1UExPi69XmWgEWw6EpdVjASXsb+vRjHh23+kZKQwOT
cXpIOuRs4uaWSD9FjvGLgbmLNE6MdbmnP0qIuIBA2ZB253aNM4rjGKeiMBOCM+Pj
tLCztp7/Vzjy4p2PNSWJ1RVd95YM5H8lMGA8UXK3miEL5SWDFuCgdIoORD4s7VTd
Dwwhb7/k1rvTyda/ewAteEajb39QxFltDaZv51kODwIOJVnTlbK3priclPCcT5Ds
nQhEZikvgwJraQ9LTtfF+P7ucVWdDlptV+H9Py2Z0erbd/MSrn9vj+EujfselmzW
WxjGpPSEFKQSRu2wCYsfMkKxijxpqhyLRsW/Amj8kzzIXE/ilfi7eR1Fwhpx8x6j
kYHhSjs+1r6sQHsrOY0GkJvm8qpKl1vG9vkAar7xCOKHQA76mbnkh4W3xm35WuQD
QCk+9xl8t3jiymOEsJO8bTuw86FgDcbndY0x1PY3ZyAAndvtbZxpNTuwu0YMRZ3A
weROP2Zn/jEuPilrf++R4o8iSPQ0Hxf7AN+Oj7nLtQ7tvQ==
=IbnH
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
