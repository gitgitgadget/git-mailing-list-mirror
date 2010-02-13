From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 23/30] builtin-notes: Add --message/--file aliases for -m/-F
 options
Date: Sat, 13 Feb 2010 22:28:31 +0100
Message-ID: <1266096518-2104-24-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPap-0002mJ-Bl
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758158Ab0BMVat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:30:49 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51460 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758117Ab0BMV3y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:54 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00EGJUDOVE80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:48 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:48 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139856>

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |    2 ++
 builtin-notes.c             |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 4d29d5f..8969f6f 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -58,11 +58,13 @@ prune::
 OPTIONS
 -------
 -m <msg>::
+--message=<msg>::
 	Use the given note message (instead of prompting).
 	If multiple `-m` options are given, their values
 	are concatenated as separate paragraphs.
 
 -F <file>::
+--file=<file>::
 	Take the note message from the given file.  Use '-' to
 	read the note message from the standard input.
 
diff --git a/builtin-notes.c b/builtin-notes.c
index b808534..ec959bc 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -217,9 +217,9 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct option options[] = {
 		OPT_GROUP("Notes edit options"),
-		OPT_CALLBACK('m', NULL, &msg, "msg",
+		OPT_CALLBACK('m', "message", &msg, "msg",
 			     "note contents as a string", parse_msg_arg),
-		OPT_FILENAME('F', NULL, &msgfile, "note contents in a file"),
+		OPT_FILENAME('F', "file", &msgfile, "note contents in a file"),
 		OPT_END()
 	};
 
-- 
1.7.0.rc1.141.gd3fd
