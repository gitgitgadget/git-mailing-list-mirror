From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v5 4/5] fmt-merge-msg: Remove deprecated '--summary' option
Date: Sun, 22 Aug 2010 21:56:37 +0530
Message-ID: <1282494398-20542-5-git-send-email-artagnon@gmail.com>
References: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 22 18:30:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnDR7-00047i-Om
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 18:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419Ab0HVQ31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 12:29:27 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39817 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab0HVQ3L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 12:29:11 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so1793710pwi.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 09:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=13oig+0SgZPuRwR4ph4xXCmFtRMfRl+N9wcF0OxsBGo=;
        b=bv1HFlEPyNRd1Rf/cQgFdazW6Jmzzez5rWzepw64XxKfgvtVcIlr/uc2ZaYnoiOTSJ
         PcMUpgbsLRvzIdayzRnbb6Q0CnUkIuGFr9+qiqTTGN1E8aw/DQ6aJoMWp2pb6VYZmD7G
         APGWu6t8O0avmvR8vogakoawvYwIwYlb/XBmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ILytQhCqw8vWpkaOYgG7806Qn4oAsj7TuyUqE8UOOR/KLJjHrn3v9eiBfAiLEeJlCc
         1urqhkhyAvty1/OkhiNS1+w50cL6wsGpxP3wh+veu/jCmTAMM2RazNas3G5ICc+WCZfg
         iB+pBEMhn5kU2LNV3qgatgRmmzCRox7t8Y4/I=
Received: by 10.142.133.2 with SMTP id g2mr3231675wfd.240.1282494550653;
        Sun, 22 Aug 2010 09:29:10 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id y16sm7089065wff.14.2010.08.22.09.29.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Aug 2010 09:29:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154185>

Remove the deprecated '--summary' option that served as a syonym to
the '--log' option. Also update the documentation accordingly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-fmt-merge-msg.txt |    9 ---------
 Documentation/merge-options.txt     |    5 -----
 builtin/fmt-merge-msg.c             |    5 +----
 builtin/merge.c                     |    2 +-
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 5954a53..a0eb7e2 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -35,11 +35,6 @@ OPTIONS
 	Do not list one-line descriptions from the actual commits being
 	merged.
 
---summary::
---no-summary::
-	Synonyms to --log and --no-log; these are deprecated and will be
-	removed in the future.
-
 -m <message>::
 --message <message>::
 	Use <message> instead of the branch names for the first line
@@ -57,10 +52,6 @@ merge.log::
 	Whether to include summaries of merged commits in newly
 	merge commit messages. False by default.
 
-merge.summary::
-	Synonym to `merge.log`; this is deprecated and will be removed in
-	the future.
-
 SEE ALSO
 --------
 linkgit:git-merge[1]
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 1083f19..8001005 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -67,11 +67,6 @@ option can be used to override --squash.
 	Pass merge strategy specific option through to the merge
 	strategy.
 
---summary::
---no-summary::
-	Synonyms to --stat and --no-stat; these are deprecated and will be
-	removed in the future.
-
 ifndef::git-pull[]
 -q::
 --quiet::
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 6a2c9c8..4255890 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -15,7 +15,7 @@ static int shortlog_len;
 
 static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
-	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
+	if (!strcmp(key, "merge.log")) {
 		int is_bool;
 		shortlog_len = git_config_bool_or_int(key, value, &is_bool);
 		if (is_bool && shortlog_len)
@@ -320,9 +320,6 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
 		  "populate log with <n> entries from shortlog",
 		  PARSE_OPT_OPTARG, NULL, 20 },
-		{ OPTION_INTEGER, 0, "summary", &shortlog_len, "n",
-                  "alias for --log (deprecated)",
-		  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, NULL, 20 },
 		OPT_STRING('m', "message", &message, "text",
 			"use <text> as start of message"),
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
diff --git a/builtin/merge.c b/builtin/merge.c
index 78d6c69..9196428 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -505,7 +505,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
-	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary")) {
+	else if (!strcmp(k, "merge.log")) {
 		int is_bool;
 		shortlog_len = git_config_bool_or_int(k, v, &is_bool);
 		if (is_bool && shortlog_len)
-- 
1.7.2.2.409.gdbb11.dirty
