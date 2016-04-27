From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 14/19] index-helper: kill mode
Date: Wed, 27 Apr 2016 16:04:36 -0400
Message-ID: <1461787481-877-15-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:05:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avViI-0003Ha-Kl
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbcD0UFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:05:30 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:32973 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbcD0UF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:27 -0400
Received: by mail-qg0-f44.google.com with SMTP id f92so21853480qgf.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PgSsfzsg0oRhFwXGhW/QqjrFBThPcaY287XYTsKvpj4=;
        b=Fgeotiurz0NwlkSK7VyEGXfSqPGkONEXG0RVOtDvPHMxshW6E1u3hbG+dgComcal/L
         /IYcdHKenNGN3GabGLYi1ngsjCCehamCk7xrcvByR4KhhUuA5BJdAGyzJj/19BxCSdGa
         SbFGwW/81vZ3OgRO42O5EdOtV2+cT8WY7MrDDcyQjAXSD+Dy8s9nbU+fNDEd8a6bOiRz
         XS2yhDxwnB+mXAmH1KQilWWKrPzz4gOsyDw4tTlUJDk/U+W57ZTLXgK2uKV//1W/kABE
         49kYKTqEJT39V6tywYST9kZ0I3Ubf+h1bijcxnNVD70B8LS71PkHMkTt1B9fFqc8t+mH
         w1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PgSsfzsg0oRhFwXGhW/QqjrFBThPcaY287XYTsKvpj4=;
        b=BtxUXGVdnEc5m+TBpOD+aFUVmFn9Ndis1fxzqgQYb0ske/AZ7NvDfGQt9VMT8/a/TP
         WOhYd1CAXXoV8C6c/J1y4zucCY/EMEn27CfTRMhFJdUy3SOSuG2PP64Fs9RiyEWAkR+Y
         8+FFgQg6XFW4UOmBoui2a8/h8FUw/VSIsoF44M4slMqFqn0zGrYRYqlfmi4T3d1o/dCs
         nRphIQCy0CfzHY/qO+4WI21Ph0klqy9En2vABGSpeUMvZ/qH+3MmtUqtVEnQ/8YxBHkn
         Si3K7u364eG2ETGzdc3kX/BwTsxBCFOzEncYvMQ3Zg5CSfR8FCIGZKLyfaOfsdlqeCtx
         I3wQ==
X-Gm-Message-State: AOPr4FVNQREZelzUJzTN7Y7WcGBGNjDIBhYpc5oqO8XGzhU7haCqLy7/CWaCUsHonnX3KA==
X-Received: by 10.140.105.134 with SMTP id c6mr10634637qgf.31.1461787525752;
        Wed, 27 Apr 2016 13:05:25 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292793>

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
index d8b8efb..d68afd7 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -37,6 +37,9 @@ OPTIONS
 --detach::
 	Detach from the shell.
 
+--kill::
+	Kill any running index-helper and clean up the socket
+
 NOTES
 -----
 
diff --git a/index-helper.c b/index-helper.c
index a3c0221..60a71f2 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -378,6 +378,8 @@ static void loop(int fd, int idle_in_seconds)
 					 * alive, nothing to do.
 					 */
 				}
+			} else if (!strcmp(buf, "die")) {
+				break;
 			} else {
 				log_warning("BUG: Bogus command %s", buf);
 			}
@@ -408,10 +410,29 @@ static const char * const usage_text[] = {
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
@@ -420,6 +441,7 @@ int main(int argc, char **argv)
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
+		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
 		OPT_END()
 	};
 
@@ -434,6 +456,13 @@ int main(int argc, char **argv)
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
