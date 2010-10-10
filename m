From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/5 v2] t7607: add leading-path tests
Date: Sun, 10 Oct 2010 10:38:58 +0200
Message-ID: <20101010083858.GB12186@localhost>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
 <1286632380-7002-3-git-send-email-drizzd@aon.at>
 <201010092114.51881.j6t@kdbg.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Oct 10 10:39:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4rQp-0007TZ-21
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 10:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab0JJIiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 04:38:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32958 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab0JJIix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 04:38:53 -0400
Received: by fxm4 with SMTP id 4so31600fxm.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=6GbYn1q4FGLMRmAxFOB9L4mcI46qin3mapaKYv0nNkA=;
        b=Xmuyef9EgOZvc89V/FtcMrZCsOrjuY/WeqTIbaov9GMGZNH56xIwFK8SsD1w62Piqj
         jtSHFYmuAI/EWeXDjir6Iy3n0VC3GjPgJ4QTIStA9Tik+2O0szsTFlpksR6k/qxvPnn+
         NxZVRo14lFQ7fB5jhD1R8hSWJ/QlWG8TQYF2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=mXN5K4hSO2uy7MwmmtYU8jwv0WBkWgC0ar4Atx/mRTowd3SOaam8glIU2BispFO8FG
         fY3Prbss0Y6OkMh6SUjxQE6xP0jdB/gc/OCwGZYp3w5NO8sBjf/aN864nQcDtGUUQA38
         uBdXCgeiWM63B8VO1SyYlxPP1TVvS4Sz8d9Us=
Received: by 10.223.107.77 with SMTP id a13mr1059584fap.96.1286699930035;
        Sun, 10 Oct 2010 01:38:50 -0700 (PDT)
Received: from darc.lan (p549A35A6.dip.t-dialin.net [84.154.53.166])
        by mx.google.com with ESMTPS id f28sm2549335faa.0.2010.10.10.01.38.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 01:38:49 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P4rQo-0003UK-NA; Sun, 10 Oct 2010 10:38:58 +0200
Content-Disposition: inline
In-Reply-To: <201010092114.51881.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158652>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

This patch depends on PATCH 1/5 v2. The remaining patches 3 to 5
still apply cleanly.

On Sat, Oct 09, 2010 at 09:14:51PM +0200, Johannes Sixt wrote:
> On Samstag, 9. Oktober 2010, Clemens Buchacher wrote:
> > +test_expect_failure 'will not overwrite untracked symlink in leading p=
ath'
>=20
> > +test_expect_success 'will not be confused by symlink in leading path' '
>=20
> Please guard these two with a SYMLINKS prerequisite.

Done. Thank you.

Clemens

 t/t7607-merge-overwrite.sh |   51 ++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index b8fab54..77fcaa2 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -12,6 +12,12 @@ test_expect_success 'setup' '
 	test_commit c1a c1.c "c1 a" &&
 	git reset --hard c0 &&
 	test_commit c2 c2.c &&
+	git reset --hard c0 &&
+	mkdir sub &&
+	echo "sub/f" > sub/f &&
+	git add sub/f &&
+	git commit -m sub &&
+	git tag sub &&
 	echo "VERY IMPORTANT CHANGES" > important
 '
=20
@@ -23,6 +29,14 @@ test_expect_success 'will not overwrite untracked file' '
 	test_cmp important c2.c
 '
=20
+test_expect_success 'will overwrite tracked file' '
+	git reset --hard c1 &&
+	cp important c2.c &&
+	git add c2.c &&
+	git commit -m important &&
+	git checkout c2
+'
+
 test_expect_success 'will not overwrite new file' '
 	git reset --hard c1 &&
 	cp important c2.c &&
@@ -76,4 +90,41 @@ test_expect_success 'will not overwrite removed file wit=
h staged changes' '
 	test_cmp important c1.c
 '
=20
+test_expect_success 'will not overwrite untracked subtree' '
+	git reset --hard c0 &&
+	rm -rf sub &&
+	mkdir -p sub/f &&
+	cp important sub/f/important &&
+	test_must_fail git merge sub &&
+	test_path_is_missing .git/MERGE_HEAD &&
+	test_cmp important sub/f/important
+'
+
+test_expect_failure 'will not overwrite untracked file in leading path' '
+	git reset --hard c0 &&
+	rm -rf sub &&
+	cp important sub &&
+	test_must_fail git merge sub &&
+	test_path_is_missing .git/MERGE_HEAD &&
+	test_cmp important sub
+'
+
+test_expect_failure SYMLINKS 'will not overwrite untracked symlink in lead=
ing path' '
+	git reset --hard c0 &&
+	rm -rf sub &&
+	mkdir sub2 &&
+	ln -s sub2 sub &&
+	test_must_fail git merge sub &&
+	test_path_is_missing .git/MERGE_HEAD
+'
+
+test_expect_success SYMLINKS 'will not be confused by symlink in leading p=
ath' '
+	git reset --hard c0 &&
+	rm -rf sub &&
+	ln -s sub2 sub &&
+	git add sub &&
+	git commit -m ln &&
+	git checkout sub
+'
+
 test_done
--=20
1.7.1.571.gba4d01


--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMsXuiAAoJELKdZexG8uqM6tgIAK07rpzMQbAc9wtyhcdPp8rt
6gMca3t/ydnz2JuXjCmOO/b0ES1XY2mCVyVGWn1p84KmReKaO92+Y/eOtaW4Aj43
sRp3hnXckMedKPcJbtiA5oDOORaY/rH9quWn8Df6Rfo+HeKJDlnb7K7JaZ2kYRbR
GF76Xfbk+HA8wa2xP1GxqshnR9FngGO2mm1E7mYy7jn5DV95mTribJIXdupZBeSV
o+0oxrUvoShzPc7Vvg0ATFNFbS7hxOku7Lc9/l3GZ/5LYCn2uu38cHEDIUmQsCQM
+KoemRdmucAfgN0FE9rBDge8MKZmDAtt7O3BBTiKfK38chcuskvTnV4AqFI1LiI=
=Aqri
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
