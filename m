From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-gui: Move frequently used commands to the top of the
 context menu.
Date: Thu, 13 Dec 2007 15:39:21 +0100
Message-ID: <47614419.3050604@viscovery.net>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com> <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com> <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com> <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com> <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com> <20071212041002.GN14735@spearce.org> <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com> <20071212052329.GR14735@spearce.org> <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com> <Pine.LNX.4.64.0712121814260.27959@racer.site> <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com> <Pine.LNX.4.64.0712121931050.27959@racer.site> <7vhcin3rv4.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0712131248500.27959@racer.site> <47613BA6.1060705@viscovery.net> 
 <Pine.LNX.4.64.0712131417110.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 15:39:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2pE5-0005M6-VY
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 15:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbXLMOj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 09:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753544AbXLMOj1
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 09:39:27 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:17805 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbXLMOj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 09:39:26 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J2pDx-0002GY-7Y; Thu, 13 Dec 2007 15:39:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 61C8169F; Thu, 13 Dec 2007 15:39:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0712131417110.27959@racer.site>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68161>

From: Johannes Sixt <johannes.sixt@telecom.at>

"Stage/Unstage Hunk" is probably the most frequently used command of the
patch context menu *and* it is not available in some other form than
the context menu. Therefore, it should go to the top. "Less Context" and
"More Context" entries are also not easily available otherwise, and are
therefore, moved second. The other entries are available via key strokes
(Copy, Paste, Refresh) or rarly used (Font Size, Options) and can go last.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Johannes Schindelin schrieb:
 > On Thu, 13 Dec 2007, Johannes Sixt wrote:
 >> It's probably sufficient to have an option "Stage this Line": Once you
 >> have staged enough lines, the hunk will be split automatically by the
 >> current number-of-context-lines setting.
 >
 > And your hand falls off... ;-)

 Not with this patch.

 And, obviously, "Stage this Line" is accompanied by "Unstage this Line".
 So when you want to stage a lot *except* one line, then you better
 stage the lot, then *unstage* one line.

 -- Hannes

 PS: Warning, Shawn: [ab]/git-gui.sh below is forged; you won't have
 blob 95b9537.

 git-gui.sh |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 95b9537..8e3751f 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2542,6 +2542,27 @@ $ui_diff tag raise sel
 set ctxm .vpane.lower.diff.body.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
+	-label [mc "Apply/Reverse Hunk"] \
+	-command {apply_hunk $cursorX $cursorY}
+set ui_diff_applyhunk [$ctxm index last]
+lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
+$ctxm add separator
+$ctxm add command \
+	-label [mc "Show Less Context"] \
+	-command {if {$repo_config(gui.diffcontext) >= 1} {
+		incr repo_config(gui.diffcontext) -1
+		reshow_diff
+	}}
+lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+$ctxm add command \
+	-label [mc "Show More Context"] \
+	-command {if {$repo_config(gui.diffcontext) < 99} {
+		incr repo_config(gui.diffcontext)
+		reshow_diff
+	}}
+lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+$ctxm add separator
+$ctxm add command \
 	-label [mc Refresh] \
 	-command reshow_diff
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
@@ -2563,12 +2584,6 @@ $ctxm add command \
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
-	-label [mc "Apply/Reverse Hunk"] \
-	-command {apply_hunk $cursorX $cursorY}
-set ui_diff_applyhunk [$ctxm index last]
-lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
-$ctxm add separator
-$ctxm add command \
 	-label [mc "Decrease Font Size"] \
 	-command {incr_font_size font_diff -1}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
@@ -2577,21 +2592,6 @@ $ctxm add command \
 	-command {incr_font_size font_diff 1}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
-$ctxm add command \
-	-label [mc "Show Less Context"] \
-	-command {if {$repo_config(gui.diffcontext) >= 1} {
-		incr repo_config(gui.diffcontext) -1
-		reshow_diff
-	}}
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-$ctxm add command \
-	-label [mc "Show More Context"] \
-	-command {if {$repo_config(gui.diffcontext) < 99} {
-		incr repo_config(gui.diffcontext)
-		reshow_diff
-	}}
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-$ctxm add separator
 $ctxm add command -label [mc "Options..."] \
 	-command do_options
 proc popup_diff_menu {ctxm x y X Y} {
-- 
1.5.3.7.1929.gf9f0a
