From: martin f krafft <madduck@madduck.net>
Subject: Storing additional information in commit headers
Date: Mon, 1 Aug 2011 20:20:15 +0200
Message-ID: <20110801182015.GA3100@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Cc: Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:20:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnx6P-0007Jw-C8
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556Ab1HASU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:20:29 -0400
Received: from seamus.madduck.net ([213.203.238.82]:53576 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab1HASU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:20:28 -0400
Received: from fishbowl.rw.madduck.net (70-204.79-83.cust.bluewin.ch [83.79.204.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id 98F5B407D24;
	Mon,  1 Aug 2011 20:20:17 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id A243D1FE00; Mon,  1 Aug 2011 20:20:15 +0200 (CEST)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178393>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

I've read =E2=80=94 with great interest =E2=80=94 the recent discussion on
generation numbers[0], mostly because Clemens Buchacher pointed me
to it as a warning not to mess with commit objects.

0. http://comments.gmane.org/gmane.comp.version-control.git/177146

My intent was to add an extra commit header to select commits as
a way to store extra information needed to automate the management
of interdependent branches and patch generation =C3=A0 la TopGit.

Having read the generation numbers debate, I am not sure that adding
additional commit headers is a bad idea per se. From what
I understand, the main pushback to Linus' idea was that people did
not feel it right to store redundant, calculateable information
permanently in commit objects, where they cannot be altered anymore,
despite the non-zero chance of there being an error. Instead, the
use of a cache was advocated. I do not want to take a side in this
debate with this mail of mine.

Instead, I am investigating ways in which I can store additional
information for a branch, and ideally in a way to make it
transparent and automatic for all users of a project's repo.

Hence, if I were to store additional information in the commit
object headers, this information would by design be correct,
immutable, and non-redundant. I am going to reply to my own mail
with some implementation details to feed the curious, with the hope
to keep this debate focused.

Are there any strong reasons against my use of commit headers for
specific, well-defined purposes in contained use-cases? E.g. are
there tools known to only copy "known" headers, which could
potentially break my assumptions?

Thanks,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"when a gentoo admin tells me that the KISS principle is good for
 'busy sysadmins', and that it's not an evolutionary step backwards,
 i wonder whether their tape is already running backwards."
=20
spamtraps: madduck.bogus@madduck.net

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJONu5bwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xLVm
D/9tEU9kLwI7Fal08++dIQqYeJ2fixyVamK6ko/44gObJo3P8Yv6KZ7SbiykB0j9
FXsxnMztNwf29t0WhnTsFjZu2FHiFtViA95AZfHsiDGsckKuEN9g/0tfaXBR1dlm
ujk72SpilvXQTzwcM1Zb/fqb7vMI2O8CZspifP5a+lM6RmrsH0/C7GPPg0hgxSM6
l7E/fh0HW6ZhDX3deUqe22rPMF9kjYQtjnzrj8DzCmXoJypM9Bang8mx5B45DkF/
hbAgLPhOOJk6koYnSNn4XWALy2Nmg1RC8Ezp5Fv7a/I573xBQ7LJhI8CpxnJEmJD
JCYJhosQV3g5K1PpDEYRvbts9wLvI/DKkw/MYvlxq0oOWmdI7RO4cPzGYAc8Xw1f
xI8rymkfKWWG9A7mgg9n0Szz/vKdnRb0pRZ/OXm9KA1xc/xfVnVpBO8EEy7vJUXo
gvmMQLQlLwIM7dxlvVH43VvFEL1GOr8SseHsHvRToz73QVKUAcvbm8UlKHvQ4xHj
c7X7ni0GmUj21MmHzFdKN24v+F+t1q8liVB595UQSm9IImxM31WpIFjqeoDpyB/F
ppgyTQcoE+Z1Oj5WcKybmyzAV0o9432L7nU6z6XmNdiToKKo2AIgQ5vNHCpqCdBN
VlQpLpAYThq230BzirEgyDocLVxbxl8JWvoXG24ioKTDaQ==
=DvIH
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
