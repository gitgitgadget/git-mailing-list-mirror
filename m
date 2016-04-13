From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 12/16] index-helper: kill mode
Date: Tue, 12 Apr 2016 20:33:05 -0400
Message-ID: <1460507589-25525-13-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:33:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8ke-0002my-BI
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758951AbcDMAdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 20:33:45 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34122 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233AbcDMAdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:35 -0400
Received: by mail-qk0-f180.google.com with SMTP id r184so13616455qkc.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iQw+DLJNJ6NHMVwvNrr0diUcvTt+0A7VMannnZjqxUI=;
        b=cjH9bn8zaV5ALVGoD4q7UeSHnlroCIXAcLLn4Ca7EmBJoKaXwtMrsrp4HNRUcOv7PJ
         +Hekd45TmNaipz298b5saKTZX5omiGsBLuz7SprCj+xAerkAWQMkwq1X9yTSId0LuPPR
         qKJdbdjnjsD3/M1PhlExpMCB37E8H+laL9lM3/DLX2U7aGNvhYeRNFzrqC+7RPqJ33zY
         If8VuUcYd4nFqWw2wPxlMAUJoVA3/cNcIfzG1ES+nq3M8IYO9lLBP8Nmby/mstILR2aA
         DLIqm+Al1Uod/1YGXwXjh6AxHbJ5mBkw/xV3pBpAY+e91rGbiw+5+3cBV0E25f6xbv02
         FM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iQw+DLJNJ6NHMVwvNrr0diUcvTt+0A7VMannnZjqxUI=;
        b=kgBLG9+xB5oY2oWYqMO6EG4OvGPjV7vW4Tq3ZSGLkynBxoWAR+NdhEtfsYpc1CBDtn
         5xGHJ7msoYUgIOGhFS7R/zq5d/P4RXn6YwpB67nyZ9gc3rPmQ0VNxarVakMLiIRZ6Zk9
         rANEuN0a0+E1bgJNP4COyC5dZYWUdwuMzVUAbOK03xhAJVS5dVDFwrWRuEQYdFxhI7DH
         dWavlr2hzK2/ibSMBSv31WWVXA5ZYRyTbctFANxGOfBjwExVV57t9Yn0Mm4kaaCcaQ6r
         lwEzN5GSaRyWxhYfoDYflCYrH9vFCJ+RH7n01CdC+pI5rl4IN7hZTbr+7A1wn6Uj7xck
         AguA==
X-Gm-Message-State: AOPr4FW0h9QBpNS1XlH4vFYCDDwPWvgbpUg50zh6vkYcPtdSXckjFeRGaMPrznsVSSz1gA==
X-Received: by 10.55.11.137 with SMTP id 131mr7255407qkl.51.1460507614568;
        Tue, 12 Apr 2016 17:33:34 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291345>

Add a new command (and command-line arg) to allow index-helpers to
exit cleanly.

This is mainly useful for tests.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 31 ++++++++++++++++++++++++++++++-
 t/t7900-index-helper.sh | 12 ++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/index-helper.c b/index-helper.c
index 1d30400..3e0990e 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -395,6 +395,8 @@ static void loop(int fd, int idle_in_seconds)
 					 * alive, nothing to do.
 					 */
 				}
+			} else if (!strcmp(command.buf, "die")) {
+				break;
 			} else {
 				warning("BUG: Bogus command %s", command.buf);
 			}
@@ -425,10 +427,29 @@ static const char * const usage_text[] = {
 	NULL
 };
 
+static void request_kill(void)
+{
+	int fd = connect_to_index_helper();
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
+	unlink(git_path("index-helper.path"));
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
@@ -437,6 +458,7 @@ int main(int argc, char **argv)
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
+		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
 		OPT_END()
 	};
 
@@ -451,6 +473,13 @@ int main(int argc, char **argv)
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
index c127ed7..fdb0d7b 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -20,4 +20,16 @@ test_expect_success 'index-helper smoke test' '
 	test_path_is_missing .git/index-helper.path
 '
 
+test_expect_success 'index-helper creates usable path file and can be killed' '
+	test_when_finished "git index-helper --kill" &&
+	test_path_is_missing .git/index-helper.path &&
+	git index-helper --detach &&
+	test -L .git/index-helper.path &&
+	dir="$(readlink .git/index-helper.path)" &&
+	test -S "$dir/s" &&
+	ls -ld "$dir" | grep ^drwx...--- &&
+	git index-helper --kill &&
+	test_path_is_missing .git/index-helper.path
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
