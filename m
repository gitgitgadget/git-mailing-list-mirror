From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] Replace remaining instances of strdup with xstrdup.
Date: Mon, 19 Mar 2007 17:42:40 -0400
Message-ID: <1174340560341-git-send-email-jbowes@dangerouslyinc.com>
Cc: junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 22:45:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTPfv-0003t2-HX
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 22:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030636AbXCSVoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 17:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030657AbXCSVnv
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 17:43:51 -0400
Received: from ms-smtp-01.southeast.rr.com ([24.25.9.100]:38460 "EHLO
	ms-smtp-01.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030654AbXCSVnc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2007 17:43:32 -0400
Received: from localhost (cpe-066-057-086-146.nc.res.rr.com [66.57.86.146])
	by ms-smtp-01.southeast.rr.com (8.13.6/8.13.6) with ESMTP id l2JLhTuW004286;
	Mon, 19 Mar 2007 17:43:29 -0400 (EDT)
X-Mailer: git-send-email 1.5.0.3
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42672>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---

This is a blatant copy of Shawn's patch. I don't know if there's a reason these
are still strdup. If there is, please ignore this patch :)

 builtin-log.c |    2 +-
 commit.c      |    2 +-
 revision.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 865832c..71df957 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -35,7 +35,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		if (!prefixcmp(arg, "--encoding=")) {
 			arg += 11;
 			if (strcmp(arg, "none"))
-				git_log_output_encoding = strdup(arg);
+				git_log_output_encoding = xstrdup(arg);
 			else
 				git_log_output_encoding = "";
 		}
diff --git a/commit.c b/commit.c
index 5b9234e..718e568 100644
--- a/commit.c
+++ b/commit.c
@@ -706,7 +706,7 @@ static char *logmsg_reencode(const struct commit *commit,
 	encoding = get_header(commit, "encoding");
 	use_encoding = encoding ? encoding : utf8;
 	if (!strcmp(use_encoding, output_encoding))
-		out = strdup(commit->buffer);
+		out = xstrdup(commit->buffer);
 	else
 		out = reencode_string(commit->buffer,
 				      output_encoding, use_encoding);
diff --git a/revision.c b/revision.c
index bcdb6a1..c680dcb 100644
--- a/revision.c
+++ b/revision.c
@@ -1038,7 +1038,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			if (!prefixcmp(arg, "--encoding=")) {
 				arg += 11;
 				if (strcmp(arg, "none"))
-					git_log_output_encoding = strdup(arg);
+					git_log_output_encoding = xstrdup(arg);
 				else
 					git_log_output_encoding = "";
 				continue;
-- 
1.5.1.rc1.1.g504b
