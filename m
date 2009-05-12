From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [RFC 3/8] Extend tests to cover locale wrt to commit messages.
Date: Wed, 13 May 2009 00:50:26 +0200
Message-ID: <1242168631-30753-4-git-send-email-robin.rosenberg@dewire.com>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-3-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 00:50:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M40oJ-0000Sx-T3
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 00:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbZELWur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 18:50:47 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbZELWuq
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 18:50:46 -0400
Received: from mail.dewire.com ([83.140.172.130]:19395 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbZELWul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 18:50:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 577E1145A58D;
	Wed, 13 May 2009 00:50:41 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qtn1OYh7ygtk; Wed, 13 May 2009 00:50:39 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 26532145A58E;
	Wed, 13 May 2009 00:50:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1242168631-30753-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118963>

---
 t/t1100-commit-tree-options.sh |   12 ++++++------
 t/t1400-update-ref.sh          |   10 +++++-----
 t/t3400-rebase.sh              |    6 +++---
 t/t3401-rebase-partial.sh      |    8 ++++----
 t/t3402-rebase-merge.sh        |   17 ++++++++++-------
 t/t3403-rebase-skip.sh         |   10 +++++-----
 6 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-optio=
ns.sh
index 19a0ed4..04f2e3b 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -13,10 +13,10 @@ object by defining all environment variables that i=
t understands.
=20
 cat >expected <<EOF
 tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
-author Author Name <author@email> 1117148400 +0000
-committer Committer Name <committer@email> 1117150200 +0000
+author Auth=F6r Name <author@email> 1117148400 +0000
+committer Committer N=E4me <committer@email> 1117150200 +0000
=20
-comment text
+c=F6mment text
 EOF
=20
 test_expect_success \
@@ -25,11 +25,11 @@ test_expect_success \
=20
 test_expect_success \
     'construct commit' \
-    'echo comment text |
-     GIT_AUTHOR_NAME=3D"Author Name" \
+    'echo c=F6mment text |
+     GIT_AUTHOR_NAME=3D"Auth=F6r Name" \
      GIT_AUTHOR_EMAIL=3D"author@email" \
      GIT_AUTHOR_DATE=3D"2005-05-26 23:00" \
-     GIT_COMMITTER_NAME=3D"Committer Name" \
+     GIT_COMMITTER_NAME=3D"Committer N=E4me" \
      GIT_COMMITTER_EMAIL=3D"committer@email" \
      GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
      TZ=3DGMT git-commit-tree `cat treeid` >commitid 2>/dev/null'
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b3b920e..0daff8a 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -71,12 +71,12 @@ touch .git/logs/refs/heads/master
 test_expect_success \
 	"create $m (logged by touch)" \
 	'GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
-	 git-update-ref HEAD '"$A"' -m "Initial Creation" &&
+	 git-update-ref HEAD '"$A"' -m "Initial Creation. /m=E4ster" &&
 	 test '"$A"' =3D $(cat .git/'"$m"')'
 test_expect_success \
 	"update $m (logged by touch)" \
 	'GIT_COMMITTER_DATE=3D"2005-05-26 23:31" \
-	 git-update-ref HEAD'" $B $A "'-m "Switch" &&
+	 git-update-ref HEAD'" $B $A "'-m "Switch /m=E4ster" &&
 	 test '"$B"' =3D $(cat .git/'"$m"')'
 test_expect_success \
 	"set $m (logged by touch)" \
@@ -84,9 +84,9 @@ test_expect_success \
 	 git-update-ref HEAD'" $A &&
 	 test $A"' =3D $(cat .git/'"$m"')'
=20
-cat >expect <<EOF
-$Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Init=
ial Creation
-$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Swit=
ch
+iconv -f iso-8859-1 -t utf-8 >expect <<EOF
+$Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Init=
ial Creation. /m=E4ster
+$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Swit=
ch /m=E4ster
 $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
 EOF
 test_expect_success \
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b9d3131..2982615 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -15,15 +15,15 @@ test_expect_success \
     'prepare repository with topic branch, then rebase against master'=
 \
     'echo First > A &&
      git-update-index --add A &&
-     git-commit -m "Add A." &&
+     git-commit -m "Add =C4." &&
      git checkout -b my-topic-branch &&
      echo Second > B &&
      git-update-index --add B &&
-     git-commit -m "Add B." &&
+     git-commit -m "Add =DF." &&
      git checkout -f master &&
      echo Third >> A &&
      git-update-index A &&
-     git-commit -m "Modify A." &&
+     git-commit -m "Modify =A2." &&
      git checkout -f my-topic-branch &&
      git rebase master'
=20
diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 8b19d3c..801b631 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -15,23 +15,23 @@ test_expect_success \
     'prepare repository with topic branch' \
     'echo First > A &&
      git-update-index --add A &&
-     git-commit -m "Add A." &&
+     git-commit -m "Add =C4." &&
=20
      git-checkout -b my-topic-branch &&
=20
      echo Second > B &&
      git-update-index --add B &&
-     git-commit -m "Add B." &&
+     git-commit -m "Add =DF." &&
=20
      echo AnotherSecond > C &&
      git-update-index --add C &&
-     git-commit -m "Add C." &&
+     git-commit -m "Add =A2." &&
=20
      git-checkout -f master &&
=20
      echo Third >> A &&
      git-update-index A &&
-     git-commit -m "Modify A."
+     git-commit -m "Modify =C4."
 '
=20
 test_expect_success \
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 0779aaa..8045995 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -7,8 +7,11 @@ test_description=3D'git rebase --merge test'
=20
 . ./test-lib.sh
=20
-T=3D"A quick brown fox
-jumps over the lazy dog."
+export GIT_AUTHOR_NAME=3D"P=E4r N=F6rdsson"
+
+T=3D"A quick brown f=F6x
+jumps over the l=E4zy dog."
+
 for i in 1 2 3 4 5 6 7 8 9 10
 do
 	echo "$i $T"
@@ -19,24 +22,24 @@ test_expect_success setup '
 	git commit -m"initial" &&
 	git branch side &&
 	echo "11 $T" >>original &&
-	git commit -a -m"master updates a bit." &&
+	git commit -a -m"m=E4ster updates a bit." &&
=20
 	echo "12 $T" >>original &&
-	git commit -a -m"master updates a bit more." &&
+	git commit -a -m"m=E4ster updates a bit more." &&
=20
 	git checkout side &&
 	(echo "0 $T" ; cat original) >renamed &&
 	git add renamed &&
 	git update-index --force-remove original &&
-	git commit -a -m"side renames and edits." &&
+	git commit -a -m"side renames and =E4dits." &&
=20
 	tr "[a-z]" "[A-Z]" <original >newfile &&
 	git add newfile &&
-	git commit -a -m"side edits further." &&
+	git commit -a -m"side edits f=FCrther." &&
=20
 	tr "[a-m]" "[A-M]" <original >newfile &&
 	rm -f original &&
-	git commit -a -m"side edits once again." &&
+	git commit -a -m"side edits =F6nce again." &&
=20
 	git branch test-rebase side &&
 	git branch test-rebase-pick side &&
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 977c498..84f14fd 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -13,20 +13,20 @@ test_description=3D'git rebase --merge --skip tests=
'
 test_expect_success setup '
 	echo hello > hello &&
 	git add hello &&
-	git commit -m "hello" &&
+	git commit -m "h=E4llo" &&
 	git branch skip-reference &&
=20
 	echo world >> hello &&
-	git commit -a -m "hello world" &&
+	git commit -a -m "h=E4llo world" &&
 	echo goodbye >> hello &&
-	git commit -a -m "goodbye" &&
+	git commit -a -m "g=F6=F6dbye" &&
=20
 	git checkout -f skip-reference &&
 	echo moo > hello &&
-	git commit -a -m "we should skip this" &&
+	git commit -a -m "we sh=F6ld skip this" &&
 	echo moo > cow &&
 	git add cow &&
-	git commit -m "this should not be skipped" &&
+	git commit -m "this sh=F6d not be skipped" &&
 	git branch pre-rebase skip-reference &&
 	git branch skip-merge skip-reference
 	'
--=20
1.6.3.dirty
