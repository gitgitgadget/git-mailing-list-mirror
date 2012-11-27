From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/4] t4041 (diff-submodule-option): modernize style
Date: Tue, 27 Nov 2012 14:11:31 +0530
Message-ID: <1354005692-2809-4-git-send-email-artagnon@gmail.com>
References: <1354005692-2809-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 09:42:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdGkR-0008CY-SD
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 09:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098Ab2K0Ilw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 03:41:52 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35808 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758390Ab2K0Ils (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 03:41:48 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so8717032pbc.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 00:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5X5jtg510LoRQc5O+qVOX/lZjF622hx4bmNtBzx32Hg=;
        b=MrdZV7nBrwY5OIXRWCn8cVpNZRYB74LqDi6pCflQydh9eGxUl3s3auySdaLrF/Eng/
         0sHRUvviPCTitnVsumipFJxYiHUkzOBRRha0BJwXaOXHvp2+DqLpavqezmWGcdkLi59P
         rhrNcseGSE20wQGikpPJ8UcM0gz8eKIwqLLKDCIvSakRzdnc03TXxFGR3LdO4Wgn1s2r
         HBKxNtf5DdooMRgewKn4jJH2/otla0UhBNu54wNt7F+odFQ6wSopbLa78YxYLKLURrOZ
         muwGVyx/z6QXFJEEj/TUJNIspeMgwL49v5yAYSWRdj/jw2pve1GcXHPEC5ukkMwepgn6
         Paew==
Received: by 10.66.72.71 with SMTP id b7mr40540073pav.28.1354005707985;
        Tue, 27 Nov 2012 00:41:47 -0800 (PST)
Received: from localhost.localdomain ([49.206.179.73])
        by mx.google.com with ESMTPS id vi9sm10284793pbc.41.2012.11.27.00.41.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 00:41:47 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1354005692-2809-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210548>

- Enclose tests in single quotes as opposed to double quotes.  This is
  the prevalent style in other tests.
- Remove the unused variable $head4_full.
- Indent the expected output so that it lines up with the rest of the
  test text.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t4041-diff-submodule-option.sh |  459 +++++++++++++++++++-------------------
 1 files changed, 229 insertions(+), 230 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 103c690..f61c664 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -32,41 +32,41 @@ add_file . foo >/dev/null
 head1=$(add_file sm1 foo1 foo2)
 fullhead1=$(cd sm1; git rev-parse --verify $head1)
 
-test_expect_success 'added submodule' "
+test_expect_success 'added submodule' '
 	git add sm1 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 0000000...$head1 (new submodule)
-EOF
+	Submodule sm1 0000000...$head1 (new submodule)
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'added submodule, set diff.submodule' "
+test_expect_success 'added submodule, set diff.submodule' '
 	git config diff.submodule log &&
 	git add sm1 &&
 	git diff --cached >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 0000000...$head1 (new submodule)
-EOF
+	Submodule sm1 0000000...$head1 (new submodule)
+	EOF
 	git config --unset diff.submodule &&
 	test_cmp expected actual
-"
+'
 
-test_expect_success '--submodule=short overrides diff.submodule' "
+test_expect_success '--submodule=short overrides diff.submodule' '
 	test_config diff.submodule log &&
 	git add sm1 &&
 	git diff --submodule=short --cached >actual &&
 	cat >expected <<-EOF &&
-diff --git a/sm1 b/sm1
-new file mode 160000
-index 0000000..$head1
---- /dev/null
-+++ b/sm1
-@@ -0,0 +1 @@
-+Subproject commit $fullhead1
-EOF
+	diff --git a/sm1 b/sm1
+	new file mode 160000
+	index 0000000..$head1
+	--- /dev/null
+	+++ b/sm1
+	@@ -0,0 +1 @@
+	+Subproject commit $fullhead1
+	EOF
 	test_cmp expected actual
-"
+'
 
 test_expect_success 'diff.submodule does not affect plumbing' '
 	test_config diff.submodule log &&
@@ -86,47 +86,47 @@ test_expect_success 'diff.submodule does not affect plumbing' '
 commit_file sm1 &&
 head2=$(add_file sm1 foo3)
 
-test_expect_success 'modified submodule(forward)' "
+test_expect_success 'modified submodule(forward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head1..$head2:
-  > Add foo3
-EOF
+	Submodule sm1 $head1..$head2:
+	  > Add foo3
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'modified submodule(forward)' "
+test_expect_success 'modified submodule(forward)' '
 	git diff --submodule=log >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head1..$head2:
-  > Add foo3
-EOF
+	Submodule sm1 $head1..$head2:
+	  > Add foo3
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'modified submodule(forward) --submodule' "
+test_expect_success 'modified submodule(forward) --submodule' '
 	git diff --submodule >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head1..$head2:
-  > Add foo3
-EOF
+	Submodule sm1 $head1..$head2:
+	  > Add foo3
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'modified submodule(forward) --submodule=short' "
 fullhead2=$(cd sm1; git rev-parse --verify $head2)
+test_expect_success 'modified submodule(forward) --submodule=short' '
 	git diff --submodule=short >actual &&
 	cat >expected <<-EOF &&
-diff --git a/sm1 b/sm1
-index $head1..$head2 160000
---- a/sm1
-+++ b/sm1
-@@ -1 +1 @@
--Subproject commit $fullhead1
-+Subproject commit $fullhead2
-EOF
+	diff --git a/sm1 b/sm1
+	index $head1..$head2 160000
+	--- a/sm1
+	+++ b/sm1
+	@@ -1 +1 @@
+	-Subproject commit $fullhead1
+	+Subproject commit $fullhead2
+	EOF
 	test_cmp expected actual
-"
+'
 
 commit_file sm1 &&
 head3=$(
@@ -135,29 +135,28 @@ head3=$(
 	git rev-parse --short --verify HEAD
 )
 
-test_expect_success 'modified submodule(backward)' "
+test_expect_success 'modified submodule(backward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head2..$head3 (rewind):
-  < Add foo3
-  < Add foo2
-EOF
+	Submodule sm1 $head2..$head3 (rewind):
+	  < Add foo3
+	  < Add foo2
+	EOF
 	test_cmp expected actual
-"
+'
 
-head4=$(add_file sm1 foo4 foo5) &&
-head4_full=$(GIT_DIR=sm1/.git git rev-parse --verify HEAD)
-test_expect_success 'modified submodule(backward and forward)' "
+head4=$(add_file sm1 foo4 foo5)
+test_expect_success 'modified submodule(backward and forward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head2...$head4:
-  > Add foo5
-  > Add foo4
-  < Add foo3
-  < Add foo2
-EOF
+	Submodule sm1 $head2...$head4:
+	  > Add foo5
+	  > Add foo4
+	  < Add foo3
+	  < Add foo2
+	EOF
 	test_cmp expected actual
-"
+'
 
 commit_file sm1 &&
 mv sm1 sm1-bak &&
@@ -167,319 +166,319 @@ git add sm1 &&
 rm -f sm1 &&
 mv sm1-bak sm1
 
-test_expect_success 'typechanged submodule(submodule->blob), --cached' "
+test_expect_success 'typechanged submodule(submodule->blob), --cached' '
 	git diff --submodule=log --cached >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head4...0000000 (submodule deleted)
-diff --git a/sm1 b/sm1
-new file mode 100644
-index 0000000..$head5
---- /dev/null
-+++ b/sm1
-@@ -0,0 +1 @@
-+sm1
-EOF
+	Submodule sm1 $head4...0000000 (submodule deleted)
+	diff --git a/sm1 b/sm1
+	new file mode 100644
+	index 0000000..$head5
+	--- /dev/null
+	+++ b/sm1
+	@@ -0,0 +1 @@
+	+sm1
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'typechanged submodule(submodule->blob)' "
+test_expect_success 'typechanged submodule(submodule->blob)' '
 	git diff --submodule=log >actual &&
 	cat >expected <<-EOF &&
-diff --git a/sm1 b/sm1
-deleted file mode 100644
-index $head5..0000000
---- a/sm1
-+++ /dev/null
-@@ -1 +0,0 @@
--sm1
-Submodule sm1 0000000...$head4 (new submodule)
-EOF
+	diff --git a/sm1 b/sm1
+	deleted file mode 100644
+	index $head5..0000000
+	--- a/sm1
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-sm1
+	Submodule sm1 0000000...$head4 (new submodule)
+	EOF
 	test_cmp expected actual
-"
+'
 
 rm -rf sm1 &&
 git checkout-index sm1
-test_expect_success 'typechanged submodule(submodule->blob)' "
+test_expect_success 'typechanged submodule(submodule->blob)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head4...0000000 (submodule deleted)
-diff --git a/sm1 b/sm1
-new file mode 100644
-index 0000000..$head5
---- /dev/null
-+++ b/sm1
-@@ -0,0 +1 @@
-+sm1
-EOF
+	Submodule sm1 $head4...0000000 (submodule deleted)
+	diff --git a/sm1 b/sm1
+	new file mode 100644
+	index 0000000..$head5
+	--- /dev/null
+	+++ b/sm1
+	@@ -0,0 +1 @@
+	+sm1
+	EOF
 	test_cmp expected actual
-"
+'
 
 rm -f sm1 &&
 test_create_repo sm1 &&
 head6=$(add_file sm1 foo6 foo7)
-test_expect_success 'nonexistent commit' "
 fullhead6=$(cd sm1; git rev-parse --verify $head6)
+test_expect_success 'nonexistent commit' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head4...$head6 (commits not present)
-EOF
+	Submodule sm1 $head4...$head6 (commits not present)
+	EOF
 	test_cmp expected actual
-"
+'
 
 commit_file
-test_expect_success 'typechanged submodule(blob->submodule)' "
+test_expect_success 'typechanged submodule(blob->submodule)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-diff --git a/sm1 b/sm1
-deleted file mode 100644
-index $head5..0000000
---- a/sm1
-+++ /dev/null
-@@ -1 +0,0 @@
--sm1
-Submodule sm1 0000000...$head6 (new submodule)
-EOF
+	diff --git a/sm1 b/sm1
+	deleted file mode 100644
+	index $head5..0000000
+	--- a/sm1
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-sm1
+	Submodule sm1 0000000...$head6 (new submodule)
+	EOF
 	test_cmp expected actual
-"
+'
 
 commit_file sm1 &&
-test_expect_success 'submodule is up to date' "
+test_expect_success 'submodule is up to date' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-EOF
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'submodule contains untracked content' "
+test_expect_success 'submodule contains untracked content' '
 	echo new > sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 contains untracked content
-EOF
+	Submodule sm1 contains untracked content
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'submodule contains untracked content (untracked ignored)' "
+test_expect_success 'submodule contains untracked content (untracked ignored)' '
 	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
 	! test -s actual
-"
+'
 
-test_expect_success 'submodule contains untracked content (dirty ignored)' "
+test_expect_success 'submodule contains untracked content (dirty ignored)' '
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
 	! test -s actual
-"
+'
 
-test_expect_success 'submodule contains untracked content (all ignored)' "
+test_expect_success 'submodule contains untracked content (all ignored)' '
 	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
 	! test -s actual
-"
+'
 
-test_expect_success 'submodule contains untracked and modifed content' "
+test_expect_success 'submodule contains untracked and modifed content' '
 	echo new > sm1/foo6 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 contains untracked content
-Submodule sm1 contains modified content
-EOF
+	Submodule sm1 contains untracked content
+	Submodule sm1 contains modified content
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'submodule contains untracked and modifed content (untracked ignored)' "
+test_expect_success 'submodule contains untracked and modifed content (untracked ignored)' '
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 contains modified content
-EOF
+	Submodule sm1 contains modified content
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'submodule contains untracked and modifed content (dirty ignored)' "
+test_expect_success 'submodule contains untracked and modifed content (dirty ignored)' '
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
 	! test -s actual
-"
+'
 
-test_expect_success 'submodule contains untracked and modifed content (all ignored)' "
+test_expect_success 'submodule contains untracked and modifed content (all ignored)' '
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
 	! test -s actual
-"
+'
 
-test_expect_success 'submodule contains modifed content' "
+test_expect_success 'submodule contains modifed content' '
 	rm -f sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 contains modified content
-EOF
+	Submodule sm1 contains modified content
+	EOF
 	test_cmp expected actual
-"
+'
 
 (cd sm1; git commit -mchange foo6 >/dev/null) &&
-test_expect_success 'submodule is modified' "
 head8=$(cd sm1; git rev-parse --short --verify HEAD) &&
+test_expect_success 'submodule is modified' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head6..$head8:
-  > change
-EOF
+	Submodule sm1 $head6..$head8:
+	  > change
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'modified submodule contains untracked content' "
+test_expect_success 'modified submodule contains untracked content' '
 	echo new > sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 contains untracked content
-Submodule sm1 $head6..$head8:
-  > change
-EOF
+	Submodule sm1 contains untracked content
+	Submodule sm1 $head6..$head8:
+	  > change
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'modified submodule contains untracked content (untracked ignored)' "
+test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
 	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head6..$head8:
-  > change
-EOF
+	Submodule sm1 $head6..$head8:
+	  > change
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'modified submodule contains untracked content (dirty ignored)' "
+test_expect_success 'modified submodule contains untracked content (dirty ignored)' '
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head6..$head8:
-  > change
-EOF
+	Submodule sm1 $head6..$head8:
+	  > change
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'modified submodule contains untracked content (all ignored)' "
+test_expect_success 'modified submodule contains untracked content (all ignored)' '
 	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
 	! test -s actual
-"
+'
 
-test_expect_success 'modified submodule contains untracked and modifed content' "
+test_expect_success 'modified submodule contains untracked and modifed content' '
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 contains untracked content
-Submodule sm1 contains modified content
-Submodule sm1 $head6..$head8:
-  > change
-EOF
+	Submodule sm1 contains untracked content
+	Submodule sm1 contains modified content
+	Submodule sm1 $head6..$head8:
+	  > change
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'modified submodule contains untracked and modifed content (untracked ignored)' "
+test_expect_success 'modified submodule contains untracked and modifed content (untracked ignored)' '
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 contains modified content
-Submodule sm1 $head6..$head8:
-  > change
-EOF
+	Submodule sm1 contains modified content
+	Submodule sm1 $head6..$head8:
+	  > change
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'modified submodule contains untracked and modifed content (dirty ignored)' "
+test_expect_success 'modified submodule contains untracked and modifed content (dirty ignored)' '
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head6..$head8:
-  > change
-EOF
+	Submodule sm1 $head6..$head8:
+	  > change
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'modified submodule contains untracked and modifed content (all ignored)' "
+test_expect_success 'modified submodule contains untracked and modifed content (all ignored)' '
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
 	! test -s actual
-"
+'
 
-test_expect_success 'modified submodule contains modifed content' "
+test_expect_success 'modified submodule contains modifed content' '
 	rm -f sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 contains modified content
-Submodule sm1 $head6..$head8:
-  > change
-EOF
+	Submodule sm1 contains modified content
+	Submodule sm1 $head6..$head8:
+	  > change
+	EOF
 	test_cmp expected actual
-"
+'
 
 rm -rf sm1
-test_expect_success 'deleted submodule' "
+test_expect_success 'deleted submodule' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head6...0000000 (submodule deleted)
-EOF
+	Submodule sm1 $head6...0000000 (submodule deleted)
+	EOF
 	test_cmp expected actual
-"
+'
 
 test_create_repo sm2 &&
 head7=$(add_file sm2 foo8 foo9) &&
 git add sm2
 
-test_expect_success 'multiple submodules' "
+test_expect_success 'multiple submodules' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head6...0000000 (submodule deleted)
-Submodule sm2 0000000...$head7 (new submodule)
-EOF
+	Submodule sm1 $head6...0000000 (submodule deleted)
+	Submodule sm2 0000000...$head7 (new submodule)
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'path filter' "
+test_expect_success 'path filter' '
 	git diff-index -p --submodule=log HEAD sm2 >actual &&
 	cat >expected <<-EOF &&
-Submodule sm2 0000000...$head7 (new submodule)
-EOF
+	Submodule sm2 0000000...$head7 (new submodule)
+	EOF
 	test_cmp expected actual
-"
+'
 
 commit_file sm2
-test_expect_success 'given commit' "
+test_expect_success 'given commit' '
 	git diff-index -p --submodule=log HEAD^ >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head6...0000000 (submodule deleted)
-Submodule sm2 0000000...$head7 (new submodule)
-EOF
+	Submodule sm1 $head6...0000000 (submodule deleted)
+	Submodule sm2 0000000...$head7 (new submodule)
+	EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'given commit --submodule' "
+test_expect_success 'given commit --submodule' '
 	git diff-index -p --submodule HEAD^ >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head6...0000000 (submodule deleted)
-Submodule sm2 0000000...$head7 (new submodule)
-EOF
+	Submodule sm1 $head6...0000000 (submodule deleted)
+	Submodule sm2 0000000...$head7 (new submodule)
+	EOF
 	test_cmp expected actual
-"
+'
 
 fullhead7=$(cd sm2; git rev-parse --verify $head7)
 
-test_expect_success 'given commit --submodule=short' "
+test_expect_success 'given commit --submodule=short' '
 	git diff-index -p --submodule=short HEAD^ >actual &&
 	cat >expected <<-EOF &&
-diff --git a/sm1 b/sm1
-deleted file mode 160000
-index $head6..0000000
---- a/sm1
-+++ /dev/null
-@@ -1 +0,0 @@
--Subproject commit $fullhead6
-diff --git a/sm2 b/sm2
-new file mode 160000
-index 0000000..$head7
---- /dev/null
-+++ b/sm2
-@@ -0,0 +1 @@
-+Subproject commit $fullhead7
-EOF
-	test_cmp expected actual
-"
+	diff --git a/sm1 b/sm1
+	deleted file mode 160000
+	index $head6..0000000
+	--- a/sm1
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-Subproject commit $fullhead6
+	diff --git a/sm2 b/sm2
+	new file mode 160000
+	index 0000000..$head7
+	--- /dev/null
+	+++ b/sm2
+	@@ -0,0 +1 @@
+	+Subproject commit $fullhead7
+	EOF
+	test_cmp expected actual
+'
 
 test_expect_success 'setup .git file for sm2' '
 	(cd sm2 &&
@@ -491,9 +490,9 @@ test_expect_success 'setup .git file for sm2' '
 test_expect_success 'diff --submodule with .git file' '
 	git diff --submodule HEAD^ >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head6...0000000 (submodule deleted)
-Submodule sm2 0000000...$head7 (new submodule)
-EOF
+	Submodule sm1 $head6...0000000 (submodule deleted)
+	Submodule sm2 0000000...$head7 (new submodule)
+	EOF
 	test_cmp expected actual
 '
 
-- 
1.7.8.1.362.g5d6df.dirty
