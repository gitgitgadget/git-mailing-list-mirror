From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Rename --with-raw to --patch-with-raw and document it
Date: Tue, 11 Apr 2006 13:22:17 +0200
Message-ID: <20060411112217.10363.66165.stgit@machine.or.cz>
References: <7vr7456jb4.fsf@assigned-by-dhcp.cox.net>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 11 13:22:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTGwt-0003V2-AP
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 13:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWDKLWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 07:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWDKLWH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 07:22:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55501 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750751AbWDKLWG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Apr 2006 07:22:06 -0400
Received: (qmail 10379 invoked from network); 11 Apr 2006 13:22:17 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 11 Apr 2006 13:22:17 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7456jb4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18609>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/diff-options.txt |    3 +++
 diff.c                         |    2 +-
 diff.h                         |    2 ++
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index ec6811c..338014c 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -4,6 +4,9 @@
 -u::
 	Synonym for "-p".
 
+--patch-with-raw::
+	Generate patch but keep also the default raw diff output.
+
 -z::
 	\0 line termination on output
 
diff --git a/diff.c b/diff.c
index 12924f2..00c79aa 100644
--- a/diff.c
+++ b/diff.c
@@ -862,7 +862,7 @@ int diff_opt_parse(struct diff_options *
 	const char *arg = av[0];
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
 		options->output_format = DIFF_FORMAT_PATCH;
-	else if (!strcmp(arg, "--with-raw")) {
+	else if (!strcmp(arg, "--patch-with-raw")) {
 		options->output_format = DIFF_FORMAT_PATCH;
 		options->with_raw = 1;
 	}
diff --git a/diff.h b/diff.h
index 07b153b..c5372b9 100644
--- a/diff.h
+++ b/diff.h
@@ -113,6 +113,8 @@ #define COMMON_DIFF_OPTIONS_HELP \
 "  -z            output diff-raw with lines terminated with NUL.\n" \
 "  -p            output patch format.\n" \
 "  -u            synonym for -p.\n" \
+"  --patch-with-raw\n" \
+"                output both a patch and the diff-raw format.\n" \
 "  --name-only   show only names of changed files.\n" \
 "  --name-status show names and status of changed files.\n" \
 "  --full-index  show full object name on index lines.\n" \
