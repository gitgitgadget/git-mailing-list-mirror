Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB000C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjATWJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjATWJB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:09:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE2AA5CD3
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:09:00 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r9so6012658wrw.4
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vt6qt5xy2LTOWOA/ba75VrNCLenL8Di1Ghv67LM82hE=;
        b=eVZhcTQYCm6Xvc8wIm0POK+m3SuItk1x2qHBk+VRyvEl3AFpNT6dY1q0t1B12IR1S4
         AHZESoiSx4OdipOg20klPd84CYzh2fjoyrPckAU+kOgyT1i1fCjDEnN+w2iwEtbPUFPl
         d76OH8p697XKm6DW48rLKnJteb2usWZyyp0vwf/8ISYkz/JjSqSx0ZuGRw/hYjmaUEhV
         Ym0q/oj5nGf8i1jKJrPAELV3EZDM53PcxRBKWOqPGtu8RqhM3NmxAeZ6XY5ha8eKZIaL
         MmttbdAzYVIfrSeO7vTpZXcg8IPn54vn0M3RO8HJiOgbmS7e0rOFHnS1DoZUTkP3xdoB
         rFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vt6qt5xy2LTOWOA/ba75VrNCLenL8Di1Ghv67LM82hE=;
        b=SgToTNYVwMG9nAZqohvZUID1xQlFzezsEVA2NRp+2svvZuxefR1kL65crK+vSUbJgh
         atC+cHt0q/lWMMutyzmjXmM3UNE3/rQPC6SQ166zpqY7j+k94Ds70Fy23yh9qgp9QdZE
         MGUJnLUHRSHhEyZ5NUwZaJiNk4uwsv+ygHJu16MBsSS5s5L8GBYSRRkYeA1q2MO38Apb
         T//H8FHQrFf6bgik4eJdLUDIos7aNjnTenqfS1qN+XYrj7lm/cz8IC/x+6pDXieET1aJ
         91VDEwO7vFs/NAljsv5shTWUQcwg9RgoFzF+4uiIb/ZU17wDjSUB8yEbR1ulVT5tgeQb
         dwLw==
X-Gm-Message-State: AFqh2kq0yB9DHBuk8Wvaf9P5A7Dn9KxEeeU3w6un5uIMkkhTGDY+KRaP
        wKVCyJzgF2RSpcXb6bspIQdj278PgBc=
X-Google-Smtp-Source: AMrXdXtqRI0rxknm7NcPlPcwN6z59xqDITZ4UyLGy+cBY5d1vtdb9TZw232tgz8K5EsvKZ1juXXhUw==
X-Received: by 2002:a5d:65cc:0:b0:2be:493f:3b2d with SMTP id e12-20020a5d65cc000000b002be493f3b2dmr5611529wrw.10.1674252538469;
        Fri, 20 Jan 2023 14:08:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4588000000b002bdfb97e029sm14810164wrq.19.2023.01.20.14.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:08:58 -0800 (PST)
Message-Id: <ca9c2787248688cd7d8e20043a6ed75d93654e35.1674252531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 22:08:45 +0000
Subject: [PATCH v7 07/12] test-http-server: pass Git requests to http-backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Teach the test-http-sever test helper to forward Git requests to the
`git-http-backend`.

Introduce a new test script t5556-http-auth.sh that spins up the test
HTTP server and attempts an `ls-remote` on the served repository,
without any authentication.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-http-server.c | 68 ++++++++++++++++++++++++++++++
 t/t5556-http-auth.sh        | 83 +++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 900f5733cc1..4191daf3c64 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -323,8 +323,76 @@ done:
 	return result;
 }
 
+static int is_git_request(struct req *req)
+{
+	static regex_t *smart_http_regex;
+	static int initialized;
+
+	if (!initialized) {
+		smart_http_regex = xmalloc(sizeof(*smart_http_regex));
+		/*
+		 * This regular expression matches all dumb and smart HTTP
+		 * requests that are currently in use, and defined in
+		 * Documentation/gitprotocol-http.txt.
+		 *
+		 */
+		if (regcomp(smart_http_regex, "^/(HEAD|info/refs|"
+			    "objects/info/[^/]+|git-(upload|receive)-pack)$",
+			    REG_EXTENDED)) {
+			warning("could not compile smart HTTP regex");
+			smart_http_regex = NULL;
+		}
+		initialized = 1;
+	}
+
+	return smart_http_regex &&
+		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
+}
+
+static enum worker_result do__git(struct req *req)
+{
+	const char *ok = "HTTP/1.1 200 OK\r\n";
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int res;
+
+	/*
+	 * Note that we always respond with a 200 OK response even if the
+	 * http-backend process exits with an error. This helper is intended
+	 * only to be used to exercise the HTTP auth handling in the Git client,
+	 * and specifically around authentication (not handled by http-backend).
+	 *
+	 * If we wanted to respond with a more 'valid' HTTP response status then
+	 * we'd need to buffer the output of http-backend, wait for and grok the
+	 * exit status of the process, then write the HTTP status line followed
+	 * by the http-backend output. This is outside of the scope of this test
+	 * helper's use at time of writing.
+	 */
+	if (write(STDOUT_FILENO, ok, strlen(ok)) < 0)
+		return error(_("could not send '%s'"), ok);
+
+	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
+	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s", req->uri_path.buf);
+	strvec_push(&cp.env, "SERVER_PROTOCOL=HTTP/1.1");
+	if (req->query_args.len)
+		strvec_pushf(&cp.env, "QUERY_STRING=%s", req->query_args.buf);
+	if (req->content_type)
+		strvec_pushf(&cp.env, "CONTENT_TYPE=%s", req->content_type);
+	if (req->has_content_length)
+		strvec_pushf(&cp.env, "CONTENT_LENGTH=%" PRIuMAX,
+			(uintmax_t)req->content_length);
+	cp.git_cmd = 1;
+	strvec_push(&cp.args, "http-backend");
+	res = run_command(&cp);
+	close(STDOUT_FILENO);
+	close(STDIN_FILENO);
+	return !!res;
+}
+
 static enum worker_result dispatch(struct req *req)
 {
+	if (is_git_request(req))
+		return do__git(req);
+
 	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
 			       WR_HANGUP);
 }
diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
index 06efc85ca53..c0a47ce342b 100755
--- a/t/t5556-http-auth.sh
+++ b/t/t5556-http-auth.sh
@@ -5,10 +5,25 @@ test_description='test http auth header and credential helper interop'
 TEST_NO_CREATE_REPO=1
 . ./test-lib.sh
 
+test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
+
 # Setup a repository
 #
 REPO_DIR="$TRASH_DIRECTORY"/repo
 
+# Setup some lookback URLs where test-http-server will be listening.
+# We will spawn it directly inside the repo directory, so we avoid
+# any need to configure directory mappings etc - we only serve this
+# repository from the root '/' of the server.
+#
+HOST_PORT=127.0.0.1:$GIT_TEST_HTTP_PROTOCOL_PORT
+ORIGIN_URL=http://$HOST_PORT/
+
+# The pid-file is created by test-http-server when it starts.
+# The server will shutdown if/when we delete it (this is easier than
+# killing it by PID).
+#
+PID_FILE="$TRASH_DIRECTORY"/pid-file.pid
 SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
 
 PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
@@ -25,7 +40,65 @@ run_http_server_worker() {
 	)
 }
 
+stop_http_server () {
+	if ! test -f "$PID_FILE"
+	then
+		return 0
+	fi
+	#
+	# The server will shutdown automatically when we delete the pid-file.
+	#
+	rm -f "$PID_FILE"
+	#
+	# Give it a few seconds to shutdown (mainly to completely release the
+	# port before the next test start another instance and it attempts to
+	# bind to it).
+	#
+	for k in 0 1 2 3 4
+	do
+		if grep -q "Starting graceful shutdown" "$SERVER_LOG"
+		then
+			return 0
+		fi
+		sleep 1
+	done
+
+	echo "stop_http_server: timeout waiting for server shutdown"
+	return 1
+}
+
+start_http_server () {
+	#
+	# Launch our server into the background in repo_dir.
+	#
+	(
+		cd "$REPO_DIR"
+		test-http-server --verbose \
+			--listen=127.0.0.1 \
+			--port=$GIT_TEST_HTTP_PROTOCOL_PORT \
+			--reuseaddr \
+			--pid-file="$PID_FILE" \
+			"$@" \
+			2>"$SERVER_LOG" &
+	)
+	#
+	# Give it a few seconds to get started.
+	#
+	for k in 0 1 2 3 4
+	do
+		if test -f "$PID_FILE"
+		then
+			return 0
+		fi
+		sleep 1
+	done
+
+	echo "start_http_server: timeout waiting for server startup"
+	return 1
+}
+
 per_test_cleanup () {
+	stop_http_server &&
 	rm -f OUT.* &&
 	rm -f IN.* &&
 }
@@ -87,4 +160,14 @@ test_expect_success 'http auth server request parsing' '
 	test_cmp OUT.http400 OUT.actual
 '
 
+
+test_expect_success 'http auth anonymous no challenge' '
+	test_when_finished "per_test_cleanup" &&
+
+	start_http_server &&
+
+	# Attempt to read from a protected repository
+	git ls-remote $ORIGIN_URL
+'
+
 test_done
-- 
gitgitgadget

