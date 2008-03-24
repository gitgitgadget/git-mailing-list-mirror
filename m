From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] Documentation/git-tag.txt: Clarify tagging of objects
Date: Mon, 24 Mar 2008 16:11:45 +0100
Message-ID: <1206371505-7698-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 24 16:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdoLg-00050K-FT
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 16:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760344AbYCXPLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 11:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759138AbYCXPLt
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 11:11:49 -0400
Received: from smtp-4.orange.nl ([193.252.22.249]:54619 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759042AbYCXPLs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 11:11:48 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6307.orange.nl (SMTP Server) with ESMTP id C6CB6700009A
	for <git@vger.kernel.org>; Mon, 24 Mar 2008 16:11:46 +0100 (CET)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6307.orange.nl (SMTP Server) with ESMTP id 7970B700008F;
	Mon, 24 Mar 2008 16:11:46 +0100 (CET)
X-ME-UUID: 20080324151146497.7970B700008F@mwinf6307.orange.nl
X-Mailer: git-send-email 1.5.4.4.594.g91c25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78050>

Change the synopsis and description of git-tag to reflect that any
object can be tagged, not just a committish.
---
This surprised me, so I guess the documentation deserves some attention.
I'm only able to build the HTML documentation, so I hope this looks correct
in manpages too.

-  Pieter


 Documentation/git-tag.txt |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index b62a3d1..9702f2f 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,7 +9,7 @@ git-tag - Create, list, delete or verify a tag object signed with GPG
 SYNOPSIS
 --------
 [verse]
-'git-tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]  <name> [<head>]
+'git-tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]  <name> [<object>]
 'git-tag' -d <name>...
 'git-tag' [-n [<num>]] -l [<pattern>]
 'git-tag' -v <name>...
@@ -18,6 +18,11 @@ DESCRIPTION
 -----------
 Adds a 'tag' reference in `.git/refs/tags/`
 
+If `<object>` is given, the given object will be tagged. While
+this usually is a committish, other objects may be tagged
+as well. If `<object>` is not given, the current HEAD will be
+tagged.
+
 Unless `-f` is given, the tag must not yet exist in
 `.git/refs/tags/` directory.
 
@@ -26,8 +31,8 @@ creates a 'tag' object, and requires the tag message.  Unless
 `-m <msg>` or `-F <file>` is given, an editor is started for the user to type
 in the tag message.
 
-Otherwise just the SHA1 object name of the commit object is
-written (i.e. a lightweight tag).
+Otherwise just the SHA1 object name of the object is written
+(i.e. a lightweight tag).
 
 A GnuPG signed tag object will be created when `-s` or `-u
 <key-id>` is used.  When `-u <key-id>` is not used, the
-- 
1.5.4.4.594.g91c25
