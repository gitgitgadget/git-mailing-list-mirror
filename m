From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 15/20] index-helper: kill mode
Date: Thu, 12 May 2016 16:20:10 -0400
Message-ID: <1463084415-19826-16-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:21:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6k-0005OJ-6V
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbcELUVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:21:11 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35527 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbcELUUs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:48 -0400
Received: by mail-io0-f181.google.com with SMTP id d62so109289255iof.2
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xFEkVIKv8OBdw1+2UZ27VzThwOZDaFj74jsjvrtZdjc=;
        b=CFkHLjtWk9U+qnOFg+AnGiU97vD+CJcdkgmsthkWBbDILmWIxGzt4Iu8xfWOf8RomV
         k9X82Zpt1LLTl96hrwuNB87fghjg/ctrzIjIkPApblpxUEW3ozzgc3GueCIDAfOemhJv
         GqyZhUdfTOgHTPZ1jZtc7WCgX7ON7ZO/8c3RE+CHnlYxNU/a/QZdqdg3a9qquzqbS0mD
         0iooIE3CLLjtJOfZQAA0ukfLqu1ucEhjUU9aYCjP/QUxigx2KhC/YzQ3I5TqpSFyIMAO
         pl+XHnb7Sh8YDWKM8gF2sucH2Zu1SlY7RzQZDCcd6ETGuVzKjeODXphSHo4OGWnZ2CLg
         reFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xFEkVIKv8OBdw1+2UZ27VzThwOZDaFj74jsjvrtZdjc=;
        b=FD3Wv8zEC3VlfzScTQqNWlgWeERgMzq1+Kukx4fJ6ZhDNezZMcm9nJEfUWNF7jpZ9E
         5adyl2Xaxi1vRSW0AFAqnVLmRJinBNUs6dibYRg9apakYYD/Fa/21O9yz7R+Yx3SNlfz
         HqV8UOUAev6gyMMVT+AR/TDQ/ByDT+e3eqbOjvYF7u/DTI9O7L+ns7CqUZVBD/U8FoqE
         096LNhxbMCqoZMZBMK9I+//fWwFQriFPhoQxIqF86n+B+PgUmykC/h09/rb6g6/VSDvO
         7J8UoVu29/P6THbNxTZ351pW2TzclDaW2ga2sNQRxiYfBuFmAG4kBOMKn0/TkAPCWVIb
         IG8A==
X-Gm-Message-State: AOPr4FW7vWL/1RvH0VHxoqAUOJY4iN+vXB8iOwlv3YzGnrhRhQtA1kD37zNAFOUSMrUEYw==
X-Received: by 10.107.5.141 with SMTP id 135mr9763253iof.91.1463084447840;
        Thu, 12 May 2016 13:20:47 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294464>

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
index 6026c74..a1b33e4 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -350,6 +350,8 @@ static void loop(int fd, int idle_in_seconds)
 					 * alive, nothing to do.
 					 */
 				}
+			} else if (!strcmp(buf, "die")) {
+				break;
 			} else {
 				warning("BUG: Bogus command %s", buf);
 			}
@@ -380,10 +382,29 @@ static const char * const usage_text[] = {
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
@@ -392,6 +413,7 @@ int main(int argc, char **argv)
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
+		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
 		OPT_END()
 	};
 
@@ -406,6 +428,13 @@ int main(int argc, char **argv)
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
