From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: improve description of --glob=pattern and friends
Date: Fri, 22 Jan 2010 01:21:38 +0100
Message-ID: <e2e992cfb93335b400fd9ec67c6d38cb0157b006.1264119524.git.trast@student.ethz.ch>
References: <7vbpgnp6d5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 01:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY7I9-0003Gs-6y
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 01:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665Ab0AVAV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 19:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755661Ab0AVAVy
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 19:21:54 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:13539 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755653Ab0AVAVw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 19:21:52 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 22 Jan
 2010 01:21:50 +0100
Received: from localhost.localdomain (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 22 Jan
 2010 01:21:38 +0100
X-Mailer: git-send-email 1.6.6.1.534.gf034a
In-Reply-To: <7vbpgnp6d5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137703>

Consolidate the descriptions of --branches, --tags and --remotes a
bit, to make it less repetitive.  Improve the grammar a bit, and spell
out the meaning of the 'append /*' rule.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Compared to the earlier draft, I changed "it is anchored" (by
appending '/*') to "it is turned into a prefix match", since this is
not anchoring in the ^regex$ sense.  (I guess 'leading-component
match' would be even more accurate, but that makes the sentence
unwieldy in my ears.)


 Documentation/git-rev-parse.txt |   32 +++++++++++++++-----------------
 1 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index e2cb913..e7845d4 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -104,25 +104,23 @@ OPTIONS
 	Show all refs found in `$GIT_DIR/refs`.
 
 --branches[=pattern]::
-	Show branch refs found in `$GIT_DIR/refs/heads`. If `pattern`
-	is given, only branches matching given shell glob are shown.
-	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
-
 --tags[=pattern]::
-	Show tag refs found in `$GIT_DIR/refs/tags`. If `pattern`
-	is given, only tags matching given shell glob are shown.
-	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
-
 --remotes[=pattern]::
-	Show tag refs found in `$GIT_DIR/refs/remotes`. If `pattern`
-	is given, only remote tracking branches matching given shell glob
-	are shown. If pattern lacks '?', '*', or '[', '/*' at the end is
-	impiled.
-
---glob=glob-pattern::
-	Show refs matching shell glob pattern `glob-pattern`. If pattern
-	specified lacks leading 'refs/', it is automatically prepended.
-	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
+	Show all branches, tags, or remote-tracking branches,
+	respectively (i.e., refs found in `$GIT_DIR/refs/heads`,
+	`$GIT_DIR/refs/tags`, or `$GIT_DIR/refs/remotes`,
+	respectively).
++
+If a `pattern` is given, only refs matching the given shell glob are
+shown.  If the pattern does not contain a globbing character (`?`,
+`\*`, or `[`), it is turned into a prefix match by appending `/\*`.
+
+--glob=pattern::
+	Show all refs matching the shell glob pattern `pattern`. If
+	the pattern does not start with `refs/`, this is automatically
+	prepended.  If the pattern does not contain a globbing
+	character (`?`, `\*`, or `[`), it is turned into a prefix
+	match by appending `/\*`.
 
 --show-toplevel::
 	Show the absolute path of the top-level directory.
-- 
1.6.6.1.534.gf034a
