From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH 1/3] git-mailsplit: Show parameter '--keep-cr' in usage and documentation
Date: Sat, 13 Feb 2010 17:59:20 +0100
Message-ID: <1266080362-24760-2-git-send-email-stefan.hahn@s-hahn.de>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 18:20:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgLfB-0003cu-Kj
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 18:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757599Ab0BMRUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 12:20:09 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:62090 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab0BMRUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 12:20:07 -0500
Received: from scotty.home (port-92-203-27-201.dynamic.qsc.de [92.203.27.201])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Lsf1t-1NrRRE3ynp-012tT5; Sat, 13 Feb 2010 18:20:06 +0100
Received: from scotty.home (smmsp@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1DHK1YJ026401
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 18:20:02 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1DH0k9t025096;
	Sat, 13 Feb 2010 18:00:46 +0100
X-Mailer: git-send-email 1.7.0.rc2.31.g49e2a
In-Reply-To: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX1+owo4BWiE5VR1pM5m/hF+oHCRCpdJpDLUSDEs
 g+COn90GuT3J8HB9qr7HCNtJE8+MEKfoGph1YHKIBKrX3lb3F5
 TqwbqgSSl+Tomj7PKc7kQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139816>

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
1.7.0.rc2.31.g49e2a
