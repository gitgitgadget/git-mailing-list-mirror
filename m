From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] Documentation/config.txt: Fix documentation of colour config tweaks.
Date: Sun, 28 Jan 2007 15:17:36 +0000
Organization: Straylight/Edgeware
Message-ID: <11699974561956-git-send-email-mdw@distorted.org.uk>
Cc: Mark Wooding <mdw@distorted.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 28 16:17:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBBmp-0006h7-9S
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 16:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbXA1PRj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 10:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbXA1PRj
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 10:17:39 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:37110 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1751897AbXA1PRi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jan 2007 10:17:38 -0500
Received: (qmail 13234 invoked by uid 1000); 28 Jan 2007 15:17:36 -0000
X-Mailer: git-send-email 1.5.0.rc2.g4e206
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38035>

  * The description of valid colour specifications was rather
    incomplete, so fix it so that it actually describes colour specs as
    accepted by color_parse().

  * The list of colour items allowed in color.diff.BLAH was missing the
    `commit' and `whitespace' entries.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

Can anyone tell that I've been messing with Git's colour output recently? ;-)

 Documentation/config.txt |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3f2fa09..15f12cf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -250,10 +250,15 @@ color.branch.<slot>::
 	Use customized color for branch coloration. `<slot>` is one of
 	`current` (the current branch), `local` (a local branch),
 	`remote` (a tracking branch in refs/remotes/), `plain` (other
-	refs), or `reset` (the normal terminal color).  The value for
-	these configuration variables can be one of: `normal`, `bold`,
-	`dim`, `ul`, `blink`, `reverse`, `reset`, `black`, `red`,
-	`green`, `yellow`, `blue`, `magenta`, `cyan`, or `white`.
+	refs).
++
+The value for these configuration variables is a list of colors (at most
+two) and attributes (at most one), separated by spaces.  The colors
+accepted are `normal`, `black`, `red`, `green`, `yellow`, `blue`,
+`magenta`, `cyan` and `white`; the attributes are `bold`, `dim`, `ul`,
+`blink` and `reverse`.  The first color given is the foreground; the
+second is the background.  The position of the attribute, if any,
+doesn't matter.
 
 color.diff::
 	When true (or `always`), always use colors in patch.
@@ -261,12 +266,13 @@ color.diff::
 	colors only when the output is to the terminal.
 
 color.diff.<slot>::
-	Use customized color for diff colorization.  `<slot>`
-	specifies which part of the patch to use the specified
-	color, and is one of `plain` (context text), `meta`
-	(metainformation), `frag` (hunk header), `old` (removed
-	lines), or `new` (added lines).  The values of these
-	variables may be specified as in color.branch.<slot>.
+	Use customized color for diff colorization.  `<slot>` specifies
+	which part of the patch to use the specified color, and is one
+	of `plain` (context text), `meta` (metainformation), `frag`
+	(hunk header), `old` (removed lines), `new` (added lines),
+	`commit` (commit headers), or `whitespace` (highlighting dubious
+	whitespace).  The values of these variables may be specified as
+	in color.branch.<slot>.
 
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
-- 
1.5.0.rc2.g4e206
