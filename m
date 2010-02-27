From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH 1/4] git-mailsplit: Show parameter '--keep-cr' in usage and documentation
Date: Sat, 27 Feb 2010 15:20:25 +0100
Message-ID: <1267280428-18223-2-git-send-email-stefan.hahn@s-hahn.de>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 15:21:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlNXd-0008BS-1I
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 15:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968394Ab0B0OUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 09:20:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:64180 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968378Ab0B0OUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 09:20:52 -0500
Received: from scotty.home (port-92-203-94-156.dynamic.qsc.de [92.203.94.156])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0LeyRX-1NOfeR2RMF-00qhtj; Sat, 27 Feb 2010 15:20:50 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1REKli0019199;
	Sat, 27 Feb 2010 15:20:47 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1REKlDQ019197;
	Sat, 27 Feb 2010 15:20:47 +0100
X-Mailer: git-send-email 1.7.0.98.g42448
In-Reply-To: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX18zllQWrlFIqIvVQe3EJyKcr9ebuNs5VgaM0EQ
 wcplL+llcR3Sn8lI4cf4MdXVUds3CrYxEfC+xSsOu9fcvY0uJc
 MytW7ksr2Y9p5i1mA79qg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141212>

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 Documentation/git-mailsplit.txt |    5 ++++-
 builtin-mailsplit.c             |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 5cc94ec..a634485 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -7,7 +7,7 @@ git-mailsplit - Simple UNIX mbox splitter program
 
 SYNOPSIS
 --------
-'git mailsplit' [-b] [-f<nn>] [-d<prec>] -o<directory> [--] [<mbox>|<Maildir>...]
+'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] -o<directory> [--] [<mbox>|<Maildir>...]
 
 DESCRIPTION
 -----------
@@ -43,6 +43,9 @@ OPTIONS
 	Skip the first <nn> numbers, for example if -f3 is specified,
 	start the numbering with 0004.
 
+--keep-cr::
+	Do not remove `\r` from lines ending with `\r\n`.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 207e358..cdfc1b7 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -10,7 +10,7 @@
 #include "strbuf.h"
 
 static const char git_mailsplit_usage[] =
-"git mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> [<mbox>|<Maildir>...]";
+"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [<mbox>|<Maildir>...]";
 
 static int is_from_line(const char *line, int len)
 {
-- 
1.7.0.98.g42448
