From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] git-am/git-mailsplit: correct synopsis for reading from stdin
Date: Sat, 12 Jul 2008 17:47:16 +0200
Message-ID: <1215877636-16982-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 17:48:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHhKd-00066o-SU
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 17:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbYGLPrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 11:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbYGLPrV
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 11:47:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:53907 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753575AbYGLPrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 11:47:20 -0400
Received: (qmail invoked by alias); 12 Jul 2008 15:47:18 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp032) with SMTP; 12 Jul 2008 17:47:18 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+bNz4hHQ6bKxMhS/P5eed4cgsIMVP/LoUOXWU8gG
	PUTWJQAwM25R5c
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHhJc-0004QH-Rd; Sat, 12 Jul 2008 17:47:16 +0200
X-Mailer: git-send-email 1.5.6.2.303.g79662
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88247>

Invoking git-am or git-mailsplit without mbox or Maildir results
in reading an mbox from stdin.
This should be mentioned in the synopsis and usage strings.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 Documentation/git-am.txt |    4 ++--
 builtin-mailsplit.c      |    2 +-
 git-am.sh                |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 3863eeb..2842880 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -12,8 +12,8 @@ SYNOPSIS
 'git am' [--signoff] [--keep] [--utf8 | --no-utf8]
          [--3way] [--interactive] [--binary]
          [--whitespace=<option>] [-C<n>] [-p<n>]
-         <mbox>|<Maildir>...
-'git am' [--skip | --resolved]
+         [<mbox> | <Maildir>...]
+'git am' (--skip | --resolved)
 
 DESCRIPTION
 -----------
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index ae2b4cb..e8cbe67 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -9,7 +9,7 @@
 #include "path-list.h"
 
 static const char git_mailsplit_usage[] =
-"git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>|<Maildir>...";
+"git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> [<mbox>|<Maildir>...]";
 
 static int is_from_line(const char *line, int len)
 {
diff --git a/git-am.sh b/git-am.sh
index 83b277a..4e73f93 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -5,7 +5,7 @@
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-git-am [options] <mbox>|<Maildir>...
+git-am [options] [<mbox>|<Maildir>...]
 git-am [options] --resolved
 git-am [options] --skip
 --
-- 
1.5.6.2.303.g79662
