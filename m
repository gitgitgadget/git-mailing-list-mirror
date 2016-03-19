From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 13/17] index-helper: kill mode
Date: Fri, 18 Mar 2016 21:04:46 -0400
Message-ID: <1458349490-1704-14-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:08:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5NZ-00012F-DE
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbcCSBI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 21:08:29 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34358 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbcCSBIX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:08:23 -0400
Received: by mail-qg0-f51.google.com with SMTP id w104so114671225qge.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fL5N3Vk2koXYf8PGIpCo2X2P5/JA0tx/kp1KF7DIWfs=;
        b=0dwTNIiXjXor/6Paz3fRPKjSFGCAgG2TiS9Ow5cSK8b6VQPqIcS5/6CMkEx+fqVc/G
         LPietqkfNHQc9HgMY5kW6H8KO7pv6+e0Fa9XPAcqQiAuUDt2ae7SwWsNjW358jAsQyA2
         yJQJm1vqKFdB5EtHCo85zR/jZunnua4mnyshPgZHwUUo0Hm1dCbbHNz9CXEHPZtJMWTA
         V4LuBLE0uXfTKCkLl/hRACk7i6VJBwPhr9YhkfNyRQTjpiVSy/O7e5b6w8kApKlGWBz6
         tzo66ln8n8TMI7Iqwy+aHVoVKJ3M5H2TP7xkTuQET6Mr0VytYsd6xDMZySyeKP4jdugd
         wn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fL5N3Vk2koXYf8PGIpCo2X2P5/JA0tx/kp1KF7DIWfs=;
        b=KUPN1yoUXcPGW2oC3UNY5TDV3LQKn5eaCEd0XOryCsuxMzmjwSgz1J3cwKW5vrkAN+
         MzNhDV5jx/bpqPj+JpBtieDioFINZaVNUNDBwWqQUnqmT7C59pEfZxJNvTHM8qOa+xqS
         AGpRpChzxZaYd0R6NKhtMFBezhCTFjKfQZ5yoV+3XsOAE6Xjpu6glrwkz+5jeCLANDl/
         VLrmpYYO06Oa4bX6b53delku2vWSsDuLx17ovfxCHwv5psHYxxFT+RJWSh0tqch4WwDl
         292xeabHj23OpXqs0Z2Jb+EYbyi9T5z6lfO0Os6iUmepVi+1go8wkNapwLM8A7QXihcj
         vsoA==
X-Gm-Message-State: AD7BkJL6CMs8jyuF+vl+XZ3QBUKOE2IRa7ynAqKu49MFCF5lw4nuff7Uyl4PWZtThZ7FKQ==
X-Received: by 10.140.165.205 with SMTP id l196mr28126369qhl.58.1458349702744;
        Fri, 18 Mar 2016 18:08:22 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.08.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:08:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289279>

Add a new command (and command-line arg) to allow index-helpers to
exit cleanly.

This is mainly useful for tests.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 39 +++++++++++++++++++++++++++++++++++++--
 t/t7900-index-helper.sh |  9 +++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/index-helper.c b/index-helper.c
index 445a0ac..ffa3c2a 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -286,6 +286,8 @@ static void loop(int fd, int idle_in_seconds)
 						 * alive, nothing to do.
 						 */
 						;
+				} else if (!strcmp(command.buf, "die")) {
+					break;
 				} else {
 					warning("BUG: Bogus command %s", command.buf);
 				}
@@ -338,10 +340,35 @@ static const char * const usage_text[] = {
 	NULL
 };
 
+static void request_kill(const char *pipe_path)
+{
+	int fd;
+
+	fd = open(pipe_path, O_WRONLY | O_NONBLOCK);
+	if (fd < 0) {
+		warning("No existing pipe; can't send kill message to old process");
+		goto done;
+	}
+
+	write_in_full(fd, "die", 4);
+	close(fd);
+
+done:
+	/*
+	 * The child will try to do this anyway, but we want to be
+	 * ready to launch a new daemon immediately after this command
+	 * returns.
+	 */
+
+	unlink(pipe_path);
+	return;
+}
+
+
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds = 600, detach = 0;
+	int idle_in_seconds = 600, detach = 0, kill = 0;
 	int fd;
 	struct strbuf pipe_path = STRBUF_INIT;
 	struct option options[] = {
@@ -350,6 +377,7 @@ int main(int argc, char **argv)
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
+		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
 		OPT_END()
 	};
 
@@ -364,10 +392,17 @@ int main(int argc, char **argv)
 			  options, usage_text, 0))
 		die(_("too many arguments"));
 
+	strbuf_git_path(&pipe_path, "index-helper.pipe");
+	if (kill) {
+		if (detach)
+			die(_("--kill doesn't want any other options"));
+		request_kill(pipe_path.buf);
+		return 0;
+	}
+
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
 
-	strbuf_git_path(&pipe_path, "index-helper.pipe");
 	fd = setup_pipe(pipe_path.buf);
 	if (fd < 0)
 		die_errno("Could not set up index-helper.pipe");
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 7126037..14b5a6c 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -15,4 +15,13 @@ test_expect_success 'index-helper smoke test' '
 	test_path_is_missing .git/index-helper.pipe
 '
 
+test_expect_success 'index-helper creates usable pipe file and can be killed' '
+	test_when_finished "git index-helper --kill" &&
+	test_path_is_missing .git/index-helper.pipe &&
+	git index-helper --detach &&
+	test -p .git/index-helper.pipe &&
+	git index-helper --kill &&
+	test_path_is_missing .git/index-helper.pipe
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
