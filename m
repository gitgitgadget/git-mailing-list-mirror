X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Document git-runstatus
Date: Sat, 18 Nov 2006 15:15:49 +0100
Message-ID: <455F1595.9020009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 14:15:41 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31772>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlQyp-0002Wk-Gx for gcvg-git@gmane.org; Sat, 18 Nov
 2006 15:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754653AbWKROPc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 09:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbWKROPc
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 09:15:32 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:5595 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S1754653AbWKROPb (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18
 Nov 2006 09:15:31 -0500
Received: from [10.0.1.3] (p508E406F.dip.t-dialin.net [80.142.64.111]) by
 neapel230.server4you.de (Postfix) with ESMTP id D63082600C; Sat, 18 Nov 2006
 15:15:29 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

I copied most of the text from git-status.txt.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-runstatus.txt |   66 +++++++++++++++++++++++++++++++++++++++
 builtin-runstatus.c             |    2 +-
 2 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-runstatus.txt b/Documentation/git-runstatus.txt
new file mode 100644
index 0000000..c144c7b
--- /dev/null
+++ b/Documentation/git-runstatus.txt
@@ -0,0 +1,66 @@
+git-runstatus(1)
+================
+
+NAME
+----
+git-runstatus - Show working tree status
+
+
+SYNOPSIS
+--------
+'git-runstatus' [--color|--nocolor] [--amend] [--verbose] [--untracked]
+
+
+DESCRIPTION
+-----------
+Examines paths in the working tree that has changes unrecorded
+to the index file, and changes between the index file and the
+current HEAD commit.  The former paths are what you _could_
+commit by running 'git-update-index' before running 'git
+commit', and the latter paths are what you _would_ commit by
+running 'git commit'.
+
+If there is no path that is different between the index file and
+the current HEAD commit, the command exits with non-zero
+status.
+
+
+OPTIONS
+-------
+--color::
+	Show colored status, highlighting modified file names.
+
+--nocolor::
+	Turn off coloring.
+
+--amend::
+	Show status based on HEAD^1, not HEAD, i.e. show what
+	'git-commit --amend' would do.
+
+--verbose::
+	Show unified diff of all file changes.
+
+--untracked::
+	Show files in untracked directories, too.  Without this
+	option only its name and a trailing slash are displayed
+	for each untracked directory.
+
+
+OUTPUT
+------
+The output from this command is designed to be used as a commit
+template comments, and all the output lines are prefixed with '#'.
+
+
+Author
+------
+Written by Jeff King.
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index 303c556..0b63037 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -4,7 +4,7 @@
 extern int wt_status_use_color;
 
 static const char runstatus_usage[] =
-"git-runstatus [--color|--nocolor] [--amend] [--verbose]";
+"git-runstatus [--color|--nocolor] [--amend] [--verbose] [--untracked]";
 
 int cmd_runstatus(int argc, const char **argv, const char *prefix)
 {
-- 
1.4.4
