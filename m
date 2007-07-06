From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-gui: Allow users to set commit.signoff from options.
Date: Fri, 6 Jul 2007 14:46:54 +0000
Message-ID: <20070706144654.12095.qmail@c8e1b1dc78de94.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 16:47:29 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6p5j-0004k5-40
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 16:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbXGFOrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 10:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbXGFOrZ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 10:47:25 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:41335 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752654AbXGFOrY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 10:47:24 -0400
Received: (qmail 12096 invoked by uid 1000); 6 Jul 2007 14:46:54 -0000
Mail-Followup-To: "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51756>

Users may want to automatically sign-off any commit for a specific
repository.  If they are mostly a git-gui user they should be able to
view/set this option from within the git-gui environment, rather than
needing to edit a raw text file on their local filesystem.

This was noticed and requested by Josh Triplett through
 http://bugs.debian.org/412776

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-gui.sh     |    1 +
 lib/option.tcl |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 0096f49..5ded736 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1295,6 +1295,7 @@ set default_config(merge.summary) false
 set default_config(merge.verbosity) 2
 set default_config(user.name) {}
 set default_config(user.email) {}
+set default_config(commit.signoff) false
 
 set default_config(gui.pruneduringfetch) false
 set default_config(gui.trustmtime) false
diff --git a/lib/option.tcl b/lib/option.tcl
index ae19a8f..28208ce 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -188,6 +188,7 @@ proc do_options {} {
 		{b merge.summary {Summarize Merge Commits}}
 		{i-1..5 merge.verbosity {Merge Verbosity}}
 		{b merge.diffstat {Show Diffstat After Merge}}
+		{b commit.signoff {Automatically Sign-off}}
 
 		{b gui.trustmtime  {Trust File Modification Timestamps}}
 		{b gui.pruneduringfetch {Prune Tracking Branches During Fetch}}
-- 
1.5.2.1
