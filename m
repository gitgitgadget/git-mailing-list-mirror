From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/8] Use 'UTF-8' rather than 'utf-8' everywhere for backward compatibility
Date: Mon, 18 May 2009 18:44:39 -0500
Message-ID: <KfeKNR3Jm6YKvPIcYGBMpLkRr97IFN82BZR2bJNHFQYwhjGgwGRoIAkKO5m1EZb7M9epcX8P-fk@cipher.nrlssc.navy.mil>
References: <KfeKNR3Jm6YKvPIcYGBMpCbbOxxIaBRphS4qzgN2W9mXIvp7Hl8SgBQzbAhZRV4A4Q6X14JTLR4@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpKjNOsMcmMNMJ1vr-EBr-eE371H-Rg69NOM1rMB2Oa5nCGVe2SMGKdc@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 01:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6CW3-0003Pz-Iw
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 01:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbZERXpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 19:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753621AbZERXpA
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 19:45:00 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50113 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbZERXo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 19:44:57 -0400
Received: by mail.nrlssc.navy.mil id n4INitKM024906; Mon, 18 May 2009 18:44:56 -0500
In-Reply-To: <KfeKNR3Jm6YKvPIcYGBMpKjNOsMcmMNMJ1vr-EBr-eE371H-Rg69NOM1rMB2Oa5nCGVe2SMGKdc@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 May 2009 23:44:55.0199 (UTC) FILETIME=[A55B12F0:01C9D812]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119472>

Some ancient platforms (Solaris 7, IRIX 6.5) do not understand 'utf-8', but
all tested implementations understand 'UTF-8'.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-log.c      |    2 +-
 builtin-mailinfo.c |    2 +-
 builtin-revert.c   |    4 ++--
 pretty.c           |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5eaec5d..58db959 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -619,7 +619,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
 	int i;
-	const char *encoding = "utf-8";
+	const char *encoding = "UTF-8";
 	struct diff_options opts;
 	int need_8bit_cte = 0;
 	struct commit *commit = NULL;
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 1eeeb4d..5ebc8b5 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -944,7 +944,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	 */
 	git_config(git_default_config, NULL);
 
-	def_charset = (git_commit_encoding ? git_commit_encoding : "utf-8");
+	def_charset = (git_commit_encoding ? git_commit_encoding : "UTF-8");
 	metainfo_charset = def_charset;
 
 	while (1 < argc && argv[1][0] == '-') {
diff --git a/builtin-revert.c b/builtin-revert.c
index 3f2614e..ae01395 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -323,9 +323,9 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	encoding = get_encoding(message);
 	if (!encoding)
-		encoding = "utf-8";
+		encoding = "UTF-8";
 	if (!git_commit_encoding)
-		git_commit_encoding = "utf-8";
+		git_commit_encoding = "UTF-8";
 	if ((reencoded_message = reencode_string(message,
 					git_commit_encoding, encoding)))
 		message = reencoded_message;
diff --git a/pretty.c b/pretty.c
index a0ef356..e5328da 100644
--- a/pretty.c
+++ b/pretty.c
@@ -284,7 +284,7 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 static char *logmsg_reencode(const struct commit *commit,
 			     const char *output_encoding)
 {
-	static const char *utf8 = "utf-8";
+	static const char *utf8 = "UTF-8";
 	const char *use_encoding;
 	char *encoding;
 	char *out;
@@ -881,7 +881,7 @@ char *reencode_commit_message(const struct commit *commit, const char **encoding
 		    ? git_log_output_encoding
 		    : git_commit_encoding);
 	if (!encoding)
-		encoding = "utf-8";
+		encoding = "UTF-8";
 	if (encoding_p)
 		*encoding_p = encoding;
 	return logmsg_reencode(commit, encoding);
-- 
1.6.3.1.24.g152f4
