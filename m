From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/5] remote-helpers: rename tests
Date: Sat, 12 Oct 2013 02:04:23 -0500
Message-ID: <1381561465-20147-4-git-send-email-felipe.contreras@gmail.com>
References: <1381561465-20147-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:10:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtLV-0003hL-UV
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab3JLHKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Oct 2013 03:10:37 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:50258 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab3JLHKf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:10:35 -0400
Received: by mail-oa0-f43.google.com with SMTP id i3so3162529oag.30
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ItNhGtvrvEXfm2/Yi7rK180gpziVvYxs2jXq6dZtWNE=;
        b=R7GvtTJPZOBwGO3PL3Mqzq5EBPk3eoAPX1sxQDJ5EsaiwEmKICIUcd6teZY6i4KjAT
         lqQMm4TuInOdKLX5wDbG+KxXIJxlp05XFLKSp0ofcMJDJZHX2SszNYaw1IwphrgwHjbV
         8Ad7EZQ+1difKgwH+ZbR2n0vbs5Eyb7zGMf7cWGui/vsOb27eSI4pKxVUofReXnZiqmc
         c3eCYo2IogTLxLXP9KnpvYJGEaqCSXnlMgBZh+qAvihnyoyUz9DxyT80mJikuu7JXjXF
         yMwM6CwptApvHyP0ruC1BX9A6T6XIlKZIAFCiPeIxwgPMCHvUPxJFw0ZKqSeTSgRunoK
         K1Dw==
X-Received: by 10.60.60.5 with SMTP id d5mr17958516oer.0.1381561834569;
        Sat, 12 Oct 2013 00:10:34 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm28629758obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:10:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561465-20147-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235960>

The .t extension is more standard for sharness tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/Makefile          |   2 +-
 contrib/remote-helpers/test-bzr.sh       | 361 ----------------
 contrib/remote-helpers/test-bzr.t        | 361 ++++++++++++++++
 contrib/remote-helpers/test-hg-bidi.sh   | 240 -----------
 contrib/remote-helpers/test-hg-bidi.t    | 240 +++++++++++
 contrib/remote-helpers/test-hg-hg-git.sh | 527 -----------------------
 contrib/remote-helpers/test-hg-hg-git.t  | 527 +++++++++++++++++++++++
 contrib/remote-helpers/test-hg.sh        | 692 -----------------------=
--------
 contrib/remote-helpers/test-hg.t         | 692 +++++++++++++++++++++++=
++++++++
 9 files changed, 1821 insertions(+), 1821 deletions(-)
 delete mode 100755 contrib/remote-helpers/test-bzr.sh
 create mode 100755 contrib/remote-helpers/test-bzr.t
 delete mode 100755 contrib/remote-helpers/test-hg-bidi.sh
 create mode 100755 contrib/remote-helpers/test-hg-bidi.t
 delete mode 100755 contrib/remote-helpers/test-hg-hg-git.sh
 create mode 100755 contrib/remote-helpers/test-hg-hg-git.t
 delete mode 100755 contrib/remote-helpers/test-hg.sh
 create mode 100755 contrib/remote-helpers/test-hg.t

diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/M=
akefile
index 973c578..8d5e9be 100644
--- a/contrib/remote-helpers/Makefile
+++ b/contrib/remote-helpers/Makefile
@@ -1,4 +1,4 @@
-TESTS :=3D $(wildcard test*.sh)
+TESTS :=3D $(wildcard test-*.t)
 SCRIPTS :=3D $(wildcard git-remote-*.py)
=20
 export T :=3D $(addprefix $(CURDIR)/,$(TESTS))
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
deleted file mode 100755
index 435b280..0000000
--- a/contrib/remote-helpers/test-bzr.sh
+++ /dev/null
@@ -1,361 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2012 Felipe Contreras
-#
-
-test_description=3D'Test remote-bzr'
-
-. ./test-lib.sh
-
-if ! test_have_prereq PYTHON; then
-	skip_all=3D'skipping remote-bzr tests; python not available'
-	test_done
-fi
-
-if ! "$PYTHON_PATH" -c 'import bzrlib'; then
-	skip_all=3D'skipping remote-bzr tests; bzr not available'
-	test_done
-fi
-
-check () {
-	echo $3 > expected &&
-	git --git-dir=3D$1/.git log --format=3D'%s' -1 $2 > actual
-	test_cmp expected actual
-}
-
-bzr whoami "A U Thor <author@example.com>"
-
-test_expect_success 'cloning' '
-	(
-	bzr init bzrrepo &&
-	cd bzrrepo &&
-	echo one > content &&
-	bzr add content &&
-	bzr commit -m one
-	) &&
-
-	git clone "bzr::bzrrepo" gitrepo &&
-	check gitrepo HEAD one
-'
-
-test_expect_success 'pulling' '
-	(
-	cd bzrrepo &&
-	echo two > content &&
-	bzr commit -m two
-	) &&
-
-	(cd gitrepo && git pull) &&
-
-	check gitrepo HEAD two
-'
-
-test_expect_success 'pushing' '
-	(
-	cd gitrepo &&
-	echo three > content &&
-	git commit -a -m three &&
-	git push
-	) &&
-
-	echo three > expected &&
-	cat bzrrepo/content > actual &&
-	test_cmp expected actual
-'
-
-test_expect_success 'roundtrip' '
-	(
-	cd gitrepo &&
-	git pull &&
-	git log --format=3D"%s" -1 origin/master > actual
-	) &&
-	echo three > expected &&
-	test_cmp expected actual &&
-
-	(cd gitrepo && git push && git pull) &&
-
-	(
-	cd bzrrepo &&
-	echo four > content &&
-	bzr commit -m four
-	) &&
-
-	(cd gitrepo && git pull && git push) &&
-
-	check gitrepo HEAD four &&
-
-	(
-	cd gitrepo &&
-	echo five > content &&
-	git commit -a -m five &&
-	git push && git pull
-	) &&
-
-	(cd bzrrepo && bzr revert) &&
-
-	echo five > expected &&
-	cat bzrrepo/content > actual &&
-	test_cmp expected actual
-'
-
-cat > expected <<EOF
-100644 blob 54f9d6da5c91d556e6b54340b1327573073030af	content
-100755 blob 68769579c3eaadbe555379b9c3538e6628bae1eb	executable
-120000 blob 6b584e8ece562ebffc15d38808cd6b98fc3d97ea	link
-EOF
-
-test_expect_success 'special modes' '
-	(
-	cd bzrrepo &&
-	echo exec > executable
-	chmod +x executable &&
-	bzr add executable
-	bzr commit -m exec &&
-	ln -s content link
-	bzr add link
-	bzr commit -m link &&
-	mkdir dir &&
-	bzr add dir &&
-	bzr commit -m dir
-	) &&
-
-	(
-	cd gitrepo &&
-	git pull
-	git ls-tree HEAD > ../actual
-	) &&
-
-	test_cmp expected actual &&
-
-	(
-	cd gitrepo &&
-	git cat-file -p HEAD:link > ../actual
-	) &&
-
-	printf content > expected &&
-	test_cmp expected actual
-'
-
-cat > expected <<EOF
-100644 blob 54f9d6da5c91d556e6b54340b1327573073030af	content
-100755 blob 68769579c3eaadbe555379b9c3538e6628bae1eb	executable
-120000 blob 6b584e8ece562ebffc15d38808cd6b98fc3d97ea	link
-040000 tree 35c0caa46693cef62247ac89a680f0c5ce32b37b	movedir-new
-EOF
-
-test_expect_success 'moving directory' '
-	(
-	cd bzrrepo &&
-	mkdir movedir &&
-	echo one > movedir/one &&
-	echo two > movedir/two &&
-	bzr add movedir &&
-	bzr commit -m movedir &&
-	bzr mv movedir movedir-new &&
-	bzr commit -m movedir-new
-	) &&
-
-	(
-	cd gitrepo &&
-	git pull &&
-	git ls-tree HEAD > ../actual
-	) &&
-
-	test_cmp expected actual
-'
-
-test_expect_success 'different authors' '
-	(
-	cd bzrrepo &&
-	echo john >> content &&
-	bzr commit -m john \
-	  --author "Jane Rey <jrey@example.com>" \
-	  --author "John Doe <jdoe@example.com>"
-	) &&
-
-	(
-	cd gitrepo &&
-	git pull &&
-	git show --format=3D"%an <%ae>, %cn <%ce>" --quiet > ../actual
-	) &&
-
-	echo "Jane Rey <jrey@example.com>, A U Thor <author@example.com>" > e=
xpected &&
-	test_cmp expected actual
-'
-
-# cleanup previous stuff
-rm -rf bzrrepo gitrepo
-
-test_expect_success 'fetch utf-8 filenames' '
-	test_when_finished "rm -rf bzrrepo gitrepo && LC_ALL=3DC" &&
-
-	LC_ALL=3Den_US.UTF-8
-	export LC_ALL
-
-	(
-	bzr init bzrrepo &&
-	cd bzrrepo &&
-
-	echo test >> "=C3=A6r=C3=B8" &&
-	bzr add "=C3=A6r=C3=B8" &&
-	echo test >> "=C3=B8~?" &&
-	bzr add "=C3=B8~?" &&
-	bzr commit -m add-utf-8 &&
-	echo test >> "=C3=A6r=C3=B8" &&
-	bzr commit -m test-utf-8 &&
-	bzr rm "=C3=B8~?" &&
-	bzr mv "=C3=A6r=C3=B8" "=C3=B8~?" &&
-	bzr commit -m bzr-mv-utf-8
-	) &&
-
-	(
-	git clone "bzr::bzrrepo" gitrepo &&
-	cd gitrepo &&
-	git -c core.quotepath=3Dfalse ls-files > ../actual
-	) &&
-	echo "=C3=B8~?" > expected &&
-	test_cmp expected actual
-'
-
-test_expect_success 'push utf-8 filenames' '
-	test_when_finished "rm -rf bzrrepo gitrepo && LC_ALL=3DC" &&
-
-	mkdir -p tmp && cd tmp &&
-
-	LC_ALL=3Den_US.UTF-8
-	export LC_ALL
-
-	(
-	bzr init bzrrepo &&
-	cd bzrrepo &&
-
-	echo one >> content &&
-	bzr add content &&
-	bzr commit -m one
-	) &&
-
-	(
-	git clone "bzr::bzrrepo" gitrepo &&
-	cd gitrepo &&
-
-	echo test >> "=C3=A6r=C3=B8" &&
-	git add "=C3=A6r=C3=B8" &&
-	git commit -m utf-8 &&
-
-	git push
-	) &&
-
-	(cd bzrrepo && bzr ls > ../actual) &&
-	printf "content\n=C3=A6r=C3=B8\n" > expected &&
-	test_cmp expected actual
-'
-
-test_expect_success 'pushing a merge' '
-	test_when_finished "rm -rf bzrrepo gitrepo" &&
-
-	(
-	bzr init bzrrepo &&
-	cd bzrrepo &&
-	echo one > content &&
-	bzr add content &&
-	bzr commit -m one
-	) &&
-
-	git clone "bzr::bzrrepo" gitrepo &&
-
-	(
-	cd bzrrepo &&
-	echo two > content &&
-	bzr commit -m two
-	) &&
-
-	(
-	cd gitrepo &&
-	echo three > content &&
-	git commit -a -m three &&
-	git fetch &&
-	git merge origin/master || true &&
-	echo three > content &&
-	git commit -a --no-edit &&
-	git push
-	) &&
-
-	echo three > expected &&
-	cat bzrrepo/content > actual &&
-	test_cmp expected actual
-'
-
-cat > expected <<EOF
-origin/HEAD
-origin/branch
-origin/trunk
-EOF
-
-test_expect_success 'proper bzr repo' '
-	test_when_finished "rm -rf bzrrepo gitrepo" &&
-
-	bzr init-repo bzrrepo &&
-
-	(
-	bzr init bzrrepo/trunk &&
-	cd bzrrepo/trunk &&
-	echo one >> content &&
-	bzr add content &&
-	bzr commit -m one
-	) &&
-
-	(
-	bzr branch bzrrepo/trunk bzrrepo/branch &&
-	cd bzrrepo/branch &&
-	echo two >> content &&
-	bzr commit -m one
-	) &&
-
-	(
-	git clone "bzr::bzrrepo" gitrepo &&
-	cd gitrepo &&
-	git for-each-ref --format "%(refname:short)" refs/remotes/origin > ..=
/actual
-	) &&
-
-	test_cmp expected actual
-'
-
-test_expect_success 'strip' '
-	test_when_finished "rm -rf bzrrepo gitrepo" &&
-
-	(
-	bzr init bzrrepo &&
-	cd bzrrepo &&
-
-	echo one >> content &&
-	bzr add content &&
-	bzr commit -m one &&
-
-	echo two >> content &&
-	bzr commit -m two
-	) &&
-
-	git clone "bzr::bzrrepo" gitrepo &&
-
-	(
-	cd bzrrepo &&
-	bzr uncommit --force &&
-
-	echo three >> content &&
-	bzr commit -m three &&
-
-	echo four >> content &&
-	bzr commit -m four &&
-	bzr log --line | sed -e "s/^[0-9][0-9]*: //" > ../expected
-	) &&
-
-	(
-	cd gitrepo &&
-	git fetch &&
-	git log --format=3D"%an %ad %s" --date=3Dshort origin/master > ../act=
ual
-	) &&
-
-	test_cmp expected actual
-'
-
-test_done
diff --git a/contrib/remote-helpers/test-bzr.t b/contrib/remote-helpers=
/test-bzr.t
new file mode 100755
index 0000000..435b280
--- /dev/null
+++ b/contrib/remote-helpers/test-bzr.t
@@ -0,0 +1,361 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+
+test_description=3D'Test remote-bzr'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	skip_all=3D'skipping remote-bzr tests; python not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import bzrlib'; then
+	skip_all=3D'skipping remote-bzr tests; bzr not available'
+	test_done
+fi
+
+check () {
+	echo $3 > expected &&
+	git --git-dir=3D$1/.git log --format=3D'%s' -1 $2 > actual
+	test_cmp expected actual
+}
+
+bzr whoami "A U Thor <author@example.com>"
+
+test_expect_success 'cloning' '
+	(
+	bzr init bzrrepo &&
+	cd bzrrepo &&
+	echo one > content &&
+	bzr add content &&
+	bzr commit -m one
+	) &&
+
+	git clone "bzr::bzrrepo" gitrepo &&
+	check gitrepo HEAD one
+'
+
+test_expect_success 'pulling' '
+	(
+	cd bzrrepo &&
+	echo two > content &&
+	bzr commit -m two
+	) &&
+
+	(cd gitrepo && git pull) &&
+
+	check gitrepo HEAD two
+'
+
+test_expect_success 'pushing' '
+	(
+	cd gitrepo &&
+	echo three > content &&
+	git commit -a -m three &&
+	git push
+	) &&
+
+	echo three > expected &&
+	cat bzrrepo/content > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'roundtrip' '
+	(
+	cd gitrepo &&
+	git pull &&
+	git log --format=3D"%s" -1 origin/master > actual
+	) &&
+	echo three > expected &&
+	test_cmp expected actual &&
+
+	(cd gitrepo && git push && git pull) &&
+
+	(
+	cd bzrrepo &&
+	echo four > content &&
+	bzr commit -m four
+	) &&
+
+	(cd gitrepo && git pull && git push) &&
+
+	check gitrepo HEAD four &&
+
+	(
+	cd gitrepo &&
+	echo five > content &&
+	git commit -a -m five &&
+	git push && git pull
+	) &&
+
+	(cd bzrrepo && bzr revert) &&
+
+	echo five > expected &&
+	cat bzrrepo/content > actual &&
+	test_cmp expected actual
+'
+
+cat > expected <<EOF
+100644 blob 54f9d6da5c91d556e6b54340b1327573073030af	content
+100755 blob 68769579c3eaadbe555379b9c3538e6628bae1eb	executable
+120000 blob 6b584e8ece562ebffc15d38808cd6b98fc3d97ea	link
+EOF
+
+test_expect_success 'special modes' '
+	(
+	cd bzrrepo &&
+	echo exec > executable
+	chmod +x executable &&
+	bzr add executable
+	bzr commit -m exec &&
+	ln -s content link
+	bzr add link
+	bzr commit -m link &&
+	mkdir dir &&
+	bzr add dir &&
+	bzr commit -m dir
+	) &&
+
+	(
+	cd gitrepo &&
+	git pull
+	git ls-tree HEAD > ../actual
+	) &&
+
+	test_cmp expected actual &&
+
+	(
+	cd gitrepo &&
+	git cat-file -p HEAD:link > ../actual
+	) &&
+
+	printf content > expected &&
+	test_cmp expected actual
+'
+
+cat > expected <<EOF
+100644 blob 54f9d6da5c91d556e6b54340b1327573073030af	content
+100755 blob 68769579c3eaadbe555379b9c3538e6628bae1eb	executable
+120000 blob 6b584e8ece562ebffc15d38808cd6b98fc3d97ea	link
+040000 tree 35c0caa46693cef62247ac89a680f0c5ce32b37b	movedir-new
+EOF
+
+test_expect_success 'moving directory' '
+	(
+	cd bzrrepo &&
+	mkdir movedir &&
+	echo one > movedir/one &&
+	echo two > movedir/two &&
+	bzr add movedir &&
+	bzr commit -m movedir &&
+	bzr mv movedir movedir-new &&
+	bzr commit -m movedir-new
+	) &&
+
+	(
+	cd gitrepo &&
+	git pull &&
+	git ls-tree HEAD > ../actual
+	) &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'different authors' '
+	(
+	cd bzrrepo &&
+	echo john >> content &&
+	bzr commit -m john \
+	  --author "Jane Rey <jrey@example.com>" \
+	  --author "John Doe <jdoe@example.com>"
+	) &&
+
+	(
+	cd gitrepo &&
+	git pull &&
+	git show --format=3D"%an <%ae>, %cn <%ce>" --quiet > ../actual
+	) &&
+
+	echo "Jane Rey <jrey@example.com>, A U Thor <author@example.com>" > e=
xpected &&
+	test_cmp expected actual
+'
+
+# cleanup previous stuff
+rm -rf bzrrepo gitrepo
+
+test_expect_success 'fetch utf-8 filenames' '
+	test_when_finished "rm -rf bzrrepo gitrepo && LC_ALL=3DC" &&
+
+	LC_ALL=3Den_US.UTF-8
+	export LC_ALL
+
+	(
+	bzr init bzrrepo &&
+	cd bzrrepo &&
+
+	echo test >> "=C3=A6r=C3=B8" &&
+	bzr add "=C3=A6r=C3=B8" &&
+	echo test >> "=C3=B8~?" &&
+	bzr add "=C3=B8~?" &&
+	bzr commit -m add-utf-8 &&
+	echo test >> "=C3=A6r=C3=B8" &&
+	bzr commit -m test-utf-8 &&
+	bzr rm "=C3=B8~?" &&
+	bzr mv "=C3=A6r=C3=B8" "=C3=B8~?" &&
+	bzr commit -m bzr-mv-utf-8
+	) &&
+
+	(
+	git clone "bzr::bzrrepo" gitrepo &&
+	cd gitrepo &&
+	git -c core.quotepath=3Dfalse ls-files > ../actual
+	) &&
+	echo "=C3=B8~?" > expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'push utf-8 filenames' '
+	test_when_finished "rm -rf bzrrepo gitrepo && LC_ALL=3DC" &&
+
+	mkdir -p tmp && cd tmp &&
+
+	LC_ALL=3Den_US.UTF-8
+	export LC_ALL
+
+	(
+	bzr init bzrrepo &&
+	cd bzrrepo &&
+
+	echo one >> content &&
+	bzr add content &&
+	bzr commit -m one
+	) &&
+
+	(
+	git clone "bzr::bzrrepo" gitrepo &&
+	cd gitrepo &&
+
+	echo test >> "=C3=A6r=C3=B8" &&
+	git add "=C3=A6r=C3=B8" &&
+	git commit -m utf-8 &&
+
+	git push
+	) &&
+
+	(cd bzrrepo && bzr ls > ../actual) &&
+	printf "content\n=C3=A6r=C3=B8\n" > expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'pushing a merge' '
+	test_when_finished "rm -rf bzrrepo gitrepo" &&
+
+	(
+	bzr init bzrrepo &&
+	cd bzrrepo &&
+	echo one > content &&
+	bzr add content &&
+	bzr commit -m one
+	) &&
+
+	git clone "bzr::bzrrepo" gitrepo &&
+
+	(
+	cd bzrrepo &&
+	echo two > content &&
+	bzr commit -m two
+	) &&
+
+	(
+	cd gitrepo &&
+	echo three > content &&
+	git commit -a -m three &&
+	git fetch &&
+	git merge origin/master || true &&
+	echo three > content &&
+	git commit -a --no-edit &&
+	git push
+	) &&
+
+	echo three > expected &&
+	cat bzrrepo/content > actual &&
+	test_cmp expected actual
+'
+
+cat > expected <<EOF
+origin/HEAD
+origin/branch
+origin/trunk
+EOF
+
+test_expect_success 'proper bzr repo' '
+	test_when_finished "rm -rf bzrrepo gitrepo" &&
+
+	bzr init-repo bzrrepo &&
+
+	(
+	bzr init bzrrepo/trunk &&
+	cd bzrrepo/trunk &&
+	echo one >> content &&
+	bzr add content &&
+	bzr commit -m one
+	) &&
+
+	(
+	bzr branch bzrrepo/trunk bzrrepo/branch &&
+	cd bzrrepo/branch &&
+	echo two >> content &&
+	bzr commit -m one
+	) &&
+
+	(
+	git clone "bzr::bzrrepo" gitrepo &&
+	cd gitrepo &&
+	git for-each-ref --format "%(refname:short)" refs/remotes/origin > ..=
/actual
+	) &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'strip' '
+	test_when_finished "rm -rf bzrrepo gitrepo" &&
+
+	(
+	bzr init bzrrepo &&
+	cd bzrrepo &&
+
+	echo one >> content &&
+	bzr add content &&
+	bzr commit -m one &&
+
+	echo two >> content &&
+	bzr commit -m two
+	) &&
+
+	git clone "bzr::bzrrepo" gitrepo &&
+
+	(
+	cd bzrrepo &&
+	bzr uncommit --force &&
+
+	echo three >> content &&
+	bzr commit -m three &&
+
+	echo four >> content &&
+	bzr commit -m four &&
+	bzr log --line | sed -e "s/^[0-9][0-9]*: //" > ../expected
+	) &&
+
+	(
+	cd gitrepo &&
+	git fetch &&
+	git log --format=3D"%an %ad %s" --date=3Dshort origin/master > ../act=
ual
+	) &&
+
+	test_cmp expected actual
+'
+
+test_done
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-he=
lpers/test-hg-bidi.sh
deleted file mode 100755
index 86a3f10..0000000
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ /dev/null
@@ -1,240 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2012 Felipe Contreras
-#
-# Base commands from hg-git tests:
-# https://bitbucket.org/durin42/hg-git/src
-#
-
-test_description=3D'Test bidirectionality of remote-hg'
-
-. ./test-lib.sh
-
-if ! test_have_prereq PYTHON; then
-	skip_all=3D'skipping remote-hg tests; python not available'
-	test_done
-fi
-
-if ! "$PYTHON_PATH" -c 'import mercurial'; then
-	skip_all=3D'skipping remote-hg tests; mercurial not available'
-	test_done
-fi
-
-# clone to a git repo
-git_clone () {
-	git clone -q "hg::$1" $2
-}
-
-# clone to an hg repo
-hg_clone () {
-	(
-	hg init $2 &&
-	cd $1 &&
-	git push -q "hg::../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/=
heads/*'
-	) &&
-
-	(cd $2 && hg -q update)
-}
-
-# push an hg repo
-hg_push () {
-	(
-	cd $2
-	git checkout -q -b tmp &&
-	git fetch -q "hg::../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs=
/heads/*' &&
-	git checkout -q @{-1} &&
-	git branch -q -D tmp 2> /dev/null || true
-	)
-}
-
-hg_log () {
-	hg -R $1 log --graph --debug
-}
-
-setup () {
-	(
-	echo "[ui]"
-	echo "username =3D A U Thor <author@example.com>"
-	echo "[defaults]"
-	echo "backout =3D -d \"0 0\""
-	echo "commit =3D -d \"0 0\""
-	echo "debugrawcommit =3D -d \"0 0\""
-	echo "tag =3D -d \"0 0\""
-	echo "[extensions]"
-	echo "graphlog =3D"
-	) >> "$HOME"/.hgrc &&
-	git config --global remote-hg.hg-git-compat true
-	git config --global remote-hg.track-branches true
-
-	HGEDITOR=3D/usr/bin/true
-	GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
-	GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
-	export HGEDITOR GIT_AUTHOR_DATE GIT_COMMITTER_DATE
-}
-
-setup
-
-test_expect_success 'encoding' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add =C3=A4lph=C3=A0" &&
-
-	GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
-	export GIT_AUTHOR_NAME &&
-	echo beta > beta &&
-	git add beta &&
-	git commit -m "add beta" &&
-
-	echo gamma > gamma &&
-	git add gamma &&
-	git commit -m "add g=C3=A4mm=C3=A2" &&
-
-	: TODO git config i18n.commitencoding latin-1 &&
-	echo delta > delta &&
-	git add delta &&
-	git commit -m "add d=C3=A9lt=C3=A0"
-	) &&
-
-	hg_clone gitrepo hgrepo &&
-	git_clone hgrepo gitrepo2 &&
-	hg_clone gitrepo2 hgrepo2 &&
-
-	HGENCODING=3Dutf-8 hg_log hgrepo > expected &&
-	HGENCODING=3Dutf-8 hg_log hgrepo2 > actual &&
-
-	test_cmp expected actual
-'
-
-test_expect_success 'file removal' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	echo beta > beta &&
-	git add beta &&
-	git commit -m "add beta"
-	mkdir foo &&
-	echo blah > foo/bar &&
-	git add foo &&
-	git commit -m "add foo" &&
-	git rm alpha &&
-	git commit -m "remove alpha" &&
-	git rm foo/bar &&
-	git commit -m "remove foo/bar"
-	) &&
-
-	hg_clone gitrepo hgrepo &&
-	git_clone hgrepo gitrepo2 &&
-	hg_clone gitrepo2 hgrepo2 &&
-
-	hg_log hgrepo > expected &&
-	hg_log hgrepo2 > actual &&
-
-	test_cmp expected actual
-'
-
-test_expect_success 'git tags' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-	git config receive.denyCurrentBranch ignore &&
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	git tag alpha &&
-
-	echo beta > beta &&
-	git add beta &&
-	git commit -m "add beta" &&
-	git tag -a -m "added tag beta" beta
-	) &&
-
-	hg_clone gitrepo hgrepo &&
-	git_clone hgrepo gitrepo2 &&
-	hg_clone gitrepo2 hgrepo2 &&
-
-	hg_log hgrepo > expected &&
-	hg_log hgrepo2 > actual &&
-
-	test_cmp expected actual
-'
-
-test_expect_success 'hg branch' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -q -m "add alpha" &&
-	git checkout -q -b not-master
-	) &&
-
-	(
-	hg_clone gitrepo hgrepo &&
-
-	cd hgrepo &&
-	hg -q co default &&
-	hg mv alpha beta &&
-	hg -q commit -m "rename alpha to beta" &&
-	hg branch gamma | grep -v "permanent and global" &&
-	hg -q commit -m "started branch gamma"
-	) &&
-
-	hg_push hgrepo gitrepo &&
-	hg_clone gitrepo hgrepo2 &&
-
-	: Back to the common revision &&
-	(cd hgrepo && hg checkout default) &&
-
-	hg_log hgrepo > expected &&
-	hg_log hgrepo2 > actual &&
-
-	test_cmp expected actual
-'
-
-test_expect_success 'hg tags' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	git checkout -q -b not-master
-	) &&
-
-	(
-	hg_clone gitrepo hgrepo &&
-
-	cd hgrepo &&
-	hg co default &&
-	hg tag alpha
-	) &&
-
-	hg_push hgrepo gitrepo &&
-	hg_clone gitrepo hgrepo2 &&
-
-	hg_log hgrepo > expected &&
-	hg_log hgrepo2 > actual &&
-
-	test_cmp expected actual
-'
-
-test_done
diff --git a/contrib/remote-helpers/test-hg-bidi.t b/contrib/remote-hel=
pers/test-hg-bidi.t
new file mode 100755
index 0000000..86a3f10
--- /dev/null
+++ b/contrib/remote-helpers/test-hg-bidi.t
@@ -0,0 +1,240 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+# Base commands from hg-git tests:
+# https://bitbucket.org/durin42/hg-git/src
+#
+
+test_description=3D'Test bidirectionality of remote-hg'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	skip_all=3D'skipping remote-hg tests; python not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import mercurial'; then
+	skip_all=3D'skipping remote-hg tests; mercurial not available'
+	test_done
+fi
+
+# clone to a git repo
+git_clone () {
+	git clone -q "hg::$1" $2
+}
+
+# clone to an hg repo
+hg_clone () {
+	(
+	hg init $2 &&
+	cd $1 &&
+	git push -q "hg::../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/=
heads/*'
+	) &&
+
+	(cd $2 && hg -q update)
+}
+
+# push an hg repo
+hg_push () {
+	(
+	cd $2
+	git checkout -q -b tmp &&
+	git fetch -q "hg::../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs=
/heads/*' &&
+	git checkout -q @{-1} &&
+	git branch -q -D tmp 2> /dev/null || true
+	)
+}
+
+hg_log () {
+	hg -R $1 log --graph --debug
+}
+
+setup () {
+	(
+	echo "[ui]"
+	echo "username =3D A U Thor <author@example.com>"
+	echo "[defaults]"
+	echo "backout =3D -d \"0 0\""
+	echo "commit =3D -d \"0 0\""
+	echo "debugrawcommit =3D -d \"0 0\""
+	echo "tag =3D -d \"0 0\""
+	echo "[extensions]"
+	echo "graphlog =3D"
+	) >> "$HOME"/.hgrc &&
+	git config --global remote-hg.hg-git-compat true
+	git config --global remote-hg.track-branches true
+
+	HGEDITOR=3D/usr/bin/true
+	GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
+	GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+	export HGEDITOR GIT_AUTHOR_DATE GIT_COMMITTER_DATE
+}
+
+setup
+
+test_expect_success 'encoding' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add =C3=A4lph=C3=A0" &&
+
+	GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
+	export GIT_AUTHOR_NAME &&
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta" &&
+
+	echo gamma > gamma &&
+	git add gamma &&
+	git commit -m "add g=C3=A4mm=C3=A2" &&
+
+	: TODO git config i18n.commitencoding latin-1 &&
+	echo delta > delta &&
+	git add delta &&
+	git commit -m "add d=C3=A9lt=C3=A0"
+	) &&
+
+	hg_clone gitrepo hgrepo &&
+	git_clone hgrepo gitrepo2 &&
+	hg_clone gitrepo2 hgrepo2 &&
+
+	HGENCODING=3Dutf-8 hg_log hgrepo > expected &&
+	HGENCODING=3Dutf-8 hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'file removal' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta"
+	mkdir foo &&
+	echo blah > foo/bar &&
+	git add foo &&
+	git commit -m "add foo" &&
+	git rm alpha &&
+	git commit -m "remove alpha" &&
+	git rm foo/bar &&
+	git commit -m "remove foo/bar"
+	) &&
+
+	hg_clone gitrepo hgrepo &&
+	git_clone hgrepo gitrepo2 &&
+	hg_clone gitrepo2 hgrepo2 &&
+
+	hg_log hgrepo > expected &&
+	hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'git tags' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	git config receive.denyCurrentBranch ignore &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	git tag alpha &&
+
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta" &&
+	git tag -a -m "added tag beta" beta
+	) &&
+
+	hg_clone gitrepo hgrepo &&
+	git_clone hgrepo gitrepo2 &&
+	hg_clone gitrepo2 hgrepo2 &&
+
+	hg_log hgrepo > expected &&
+	hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'hg branch' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -q -m "add alpha" &&
+	git checkout -q -b not-master
+	) &&
+
+	(
+	hg_clone gitrepo hgrepo &&
+
+	cd hgrepo &&
+	hg -q co default &&
+	hg mv alpha beta &&
+	hg -q commit -m "rename alpha to beta" &&
+	hg branch gamma | grep -v "permanent and global" &&
+	hg -q commit -m "started branch gamma"
+	) &&
+
+	hg_push hgrepo gitrepo &&
+	hg_clone gitrepo hgrepo2 &&
+
+	: Back to the common revision &&
+	(cd hgrepo && hg checkout default) &&
+
+	hg_log hgrepo > expected &&
+	hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'hg tags' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	git checkout -q -b not-master
+	) &&
+
+	(
+	hg_clone gitrepo hgrepo &&
+
+	cd hgrepo &&
+	hg co default &&
+	hg tag alpha
+	) &&
+
+	hg_push hgrepo gitrepo &&
+	hg_clone gitrepo hgrepo2 &&
+
+	hg_log hgrepo > expected &&
+	hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_done
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-=
helpers/test-hg-hg-git.sh
deleted file mode 100755
index 0217860..0000000
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ /dev/null
@@ -1,527 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2012 Felipe Contreras
-#
-# Base commands from hg-git tests:
-# https://bitbucket.org/durin42/hg-git/src
-#
-
-test_description=3D'Test remote-hg output compared to hg-git'
-
-. ./test-lib.sh
-
-if ! test_have_prereq PYTHON; then
-	skip_all=3D'skipping remote-hg tests; python not available'
-	test_done
-fi
-
-if ! "$PYTHON_PATH" -c 'import mercurial'; then
-	skip_all=3D'skipping remote-hg tests; mercurial not available'
-	test_done
-fi
-
-if ! "$PYTHON_PATH" -c 'import hggit'; then
-	skip_all=3D'skipping remote-hg tests; hg-git not available'
-	test_done
-fi
-
-# clone to a git repo with git
-git_clone_git () {
-	git clone -q "hg::$1" $2 &&
-	(cd $2 && git checkout master && git branch -D default)
-}
-
-# clone to an hg repo with git
-hg_clone_git () {
-	(
-	hg init $2 &&
-	hg -R $2 bookmark -i master &&
-	cd $1 &&
-	git push -q "hg::../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/=
heads/*'
-	) &&
-
-	(cd $2 && hg -q update)
-}
-
-# clone to a git repo with hg
-git_clone_hg () {
-	(
-	git init -q $2 &&
-	cd $1 &&
-	hg bookmark -i -f -r tip master &&
-	hg -q push -r master ../$2 || true
-	)
-}
-
-# clone to an hg repo with hg
-hg_clone_hg () {
-	hg -q clone $1 $2
-}
-
-# push an hg repo with git
-hg_push_git () {
-	(
-	cd $2
-	git checkout -q -b tmp &&
-	git fetch -q "hg::../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs=
/heads/*' &&
-	git branch -D default &&
-	git checkout -q @{-1} &&
-	git branch -q -D tmp 2> /dev/null || true
-	)
-}
-
-# push an hg git repo with hg
-hg_push_hg () {
-	(
-	cd $1 &&
-	hg -q push ../$2 || true
-	)
-}
-
-hg_log () {
-	hg -R $1 log --graph --debug >log &&
-	grep -v 'tag: *default/' log
-}
-
-git_log () {
-	git --git-dir=3D$1/.git fast-export --branches
-}
-
-setup () {
-	(
-	echo "[ui]"
-	echo "username =3D A U Thor <author@example.com>"
-	echo "[defaults]"
-	echo "backout =3D -d \"0 0\""
-	echo "commit =3D -d \"0 0\""
-	echo "debugrawcommit =3D -d \"0 0\""
-	echo "tag =3D -d \"0 0\""
-	echo "[extensions]"
-	echo "hgext.bookmarks =3D"
-	echo "hggit =3D"
-	echo "graphlog =3D"
-	) >> "$HOME"/.hgrc &&
-	git config --global receive.denycurrentbranch warn
-	git config --global remote-hg.hg-git-compat true
-	git config --global remote-hg.track-branches false
-
-	HGEDITOR=3Dtrue
-	HGMERGE=3Dtrue
-
-	GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
-	GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
-	export HGEDITOR HGMERGE GIT_AUTHOR_DATE GIT_COMMITTER_DATE
-}
-
-setup
-
-test_expect_success 'executable bit' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-	echo alpha > alpha &&
-	chmod 0644 alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	chmod 0755 alpha &&
-	git add alpha &&
-	git commit -m "set executable bit" &&
-	chmod 0644 alpha &&
-	git add alpha &&
-	git commit -m "clear executable bit"
-	) &&
-
-	for x in hg git; do
-		(
-		hg_clone_$x gitrepo hgrepo-$x &&
-		cd hgrepo-$x &&
-		hg_log . &&
-		hg manifest -r 1 -v &&
-		hg manifest -v
-		) > output-$x &&
-
-		git_clone_$x hgrepo-$x gitrepo2-$x &&
-		git_log gitrepo2-$x > log-$x
-	done &&
-
-	test_cmp output-hg output-git &&
-	test_cmp log-hg log-git
-'
-
-test_expect_success 'symlink' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	ln -s alpha beta &&
-	git add beta &&
-	git commit -m "add beta"
-	) &&
-
-	for x in hg git; do
-		(
-		hg_clone_$x gitrepo hgrepo-$x &&
-		cd hgrepo-$x &&
-		hg_log . &&
-		hg manifest -v
-		) > output-$x &&
-
-		git_clone_$x hgrepo-$x gitrepo2-$x &&
-		git_log gitrepo2-$x > log-$x
-	done &&
-
-	test_cmp output-hg output-git &&
-	test_cmp log-hg log-git
-'
-
-test_expect_success 'merge conflict 1' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	hg init hgrepo1 &&
-	cd hgrepo1 &&
-	echo A > afile &&
-	hg add afile &&
-	hg ci -m "origin" &&
-
-	echo B > afile &&
-	hg ci -m "A->B" &&
-
-	hg up -r0 &&
-	echo C > afile &&
-	hg ci -m "A->C" &&
-
-	hg merge -r1 &&
-	echo C > afile &&
-	hg resolve -m afile &&
-	hg ci -m "merge to C"
-	) &&
-
-	for x in hg git; do
-		git_clone_$x hgrepo1 gitrepo-$x &&
-		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
-	done &&
-
-	test_cmp hg-log-hg hg-log-git &&
-	test_cmp git-log-hg git-log-git
-'
-
-test_expect_success 'merge conflict 2' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	hg init hgrepo1 &&
-	cd hgrepo1 &&
-	echo A > afile &&
-	hg add afile &&
-	hg ci -m "origin" &&
-
-	echo B > afile &&
-	hg ci -m "A->B" &&
-
-	hg up -r0 &&
-	echo C > afile &&
-	hg ci -m "A->C" &&
-
-	hg merge -r1 || true &&
-	echo B > afile &&
-	hg resolve -m afile &&
-	hg ci -m "merge to B"
-	) &&
-
-	for x in hg git; do
-		git_clone_$x hgrepo1 gitrepo-$x &&
-		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
-	done &&
-
-	test_cmp hg-log-hg hg-log-git &&
-	test_cmp git-log-hg git-log-git
-'
-
-test_expect_success 'converged merge' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	hg init hgrepo1 &&
-	cd hgrepo1 &&
-	echo A > afile &&
-	hg add afile &&
-	hg ci -m "origin" &&
-
-	echo B > afile &&
-	hg ci -m "A->B" &&
-
-	echo C > afile &&
-	hg ci -m "B->C" &&
-
-	hg up -r0 &&
-	echo C > afile &&
-	hg ci -m "A->C" &&
-
-	hg merge -r2 || true &&
-	hg ci -m "merge"
-	) &&
-
-	for x in hg git; do
-		git_clone_$x hgrepo1 gitrepo-$x &&
-		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
-	done &&
-
-	test_cmp hg-log-hg hg-log-git &&
-	test_cmp git-log-hg git-log-git
-'
-
-test_expect_success 'encoding' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add =C3=A4lph=C3=A0" &&
-
-	GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
-	export GIT_AUTHOR_NAME &&
-	echo beta > beta &&
-	git add beta &&
-	git commit -m "add beta" &&
-
-	echo gamma > gamma &&
-	git add gamma &&
-	git commit -m "add g=C3=A4mm=C3=A2" &&
-
-	: TODO git config i18n.commitencoding latin-1 &&
-	echo delta > delta &&
-	git add delta &&
-	git commit -m "add d=C3=A9lt=C3=A0"
-	) &&
-
-	for x in hg git; do
-		hg_clone_$x gitrepo hgrepo-$x &&
-		git_clone_$x hgrepo-$x gitrepo2-$x &&
-
-		HGENCODING=3Dutf-8 hg_log hgrepo-$x > hg-log-$x &&
-		git_log gitrepo2-$x > git-log-$x
-	done &&
-
-	test_cmp hg-log-hg hg-log-git &&
-	test_cmp git-log-hg git-log-git
-'
-
-test_expect_success 'file removal' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	echo beta > beta &&
-	git add beta &&
-	git commit -m "add beta"
-	mkdir foo &&
-	echo blah > foo/bar &&
-	git add foo &&
-	git commit -m "add foo" &&
-	git rm alpha &&
-	git commit -m "remove alpha" &&
-	git rm foo/bar &&
-	git commit -m "remove foo/bar"
-	) &&
-
-	for x in hg git; do
-		(
-		hg_clone_$x gitrepo hgrepo-$x &&
-		cd hgrepo-$x &&
-		hg_log . &&
-		hg manifest -r 3 &&
-		hg manifest
-		) > output-$x &&
-
-		git_clone_$x hgrepo-$x gitrepo2-$x &&
-		git_log gitrepo2-$x > log-$x
-	done &&
-
-	test_cmp output-hg output-git &&
-	test_cmp log-hg log-git
-'
-
-test_expect_success 'git tags' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-	git config receive.denyCurrentBranch ignore &&
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	git tag alpha &&
-
-	echo beta > beta &&
-	git add beta &&
-	git commit -m "add beta" &&
-	git tag -a -m "added tag beta" beta
-	) &&
-
-	for x in hg git; do
-		hg_clone_$x gitrepo hgrepo-$x &&
-		hg_log hgrepo-$x > log-$x
-	done &&
-
-	test_cmp log-hg log-git
-'
-
-test_expect_success 'hg author' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	for x in hg git; do
-		(
-		git init -q gitrepo-$x &&
-		cd gitrepo-$x &&
-
-		echo alpha > alpha &&
-		git add alpha &&
-		git commit -m "add alpha" &&
-		git checkout -q -b not-master
-		) &&
-
-		(
-		hg_clone_$x gitrepo-$x hgrepo-$x &&
-		cd hgrepo-$x &&
-
-		hg co master &&
-		echo beta > beta &&
-		hg add beta &&
-		hg commit -u "test" -m "add beta" &&
-
-		echo gamma >> beta &&
-		hg commit -u "test <test@example.com> (comment)" -m "modify beta" &&
-
-		echo gamma > gamma &&
-		hg add gamma &&
-		hg commit -u "<test@example.com>" -m "add gamma" &&
-
-		echo delta > delta &&
-		hg add delta &&
-		hg commit -u "name<test@example.com>" -m "add delta" &&
-
-		echo epsilon > epsilon &&
-		hg add epsilon &&
-		hg commit -u "name <test@example.com" -m "add epsilon" &&
-
-		echo zeta > zeta &&
-		hg add zeta &&
-		hg commit -u " test " -m "add zeta" &&
-
-		echo eta > eta &&
-		hg add eta &&
-		hg commit -u "test < test@example.com >" -m "add eta" &&
-
-		echo theta > theta &&
-		hg add theta &&
-		hg commit -u "test >test@example.com>" -m "add theta" &&
-
-		echo iota > iota &&
-		hg add iota &&
-		hg commit -u "test <test <at> example <dot> com>" -m "add iota"
-		) &&
-
-		hg_push_$x hgrepo-$x gitrepo-$x &&
-		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
-	done &&
-
-	test_cmp hg-log-hg hg-log-git &&
-	test_cmp git-log-hg git-log-git
-'
-
-test_expect_success 'hg branch' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	for x in hg git; do
-		(
-		git init -q gitrepo-$x &&
-		cd gitrepo-$x &&
-
-		echo alpha > alpha &&
-		git add alpha &&
-		git commit -q -m "add alpha" &&
-		git checkout -q -b not-master
-		) &&
-
-		(
-		hg_clone_$x gitrepo-$x hgrepo-$x &&
-
-		cd hgrepo-$x &&
-		hg -q co master &&
-		hg mv alpha beta &&
-		hg -q commit -m "rename alpha to beta" &&
-		hg branch gamma | grep -v "permanent and global" &&
-		hg -q commit -m "started branch gamma"
-		) &&
-
-		hg_push_$x hgrepo-$x gitrepo-$x &&
-		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
-	done &&
-
-	test_cmp hg-log-hg hg-log-git &&
-	test_cmp git-log-hg git-log-git
-'
-
-test_expect_success 'hg tags' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	for x in hg git; do
-		(
-		git init -q gitrepo-$x &&
-		cd gitrepo-$x &&
-
-		echo alpha > alpha &&
-		git add alpha &&
-		git commit -m "add alpha" &&
-		git checkout -q -b not-master
-		) &&
-
-		(
-		hg_clone_$x gitrepo-$x hgrepo-$x &&
-
-		cd hgrepo-$x &&
-		hg co master &&
-		hg tag alpha
-		) &&
-
-		hg_push_$x hgrepo-$x gitrepo-$x &&
-		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-
-		(
-		git --git-dir=3Dgitrepo-$x/.git tag -l &&
-		hg_log hgrepo2-$x &&
-		cat hgrepo2-$x/.hgtags
-		) > output-$x
-	done &&
-
-	test_cmp output-hg output-git
-'
-
-test_done
diff --git a/contrib/remote-helpers/test-hg-hg-git.t b/contrib/remote-h=
elpers/test-hg-hg-git.t
new file mode 100755
index 0000000..0217860
--- /dev/null
+++ b/contrib/remote-helpers/test-hg-hg-git.t
@@ -0,0 +1,527 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+# Base commands from hg-git tests:
+# https://bitbucket.org/durin42/hg-git/src
+#
+
+test_description=3D'Test remote-hg output compared to hg-git'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	skip_all=3D'skipping remote-hg tests; python not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import mercurial'; then
+	skip_all=3D'skipping remote-hg tests; mercurial not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import hggit'; then
+	skip_all=3D'skipping remote-hg tests; hg-git not available'
+	test_done
+fi
+
+# clone to a git repo with git
+git_clone_git () {
+	git clone -q "hg::$1" $2 &&
+	(cd $2 && git checkout master && git branch -D default)
+}
+
+# clone to an hg repo with git
+hg_clone_git () {
+	(
+	hg init $2 &&
+	hg -R $2 bookmark -i master &&
+	cd $1 &&
+	git push -q "hg::../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/=
heads/*'
+	) &&
+
+	(cd $2 && hg -q update)
+}
+
+# clone to a git repo with hg
+git_clone_hg () {
+	(
+	git init -q $2 &&
+	cd $1 &&
+	hg bookmark -i -f -r tip master &&
+	hg -q push -r master ../$2 || true
+	)
+}
+
+# clone to an hg repo with hg
+hg_clone_hg () {
+	hg -q clone $1 $2
+}
+
+# push an hg repo with git
+hg_push_git () {
+	(
+	cd $2
+	git checkout -q -b tmp &&
+	git fetch -q "hg::../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs=
/heads/*' &&
+	git branch -D default &&
+	git checkout -q @{-1} &&
+	git branch -q -D tmp 2> /dev/null || true
+	)
+}
+
+# push an hg git repo with hg
+hg_push_hg () {
+	(
+	cd $1 &&
+	hg -q push ../$2 || true
+	)
+}
+
+hg_log () {
+	hg -R $1 log --graph --debug >log &&
+	grep -v 'tag: *default/' log
+}
+
+git_log () {
+	git --git-dir=3D$1/.git fast-export --branches
+}
+
+setup () {
+	(
+	echo "[ui]"
+	echo "username =3D A U Thor <author@example.com>"
+	echo "[defaults]"
+	echo "backout =3D -d \"0 0\""
+	echo "commit =3D -d \"0 0\""
+	echo "debugrawcommit =3D -d \"0 0\""
+	echo "tag =3D -d \"0 0\""
+	echo "[extensions]"
+	echo "hgext.bookmarks =3D"
+	echo "hggit =3D"
+	echo "graphlog =3D"
+	) >> "$HOME"/.hgrc &&
+	git config --global receive.denycurrentbranch warn
+	git config --global remote-hg.hg-git-compat true
+	git config --global remote-hg.track-branches false
+
+	HGEDITOR=3Dtrue
+	HGMERGE=3Dtrue
+
+	GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
+	GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+	export HGEDITOR HGMERGE GIT_AUTHOR_DATE GIT_COMMITTER_DATE
+}
+
+setup
+
+test_expect_success 'executable bit' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	echo alpha > alpha &&
+	chmod 0644 alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	chmod 0755 alpha &&
+	git add alpha &&
+	git commit -m "set executable bit" &&
+	chmod 0644 alpha &&
+	git add alpha &&
+	git commit -m "clear executable bit"
+	) &&
+
+	for x in hg git; do
+		(
+		hg_clone_$x gitrepo hgrepo-$x &&
+		cd hgrepo-$x &&
+		hg_log . &&
+		hg manifest -r 1 -v &&
+		hg manifest -v
+		) > output-$x &&
+
+		git_clone_$x hgrepo-$x gitrepo2-$x &&
+		git_log gitrepo2-$x > log-$x
+	done &&
+
+	test_cmp output-hg output-git &&
+	test_cmp log-hg log-git
+'
+
+test_expect_success 'symlink' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	ln -s alpha beta &&
+	git add beta &&
+	git commit -m "add beta"
+	) &&
+
+	for x in hg git; do
+		(
+		hg_clone_$x gitrepo hgrepo-$x &&
+		cd hgrepo-$x &&
+		hg_log . &&
+		hg manifest -v
+		) > output-$x &&
+
+		git_clone_$x hgrepo-$x gitrepo2-$x &&
+		git_log gitrepo2-$x > log-$x
+	done &&
+
+	test_cmp output-hg output-git &&
+	test_cmp log-hg log-git
+'
+
+test_expect_success 'merge conflict 1' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	hg init hgrepo1 &&
+	cd hgrepo1 &&
+	echo A > afile &&
+	hg add afile &&
+	hg ci -m "origin" &&
+
+	echo B > afile &&
+	hg ci -m "A->B" &&
+
+	hg up -r0 &&
+	echo C > afile &&
+	hg ci -m "A->C" &&
+
+	hg merge -r1 &&
+	echo C > afile &&
+	hg resolve -m afile &&
+	hg ci -m "merge to C"
+	) &&
+
+	for x in hg git; do
+		git_clone_$x hgrepo1 gitrepo-$x &&
+		hg_clone_$x gitrepo-$x hgrepo2-$x &&
+		hg_log hgrepo2-$x > hg-log-$x &&
+		git_log gitrepo-$x > git-log-$x
+	done &&
+
+	test_cmp hg-log-hg hg-log-git &&
+	test_cmp git-log-hg git-log-git
+'
+
+test_expect_success 'merge conflict 2' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	hg init hgrepo1 &&
+	cd hgrepo1 &&
+	echo A > afile &&
+	hg add afile &&
+	hg ci -m "origin" &&
+
+	echo B > afile &&
+	hg ci -m "A->B" &&
+
+	hg up -r0 &&
+	echo C > afile &&
+	hg ci -m "A->C" &&
+
+	hg merge -r1 || true &&
+	echo B > afile &&
+	hg resolve -m afile &&
+	hg ci -m "merge to B"
+	) &&
+
+	for x in hg git; do
+		git_clone_$x hgrepo1 gitrepo-$x &&
+		hg_clone_$x gitrepo-$x hgrepo2-$x &&
+		hg_log hgrepo2-$x > hg-log-$x &&
+		git_log gitrepo-$x > git-log-$x
+	done &&
+
+	test_cmp hg-log-hg hg-log-git &&
+	test_cmp git-log-hg git-log-git
+'
+
+test_expect_success 'converged merge' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	hg init hgrepo1 &&
+	cd hgrepo1 &&
+	echo A > afile &&
+	hg add afile &&
+	hg ci -m "origin" &&
+
+	echo B > afile &&
+	hg ci -m "A->B" &&
+
+	echo C > afile &&
+	hg ci -m "B->C" &&
+
+	hg up -r0 &&
+	echo C > afile &&
+	hg ci -m "A->C" &&
+
+	hg merge -r2 || true &&
+	hg ci -m "merge"
+	) &&
+
+	for x in hg git; do
+		git_clone_$x hgrepo1 gitrepo-$x &&
+		hg_clone_$x gitrepo-$x hgrepo2-$x &&
+		hg_log hgrepo2-$x > hg-log-$x &&
+		git_log gitrepo-$x > git-log-$x
+	done &&
+
+	test_cmp hg-log-hg hg-log-git &&
+	test_cmp git-log-hg git-log-git
+'
+
+test_expect_success 'encoding' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add =C3=A4lph=C3=A0" &&
+
+	GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
+	export GIT_AUTHOR_NAME &&
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta" &&
+
+	echo gamma > gamma &&
+	git add gamma &&
+	git commit -m "add g=C3=A4mm=C3=A2" &&
+
+	: TODO git config i18n.commitencoding latin-1 &&
+	echo delta > delta &&
+	git add delta &&
+	git commit -m "add d=C3=A9lt=C3=A0"
+	) &&
+
+	for x in hg git; do
+		hg_clone_$x gitrepo hgrepo-$x &&
+		git_clone_$x hgrepo-$x gitrepo2-$x &&
+
+		HGENCODING=3Dutf-8 hg_log hgrepo-$x > hg-log-$x &&
+		git_log gitrepo2-$x > git-log-$x
+	done &&
+
+	test_cmp hg-log-hg hg-log-git &&
+	test_cmp git-log-hg git-log-git
+'
+
+test_expect_success 'file removal' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta"
+	mkdir foo &&
+	echo blah > foo/bar &&
+	git add foo &&
+	git commit -m "add foo" &&
+	git rm alpha &&
+	git commit -m "remove alpha" &&
+	git rm foo/bar &&
+	git commit -m "remove foo/bar"
+	) &&
+
+	for x in hg git; do
+		(
+		hg_clone_$x gitrepo hgrepo-$x &&
+		cd hgrepo-$x &&
+		hg_log . &&
+		hg manifest -r 3 &&
+		hg manifest
+		) > output-$x &&
+
+		git_clone_$x hgrepo-$x gitrepo2-$x &&
+		git_log gitrepo2-$x > log-$x
+	done &&
+
+	test_cmp output-hg output-git &&
+	test_cmp log-hg log-git
+'
+
+test_expect_success 'git tags' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	git config receive.denyCurrentBranch ignore &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	git tag alpha &&
+
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta" &&
+	git tag -a -m "added tag beta" beta
+	) &&
+
+	for x in hg git; do
+		hg_clone_$x gitrepo hgrepo-$x &&
+		hg_log hgrepo-$x > log-$x
+	done &&
+
+	test_cmp log-hg log-git
+'
+
+test_expect_success 'hg author' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	for x in hg git; do
+		(
+		git init -q gitrepo-$x &&
+		cd gitrepo-$x &&
+
+		echo alpha > alpha &&
+		git add alpha &&
+		git commit -m "add alpha" &&
+		git checkout -q -b not-master
+		) &&
+
+		(
+		hg_clone_$x gitrepo-$x hgrepo-$x &&
+		cd hgrepo-$x &&
+
+		hg co master &&
+		echo beta > beta &&
+		hg add beta &&
+		hg commit -u "test" -m "add beta" &&
+
+		echo gamma >> beta &&
+		hg commit -u "test <test@example.com> (comment)" -m "modify beta" &&
+
+		echo gamma > gamma &&
+		hg add gamma &&
+		hg commit -u "<test@example.com>" -m "add gamma" &&
+
+		echo delta > delta &&
+		hg add delta &&
+		hg commit -u "name<test@example.com>" -m "add delta" &&
+
+		echo epsilon > epsilon &&
+		hg add epsilon &&
+		hg commit -u "name <test@example.com" -m "add epsilon" &&
+
+		echo zeta > zeta &&
+		hg add zeta &&
+		hg commit -u " test " -m "add zeta" &&
+
+		echo eta > eta &&
+		hg add eta &&
+		hg commit -u "test < test@example.com >" -m "add eta" &&
+
+		echo theta > theta &&
+		hg add theta &&
+		hg commit -u "test >test@example.com>" -m "add theta" &&
+
+		echo iota > iota &&
+		hg add iota &&
+		hg commit -u "test <test <at> example <dot> com>" -m "add iota"
+		) &&
+
+		hg_push_$x hgrepo-$x gitrepo-$x &&
+		hg_clone_$x gitrepo-$x hgrepo2-$x &&
+
+		hg_log hgrepo2-$x > hg-log-$x &&
+		git_log gitrepo-$x > git-log-$x
+	done &&
+
+	test_cmp hg-log-hg hg-log-git &&
+	test_cmp git-log-hg git-log-git
+'
+
+test_expect_success 'hg branch' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	for x in hg git; do
+		(
+		git init -q gitrepo-$x &&
+		cd gitrepo-$x &&
+
+		echo alpha > alpha &&
+		git add alpha &&
+		git commit -q -m "add alpha" &&
+		git checkout -q -b not-master
+		) &&
+
+		(
+		hg_clone_$x gitrepo-$x hgrepo-$x &&
+
+		cd hgrepo-$x &&
+		hg -q co master &&
+		hg mv alpha beta &&
+		hg -q commit -m "rename alpha to beta" &&
+		hg branch gamma | grep -v "permanent and global" &&
+		hg -q commit -m "started branch gamma"
+		) &&
+
+		hg_push_$x hgrepo-$x gitrepo-$x &&
+		hg_clone_$x gitrepo-$x hgrepo2-$x &&
+
+		hg_log hgrepo2-$x > hg-log-$x &&
+		git_log gitrepo-$x > git-log-$x
+	done &&
+
+	test_cmp hg-log-hg hg-log-git &&
+	test_cmp git-log-hg git-log-git
+'
+
+test_expect_success 'hg tags' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	for x in hg git; do
+		(
+		git init -q gitrepo-$x &&
+		cd gitrepo-$x &&
+
+		echo alpha > alpha &&
+		git add alpha &&
+		git commit -m "add alpha" &&
+		git checkout -q -b not-master
+		) &&
+
+		(
+		hg_clone_$x gitrepo-$x hgrepo-$x &&
+
+		cd hgrepo-$x &&
+		hg co master &&
+		hg tag alpha
+		) &&
+
+		hg_push_$x hgrepo-$x gitrepo-$x &&
+		hg_clone_$x gitrepo-$x hgrepo2-$x &&
+
+		(
+		git --git-dir=3Dgitrepo-$x/.git tag -l &&
+		hg_log hgrepo2-$x &&
+		cat hgrepo2-$x/.hgtags
+		) > output-$x
+	done &&
+
+	test_cmp output-hg output-git
+'
+
+test_done
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers=
/test-hg.sh
deleted file mode 100755
index 30f4ff6..0000000
--- a/contrib/remote-helpers/test-hg.sh
+++ /dev/null
@@ -1,692 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2012 Felipe Contreras
-#
-# Base commands from hg-git tests:
-# https://bitbucket.org/durin42/hg-git/src
-#
-
-test_description=3D'Test remote-hg'
-
-. ./test-lib.sh
-
-if ! test_have_prereq PYTHON; then
-	skip_all=3D'skipping remote-hg tests; python not available'
-	test_done
-fi
-
-if ! "$PYTHON_PATH" -c 'import mercurial'; then
-	skip_all=3D'skipping remote-hg tests; mercurial not available'
-	test_done
-fi
-
-check () {
-	echo $3 > expected &&
-	git --git-dir=3D$1/.git log --format=3D'%s' -1 $2 > actual
-	test_cmp expected actual
-}
-
-check_branch () {
-	if [ -n "$3" ]; then
-		echo $3 > expected &&
-		hg -R $1 log -r $2 --template '{desc}\n' > actual &&
-		test_cmp expected actual
-	else
-		hg -R $1 branches > out &&
-		! grep $2 out
-	fi
-}
-
-check_bookmark () {
-	if [ -n "$3" ]; then
-		echo $3 > expected &&
-		hg -R $1 log -r "bookmark('$2')" --template '{desc}\n' > actual &&
-		test_cmp expected actual
-	else
-		hg -R $1 bookmarks > out &&
-		! grep $2 out
-	fi
-}
-
-check_push () {
-	local expected_ret=3D$1 ret=3D0 ref_ret=3D0 IFS=3D':'
-
-	shift
-	git push origin "$@" 2> error
-	ret=3D$?
-	cat error
-
-	while read branch kind
-	do
-		case "$kind" in
-		'new')
-			grep "^ \* \[new branch\] *${branch} -> ${branch}$" error || ref_re=
t=3D1
-			;;
-		'non-fast-forward')
-			grep "^ ! \[rejected\] *${branch} -> ${branch} (non-fast-forward)$"=
 error || ref_ret=3D1
-			;;
-		'fetch-first')
-			grep "^ ! \[rejected\] *${branch} -> ${branch} (fetch first)$" erro=
r || ref_ret=3D1
-			;;
-		'forced-update')
-			grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *${branch} -> ${branch} (forced =
update)$" error || ref_ret=3D1
-			;;
-		'')
-			grep "^   [a-f0-9]*\.\.[a-f0-9]* *${branch} -> ${branch}$" error ||=
 ref_ret=3D1
-			;;
-		esac
-		let 'ref_ret' && echo "match for '$branch' failed" && break
-	done
-
-	if let 'expected_ret !=3D ret || ref_ret'
-	then
-		return 1
-	fi
-
-	return 0
-}
-
-setup () {
-	(
-	echo "[ui]"
-	echo "username =3D H G Wells <wells@example.com>"
-	echo "[extensions]"
-	echo "mq =3D"
-	) >> "$HOME"/.hgrc &&
-
-	GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230" &&
-	GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE" &&
-	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
-}
-
-setup
-
-test_expect_success 'cloning' '
-	test_when_finished "rm -rf gitrepo*" &&
-
-	(
-	hg init hgrepo &&
-	cd hgrepo &&
-	echo zero > content &&
-	hg add content &&
-	hg commit -m zero
-	) &&
-
-	git clone "hg::hgrepo" gitrepo &&
-	check gitrepo HEAD zero
-'
-
-test_expect_success 'cloning with branches' '
-	test_when_finished "rm -rf gitrepo*" &&
-
-	(
-	cd hgrepo &&
-	hg branch next &&
-	echo next > content &&
-	hg commit -m next
-	) &&
-
-	git clone "hg::hgrepo" gitrepo &&
-	check gitrepo origin/branches/next next
-'
-
-test_expect_success 'cloning with bookmarks' '
-	test_when_finished "rm -rf gitrepo*" &&
-
-	(
-	cd hgrepo &&
-	hg checkout default &&
-	hg bookmark feature-a &&
-	echo feature-a > content &&
-	hg commit -m feature-a
-	) &&
-
-	git clone "hg::hgrepo" gitrepo &&
-	check gitrepo origin/feature-a feature-a
-'
-
-test_expect_success 'update bookmark' '
-	test_when_finished "rm -rf gitrepo*" &&
-
-	(
-	cd hgrepo &&
-	hg bookmark devel
-	) &&
-
-	(
-	git clone "hg::hgrepo" gitrepo &&
-	cd gitrepo &&
-	git checkout --quiet devel &&
-	echo devel > content &&
-	git commit -a -m devel &&
-	git push --quiet
-	) &&
-
-	check_bookmark hgrepo devel devel
-'
-
-test_expect_success 'new bookmark' '
-	test_when_finished "rm -rf gitrepo*" &&
-
-	(
-	git clone "hg::hgrepo" gitrepo &&
-	cd gitrepo &&
-	git checkout --quiet -b feature-b &&
-	echo feature-b > content &&
-	git commit -a -m feature-b &&
-	git push --quiet origin feature-b
-	) &&
-
-	check_bookmark hgrepo feature-b feature-b
-'
-
-# cleanup previous stuff
-rm -rf hgrepo
-
-author_test () {
-	echo $1 >> content &&
-	hg commit -u "$2" -m "add $1" &&
-	echo "$3" >> ../expected
-}
-
-test_expect_success 'authors' '
-	test_when_finished "rm -rf hgrepo gitrepo" &&
-
-	(
-	hg init hgrepo &&
-	cd hgrepo &&
-
-	touch content &&
-	hg add content &&
-
-	> ../expected &&
-	author_test alpha "" "H G Wells <wells@example.com>" &&
-	author_test beta "test" "test <unknown>" &&
-	author_test beta "test <test@example.com> (comment)" "test <test@exam=
ple.com>" &&
-	author_test gamma "<test@example.com>" "Unknown <test@example.com>" &=
&
-	author_test delta "name<test@example.com>" "name <test@example.com>" =
&&
-	author_test epsilon "name <test@example.com" "name <test@example.com>=
" &&
-	author_test zeta " test " "test <unknown>" &&
-	author_test eta "test < test@example.com >" "test <test@example.com>"=
 &&
-	author_test theta "test >test@example.com>" "test <test@example.com>"=
 &&
-	author_test iota "test < test <at> example <dot> com>" "test <unknown=
>" &&
-	author_test kappa "test@example.com" "Unknown <test@example.com>"
-	) &&
-
-	git clone "hg::hgrepo" gitrepo &&
-	git --git-dir=3Dgitrepo/.git log --reverse --format=3D"%an <%ae>" > a=
ctual &&
-
-	test_cmp expected actual
-'
-
-test_expect_success 'strip' '
-	test_when_finished "rm -rf hgrepo gitrepo" &&
-
-	(
-	hg init hgrepo &&
-	cd hgrepo &&
-
-	echo one >> content &&
-	hg add content &&
-	hg commit -m one &&
-
-	echo two >> content &&
-	hg commit -m two
-	) &&
-
-	git clone "hg::hgrepo" gitrepo &&
-
-	(
-	cd hgrepo &&
-	hg strip 1 &&
-
-	echo three >> content &&
-	hg commit -m three &&
-
-	echo four >> content &&
-	hg commit -m four
-	) &&
-
-	(
-	cd gitrepo &&
-	git fetch &&
-	git log --format=3D"%s" origin/master > ../actual
-	) &&
-
-	hg -R hgrepo log --template "{desc}\n" > expected &&
-	test_cmp actual expected
-'
-
-test_expect_success 'remote push with master bookmark' '
-	test_when_finished "rm -rf hgrepo gitrepo*" &&
-
-	(
-	hg init hgrepo &&
-	cd hgrepo &&
-	echo zero > content &&
-	hg add content &&
-	hg commit -m zero &&
-	hg bookmark master &&
-	echo one > content &&
-	hg commit -m one
-	) &&
-
-	(
-	git clone "hg::hgrepo" gitrepo &&
-	cd gitrepo &&
-	echo two > content &&
-	git commit -a -m two &&
-	git push
-	) &&
-
-	check_branch hgrepo default two
-'
-
-cat > expected <<EOF
-changeset:   0:6e2126489d3d
-tag:         tip
-user:        A U Thor <author@example.com>
-date:        Mon Jan 01 00:00:00 2007 +0230
-summary:     one
-
-EOF
-
-test_expect_success 'remote push from master branch' '
-	test_when_finished "rm -rf hgrepo gitrepo*" &&
-
-	hg init hgrepo &&
-
-	(
-	git init gitrepo &&
-	cd gitrepo &&
-	git remote add origin "hg::../hgrepo" &&
-	echo one > content &&
-	git add content &&
-	git commit -a -m one &&
-	git push origin master
-	) &&
-
-	hg -R hgrepo log > actual &&
-	cat actual &&
-	test_cmp expected actual &&
-
-	check_branch hgrepo default one
-'
-
-GIT_REMOTE_HG_TEST_REMOTE=3D1
-export GIT_REMOTE_HG_TEST_REMOTE
-
-test_expect_success 'remote cloning' '
-	test_when_finished "rm -rf gitrepo*" &&
-
-	(
-	hg init hgrepo &&
-	cd hgrepo &&
-	echo zero > content &&
-	hg add content &&
-	hg commit -m zero
-	) &&
-
-	git clone "hg::hgrepo" gitrepo &&
-	check gitrepo HEAD zero
-'
-
-test_expect_success 'remote update bookmark' '
-	test_when_finished "rm -rf gitrepo*" &&
-
-	(
-	cd hgrepo &&
-	hg bookmark devel
-	) &&
-
-	(
-	git clone "hg::hgrepo" gitrepo &&
-	cd gitrepo &&
-	git checkout --quiet devel &&
-	echo devel > content &&
-	git commit -a -m devel &&
-	git push --quiet
-	) &&
-
-	check_bookmark hgrepo devel devel
-'
-
-test_expect_success 'remote new bookmark' '
-	test_when_finished "rm -rf gitrepo*" &&
-
-	(
-	git clone "hg::hgrepo" gitrepo &&
-	cd gitrepo &&
-	git checkout --quiet -b feature-b &&
-	echo feature-b > content &&
-	git commit -a -m feature-b &&
-	git push --quiet origin feature-b
-	) &&
-
-	check_bookmark hgrepo feature-b feature-b
-'
-
-test_expect_success 'remote push diverged' '
-	test_when_finished "rm -rf gitrepo*" &&
-
-	git clone "hg::hgrepo" gitrepo &&
-
-	(
-	cd hgrepo &&
-	hg checkout default &&
-	echo bump > content &&
-	hg commit -m bump
-	) &&
-
-	(
-	cd gitrepo &&
-	echo diverge > content &&
-	git commit -a -m diverged &&
-	check_push 1 <<-EOF
-	master:non-fast-forward
-	EOF
-	) &&
-
-	check_branch hgrepo default bump
-'
-
-test_expect_success 'remote update bookmark diverge' '
-	test_when_finished "rm -rf gitrepo*" &&
-
-	(
-	cd hgrepo &&
-	hg checkout tip^ &&
-	hg bookmark diverge
-	) &&
-
-	git clone "hg::hgrepo" gitrepo &&
-
-	(
-	cd hgrepo &&
-	echo "bump bookmark" > content &&
-	hg commit -m "bump bookmark"
-	) &&
-
-	(
-	cd gitrepo &&
-	git checkout --quiet diverge &&
-	echo diverge > content &&
-	git commit -a -m diverge &&
-	check_push 1 <<-EOF
-	diverge:fetch-first
-	EOF
-	) &&
-
-	check_bookmark hgrepo diverge "bump bookmark"
-'
-
-test_expect_success 'remote new bookmark multiple branch head' '
-	test_when_finished "rm -rf gitrepo*" &&
-
-	(
-	git clone "hg::hgrepo" gitrepo &&
-	cd gitrepo &&
-	git checkout --quiet -b feature-c HEAD^ &&
-	echo feature-c > content &&
-	git commit -a -m feature-c &&
-	git push --quiet origin feature-c
-	) &&
-
-	check_bookmark hgrepo feature-c feature-c
-'
-
-# cleanup previous stuff
-rm -rf hgrepo
-
-setup_big_push () {
-	(
-	hg init hgrepo &&
-	cd hgrepo &&
-	echo zero > content &&
-	hg add content &&
-	hg commit -m zero &&
-	hg bookmark bad_bmark1 &&
-	echo one > content &&
-	hg commit -m one &&
-	hg bookmark bad_bmark2 &&
-	hg bookmark good_bmark &&
-	hg bookmark -i good_bmark &&
-	hg -q branch good_branch &&
-	echo "good branch" > content &&
-	hg commit -m "good branch" &&
-	hg -q branch bad_branch &&
-	echo "bad branch" > content &&
-	hg commit -m "bad branch"
-	) &&
-
-	git clone "hg::hgrepo" gitrepo &&
-
-	(
-	cd gitrepo &&
-	echo two > content &&
-	git commit -q -a -m two &&
-
-	git checkout -q good_bmark &&
-	echo three > content &&
-	git commit -q -a -m three &&
-
-	git checkout -q bad_bmark1 &&
-	git reset --hard HEAD^ &&
-	echo four > content &&
-	git commit -q -a -m four &&
-
-	git checkout -q bad_bmark2 &&
-	git reset --hard HEAD^ &&
-	echo five > content &&
-	git commit -q -a -m five &&
-
-	git checkout -q -b new_bmark master &&
-	echo six > content &&
-	git commit -q -a -m six &&
-
-	git checkout -q branches/good_branch &&
-	echo seven > content &&
-	git commit -q -a -m seven &&
-	echo eight > content &&
-	git commit -q -a -m eight &&
-
-	git checkout -q branches/bad_branch &&
-	git reset --hard HEAD^ &&
-	echo nine > content &&
-	git commit -q -a -m nine &&
-
-	git checkout -q -b branches/new_branch master &&
-	echo ten > content &&
-	git commit -q -a -m ten
-	)
-}
-
-test_expect_success 'remote big push' '
-	test_when_finished "rm -rf hgrepo gitrepo*" &&
-
-	setup_big_push
-
-	(
-	cd gitrepo &&
-
-	check_push 1 --all <<-EOF
-	master
-	good_bmark
-	branches/good_branch
-	new_bmark:new
-	branches/new_branch:new
-	bad_bmark1:non-fast-forward
-	bad_bmark2:non-fast-forward
-	branches/bad_branch:non-fast-forward
-	EOF
-	) &&
-
-	check_branch hgrepo default one &&
-	check_branch hgrepo good_branch "good branch" &&
-	check_branch hgrepo bad_branch "bad branch" &&
-	check_branch hgrepo new_branch '' &&
-	check_bookmark hgrepo good_bmark one &&
-	check_bookmark hgrepo bad_bmark1 one &&
-	check_bookmark hgrepo bad_bmark2 one &&
-	check_bookmark hgrepo new_bmark ''
-'
-
-test_expect_success 'remote big push fetch first' '
-	test_when_finished "rm -rf hgrepo gitrepo*" &&
-
-	(
-	hg init hgrepo &&
-	cd hgrepo &&
-	echo zero > content &&
-	hg add content &&
-	hg commit -m zero &&
-	hg bookmark bad_bmark &&
-	hg bookmark good_bmark &&
-	hg bookmark -i good_bmark &&
-	hg -q branch good_branch &&
-	echo "good branch" > content &&
-	hg commit -m "good branch" &&
-	hg -q branch bad_branch &&
-	echo "bad branch" > content &&
-	hg commit -m "bad branch"
-	) &&
-
-	git clone "hg::hgrepo" gitrepo &&
-
-	(
-	cd hgrepo &&
-	hg bookmark -f bad_bmark &&
-	echo update_bmark > content &&
-	hg commit -m "update bmark"
-	) &&
-
-	(
-	cd gitrepo &&
-	echo two > content &&
-	git commit -q -a -m two &&
-
-	git checkout -q good_bmark &&
-	echo three > content &&
-	git commit -q -a -m three &&
-
-	git checkout -q bad_bmark &&
-	echo four > content &&
-	git commit -q -a -m four &&
-
-	git checkout -q branches/bad_branch &&
-	echo five > content &&
-	git commit -q -a -m five &&
-
-	check_push 1 --all <<-EOF
-	master
-	good_bmark
-	new_bmark:new
-	new_branch:new
-	bad_bmark:fetch-first
-	branches/bad_branch:festch-first
-	EOF
-
-	git fetch &&
-
-	check_push 1 --all <<-EOF
-	master
-	good_bmark
-	bad_bmark:non-fast-forward
-	branches/bad_branch:non-fast-forward
-	EOF
-	)
-'
-
-test_expect_failure 'remote big push force' '
-	test_when_finished "rm -rf hgrepo gitrepo*" &&
-
-	setup_big_push
-
-	(
-	cd gitrepo &&
-
-	check_push 0 --force --all <<-EOF
-	master
-	good_bmark
-	branches/good_branch
-	new_bmark:new
-	branches/new_branch:new
-	bad_bmark1:forced-update
-	bad_bmark2:forced-update
-	branches/bad_branch:forced-update
-	EOF
-	) &&
-
-	check_branch hgrepo default six &&
-	check_branch hgrepo good_branch eight &&
-	check_branch hgrepo bad_branch nine &&
-	check_branch hgrepo new_branch ten &&
-	check_bookmark hgrepo good_bmark three &&
-	check_bookmark hgrepo bad_bmark1 four &&
-	check_bookmark hgrepo bad_bmark2 five &&
-	check_bookmark hgrepo new_bmark six
-'
-
-test_expect_failure 'remote big push dry-run' '
-	test_when_finished "rm -rf hgrepo gitrepo*" &&
-
-	setup_big_push
-
-	(
-	cd gitrepo &&
-
-	check_push 0 --dry-run --all <<-EOF
-	master
-	good_bmark
-	branches/good_branch
-	new_bmark:new
-	branches/new_branch:new
-	bad_bmark1:non-fast-forward
-	bad_bmark2:non-fast-forward
-	branches/bad_branch:non-fast-forward
-	EOF
-
-	check_push 0 --dry-run master good_bmark new_bmark branches/good_bran=
ch branches/new_branch <<-EOF
-	master
-	good_bmark
-	branches/good_branch
-	new_bmark:new
-	branches/new_branch:new
-	EOF
-	) &&
-
-	check_branch hgrepo default one &&
-	check_branch hgrepo good_branch "good branch" &&
-	check_branch hgrepo bad_branch "bad branch" &&
-	check_branch hgrepo new_branch '' &&
-	check_bookmark hgrepo good_bmark one &&
-	check_bookmark hgrepo bad_bmark1 one &&
-	check_bookmark hgrepo bad_bmark2 one &&
-	check_bookmark hgrepo new_bmark ''
-'
-
-test_expect_success 'remote double failed push' '
-	test_when_finished "rm -rf hgrepo gitrepo*" &&
-
-	(
-	hg init hgrepo &&
-	cd hgrepo &&
-	echo zero > content &&
-	hg add content &&
-	hg commit -m zero &&
-	echo one > content &&
-	hg commit -m one
-	) &&
-
-	(
-	git clone "hg::hgrepo" gitrepo &&
-	cd gitrepo &&
-	git reset --hard HEAD^ &&
-	echo two > content &&
-	git commit -a -m two &&
-	test_expect_code 1 git push &&
-	test_expect_code 1 git push
-	)
-'
-
-test_done
diff --git a/contrib/remote-helpers/test-hg.t b/contrib/remote-helpers/=
test-hg.t
new file mode 100755
index 0000000..30f4ff6
--- /dev/null
+++ b/contrib/remote-helpers/test-hg.t
@@ -0,0 +1,692 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+# Base commands from hg-git tests:
+# https://bitbucket.org/durin42/hg-git/src
+#
+
+test_description=3D'Test remote-hg'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	skip_all=3D'skipping remote-hg tests; python not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import mercurial'; then
+	skip_all=3D'skipping remote-hg tests; mercurial not available'
+	test_done
+fi
+
+check () {
+	echo $3 > expected &&
+	git --git-dir=3D$1/.git log --format=3D'%s' -1 $2 > actual
+	test_cmp expected actual
+}
+
+check_branch () {
+	if [ -n "$3" ]; then
+		echo $3 > expected &&
+		hg -R $1 log -r $2 --template '{desc}\n' > actual &&
+		test_cmp expected actual
+	else
+		hg -R $1 branches > out &&
+		! grep $2 out
+	fi
+}
+
+check_bookmark () {
+	if [ -n "$3" ]; then
+		echo $3 > expected &&
+		hg -R $1 log -r "bookmark('$2')" --template '{desc}\n' > actual &&
+		test_cmp expected actual
+	else
+		hg -R $1 bookmarks > out &&
+		! grep $2 out
+	fi
+}
+
+check_push () {
+	local expected_ret=3D$1 ret=3D0 ref_ret=3D0 IFS=3D':'
+
+	shift
+	git push origin "$@" 2> error
+	ret=3D$?
+	cat error
+
+	while read branch kind
+	do
+		case "$kind" in
+		'new')
+			grep "^ \* \[new branch\] *${branch} -> ${branch}$" error || ref_re=
t=3D1
+			;;
+		'non-fast-forward')
+			grep "^ ! \[rejected\] *${branch} -> ${branch} (non-fast-forward)$"=
 error || ref_ret=3D1
+			;;
+		'fetch-first')
+			grep "^ ! \[rejected\] *${branch} -> ${branch} (fetch first)$" erro=
r || ref_ret=3D1
+			;;
+		'forced-update')
+			grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *${branch} -> ${branch} (forced =
update)$" error || ref_ret=3D1
+			;;
+		'')
+			grep "^   [a-f0-9]*\.\.[a-f0-9]* *${branch} -> ${branch}$" error ||=
 ref_ret=3D1
+			;;
+		esac
+		let 'ref_ret' && echo "match for '$branch' failed" && break
+	done
+
+	if let 'expected_ret !=3D ret || ref_ret'
+	then
+		return 1
+	fi
+
+	return 0
+}
+
+setup () {
+	(
+	echo "[ui]"
+	echo "username =3D H G Wells <wells@example.com>"
+	echo "[extensions]"
+	echo "mq =3D"
+	) >> "$HOME"/.hgrc &&
+
+	GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230" &&
+	GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE" &&
+	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+}
+
+setup
+
+test_expect_success 'cloning' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check gitrepo HEAD zero
+'
+
+test_expect_success 'cloning with branches' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	cd hgrepo &&
+	hg branch next &&
+	echo next > content &&
+	hg commit -m next
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check gitrepo origin/branches/next next
+'
+
+test_expect_success 'cloning with bookmarks' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	cd hgrepo &&
+	hg checkout default &&
+	hg bookmark feature-a &&
+	echo feature-a > content &&
+	hg commit -m feature-a
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check gitrepo origin/feature-a feature-a
+'
+
+test_expect_success 'update bookmark' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	cd hgrepo &&
+	hg bookmark devel
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet devel &&
+	echo devel > content &&
+	git commit -a -m devel &&
+	git push --quiet
+	) &&
+
+	check_bookmark hgrepo devel devel
+'
+
+test_expect_success 'new bookmark' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet -b feature-b &&
+	echo feature-b > content &&
+	git commit -a -m feature-b &&
+	git push --quiet origin feature-b
+	) &&
+
+	check_bookmark hgrepo feature-b feature-b
+'
+
+# cleanup previous stuff
+rm -rf hgrepo
+
+author_test () {
+	echo $1 >> content &&
+	hg commit -u "$2" -m "add $1" &&
+	echo "$3" >> ../expected
+}
+
+test_expect_success 'authors' '
+	test_when_finished "rm -rf hgrepo gitrepo" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+
+	touch content &&
+	hg add content &&
+
+	> ../expected &&
+	author_test alpha "" "H G Wells <wells@example.com>" &&
+	author_test beta "test" "test <unknown>" &&
+	author_test beta "test <test@example.com> (comment)" "test <test@exam=
ple.com>" &&
+	author_test gamma "<test@example.com>" "Unknown <test@example.com>" &=
&
+	author_test delta "name<test@example.com>" "name <test@example.com>" =
&&
+	author_test epsilon "name <test@example.com" "name <test@example.com>=
" &&
+	author_test zeta " test " "test <unknown>" &&
+	author_test eta "test < test@example.com >" "test <test@example.com>"=
 &&
+	author_test theta "test >test@example.com>" "test <test@example.com>"=
 &&
+	author_test iota "test < test <at> example <dot> com>" "test <unknown=
>" &&
+	author_test kappa "test@example.com" "Unknown <test@example.com>"
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	git --git-dir=3Dgitrepo/.git log --reverse --format=3D"%an <%ae>" > a=
ctual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'strip' '
+	test_when_finished "rm -rf hgrepo gitrepo" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+
+	echo one >> content &&
+	hg add content &&
+	hg commit -m one &&
+
+	echo two >> content &&
+	hg commit -m two
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd hgrepo &&
+	hg strip 1 &&
+
+	echo three >> content &&
+	hg commit -m three &&
+
+	echo four >> content &&
+	hg commit -m four
+	) &&
+
+	(
+	cd gitrepo &&
+	git fetch &&
+	git log --format=3D"%s" origin/master > ../actual
+	) &&
+
+	hg -R hgrepo log --template "{desc}\n" > expected &&
+	test_cmp actual expected
+'
+
+test_expect_success 'remote push with master bookmark' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero &&
+	hg bookmark master &&
+	echo one > content &&
+	hg commit -m one
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	echo two > content &&
+	git commit -a -m two &&
+	git push
+	) &&
+
+	check_branch hgrepo default two
+'
+
+cat > expected <<EOF
+changeset:   0:6e2126489d3d
+tag:         tip
+user:        A U Thor <author@example.com>
+date:        Mon Jan 01 00:00:00 2007 +0230
+summary:     one
+
+EOF
+
+test_expect_success 'remote push from master branch' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	hg init hgrepo &&
+
+	(
+	git init gitrepo &&
+	cd gitrepo &&
+	git remote add origin "hg::../hgrepo" &&
+	echo one > content &&
+	git add content &&
+	git commit -a -m one &&
+	git push origin master
+	) &&
+
+	hg -R hgrepo log > actual &&
+	cat actual &&
+	test_cmp expected actual &&
+
+	check_branch hgrepo default one
+'
+
+GIT_REMOTE_HG_TEST_REMOTE=3D1
+export GIT_REMOTE_HG_TEST_REMOTE
+
+test_expect_success 'remote cloning' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check gitrepo HEAD zero
+'
+
+test_expect_success 'remote update bookmark' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	cd hgrepo &&
+	hg bookmark devel
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet devel &&
+	echo devel > content &&
+	git commit -a -m devel &&
+	git push --quiet
+	) &&
+
+	check_bookmark hgrepo devel devel
+'
+
+test_expect_success 'remote new bookmark' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet -b feature-b &&
+	echo feature-b > content &&
+	git commit -a -m feature-b &&
+	git push --quiet origin feature-b
+	) &&
+
+	check_bookmark hgrepo feature-b feature-b
+'
+
+test_expect_success 'remote push diverged' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd hgrepo &&
+	hg checkout default &&
+	echo bump > content &&
+	hg commit -m bump
+	) &&
+
+	(
+	cd gitrepo &&
+	echo diverge > content &&
+	git commit -a -m diverged &&
+	check_push 1 <<-EOF
+	master:non-fast-forward
+	EOF
+	) &&
+
+	check_branch hgrepo default bump
+'
+
+test_expect_success 'remote update bookmark diverge' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	cd hgrepo &&
+	hg checkout tip^ &&
+	hg bookmark diverge
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd hgrepo &&
+	echo "bump bookmark" > content &&
+	hg commit -m "bump bookmark"
+	) &&
+
+	(
+	cd gitrepo &&
+	git checkout --quiet diverge &&
+	echo diverge > content &&
+	git commit -a -m diverge &&
+	check_push 1 <<-EOF
+	diverge:fetch-first
+	EOF
+	) &&
+
+	check_bookmark hgrepo diverge "bump bookmark"
+'
+
+test_expect_success 'remote new bookmark multiple branch head' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet -b feature-c HEAD^ &&
+	echo feature-c > content &&
+	git commit -a -m feature-c &&
+	git push --quiet origin feature-c
+	) &&
+
+	check_bookmark hgrepo feature-c feature-c
+'
+
+# cleanup previous stuff
+rm -rf hgrepo
+
+setup_big_push () {
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero &&
+	hg bookmark bad_bmark1 &&
+	echo one > content &&
+	hg commit -m one &&
+	hg bookmark bad_bmark2 &&
+	hg bookmark good_bmark &&
+	hg bookmark -i good_bmark &&
+	hg -q branch good_branch &&
+	echo "good branch" > content &&
+	hg commit -m "good branch" &&
+	hg -q branch bad_branch &&
+	echo "bad branch" > content &&
+	hg commit -m "bad branch"
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd gitrepo &&
+	echo two > content &&
+	git commit -q -a -m two &&
+
+	git checkout -q good_bmark &&
+	echo three > content &&
+	git commit -q -a -m three &&
+
+	git checkout -q bad_bmark1 &&
+	git reset --hard HEAD^ &&
+	echo four > content &&
+	git commit -q -a -m four &&
+
+	git checkout -q bad_bmark2 &&
+	git reset --hard HEAD^ &&
+	echo five > content &&
+	git commit -q -a -m five &&
+
+	git checkout -q -b new_bmark master &&
+	echo six > content &&
+	git commit -q -a -m six &&
+
+	git checkout -q branches/good_branch &&
+	echo seven > content &&
+	git commit -q -a -m seven &&
+	echo eight > content &&
+	git commit -q -a -m eight &&
+
+	git checkout -q branches/bad_branch &&
+	git reset --hard HEAD^ &&
+	echo nine > content &&
+	git commit -q -a -m nine &&
+
+	git checkout -q -b branches/new_branch master &&
+	echo ten > content &&
+	git commit -q -a -m ten
+	)
+}
+
+test_expect_success 'remote big push' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	setup_big_push
+
+	(
+	cd gitrepo &&
+
+	check_push 1 --all <<-EOF
+	master
+	good_bmark
+	branches/good_branch
+	new_bmark:new
+	branches/new_branch:new
+	bad_bmark1:non-fast-forward
+	bad_bmark2:non-fast-forward
+	branches/bad_branch:non-fast-forward
+	EOF
+	) &&
+
+	check_branch hgrepo default one &&
+	check_branch hgrepo good_branch "good branch" &&
+	check_branch hgrepo bad_branch "bad branch" &&
+	check_branch hgrepo new_branch '' &&
+	check_bookmark hgrepo good_bmark one &&
+	check_bookmark hgrepo bad_bmark1 one &&
+	check_bookmark hgrepo bad_bmark2 one &&
+	check_bookmark hgrepo new_bmark ''
+'
+
+test_expect_success 'remote big push fetch first' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero &&
+	hg bookmark bad_bmark &&
+	hg bookmark good_bmark &&
+	hg bookmark -i good_bmark &&
+	hg -q branch good_branch &&
+	echo "good branch" > content &&
+	hg commit -m "good branch" &&
+	hg -q branch bad_branch &&
+	echo "bad branch" > content &&
+	hg commit -m "bad branch"
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd hgrepo &&
+	hg bookmark -f bad_bmark &&
+	echo update_bmark > content &&
+	hg commit -m "update bmark"
+	) &&
+
+	(
+	cd gitrepo &&
+	echo two > content &&
+	git commit -q -a -m two &&
+
+	git checkout -q good_bmark &&
+	echo three > content &&
+	git commit -q -a -m three &&
+
+	git checkout -q bad_bmark &&
+	echo four > content &&
+	git commit -q -a -m four &&
+
+	git checkout -q branches/bad_branch &&
+	echo five > content &&
+	git commit -q -a -m five &&
+
+	check_push 1 --all <<-EOF
+	master
+	good_bmark
+	new_bmark:new
+	new_branch:new
+	bad_bmark:fetch-first
+	branches/bad_branch:festch-first
+	EOF
+
+	git fetch &&
+
+	check_push 1 --all <<-EOF
+	master
+	good_bmark
+	bad_bmark:non-fast-forward
+	branches/bad_branch:non-fast-forward
+	EOF
+	)
+'
+
+test_expect_failure 'remote big push force' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	setup_big_push
+
+	(
+	cd gitrepo &&
+
+	check_push 0 --force --all <<-EOF
+	master
+	good_bmark
+	branches/good_branch
+	new_bmark:new
+	branches/new_branch:new
+	bad_bmark1:forced-update
+	bad_bmark2:forced-update
+	branches/bad_branch:forced-update
+	EOF
+	) &&
+
+	check_branch hgrepo default six &&
+	check_branch hgrepo good_branch eight &&
+	check_branch hgrepo bad_branch nine &&
+	check_branch hgrepo new_branch ten &&
+	check_bookmark hgrepo good_bmark three &&
+	check_bookmark hgrepo bad_bmark1 four &&
+	check_bookmark hgrepo bad_bmark2 five &&
+	check_bookmark hgrepo new_bmark six
+'
+
+test_expect_failure 'remote big push dry-run' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	setup_big_push
+
+	(
+	cd gitrepo &&
+
+	check_push 0 --dry-run --all <<-EOF
+	master
+	good_bmark
+	branches/good_branch
+	new_bmark:new
+	branches/new_branch:new
+	bad_bmark1:non-fast-forward
+	bad_bmark2:non-fast-forward
+	branches/bad_branch:non-fast-forward
+	EOF
+
+	check_push 0 --dry-run master good_bmark new_bmark branches/good_bran=
ch branches/new_branch <<-EOF
+	master
+	good_bmark
+	branches/good_branch
+	new_bmark:new
+	branches/new_branch:new
+	EOF
+	) &&
+
+	check_branch hgrepo default one &&
+	check_branch hgrepo good_branch "good branch" &&
+	check_branch hgrepo bad_branch "bad branch" &&
+	check_branch hgrepo new_branch '' &&
+	check_bookmark hgrepo good_bmark one &&
+	check_bookmark hgrepo bad_bmark1 one &&
+	check_bookmark hgrepo bad_bmark2 one &&
+	check_bookmark hgrepo new_bmark ''
+'
+
+test_expect_success 'remote double failed push' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero &&
+	echo one > content &&
+	hg commit -m one
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git reset --hard HEAD^ &&
+	echo two > content &&
+	git commit -a -m two &&
+	test_expect_code 1 git push &&
+	test_expect_code 1 git push
+	)
+'
+
+test_done
--=20
1.8.4-fc
