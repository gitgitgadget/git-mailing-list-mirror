From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Minor addition to git-check-ref-format man page
Date: Sun, 15 Jul 2007 08:18:08 -0400
Message-ID: <20070715081808.17e0564e.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 15 14:20:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA35P-0006Y1-3N
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 14:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbXGOMUX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 08:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbXGOMUX
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 08:20:23 -0400
Received: from bay0-omc3-s32.bay0.hotmail.com ([65.54.246.232]:9766 "EHLO
	bay0-omc3-s32.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753515AbXGOMUW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 08:20:22 -0400
Received: from BAYC1-PASMTP08.bayc1.hotmail.com ([65.54.191.168]) by bay0-omc3-s32.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 05:20:22 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP08.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 05:21:43 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IA35I-0000VI-E6
	for git@vger.kernel.org; Sun, 15 Jul 2007 08:20:20 -0400
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 15 Jul 2007 12:21:43.0281 (UTC) FILETIME=[B4430610:01C7C6DA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52547>


Mention that refname must include at least one slash to
be considered valid.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 Documentation/git-check-ref-format.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 13a5f43..4f80053 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -11,11 +11,13 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Checks if a given 'refname' is acceptable, and exits non-zero if
-it is not.
+Checks if a given 'refname' is acceptable and exits with zero if
+it is all right.  To be considered acceptable, the refname must
+contain at least one slash '/' character (eg. heads/master).
 
 A reference is used in git to specify branches and tags.  A
-branch head is stored under `$GIT_DIR/refs/heads` directory, and
+branch head is stored under `$GIT_DIR/refs/heads` directory, a
+remote-branch head is stored under `$GIT_DIR/refs/remotes`, and
 a tag is stored under `$GIT_DIR/refs/tags` directory.  git
 imposes the following rules on how refs are named:
 
@@ -32,7 +34,7 @@ imposes the following rules on how refs are named:
 
 . It cannot end with a slash `/`.
 
-These rules makes it easy for shell script based tools to parse
+These rules make it easy for shell script based tools to parse
 refnames, pathname expansion by the shell when a refname is used
 unquoted (by mistake), and also avoids ambiguities in certain
 refname expressions (see gitlink:git-rev-parse[1]).  Namely:
-- 
1.5.2.2
