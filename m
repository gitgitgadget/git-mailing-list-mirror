From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH - v2] gitk: fix "Key bindings" message
Date: Wed, 9 Jan 2008 19:16:52 +0100
Message-ID: <200801091916.52680.barra_cuda@katamail.com>
References: <200801081437.46398.barra_cuda@katamail.com> <18308.2284.160506.432481@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 19:10:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCfNK-0008Q7-7O
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 19:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbYAISJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 13:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753763AbYAISJc
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 13:09:32 -0500
Received: from slim-3c.inet.it ([213.92.5.125]:59719 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbYAISJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 13:09:31 -0500
Received: from host241-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.241]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.241+OxhT5UgYdaq; Wed, 09 Jan 2008 19:09:28 +0100
User-Agent: KMail/1.9.7
In-Reply-To: <18308.2284.160506.432481@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70001>

Fix string substitution using 'string map'. Now the
"Key bindings" menu is ready for translation.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
On Wednesday 09 January 2008, Paul Mackerras wrote:
> Michele Ballabio writes:
> 
> > -"] \
> > +" $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T ] \
> 
> Ick.  Are you sure you have the right number of instances of $M1T? :)

Yes :^P. I was sure there was a better fix but didn't know where to look at.

> I'd prefer to use [string map].

This patch tries to do so. Is this correct?

> Actually, for translation, it would probably be better to bust up that
> help text into a series of shorter strings, maybe even one per line.

Or split this by "topic": "scrolling", "search", "fonts", "history"...

 gitk |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/gitk b/gitk
index 801a5a9..24796e1 100755
--- a/gitk
+++ b/gitk
@@ -1306,10 +1306,10 @@ proc keys {} {
     }
     toplevel $w
     wm title $w [mc "Gitk key bindings"]
-    message $w.m -text [mc "
+    message $w.m -text [ string map "M1T $M1T" [ mc "
 Gitk key bindings:
 
-<$M1T-Q>		Quit
+<M1T-Q>		Quit
 <Home>		Move to first commit
 <End>		Move to last commit
 <Up>, p, i	Move up one commit
@@ -1318,12 +1318,12 @@ Gitk key bindings:
 <Right>, x, l	Go forward in history list
 <PageUp>	Move up one page in commit list
 <PageDown>	Move down one page in commit list
-<$M1T-Home>	Scroll to top of commit list
-<$M1T-End>	Scroll to bottom of commit list
-<$M1T-Up>	Scroll commit list up one line
-<$M1T-Down>	Scroll commit list down one line
-<$M1T-PageUp>	Scroll commit list up one page
-<$M1T-PageDown>	Scroll commit list down one page
+<M1T-Home>	Scroll to top of commit list
+<M1T-End>	Scroll to bottom of commit list
+<M1T-Up>	Scroll commit list up one line
+<M1T-Down>	Scroll commit list down one line
+<M1T-PageUp>	Scroll commit list up one page
+<M1T-PageDown>	Scroll commit list down one page
 <Shift-Up>	Find backwards (upwards, later commits)
 <Shift-Down>	Find forwards (downwards, earlier commits)
 <Delete>, b	Scroll diff view up one page
@@ -1331,20 +1331,20 @@ Gitk key bindings:
 <Space>		Scroll diff view down one page
 u		Scroll diff view up 18 lines
 d		Scroll diff view down 18 lines
-<$M1T-F>		Find
-<$M1T-G>		Move to next find hit
+<M1T-F>		Find
+<M1T-G>		Move to next find hit
 <Return>	Move to next find hit
 /		Move to next find hit, or redo find
 ?		Move to previous find hit
 f		Scroll diff view to next file
-<$M1T-S>		Search for next hit in diff view
-<$M1T-R>		Search for previous hit in diff view
-<$M1T-KP+>	Increase font size
-<$M1T-plus>	Increase font size
-<$M1T-KP->	Decrease font size
-<$M1T-minus>	Decrease font size
+<M1T-S>		Search for next hit in diff view
+<M1T-R>		Search for previous hit in diff view
+<M1T-KP+>	Increase font size
+<M1T-plus>	Increase font size
+<M1T-KP->	Decrease font size
+<M1T-minus>	Decrease font size
 <F5>		Update
-"] \
+" ] ] \
 	    -justify left -bg white -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
     button $w.ok -text [mc "Close"] -command "destroy $w" -default active
-- 
1.5.3.5
