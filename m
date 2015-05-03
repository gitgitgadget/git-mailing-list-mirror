From: Alangi Derick <alangiderick@gmail.com>
Subject: [PATCH] fixed translation error-1
Date: Sun, 3 May 2015 23:25:18 +0100
Message-ID: <554769b8.e25bb40a.1c70.ffff88bd@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon May 04 14:44:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpFjw-0008RO-BU
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 14:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbbEDMor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 08:44:47 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37732 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbbEDMom (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 08:44:42 -0400
Received: by widdi4 with SMTP id di4so108639558wid.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject;
        bh=bUtTgJ/gemzzyp/YOZBI0RABAPfZhrh7NGziTGTJaSc=;
        b=aQB9ycNxoa1lXpwokKSPtZAiA1TiOdH6fE7c9pDI/PIwtVG40JucjcH+2m/szH6TJy
         uhmEUtadEt9PrEecvPoA6+m0tUNqQmtYJ+l2r3MyVOBxiUBgRxtJ/Uq54gshVVHYhhjc
         PX8m3NnOvn6SgK6o0iVF5Ff00GpaCmojvYGWTPA2sgo7ObIzu5RtHFTOBvoGCNbPnZXc
         NY1PPNS3C+0WlH5GQo1CF98QZs6BPJsVyYuQ2IAx6rrxpYsX95gauCTxQ4uDdxyh0SfX
         sGG8X1KT15Is4wFCevJVLfcmWyC5KW83nijYo8UD/WG9WGWTlP3WsN6sCUkPwI8RYDN4
         751Q==
X-Received: by 10.194.236.66 with SMTP id us2mr42298236wjc.54.1430743481465;
        Mon, 04 May 2015 05:44:41 -0700 (PDT)
Received: from localhost ([195.24.220.134])
        by mx.google.com with ESMTPSA id ch2sm11049979wib.18.2015.05.04.05.44.37
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2015 05:44:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268321>

Signed-off-by: Alangi Derick <alangiderick@gmail.com>
---
 builtin/check-attr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 21d2bed..fba1b52 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -58,11 +58,11 @@ static void check_attr(const char *prefix, int cnt,
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 	if (check != NULL) {
 		if (git_check_attr(full_path, cnt, check))
-			die("git_check_attr died");
+			die(_("git_check_attr died"));
 		output_attr(cnt, check, file);
 	} else {
 		if (git_all_attrs(full_path, &cnt, &check))
-			die("git_all_attrs died");
+			die(_("git_all_attrs died"));
 		output_attr(cnt, check, file);
 		free(check);
 	}
@@ -81,7 +81,7 @@ static void check_attr_stdin_paths(const char *prefix, int cnt,
 		if (line_termination && buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
-				die("line is badly quoted");
+				die(_("line is badly quoted"));
 			strbuf_swap(&buf, &nbuf);
 		}
 		check_attr(prefix, cnt, check, buf.buf);
@@ -93,7 +93,7 @@ static void check_attr_stdin_paths(const char *prefix, int cnt,
 
 static NORETURN void error_with_usage(const char *msg)
 {
-	error("%s", msg);
+	error(_("%s"), msg);
 	usage_with_options(check_attr_usage, check_attr_options);
 }
 
@@ -111,7 +111,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
 	if (read_cache() < 0) {
-		die("invalid cache");
+		die(_("invalid cache"));
 	}
 
 	if (cached_attrs)
@@ -169,7 +169,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 			name = argv[i];
 			a = git_attr(name);
 			if (!a)
-				return error("%s: not a valid attribute name",
+				return error(_("%s: not a valid attribute name"),
 					name);
 			check[i].attr = a;
 		}
-- 
2.4.0.3.g9c6ac00.dirty
