From: martin f krafft <madduck@madduck.net>
Subject: failing to send patches to the list
Date: Fri, 13 Jul 2007 11:30:50 +0200
Message-ID: <20070713093050.GA18001@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 11:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9HTn-0004XQ-IO
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 11:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934345AbXGMJaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 05:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763298AbXGMJaX
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 05:30:23 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:43718 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763283AbXGMJaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 05:30:22 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 6A52C895D6F
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 11:30:21 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06696-08 for <git@vger.kernel.org>;
	Fri, 13 Jul 2007 11:30:21 +0200 (CEST)
Received: from lapse.madduck.net (p549C364A.dip0.t-ipconnect.de [84.156.54.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id AD2AD895D6D
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 11:30:20 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 668084FD40; Fri, 13 Jul 2007 11:30:49 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52374>


--FkmkrVfFsRoUs1wW
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

attached you may find two patches, which I've previously sent to the
list with

  git format-patch -s --stdout | sendmail git@vger.kernel.org

Even though my mail server seems to have delivered them correctly:

  Jul 13 10:53:32 albatross postfix/smtp[29758]: C404D895D6F:
  to=3D<git@vger.kernel.org>,
  relay=3Dvger.kernel.org[209.132.176.167]:25, delay=3D2.2,
  delays=3D0.08/0.04/0.56/1.6, dsn=3D2.7.1, status=3Dsent (250 2.7.1 Looks
  like Linux source DIFF email.. BF:<H 5.0943e-06>; S932911AbXGMIxb)

they never made it onto the list.

What am I doing wrong?

Should I resubmit the patches or is this enough for now?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
all software projects are done by iterative prototyping.
some companies call their prototypes "releases", that's all.

--PEIAKu/WMn1b1Hv9
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-fall-back-to-mozilla-s-sha.h-if-openssl-sha.h-is-not.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 7b2bb44f78b8bc691bbc1445c6c333fdc281a788 Mon Sep 17 00:00:00 2001
=46rom: martin f. krafft <madduck@madduck.net>
Date: Fri, 13 Jul 2007 11:09:05 +0200
Subject: [PATCH] fall back to mozilla's sha.h if openssl/sha.h is not avail=
able

Uses $(CPP) to attempt to preprocess an include <openssl/sha.h> directive. =
If
that fails, NO_OPENSSL is defined, causing the Makefile to fall back to usi=
ng
mozilla's SHA implementation.

Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 Makefile |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index d7541b4..1676343 100644
--- a/Makefile
+++ b/Makefile
@@ -532,6 +532,12 @@ ifndef NO_CURL
 	endif
 endif
=20
+HAS_OPENSSL :=3D $(shell echo "\#include <openssl/sha.h>" \
+			| $(CPP) -o/dev/null - 2>/dev/null || echo no)
+ifeq "$(HAS_OPENSSL)" "no"
+	NO_OPENSSL =3D "openssl_sha.h_not_found"
+endif
+
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL =3D -lssl
 	ifdef OPENSSLDIR
--=20
1.5.3.rc1.7.gcae4


--PEIAKu/WMn1b1Hv9
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-Provide-stdlayout-option-for-git-svn-to-set-trunk.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 5f537c75774c5c0b45b74585ace4178738f251f0 Mon Sep 17 00:00:00 2001
=46rom: martin f. krafft <madduck@madduck.net>
Date: Fri, 13 Jul 2007 11:09:46 +0200
Subject: [PATCH] Provide --stdlayout option for git-svn to set trunk,tags,b=
ranches to defaults

The --stdlayout option to git-svn init initialises the default Subversion
values of trunk,tags,branches: -T trunk -b branches -t tags. If any of the
-T/-t/-b options are given in addition, they are given preference.

Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 Documentation/git-svn.txt |    6 +++++-
 git-svn.perl              |    8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 0a210e4..9e74b27 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -44,10 +44,14 @@ COMMANDS
 --tags=3D<tags_subdir>;;
 -b<branches_subdir>;;
 --branches=3D<branches_subdir>;;
+--stdlayout;;
 	These are optional command-line options for init.  Each of
 	these flags can point to a relative repository path
 	(--tags=3Dproject/tags') or a full url
-	(--tags=3Dhttps://foo.org/project/tags)
+	(--tags=3Dhttps://foo.org/project/tags). The option --stdlayout is
+	a shorthand way of setting trunk,tags,branches as the relative paths,
+	which is the Subversion default. If any of the other options are given
+	as well, they take precedence.
 --no-metadata;;
 	Set the 'noMetadata' option in the [svn-remote] config.
 --use-svm-props;;
diff --git a/git-svn.perl b/git-svn.perl
index b3dffcc..5b443ee 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -77,11 +77,12 @@ my %fc_opts =3D ( 'follow-parent|follow!' =3D> \$Git::S=
VN::_follow_parent,
 		   \$Git::SVN::_repack_flags,
 		%remote_opts );
=20
-my ($_trunk, $_tags, $_branches);
+my ($_trunk, $_tags, $_branches, $_stdlayout);
 my %icv;
 my %init_opts =3D ( 'template=3Ds' =3D> \$_template, 'shared:s' =3D> \$_sh=
ared,
                   'trunk|T=3Ds' =3D> \$_trunk, 'tags|t=3Ds' =3D> \$_tags,
                   'branches|b=3Ds' =3D> \$_branches, 'prefix=3Ds' =3D> \$_=
prefix,
+                  'stdlayout' =3D> \$_stdlayout,
                   'minimize-url|m' =3D> \$Git::SVN::_minimize_url,
 		  'no-metadata' =3D> sub { $icv{noMetadata} =3D 1 },
 		  'use-svm-props' =3D> sub { $icv{useSvmProps} =3D 1 },
@@ -296,6 +297,11 @@ sub cmd_clone {
 	    $url !~ m#^[a-z\+]+://#) {
 		$path =3D $url;
 	}
+        if (defined $_stdlayout) {
+          $_trunk =3D 'trunk' if (!defined $_trunk);
+          $_tags =3D 'tags' if (!defined $_tags);
+          $_branches =3D 'branches' if (!defined $_branches);
+        }
 	$path =3D basename($url) if !defined $path || !length $path;
 	cmd_init($url, $path);
 	Git::SVN::fetch_all($Git::SVN::default_repo_id);
--=20
1.5.3.rc1.7.gcae4


--PEIAKu/WMn1b1Hv9--

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGl0ZJIgvIgzMMSnURAgeqAKDjmOlpX5AO9ezBrEBpuEoEsK8PdgCfcJDm
2T6792hIBIH/OgXP/e+ERZ8=
=c6Rw
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
