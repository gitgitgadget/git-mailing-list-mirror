From: Matthias Ruester <matthias.ruester@gmail.com>
Subject: [PATCH] builtin/log.c: mark strings for translation
Date: Mon, 15 Sep 2014 00:07:10 +0200
Message-ID: <1410732430-26730-1-git-send-email-matthias.ruester@gmail.com>
Cc: Matthias Ruester <matthias.ruester@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 00:07:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTHx6-0004Uc-70
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 00:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbaINWHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 18:07:19 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:62450 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbaINWHS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 18:07:18 -0400
Received: by mail-lb0-f182.google.com with SMTP id v6so3348619lbi.41
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=L8g6Sf5UpUnw5b9eR7SStcPstCAvUR8JXkH4oPBKNlY=;
        b=euIQs7MK9UYBxDnny50cLqC8TsrXaMu+6YrFoUiawBWzaOF7phfoSt9uiSh/Za7b+i
         vunNbpmaAIs2Hk5ngdTK6qIO+MLbuKiCtbYMHT7TH+0pPNtKGjDLwHY3u5vA3XzT/JOK
         eZXB3Smys6g3bUAhl0rSaEiay10IoAQrgtvUHsQQ7ke3i13TIHkAXOwIj+esgFQCW2t1
         mJ0Weppp6l/yAqybVW95dVbaGOS+lsmj0emkdambtiMOlkhlAyv3pBJfv4whGRooocy0
         v44E2JAu+lDdQeDqaMdzZoa2kbECh3sXZWRKthsBztH+i9W6c7GStXgLeG2u/oOY9gYQ
         rgSg==
X-Received: by 10.112.160.163 with SMTP id xl3mr4131535lbb.80.1410732436707;
        Sun, 14 Sep 2014 15:07:16 -0700 (PDT)
Received: from localhost.localdomain ([193.25.42.141])
        by mx.google.com with ESMTPSA id t6sm2849830lag.27.2014.09.14.15.07.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Sep 2014 15:07:15 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.240.gee0024b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257031>

Signed-off-by: Matthias Ruester <matthias.ruester@gmail.com>
---
 builtin/log.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e713618..5621475 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -78,7 +78,7 @@ static int decorate_callback(const struct option *opt, const char *arg, int unse
 		decoration_style = DECORATE_SHORT_REFS;
 
 	if (decoration_style < 0)
-		die("invalid --decorate option: %s", arg);
+		die(_("invalid --decorate option: %s"), arg);
 
 	decoration_given = 1;
 
@@ -130,7 +130,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
 		  PARSE_OPT_OPTARG, decorate_callback},
 		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
-			     "Process line range n,m in file, counting from 1",
+			     N_("Process line range n,m in file, counting from 1"),
 			     log_line_range_callback),
 		OPT_END()
 	};
@@ -150,7 +150,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 
 	/* Any arguments at this point are not recognized */
 	if (argc > 1)
-		die("unrecognized argument: %s", argv[1]);
+		die(_("unrecognized argument: %s"), argv[1]);
 
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
@@ -447,13 +447,13 @@ static int show_blob_object(const unsigned char *sha1, struct rev_info *rev, con
 		return stream_blob_to_fd(1, sha1, NULL, 0);
 
 	if (get_sha1_with_context(obj_name, 0, sha1c, &obj_context))
-		die("Not a valid object name %s", obj_name);
+		die(_("Not a valid object name %s"), obj_name);
 	if (!obj_context.path[0] ||
 	    !textconv_object(obj_context.path, obj_context.mode, sha1c, 1, &buf, &size))
 		return stream_blob_to_fd(1, sha1, NULL, 0);
 
 	if (!buf)
-		die("git show %s: bad file", obj_name);
+		die(_("git show %s: bad file"), obj_name);
 
 	write_or_die(1, buf, size);
 	return 0;
-- 
2.1.0.240.gee0024b
