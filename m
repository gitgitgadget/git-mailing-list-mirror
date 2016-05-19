From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 15/20] index-helper: kill mode
Date: Thu, 19 May 2016 17:45:52 -0400
Message-ID: <1463694357-6503-16-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:47:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Vn3-00072K-2z
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbcESVrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 17:47:19 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33918 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932504AbcESVqz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:55 -0400
Received: by mail-qg0-f42.google.com with SMTP id 90so51217225qgz.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IA0teDIqcgTOHFEFYhxQhBpp7J3J9GLCVkum/qxZW4M=;
        b=yu6uBsDj8nTQ7Jkw3WOxkvGMkuzvS4RPXCc+eCHV8dN/ZSOOWgTJFRmze+gVgBEn6T
         mZwQ4zHnjmAdrIBNDuNfpN+w9694kK/w6m5CWTr8UMB58zQdZlskoVWy3D5wxDtBXy53
         tHxajtG1RABe5FuC4mC5+C1rsj5BwjreMyNKrk39wCVtvBu8UzPlgnotbiuU9Mw2FJWe
         t/hvhe7L8abbhe0V/68c5NOJxCBHPN5xhyiQjHlsT7f0KizCfY9pu9HeBZ59jPsDoDD7
         2L0OfX5GxT+AO15fa+RMN22HK6Uu1sS+qQIObt3/Hyq8liHmD1zHOvhocwRJCINWMEZt
         yd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IA0teDIqcgTOHFEFYhxQhBpp7J3J9GLCVkum/qxZW4M=;
        b=kWiTu1gR53Ww5SfWCCjJLYFnf8E1rWpF7xLIlQLFAdZ+eQZ9N0/SDn5J+uoF+EniVK
         gY33/fviUGhnVsgDXi3KznBsxV821PF8JPokb8rQOSVXHV/VBOhd6Eidixtf4x//ZCTj
         zJocxUqkl6ry1VXxDzu0EtjWLYd3NS122A9y5cVL/cvG8cngsJ/bjYSX/4ymXuRJl+9N
         NeUOOj5zLqDoZ5fbFBruh/o0Cyvr8x0m5YiQnAOa1Yv/mUwz2Tm3kqhB7u/KJj8fD81H
         GAg8fu54BWf90ZEQZZA+4CwJw5irPu2/cuJ6Bk4kzugfZwN/gKWd40bPGI30EUJZcjaq
         Ahlw==
X-Gm-Message-State: AOPr4FW85pTlqoj5IGWZVpudXQFgHCx6glM+Yc8ESjviBj/E/tvi0jYucuqF07xwf2yaXA==
X-Received: by 10.140.32.198 with SMTP id h64mr195912qgh.53.1463694415046;
        Thu, 19 May 2016 14:46:55 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:54 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295122>

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
index d3a1f39..4a171e6 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -353,6 +353,8 @@ static void loop(int fd, int idle_in_seconds)
 					 * alive, nothing to do.
 					 */
 				}
+			} else if (!strcmp(buf, "die")) {
+				break;
 			} else {
 				warning("BUG: Bogus command %s", buf);
 			}
@@ -383,10 +385,29 @@ static const char * const usage_text[] = {
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
@@ -395,6 +416,7 @@ int main(int argc, char **argv)
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
+		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
 		OPT_END()
 	};
 
@@ -409,6 +431,13 @@ int main(int argc, char **argv)
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
