From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH en/cascade-tests] tests: add missing &&
Date: Sat, 30 Oct 2010 20:46:54 -0500
Message-ID: <20101031014654.GC29456@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 02:47:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCN0w-00089O-HF
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 02:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673Ab0JaBrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 21:47:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45595 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab0JaBrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 21:47:08 -0400
Received: by gwj21 with SMTP id 21so2631121gwj.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 18:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7OIlAhLrhTkiqyDeEbfAjPzy/DvnJpNQy74gYcraiWI=;
        b=xcXbJzW1Jj4mhfLgG8Y6T5n68HzzCaquC4ca1/vXWDHe1KkD5Tner27jHDvIhGVve6
         v4tTDVkYwA8k6t6ZnqfO3zXjOPSpqJ35UdLdKopHvDzeRsVtU+/RQBu4kr5zEAkkQvhR
         zVzdlu0Y2NBp7ndyjD3bkacfNPAkETjMT7ppA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QKv18s8nYz04v3/6rR6tTNkM3LFdYMcmwHLrRJ1Fq5oaqr6Mx8a2NIsAoUPoHgIx5i
         OaK02F2nf1Eiq2vqGuCFyfZGvSwG2ze6KhaFPEz8IfIAWfrt/4pISynjgw4pwJ2jh5UB
         ss6PGXn6F7j+GJNFRTfdOK7uEjNfK33cE5f1s=
Received: by 10.90.20.6 with SMTP id 6mr6748032agt.200.1288489626646;
        Sat, 30 Oct 2010 18:47:06 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id g3sm1313935yha.2.2010.10.30.18.47.02
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Oct 2010 18:47:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286136014-7728-16-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160408>

Breaks in a test assertion's && chain can potentially hide
failures from earlier commands in the chain.

Commands intended to fail should be marked with !, test_must_fail, or
test_might_fail.  The examples in this patch do not require that.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Just found some time to work through reports from the && checker.
The examples below only add && to the end of lines in various tests.
Passes all tests there (though of course that does not mean much).

Thoughts?

Jonathan

 t/annotate-tests.sh                         |    2 +-
 t/t0003-attributes.sh                       |    2 +-
 t/t0024-crlf-archive.sh                     |    4 ++--
 t/t0026-eol-config.sh                       |    2 +-
 t/t0050-filesystem.sh                       |   12 ++++++------
 t/t1000-read-tree-m-3way.sh                 |    2 +-
 t/t1001-read-tree-m-2way.sh                 |    2 +-
 t/t1011-read-tree-sparse-checkout.sh        |    2 +-
 t/t1200-tutorial.sh                         |    2 +-
 t/t1302-repo-version.sh                     |    2 +-
 t/t1401-symbolic-ref.sh                     |    2 +-
 t/t1402-check-ref-format.sh                 |    4 ++--
 t/t1410-reflog.sh                           |    8 ++++----
 t/t1450-fsck.sh                             |    4 ++--
 t/t2007-checkout-symlink.sh                 |    2 +-
 t/t2016-checkout-patch.sh                   |    2 +-
 t/t2017-checkout-orphan.sh                  |    2 +-
 t/t2050-git-dir-relative.sh                 |    4 ++--
 t/t2101-update-index-reupdate.sh            |    2 +-
 t/t2200-add-update.sh                       |    2 +-
 t/t3001-ls-files-others-exclude.sh          |    2 +-
 t/t3030-merge-recursive.sh                  |    2 +-
 t/t3050-subprojects-fetch.sh                |    4 ++--
 t/t3203-branch-output.sh                    |    6 +++---
 t/t3300-funny-names.sh                      |    8 ++++----
 t/t3307-notes-man.sh                        |    2 +-
 t/t3406-rebase-message.sh                   |    6 +++---
 t/t3408-rebase-multi-line.sh                |    2 +-
 t/t3412-rebase-root.sh                      |    4 ++--
 t/t3415-rebase-autosquash.sh                |    6 +++---
 t/t3417-rebase-whitespace-fix.sh            |    2 +-
 t/t3504-cherry-pick-rerere.sh               |    4 ++--
 t/t3902-quoted.sh                           |    6 +++---
 t/t3903-stash.sh                            |    6 +++---
 t/t3904-stash-patch.sh                      |    2 +-
 t/t4008-diff-break-rewrite.sh               |    2 +-
 t/t4015-diff-whitespace.sh                  |    2 +-
 t/t4021-format-patch-numbered.sh            |    2 +-
 t/t4027-diff-submodule.sh                   |    8 ++++----
 t/t4034-diff-words.sh                       |    4 ++--
 t/t4103-apply-binary.sh                     |    8 ++++----
 t/t4111-apply-subdir.sh                     |    4 ++--
 t/t4119-apply-config.sh                     |    2 +-
 t/t4127-apply-same-fn.sh                    |   18 +++++++++---------
 t/t4130-apply-criss-cross-rename.sh         |    2 +-
 t/t4133-apply-filenames.sh                  |    8 ++++----
 t/t4134-apply-submodule.sh                  |    2 +-
 t/t4150-am.sh                               |    2 +-
 t/t4201-shortlog.sh                         |    2 +-
 t/t4202-log.sh                              |    4 ++--
 t/t4252-am-options.sh                       |    2 +-
 t/t5300-pack-object.sh                      |    2 +-
 t/t5301-sliding-window.sh                   |    4 ++--
 t/t5302-pack-index.sh                       |    2 +-
 t/t5500-fetch-pack.sh                       |    2 +-
 t/t5502-quickfetch.sh                       |    2 +-
 t/t5510-fetch.sh                            |    2 +-
 t/t5514-fetch-multiple.sh                   |    2 +-
 t/t5516-fetch-push.sh                       |    8 ++++----
 t/t5519-push-alternates.sh                  |    2 +-
 t/t5531-deep-submodule-push.sh              |    2 +-
 t/t556x_common                              |   24 ++++++++++++------------
 t/t6001-rev-list-graft.sh                   |    8 ++++----
 t/t6009-rev-list-parent.sh                  |    2 +-
 t/t6010-merge-base.sh                       |    2 +-
 t/t6024-recursive-merge.sh                  |    2 +-
 t/t6029-merge-subtree.sh                    |    2 +-
 t/t6030-bisect-porcelain.sh                 |    8 ++++----
 t/t6036-recursive-corner-cases.sh           |    2 +-
 t/t6040-tracking-info.sh                    |    2 +-
 t/t6050-replace.sh                          |    2 +-
 t/t7105-reset-patch.sh                      |    6 +++---
 t/t7509-commit.sh                           |    2 +-
 t/t7602-merge-octopus-many.sh               |    2 +-
 t/t7610-mergetool.sh                        |    2 +-
 t/t7810-grep.sh                             |    4 ++--
 t/t9104-git-svn-follow-parent.sh            |    2 +-
 t/t9123-git-svn-rebuild-with-rewriteroot.sh |    2 +-
 t/t9124-git-svn-dcommit-auto-props.sh       |    2 +-
 t/t9151-svn-mergeinfo.sh                    |   22 +++++++++++-----------
 t/t9300-fast-import.sh                      |    2 +-
 t/t9350-fast-export.sh                      |    2 +-
 t/t9400-git-cvsserver-server.sh             |    2 +-
 t/t9401-git-cvsserver-crlf.sh               |    2 +-
 84 files changed, 166 insertions(+), 166 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 396b965..35353fa 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -38,7 +38,7 @@ test_expect_success \
     'prepare reference tree' \
     'echo "1A quick brown fox jumps over the" >file &&
      echo "lazy dog" >>file &&
-     git add file
+     git add file &&
      GIT_AUTHOR_NAME="A" git commit -a -m "Initial."'
 
 test_expect_success \
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index de38c7f..7590b45 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -59,7 +59,7 @@ test_expect_success 'attribute test' '
 
 test_expect_success 'attribute test: read paths from stdin' '
 
-	cat <<EOF > expect
+	cat <<EOF > expect &&
 f: test: f
 a/f: test: f
 a/c/f: test: f
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index c7d0324..ec6c1b3 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -7,7 +7,7 @@ UNZIP=${UNZIP:-unzip}
 
 test_expect_success setup '
 
-	git config core.autocrlf true
+	git config core.autocrlf true &&
 
 	printf "CRLF line ending\r\nAnd another\r\n" > sample &&
 	git add sample &&
@@ -20,7 +20,7 @@ test_expect_success setup '
 test_expect_success 'tar archive' '
 
 	git archive --format=tar HEAD |
-	( mkdir untarred && cd untarred && "$TAR" -xf - )
+	( mkdir untarred && cd untarred && "$TAR" -xf - ) &&
 
 	test_cmp sample untarred/sample
 
diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
index f37ac8f..fe0164b 100755
--- a/t/t0026-eol-config.sh
+++ b/t/t0026-eol-config.sh
@@ -12,7 +12,7 @@ test_expect_success setup '
 
 	git config core.autocrlf false &&
 
-	echo "one text" > .gitattributes
+	echo "one text" > .gitattributes &&
 
 	for w in Hello world how are you; do echo $w; done >one &&
 	for w in I am very very fine thank you; do echo $w; done >two &&
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 41df6bc..057c97c 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -12,14 +12,14 @@ unibad=
 no_symlinks=
 test_expect_success 'see what we expect' '
 
-	test_case=test_expect_success
-	test_unicode=test_expect_success
+	test_case=test_expect_success &&
+	test_unicode=test_expect_success &&
 	mkdir junk &&
 	echo good >junk/CamelCase &&
 	echo bad >junk/camelcase &&
 	if test "$(cat junk/CamelCase)" != good
 	then
-		test_case=test_expect_failure
+		test_case=test_expect_failure &&
 		case_insensitive=t
 	fi &&
 	rm -fr junk &&
@@ -27,7 +27,7 @@ test_expect_success 'see what we expect' '
 	>junk/"$auml" &&
 	case "$(cd junk && echo *)" in
 	"$aumlcdiar")
-		test_unicode=test_expect_failure
+		test_unicode=test_expect_failure &&
 		unibad=t
 		;;
 	*)	;;
@@ -36,7 +36,7 @@ test_expect_success 'see what we expect' '
 	{
 		ln -s x y 2> /dev/null &&
 		test -h y 2> /dev/null ||
-		no_symlinks=1
+		no_symlinks=1 &&
 		rm -f y
 	}
 '
@@ -128,7 +128,7 @@ test_expect_success "setup unicode normalization tests" '
   cd unicode &&
   touch "$aumlcdiar" &&
   git add "$aumlcdiar" &&
-  git commit -m initial
+  git commit -m initial &&
   git tag initial &&
   git checkout -b topic &&
   git mv $aumlcdiar tmp &&
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index 4f17172..ca8a409 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -309,7 +309,7 @@ test_expect_success \
 test_expect_success \
     '6 - must not exist in O && !A && !B case' "
      rm -f .git/index DD &&
-     echo DD >DD
+     echo DD >DD &&
      git update-index --add DD &&
      test_must_fail git read-tree -m $tree_O $tree_A $tree_B
 "
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index c28d790..680d992 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -394,7 +394,7 @@ test_expect_success '-m references the correct modified tree' '
 	echo >file-a &&
 	echo >file-b &&
 	git add file-a file-b &&
-	git commit -a -m "test for correct modified tree"
+	git commit -a -m "test for correct modified tree" &&
 	git branch initial-mod &&
 	echo b >file-b &&
 	git commit -a -m "B" &&
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 9a07de1..8cf1515 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -47,7 +47,7 @@ test_expect_success 'read-tree without .git/info/sparse-checkout' '
 '
 
 test_expect_success 'read-tree with .git/info/sparse-checkout but disabled' '
-	echo >.git/info/sparse-checkout
+	echo >.git/info/sparse-checkout &&
 	git read-tree -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt result &&
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index ab55eda..bfa2c21 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -42,7 +42,7 @@ test_expect_success 'git diff' '
 '
 
 test_expect_success 'tree' '
-	tree=$(git write-tree 2>/dev/null)
+	tree=$(git write-tree 2>/dev/null) &&
 	test 8988da15d077d4829fc51d8544c097def6644dbb = $tree
 '
 
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index a6bf1bf..0e47662 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -39,7 +39,7 @@ test_expect_success 'gitdir selection on unsupported repo' '
 	(
 		cd test2 &&
 		git config core.repositoryformatversion >../actual
-	)
+	) &&
 	test_cmp expect actual
 '
 
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 7fa5f5b..2c96551 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -28,7 +28,7 @@ test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
 reset_to_sane
 
 test_expect_success 'symbolic-ref refuses bare sha1' '
-	echo content >file && git add file && git commit -m one
+	echo content >file && git add file && git commit -m one &&
 	test_must_fail git symbolic-ref HEAD `git rev-parse HEAD`
 '
 reset_to_sane
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 782e75d..1b0f82f 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -32,7 +32,7 @@ test_expect_success "check-ref-format --branch @{-1}" '
 	T=$(git write-tree) &&
 	sha1=$(echo A | git commit-tree $T) &&
 	git update-ref refs/heads/master $sha1 &&
-	git update-ref refs/remotes/origin/master $sha1
+	git update-ref refs/remotes/origin/master $sha1 &&
 	git checkout master &&
 	git checkout origin/master &&
 	git checkout master &&
@@ -47,7 +47,7 @@ test_expect_success 'check-ref-format --branch from subdir' '
 	T=$(git write-tree) &&
 	sha1=$(echo A | git commit-tree $T) &&
 	git update-ref refs/heads/master $sha1 &&
-	git update-ref refs/remotes/origin/master $sha1
+	git update-ref refs/remotes/origin/master $sha1 &&
 	git checkout master &&
 	git checkout origin/master &&
 	git checkout master &&
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 25046c4..252fc82 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -186,8 +186,8 @@ test_expect_success 'delete' '
 	test_tick &&
 	git commit -m tiger C &&
 
-	HEAD_entry_count=$(git reflog | wc -l)
-	master_entry_count=$(git reflog show master | wc -l)
+	HEAD_entry_count=$(git reflog | wc -l) &&
+	master_entry_count=$(git reflog show master | wc -l) &&
 
 	test $HEAD_entry_count = 5 &&
 	test $master_entry_count = 5 &&
@@ -199,13 +199,13 @@ test_expect_success 'delete' '
 	test $HEAD_entry_count = $(git reflog | wc -l) &&
 	! grep ox < output &&
 
-	master_entry_count=$(wc -l < output)
+	master_entry_count=$(wc -l < output) &&
 
 	git reflog delete HEAD@{1} &&
 	test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
 	test $master_entry_count = $(git reflog show master | wc -l) &&
 
-	HEAD_entry_count=$(git reflog | wc -l)
+	HEAD_entry_count=$(git reflog | wc -l) &&
 
 	git reflog delete master@{07.04.2005.15:15:00.-0700} &&
 	git reflog show master > output &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 1be415e..bb01d5a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -61,7 +61,7 @@ test_expect_success 'object with bad sha1' '
 	sha=$(echo blob | git hash-object -w --stdin) &&
 	old=$(echo $sha | sed "s+^..+&/+") &&
 	new=$(dirname $old)/ffffffffffffffffffffffffffffffffffffff &&
-	sha="$(dirname $new)$(basename $new)"
+	sha="$(dirname $new)$(basename $new)" &&
 	mv .git/objects/$old .git/objects/$new &&
 	test_when_finished "remove_object $sha" &&
 	git update-index --add --cacheinfo 100644 $sha foo &&
@@ -111,7 +111,7 @@ test_expect_success 'email with embedded > is not okay' '
 '
 
 test_expect_success 'tag pointing to nonexistent' '
-	cat >invalid-tag <<-\EOF
+	cat >invalid-tag <<-\EOF &&
 	object ffffffffffffffffffffffffffffffffffffffff
 	type commit
 	tag invalid
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index a74ee22..e6f59f1 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -17,7 +17,7 @@ test_expect_success SYMLINKS setup '
 	git branch side &&
 
 	echo goodbye >nitfol &&
-	git add nitfol
+	git add nitfol &&
 	test_tick &&
 	git commit -m "master adds file nitfol" &&
 
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index a463b13..9cd0ac4 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -32,7 +32,7 @@ test_expect_success PERL 'git checkout -p' '
 '
 
 test_expect_success PERL 'git checkout -p with staged changes' '
-	set_state dir/foo work index
+	set_state dir/foo work index &&
 	(echo n; echo y) | git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo index index
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 2d2f63f..0e3b858 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -14,7 +14,7 @@ TEST_FILE=foo
 test_expect_success 'Setup' '
 	echo "Initial" >"$TEST_FILE" &&
 	git add "$TEST_FILE" &&
-	git commit -m "First Commit"
+	git commit -m "First Commit" &&
 	test_tick &&
 	echo "State 1" >>"$TEST_FILE" &&
 	git add "$TEST_FILE" &&
diff --git a/t/t2050-git-dir-relative.sh b/t/t2050-git-dir-relative.sh
index b7131d8..21f4659 100755
--- a/t/t2050-git-dir-relative.sh
+++ b/t/t2050-git-dir-relative.sh
@@ -26,7 +26,7 @@ chmod +x .git/hooks/post-commit'
 
 test_expect_success 'post-commit hook used ordinarily' '
 echo initial >top &&
-git add top
+git add top &&
 git commit -m initial &&
 test -r "${COMMIT_FILE}"
 '
@@ -45,7 +45,7 @@ test -r "${COMMIT_FILE}"
 rm -rf "${COMMIT_FILE}"
 
 test_expect_success 'post-commit-hook from sub dir' '
-echo changed again >top
+echo changed again >top &&
 cd subdir &&
 git --git-dir .git --work-tree .. add ../top &&
 git --git-dir .git --work-tree .. commit -m subcommit &&
diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
index 76ad7c3..c8bce8c 100755
--- a/t/t2101-update-index-reupdate.sh
+++ b/t/t2101-update-index-reupdate.sh
@@ -51,7 +51,7 @@ test_expect_success 'update-index again' \
 	echo hello world >dir1/file3 &&
 	echo goodbye people >file2 &&
 	git update-index --add file2 dir1/file3 &&
-	echo hello everybody >file2
+	echo hello everybody >file2 &&
 	echo happy >dir1/file3 &&
 	git update-index --again &&
 	git ls-files -s >current &&
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 2ad2819..0692427 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 	echo initial >dir1/sub2 &&
 	echo initial >dir2/sub3 &&
 	git add check dir1 dir2 top foo &&
-	test_tick
+	test_tick &&
 	git commit -m initial &&
 
 	echo changed >check &&
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 6d2f2b6..c8fe978 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -156,7 +156,7 @@ test_expect_success 'trailing slash in exclude allows directory match (2)' '
 
 test_expect_success 'trailing slash in exclude forces directory match (1)' '
 
-	>two
+	>two &&
 	git ls-files --others --exclude=two/ >output &&
 	grep "^two" output
 
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index e66e550..20d4f11 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -544,7 +544,7 @@ test_expect_success 'reset and bind merge' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	test_cmp expected actual
+	test_cmp expected actual &&
 
 	git read-tree --prefix=z/ master &&
 	git ls-files -s >actual &&
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index 4261e96..2f5f41a 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -10,10 +10,10 @@ test_expect_success setup '
 		cd sub &&
 		git init &&
 		>subfile &&
-		git add subfile
+		git add subfile &&
 		git commit -m "subproject commit #1"
 	) &&
-	>mainfile
+	>mainfile &&
 	git add sub mainfile &&
 	test_tick &&
 	git commit -m "superproject commit #1"
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 809d1c4..6028748 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -12,13 +12,13 @@ test_expect_success 'make commits' '
 '
 
 test_expect_success 'make branches' '
-	git branch branch-one
+	git branch branch-one &&
 	git branch branch-two HEAD^
 '
 
 test_expect_success 'make remote branches' '
-	git update-ref refs/remotes/origin/branch-one branch-one
-	git update-ref refs/remotes/origin/branch-two branch-two
+	git update-ref refs/remotes/origin/branch-one branch-one &&
+	git update-ref refs/remotes/origin/branch-two branch-two &&
 	git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/branch-one
 '
 
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index f39a261..5e29a05 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -43,8 +43,8 @@ test_expect_success TABS_IN_FILENAMES 'git ls-files no-funny' \
 	test_cmp expected current'
 
 test_expect_success TABS_IN_FILENAMES 'setup expect' '
-t0=`git write-tree`
-echo "$t0" >t0
+t0=`git write-tree` &&
+echo "$t0" >t0 &&
 
 cat > expected <<\EOF
 just space
@@ -69,8 +69,8 @@ test_expect_success TABS_IN_FILENAMES 'git ls-files -z with-funny' \
 	test_cmp expected current'
 
 test_expect_success TABS_IN_FILENAMES 'setup expect' '
-t1=`git write-tree`
-echo "$t1" >t1
+t1=`git write-tree` &&
+echo "$t1" >t1 &&
 
 cat > expected <<\EOF
 just space
diff --git a/t/t3307-notes-man.sh b/t/t3307-notes-man.sh
index 3269f2e..2ea3be6 100755
--- a/t/t3307-notes-man.sh
+++ b/t/t3307-notes-man.sh
@@ -26,7 +26,7 @@ test_expect_success 'example 1: notes to add an Acked-by line' '
 '
 
 test_expect_success 'example 2: binary notes' '
-	cp "$TEST_DIRECTORY"/test4012.png .
+	cp "$TEST_DIRECTORY"/test4012.png . &&
 	git checkout B &&
 	blob=$(git hash-object -w test4012.png) &&
 	git notes --ref=logo add -C "$blob" &&
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 85fc7c4..506d37e 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -43,20 +43,20 @@ test_expect_success 'rebase -m' '
 '
 
 test_expect_success 'rebase --stat' '
-        git reset --hard start
+        git reset --hard start &&
         git rebase --stat master >diffstat.txt &&
         grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase w/config rebase.stat' '
-        git reset --hard start
+        git reset --hard start &&
         git config rebase.stat true &&
         git rebase master >diffstat.txt &&
         grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase -n overrides config rebase.stat config' '
-        git reset --hard start
+        git reset --hard start &&
         git config rebase.stat true &&
         git rebase -n master >diffstat.txt &&
         ! grep "^ fileX |  *1 +$" diffstat.txt
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
index 2062b85..6b84e60 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -16,7 +16,7 @@ test_expect_success setup '
 	git commit -a -m "A sample commit log message that has a long
 summary that spills over multiple lines.
 
-But otherwise with a sane description."
+But otherwise with a sane description." &&
 
 	git branch side &&
 
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 5869061..086c91c 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -173,14 +173,14 @@ EOF
 test_expect_success 'pre-rebase hook stops rebase' '
 	git checkout -b stops1 other &&
 	test_must_fail git rebase --root --onto master &&
-	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops1
+	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops1 &&
 	test 0 = $(git rev-list other...stops1 | wc -l)
 '
 
 test_expect_success 'pre-rebase hook stops rebase -i' '
 	git checkout -b stops2 other &&
 	test_must_fail git rebase --root --onto master &&
-	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops2
+	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops2 &&
 	test 0 = $(git rev-list other...stops2 | wc -l)
 '
 
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 37cb89a..fd2184c 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -26,7 +26,7 @@ test_auto_fixup() {
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "fixup! first"
+	git commit -m "fixup! first" &&
 
 	git tag $1 &&
 	test_tick &&
@@ -55,7 +55,7 @@ test_auto_squash() {
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! first"
+	git commit -m "squash! first" &&
 
 	git tag $1 &&
 	test_tick &&
@@ -84,7 +84,7 @@ test_expect_success 'misspelled auto squash' '
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! forst"
+	git commit -m "squash! forst" &&
 	git tag final-missquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
diff --git a/t/t3417-rebase-whitespace-fix.sh b/t/t3417-rebase-whitespace-fix.sh
index 220a740..1fb3e49 100755
--- a/t/t3417-rebase-whitespace-fix.sh
+++ b/t/t3417-rebase-whitespace-fix.sh
@@ -89,7 +89,7 @@ test_expect_success 'same, but do not remove trailing spaces' '
 	git config core.whitespace "-blank-at-eol" &&
 	git reset --hard HEAD^ &&
 	cp third file && git add file && git commit -m third &&
-	git rebase --whitespace=fix HEAD^^
+	git rebase --whitespace=fix HEAD^^ &&
 	git diff --exit-code HEAD^:file expect-second &&
 	test_cmp file third
 '
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index f7b3518..e6a6481 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -23,7 +23,7 @@ test_expect_success 'conflicting merge' '
 test_expect_success 'fixup' '
 	echo foo-dev >foo &&
 	git add foo && test_tick && git commit -q -m 4 &&
-	git reset --hard HEAD^
+	git reset --hard HEAD^ &&
 	echo foo-dev >expect
 '
 
@@ -33,7 +33,7 @@ test_expect_success 'cherry-pick conflict' '
 '
 
 test_expect_success 'reconfigure' '
-	git config rerere.enabled false
+	git config rerere.enabled false &&
 	git reset --hard
 '
 
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 7d49469..da82b65 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -36,19 +36,19 @@ for_each_name () {
 test_expect_success TABS_IN_FILENAMES 'setup' '
 
 	mkdir "$FN" &&
-	for_each_name "echo initial >\"\$name\""
+	for_each_name "echo initial >\"\$name\"" &&
 	git add . &&
 	git commit -q -m Initial &&
 
 	for_each_name "echo second >\"\$name\"" &&
-	git commit -a -m Second
+	git commit -a -m Second &&
 
 	for_each_name "echo modified >\"\$name\""
 
 '
 
 test_expect_success TABS_IN_FILENAMES 'setup expected files' '
-cat >expect.quoted <<\EOF
+cat >expect.quoted <<\EOF &&
 Name
 "Name and a\nLF"
 "Name and an\tHT"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 903a122..6fd560c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -157,7 +157,7 @@ EOF
 
 test_expect_success 'stash branch' '
 	echo foo > file &&
-	git commit file -m first
+	git commit file -m first &&
 	echo bar > file &&
 	echo bar2 > file2 &&
 	git add file2 &&
@@ -255,7 +255,7 @@ test_expect_success 'stash rm and ignore' '
 	echo file >.gitignore &&
 	git stash save "rm and ignore" &&
 	test bar = "$(cat file)" &&
-	test file = "$(cat .gitignore)"
+	test file = "$(cat .gitignore)" &&
 	git stash apply &&
 	! test -r file &&
 	test file = "$(cat .gitignore)"
@@ -268,7 +268,7 @@ test_expect_success 'stash rm and ignore (stage .gitignore)' '
 	git add .gitignore &&
 	git stash save "rm and ignore (stage .gitignore)" &&
 	test bar = "$(cat file)" &&
-	! test -r .gitignore
+	! test -r .gitignore &&
 	git stash apply &&
 	! test -r file &&
 	test file = "$(cat .gitignore)"
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index d1819ca..1e7193a 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -20,7 +20,7 @@ test_expect_success PERL 'setup' '
 # note: bar sorts before dir, so the first 'n' is always to skip 'bar'
 
 test_expect_success PERL 'saying "n" does nothing' '
-	set_state dir/foo work index
+	set_state dir/foo work index &&
 	(echo n; echo n) | test_must_fail git stash save -p &&
 	verify_state dir/foo work index &&
 	verify_saved_state bar
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index e19ca65..d79d9e1e 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -155,7 +155,7 @@ test_expect_success \
      git checkout-index -f -u -a &&
      sed -e "s/git/GIT/" file0 >file1 &&
      sed -e "s/git/GET/" file0 >file2 &&
-     rm -f file0
+     rm -f file0 &&
      git update-index --add --remove file0 file1 file2'
 
 test_expect_success \
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 935d101..88c6b5b 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -330,7 +330,7 @@ test_expect_success 'check space before tab in indent (space-before-tab: on)' '
 
 test_expect_success 'check spaces as indentation (indent-with-non-tab: off)' '
 
-	git config core.whitespace "-indent-with-non-tab"
+	git config core.whitespace "-indent-with-non-tab" &&
 	echo "        foo ();" > x &&
 	git diff --check
 
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 709b323..886494b 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -95,7 +95,7 @@ test_expect_success 'format.numbered && --keep-subject' '
 
 test_expect_success 'format.numbered = auto' '
 
-	git config format.numbered auto
+	git config format.numbered auto &&
 	git format-patch --stdout HEAD~2 > patch5 &&
 	test_numbered patch5
 
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index d99814a..241a74d 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -316,11 +316,11 @@ test_expect_success 'git diff (empty submodule dir)' '
 test_expect_success 'conflicted submodule setup' '
 
 	# 39 efs
-	c=fffffffffffffffffffffffffffffffffffffff
+	c=fffffffffffffffffffffffffffffffffffffff &&
 	(
-		echo "000000 $_z40 0	sub"
-		echo "160000 1$c 1	sub"
-		echo "160000 2$c 2	sub"
+		echo "000000 $_z40 0	sub" &&
+		echo "160000 1$c 1	sub" &&
+		echo "160000 2$c 2	sub" &&
 		echo "160000 3$c 3	sub"
 	) | git update-index --index-info &&
 	echo >expect.nosub '\''diff --cc sub
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 6f7548c..483f6a0 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -6,8 +6,8 @@ test_description='word diff colors'
 
 test_expect_success setup '
 
-	git config diff.color.old red
-	git config diff.color.new green
+	git config diff.color.old red &&
+	git config diff.color.new green &&
 	git config diff.color.func magenta
 
 '
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 9692f16..954118c 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -41,11 +41,11 @@ test_expect_success 'setup' "
 "
 
 test_expect_success 'stat binary diff -- should not fail.' \
-	'git checkout master
+	'git checkout master &&
 	 git apply --stat --summary B.diff'
 
 test_expect_success 'stat binary diff (copy) -- should not fail.' \
-	'git checkout master
+	'git checkout master &&
 	 git apply --stat --summary C.diff'
 
 test_expect_success 'check binary diff -- should fail.' \
@@ -69,11 +69,11 @@ test_expect_success \
 '
 
 test_expect_success 'check binary diff with replacement.' \
-	'git checkout master
+	'git checkout master &&
 	 git apply --check --allow-binary-replacement BF.diff'
 
 test_expect_success 'check binary diff with replacement (copy).' \
-	'git checkout master
+	'git checkout master &&
 	 git apply --check --allow-binary-replacement CF.diff'
 
 # Now we start applying them.
diff --git a/t/t4111-apply-subdir.sh b/t/t4111-apply-subdir.sh
index a52d94a..7c39843 100755
--- a/t/t4111-apply-subdir.sh
+++ b/t/t4111-apply-subdir.sh
@@ -89,7 +89,7 @@ test_expect_success 'apply --index from subdir of toplevel' '
 test_expect_success 'apply from .git dir' '
 	cp postimage expected &&
 	cp preimage .git/file &&
-	cp preimage .git/objects/file
+	cp preimage .git/objects/file &&
 	(
 		cd .git &&
 		git apply "$patch"
@@ -100,7 +100,7 @@ test_expect_success 'apply from .git dir' '
 test_expect_success 'apply from subdir of .git dir' '
 	cp postimage expected &&
 	cp preimage .git/file &&
-	cp preimage .git/objects/file
+	cp preimage .git/objects/file &&
 	(
 		cd .git/objects &&
 		git apply "$patch"
diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
index 3c73a78..3d0384d 100755
--- a/t/t4119-apply-config.sh
+++ b/t/t4119-apply-config.sh
@@ -73,7 +73,7 @@ D=`pwd`
 test_expect_success 'apply --whitespace=strip in subdir' '
 
 	cd "$D" &&
-	git config --unset-all apply.whitespace
+	git config --unset-all apply.whitespace &&
 	rm -f sub/file1 &&
 	cp saved sub/file1 &&
 	git update-index --refresh &&
diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index 77200c0..972946c 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -31,7 +31,7 @@ test_expect_success 'apply same filename with independent changes' '
 '
 
 test_expect_success 'apply same filename with overlapping changes' '
-	git reset --hard
+	git reset --hard &&
 	modify "s/^d/z/" same_fn &&
 	git diff > patch0 &&
 	git add same_fn &&
@@ -44,8 +44,8 @@ test_expect_success 'apply same filename with overlapping changes' '
 '
 
 test_expect_success 'apply same new filename after rename' '
-	git reset --hard
-	git mv same_fn new_fn
+	git reset --hard &&
+	git mv same_fn new_fn &&
 	modify "s/^d/z/" new_fn &&
 	git add new_fn &&
 	git diff -M --cached > patch1 &&
@@ -58,12 +58,12 @@ test_expect_success 'apply same new filename after rename' '
 '
 
 test_expect_success 'apply same old filename after rename -- should fail.' '
-	git reset --hard
-	git mv same_fn new_fn
+	git reset --hard &&
+	git mv same_fn new_fn &&
 	modify "s/^d/z/" new_fn &&
 	git add new_fn &&
 	git diff -M --cached > patch1 &&
-	git mv new_fn same_fn
+	git mv new_fn same_fn &&
 	modify "s/^e/y/" same_fn &&
 	git diff >> patch1 &&
 	git reset --hard &&
@@ -71,13 +71,13 @@ test_expect_success 'apply same old filename after rename -- should fail.' '
 '
 
 test_expect_success 'apply A->B (rename), C->A (rename), A->A -- should pass.' '
-	git reset --hard
-	git mv same_fn new_fn
+	git reset --hard &&
+	git mv same_fn new_fn &&
 	modify "s/^d/z/" new_fn &&
 	git add new_fn &&
 	git diff -M --cached > patch1 &&
 	git commit -m "a rename" &&
-	git mv other_fn same_fn
+	git mv other_fn same_fn &&
 	modify "s/^e/y/" same_fn &&
 	git add same_fn &&
 	git diff -M --cached >> patch1 &&
diff --git a/t/t4130-apply-criss-cross-rename.sh b/t/t4130-apply-criss-cross-rename.sh
index 7cfa2d6..d173acd 100755
--- a/t/t4130-apply-criss-cross-rename.sh
+++ b/t/t4130-apply-criss-cross-rename.sh
@@ -44,7 +44,7 @@ test_expect_success 'criss-cross rename' '
 	git reset --hard &&
 	mv file1 tmp &&
 	mv file2 file1 &&
-	mv file3 file2
+	mv file3 file2 &&
 	mv tmp file3 &&
 	cp file1 file1-swapped &&
 	cp file2 file2-swapped &&
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 3421807..94da990 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -8,7 +8,7 @@ test_description='git apply filename consistency check'
 . ./test-lib.sh
 
 test_expect_success setup '
-	cat > bad1.patch <<EOF
+	cat > bad1.patch <<EOF &&
 diff --git a/f b/f
 new file mode 100644
 index 0000000..d00491f
@@ -29,9 +29,9 @@ EOF
 '
 
 test_expect_success 'apply diff with inconsistent filenames in headers' '
-	test_must_fail git apply bad1.patch 2>err
-	grep "inconsistent new filename" err
-	test_must_fail git apply bad2.patch 2>err
+	test_must_fail git apply bad1.patch 2>err &&
+	grep "inconsistent new filename" err &&
+	test_must_fail git apply bad2.patch 2>err &&
 	grep "inconsistent old filename" err
 '
 
diff --git a/t/t4134-apply-submodule.sh b/t/t4134-apply-submodule.sh
index 1b82f93..0043930 100755
--- a/t/t4134-apply-submodule.sh
+++ b/t/t4134-apply-submodule.sh
@@ -8,7 +8,7 @@ test_description='git apply submodule tests'
 . ./test-lib.sh
 
 test_expect_success setup '
-	cat > create-sm.patch <<EOF
+	cat > create-sm.patch <<EOF &&
 diff --git a/dir/sm b/dir/sm
 new file mode 160000
 index 0000000..0123456
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 1c3d8ed..850fc96 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -219,7 +219,7 @@ test_expect_success 'am stays in branch' '
 
 test_expect_success 'am --signoff does not add Signed-off-by: line if already there' '
 	git format-patch --stdout HEAD^ >patch3 &&
-	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2," patch3 >patch4
+	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2," patch3 >patch4 &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout HEAD^ &&
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index cdb70b4..6872ba1 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -35,7 +35,7 @@ test_expect_success 'setup' '
 		tr 1234 "\370\235\204\236")" a1 &&
 
 	echo 5 >a1 &&
-	git commit --quiet -m "a								12	34	56	78" a1
+	git commit --quiet -m "a								12	34	56	78" a1 &&
 
 	echo 6 >a1 &&
 	git commit --quiet -m "Commit by someone else" \
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1172e45..a8c33d5 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -191,7 +191,7 @@ test_expect_success 'git show <commits> leaves list of commits as given' '
 test_expect_success 'setup case sensitivity tests' '
 	echo case >one &&
 	test_tick &&
-	git add one
+	git add one &&
 	git commit -a -m Second
 '
 
@@ -341,7 +341,7 @@ test_expect_success 'set up more tangled history' '
 	test_commit octopus-b &&
 	git checkout master &&
 	test_commit seventh &&
-	git merge octopus-a octopus-b
+	git merge octopus-a octopus-b &&
 	git merge reach
 '
 
diff --git a/t/t4252-am-options.sh b/t/t4252-am-options.sh
index f603c1b..e758e63 100755
--- a/t/t4252-am-options.sh
+++ b/t/t4252-am-options.sh
@@ -59,7 +59,7 @@ test_expect_success 'interrupted am --directory="frotz nitfol"' '
 '
 
 test_expect_success 'apply to a funny path' '
-	with_sq="with'\''sq"
+	with_sq="with'\''sq" &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard initial &&
 	git am --directory="$with_sq" "$tm"/am-test-5-2 &&
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index bbb9c12..602806d 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -12,7 +12,7 @@ TRASH=`pwd`
 
 test_expect_success \
     'setup' \
-    'rm -f .git/index*
+    'rm -f .git/index* &&
      perl -e "print \"a\" x 4096;" > a &&
      perl -e "print \"b\" x 4096;" > b &&
      perl -e "print \"c\" x 4096;" > c &&
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 0a24e61..2fc5af6 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -8,7 +8,7 @@ test_description='mmap sliding window tests'
 
 test_expect_success \
     'setup' \
-    'rm -f .git/index*
+    'rm -f .git/index* &&
      for i in a b c
      do
          echo $i >$i &&
@@ -48,7 +48,7 @@ test_expect_success \
      git repack -a -d &&
      test "`git count-objects`" = "0 objects, 0 kilobytes" &&
      pack2=`ls .git/objects/pack/*.pack` &&
-     test -f "$pack2"
+     test -f "$pack2" &&
      test "$pack1" \!= "$pack2"'
 
 test_expect_success \
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index fb3a270..b34ea93 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -8,7 +8,7 @@ test_description='pack index with 64-bit offsets and object CRC'
 
 test_expect_success \
     'setup' \
-    'rm -rf .git
+    'rm -rf .git &&
      git init &&
      git config pack.threads 1 &&
      i=1 &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 18376d6..bafcca7 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -91,7 +91,7 @@ test_expect_success 'setup' '
 		prev=$cur &&
 		cur=$(($cur+1))
 	done &&
-	add B1 $A1
+	add B1 $A1 &&
 	echo $ATIP > .git/refs/heads/A &&
 	echo $BTIP > .git/refs/heads/B &&
 	git symbolic-ref HEAD refs/heads/B
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index 1037a72..7a46cbd 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -57,7 +57,7 @@ test_expect_success 'copy commit and tree but not blob by hand' '
 		cd cloned &&
 		git count-objects | sed -e "s/ *objects,.*//"
 	) ) &&
-	test $cnt -eq 6
+	test $cnt -eq 6 &&
 
 	blob=$(git rev-parse HEAD:file | sed -e "s|..|&/|") &&
 	test -f "cloned/.git/objects/$blob" &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9a88475..7e433b1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -119,7 +119,7 @@ test_expect_success 'fetch must not resolve short tag name' '
 test_expect_success 'fetch must not resolve short remote name' '
 
 	cd "$D" &&
-	git update-ref refs/remotes/six/HEAD HEAD
+	git update-ref refs/remotes/six/HEAD HEAD &&
 
 	mkdir six &&
 	cd six &&
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index b737332..227dd56 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -27,7 +27,7 @@ test_expect_success setup '
 	(
 		cd two && git branch another
 	) &&
-	git clone --mirror two three
+	git clone --mirror two three &&
 	git clone one test
 '
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b11da79..d73731e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -586,7 +586,7 @@ test_expect_success 'push --delete refuses src:dest refspecs' '
 '
 
 test_expect_success 'warn on push to HEAD of non-bare repository' '
-	mk_test heads/master
+	mk_test heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -597,7 +597,7 @@ test_expect_success 'warn on push to HEAD of non-bare repository' '
 '
 
 test_expect_success 'deny push to HEAD of non-bare repository' '
-	mk_test heads/master
+	mk_test heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -607,7 +607,7 @@ test_expect_success 'deny push to HEAD of non-bare repository' '
 '
 
 test_expect_success 'allow push to HEAD of bare repository (bare)' '
-	mk_test heads/master
+	mk_test heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -619,7 +619,7 @@ test_expect_success 'allow push to HEAD of bare repository (bare)' '
 '
 
 test_expect_success 'allow push to HEAD of non-bare repository (config)' '
-	mk_test heads/master
+	mk_test heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
index 96be523..c00c9b0 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -123,7 +123,7 @@ test_expect_success 'bob works and pushes again' '
 	(
 		cd alice-pub &&
 		git cat-file commit master >../bob-work/commit
-	)
+	) &&
 	(
 		# This time Bob does not pull from Alice, and
 		# the master branch at her public repository points
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 65d8d47..faa2e96 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -6,7 +6,7 @@ test_description='unpack-objects'
 
 test_expect_success setup '
 	mkdir pub.git &&
-	GIT_DIR=pub.git git init --bare
+	GIT_DIR=pub.git git init --bare &&
 	GIT_DIR=pub.git git config receive.fsckobjects true &&
 	mkdir work &&
 	(
diff --git a/t/t556x_common b/t/t556x_common
index be024e5..03dcfb1 100755
--- a/t/t556x_common
+++ b/t/t556x_common
@@ -52,21 +52,21 @@ get_static_files() {
 SMART=smart
 export GIT_HTTP_EXPORT_ALL=1
 test_expect_success 'direct refs/heads/master not found' '
-	log_div "refs/heads/master"
+	log_div "refs/heads/master" &&
 	GET refs/heads/master "404 Not Found"
 '
 test_expect_success 'static file is ok' '
-	log_div "getanyfile default"
+	log_div "getanyfile default" &&
 	get_static_files "200 OK"
 '
 SMART=smart_noexport
 unset GIT_HTTP_EXPORT_ALL
 test_expect_success 'no export by default' '
-	log_div "no git-daemon-export-ok"
+	log_div "no git-daemon-export-ok" &&
 	get_static_files "404 Not Found"
 '
 test_expect_success 'export if git-daemon-export-ok' '
-	log_div "git-daemon-export-ok"
+	log_div "git-daemon-export-ok" &&
         (cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	 touch git-daemon-export-ok
 	) &&
@@ -75,47 +75,47 @@ test_expect_success 'export if git-daemon-export-ok' '
 SMART=smart
 export GIT_HTTP_EXPORT_ALL=1
 test_expect_success 'static file if http.getanyfile true is ok' '
-	log_div "getanyfile true"
+	log_div "getanyfile true" &&
 	config http.getanyfile true &&
 	get_static_files "200 OK"
 '
 test_expect_success 'static file if http.getanyfile false fails' '
-	log_div "getanyfile false"
+	log_div "getanyfile false" &&
 	config http.getanyfile false &&
 	get_static_files "403 Forbidden"
 '
 
 test_expect_success 'http.uploadpack default enabled' '
-	log_div "uploadpack default"
+	log_div "uploadpack default" &&
 	GET info/refs?service=git-upload-pack "200 OK"  &&
 	POST git-upload-pack 0000 "200 OK"
 '
 test_expect_success 'http.uploadpack true' '
-	log_div "uploadpack true"
+	log_div "uploadpack true" &&
 	config http.uploadpack true &&
 	GET info/refs?service=git-upload-pack "200 OK" &&
 	POST git-upload-pack 0000 "200 OK"
 '
 test_expect_success 'http.uploadpack false' '
-	log_div "uploadpack false"
+	log_div "uploadpack false" &&
 	config http.uploadpack false &&
 	GET info/refs?service=git-upload-pack "403 Forbidden" &&
 	POST git-upload-pack 0000 "403 Forbidden"
 '
 
 test_expect_success 'http.receivepack default disabled' '
-	log_div "receivepack default"
+	log_div "receivepack default" &&
 	GET info/refs?service=git-receive-pack "403 Forbidden"  &&
 	POST git-receive-pack 0000 "403 Forbidden"
 '
 test_expect_success 'http.receivepack true' '
-	log_div "receivepack true"
+	log_div "receivepack true" &&
 	config http.receivepack true &&
 	GET info/refs?service=git-receive-pack "200 OK" &&
 	POST git-receive-pack 0000 "200 OK"
 '
 test_expect_success 'http.receivepack false' '
-	log_div "receivepack false"
+	log_div "receivepack false" &&
 	config http.receivepack false &&
 	GET info/refs?service=git-receive-pack "403 Forbidden" &&
 	POST git-receive-pack 0000 "403 Forbidden"
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index fc57e7d..8efcd13 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -90,22 +90,22 @@ check () {
 for type in basic parents parents-raw
 do
 	test_expect_success 'without grafts' "
-		rm -f .git/info/grafts
+		rm -f .git/info/grafts &&
 		check $type $B2 -- $B2 $B1 $B0
 	"
 
 	test_expect_success 'with grafts' "
-		echo '$B0 $A2' >.git/info/grafts
+		echo '$B0 $A2' >.git/info/grafts &&
 		check $type $B2 -- $B2 $B1 $B0 $A2 $A1 $A0
 	"
 
 	test_expect_success 'without grafts, with pathlimit' "
-		rm -f .git/info/grafts
+		rm -f .git/info/grafts &&
 		check $type $B2 subdir -- $B2 $B0
 	"
 
 	test_expect_success 'with grafts, with pathlimit' "
-		echo '$B0 $A2' >.git/info/grafts
+		echo '$B0 $A2' >.git/info/grafts &&
 		check $type $B2 subdir -- $B2 $B0 $A2 $A0
 	"
 
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index c8a96a9..52f7b27 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -18,7 +18,7 @@ test_expect_success setup '
 
 	commit one &&
 
-	test_tick=$(($test_tick - 2400))
+	test_tick=$(($test_tick - 2400)) &&
 
 	commit two &&
 	commit three &&
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 62197a3..082032e 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -131,7 +131,7 @@ test_expect_success 'unsynchronized clocks' '
 	R2=$(doit  3 R2 $R1) &&
 
 	PL=$(doit  4 PL $L2 $C2) &&
-	PR=$(doit  4 PR $C2 $R2)
+	PR=$(doit  4 PR $C2 $R2) &&
 
 	git name-rev $C2 >expected &&
 
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index b3fbf65..755d30c 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -104,7 +104,7 @@ test_expect_success 'mark rename/delete as unmerged' '
 	test_tick &&
 	git commit -m delete &&
 	git checkout -b rename HEAD^ &&
-	git mv a1 a2
+	git mv a1 a2 &&
 	test_tick &&
 	git commit -m rename &&
 	test_must_fail git merge delete &&
diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 3900d9f..73fc240 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -6,7 +6,7 @@ test_description='subtree merge strategy'
 
 test_expect_success setup '
 
-	s="1 2 3 4 5 6 7 8"
+	s="1 2 3 4 5 6 7 8" &&
 	for i in $s; do echo $i; done >hello &&
 	git add hello &&
 	git commit -m initial &&
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 3b042aa..b5063b6 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -517,13 +517,13 @@ test_expect_success '"parallel" side branch creation' '
 	add_line_into_file "2(para): line 2 on parallel branch" dir2/file2 &&
 	PARA_HASH2=$(git rev-parse --verify HEAD) &&
 	add_line_into_file "3(para): line 3 on parallel branch" dir2/file3 &&
-	PARA_HASH3=$(git rev-parse --verify HEAD)
+	PARA_HASH3=$(git rev-parse --verify HEAD) &&
 	git merge -m "merge HASH4 and PARA_HASH3" "$HASH4" &&
-	PARA_HASH4=$(git rev-parse --verify HEAD)
+	PARA_HASH4=$(git rev-parse --verify HEAD) &&
 	add_line_into_file "5(para): add line on parallel branch" dir1/file1 &&
-	PARA_HASH5=$(git rev-parse --verify HEAD)
+	PARA_HASH5=$(git rev-parse --verify HEAD) &&
 	add_line_into_file "6(para): add line on parallel branch" dir2/file2 &&
-	PARA_HASH6=$(git rev-parse --verify HEAD)
+	PARA_HASH6=$(git rev-parse --verify HEAD) &&
 	git merge -m "merge HASH7 and PARA_HASH6" "$HASH7" &&
 	PARA_HASH7=$(git rev-parse --verify HEAD)
 '
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index b874141..004c365 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -15,7 +15,7 @@ test_description='recursive merge corner cases'
 #
 
 test_expect_success setup '
-	ten="0 1 2 3 4 5 6 7 8 9"
+	ten="0 1 2 3 4 5 6 7 8 9" &&
 	for i in $ten
 	do
 		echo line $i in a sample file
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 1785e17..1e0447f 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -60,7 +60,7 @@ test_expect_success 'checkout' '
 
 test_expect_success 'checkout with local tracked branch' '
 	git checkout master &&
-	git checkout follower >actual
+	git checkout follower >actual &&
 	grep "is ahead of" actual
 '
 
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 95b180f..ae2194e 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -53,7 +53,7 @@ test_expect_success 'set up buggy branch' '
      echo "line 12" >> hello &&
      echo "line 13" >> hello &&
      add_and_commit_file hello "2 more lines" &&
-     HASH6=$(git rev-parse --verify HEAD)
+     HASH6=$(git rev-parse --verify HEAD) &&
      echo "line 14" >> hello &&
      echo "line 15" >> hello &&
      echo "line 16" >> hello &&
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 9891e2c..95fab20 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -18,7 +18,7 @@ test_expect_success PERL 'setup' '
 # note: bar sorts before foo, so the first 'n' is always to skip 'bar'
 
 test_expect_success PERL 'saying "n" does nothing' '
-	set_and_save_state dir/foo work work
+	set_and_save_state dir/foo work work &&
 	(echo n; echo n) | git reset -p &&
 	verify_saved_state dir/foo &&
 	verify_saved_state bar
@@ -42,14 +42,14 @@ test_expect_success PERL 'git reset -p HEAD^' '
 # the failure case (and thus get out of the loop).
 
 test_expect_success PERL 'git reset -p dir' '
-	set_state dir/foo work work
+	set_state dir/foo work work &&
 	(echo y; echo n) | git reset -p dir &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
 '
 
 test_expect_success PERL 'git reset -p -- foo (inside dir)' '
-	set_state dir/foo work work
+	set_state dir/foo work work &&
 	(echo y; echo n) | (cd dir && git reset -p -- foo) &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
index 643ab03..77b6920 100755
--- a/t/t7509-commit.sh
+++ b/t/t7509-commit.sh
@@ -40,7 +40,7 @@ test_expect_success '-C option copies only the message with --reset-author' '
 	test_tick &&
 	git commit -a -C Initial --reset-author &&
 	echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" >expect &&
-	author_header HEAD >actual
+	author_header HEAD >actual &&
 	test_cmp expect actual &&
 
 	message_body Initial >expect &&
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 2746169..0a46795 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -31,7 +31,7 @@ test_expect_success 'merge c1 with c2, c3, c4, ... c29' '
 	do
 		refs="$refs c$i"
 		i=`expr $i + 1`
-	done
+	done &&
 	git merge $refs &&
 	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
 	i=1 &&
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 3bd7404..d78bdec 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -54,7 +54,7 @@ test_expect_success 'custom mergetool' '
 
 test_expect_success 'mergetool crlf' '
     git config core.autocrlf true &&
-    git checkout -b test2 branch1
+    git checkout -b test2 branch1 &&
     test_must_fail git merge master >/dev/null 2>&1 &&
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 023f225..79195e2 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -452,7 +452,7 @@ test_expect_success 'outside of git repository' '
 		echo file1:hello &&
 		echo sub/file2:world
 	} >non/expect.full &&
-	echo file2:world >non/expect.sub
+	echo file2:world >non/expect.sub &&
 	(
 		GIT_CEILING_DIRECTORIES="$(pwd)/non/git" &&
 		export GIT_CEILING_DIRECTORIES &&
@@ -478,7 +478,7 @@ test_expect_success 'inside git repository but with --no-index' '
 		echo sub/file2:world
 	} >is/expect.full &&
 	: >is/expect.empty &&
-	echo file2:world >is/expect.sub
+	echo file2:world >is/expect.sub &&
 	(
 		cd is/git &&
 		git init &&
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index f7f3c5a..13b179e 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -190,7 +190,7 @@ test_expect_success "follow-parent is atomic" '
 	git svn init --minimize-url -i stunk "$svnrepo"/stunk &&
 	git svn fetch -i stunk &&
 	git svn init --minimize-url -i flunked "$svnrepo"/flunked &&
-	git svn fetch -i flunked
+	git svn fetch -i flunked &&
 	test "`git rev-parse --verify refs/remotes/flunk@18`" \
 	   = "`git rev-parse --verify refs/remotes/stunk`" &&
 	test "`git rev-parse --verify refs/remotes/flunk~1`" \
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
index 0ed90d9..fd81847 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -16,7 +16,7 @@ rm -rf import
 
 test_expect_success 'init, fetch and checkout repository' '
 	git svn init --rewrite-root=http://invalid.invalid/ "$svnrepo" &&
-	git svn fetch
+	git svn fetch &&
 	git checkout -b mybranch ${remotes_git_svn}
 	'
 
diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-dcommit-auto-props.sh
index d6b076f..aa841e1 100755
--- a/t/t9124-git-svn-dcommit-auto-props.sh
+++ b/t/t9124-git-svn-dcommit-auto-props.sh
@@ -24,7 +24,7 @@ test_expect_success 'initialize git svn' '
 		svn_cmd import -m "import for git svn" . "$svnrepo"
 	) &&
 	rm -rf import &&
-	git svn init "$svnrepo"
+	git svn init "$svnrepo" &&
 	git svn fetch
 '
 
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 250c651..4f6c06e 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -18,39 +18,39 @@ test_expect_success 'load svn dump' "
 
 test_expect_success 'all svn merges became git merge commits' '
 	unmarked=$(git rev-list --parents --all --grep=Merge |
-		grep -v " .* " | cut -f1 -d" ")
+		grep -v " .* " | cut -f1 -d" ") &&
 	[ -z "$unmarked" ]
 	'
 
 test_expect_success 'cherry picks did not become git merge commits' '
 	bad_cherries=$(git rev-list --parents --all --grep=Cherry |
-		grep " .* " | cut -f1 -d" ")
+		grep " .* " | cut -f1 -d" ") &&
 	[ -z "$bad_cherries" ]
 	'
 
 test_expect_success 'svn non-merge merge commits did not become git merge commits' '
 	bad_non_merges=$(git rev-list --parents --all --grep=non-merge |
-		grep " .* " | cut -f1 -d" ")
+		grep " .* " | cut -f1 -d" ") &&
 	[ -z "$bad_non_merges" ]
 	'
 
 test_expect_success 'commit made to merged branch is reachable from the merge' '
-	before_commit=$(git rev-list --all --grep="trunk commit before merging trunk to b2")
-	merge_commit=$(git rev-list --all --grep="Merge trunk to b2")
-	not_reachable=$(git rev-list -1 $before_commit --not $merge_commit)
+	before_commit=$(git rev-list --all --grep="trunk commit before merging trunk to b2") &&
+	merge_commit=$(git rev-list --all --grep="Merge trunk to b2") &&
+	not_reachable=$(git rev-list -1 $before_commit --not $merge_commit) &&
 	[ -z "$not_reachable" ]
 	'
 
 test_expect_success 'merging two branches in one commit is detected correctly' '
-	f1_commit=$(git rev-list --all --grep="make f1 branch from trunk")
-	f2_commit=$(git rev-list --all --grep="make f2 branch from trunk")
-	merge_commit=$(git rev-list --all --grep="Merge f1 and f2 to trunk")
-	not_reachable=$(git rev-list -1 $f1_commit $f2_commit --not $merge_commit)
+	f1_commit=$(git rev-list --all --grep="make f1 branch from trunk") &&
+	f2_commit=$(git rev-list --all --grep="make f2 branch from trunk") &&
+	merge_commit=$(git rev-list --all --grep="Merge f1 and f2 to trunk") &&
+	not_reachable=$(git rev-list -1 $f1_commit $f2_commit --not $merge_commit) &&
 	[ -z "$not_reachable" ]
 	'
 
 test_expect_failure 'everything got merged in the end' '
-	unmerged=$(git rev-list --all --not master)
+	unmerged=$(git rev-list --all --not master) &&
 	[ -z "$unmerged" ]
 	'
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 7c05920..ab48f42 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -321,7 +321,7 @@ test_expect_success \
 	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
 test_expect_success \
 	'C: validate reuse existing blob' \
-	'test $newf = `git rev-parse --verify branch:file2/newf`
+	'test $newf = `git rev-parse --verify branch:file2/newf` &&
 	 test $oldf = `git rev-parse --verify branch:file2/oldf`'
 
 cat >expect <<EOF
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 8c8e679..f823c05 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -26,7 +26,7 @@ test_expect_success 'setup' '
 	test_tick &&
 	git tag rein &&
 	git checkout -b wer HEAD^ &&
-	echo lange > file2
+	echo lange > file2 &&
 	test_tick &&
 	git commit -m sitzt file2 &&
 	test_tick &&
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 36c457e..9199550 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -57,7 +57,7 @@ test_expect_success 'setup' '
 # as argument to co -d
 test_expect_success 'basic checkout' \
   'GIT_CONFIG="$git_config" cvs -Q co -d cvswork master &&
-   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | head -n 1))" = "empty/1.1/"
+   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | head -n 1))" = "empty/1.1/" &&
    test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | sed -ne \$p))" = "secondrootfile/1.1/"'
 
 #------------------------
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 1bbfd82..ff6d6fb 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -70,7 +70,7 @@ test_expect_success 'setup' '
     mkdir subdir &&
     echo "Another text file" > subdir/file.h &&
     echo "Another binary: Q (this time CR)" | q_to_cr > subdir/withCr.bin &&
-    echo "Mixed up NUL, but marked text: Q <- there" | q_to_nul > mixedUp.c
+    echo "Mixed up NUL, but marked text: Q <- there" | q_to_nul > mixedUp.c &&
     echo "Unspecified" > subdir/unspecified.other &&
     echo "/*.bin -crlf" > .gitattributes &&
     echo "/*.c crlf" >> .gitattributes &&
-- 
1.7.2.3.557.gab647.dirty
