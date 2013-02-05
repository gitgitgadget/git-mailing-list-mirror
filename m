From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 01/13] contrib/subtree: Remove Test Number Comments
Date: Tue,  5 Feb 2013 05:36:47 -0600
Message-ID: <1360064219-28789-2-git-send-email-greened@obbligato.org>
References: <1360064219-28789-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 12:38:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2gr1-0000c5-Qf
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 12:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab3BELhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 06:37:51 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:38193 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751234Ab3BELhu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 06:37:50 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U2grR-00055A-Iv; Tue, 05 Feb 2013 05:38:50 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360064219-28789-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: "David A. Greene" <greened@obbligato.org> Delete the
    comments indicating test numbers as it causes maintenance headaches. t*.sh
    -i will help us find any broken tests. Signed-off-by: David A. Greene <greened@obbligato.org>
    --- contrib/subtree/t/t7900-subtree.sh | 55 1 file changed, 55 deletions(-)
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215483>

From: "David A. Greene" <greened@obbligato.org>

Delete the comments indicating test numbers as it causes maintenance
headaches.  t*.sh -i will help us find any broken tests.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/t/t7900-subtree.sh |   55 ------------------------------------
 1 file changed, 55 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index bc2eeb0..6cf9fb9 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -60,7 +60,6 @@ last_commit_message()
 	git log --pretty=format:%s -1
 }
 
-# 1
 test_expect_success 'init subproj' '
         test_create_repo subproj
 '
@@ -68,7 +67,6 @@ test_expect_success 'init subproj' '
 # To the subproject!
 cd subproj
 
-# 2
 test_expect_success 'add sub1' '
         create sub1 &&
         git commit -m "sub1" &&
@@ -76,14 +74,12 @@ test_expect_success 'add sub1' '
         git branch -m master subproj
 '
 
-# 3
 test_expect_success 'add sub2' '
         create sub2 &&
         git commit -m "sub2" &&
         git branch sub2
 '
 
-# 4
 test_expect_success 'add sub3' '
         create sub3 &&
         git commit -m "sub3" &&
@@ -93,7 +89,6 @@ test_expect_success 'add sub3' '
 # Back to mainline
 cd ..
 
-# 5
 test_expect_success 'add main4' '
         create main4 &&
         git commit -m "main4" &&
@@ -101,101 +96,85 @@ test_expect_success 'add main4' '
         git branch subdir
 '
 
-# 6
 test_expect_success 'fetch subproj history' '
         git fetch ./subproj sub1 &&
         git branch sub1 FETCH_HEAD
 '
 
-# 7
 test_expect_success 'no subtree exists in main tree' '
         test_must_fail git subtree merge --prefix=subdir sub1
 '
 
-# 8
 test_expect_success 'no pull from non-existant subtree' '
         test_must_fail git subtree pull --prefix=subdir ./subproj sub1
 '
 
-# 9
 test_expect_success 'check if --message works for add' '
         git subtree add --prefix=subdir --message="Added subproject" sub1 &&
         check_equal ''"$(last_commit_message)"'' "Added subproject" &&
         undo
 '
 
-# 10
 test_expect_success 'check if --message works as -m and --prefix as -P' '
         git subtree add -P subdir -m "Added subproject using git subtree" sub1 &&
         check_equal ''"$(last_commit_message)"'' "Added subproject using git subtree" &&
         undo
 '
 
-# 11
 test_expect_success 'check if --message works with squash too' '
         git subtree add -P subdir -m "Added subproject with squash" --squash sub1 &&
         check_equal ''"$(last_commit_message)"'' "Added subproject with squash" &&
         undo
 '
 
-# 12
 test_expect_success 'add subproj to mainline' '
         git subtree add --prefix=subdir/ FETCH_HEAD &&
         check_equal ''"$(last_commit_message)"'' "Add '"'subdir/'"' from commit '"'"'''"$(git rev-parse sub1)"'''"'"'"
 '
 
-# 13
 # this shouldn't actually do anything, since FETCH_HEAD is already a parent
 test_expect_success 'merge fetched subproj' '
         git merge -m "merge -s -ours" -s ours FETCH_HEAD
 '
 
-# 14
 test_expect_success 'add main-sub5' '
         create subdir/main-sub5 &&
         git commit -m "main-sub5"
 '
 
-# 15
 test_expect_success 'add main6' '
         create main6 &&
         git commit -m "main6 boring"
 '
 
-# 16
 test_expect_success 'add main-sub7' '
         create subdir/main-sub7 &&
         git commit -m "main-sub7"
 '
 
-# 17
 test_expect_success 'fetch new subproj history' '
         git fetch ./subproj sub2 &&
         git branch sub2 FETCH_HEAD
 '
 
-# 18
 test_expect_success 'check if --message works for merge' '
         git subtree merge --prefix=subdir -m "Merged changes from subproject" sub2 &&
         check_equal ''"$(last_commit_message)"'' "Merged changes from subproject" &&
         undo
 '
 
-# 19
 test_expect_success 'check if --message for merge works with squash too' '
         git subtree merge --prefix subdir -m "Merged changes from subproject using squash" --squash sub2 &&
         check_equal ''"$(last_commit_message)"'' "Merged changes from subproject using squash" &&
         undo
 '
 
-# 20
 test_expect_success 'merge new subproj history into subdir' '
         git subtree merge --prefix=subdir FETCH_HEAD &&
         git branch pre-split &&
         check_equal ''"$(last_commit_message)"'' "Merge commit '"'"'"$(git rev-parse sub2)"'"'"' into mainline"
 '
 
-# 21
 test_expect_success 'Check that prefix argument is required for split' '
         echo "You must provide the --prefix option." > expected &&
         test_must_fail git subtree split > actual 2>&1 &&
@@ -207,7 +186,6 @@ test_expect_success 'Check that prefix argument is required for split' '
         rm -f expected actual
 '
 
-# 22
 test_expect_success 'Check that the <prefix> exists for a split' '
         echo "'"'"'non-existent-directory'"'"'" does not exist\; use "'"'"'git subtree add'"'"'" > expected &&
         test_must_fail git subtree split --prefix=non-existent-directory > actual 2>&1 &&
@@ -219,7 +197,6 @@ test_expect_success 'Check that the <prefix> exists for a split' '
 #        rm -f expected actual
 '
 
-# 23
 test_expect_success 'check if --message works for split+rejoin' '
         spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
         git branch spl1 "$spl1" &&
@@ -227,7 +204,6 @@ test_expect_success 'check if --message works for split+rejoin' '
         undo
 '
 
-# 24
 test_expect_success 'check split with --branch' '
         spl1=$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin) &&
         undo &&
@@ -235,7 +211,6 @@ test_expect_success 'check split with --branch' '
         check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"
 '
 
-# 25
 test_expect_success 'check split with --branch for an existing branch' '
         spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
         undo &&
@@ -244,13 +219,10 @@ test_expect_success 'check split with --branch for an existing branch' '
         check_equal ''"$(git rev-parse splitbr2)"'' "$spl1"
 '
 
-# 26
 test_expect_success 'check split with --branch for an incompatible branch' '
         test_must_fail git subtree split --prefix subdir --onto FETCH_HEAD --branch subdir
 '
 
-
-# 27
 test_expect_success 'check split+rejoin' '
         spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
         undo &&
@@ -258,7 +230,6 @@ test_expect_success 'check split+rejoin' '
         check_equal ''"$(last_commit_message)"'' "Split '"'"'subdir/'"'"' into commit '"'"'"$spl1"'"'"'"
 '
 
-# 28
 test_expect_success 'add main-sub8' '
         create subdir/main-sub8 &&
         git commit -m "main-sub8"
@@ -267,14 +238,12 @@ test_expect_success 'add main-sub8' '
 # To the subproject!
 cd ./subproj
 
-# 29
 test_expect_success 'merge split into subproj' '
         git fetch .. spl1 &&
         git branch spl1 FETCH_HEAD &&
         git merge FETCH_HEAD
 '
 
-# 30
 test_expect_success 'add sub9' '
         create sub9 &&
         git commit -m "sub9"
@@ -283,19 +252,16 @@ test_expect_success 'add sub9' '
 # Back to mainline
 cd ..
 
-# 31
 test_expect_success 'split for sub8' '
         split2=''"$(git subtree split --annotate='"'*'"' --prefix subdir/ --rejoin)"''
         git branch split2 "$split2"
 '
 
-# 32
 test_expect_success 'add main-sub10' '
         create subdir/main-sub10 &&
         git commit -m "main-sub10"
 '
 
-# 33
 test_expect_success 'split for sub10' '
         spl3=''"$(git subtree split --annotate='"'*'"' --prefix subdir --rejoin)"'' &&
         git branch spl3 "$spl3"
@@ -304,7 +270,6 @@ test_expect_success 'split for sub10' '
 # To the subproject!
 cd ./subproj
 
-# 34
 test_expect_success 'merge split into subproj' '
         git fetch .. spl3 &&
         git branch spl3 FETCH_HEAD &&
@@ -318,13 +283,11 @@ chkms_sub=$(echo $chkms | multiline | sed 's,^,subdir/,' | fixnl)
 chks="sub1 sub2 sub3 sub9"
 chks_sub=$(echo $chks | multiline | sed 's,^,subdir/,' | fixnl)
 
-# 35
 test_expect_success 'make sure exactly the right set of files ends up in the subproj' '
         subfiles=''"$(git ls-files | fixnl)"'' &&
         check_equal "$subfiles" "$chkms $chks"
 '
 
-# 36
 test_expect_success 'make sure the subproj history *only* contains commits that affect the subdir' '
         allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | fixnl)"'' &&
         check_equal "$allchanges" "$chkms $chks"
@@ -333,20 +296,17 @@ test_expect_success 'make sure the subproj history *only* contains commits that
 # Back to mainline
 cd ..
 
-# 37
 test_expect_success 'pull from subproj' '
         git fetch ./subproj subproj-merge-spl3 &&
         git branch subproj-merge-spl3 FETCH_HEAD &&
         git subtree pull --prefix=subdir ./subproj subproj-merge-spl3
 '
 
-# 38
 test_expect_success 'make sure exactly the right set of files ends up in the mainline' '
         mainfiles=''"$(git ls-files | fixnl)"'' &&
         check_equal "$mainfiles" "$chkm $chkms_sub $chks_sub"
 '
 
-# 39
 test_expect_success 'make sure each filename changed exactly once in the entire history' '
         # main-sub?? and /subdir/main-sub?? both change, because those are the
         # changes that were split into their own history.  And subdir/sub?? never
@@ -355,12 +315,10 @@ test_expect_success 'make sure each filename changed exactly once in the entire
         check_equal "$allchanges" ''"$(echo $chkms $chkm $chks $chkms_sub | multiline | sort | fixnl)"''
 '
 
-# 40
 test_expect_success 'make sure the --rejoin commits never make it into subproj' '
         check_equal ''"$(git log --pretty=format:'"'%s'"' HEAD^2 | grep -i split)"'' ""
 '
 
-# 41
 test_expect_success 'make sure no "git subtree" tagged commits make it into subproj' '
         # They are meaningless to subproj since one side of the merge refers to the mainline
         check_equal ''"$(git log --pretty=format:'"'%s%n%b'"' HEAD^2 | grep "git-subtree.*:")"'' ""
@@ -370,14 +328,12 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 mkdir test2
 cd test2
 
-# 42
 test_expect_success 'init main' '
         test_create_repo main
 '
 
 cd main
 
-# 43
 test_expect_success 'add main1' '
         create main1 &&
         git commit -m "main1"
@@ -385,14 +341,12 @@ test_expect_success 'add main1' '
 
 cd ..
 
-# 44
 test_expect_success 'init sub' '
         test_create_repo sub
 '
 
 cd sub
 
-# 45
 test_expect_success 'add sub2' '
         create sub2 &&
         git commit -m "sub2"
@@ -402,7 +356,6 @@ cd ../main
 
 # check if split can find proper base without --onto
 
-# 46
 test_expect_success 'add sub as subdir in main' '
         git fetch ../sub master &&
         git branch sub2 FETCH_HEAD &&
@@ -411,7 +364,6 @@ test_expect_success 'add sub as subdir in main' '
 
 cd ../sub
 
-# 47
 test_expect_success 'add sub3' '
         create sub3 &&
         git commit -m "sub3"
@@ -419,20 +371,17 @@ test_expect_success 'add sub3' '
 
 cd ../main
 
-# 48
 test_expect_success 'merge from sub' '
         git fetch ../sub master &&
         git branch sub3 FETCH_HEAD &&
         git subtree merge --prefix subdir sub3
 '
 
-# 49
 test_expect_success 'add main-sub4' '
         create subdir/main-sub4 &&
         git commit -m "main-sub4"
 '
 
-# 50
 test_expect_success 'split for main-sub4 without --onto' '
         git subtree split --prefix subdir --branch mainsub4
 '
@@ -442,19 +391,16 @@ test_expect_success 'split for main-sub4 without --onto' '
 # have been sub3, but it was not, because its cache was not set to
 # itself)
 
-# 51
 test_expect_success 'check that the commit parent is sub3' '
         check_equal ''"$(git log --pretty=format:%P -1 mainsub4)"'' ''"$(git rev-parse sub3)"''
 '
 
-# 52
 test_expect_success 'add main-sub5' '
         mkdir subdir2 &&
         create subdir2/main-sub5 &&
         git commit -m "main-sub5"
 '
 
-# 53
 test_expect_success 'split for main-sub5 without --onto' '
         # also test that we still can split out an entirely new subtree
         # if the parent of the first commit in the tree is not empty,
@@ -487,7 +433,6 @@ joincommits()
 	echo "$commit $all"
 }
 
-# 54
 test_expect_success 'verify one file change per commit' '
         x= &&
         list=''"$(git log --pretty=format:'"'commit: %H'"' | joincommits)"'' &&
-- 
1.7.10.4
