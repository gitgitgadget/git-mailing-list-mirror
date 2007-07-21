From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 2/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 14:34:55 +0200
Message-ID: <200707211434.56622.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <20070721080338.GT32566@spearce.org> <200707211433.29318.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 14:34:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICEAg-0007un-8Z
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 14:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761865AbXGUMeu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 08:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761890AbXGUMeu
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 08:34:50 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:36273 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761865AbXGUMet convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 08:34:49 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6LCYgZV030829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 21 Jul 2007 14:34:42 +0200
Received: from [192.168.2.102] (p549012DA.dip0.t-ipconnect.de [84.144.18.218])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6LCYdGm006052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 14:34:40 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <200707211433.29318.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53161>

>From d2d2dde44790c3d239d69d7250e9949b6ff002c2 Mon Sep 17 00:00:00 2001
From: Christian Stimming <chs@ckiste.goetheallee>
Date: Sat, 21 Jul 2007 14:21:34 +0200
Subject: [PATCH] Mark strings for translation.

The procedure [mc ...] will translate the strings through msgcat.
Strings must be enclosed in quotes, not in braces, because otherwise
xgettext cannot extract them properly, although on the Tcl side both
delimiters would work fine.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---

Here I marked much more strings than in the previous patch, and as discussed
the procedure [mc ...] is used for translation. Actually I think this pretty much 
caught all occurrences of user-visible strings in *this* file; there will be many
more strings in all the other files, of course.

 git-gui.sh |  170 ++++++++++++++++++++++++++++++------------------------------
 1 files changed, 85 insertions(+), 85 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 0c5ca46..95dac55 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1653,18 +1653,18 @@ set ui_comm {}
 # -- Menu Bar
 #
 menu .mbar -tearoff 0
-.mbar add cascade -label Repository -menu .mbar.repository
-.mbar add cascade -label Edit -menu .mbar.edit
+.mbar add cascade -label [mc Repository] -menu .mbar.repository
+.mbar add cascade -label [mc Edit] -menu .mbar.edit
 if {[is_enabled branch]} {
-	.mbar add cascade -label Branch -menu .mbar.branch
+	.mbar add cascade -label [mc Branch] -menu .mbar.branch
 }
 if {[is_enabled multicommit] || [is_enabled singlecommit]} {
-	.mbar add cascade -label Commit -menu .mbar.commit
+	.mbar add cascade -label [mc Commit] -menu .mbar.commit
 }
 if {[is_enabled transport]} {
-	.mbar add cascade -label Merge -menu .mbar.merge
-	.mbar add cascade -label Fetch -menu .mbar.fetch
-	.mbar add cascade -label Push -menu .mbar.push
+	.mbar add cascade -label [mc Merge] -menu .mbar.merge
+	.mbar add cascade -label [mc Fetch] -menu .mbar.fetch
+	.mbar add cascade -label [mc Push] -menu .mbar.push
 }
 . configure -menu .mbar
 
@@ -1673,7 +1673,7 @@ if {[is_enabled transport]} {
 menu .mbar.repository
 
 .mbar.repository add command \
-	-label {Browse Current Branch's Files} \
+	-label [mc "Browse Current Branch's Files"] \
 	-command {browser::new $current_branch}
 trace add variable current_branch write ".mbar.repository entryconf [.mbar.repository index last] -label \"Browse \$current_branch's Files\" ;#"
 .mbar.repository add command \
@@ -1682,69 +1682,69 @@ trace add variable current_branch write ".mbar.repository entryconf [.mbar.repos
 .mbar.repository add separator
 
 .mbar.repository add command \
-	-label {Visualize Current Branch's History} \
+	-label [mc "Visualize Current Branch's History"] \
 	-command {do_gitk $current_branch}
 trace add variable current_branch write ".mbar.repository entryconf [.mbar.repository index last] -label \"Visualize \$current_branch's History\" ;#"
 .mbar.repository add command \
-	-label {Visualize All Branch History} \
+	-label [mc "Visualize All Branch History"] \
 	-command {do_gitk --all}
 .mbar.repository add separator
 
 if {[is_enabled multicommit]} {
-	.mbar.repository add command -label {Database Statistics} \
+	.mbar.repository add command -label [mc "Database Statistics"] \
 		-command do_stats
 
-	.mbar.repository add command -label {Compress Database} \
+	.mbar.repository add command -label [mc "Compress Database"] \
 		-command do_gc
 
-	.mbar.repository add command -label {Verify Database} \
+	.mbar.repository add command -label [mc "Verify Database"] \
 		-command do_fsck_objects
 
 	.mbar.repository add separator
 
 	if {[is_Cygwin]} {
 		.mbar.repository add command \
-			-label {Create Desktop Icon} \
+			-label [mc "Create Desktop Icon"] \
 			-command do_cygwin_shortcut
 	} elseif {[is_Windows]} {
 		.mbar.repository add command \
-			-label {Create Desktop Icon} \
+			-label [mc "Create Desktop Icon"] \
 			-command do_windows_shortcut
 	} elseif {[is_MacOSX]} {
 		.mbar.repository add command \
-			-label {Create Desktop Icon} \
+			-label [mc "Create Desktop Icon"] \
 			-command do_macosx_app
 	}
 }
 
-.mbar.repository add command -label Quit \
+.mbar.repository add command -label [mc Quit] \
 	-command do_quit \
 	-accelerator $M1T-Q
 
 # -- Edit Menu
 #
 menu .mbar.edit
-.mbar.edit add command -label Undo \
+.mbar.edit add command -label [mc Undo] \
 	-command {catch {[focus] edit undo}} \
 	-accelerator $M1T-Z
-.mbar.edit add command -label Redo \
+.mbar.edit add command -label [mc Redo] \
 	-command {catch {[focus] edit redo}} \
 	-accelerator $M1T-Y
 .mbar.edit add separator
-.mbar.edit add command -label Cut \
+.mbar.edit add command -label [mc Cut] \
 	-command {catch {tk_textCut [focus]}} \
 	-accelerator $M1T-X
-.mbar.edit add command -label Copy \
+.mbar.edit add command -label [mc Copy] \
 	-command {catch {tk_textCopy [focus]}} \
 	-accelerator $M1T-C
-.mbar.edit add command -label Paste \
+.mbar.edit add command -label [mc Paste] \
 	-command {catch {tk_textPaste [focus]; [focus] see insert}} \
 	-accelerator $M1T-V
-.mbar.edit add command -label Delete \
+.mbar.edit add command -label [mc Delete] \
 	-command {catch {[focus] delete sel.first sel.last}} \
 	-accelerator Del
 .mbar.edit add separator
-.mbar.edit add command -label {Select All} \
+.mbar.edit add command -label [mc "Select All"] \
 	-command {catch {[focus] tag add sel 0.0 end}} \
 	-accelerator $M1T-A
 
@@ -1753,29 +1753,29 @@ menu .mbar.edit
 if {[is_enabled branch]} {
 	menu .mbar.branch
 
-	.mbar.branch add command -label {Create...} \
+	.mbar.branch add command -label [mc "Create..."] \
 		-command branch_create::dialog \
 		-accelerator $M1T-N
 	lappend disable_on_lock [list .mbar.branch entryconf \
 		[.mbar.branch index last] -state]
 
-	.mbar.branch add command -label {Checkout...} \
+	.mbar.branch add command -label [mc "Checkout..."] \
 		-command branch_checkout::dialog \
 		-accelerator $M1T-O
 	lappend disable_on_lock [list .mbar.branch entryconf \
 		[.mbar.branch index last] -state]
 
-	.mbar.branch add command -label {Rename...} \
+	.mbar.branch add command -label [mc "Rename..."] \
 		-command branch_rename::dialog
 	lappend disable_on_lock [list .mbar.branch entryconf \
 		[.mbar.branch index last] -state]
 
-	.mbar.branch add command -label {Delete...} \
+	.mbar.branch add command -label [mc "Delete..."] \
 		-command branch_delete::dialog
 	lappend disable_on_lock [list .mbar.branch entryconf \
 		[.mbar.branch index last] -state]
 
-	.mbar.branch add command -label {Reset...} \
+	.mbar.branch add command -label [mc "Reset..."] \
 		-command merge::reset_hard
 	lappend disable_on_lock [list .mbar.branch entryconf \
 		[.mbar.branch index last] -state]
@@ -1787,7 +1787,7 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 	menu .mbar.commit
 
 	.mbar.commit add radiobutton \
-		-label {New Commit} \
+		-label [mc "New Commit"] \
 		-command do_select_commit_type \
 		-variable selected_commit_type \
 		-value new
@@ -1795,7 +1795,7 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
 	.mbar.commit add radiobutton \
-		-label {Amend Last Commit} \
+		-label [mc "Amend Last Commit"] \
 		-command do_select_commit_type \
 		-variable selected_commit_type \
 		-value amend
@@ -1804,40 +1804,40 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 
 	.mbar.commit add separator
 
-	.mbar.commit add command -label Rescan \
+	.mbar.commit add command -label [mc Rescan] \
 		-command do_rescan \
 		-accelerator F5
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
-	.mbar.commit add command -label {Add To Commit} \
+	.mbar.commit add command -label [mc "Add To Commit"] \
 		-command do_add_selection
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
-	.mbar.commit add command -label {Add Existing To Commit} \
+	.mbar.commit add command -label [mc "Add Existing To Commit"] \
 		-command do_add_all \
 		-accelerator $M1T-I
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
-	.mbar.commit add command -label {Unstage From Commit} \
+	.mbar.commit add command -label [mc "Unstage From Commit"] \
 		-command do_unstage_selection
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
-	.mbar.commit add command -label {Revert Changes} \
+	.mbar.commit add command -label [mc "Revert Changes"] \
 		-command do_revert_selection
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
 	.mbar.commit add separator
 
-	.mbar.commit add command -label {Sign Off} \
+	.mbar.commit add command -label [mc "Sign Off"] \
 		-command do_signoff \
 		-accelerator $M1T-S
 
-	.mbar.commit add command -label Commit \
+	.mbar.commit add command -label [mc Commit] \
 		-command do_commit \
 		-accelerator $M1T-Return
 	lappend disable_on_lock \
@@ -1848,12 +1848,12 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 #
 if {[is_enabled branch]} {
 	menu .mbar.merge
-	.mbar.merge add command -label {Local Merge...} \
+	.mbar.merge add command -label [mc "Local Merge..."] \
 		-command merge::dialog \
 		-accelerator $M1T-M
 	lappend disable_on_lock \
 		[list .mbar.merge entryconf [.mbar.merge index last] -state]
-	.mbar.merge add command -label {Abort Merge...} \
+	.mbar.merge add command -label [mc "Abort Merge..."] \
 		-command merge::reset_hard
 	lappend disable_on_lock \
 		[list .mbar.merge entryconf [.mbar.merge index last] -state]
@@ -1865,28 +1865,28 @@ if {[is_enabled transport]} {
 	menu .mbar.fetch
 
 	menu .mbar.push
-	.mbar.push add command -label {Push...} \
+	.mbar.push add command -label [mc "Push..."] \
 		-command do_push_anywhere \
 		-accelerator $M1T-P
-	.mbar.push add command -label {Delete...} \
+	.mbar.push add command -label [mc "Delete..."] \
 		-command remote_branch_delete::dialog
 }
 
 if {[is_MacOSX]} {
 	# -- Apple Menu (Mac OS X only)
 	#
-	.mbar add cascade -label Apple -menu .mbar.apple
+	.mbar add cascade -label [mc Apple] -menu .mbar.apple
 	menu .mbar.apple
 
-	.mbar.apple add command -label "About [appname]" \
+	.mbar.apple add command -label [mc "About %s" appname] \
 		-command do_about
-	.mbar.apple add command -label "Options..." \
+	.mbar.apple add command -label [mc "Options..."] \
 		-command do_options
 } else {
 	# -- Edit Menu
 	#
 	.mbar.edit add separator
-	.mbar.edit add command -label {Options...} \
+	.mbar.edit add command -label [mc "Options..."] \
 		-command do_options
 
 	# -- Tools Menu
@@ -1921,11 +1921,11 @@ if {[is_MacOSX]} {
 
 # -- Help Menu
 #
-.mbar add cascade -label Help -menu .mbar.help
+.mbar add cascade -label [mc Help] -menu .mbar.help
 menu .mbar.help
 
 if {![is_MacOSX]} {
-	.mbar.help add command -label "About [appname]" \
+	.mbar.help add command -label [mc "About %s" appname] \
 		-command do_about
 }
 
@@ -1962,7 +1962,7 @@ if {[file isfile $doc_path]} {
 }
 
 if {$browser ne {}} {
-	.mbar.help add command -label {Online Documentation} \
+	.mbar.help add command -label [mc "Online Documentation"] \
 		-command [list exec $browser $doc_url &]
 }
 unset browser doc_path doc_url
@@ -2078,7 +2078,7 @@ frame .branch \
 	-borderwidth 1 \
 	-relief sunken
 label .branch.l1 \
-	-text {Current Branch:} \
+	-text [mc "Current Branch:"] \
 	-anchor w \
 	-justify left
 label .branch.cb \
@@ -2099,7 +2099,7 @@ pack .vpane -anchor n -side top -fill both -expand 1
 # -- Index File List
 #
 frame .vpane.files.index -height 100 -width 200
-label .vpane.files.index.title -text {Staged Changes (Will Be Committed)} \
+label .vpane.files.index.title -text [mc "Staged Changes (Will Be Committed)"] \
 	-background lightgreen
 text $ui_index -background white -borderwidth 0 \
 	-width 20 -height 10 \
@@ -2119,7 +2119,7 @@ pack $ui_index -side left -fill both -expand 1
 # -- Working Directory File List
 #
 frame .vpane.files.workdir -height 100 -width 200
-label .vpane.files.workdir.title -text {Unstaged Changes (Will Not Be Committed)} \
+label .vpane.files.workdir.title -text [mc "Unstaged Changes (Will Not Be Committed)"] \
 	-background lightsalmon
 text $ui_workdir -background white -borderwidth 0 \
 	-width 20 -height 10 \
@@ -2160,29 +2160,29 @@ label .vpane.lower.commarea.buttons.l -text {} \
 pack .vpane.lower.commarea.buttons.l -side top -fill x
 pack .vpane.lower.commarea.buttons -side left -fill y
 
-button .vpane.lower.commarea.buttons.rescan -text {Rescan} \
+button .vpane.lower.commarea.buttons.rescan -text [mc Rescan] \
 	-command do_rescan
 pack .vpane.lower.commarea.buttons.rescan -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.rescan conf -state}
 
-button .vpane.lower.commarea.buttons.incall -text {Add Existing} \
+button .vpane.lower.commarea.buttons.incall -text [mc "Add Existing"] \
 	-command do_add_all
 pack .vpane.lower.commarea.buttons.incall -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.incall conf -state}
 
-button .vpane.lower.commarea.buttons.signoff -text {Sign Off} \
+button .vpane.lower.commarea.buttons.signoff -text [mc "Sign Off"] \
 	-command do_signoff
 pack .vpane.lower.commarea.buttons.signoff -side top -fill x
 
-button .vpane.lower.commarea.buttons.commit -text {Commit} \
+button .vpane.lower.commarea.buttons.commit -text [mc Commit] \
 	-command do_commit
 pack .vpane.lower.commarea.buttons.commit -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.commit conf -state}
 
-button .vpane.lower.commarea.buttons.push -text {Push} \
+button .vpane.lower.commarea.buttons.push -text [mc Push] \
 	-command do_push_anywhere
 pack .vpane.lower.commarea.buttons.push -side top -fill x
 
@@ -2193,14 +2193,14 @@ frame .vpane.lower.commarea.buffer.header
 set ui_comm .vpane.lower.commarea.buffer.t
 set ui_coml .vpane.lower.commarea.buffer.header.l
 radiobutton .vpane.lower.commarea.buffer.header.new \
-	-text {New Commit} \
+	-text [mc "New Commit"] \
 	-command do_select_commit_type \
 	-variable selected_commit_type \
 	-value new
 lappend disable_on_lock \
 	[list .vpane.lower.commarea.buffer.header.new conf -state]
 radiobutton .vpane.lower.commarea.buffer.header.amend \
-	-text {Amend Last Commit} \
+	-text [mc "Amend Last Commit"] \
 	-command do_select_commit_type \
 	-variable selected_commit_type \
 	-value amend
@@ -2212,12 +2212,12 @@ label $ui_coml \
 proc trace_commit_type {varname args} {
 	global ui_coml commit_type
 	switch -glob -- $commit_type {
-	initial       {set txt {Initial Commit Message:}}
-	amend         {set txt {Amended Commit Message:}}
-	amend-initial {set txt {Amended Initial Commit Message:}}
-	amend-merge   {set txt {Amended Merge Commit Message:}}
-	merge         {set txt {Merge Commit Message:}}
-	*             {set txt {Commit Message:}}
+	initial       {set txt [mc "Initial Commit Message:"]}
+	amend         {set txt [mc "Amended Commit Message:"]}
+	amend-initial {set txt [mc "Amended Initial Commit Message:"]}
+	amend-merge   {set txt [mc "Amended Merge Commit Message:"]}
+	merge         {set txt [mc "Merge Commit Message:"]}
+	*             {set txt [mc "Commit Message:"]}
 	}
 	$ui_coml conf -text $txt
 }
@@ -2246,23 +2246,23 @@ pack .vpane.lower.commarea.buffer -side left -fill y
 set ctxm .vpane.lower.commarea.buffer.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
-	-label {Cut} \
+	-label [mc Cut] \
 	-command {tk_textCut $ui_comm}
 $ctxm add command \
-	-label {Copy} \
+	-label [mc Copy] \
 	-command {tk_textCopy $ui_comm}
 $ctxm add command \
-	-label {Paste} \
+	-label [mc Paste] \
 	-command {tk_textPaste $ui_comm}
 $ctxm add command \
-	-label {Delete} \
+	-label [mc Delete] \
 	-command {$ui_comm delete sel.first sel.last}
 $ctxm add separator
 $ctxm add command \
-	-label {Select All} \
+	-label [mc "Select All"] \
 	-command {focus $ui_comm;$ui_comm tag add sel 0.0 end}
 $ctxm add command \
-	-label {Copy All} \
+	-label [mc "Copy All"] \
 	-command {
 		$ui_comm tag add sel 0.0 end
 		tk_textCopy $ui_comm
@@ -2270,7 +2270,7 @@ $ctxm add command \
 	}
 $ctxm add separator
 $ctxm add command \
-	-label {Sign Off} \
+	-label [mc "Sign Off"] \
 	-command do_signoff
 bind_button3 $ui_comm "tk_popup $ctxm %X %Y"
 
@@ -2320,7 +2320,7 @@ pack .vpane.lower.diff.header.path -fill x
 set ctxm .vpane.lower.diff.header.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
-	-label {Copy} \
+	-label [mc Copy] \
 	-command {
 		clipboard clear
 		clipboard append \
@@ -2388,19 +2388,19 @@ $ui_diff tag raise sel
 set ctxm .vpane.lower.diff.body.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
-	-label {Refresh} \
+	-label [mc Refresh] \
 	-command reshow_diff
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-	-label {Copy} \
+	-label [mc Copy] \
 	-command {tk_textCopy $ui_diff}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-	-label {Select All} \
+	-label [mc "Select All"] \
 	-command {focus $ui_diff;$ui_diff tag add sel 0.0 end}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-	-label {Copy All} \
+	-label [mc "Copy All"] \
 	-command {
 		$ui_diff tag add sel 0.0 end
 		tk_textCopy $ui_diff
@@ -2409,44 +2409,44 @@ $ctxm add command \
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
-	-label {Apply/Reverse Hunk} \
+	-label [mc "Apply/Reverse Hunk"] \
 	-command {apply_hunk $cursorX $cursorY}
 set ui_diff_applyhunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
 $ctxm add separator
 $ctxm add command \
-	-label {Decrease Font Size} \
+	-label [mc "Decrease Font Size"] \
 	-command {incr_font_size font_diff -1}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-	-label {Increase Font Size} \
+	-label [mc "Increase Font Size"] \
 	-command {incr_font_size font_diff 1}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
-	-label {Show Less Context} \
+	-label [mc "Show Less Context"] \
 	-command {if {$repo_config(gui.diffcontext) >= 1} {
 		incr repo_config(gui.diffcontext) -1
 		reshow_diff
 	}}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-	-label {Show More Context} \
+	-label [mc "Show More Context"] \
 	-command {if {$repo_config(gui.diffcontext) < 99} {
 		incr repo_config(gui.diffcontext)
 		reshow_diff
 	}}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
-$ctxm add command -label {Options...} \
+$ctxm add command -label [mc "Options..."] \
 	-command do_options
 bind_button3 $ui_diff "
 	set cursorX %x
 	set cursorY %y
 	if {\$ui_index eq \$current_diff_side} {
-		$ctxm entryconf $ui_diff_applyhunk -label {Unstage Hunk From Commit}
+		$ctxm entryconf $ui_diff_applyhunk -label [mc {Unstage Hunk From Commit}]
 	} else {
-		$ctxm entryconf $ui_diff_applyhunk -label {Stage Hunk For Commit}
+		$ctxm entryconf $ui_diff_applyhunk -label [mc {Stage Hunk For Commit}]
 	}
 	tk_popup $ctxm %X %Y
 "
-- 
1.5.2
