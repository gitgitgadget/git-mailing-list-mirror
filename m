From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3 2/3] t5516-fetch-push.sh: style cleanup
Date: Mon, 19 Apr 2010 18:08:31 -0400
Message-ID: <1271714912-56659-3-git-send-email-jaysoffian@gmail.com>
References: <1271714912-56659-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junio@kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 00:09:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3z9h-0005uP-2q
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 00:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab0DSWJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 18:09:14 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53241 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab0DSWJM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 18:09:12 -0400
Received: by mail-gw0-f46.google.com with SMTP id 19so429991gwj.19
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 15:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=3e1gFVnFXnEC6Yz77KOrBSyXsN2pIm3r7SVc+GUVdfc=;
        b=Nqf/+TV7rwu9ZKdL95vTKHeF2S7K2w/silJQhkHRvasQRygNZI//qaFRDVhGd1BEGT
         +e5gkMEO0r8rj2XRyGhg899AnRoPC0KcDEiHrz7m3EbIsBgYA03y7vjbgXqRg8zH1zCZ
         +ThYC945bP5fUgaN8qgYB2jDvRPBKX4EBjftw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WrdQiE/nT5sr8gzys9o6KGPi8dpwLDCvRpb+u0X3mZ6DmVbirmQfbxCAWp6BmuNb87
         lQclnBsUSPZNUXOeZvkjGdmxc2sVHWK5wmv7VJ+aLdxQUic625INnOgTH2PA260Lhl/y
         iJ16EKI56nkhjI4u+qwoAWbx6bESzAvWmNnxc=
Received: by 10.101.196.32 with SMTP id y32mr14785000anp.81.1271714946952;
        Mon, 19 Apr 2010 15:09:06 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id 30sm50193935anp.1.2010.04.19.15.09.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 15:09:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.436.g2b878
In-Reply-To: <1271714912-56659-1-git-send-email-jaysoffian@gmail.com>
In-Reply-To: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145336>

Cleanup t5516-fetch-push.sh to use prevailing test script style

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 t/t5516-fetch-push.sh |   69 ++++++++++++++++++++++++++++++++----------------
 1 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 0f04b2e..3148789 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -64,13 +64,13 @@ check_push_result () {
 
 test_expect_success setup '
 
-	: >path1 &&
+	>path1 &&
 	git add path1 &&
 	test_tick &&
 	git commit -a -m repo &&
 	the_first_commit=$(git show-ref -s --verify refs/heads/master) &&
 
-	: >path2 &&
+	>path2 &&
 	git add path2 &&
 	test_tick &&
 	git commit -a -m second &&
@@ -483,8 +483,10 @@ git config --remove-section remote.there
 test_expect_success 'push with dry-run' '
 
 	mk_test heads/master &&
-	(cd testrepo &&
-	 old_commit=$(git show-ref -s --verify refs/heads/master)) &&
+	(
+		cd testrepo &&
+		old_commit=$(git show-ref -s --verify refs/heads/master)
+	) &&
 	git push --dry-run testrepo &&
 	check_push_result $old_commit heads/master
 '
@@ -493,10 +495,13 @@ test_expect_success 'push updates local refs' '
 
 	mk_test heads/master &&
 	mk_child child &&
-	(cd child &&
+	(
+		cd child &&
 		git pull .. master &&
 		git push &&
-	test $(git rev-parse master) = $(git rev-parse remotes/origin/master))
+		test $(git rev-parse master) = \
+			$(git rev-parse remotes/origin/master)
+	)
 
 '
 
@@ -506,10 +511,13 @@ test_expect_success 'push updates up-to-date local refs' '
 	mk_child child1 &&
 	mk_child child2 &&
 	(cd child1 && git pull .. master && git push) &&
-	(cd child2 &&
+	(
+		cd child2 &&
 		git pull ../child1 master &&
 		git push &&
-	test $(git rev-parse master) = $(git rev-parse remotes/origin/master))
+		test $(git rev-parse master) = \
+			$(git rev-parse remotes/origin/master)
+	)
 
 '
 
@@ -517,9 +525,11 @@ test_expect_success 'push preserves up-to-date packed refs' '
 
 	mk_test heads/master &&
 	mk_child child &&
-	(cd child &&
+	(
+		cd child &&
 		git push &&
-	! test -f .git/refs/remotes/origin/master)
+		! test -f .git/refs/remotes/origin/master
+	)
 
 '
 
@@ -530,11 +540,13 @@ test_expect_success 'push does not update local refs on failure' '
 	mkdir testrepo/.git/hooks &&
 	echo exit 1 >testrepo/.git/hooks/pre-receive &&
 	chmod +x testrepo/.git/hooks/pre-receive &&
-	(cd child &&
+	(
+		cd child &&
 		git pull .. master
 		test_must_fail git push &&
 		test $(git rev-parse master) != \
-			$(git rev-parse remotes/origin/master))
+			$(git rev-parse remotes/origin/master)
+	)
 
 '
 
@@ -575,34 +587,41 @@ test_expect_success 'push --delete refuses src:dest refspecs' '
 
 test_expect_success 'warn on push to HEAD of non-bare repository' '
 	mk_test heads/master
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git checkout master &&
-		git config receive.denyCurrentBranch warn) &&
+		git config receive.denyCurrentBranch warn
+	) &&
 	git push testrepo master 2>stderr &&
 	grep "warning: updating the current branch" stderr
 '
 
 test_expect_success 'deny push to HEAD of non-bare repository' '
 	mk_test heads/master
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git checkout master &&
-		git config receive.denyCurrentBranch true) &&
+		git config receive.denyCurrentBranch true
+	) &&
 	test_must_fail git push testrepo master
 '
 
 test_expect_success 'allow push to HEAD of bare repository (bare)' '
 	mk_test heads/master
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git checkout master &&
 		git config receive.denyCurrentBranch true &&
-		git config core.bare true) &&
+		git config core.bare true
+	) &&
 	git push testrepo master 2>stderr &&
 	! grep "warning: updating the current branch" stderr
 '
 
 test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 	mk_test heads/master
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git checkout master &&
 		git config receive.denyCurrentBranch false
 	) &&
@@ -615,7 +634,8 @@ test_expect_success 'fetch with branches' '
 	git branch second $the_first_commit &&
 	git checkout second &&
 	echo ".." > testrepo/.git/branches/branch1 &&
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git fetch branch1 &&
 		r=$(git show-ref -s --verify refs/heads/branch1) &&
 		test "z$r" = "z$the_commit" &&
@@ -627,7 +647,8 @@ test_expect_success 'fetch with branches' '
 test_expect_success 'fetch with branches containing #' '
 	mk_empty &&
 	echo "..#second" > testrepo/.git/branches/branch2 &&
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git fetch branch2 &&
 		r=$(git show-ref -s --verify refs/heads/branch2) &&
 		test "z$r" = "z$the_first_commit" &&
@@ -641,7 +662,8 @@ test_expect_success 'push with branches' '
 	git checkout second &&
 	echo "testrepo" > .git/branches/branch1 &&
 	git push branch1 &&
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		r=$(git show-ref -s --verify refs/heads/master) &&
 		test "z$r" = "z$the_first_commit" &&
 		test 1 = $(git for-each-ref refs/heads | wc -l)
@@ -652,7 +674,8 @@ test_expect_success 'push with branches containing #' '
 	mk_empty &&
 	echo "testrepo#branch3" > .git/branches/branch2 &&
 	git push branch2 &&
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		r=$(git show-ref -s --verify refs/heads/branch3) &&
 		test "z$r" = "z$the_first_commit" &&
 		test 1 = $(git for-each-ref refs/heads | wc -l)
-- 
1.7.0.3.436.g2b878
