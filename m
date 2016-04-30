From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 14/19] index-helper: kill mode
Date: Fri, 29 Apr 2016 21:02:08 -0400
Message-ID: <1461978133-13966-15-git-send-email-dturner@twopensource.com>
References: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:03:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJJM-00089Y-Um
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbcD3BDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 21:03:04 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34680 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbcD3BCk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:40 -0400
Received: by mail-qg0-f54.google.com with SMTP id 90so34036066qgz.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yg1nQ1tLFmKbdEm9acNnEShDjhOQg3RzFJsCHoFCcU8=;
        b=e+WmQCJ/o/Kt3wxTqyK5b6yufRzv4r9/7TG8dNJ2YQZEWCz20qNieYo8bOjKyUw1YS
         gNGYr5o1FMy8HGV3wSbQb8j2rrWghvwLGfq6Jn6xq3LOaygf16mR2J8HQziR76I9CzQB
         rkkcIFohCJOx8G7L9kwoGAM+W8BFcbeq5EdVrbunSCQ5fhYt6HsKyP3LyEMQs+b4JFDb
         MHc7UGpx/riWmIvZhbdygzGwbQ6s664lKnQBIwCSWENS5YKv6/rRd9ue9jI49FRDriUw
         zhlzrt/5pmKMhvtbx77mYJ2m+8D9bni+haHycUszDM/FBjyfqYR3hD5lwjmtxH1y0K+C
         SfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yg1nQ1tLFmKbdEm9acNnEShDjhOQg3RzFJsCHoFCcU8=;
        b=B2mlNT1VbSLTO45c7moIsZHEH605z8JXhzXOfHc2NuVufKGE6dwMSZ0BPsCSjhcFw8
         95EcSNvVbv7MmtwCKd6fOtGZkZghLPmRG/hUYV7TYogii/RcY2kKVxrm+N9Ks+If/Qc5
         tSDY7iMK8IkK4TyYhJgHY6XfwQ3FKB3whlixiHNQzyETD2GpcgSE+emhP04DTWoEEKQE
         1dn3D0h8iRKZUtmc8+pgUbY4O4KC6cepGQDjzSjEdt75BW0GKad08/y5sMeFZJZOociC
         1pgKJVqOXg0vPAhu1+cLOrCQW2IVRoxqtQQfZAGFHx2rJoE/J3iWswhvhtqlQ7HDEVxQ
         h8Jg==
X-Gm-Message-State: AOPr4FXhQ/HGKVo0DOXR3qduYzQd+lKMghMBRS8yyXQDeMboUeb+nn+xEEOVT9/JxR5kTw==
X-Received: by 10.140.96.227 with SMTP id k90mr21934886qge.34.1461978159503;
        Fri, 29 Apr 2016 18:02:39 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:38 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293113>

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
index 6a61695..9ca2ca6 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -370,6 +370,8 @@ static void loop(int fd, int idle_in_seconds)
 					 * alive, nothing to do.
 					 */
 				}
+			} else if (!strcmp(buf, "die")) {
+				break;
 			} else {
 				log_warning("BUG: Bogus command %s", buf);
 			}
@@ -400,10 +402,29 @@ static const char * const usage_text[] = {
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
@@ -412,6 +433,7 @@ int main(int argc, char **argv)
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
+		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
 		OPT_END()
 	};
 
@@ -426,6 +448,13 @@ int main(int argc, char **argv)
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
