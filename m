From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v4 2/6] t7403: modernize style
Date: Sun, 16 Jun 2013 15:18:14 +0100
Message-ID: <0bd17d5cf3c001d1271ba7d36299ea20881ca122.1371391740.git.john@keeping.me.uk>
References: <cover.1371391740.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 16:19:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoDnQ-0001Dn-Ch
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 16:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217Ab3FPOTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 10:19:04 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:37899 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3FPOTC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 10:19:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id C67AA6064CE;
	Sun, 16 Jun 2013 15:19:01 +0100 (BST)
X-Quarantine-ID: <EmruCgY1iZFU>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EmruCgY1iZFU; Sun, 16 Jun 2013 15:19:01 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id CD6D76064EC;
	Sun, 16 Jun 2013 15:19:00 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id BDEE5161E3B1;
	Sun, 16 Jun 2013 15:19:00 +0100 (BST)
X-Quarantine-ID: <Xrt1doI+pL1H>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xrt1doI+pL1H; Sun, 16 Jun 2013 15:19:00 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 6569D161E03F;
	Sun, 16 Jun 2013 15:18:48 +0100 (BST)
X-Mailer: git-send-email 1.8.3.779.g691e267
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
References: <cover.1371391740.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228010>

Change the indentation to use tabs consistently and start content on the
line after the paren opening a subshell.

Also don't put a space in ">file" and remove ":" from ": >file" to be
consistent with the majority of tests elsewhere.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t7403-submodule-sync.sh | 316 +++++++++++++++++++++++++++-------------------
 1 file changed, 183 insertions(+), 133 deletions(-)

diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 94e26c4..38f6cc4 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -11,216 +11,266 @@ These tests exercise the "git submodule sync" subcommand.
 . ./test-lib.sh
 
 test_expect_success setup '
-	echo file > file &&
+	echo file >file &&
 	git add file &&
 	test_tick &&
 	git commit -m upstream &&
 	git clone . super &&
 	git clone super submodule &&
-	(cd submodule &&
-	 git submodule add ../submodule sub-submodule &&
-	 test_tick &&
-	 git commit -m "sub-submodule"
+	(
+		cd submodule &&
+		git submodule add ../submodule sub-submodule &&
+		test_tick &&
+		git commit -m "sub-submodule"
 	) &&
-	(cd super &&
-	 git submodule add ../submodule submodule &&
-	 test_tick &&
-	 git commit -m "submodule"
+	(
+		cd super &&
+		git submodule add ../submodule submodule &&
+		test_tick &&
+		git commit -m "submodule"
 	) &&
 	git clone super super-clone &&
-	(cd super-clone && git submodule update --init --recursive) &&
+	(
+		cd super-clone &&
+		git submodule update --init --recursive
+	) &&
 	git clone super empty-clone &&
-	(cd empty-clone && git submodule init) &&
+	(
+		cd empty-clone &&
+		git submodule init
+	) &&
 	git clone super top-only-clone &&
 	git clone super relative-clone &&
-	(cd relative-clone && git submodule update --init --recursive) &&
+	(
+		cd relative-clone &&
+		git submodule update --init --recursive
+	) &&
 	git clone super recursive-clone &&
-	(cd recursive-clone && git submodule update --init --recursive)
+	(
+		cd recursive-clone &&
+		git submodule update --init --recursive
+	)
 '
 
 test_expect_success 'change submodule' '
-	(cd submodule &&
-	 echo second line >> file &&
-	 test_tick &&
-	 git commit -a -m "change submodule"
+	(
+		cd submodule &&
+		echo second line >>file &&
+		test_tick &&
+		git commit -a -m "change submodule"
 	)
 '
 
 test_expect_success 'change submodule url' '
-	(cd super &&
-	 cd submodule &&
-	 git checkout master &&
-	 git pull
+	(
+		cd super &&
+		cd submodule &&
+		git checkout master &&
+		git pull
 	) &&
 	mv submodule moved-submodule &&
-	(cd moved-submodule &&
-	 git config -f .gitmodules submodule.sub-submodule.url ../moved-submodule &&
-	 test_tick &&
-	 git commit -a -m moved-sub-submodule
+	(
+		cd moved-submodule &&
+		git config -f .gitmodules submodule.sub-submodule.url ../moved-submodule &&
+		test_tick &&
+		git commit -a -m moved-sub-submodule
 	) &&
-	(cd super &&
-	 git config -f .gitmodules submodule.submodule.url ../moved-submodule &&
-	 test_tick &&
-	 git commit -a -m moved-submodule
+	(
+		cd super &&
+		git config -f .gitmodules submodule.submodule.url ../moved-submodule &&
+		test_tick &&
+		git commit -a -m moved-submodule
 	)
 '
 
 test_expect_success '"git submodule sync" should update submodule URLs' '
-	(cd super-clone &&
-	 git pull --no-recurse-submodules &&
-	 git submodule sync
+	(
+		cd super-clone &&
+		git pull --no-recurse-submodules &&
+		git submodule sync
 	) &&
-	test -d "$(cd super-clone/submodule &&
-	 git config remote.origin.url
+	test -d "$(
+		cd super-clone/submodule &&
+		git config remote.origin.url
 	)" &&
-	test ! -d "$(cd super-clone/submodule/sub-submodule &&
-	 git config remote.origin.url
+	test ! -d "$(
+		cd super-clone/submodule/sub-submodule &&
+		git config remote.origin.url
 	)" &&
-	(cd super-clone/submodule &&
-	 git checkout master &&
-	 git pull
+	(
+		cd super-clone/submodule &&
+		git checkout master &&
+		git pull
 	) &&
-	(cd super-clone &&
-	 test -d "$(git config submodule.submodule.url)"
+	(
+		cd super-clone &&
+		test -d "$(git config submodule.submodule.url)"
 	)
 '
 
 test_expect_success '"git submodule sync --recursive" should update all submodule URLs' '
-	(cd super-clone &&
-	 (cd submodule &&
-	  git pull --no-recurse-submodules
-	 ) &&
-	 git submodule sync --recursive
+	(
+		cd super-clone &&
+		(
+			cd submodule &&
+			git pull --no-recurse-submodules
+		) &&
+		git submodule sync --recursive
 	) &&
-	test -d "$(cd super-clone/submodule &&
-	 git config remote.origin.url
+	test -d "$(
+		cd super-clone/submodule &&
+		git config remote.origin.url
 	)" &&
-	test -d "$(cd super-clone/submodule/sub-submodule &&
-	 git config remote.origin.url
+	test -d "$(
+		cd super-clone/submodule/sub-submodule &&
+		git config remote.origin.url
 	)" &&
-	(cd super-clone/submodule/sub-submodule &&
-	 git checkout master &&
-	 git pull
+	(
+		cd super-clone/submodule/sub-submodule &&
+		git checkout master &&
+		git pull
 	)
 '
 
 test_expect_success '"git submodule sync" should update known submodule URLs' '
-	(cd empty-clone &&
-	 git pull &&
-	 git submodule sync &&
-	 test -d "$(git config submodule.submodule.url)"
+	(
+		cd empty-clone &&
+		git pull &&
+		git submodule sync &&
+		test -d "$(git config submodule.submodule.url)"
 	)
 '
 
 test_expect_success '"git submodule sync" should not vivify uninteresting submodule' '
-	(cd top-only-clone &&
-	 git pull &&
-	 git submodule sync &&
-	 test -z "$(git config submodule.submodule.url)" &&
-	 git submodule sync submodule &&
-	 test -z "$(git config submodule.submodule.url)"
+	(
+		cd top-only-clone &&
+		git pull &&
+		git submodule sync &&
+		test -z "$(git config submodule.submodule.url)" &&
+		git submodule sync submodule &&
+		test -z "$(git config submodule.submodule.url)"
 	)
 '
 
 test_expect_success '"git submodule sync" handles origin URL of the form foo' '
-	(cd relative-clone &&
-	 git remote set-url origin foo &&
-	 git submodule sync &&
-	(cd submodule &&
-	 #actual fails with: "cannot strip off url foo
-	 test "$(git config remote.origin.url)" = "../submodule"
-	)
+	(
+		cd relative-clone &&
+		git remote set-url origin foo &&
+		git submodule sync &&
+		(
+			cd submodule &&
+			#actual fails with: "cannot strip off url foo
+			test "$(git config remote.origin.url)" = "../submodule"
+		)
 	)
 '
 
 test_expect_success '"git submodule sync" handles origin URL of the form foo/bar' '
-	(cd relative-clone &&
-	 git remote set-url origin foo/bar &&
-	 git submodule sync &&
-	(cd submodule &&
-	 #actual foo/submodule
-	 test "$(git config remote.origin.url)" = "../foo/submodule"
-	)
-	(cd submodule/sub-submodule &&
-	 test "$(git config remote.origin.url)" != "../../foo/submodule"
-	)
+	(
+		cd relative-clone &&
+		git remote set-url origin foo/bar &&
+		git submodule sync &&
+		(
+			cd submodule &&
+			#actual foo/submodule
+			test "$(git config remote.origin.url)" = "../foo/submodule"
+		)
+		(
+			cd submodule/sub-submodule &&
+			test "$(git config remote.origin.url)" != "../../foo/submodule"
+		)
 	)
 '
 
 test_expect_success '"git submodule sync --recursive" propagates changes in origin' '
-	(cd recursive-clone &&
-	 git remote set-url origin foo/bar &&
-	 git submodule sync --recursive &&
-	(cd submodule &&
-	 #actual foo/submodule
-	 test "$(git config remote.origin.url)" = "../foo/submodule"
-	)
-	(cd submodule/sub-submodule &&
-	 test "$(git config remote.origin.url)" = "../../foo/submodule"
-	)
+	(
+		cd recursive-clone &&
+		git remote set-url origin foo/bar &&
+		git submodule sync --recursive &&
+		(
+			cd submodule &&
+			#actual foo/submodule
+			test "$(git config remote.origin.url)" = "../foo/submodule"
+		)
+		(
+			cd submodule/sub-submodule &&
+			test "$(git config remote.origin.url)" = "../../foo/submodule"
+		)
 	)
 '
 
 test_expect_success '"git submodule sync" handles origin URL of the form ./foo' '
-	(cd relative-clone &&
-	 git remote set-url origin ./foo &&
-	 git submodule sync &&
-	(cd submodule &&
-	 #actual ./submodule
-	 test "$(git config remote.origin.url)" = "../submodule"
-	)
+	(
+		cd relative-clone &&
+		git remote set-url origin ./foo &&
+		git submodule sync &&
+		(
+			cd submodule &&
+			#actual ./submodule
+			test "$(git config remote.origin.url)" = "../submodule"
+		)
 	)
 '
 
 test_expect_success '"git submodule sync" handles origin URL of the form ./foo/bar' '
-	(cd relative-clone &&
-	 git remote set-url origin ./foo/bar &&
-	 git submodule sync &&
-	(cd submodule &&
-	 #actual ./foo/submodule
-	 test "$(git config remote.origin.url)" = "../foo/submodule"
-	)
+	(
+		cd relative-clone &&
+		git remote set-url origin ./foo/bar &&
+		git submodule sync &&
+		(
+			cd submodule &&
+			#actual ./foo/submodule
+			test "$(git config remote.origin.url)" = "../foo/submodule"
+		)
 	)
 '
 
 test_expect_success '"git submodule sync" handles origin URL of the form ../foo' '
-	(cd relative-clone &&
-	 git remote set-url origin ../foo &&
-	 git submodule sync &&
-	(cd submodule &&
-	 #actual ../submodule
-	 test "$(git config remote.origin.url)" = "../../submodule"
-	)
+	(
+		cd relative-clone &&
+		git remote set-url origin ../foo &&
+		git submodule sync &&
+		(
+			cd submodule &&
+			#actual ../submodule
+			test "$(git config remote.origin.url)" = "../../submodule"
+		)
 	)
 '
 
 test_expect_success '"git submodule sync" handles origin URL of the form ../foo/bar' '
-	(cd relative-clone &&
-	 git remote set-url origin ../foo/bar &&
-	 git submodule sync &&
-	(cd submodule &&
-	 #actual ../foo/submodule
-	 test "$(git config remote.origin.url)" = "../../foo/submodule"
-	)
+	(
+		cd relative-clone &&
+		git remote set-url origin ../foo/bar &&
+		git submodule sync &&
+		(
+			cd submodule &&
+			#actual ../foo/submodule
+			test "$(git config remote.origin.url)" = "../../foo/submodule"
+		)
 	)
 '
 
 test_expect_success '"git submodule sync" handles origin URL of the form ../foo/bar with deeply nested submodule' '
-	(cd relative-clone &&
-	 git remote set-url origin ../foo/bar &&
-	 mkdir -p a/b/c &&
-	 ( cd a/b/c &&
-	   git init &&
-	   :> .gitignore &&
-	   git add .gitignore &&
-	   test_tick &&
-	   git commit -m "initial commit" ) &&
-	 git submodule add ../bar/a/b/c ./a/b/c &&
-	 git submodule sync &&
-	(cd a/b/c &&
-	 #actual ../foo/bar/a/b/c
-	 test "$(git config remote.origin.url)" = "../../../../foo/bar/a/b/c"
-	)
+	(
+		cd relative-clone &&
+		git remote set-url origin ../foo/bar &&
+		mkdir -p a/b/c &&
+		(
+			cd a/b/c &&
+			git init &&
+			>.gitignore &&
+			git add .gitignore &&
+			test_tick &&
+			git commit -m "initial commit"
+		) &&
+		git submodule add ../bar/a/b/c ./a/b/c &&
+		git submodule sync &&
+		(
+			cd a/b/c &&
+			#actual ../foo/bar/a/b/c
+			test "$(git config remote.origin.url)" = "../../../../foo/bar/a/b/c"
+		)
 	)
 '
 
-- 
1.8.3.779.g691e267
