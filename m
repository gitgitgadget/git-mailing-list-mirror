From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 1/7] i18n: mark init-db messages for translation
Date: Sun, 10 Apr 2011 19:34:02 +0000
Message-ID: <1302464048-21806-2-git-send-email-avarab@gmail.com>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 21:34:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90P2-00036n-Rk
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab1DJTeU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 15:34:20 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37883 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874Ab1DJTeS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 15:34:18 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1532438ewy.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Da3moaeAR6oa+VtghKuXLSo2Oqz03TQx23ReH1RtsHs=;
        b=asEkx5T7U+hHSh0CwAlsU0rYknwFoI+25DPYNpewyKAr3MlHKw7Wvys/P9yKTsLqB+
         KOHXUbXh7XjPhn0CyBKgDQPbW2gmw63dbxMseQqMdH3I0dWwR1aEn7E4Cl1CrAI6/Y1z
         toHFjdBO37JqjYpII+eCTSVXSuBAPkXE/JAs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VsXdtjkBxbNDs/ebsXga65CGpvz57m+zAg+KvP70Nw+ZVzX3TUyNd2YF5CUhId5HRj
         g1hsLuTZyHplLEYrRrNA8AmzRMxQmLxyxNbbJVFHo7rwGxfuo3mr59Ow/BKtAD0Gsm0j
         2i1lfhubhXbe096x4ed1ZjAj2eqFrzSm4wZMI=
Received: by 10.213.97.30 with SMTP id j30mr1912414ebn.20.1302464057930;
        Sun, 10 Apr 2011 12:34:17 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id m55sm1147236eei.8.2011.04.10.12.34.16
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:34:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171279>

Mark the init-db messages that were added in v1.7.5-rc1~16^2 (init,
clone: support --separate-git-dir for .git file) by Nguy=E1=BB=85n Th=C3=
=A1i Ng=E1=BB=8Dc
Duy for translation.

This requires splitting up the tests that the patch added so that
certain parts of them can be skipped unless the C_LOCALE_OUTPUT
prerequisite is satisfied.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/init-db.c |   12 ++++++------
 t/t0001-init.sh   |   28 ++++++++++++++++++++--------
 t/t5601-clone.sh  |    7 +++++--
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index b7370d9..6d0a856 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -319,10 +319,10 @@ int set_git_dir_init(const char *git_dir, const c=
har *real_git_dir,
 		struct stat st;
=20
 		if (!exist_ok && !stat(git_dir, &st))
-			die("%s already exists", git_dir);
+			die(_("%s already exists"), git_dir);
=20
 		if (!exist_ok && !stat(real_git_dir, &st))
-			die("%s already exists", real_git_dir);
+			die(_("%s already exists"), real_git_dir);
=20
 		/*
 		 * make sure symlinks are resolved because we'll be
@@ -351,16 +351,16 @@ static void separate_git_dir(const char *git_dir)
 		else if (S_ISDIR(st.st_mode))
 			src =3D git_link;
 		else
-			die("unable to handle file type %d", st.st_mode);
+			die(_("unable to handle file type %d"), st.st_mode);
=20
 		if (rename(src, git_dir))
-			die_errno("unable to move %s to %s", src, git_dir);
+			die_errno(_("unable to move %s to %s"), src, git_dir);
 	}
=20
 	fp =3D fopen(git_link, "w");
 	if (!fp)
-		die("Could not create git link %s", git_link);
-	fprintf(fp, "gitdir: %s\n", git_dir);
+		die(_("Could not create git link %s"), git_link);
+	fprintf(fp, _("gitdir: %s\n"), git_dir);
 	fclose(fp);
 }
=20
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index a5816d0..fa31cbd 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -374,22 +374,28 @@ test_expect_success 'init prefers command line to=
 GIT_DIR' '
 test_expect_success 'init with separate gitdir' '
 	rm -rf newdir &&
 	git init --separate-git-dir realgitdir newdir &&
-	echo "gitdir: `pwd`/realgitdir" >expected &&
-	test_cmp expected newdir/.git &&
 	test -d realgitdir/refs
 '
=20
+test_expect_success C_LOCALE_OUTPUT 'init with separate gitdir: output=
' '
+	echo "gitdir: `pwd`/realgitdir" >expected &&
+	test_cmp expected newdir/.git
+'
+
 test_expect_success 're-init to update git link' '
 	(
 	cd newdir &&
 	git init --separate-git-dir ../surrealgitdir
 	) &&
-	echo "gitdir: `pwd`/surrealgitdir" >expected &&
-	test_cmp expected newdir/.git &&
 	test -d surrealgitdir/refs &&
 	! test -d realgitdir/refs
 '
=20
+test_expect_success C_LOCALE_OUTPUT 're-init to update git link: outpu=
t' '
+	echo "gitdir: `pwd`/surrealgitdir" >expected &&
+	test_cmp expected newdir/.git
+'
+
 test_expect_success 're-init to move gitdir' '
 	rm -rf newdir realgitdir surrealgitdir &&
 	git init newdir &&
@@ -397,11 +403,14 @@ test_expect_success 're-init to move gitdir' '
 	cd newdir &&
 	git init --separate-git-dir ../realgitdir
 	) &&
-	echo "gitdir: `pwd`/realgitdir" >expected &&
-	test_cmp expected newdir/.git &&
 	test -d realgitdir/refs
 '
=20
+test_expect_success C_LOCALE_OUTPUT 're-init to move gitdir: output' '
+	echo "gitdir: `pwd`/realgitdir" >expected &&
+	test_cmp expected newdir/.git
+'
+
 test_expect_success 're-init to move gitdir symlink' '
 	rm -rf newdir realgitdir &&
 	git init newdir &&
@@ -411,10 +420,13 @@ test_expect_success 're-init to move gitdir symli=
nk' '
 	ln -s here .git &&
 	git init -L ../realgitdir
 	) &&
-	echo "gitdir: `pwd`/realgitdir" >expected &&
-	test_cmp expected newdir/.git &&
 	test -d realgitdir/refs &&
 	! test -d newdir/here
 '
=20
+test_expect_success C_LOCALE_OUTPUT 're-init to move gitdir symlink: o=
utput' '
+	echo "gitdir: `pwd`/realgitdir" >expected &&
+	test_cmp expected newdir/.git
+'
+
 test_done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 5a068b2..a50e36e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -194,11 +194,14 @@ test_expect_success 'do not respect url-encoding =
of non-url path' '
 test_expect_success 'clone separate gitdir' '
 	rm -rf dst &&
 	git clone --separate-git-dir realgitdir src dst &&
-	echo "gitdir: `pwd`/realgitdir" >expected &&
-	test_cmp expected dst/.git &&
 	test -d realgitdir/refs
 '
=20
+test_expect_success C_LOCALE_OUTPUT 'clone separate gitdir: output' '
+	echo "gitdir: `pwd`/realgitdir" >expected &&
+	test_cmp expected dst/.git
+'
+
 test_expect_success 'clone separate gitdir where target already exists=
' '
 	rm -rf dst &&
 	test_must_fail git clone --separate-git-dir realgitdir src dst
--=20
1.7.4.1
