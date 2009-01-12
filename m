From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH next] notes: fix core.notesRef documentation
Date: Mon, 12 Jan 2009 15:16:04 +0100
Message-ID: <1231769764-17294-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 15:17:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMNc2-0004i1-Iw
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 15:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbZALOQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 09:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbZALOQR
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 09:16:17 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:50547 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbZALOQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 09:16:16 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Jan 2009 15:16:13 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Jan 2009 15:16:13 +0100
X-Mailer: git-send-email 1.6.1.310.g1063e
X-OriginalArrivalTime: 12 Jan 2009 14:16:13.0358 (UTC) FILETIME=[531AD4E0:01C974C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105345>

The path format was inconsistent with the one used in git-notes.sh: it
supposedly split the sha1 in the same 2/38 format that .git/objects
uses, but the code uses the full sha1 without a path separator.

While at it, also fix a grammatical error.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---
 Documentation/config.txt |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index acfeb77..348da77 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -424,15 +424,13 @@ overlapping IO's.
 
 core.notesRef::
 	When showing commit messages, also show notes which are stored in
-	the given ref.  This ref is expected to contain paths of the form
-	??/*, where the directory name consists of the first two
-	characters of the commit name, and the base name consists of
-	the remaining 38 characters.
+	the given ref.  This ref is expected to contain files named
+	after the full SHA-1 of the commit they annotate.
 +
-If such a path exists in the given ref, the referenced blob is read, and
+If such a file exists in the given ref, the referenced blob is read, and
 appended to the commit message, separated by a "Notes:" line.  If the
 given ref itself does not exist, it is not an error, but means that no
-notes should be print.
+notes should be printed.
 +
 This setting defaults to "refs/notes/commits", and can be overridden by
 the `GIT_NOTES_REF` environment variable.
-- 
tg: (1063ea4..) t/notes-doc-fix (depends on: next)
