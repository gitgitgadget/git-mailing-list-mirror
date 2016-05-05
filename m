From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 14/19] index-helper: kill mode
Date: Thu,  5 May 2016 17:47:06 -0400
Message-ID: <1462484831-13643-15-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:48:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR81-0008DU-JJ
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757818AbcEEVsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:48:00 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33552 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757948AbcEEVrt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:49 -0400
Received: by mail-qk0-f170.google.com with SMTP id n63so50928465qkf.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0gyGUBG6EShx4FuR4U6rO4q5iv//2FUhAK6WrxfyK7M=;
        b=mSSGQx0hw/E1DU5eqTRGrPjcPf7ZlmBwsUXJuYM7h7vTBzmw/k5+wHwUOSBt/A6ECe
         UIvylufPh+13397Y7zz64yLZzYMwwhey/eYaSl3vlIXgnKRbYW0w5D4quqo+Z41hINJQ
         JUuCLuRhH+GDAZjuHIyyzg+wyEBGbuptuudRduE9Qyt20PevylJ+uFyoiyuyI2Iw/tpu
         FsRLzBm/xwA73UFn9ca2u056/LfgksL9ekWUx62RZNdkfuHkt+PRJBdJuDsfgQeHSaSj
         4ABpVsYPhgWE97D54TNnIm/WozUS2EwxbYBfIew/vc1Zdn1klC4I5ZKzZUg/9Pys6Z77
         fPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0gyGUBG6EShx4FuR4U6rO4q5iv//2FUhAK6WrxfyK7M=;
        b=T0ieidyNQ5+VDaZXo/H7ElWfSMuGLDAQvPxCQPmADP72XWmMNx+3fWaVlbwof3/9p0
         Rvus1AUsDiXVvHLqSOdz+nahXcPH0vLstKjwkjrJf9fCpKlbLZwSccA7ZuZt9lpEokak
         OB7pS8594uoXlb3oSMeYugob3XEDOSqrxpghKElGS+WpUqnu0LahbM97b5ZCDyOs0pOq
         PVtm0mWz6Eiow+FGxJj6nbEsgplXgA4Kic5xgpl/b1GxLpe0N/Y71Y66/MkSqqbup3N1
         pTmfQr09S9z5NvJCYxOgDOQoRWTueYSvTG9Kn0TOhc95ZZqAKU2+CflgiwgR7xoHXkwA
         fthA==
X-Gm-Message-State: AOPr4FWLwv93qDu4lC7MpMVQUbIyT69cQq00wl88LaQbjDcZHpU4zhpCV8txedQzZHneQQ==
X-Received: by 10.55.21.233 with SMTP id 102mr17182252qkv.161.1462484863297;
        Thu, 05 May 2016 14:47:43 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:42 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293698>

Add a new command (and command-line arg) to allow index-helpers to
exit cleanly.

This is mainly useful for tests.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 31 ++++++++++++++++++++++++++++++-
 t/t7900-index-helper.sh            |  9 +++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index 55a8a5a..addf694 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -40,6 +40,9 @@ OPTIONS
 --detach::
 	Detach from the shell.
 
+--kill::
+	Kill any running index-helper and clean up the socket
+
 NOTES
 -----
 
diff --git a/index-helper.c b/index-helper.c
index 71c4f48..4ed1610 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -373,6 +373,8 @@ static void loop(int fd, int idle_in_seconds)
 					 * alive, nothing to do.
 					 */
 				}
+			} else if (!strcmp(buf, "die")) {
+				break;
 			} else {
 				log_warning("BUG: Bogus command %s", buf);
 			}
@@ -403,10 +405,29 @@ static const char * const usage_text[] = {
 	NULL
 };
 
+static void request_kill(void)
+{
+	int fd = unix_stream_connect(git_path("index-helper.sock"));
+
+	if (fd >= 0) {
+		write_in_full(fd, "die", 4);
+		close(fd);
+	}
+
+	/*
+	 * The child will try to do this anyway, but we want to be
+	 * ready to launch a new daemon immediately after this command
+	 * returns.
+	 */
+
+	unlink(git_path("index-helper.sock"));
+	return;
+}
+
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds = 600, detach = 0;
+	int idle_in_seconds = 600, detach = 0, kill = 0;
 	int fd;
 	struct strbuf socket_path = STRBUF_INIT;
 	struct option options[] = {
@@ -415,6 +436,7 @@ int main(int argc, char **argv)
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
+		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
 		OPT_END()
 	};
 
@@ -429,6 +451,13 @@ int main(int argc, char **argv)
 			  options, usage_text, 0))
 		die(_("too many arguments"));
 
+	if (kill) {
+		if (detach)
+			die(_("--kill doesn't want any other options"));
+		request_kill();
+		return 0;
+	}
+
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
 
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 114c112..e71b5af 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -20,4 +20,13 @@ test_expect_success 'index-helper smoke test' '
 	test_path_is_missing .git/index-helper.sock
 '
 
+test_expect_success 'index-helper creates usable path file and can be killed' '
+	test_when_finished "git index-helper --kill" &&
+	test_path_is_missing .git/index-helper.sock &&
+	git index-helper --detach &&
+	test -S .git/index-helper.sock &&
+	git index-helper --kill &&
+	test_path_is_missing .git/index-helper.sock
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
