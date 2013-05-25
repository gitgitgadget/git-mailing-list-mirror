From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/48] remote-helpers: test: simplify remote URLs
Date: Fri, 24 May 2013 21:29:22 -0500
Message-ID: <1369449004-17981-7-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4HC-0001Wx-Pm
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549Ab3EYCcD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 May 2013 22:32:03 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:54003 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab3EYCcB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:01 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so6898280oag.20
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1UAK3NWt0RAKtW0iUvmnj5Lh1lu3CElxd4gR2u/LjAE=;
        b=adtu7JI06AZZ2AveAqjWVLoaARgnePROHZVmusHDTPxFVLIbKImRERUZ0rr11hfxNP
         X67jclbJ3asr1f2gybXmaObUZSbhaTxbtwqEwA0J/jPYzGpEgAnsKM4eWkvnU5+nEOtm
         ym6eae4cl+zmKkMHPSdEA5R4XE0BrU5cMvFTmyK5hegZqEnlmIJTeLAuBnS4HrWTjaZp
         RMEikfZC4F0IzRxvOaN91WbGxkA+XCDjI6vv4sGInKkWBcXbfv0L2T+LHMxT0MoSJh3e
         iXgP9R4O4nvAfjBgIuiZTI5182s58D0id+OFdW5dBYiV4zRRADTKVcPBsN6hB9pU0CI4
         kkNw==
X-Received: by 10.182.45.197 with SMTP id p5mr13125571obm.92.1369449120745;
        Fri, 24 May 2013 19:32:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ku7sm20075609obc.6.2013.05.24.19.31.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:31:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225420>

No need to specify $PWD any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh       | 12 ++++++------
 contrib/remote-helpers/test-hg-bidi.sh   |  6 +++---
 contrib/remote-helpers/test-hg-hg-git.sh |  6 +++---
 contrib/remote-helpers/test-hg.sh        | 14 +++++++-------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index 1ae7376..0276db0 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -41,7 +41,7 @@ test_expect_success 'cloning' '
 	bzr commit -m one
 	) &&
=20
-	git clone "bzr::$PWD/bzrrepo" gitrepo &&
+	git clone "bzr::bzrrepo" gitrepo &&
 	check gitrepo one master
 '
=20
@@ -216,7 +216,7 @@ test_expect_success 'fetch utf-8 filenames' '
 	) &&
=20
 	(
-	git clone "bzr::$PWD/bzrrepo" gitrepo &&
+	git clone "bzr::bzrrepo" gitrepo &&
 	cd gitrepo &&
 	git -c core.quotepath=3Dfalse ls-files > ../actual
 	) &&
@@ -242,7 +242,7 @@ test_expect_success 'push utf-8 filenames' '
 	) &&
=20
 	(
-	git clone "bzr::$PWD/bzrrepo" gitrepo &&
+	git clone "bzr::bzrrepo" gitrepo &&
 	cd gitrepo &&
=20
 	echo test >> "=C3=A6r=C3=B8" &&
@@ -268,7 +268,7 @@ test_expect_success 'pushing a merge' '
 	bzr commit -m one
 	) &&
=20
-	git clone "bzr::$PWD/bzrrepo" gitrepo &&
+	git clone "bzr::bzrrepo" gitrepo &&
=20
 	(
 	cd bzrrepo &&
@@ -319,7 +319,7 @@ test_expect_success 'proper bzr repo' '
 	) &&
=20
 	(
-	git clone "bzr::$PWD/bzrrepo" gitrepo &&
+	git clone "bzr::bzrrepo" gitrepo &&
 	cd gitrepo &&
 	git for-each-ref --format "%(refname:short)" refs/remotes/origin > ..=
/actual
 	) &&
@@ -342,7 +342,7 @@ test_expect_success 'strip' '
 	bzr commit -m two
 	) &&
=20
-	git clone "bzr::$PWD/bzrrepo" gitrepo &&
+	git clone "bzr::bzrrepo" gitrepo &&
=20
 	(
 	cd bzrrepo &&
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-he=
lpers/test-hg-bidi.sh
index 490a395..4bfbda2 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -22,7 +22,7 @@ fi
=20
 # clone to a git repo
 git_clone () {
-	git clone -q "hg::$PWD/$1" $2
+	git clone -q "hg::$1" $2
 }
=20
 # clone to an hg repo
@@ -31,7 +31,7 @@ hg_clone () {
 	hg init $2 &&
 	hg -R $2 bookmark -i master &&
 	cd $1 &&
-	git push -q "hg::$PWD/../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:=
refs/heads/*'
+	git push -q "hg::../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/=
heads/*'
 	) &&
=20
 	(cd $2 && hg -q update)
@@ -43,7 +43,7 @@ hg_push () {
 	cd $2
 	old=3D$(git symbolic-ref --short HEAD)
 	git checkout -q -b tmp &&
-	git fetch -q "hg::$PWD/../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*=
:refs/heads/*' &&
+	git fetch -q "hg::../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs=
/heads/*' &&
 	git checkout -q $old &&
 	git branch -q -D tmp 2> /dev/null || true
 	)
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-=
helpers/test-hg-hg-git.sh
index 6f0819c..274a8d5 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -27,7 +27,7 @@ fi
=20
 # clone to a git repo with git
 git_clone_git () {
-	git clone -q "hg::$PWD/$1" $2
+	git clone -q "hg::$1" $2
 }
=20
 # clone to an hg repo with git
@@ -36,7 +36,7 @@ hg_clone_git () {
 	hg init $2 &&
 	hg -R $2 bookmark -i master &&
 	cd $1 &&
-	git push -q "hg::$PWD/../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:=
refs/heads/*'
+	git push -q "hg::../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/=
heads/*'
 	) &&
=20
 	(cd $2 && hg -q update)
@@ -63,7 +63,7 @@ hg_push_git () {
 	cd $2
 	old=3D$(git symbolic-ref --short HEAD)
 	git checkout -q -b tmp &&
-	git fetch -q "hg::$PWD/../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*=
:refs/heads/*' &&
+	git fetch -q "hg::../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs=
/heads/*' &&
 	git checkout -q $old &&
 	git branch -q -D tmp 2> /dev/null || true
 	)
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers=
/test-hg.sh
index 043f6c6..4bd7584 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -53,7 +53,7 @@ test_expect_success 'cloning' '
 	hg commit -m zero
 	) &&
=20
-	git clone "hg::$PWD/hgrepo" gitrepo &&
+	git clone "hg::hgrepo" gitrepo &&
 	check gitrepo zero master
 '
=20
@@ -67,12 +67,12 @@ test_expect_success 'cloning with branches' '
 	hg commit -m next
 	) &&
=20
-	git clone "hg::$PWD/hgrepo" gitrepo &&
+	git clone "hg::hgrepo" gitrepo &&
 	check gitrepo next next &&
=20
 	(cd hgrepo && hg checkout default) &&
=20
-	git clone "hg::$PWD/hgrepo" gitrepo2 &&
+	git clone "hg::hgrepo" gitrepo2 &&
 	check gitrepo2 zero master
 '
=20
@@ -86,7 +86,7 @@ test_expect_success 'cloning with bookmarks' '
 	hg commit -m feature-a
 	) &&
=20
-	git clone "hg::$PWD/hgrepo" gitrepo &&
+	git clone "hg::hgrepo" gitrepo &&
 	check gitrepo feature-a feature-a
 '
=20
@@ -98,7 +98,7 @@ test_expect_success 'cloning with detached head' '
 	hg update -r 0
 	) &&
=20
-	git clone "hg::$PWD/hgrepo" gitrepo &&
+	git clone "hg::hgrepo" gitrepo &&
 	check gitrepo zero master
 '
=20
@@ -111,7 +111,7 @@ test_expect_success 'update bookmark' '
 	) &&
=20
 	(
-	git clone "hg::$PWD/hgrepo" gitrepo &&
+	git clone "hg::hgrepo" gitrepo &&
 	cd gitrepo &&
 	git checkout --quiet devel &&
 	echo devel > content &&
@@ -155,7 +155,7 @@ test_expect_success 'authors' '
 	author_test kappa "test@example.com" "Unknown <test@example.com>"
 	) &&
=20
-	git clone "hg::$PWD/hgrepo" gitrepo &&
+	git clone "hg::hgrepo" gitrepo &&
 	git --git-dir=3Dgitrepo/.git log --reverse --format=3D"%an <%ae>" > a=
ctual &&
=20
 	test_cmp expected actual
--=20
1.8.3.rc3.312.g47657de
