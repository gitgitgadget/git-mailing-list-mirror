From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH (GIT-GUI)] git-gui: Add more integration options to
	citool.
Date: Fri, 26 Sep 2008 07:45:36 -0700
Message-ID: <20080926144536.GA3669@spearce.org>
References: <200809122243.50007.angavrilov@gmail.com> <20080924165201.GV3669@spearce.org> <200809261419.41392.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 16:47:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjEal-0001iQ-T2
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 16:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbYIZOph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 10:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbYIZOph
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 10:45:37 -0400
Received: from george.spearce.org ([209.20.77.23]:53082 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbYIZOph (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 10:45:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 873B13835F; Fri, 26 Sep 2008 14:45:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809261419.41392.angavrilov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96860>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> On Wednesday 24 September 2008 20:52:01 Shawn O. Pearce wrote:
> > 
> > --8<--
> > git-gui: Hide commit related UI during citool --nocommit
> 
> I believe that the 'Sign Off' button should better be controlled by the nocommitmsg
> option; otherwise this looks good to me. But I'm not the best thinker at the
> moment (had a cold).

Since I've already pushed that patch in both git-gui.git and git.git
how is this as a followup?

--8<--
git-gui: Show/hide "Sign Off" based on nocommitmsg option

If citool --nocommit is invoked we hide the Sign Off features, as
the commit message area is not editable.  But we really want the
selection tied to the message area's editing ability.

Suggested-by: Alexander Gavrilov <angavrilov@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-gui.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 4085e8f..09ce410 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2413,7 +2413,7 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 
 	.mbar.commit add separator
 
-	if {![is_enabled nocommit]} {
+	if {![is_enabled nocommitmsg]} {
 		.mbar.commit add command -label [mc "Sign Off"] \
 			-command do_signoff \
 			-accelerator $M1T-S
@@ -2743,7 +2743,7 @@ pack .vpane.lower.commarea.buttons.incall -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.incall conf -state}
 
-if {![is_enabled nocommit]} {
+if {![is_enabled nocommitmsg]} {
 	button .vpane.lower.commarea.buttons.signoff -text [mc "Sign Off"] \
 		-command do_signoff
 	pack .vpane.lower.commarea.buttons.signoff -side top -fill x
-- 
1.6.0.2.508.g2bf53a


-- 
Shawn.
