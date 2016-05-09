From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 14/19] index-helper: kill mode
Date: Mon,  9 May 2016 16:48:44 -0400
Message-ID: <1462826929-7567-15-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:50:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7P-0003yU-GA
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbcEIUt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:49:27 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36129 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbcEIUtX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:23 -0400
Received: by mail-qk0-f176.google.com with SMTP id x7so101937761qkd.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0gyGUBG6EShx4FuR4U6rO4q5iv//2FUhAK6WrxfyK7M=;
        b=VqKGMl9Hbg0pgF3xAZBBexSjjw81p4260tm8GGv6h7rLK7acSf/HB56hbA9PKTnaq+
         KO3qLqdIvxu/eCqKBNHDdzVeJrHrUiR4g4Sjb7BxATqq6dEsYMa5rvqzKq3+TJXorvvE
         IIAktDVZJG6gXxZJFqWiyVo35/Q3lBdEynF2AvwLkS769XDPcvlAriTRUpXlQNlnwpoj
         Xf7LZCVnAWgfu67aqAoABDeqJqHGpbFCj9rSR22TN9BTec4iNbh/eT4CsnXzMzTkAjE/
         lrNW4YGoAo+7O0Jizay7FjKVUGUZK8fKyPk1FvsOvl8Bq2FS6lnUHav1mgMSByJvC1KG
         9zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0gyGUBG6EShx4FuR4U6rO4q5iv//2FUhAK6WrxfyK7M=;
        b=gI2MQXCbVfRsNS8dfk+WYVNgf4DXBeJhPaihyVdPmGzBOt60CcrvoIxoQXLvVsD+4b
         f50O+kN6DWE7zntg2N13jzYbVo42SMgWQMiEocQ+H5sRuf9i/sL1vJFQJtQ+EhnB86Db
         Zd1YfHNrHJBMplmhWoot9/87jVovW5Pp8n9Guk9cU6dHylSjVE54soi3da8OFD9NHuol
         KN4xsVX/8NaZkCGAIUE/ywu8NFx5Dde+JZuLpuOcc99sG65mGWFRcUarAgKBXgMX7Aed
         SO6615bmnzg1vKiVbqDFODI4X7qpUAcomvUsgy1zWxKtBzydXDDmad2j23Jn1YAFLIiJ
         8w5g==
X-Gm-Message-State: AOPr4FXxEnswaT42sf1GCm5XBGrCaRGaJiT+ugem6epMLqGsOHenhhd5NKBLhe/XFT2nVg==
X-Received: by 10.55.93.130 with SMTP id r124mr39414523qkb.195.1462826962498;
        Mon, 09 May 2016 13:49:22 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294053>

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
