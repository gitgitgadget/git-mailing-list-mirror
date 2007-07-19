From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] Internationalization of git-gui
Date: Thu, 19 Jul 2007 12:56:57 +0200
Message-ID: <20070719125657.8utk85ynuow4ow48@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_22ekcyapv6gp"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 14:20:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBV02-00006E-5e
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 14:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXGSMUh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 08:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbXGSMUg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 08:20:36 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:54658 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbXGSMUe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 08:20:34 -0400
X-Greylist: delayed 5013 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jul 2007 08:20:33 EDT
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6JAuwOv014056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 19 Jul 2007 12:56:58 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6JAuvIH013511
	for <git@vger.kernel.org>; Thu, 19 Jul 2007 12:56:57 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id BFA9AE50343; Thu, 19 Jul 2007 12:56:57 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Thu, 19 Jul 2007
	12:56:57 +0200
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52979>

This message is in MIME format.

--=_22ekcyapv6gp
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This is an initial patch of how internationalization (i18n) in git  
could be done, starting with the git-gui application (because I need  
that one in German to convince my workplace of switching to git).

Does this implementation look okay? If yes, I'd happily i18n'ize the  
rest of git-gui and provide a full German translation as well.

Thanks,

Christian Stimming

--=_22ekcyapv6gp
Content-Type: text/x-patch;
	charset=UTF-8;
	name="0001-Initialize-msgcat-gettext.patch"
Content-Disposition: attachment;
	filename="0001-Initialize-msgcat-gettext.patch"
Content-Transfer-Encoding: 7bit

>From ea66070d95061e623cb5430fe88efea653e511e0 Mon Sep 17 00:00:00 2001
From: Christian Stimming <stimming@tuhh.de>
Date: Thu, 19 Jul 2007 12:48:08 +0200
Subject: [PATCH] Initialize msgcat (gettext).

---
 git-gui/git-gui.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 2077261..c56a3f1 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -108,6 +108,12 @@ if {$idx ne {}} {
 }
 unset -nocomplain oguirel idx fd
 
+## Internationalization (i18n) through gettext. See
+## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
+package require msgcat
+::msgcat::mcload [file join $oguilib msgs]
+proc _ {s} {return [::msgcat::mc $s]}
+
 ######################################################################
 ##
 ## read only globals
-- 
1.5.3.rc2.4.g726f9


--=_22ekcyapv6gp
Content-Type: text/x-patch;
	charset=UTF-8;
	name="0002-Mark-strings-for-translation.patch"
Content-Disposition: attachment;
	filename="0002-Mark-strings-for-translation.patch"
Content-Transfer-Encoding: quoted-printable

>From 154d29786bdda205357595e22b3385d7cdb77453 Mon Sep 17 00:00:00 2001
From: Christian Stimming <stimming@tuhh.de>
Date: Thu, 19 Jul 2007 12:49:09 +0200
Subject: [PATCH] Mark strings for translation

---
 git-gui/git-gui.sh |  154 ++++++++++++++++++++++++++-----------------------=
---
 1 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index c56a3f1..45b7ef1 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1618,18 +1618,18 @@ set ui_comm {}
 # -- Menu Bar
 #
 menu .mbar -tearoff 0
-.mbar add cascade -label Repository -menu .mbar.repository
-.mbar add cascade -label Edit -menu .mbar.edit
+.mbar add cascade -label [_ Repository] -menu .mbar.repository
+.mbar add cascade -label [_ Edit] -menu .mbar.edit
 if {[is_enabled branch]} {
-=09.mbar add cascade -label Branch -menu .mbar.branch
+=09.mbar add cascade -label [_ Branch] -menu .mbar.branch
 }
 if {[is_enabled multicommit] || [is_enabled singlecommit]} {
-=09.mbar add cascade -label Commit -menu .mbar.commit
+=09.mbar add cascade -label [_ Commit] -menu .mbar.commit
 }
 if {[is_enabled transport]} {
-=09.mbar add cascade -label Merge -menu .mbar.merge
-=09.mbar add cascade -label Fetch -menu .mbar.fetch
-=09.mbar add cascade -label Push -menu .mbar.push
+=09.mbar add cascade -label [_ Merge] -menu .mbar.merge
+=09.mbar add cascade -label [_ Fetch] -menu .mbar.fetch
+=09.mbar add cascade -label [_ Push] -menu .mbar.push
 }
 . configure -menu .mbar
=20
@@ -1638,75 +1638,75 @@ if {[is_enabled transport]} {
 menu .mbar.repository
=20
 .mbar.repository add command \
-=09-label {Browse Current Branch} \
+=09-label [_ {Browse Current Branch}] \
 =09-command {browser::new $current_branch}
 trace add variable current_branch write ".mbar.repository entryconf [.mbar.=
repository index last] -label \"Browse \$current_branch\" ;#"
 .mbar.repository add separator
=20
 .mbar.repository add command \
-=09-label {Visualize Current Branch} \
+=09-label [_ {Visualize Current Branch}]  \
 =09-command {do_gitk $current_branch}
 trace add variable current_branch write ".mbar.repository entryconf [.mbar.=
repository index last] -label \"Visualize \$current_branch\" ;#"
 .mbar.repository add command \
-=09-label {Visualize All Branches} \
+=09-label [_ {Visualize All Branches}] \
 =09-command {do_gitk --all}
 .mbar.repository add separator
=20
 if {[is_enabled multicommit]} {
-=09.mbar.repository add command -label {Database Statistics} \
+=09.mbar.repository add command -label [_ {Database Statistics}] \
 =09=09-command do_stats
=20
-=09.mbar.repository add command -label {Compress Database} \
+=09.mbar.repository add command -label [_ {Compress Database}] \
 =09=09-command do_gc
=20
-=09.mbar.repository add command -label {Verify Database} \
+=09.mbar.repository add command -label [_ {Verify Database}] \
 =09=09-command do_fsck_objects
=20
 =09.mbar.repository add separator
=20
 =09if {[is_Cygwin]} {
 =09=09.mbar.repository add command \
-=09=09=09-label {Create Desktop Icon} \
+=09=09=09-label [_ {Create Desktop Icon}] \
 =09=09=09-command do_cygwin_shortcut
 =09} elseif {[is_Windows]} {
 =09=09.mbar.repository add command \
-=09=09=09-label {Create Desktop Icon} \
+=09=09=09-label [_ {Create Desktop Icon}] \
 =09=09=09-command do_windows_shortcut
 =09} elseif {[is_MacOSX]} {
 =09=09.mbar.repository add command \
-=09=09=09-label {Create Desktop Icon} \
+=09=09=09-label [_ {Create Desktop Icon}] \
 =09=09=09-command do_macosx_app
 =09}
 }
=20
-.mbar.repository add command -label Quit \
+.mbar.repository add command -label [_ Quit] \
 =09-command do_quit \
 =09-accelerator $M1T-Q
=20
 # -- Edit Menu
 #
 menu .mbar.edit
-.mbar.edit add command -label Undo \
+.mbar.edit add command -label [_ Undo] \
 =09-command {catch {[focus] edit undo}} \
 =09-accelerator $M1T-Z
-.mbar.edit add command -label Redo \
+.mbar.edit add command -label [_ Redo] \
 =09-command {catch {[focus] edit redo}} \
 =09-accelerator $M1T-Y
 .mbar.edit add separator
-.mbar.edit add command -label Cut \
+.mbar.edit add command -label [_ Cut] \
 =09-command {catch {tk_textCut [focus]}} \
 =09-accelerator $M1T-X
-.mbar.edit add command -label Copy \
+.mbar.edit add command -label [_ Copy] \
 =09-command {catch {tk_textCopy [focus]}} \
 =09-accelerator $M1T-C
-.mbar.edit add command -label Paste \
+.mbar.edit add command -label [_ Paste] \
 =09-command {catch {tk_textPaste [focus]; [focus] see insert}} \
 =09-accelerator $M1T-V
-.mbar.edit add command -label Delete \
+.mbar.edit add command -label [_ Delete] \
 =09-command {catch {[focus] delete sel.first sel.last}} \
 =09-accelerator Del
 .mbar.edit add separator
-.mbar.edit add command -label {Select All} \
+.mbar.edit add command -label [_ {Select All}] \
 =09-command {catch {[focus] tag add sel 0.0 end}} \
 =09-accelerator $M1T-A
=20
@@ -1715,29 +1715,29 @@ menu .mbar.edit
 if {[is_enabled branch]} {
 =09menu .mbar.branch
=20
-=09.mbar.branch add command -label {Create...} \
+=09.mbar.branch add command -label [_ {Create...}] \
 =09=09-command branch_create::dialog \
 =09=09-accelerator $M1T-N
 =09lappend disable_on_lock [list .mbar.branch entryconf \
 =09=09[.mbar.branch index last] -state]
=20
-=09.mbar.branch add command -label {Checkout...} \
+=09.mbar.branch add command -label [_ {Checkout...}] \
 =09=09-command branch_checkout::dialog \
 =09=09-accelerator $M1T-O
 =09lappend disable_on_lock [list .mbar.branch entryconf \
 =09=09[.mbar.branch index last] -state]
=20
-=09.mbar.branch add command -label {Rename...} \
+=09.mbar.branch add command -label [_ {Rename...}] \
 =09=09-command branch_rename::dialog
 =09lappend disable_on_lock [list .mbar.branch entryconf \
 =09=09[.mbar.branch index last] -state]
=20
-=09.mbar.branch add command -label {Delete...} \
+=09.mbar.branch add command -label [_ {Delete...}] \
 =09=09-command branch_delete::dialog
 =09lappend disable_on_lock [list .mbar.branch entryconf \
 =09=09[.mbar.branch index last] -state]
=20
-=09.mbar.branch add command -label {Reset...} \
+=09.mbar.branch add command -label [_ {Reset...}] \
 =09=09-command merge::reset_hard
 =09lappend disable_on_lock [list .mbar.branch entryconf \
 =09=09[.mbar.branch index last] -state]
@@ -1749,7 +1749,7 @@ if {[is_enabled multicommit] || [is_enabled singlecomm=
it]} {
 =09menu .mbar.commit
=20
 =09.mbar.commit add radiobutton \
-=09=09-label {New Commit} \
+=09=09-label [_ {New Commit}] \
 =09=09-command do_select_commit_type \
 =09=09-variable selected_commit_type \
 =09=09-value new
@@ -1757,7 +1757,7 @@ if {[is_enabled multicommit] || [is_enabled singlecomm=
it]} {
 =09=09[list .mbar.commit entryconf [.mbar.commit index last] -state]
=20
 =09.mbar.commit add radiobutton \
-=09=09-label {Amend Last Commit} \
+=09=09-label [_ {Amend Last Commit}] \
 =09=09-command do_select_commit_type \
 =09=09-variable selected_commit_type \
 =09=09-value amend
@@ -1766,40 +1766,40 @@ if {[is_enabled multicommit] || [is_enabled singleco=
mmit]} {
=20
 =09.mbar.commit add separator
=20
-=09.mbar.commit add command -label Rescan \
+=09.mbar.commit add command -label [_ Rescan] \
 =09=09-command do_rescan \
 =09=09-accelerator F5
 =09lappend disable_on_lock \
 =09=09[list .mbar.commit entryconf [.mbar.commit index last] -state]
=20
-=09.mbar.commit add command -label {Add To Commit} \
+=09.mbar.commit add command -label [_ {Add To Commit}] \
 =09=09-command do_add_selection
 =09lappend disable_on_lock \
 =09=09[list .mbar.commit entryconf [.mbar.commit index last] -state]
=20
-=09.mbar.commit add command -label {Add Existing To Commit} \
+=09.mbar.commit add command -label [_ {Add Existing To Commit}] \
 =09=09-command do_add_all \
 =09=09-accelerator $M1T-I
 =09lappend disable_on_lock \
 =09=09[list .mbar.commit entryconf [.mbar.commit index last] -state]
=20
-=09.mbar.commit add command -label {Unstage From Commit} \
+=09.mbar.commit add command -label [_ {Unstage From Commit}] \
 =09=09-command do_unstage_selection
 =09lappend disable_on_lock \
 =09=09[list .mbar.commit entryconf [.mbar.commit index last] -state]
=20
-=09.mbar.commit add command -label {Revert Changes} \
+=09.mbar.commit add command -label [_ {Revert Changes}] \
 =09=09-command do_revert_selection
 =09lappend disable_on_lock \
 =09=09[list .mbar.commit entryconf [.mbar.commit index last] -state]
=20
 =09.mbar.commit add separator
=20
-=09.mbar.commit add command -label {Sign Off} \
+=09.mbar.commit add command -label [_ {Sign Off}] \
 =09=09-command do_signoff \
 =09=09-accelerator $M1T-S
=20
-=09.mbar.commit add command -label Commit \
+=09.mbar.commit add command -label [_ Commit] \
 =09=09-command do_commit \
 =09=09-accelerator $M1T-Return
 =09lappend disable_on_lock \
@@ -1810,11 +1810,11 @@ if {[is_enabled multicommit] || [is_enabled singleco=
mmit]} {
 #
 if {[is_enabled branch]} {
 =09menu .mbar.merge
-=09.mbar.merge add command -label {Local Merge...} \
+=09.mbar.merge add command -label [_ {Local Merge...}] \
 =09=09-command merge::dialog
 =09lappend disable_on_lock \
 =09=09[list .mbar.merge entryconf [.mbar.merge index last] -state]
-=09.mbar.merge add command -label {Abort Merge...} \
+=09.mbar.merge add command -label [_ {Abort Merge...}] \
 =09=09-command merge::reset_hard
 =09lappend disable_on_lock \
 =09=09[list .mbar.merge entryconf [.mbar.merge index last] -state]
@@ -1827,28 +1827,28 @@ if {[is_enabled transport]} {
 =09menu .mbar.fetch
=20
 =09menu .mbar.push
-=09.mbar.push add command -label {Push...} \
+=09.mbar.push add command -label [_ {Push...}] \
 =09=09-command do_push_anywhere \
 =09=09-accelerator $M1T-P
-=09.mbar.push add command -label {Delete...} \
+=09.mbar.push add command -label [_ {Delete...}] \
 =09=09-command remote_branch_delete::dialog
 }
=20
 if {[is_MacOSX]} {
 =09# -- Apple Menu (Mac OS X only)
 =09#
-=09.mbar add cascade -label Apple -menu .mbar.apple
+=09.mbar add cascade -label [_ Apple] -menu .mbar.apple
 =09menu .mbar.apple
=20
-=09.mbar.apple add command -label "About [appname]" \
+=09.mbar.apple add command -label [format [_ "About %s"] [appname]] \
 =09=09-command do_about
-=09.mbar.apple add command -label "Options..." \
+=09.mbar.apple add command -label [_ "Options..."] \
 =09=09-command do_options
 } else {
 =09# -- Edit Menu
 =09#
 =09.mbar.edit add separator
-=09.mbar.edit add command -label {Options...} \
+=09.mbar.edit add command -label [_ {Options...}] \
 =09=09-command do_options
=20
 =09# -- Tools Menu
@@ -1870,9 +1870,9 @@ if {[is_MacOSX]} {
 =09=09=09rescan ui_ready
 =09=09}
 =09}
-=09.mbar add cascade -label Tools -menu .mbar.tools
+=09.mbar add cascade -label [_ Tools] -menu .mbar.tools
 =09menu .mbar.tools
-=09.mbar.tools add command -label "Migrate" \
+=09.mbar.tools add command -label [_ "Migrate"] \
 =09=09-command do_miga
 =09lappend disable_on_lock \
 =09=09[list .mbar.tools entryconf [.mbar.tools index last] -state]
@@ -1881,11 +1881,11 @@ if {[is_MacOSX]} {
=20
 # -- Help Menu
 #
-.mbar add cascade -label Help -menu .mbar.help
+.mbar add cascade -label [_ Help] -menu .mbar.help
 menu .mbar.help
=20
 if {![is_MacOSX]} {
-=09.mbar.help add command -label "About [appname]" \
+=09.mbar.help add command -label [format [_ "About %s"] [appname]] \
 =09=09-command do_about
 }
=20
@@ -1922,7 +1922,7 @@ if {[file isfile $doc_path]} {
 }
=20
 if {$browser ne {}} {
-=09.mbar.help add command -label {Online Documentation} \
+=09.mbar.help add command -label [_ {Online Documentation}] \
 =09=09-command [list exec $browser $doc_url &]
 }
 unset browser doc_path doc_url
@@ -2167,12 +2167,12 @@ label $ui_coml \
 proc trace_commit_type {varname args} {
 =09global ui_coml commit_type
 =09switch -glob -- $commit_type {
-=09initial       {set txt {Initial Commit Message:}}
-=09amend         {set txt {Amended Commit Message:}}
-=09amend-initial {set txt {Amended Initial Commit Message:}}
-=09amend-merge   {set txt {Amended Merge Commit Message:}}
-=09merge         {set txt {Merge Commit Message:}}
-=09*             {set txt {Commit Message:}}
+=09initial       {set txt [_ {Initial Commit Message:}]}
+=09amend         {set txt [_ {Amended Commit Message:}]}
+=09amend-initial {set txt [_ {Amended Initial Commit Message:}]}
+=09amend-merge   {set txt [_ {Amended Merge Commit Message:}]}
+=09merge         {set txt [_ {Merge Commit Message:}]}
+=09*             {set txt [_ {Commit Message:}]}
 =09}
 =09$ui_coml conf -text $txt
 }
@@ -2201,23 +2201,23 @@ pack .vpane.lower.commarea.buffer -side left -fill y
 set ctxm .vpane.lower.commarea.buffer.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
-=09-label {Cut} \
+=09-label [_ {Cut}] \
 =09-command {tk_textCut $ui_comm}
 $ctxm add command \
-=09-label {Copy} \
+=09-label [_ {Copy}] \
 =09-command {tk_textCopy $ui_comm}
 $ctxm add command \
-=09-label {Paste} \
+=09-label [_ {Paste}] \
 =09-command {tk_textPaste $ui_comm}
 $ctxm add command \
-=09-label {Delete} \
+=09-label [_ {Delete}] \
 =09-command {$ui_comm delete sel.first sel.last}
 $ctxm add separator
 $ctxm add command \
-=09-label {Select All} \
+=09-label [_ {Select All}] \
 =09-command {focus $ui_comm;$ui_comm tag add sel 0.0 end}
 $ctxm add command \
-=09-label {Copy All} \
+=09-label [_ {Copy All}] \
 =09-command {
 =09=09$ui_comm tag add sel 0.0 end
 =09=09tk_textCopy $ui_comm
@@ -2225,7 +2225,7 @@ $ctxm add command \
 =09}
 $ctxm add separator
 $ctxm add command \
-=09-label {Sign Off} \
+=09-label [_ {Sign Off}] \
 =09-command do_signoff
 bind_button3 $ui_comm "tk_popup $ctxm %X %Y"
=20
@@ -2275,7 +2275,7 @@ pack .vpane.lower.diff.header.path -fill x
 set ctxm .vpane.lower.diff.header.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
-=09-label {Copy} \
+=09-label [_ {Copy}] \
 =09-command {
 =09=09clipboard clear
 =09=09clipboard append \
@@ -2343,19 +2343,19 @@ $ui_diff tag raise sel
 set ctxm .vpane.lower.diff.body.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
-=09-label {Refresh} \
+=09-label [_ {Refresh}] \
 =09-command reshow_diff
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-=09-label {Copy} \
+=09-label [_ {Copy}] \
 =09-command {tk_textCopy $ui_diff}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-=09-label {Select All} \
+=09-label [_ {Select All}] \
 =09-command {focus $ui_diff;$ui_diff tag add sel 0.0 end}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-=09-label {Copy All} \
+=09-label [_ {Copy All}] \
 =09-command {
 =09=09$ui_diff tag add sel 0.0 end
 =09=09tk_textCopy $ui_diff
@@ -2364,44 +2364,44 @@ $ctxm add command \
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
-=09-label {Apply/Reverse Hunk} \
+=09-label [_ {Apply/Reverse Hunk}] \
 =09-command {apply_hunk $cursorX $cursorY}
 set ui_diff_applyhunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
 $ctxm add separator
 $ctxm add command \
-=09-label {Decrease Font Size} \
+=09-label [_ {Decrease Font Size}] \
 =09-command {incr_font_size font_diff -1}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-=09-label {Increase Font Size} \
+=09-label [_ {Increase Font Size}] \
 =09-command {incr_font_size font_diff 1}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
-=09-label {Show Less Context} \
+=09-label [_ {Show Less Context}] \
 =09-command {if {$repo_config(gui.diffcontext) >=3D 1} {
 =09=09incr repo_config(gui.diffcontext) -1
 =09=09reshow_diff
 =09}}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-=09-label {Show More Context} \
+=09-label [_ {Show More Context}] \
 =09-command {if {$repo_config(gui.diffcontext) < 99} {
 =09=09incr repo_config(gui.diffcontext)
 =09=09reshow_diff
 =09}}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
-$ctxm add command -label {Options...} \
+$ctxm add command -label [_ {Options...}] \
 =09-command do_options
 bind_button3 $ui_diff "
 =09set cursorX %x
 =09set cursorY %y
 =09if {\$ui_index eq \$current_diff_side} {
-=09=09$ctxm entryconf $ui_diff_applyhunk -label {Unstage Hunk From Commit}
+=09=09$ctxm entryconf $ui_diff_applyhunk -label [_ {Unstage Hunk From Commi=
t}]
 =09} else {
-=09=09$ctxm entryconf $ui_diff_applyhunk -label {Stage Hunk For Commit}
+=09=09$ctxm entryconf $ui_diff_applyhunk -label [_ {Stage Hunk For Commit}]
 =09}
 =09tk_popup $ctxm %X %Y
 "
--=20
1.5.3.rc2.4.g726f9


--=_22ekcyapv6gp
Content-Type: text/x-patch;
	charset=UTF-8;
	name="0003-Enclose-strings-in-quotes-not-in-braces-so-that-xg.patch"
Content-Disposition: attachment;
	filename="0003-Enclose-strings-in-quotes-not-in-braces-so-that-xg.patch"
Content-Transfer-Encoding: quoted-printable

>From 3ff00ecdabb82448b95ad3b9e738441236c0eb11 Mon Sep 17 00:00:00 2001
From: Christian Stimming <stimming@tuhh.de>
Date: Thu, 19 Jul 2007 12:49:11 +0200
Subject: [PATCH] Enclose strings in quotes, not in braces, so that xgettext =
finds them

---
 git-gui/git-gui.sh |  104 ++++++++++++++++++++++++++-----------------------=
---
 1 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 45b7ef1..5eef35d 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1638,43 +1638,43 @@ if {[is_enabled transport]} {
 menu .mbar.repository
=20
 .mbar.repository add command \
-=09-label [_ {Browse Current Branch}] \
+=09-label [_ "Browse Current Branch"] \
 =09-command {browser::new $current_branch}
 trace add variable current_branch write ".mbar.repository entryconf [.mbar.=
repository index last] -label \"Browse \$current_branch\" ;#"
 .mbar.repository add separator
=20
 .mbar.repository add command \
-=09-label [_ {Visualize Current Branch}]  \
+=09-label [_ "Visualize Current Branch"]  \
 =09-command {do_gitk $current_branch}
 trace add variable current_branch write ".mbar.repository entryconf [.mbar.=
repository index last] -label \"Visualize \$current_branch\" ;#"
 .mbar.repository add command \
-=09-label [_ {Visualize All Branches}] \
+=09-label [_ "Visualize All Branches"] \
 =09-command {do_gitk --all}
 .mbar.repository add separator
=20
 if {[is_enabled multicommit]} {
-=09.mbar.repository add command -label [_ {Database Statistics}] \
+=09.mbar.repository add command -label [_ "Database Statistics"] \
 =09=09-command do_stats
=20
-=09.mbar.repository add command -label [_ {Compress Database}] \
+=09.mbar.repository add command -label [_ "Compress Database"] \
 =09=09-command do_gc
=20
-=09.mbar.repository add command -label [_ {Verify Database}] \
+=09.mbar.repository add command -label [_ "Verify Database"] \
 =09=09-command do_fsck_objects
=20
 =09.mbar.repository add separator
=20
 =09if {[is_Cygwin]} {
 =09=09.mbar.repository add command \
-=09=09=09-label [_ {Create Desktop Icon}] \
+=09=09=09-label [_ "Create Desktop Icon"] \
 =09=09=09-command do_cygwin_shortcut
 =09} elseif {[is_Windows]} {
 =09=09.mbar.repository add command \
-=09=09=09-label [_ {Create Desktop Icon}] \
+=09=09=09-label [_ "Create Desktop Icon"] \
 =09=09=09-command do_windows_shortcut
 =09} elseif {[is_MacOSX]} {
 =09=09.mbar.repository add command \
-=09=09=09-label [_ {Create Desktop Icon}] \
+=09=09=09-label [_ "Create Desktop Icon"] \
 =09=09=09-command do_macosx_app
 =09}
 }
@@ -1706,7 +1706,7 @@ menu .mbar.edit
 =09-command {catch {[focus] delete sel.first sel.last}} \
 =09-accelerator Del
 .mbar.edit add separator
-.mbar.edit add command -label [_ {Select All}] \
+.mbar.edit add command -label [_ "Select All"] \
 =09-command {catch {[focus] tag add sel 0.0 end}} \
 =09-accelerator $M1T-A
=20
@@ -1715,29 +1715,29 @@ menu .mbar.edit
 if {[is_enabled branch]} {
 =09menu .mbar.branch
=20
-=09.mbar.branch add command -label [_ {Create...}] \
+=09.mbar.branch add command -label [_ "Create..."] \
 =09=09-command branch_create::dialog \
 =09=09-accelerator $M1T-N
 =09lappend disable_on_lock [list .mbar.branch entryconf \
 =09=09[.mbar.branch index last] -state]
=20
-=09.mbar.branch add command -label [_ {Checkout...}] \
+=09.mbar.branch add command -label [_ "Checkout..."] \
 =09=09-command branch_checkout::dialog \
 =09=09-accelerator $M1T-O
 =09lappend disable_on_lock [list .mbar.branch entryconf \
 =09=09[.mbar.branch index last] -state]
=20
-=09.mbar.branch add command -label [_ {Rename...}] \
+=09.mbar.branch add command -label [_ "Rename..."] \
 =09=09-command branch_rename::dialog
 =09lappend disable_on_lock [list .mbar.branch entryconf \
 =09=09[.mbar.branch index last] -state]
=20
-=09.mbar.branch add command -label [_ {Delete...}] \
+=09.mbar.branch add command -label [_ "Delete..."] \
 =09=09-command branch_delete::dialog
 =09lappend disable_on_lock [list .mbar.branch entryconf \
 =09=09[.mbar.branch index last] -state]
=20
-=09.mbar.branch add command -label [_ {Reset...}] \
+=09.mbar.branch add command -label [_ "Reset..."] \
 =09=09-command merge::reset_hard
 =09lappend disable_on_lock [list .mbar.branch entryconf \
 =09=09[.mbar.branch index last] -state]
@@ -1749,7 +1749,7 @@ if {[is_enabled multicommit] || [is_enabled singlecomm=
it]} {
 =09menu .mbar.commit
=20
 =09.mbar.commit add radiobutton \
-=09=09-label [_ {New Commit}] \
+=09=09-label [_ "New Commit"] \
 =09=09-command do_select_commit_type \
 =09=09-variable selected_commit_type \
 =09=09-value new
@@ -1757,7 +1757,7 @@ if {[is_enabled multicommit] || [is_enabled singlecomm=
it]} {
 =09=09[list .mbar.commit entryconf [.mbar.commit index last] -state]
=20
 =09.mbar.commit add radiobutton \
-=09=09-label [_ {Amend Last Commit}] \
+=09=09-label [_ "Amend Last Commit"] \
 =09=09-command do_select_commit_type \
 =09=09-variable selected_commit_type \
 =09=09-value amend
@@ -1772,30 +1772,30 @@ if {[is_enabled multicommit] || [is_enabled singleco=
mmit]} {
 =09lappend disable_on_lock \
 =09=09[list .mbar.commit entryconf [.mbar.commit index last] -state]
=20
-=09.mbar.commit add command -label [_ {Add To Commit}] \
+=09.mbar.commit add command -label [_ "Add To Commit"] \
 =09=09-command do_add_selection
 =09lappend disable_on_lock \
 =09=09[list .mbar.commit entryconf [.mbar.commit index last] -state]
=20
-=09.mbar.commit add command -label [_ {Add Existing To Commit}] \
+=09.mbar.commit add command -label [_ "Add Existing To Commit"] \
 =09=09-command do_add_all \
 =09=09-accelerator $M1T-I
 =09lappend disable_on_lock \
 =09=09[list .mbar.commit entryconf [.mbar.commit index last] -state]
=20
-=09.mbar.commit add command -label [_ {Unstage From Commit}] \
+=09.mbar.commit add command -label [_ "Unstage From Commit"] \
 =09=09-command do_unstage_selection
 =09lappend disable_on_lock \
 =09=09[list .mbar.commit entryconf [.mbar.commit index last] -state]
=20
-=09.mbar.commit add command -label [_ {Revert Changes}] \
+=09.mbar.commit add command -label [_ "Revert Changes"] \
 =09=09-command do_revert_selection
 =09lappend disable_on_lock \
 =09=09[list .mbar.commit entryconf [.mbar.commit index last] -state]
=20
 =09.mbar.commit add separator
=20
-=09.mbar.commit add command -label [_ {Sign Off}] \
+=09.mbar.commit add command -label [_ "Sign Off"] \
 =09=09-command do_signoff \
 =09=09-accelerator $M1T-S
=20
@@ -1810,11 +1810,11 @@ if {[is_enabled multicommit] || [is_enabled singleco=
mmit]} {
 #
 if {[is_enabled branch]} {
 =09menu .mbar.merge
-=09.mbar.merge add command -label [_ {Local Merge...}] \
+=09.mbar.merge add command -label [_ "Local Merge..."] \
 =09=09-command merge::dialog
 =09lappend disable_on_lock \
 =09=09[list .mbar.merge entryconf [.mbar.merge index last] -state]
-=09.mbar.merge add command -label [_ {Abort Merge...}] \
+=09.mbar.merge add command -label [_ "Abort Merge..."] \
 =09=09-command merge::reset_hard
 =09lappend disable_on_lock \
 =09=09[list .mbar.merge entryconf [.mbar.merge index last] -state]
@@ -1827,10 +1827,10 @@ if {[is_enabled transport]} {
 =09menu .mbar.fetch
=20
 =09menu .mbar.push
-=09.mbar.push add command -label [_ {Push...}] \
+=09.mbar.push add command -label [_ "Push..."] \
 =09=09-command do_push_anywhere \
 =09=09-accelerator $M1T-P
-=09.mbar.push add command -label [_ {Delete...}] \
+=09.mbar.push add command -label [_ "Delete..."] \
 =09=09-command remote_branch_delete::dialog
 }
=20
@@ -1848,7 +1848,7 @@ if {[is_MacOSX]} {
 =09# -- Edit Menu
 =09#
 =09.mbar.edit add separator
-=09.mbar.edit add command -label [_ {Options...}] \
+=09.mbar.edit add command -label [_ "Options..."] \
 =09=09-command do_options
=20
 =09# -- Tools Menu
@@ -1922,7 +1922,7 @@ if {[file isfile $doc_path]} {
 }
=20
 if {$browser ne {}} {
-=09.mbar.help add command -label [_ {Online Documentation}] \
+=09.mbar.help add command -label [_ "Online Documentation"] \
 =09=09-command [list exec $browser $doc_url &]
 }
 unset browser doc_path doc_url
@@ -2167,12 +2167,12 @@ label $ui_coml \
 proc trace_commit_type {varname args} {
 =09global ui_coml commit_type
 =09switch -glob -- $commit_type {
-=09initial       {set txt [_ {Initial Commit Message:}]}
-=09amend         {set txt [_ {Amended Commit Message:}]}
-=09amend-initial {set txt [_ {Amended Initial Commit Message:}]}
-=09amend-merge   {set txt [_ {Amended Merge Commit Message:}]}
-=09merge         {set txt [_ {Merge Commit Message:}]}
-=09*             {set txt [_ {Commit Message:}]}
+=09initial       {set txt [_ "Initial Commit Message:"]}
+=09amend         {set txt [_ "Amended Commit Message:"]}
+=09amend-initial {set txt [_ "Amended Initial Commit Message:"]}
+=09amend-merge   {set txt [_ "Amended Merge Commit Message:"]}
+=09merge         {set txt [_ "Merge Commit Message:"]}
+=09*             {set txt [_ "Commit Message:"]}
 =09}
 =09$ui_coml conf -text $txt
 }
@@ -2201,23 +2201,23 @@ pack .vpane.lower.commarea.buffer -side left -fill y
 set ctxm .vpane.lower.commarea.buffer.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
-=09-label [_ {Cut}] \
+=09-label [_ Cut] \
 =09-command {tk_textCut $ui_comm}
 $ctxm add command \
-=09-label [_ {Copy}] \
+=09-label [_ Copy] \
 =09-command {tk_textCopy $ui_comm}
 $ctxm add command \
-=09-label [_ {Paste}] \
+=09-label [_ Paste] \
 =09-command {tk_textPaste $ui_comm}
 $ctxm add command \
-=09-label [_ {Delete}] \
+=09-label [_ Delete] \
 =09-command {$ui_comm delete sel.first sel.last}
 $ctxm add separator
 $ctxm add command \
-=09-label [_ {Select All}] \
+=09-label [_ "Select All"] \
 =09-command {focus $ui_comm;$ui_comm tag add sel 0.0 end}
 $ctxm add command \
-=09-label [_ {Copy All}] \
+=09-label [_ "Copy All"] \
 =09-command {
 =09=09$ui_comm tag add sel 0.0 end
 =09=09tk_textCopy $ui_comm
@@ -2225,7 +2225,7 @@ $ctxm add command \
 =09}
 $ctxm add separator
 $ctxm add command \
-=09-label [_ {Sign Off}] \
+=09-label [_ "Sign Off"] \
 =09-command do_signoff
 bind_button3 $ui_comm "tk_popup $ctxm %X %Y"
=20
@@ -2275,7 +2275,7 @@ pack .vpane.lower.diff.header.path -fill x
 set ctxm .vpane.lower.diff.header.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
-=09-label [_ {Copy}] \
+=09-label [_ Copy] \
 =09-command {
 =09=09clipboard clear
 =09=09clipboard append \
@@ -2343,19 +2343,19 @@ $ui_diff tag raise sel
 set ctxm .vpane.lower.diff.body.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
-=09-label [_ {Refresh}] \
+=09-label [_ Refresh] \
 =09-command reshow_diff
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-=09-label [_ {Copy}] \
+=09-label [_ Copy] \
 =09-command {tk_textCopy $ui_diff}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-=09-label [_ {Select All}] \
+=09-label [_ "Select All"] \
 =09-command {focus $ui_diff;$ui_diff tag add sel 0.0 end}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-=09-label [_ {Copy All}] \
+=09-label [_ "Copy All"] \
 =09-command {
 =09=09$ui_diff tag add sel 0.0 end
 =09=09tk_textCopy $ui_diff
@@ -2364,36 +2364,36 @@ $ctxm add command \
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
-=09-label [_ {Apply/Reverse Hunk}] \
+=09-label [_ "Apply/Reverse Hunk"] \
 =09-command {apply_hunk $cursorX $cursorY}
 set ui_diff_applyhunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
 $ctxm add separator
 $ctxm add command \
-=09-label [_ {Decrease Font Size}] \
+=09-label [_ "Decrease Font Size"] \
 =09-command {incr_font_size font_diff -1}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-=09-label [_ {Increase Font Size}] \
+=09-label [_ "Increase Font Size"] \
 =09-command {incr_font_size font_diff 1}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
-=09-label [_ {Show Less Context}] \
+=09-label [_ "Show Less Context"] \
 =09-command {if {$repo_config(gui.diffcontext) >=3D 1} {
 =09=09incr repo_config(gui.diffcontext) -1
 =09=09reshow_diff
 =09}}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-=09-label [_ {Show More Context}] \
+=09-label [_ "Show More Context"] \
 =09-command {if {$repo_config(gui.diffcontext) < 99} {
 =09=09incr repo_config(gui.diffcontext)
 =09=09reshow_diff
 =09}}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
-$ctxm add command -label [_ {Options...}] \
+$ctxm add command -label [_ "Options..."] \
 =09-command do_options
 bind_button3 $ui_diff "
 =09set cursorX %x
--=20
1.5.3.rc2.4.g726f9


--=_22ekcyapv6gp
Content-Type: text/x-patch;
	charset=UTF-8;
	name="0004-Initial-German-translation-for-testing-of-i18n.patch"
Content-Disposition: attachment;
	filename="0004-Initial-German-translation-for-testing-of-i18n.patch"
Content-Transfer-Encoding: quoted-printable

>From 9b7ef0f5d5627e65e5ab354cf99c8939770416d9 Mon Sep 17 00:00:00 2001
From: Christian Stimming <stimming@tuhh.de>
Date: Thu, 19 Jul 2007 12:50:19 +0200
Subject: [PATCH] Initial German translation for testing of i18n.

---
 git-gui/po/de.po |  249 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
 1 files changed, 249 insertions(+), 0 deletions(-)
 create mode 100644 git-gui/po/de.po

diff --git a/git-gui/po/de.po b/git-gui/po/de.po
new file mode 100644
index 0000000..7a74329
--- /dev/null
+++ b/git-gui/po/de.po
@@ -0,0 +1,249 @@
+# Translation of git-gui to German.
+# Copyright (C) 2007 Linux Thorvalds
+# This file is distributed under the same license as the git package.
+# Christian Stimming <stimming@tuhh.de>, 2007
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-07-18 18:27+0200\n"
+"PO-Revision-Date: 2007-07-19 11:45+0200\n"
+"Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
+"Language-Team: German\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: git-gui.sh:1622
+msgid "Repository"
+msgstr ""
+
+#: git-gui.sh:1623
+msgid "Edit"
+msgstr "Bearbeiten"
+
+#: git-gui.sh:1625
+msgid "Branch"
+msgstr ""
+
+#: git-gui.sh:1628 git-gui.sh:1803
+msgid "Commit"
+msgstr ""
+
+#: git-gui.sh:1631
+msgid "Merge"
+msgstr ""
+
+#: git-gui.sh:1632
+msgid "Fetch"
+msgstr ""
+
+#: git-gui.sh:1633
+msgid "Push"
+msgstr ""
+
+#: git-gui.sh:1642
+msgid "Browse Current Branch"
+msgstr ""
+
+#: git-gui.sh:1648
+msgid "Visualize Current Branch"
+msgstr ""
+
+#: git-gui.sh:1652
+msgid "Visualize All Branches"
+msgstr ""
+
+#: git-gui.sh:1657
+msgid "Database Statistics"
+msgstr ""
+
+#: git-gui.sh:1660
+msgid "Compress Database"
+msgstr ""
+
+#: git-gui.sh:1663
+msgid "Verify Database"
+msgstr ""
+
+#: git-gui.sh:1670 git-gui.sh:1674 git-gui.sh:1678
+msgid "Create Desktop Icon"
+msgstr ""
+
+#: git-gui.sh:1683
+msgid "Quit"
+msgstr "Beenden"
+
+#: git-gui.sh:1690
+msgid "Undo"
+msgstr "R=C3=BCckg=C3=A4ngig"
+
+#: git-gui.sh:1693
+msgid "Redo"
+msgstr ""
+
+#: git-gui.sh:1697 git-gui.sh:2205
+msgid "Cut"
+msgstr "Ausschneiden"
+
+#: git-gui.sh:1700 git-gui.sh:2208 git-gui.sh:2279 git-gui.sh:2351
+msgid "Copy"
+msgstr "Kopieren"
+
+#: git-gui.sh:1703 git-gui.sh:2211
+msgid "Paste"
+msgstr "Einf=C3=BCgen"
+
+#: git-gui.sh:1706 git-gui.sh:2214
+msgid "Delete"
+msgstr "L=C3=B6schen"
+
+#: git-gui.sh:1710 git-gui.sh:2218 git-gui.sh:2355
+msgid "Select All"
+msgstr ""
+
+#: git-gui.sh:1719
+msgid "Create..."
+msgstr ""
+
+#: git-gui.sh:1725
+msgid "Checkout..."
+msgstr ""
+
+#: git-gui.sh:1731
+msgid "Rename..."
+msgstr ""
+
+#: git-gui.sh:1736 git-gui.sh:1834
+msgid "Delete..."
+msgstr "L=C3=B6schen..."
+
+#: git-gui.sh:1741
+msgid "Reset..."
+msgstr ""
+
+#: git-gui.sh:1753
+msgid "New Commit"
+msgstr ""
+
+#: git-gui.sh:1761
+msgid "Amend Last Commit"
+msgstr ""
+
+#: git-gui.sh:1770
+msgid "Rescan"
+msgstr "Neu laden"
+
+#: git-gui.sh:1776
+msgid "Add To Commit"
+msgstr ""
+
+#: git-gui.sh:1781
+msgid "Add Existing To Commit"
+msgstr ""
+
+#: git-gui.sh:1787
+msgid "Unstage From Commit"
+msgstr ""
+
+#: git-gui.sh:1792
+msgid "Revert Changes"
+msgstr ""
+
+#: git-gui.sh:1799 git-gui.sh:2229
+msgid "Sign Off"
+msgstr ""
+
+#: git-gui.sh:1814
+msgid "Local Merge..."
+msgstr ""
+
+#: git-gui.sh:1818
+msgid "Abort Merge..."
+msgstr ""
+
+#: git-gui.sh:1831
+msgid "Push..."
+msgstr ""
+
+#: git-gui.sh:1841
+msgid "Apple"
+msgstr "Apple"
+
+#: git-gui.sh:1844 git-gui.sh:1889
+#, tcl-format
+msgid "About %s"
+msgstr ""
+
+#: git-gui.sh:1846 git-gui.sh:1852 git-gui.sh:2397
+msgid "Options..."
+msgstr ""
+
+#: git-gui.sh:1874
+msgid "Tools"
+msgstr "Werkzeuge"
+
+#: git-gui.sh:1876
+msgid "Migrate"
+msgstr ""
+
+#: git-gui.sh:1885
+msgid "Help"
+msgstr "Hilfe"
+
+#: git-gui.sh:1926
+msgid "Online Documentation"
+msgstr ""
+
+#: git-gui.sh:2171
+msgid "Initial Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2172
+msgid "Amended Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2173
+msgid "Amended Initial Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2174
+msgid "Amended Merge Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2175
+msgid "Merge Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2176
+msgid "Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2221 git-gui.sh:2359
+msgid "Copy All"
+msgstr "Alle kopieren"
+
+#: git-gui.sh:2347
+msgid "Refresh"
+msgstr "Aktualisieren"
+
+#: git-gui.sh:2368
+msgid "Apply/Reverse Hunk"
+msgstr ""
+
+#: git-gui.sh:2374
+msgid "Decrease Font Size"
+msgstr "Schriftgr=C3=B6=C3=9Fe verkleinern"
+
+#: git-gui.sh:2378
+msgid "Increase Font Size"
+msgstr "Schriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9Fern"
+
+#: git-gui.sh:2383
+msgid "Show Less Context"
+msgstr ""
+
+#: git-gui.sh:2390
+msgid "Show More Context"
+msgstr ""
--=20
1.5.3.rc2.4.g726f9


--=_22ekcyapv6gp
Content-Type: text/x-patch;
	charset=UTF-8;
	name="0005-Makefile-rules-for-message-catalog-generation-and-in.patch"
Content-Disposition: attachment;
	filename="0005-Makefile-rules-for-message-catalog-generation-and-in.patch"
Content-Transfer-Encoding: quoted-printable

>From a91dc11906f6ced938dc79bded2fa46fcc147524 Mon Sep 17 00:00:00 2001
From: Christian Stimming <stimming@tuhh.de>
Date: Thu, 19 Jul 2007 12:50:32 +0200
Subject: [PATCH] Makefile rules for message catalog generation and installat=
ion.

---
 git-gui/Makefile |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index 1bac6fe..f6a6ce3 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -103,6 +103,19 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 $(GITGUI_BUILT_INS): git-gui
 =09$(QUIET_BUILT_IN)rm -f $@ && ln git-gui $@
=20
+XGETTEXT   ?=3D xgettext
+msgsdir    ?=3D $(libdir)/msgs
+msgsdir_SQ  =3D $(subst ','\'',$(msgsdir))
+PO_TEMPLATE =3D po/git-gui.pot
+ALL_LINGUAS =3D de
+
+$(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
+=09$(XGETTEXT) -k_ -LTcl -o $@ $(SCRIPT_SH) $(ALL_LIBFILES)
+update-po:: $(PO_TEMPLATE)
+=09( cd po ; for A in *.po ; do echo Updating $${A} ; msgmerge -U $${A} ../=
$(PO_TEMPLATE) ; done )
+catalogs:: $(PO_TEMPLATE)
+=09( cd po ; for A in $(ALL_LINGUAS) ; do echo Generating catalog $${A} ; m=
sgfmt --statistics --tcl $${A}.po -l $${A} -d . ; done )
+
 lib/tclIndex: $(ALL_LIBFILES)
 =09$(QUIET_INDEX)if echo \
 =09  $(foreach p,$(PRELOAD_FILES),source $p\;) \
@@ -136,7 +149,7 @@ GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
 =09=09echo 1>$@ "$$VARS"; \
 =09fi
=20
-all:: $(ALL_PROGRAMS) lib/tclIndex
+all:: $(ALL_PROGRAMS) lib/tclIndex catalogs
=20
 install: all
 =09$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
@@ -145,6 +158,8 @@ install: all
 =09$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(libdir_SQ)' $(INSTALL_D1)
 =09$(QUIET)$(INSTALL_R0)lib/tclIndex $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_S=
Q)'
 =09$(QUIET)$(foreach p,$(ALL_LIBFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DE=
STDIR_SQ)$(libdir_SQ)' &&) true
+=09$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(msgsdir_SQ)' $(INSTALL_D1)
+=09$(QUIET)$(foreach p,$(ALL_LINGUAS), $(INSTALL_R0)po/$p.msg $(INSTALL_R1)=
 '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
=20
 dist-version:
 =09@mkdir -p $(TARDIR)
--=20
1.5.3.rc2.4.g726f9


--=_22ekcyapv6gp--
