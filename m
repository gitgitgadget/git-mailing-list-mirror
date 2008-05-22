From: Barry Roberts <blr@robertsr.us>
Subject: Naughty, Evil git-gui patches
Date: Thu, 22 May 2008 10:32:10 -0600
Message-ID: <4835A00A.5050207@robertsr.us>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030905030703060804090306"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 18:33:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzDj4-0001pc-F5
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 18:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbYEVQcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 12:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbYEVQcS
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 12:32:18 -0400
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:42794 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753714AbYEVQcQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 May 2008 12:32:16 -0400
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA07.emeryville.ca.mail.comcast.net with comcast
	id Ug6C1Z00V0EPchoA702J00; Thu, 22 May 2008 16:32:15 +0000
Received: from dalmuti.xactvalue.com ([76.27.63.88])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id UgYA1Z00C1uEJYk8M00000; Thu, 22 May 2008 16:32:15 +0000
X-Authority-Analysis: v=1.0 c=1 a=iWQI3USln9kTMSq5zDoA:9
 a=NgCkMW8A3lPl_jDwlfQA:7 a=XTibHQs2_eO7C9TrfaRAdYOoDecA:4 a=gi0PWCVxevcA:10
 a=y7TVEcHJc2T3lR8QD6sA:9 a=OmmoXLiTLmZJGjWd398A:7
 a=2sRLL91hOgQGWl4M_zixTwTZU5IA:4 a=iYlkOlhu7C0A:10 a=1QHUsRB-rQ9eebc2-GEA:9
 a=tmZHWkg1nShYXVWqShUA:7 a=FJbrI8aU6SPNAVVlP6N045GEgGcA:4
 a=5nDtrUAYXKhw5VQiZrYA:9 a=ZD53-GNnew2MRoO-8cQA:7
 a=Ly-iZIZJVGLYfSG5TsK5YsPtuBQA:4 a=Tw3Gdg_SRJRLg2hUS88A:9
 a=vj0ws7R7EMJp7TcGGj0A:7 a=bNf_gVyugcRjUAQt2qN3kAgO7YoA:4
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82637>

This is a multi-part message in MIME format.
--------------030905030703060804090306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have no hope of these patches being accepted, this is just for 
discussion (and maybe education) purposes, so I attached them all here 
instead of sending individual messages and having to put the disclaimer 
on all of them.

The combination of compulsive command-line aversion among Windows users 
and git-gui not being oriented toward CVS-like usage almost killed our 
cvs->git transition.  These patches are emergency measures to appease 
point-and-clickers transitioning from CVS, but  written by someone who 
doesn't know TCL (or even git).  Written isn't even the appropriate 
word, most are cut&paste from existing git-gui code.

Disclaimers and excuses:
 0001 - All the CVS transition docs talk about pull, but not having it 
in the gui means it doesn't really exist for some users

0002 - I have read the reasons for having merge in the gui be more 
strict than 'git merge' from the command line, but 'cvs update' never 
gave a clean way to back out, so nobody here expects that anyway.

0003 -  Yeah, I want to list the stashes and select from available 
stashes to apply.  But this does the 80% of what we need (reducing 
command line usage), and my tcl sk1llz aren't that l33t.

0004 - This is just a concession to (I think) Tortoise.  Just before you 
commit, you notice that you left in a debug message.  This gives us an 
easy way to fix by diff before commit'ing.  This requires setting 
GIT_EXTERNAL_DIFF, or it's not very interesting.

My intention in sending these is to hopefully generate some discussion 
on how something like these changes can be done properly, with the 
exception of patch 0002, which I fully intend to maintain as a local patch.

Our developers are happy with git now.  Speed, topic branches, speed, 
easy merges from release branches, speed, and my bastard git-gui have 
won over the developers I work with AFAIK.  Thanks for a great suite of 
tools.

Barry Roberts


--------------030905030703060804090306
Content-Type: text/x-patch;
 name="0001-Add-a-simple-git-pull-to-the-menu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Add-a-simple-git-pull-to-the-menu.patch"

>From 1829aa454f8aad89fca460b0f3f86ecda6ca8556 Mon Sep 17 00:00:00 2001
From: Barry Roberts <blr@robertsr.us>
Date: Tue, 6 May 2008 11:31:52 -0600
Subject: [PATCH] Add a simple "git pull" to the menu.

---
 git-gui/git-gui.sh        |    3 +++
 git-gui/lib/transport.tcl |    9 +++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 7c25bb9..49c8580 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2110,6 +2110,9 @@ if {[is_enabled transport]} {
 	.mbar.remote add command \
 		-label [mc "Delete..."] \
 		-command remote_branch_delete::dialog
+        .mbar.remote add command \
+	    -label [mc "Pull..."] \
+	    -command do_pull
 }
 
 if {[is_MacOSX]} {
diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
index 8e6a9d0..30f1015 100644
--- a/git-gui/lib/transport.tcl
+++ b/git-gui/lib/transport.tcl
@@ -182,3 +182,12 @@ proc do_push_anywhere {} {
 	wm title $w [append "[appname] ([reponame]): " [mc "Push"]]
 	tkwait window $w
 }
+
+proc do_pull {} {
+	set w [console::new \
+		[mc "pull "] \
+		[mc "Pulling changes from default"]]
+	set cmd [list git pull]
+	lappend cmd -v
+	console::exec $w $cmd
+}
-- 
1.5.5.1.116.ge4b9c


--------------030905030703060804090306
Content-Type: text/x-patch;
 name="0002-Removed-strictness-of-merge.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-Removed-strictness-of-merge.patch"

>From 5bad6baa742fb719ada8c0bdcee959d36f2914f2 Mon Sep 17 00:00:00 2001
From: Barry Roberts <blr@robertsr.us>
Date: Tue, 6 May 2008 14:46:35 -0600
Subject: [PATCH] Removed strictness of merge

Started on stash, but that's a bigger project.
---
 git-gui/git-gui.sh    |   13 +++++++++++++
 git-gui/lib/merge.tcl |   10 ----------
 git-gui/lib/stash.tcl |    6 ++++++
 3 files changed, 19 insertions(+), 10 deletions(-)
 create mode 100644 git-gui/lib/stash.tcl

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 49c8580..63c9e09 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -874,6 +874,7 @@ if {$subcommand eq {gui} && [llength $argv] > 0} {
 enable_option multicommit
 enable_option branch
 enable_option transport
+disable_option stash
 disable_option bare
 
 switch -- $subcommand {
@@ -2137,6 +2138,18 @@ if {[is_MacOSX]} {
 		-command do_options
 }
 
+# -- Stash Menu
+#
+
+if {[is_enabled stash]} {
+	.mbar add cascade -label [mc Stash] -menu .mbar.stash
+	menu .mbar.stash
+
+	.mbar.stash add command \
+		-label [mc "List"] \
+		-command do_stash_list
+}
+
 # -- Help Menu
 #
 .mbar add cascade -label [mc Help] -menu .mbar.help
diff --git a/git-gui/lib/merge.tcl b/git-gui/lib/merge.tcl
index cc26b07..d4c44c2 100644
--- a/git-gui/lib/merge.tcl
+++ b/git-gui/lib/merge.tcl
@@ -50,16 +50,6 @@ You must resolve them, stage the file, and commit to complete the current merge.
 			unlock_index
 			return 0
 		}
-		?? {
-			error_popup [mc "You are in the middle of a change.
-
-File %s is modified.
-
-You should complete the current commit before starting a merge.  Doing so will help you abort a failed merge, should the need arise.
-" [short_path $path]]
-			unlock_index
-			return 0
-		}
 		}
 	}
 
diff --git a/git-gui/lib/stash.tcl b/git-gui/lib/stash.tcl
new file mode 100644
index 0000000..4ff2d20
--- /dev/null
+++ b/git-gui/lib/stash.tcl
@@ -0,0 +1,6 @@
+# git stash support
+#
+
+proc do_stash_list {} {
+	error_popup [mc "do_stash_list called."]
+}
\ No newline at end of file
-- 
1.5.5.1.116.ge4b9c


--------------030905030703060804090306
Content-Type: text/x-patch;
 name="0003-Added-VERY-simple-stash.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0003-Added-VERY-simple-stash.patch"

>From ae77b093e71335d2c2941677e5c366dc31732773 Mon Sep 17 00:00:00 2001
From: Barry Roberts <blr@robertsr.us>
Date: Wed, 7 May 2008 09:20:50 -0600
Subject: [PATCH] Added VERY simple stash

Don't forget to manually re-scan after saving or applyling
---
 git-gui/git-gui.sh    |   11 ++++++++++-
 git-gui/lib/stash.tcl |   36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 63c9e09..0b201ec 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -874,7 +874,7 @@ if {$subcommand eq {gui} && [llength $argv] > 0} {
 enable_option multicommit
 enable_option branch
 enable_option transport
-disable_option stash
+enable_option stash
 disable_option bare
 
 switch -- $subcommand {
@@ -2148,6 +2148,15 @@ if {[is_enabled stash]} {
 	.mbar.stash add command \
 		-label [mc "List"] \
 		-command do_stash_list
+	.mbar.stash add command \
+		-label [mc "Apply"] \
+		-command do_stash_apply
+	.mbar.stash add command \
+		-label [mc "Save"] \
+		-command do_stash_save
+	.mbar.stash add command \
+		-label [mc "Drop"] \
+		-command do_stash_drop
 }
 
 # -- Help Menu
diff --git a/git-gui/lib/stash.tcl b/git-gui/lib/stash.tcl
index 4ff2d20..c2e40db 100644
--- a/git-gui/lib/stash.tcl
+++ b/git-gui/lib/stash.tcl
@@ -2,5 +2,37 @@
 #
 
 proc do_stash_list {} {
-	error_popup [mc "do_stash_list called."]
-}
\ No newline at end of file
+	set w [console::new \
+		[mc "stash"] \
+		[mc "Listing stashes"]]
+	set cmd [list git stash list]
+	lappend cmd -v
+	console::exec $w $cmd
+}
+
+proc do_stash_apply { } {
+	set w [console::new \
+		[mc "stash"] \
+		[mc "Applying stash"]]
+	set cmd [list git stash apply]
+	lappend cmd -v
+	console::exec $w $cmd
+	
+}
+
+proc do_stash_save { } {
+	set w [console::new \
+		[mc "stash"] \
+		[mc "Saving stash"]]
+	set cmd [list git stash save]
+	lappend cmd -v
+	console::exec $w $cmd
+}
+
+proc do_stash_drop { } {
+	set w [console::new \
+		[mc "stash"] \
+		[mc "Dropping stash"]]
+	set cmd [list git stash drop]
+	console::exec $w $cmd
+}
-- 
1.5.5.1.116.ge4b9c


--------------030905030703060804090306
Content-Type: text/x-patch;
 name="0004-Added-cheap-call-to-git-diff-for-ext-diff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0004-Added-cheap-call-to-git-diff-for-ext-diff.patch"

>From 53d911208cb867eab4a2a6d71bfa3d95bc9f2671 Mon Sep 17 00:00:00 2001
From: Barry Roberts <blr@robertsr.us>
Date: Thu, 8 May 2008 11:37:53 -0600
Subject: [PATCH] Added cheap call to git-diff for ext diff

---
 git-gui/git-gui.sh    |    3 +++
 git-gui/lib/index.tcl |   14 ++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 0b201ec..3b77e68 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2061,6 +2061,9 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
+	.mbar.commit add command -label [mc "External Diff"] \
+		-command do_ext_diff_selection
+
 	.mbar.commit add separator
 
 	.mbar.commit add command -label [mc "Show Less Context"] \
diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
index 3c1fce7..1e08664 100644
--- a/git-gui/lib/index.tcl
+++ b/git-gui/lib/index.tcl
@@ -435,3 +435,17 @@ proc do_select_commit_type {} {
 		}
 	}
 }
+
+proc do_ext_diff_selection { } {
+	global current_diff_path selected_paths
+
+	if {[array size selected_paths] > 0} {
+		error_popup [mc "Please select one file at a time for diffs"]
+	} elseif {$current_diff_path ne {}} {
+		set w [console::new \
+				   [mc "diff"] \
+				   [mc "Differencing"]]
+		set cmd [list git diff $current_diff_path]
+		console::exec $w $cmd
+	}
+}
\ No newline at end of file
-- 
1.5.5.1.116.ge4b9c


--------------030905030703060804090306--
