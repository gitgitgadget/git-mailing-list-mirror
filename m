From: Matthias Beyer <mail@beyermatthias.de>
Subject: File extension conflict when working with git and latex
Date: Fri, 21 Mar 2014 17:13:24 +0100
Message-ID: <20140321161324.GC2965@fu.192.168.200.1>
Reply-To: Matthias Beyer <mail@beyermatthias.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 17:22:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR2Ci-00033D-R4
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 17:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761100AbaCUQVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 12:21:50 -0400
Received: from libra.uberspace.de ([95.143.172.171]:46380 "HELO
	libra.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760956AbaCUQVu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 12:21:50 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Mar 2014 12:21:49 EDT
Received: (qmail 29158 invoked from network); 21 Mar 2014 16:15:11 -0000
Received: from unknown (HELO localhost) (37.209.116.43)
  by libra.uberspace.de with SMTP; 21 Mar 2014 16:15:11 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244695>


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I struggled with a really nasty issue today (and yesterday):

I work on a semester project paper which is written in latex and
therefor version-controlled with git. We compile the document using
pdflatex, we automate the compiling with make.

pdflatex generates some temporary files, which are required if you
call it the second and third time (it is a top-down compiler, which
needs to be called several times). One of the file extensions is
".idx", which (kind of) conflicts with file extensions in .git/.

Unfortunetely, we wrote our `make clean` task recursively. I think you
can imagine what went wrong: The clean-task corrupted the repository,
as it removed .idx files from within .git/.

I lost work because of this ugly name collision.

My question now:

I know, I can fix this by fixing the clean task in my Makefile. But
maybe someone somewhere on this world doesn't know the git internals
as good as me (and, of course, my coworker). Is there _any chance
at all_ that this gets mentioned somewhere, so others don't fall into
this pit?

--=20
Mit freundlichen Gr=FC=DFen,
Kind regards,
Matthias Beyer

Proudly sent with mutt.
Happily signed with gnupg.

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLGUkAAoJEJi+S08gyg+UV+0QAJUOXkyyoQ9MyAl6ScCwi5Nr
WeeL/hT5JTJng75hBKwFbA3XgqPlJJ+U/+i6lA/5vikcMKDjFeCMjlB0EqqR4XE/
Q6Mh9OeMq0G7CBk4VkZ2qxANirLB/sbOamPyDIoYF37mQqRvnRM5DnEjr1b2wInD
u7sMidgohemJOmIk/PDTHRgQrpHi/1jSsLgcmlv4iDIHdgxElhUEGWqfLmhGcDcI
TcQqnAYvrs+5HDBFXzWkXDijZ9hddkOGJgi5SZaWCC6E9HJjhLBS2C5mRAgt36nj
zVnNjq5fAYP8sqvfmCzzhmVAoGRncc5XnILDpp69eSjA5HGegBey5J9yHr6I36a5
CUI2Cf/HiW+iLvFSQMCK+4KqZQdcCsg58eb15mOaVpriS2nXw28F+Qu8c87nMGHs
ywSLIRfp06e4pxFM/R6b6hg63u5IVGWJeaPc5jRsLykUuxdGk9QMEaPgIuy11hKl
Cfnfx6PeLqUXKIsXC/sHip60rpgTtzXBA7OKSUKL2rc7UreoA4qn9K3/7w5w0KqU
vM2X9WrTz2HIKWRhhiGlDDYxydxW1eLbRrcEm69rnnMKAHawPUcIfqwilun/1R/b
/MKIYQExmuHX9GK7oCMtZ9juLiJpRG0FPwo95KOP7Xn6Mac+vJ+/CmTy3KlloDT0
XUNeZYlPTCLz2VqpmRQr
=eFEn
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
