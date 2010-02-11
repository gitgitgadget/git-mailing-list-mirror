From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: git-mailsplit: Show parameter '--keep-cr' in usage and
	documentation
Date: Thu, 11 Feb 2010 19:13:36 +0100
Message-ID: <20100211181336.GB15028@scotty.home>
References: <1265911741-14840-1-git-send-email-stefan.hahn@s-hahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 19:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfdXt-0004Ub-1E
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 19:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692Ab0BKSNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 13:13:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:61506 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab0BKSNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 13:13:38 -0500
Received: from scotty.home (port-92-203-5-233.dynamic.qsc.de [92.203.5.233])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MIRvH-1NhYp42m1X-004NAY; Thu, 11 Feb 2010 19:13:37 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1BIDacB015136
	for <git@vger.kernel.org>; Thu, 11 Feb 2010 19:13:36 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1BIDaU4015134
	for git@vger.kernel.org; Thu, 11 Feb 2010 19:13:36 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <1265911741-14840-1-git-send-email-stefan.hahn@s-hahn.de>
X-Mailer: git-send-email 1.7.0.rc1.50.g84249.dirty
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX18Un9Y6au4jmW6aDEXKbLbiy3QUpfXuqjci3x0
 kQhuu/5JDLdbboD4vdhxiq3iNSorR/vRdPiv9rkrKZa/2lVd3B
 GtIQk+2R0kIMup7wl160Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139611>

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
1.7.0.rc1.50.g84249.dirty
