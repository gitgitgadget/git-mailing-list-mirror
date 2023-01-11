Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34940C5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbjAKWNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjAKWNU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:13:20 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B6A3E0E1
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:19 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ja17so12030048wmb.3
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qs6h0DoO/ZYvBRFEyqt00y4wrQgWlKREO3Bh+Yt2h4o=;
        b=W8sn2kweNQwxKuXaWq1FG4y9Hb0vPSqdZ160frLjmZ9BSHqht8uTWOWf5p8pFhkP86
         cnfHWOxY+GMe9t+dc1ZZ+zC450Xz0r6K5zZx7rru8iUjZNGcaAg5weUlhOBkCjaCYICZ
         Y0lAWLNlFJJU/RG65xbpuTeEhi8iVyQrw3et3t8hIOi2Zfw0QlDipNTvX9rwSZ01N3dk
         BQ4SZXwEQtrJ7EcEFDhrCmAdDwuWghpT6/5O120UoOZzAtB5ZjHixt4iPppHTxABvaY+
         dvwT57haMgCH6yu0Sv61badA/IMa1Kui0nnbth36JBJDMLC9Bm/OysET/9m2uU55xHN2
         3xlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qs6h0DoO/ZYvBRFEyqt00y4wrQgWlKREO3Bh+Yt2h4o=;
        b=YKs8OEJkUwYJeKK+LR6TqXgicE+pJfPXE4pA4f+BQt/qSyCJrw6ZGcdoHBoTDwcref
         h/EbfXBEK+/GSUuiB2YK2zpJCIW1vj9pLobNCWJ5n95PEpVjTsnv7LPksvg+DczSSnNR
         wGuDLOXpcWsiIjInNYXExsWdvZGmwJGJnJTKOjDlz824XL+sK09mud/f/Ydu0j+aCG/O
         UGljmucAfGcJYOVREhO2S4gYpL7uil55pdouhZzCdfVHPdlJaKYwoJ8yWVafLdp0CnOn
         tee3kasO5y/JlIyRuNMbQVvaNq6NytB9QejBjo7PqMC0VkyVNTLFkBqrQp3NoEO1WZE3
         6/cg==
X-Gm-Message-State: AFqh2ko+xlNdVW+4qHrPsc5uMlQrMa5cF5PpTkOykEbIC8xIo3r7XuJ3
        Hw2NV9P3KjAzJMrSZFvidb7b4zPnybQ=
X-Google-Smtp-Source: AMrXdXuyGIQJIz8gCojVigkSYk3XlEbXWXrRW1apfW60oAliiALuzmCLqHcNJQd7iUA1QAqHKovyNA==
X-Received: by 2002:a05:600c:3844:b0:3d3:4406:8a3a with SMTP id s4-20020a05600c384400b003d344068a3amr64079731wmr.30.1673475197436;
        Wed, 11 Jan 2023 14:13:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m25-20020a05600c3b1900b003d9ed49ee2bsm15321910wms.1.2023.01.11.14.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:13:16 -0800 (PST)
Message-Id: <6f66bf146b4d6e4044b3c6c2224795918191bc3f.1673475190.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
        <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 22:13:05 +0000
Subject: [PATCH v5 05/10] test-http-server: add HTTP error response function
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
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Introduce a function to the test-http-server test helper to write more
full and valid HTTP error responses, including all the standard response
headers like `Server` and `Date`.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-http-server.c | 303 +++++++++++++++++++++++++++++++++++-
 t/t5556-http-auth.sh        | 106 +++++++++++++
 2 files changed, 404 insertions(+), 5 deletions(-)
 create mode 100755 t/t5556-http-auth.sh

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 11071b1dd89..67bc16354a1 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -83,9 +83,297 @@ enum worker_result {
 	WR_HANGUP   = 1<<1,
 };
 
+/*
+ * Fields from a parsed HTTP request.
+ */
+struct req {
+	struct strbuf start_line;
+
+	const char *method;
+	const char *http_version;
+
+	struct strbuf uri_path;
+	struct strbuf query_args;
+
+	struct string_list header_list;
+	const char *content_type;
+	ssize_t content_length;
+};
+
+#define REQ__INIT { \
+	.start_line = STRBUF_INIT, \
+	.uri_path = STRBUF_INIT, \
+	.query_args = STRBUF_INIT, \
+	.header_list = STRING_LIST_INIT_NODUP, \
+	.content_type = NULL, \
+	.content_length = -1 \
+	}
+
+static void req__release(struct req *req)
+{
+	strbuf_release(&req->start_line);
+
+	strbuf_release(&req->uri_path);
+	strbuf_release(&req->query_args);
+
+	string_list_clear(&req->header_list, 0);
+}
+
+static enum worker_result send_http_error(
+	int fd,
+	int http_code, const char *http_code_name,
+	int retry_after_seconds, struct string_list *response_headers,
+	enum worker_result wr_in)
+{
+	struct strbuf response_header = STRBUF_INIT;
+	struct strbuf response_content = STRBUF_INIT;
+	struct string_list_item *h;
+	enum worker_result wr;
+
+	strbuf_addf(&response_content, "Error: %d %s\r\n",
+		    http_code, http_code_name);
+	if (retry_after_seconds > 0)
+		strbuf_addf(&response_content, "Retry-After: %d\r\n",
+			    retry_after_seconds);
+
+	strbuf_addf  (&response_header, "HTTP/1.1 %d %s\r\n", http_code, http_code_name);
+	strbuf_addstr(&response_header, "Cache-Control: private\r\n");
+	strbuf_addstr(&response_header,	"Content-Type: text/plain\r\n");
+	strbuf_addf  (&response_header,	"Content-Length: %d\r\n", (int)response_content.len);
+	if (retry_after_seconds > 0)
+		strbuf_addf(&response_header, "Retry-After: %d\r\n", retry_after_seconds);
+	strbuf_addf(  &response_header,	"Server: test-http-server/%s\r\n", git_version_string);
+	strbuf_addf(  &response_header, "Date: %s\r\n", show_date(time(NULL), 0, DATE_MODE(RFC2822)));
+	if (response_headers)
+		for_each_string_list_item(h, response_headers)
+			strbuf_addf(&response_header, "%s\r\n", h->string);
+	strbuf_addstr(&response_header, "\r\n");
+
+	if (write_in_full(fd, response_header.buf, response_header.len) < 0) {
+		logerror("unable to write response header");
+		wr = WR_IO_ERROR;
+		goto done;
+	}
+
+	if (write_in_full(fd, response_content.buf, response_content.len) < 0) {
+		logerror("unable to write response content body");
+		wr = WR_IO_ERROR;
+		goto done;
+	}
+
+	wr = wr_in;
+
+done:
+	strbuf_release(&response_header);
+	strbuf_release(&response_content);
+
+	return wr;
+}
+
+/*
+ * Read the HTTP request up to the start of the optional message-body.
+ * We do this byte-by-byte because we have keep-alive turned on and
+ * cannot rely on an EOF.
+ *
+ * https://tools.ietf.org/html/rfc7230
+ *
+ * We cannot call die() here because our caller needs to properly
+ * respond to the client and/or close the socket before this
+ * child exits so that the client doesn't get a connection reset
+ * by peer error.
+ */
+static enum worker_result req__read(struct req *req, int fd)
+{
+	struct strbuf h = STRBUF_INIT;
+	struct string_list start_line_fields = STRING_LIST_INIT_DUP;
+	int nr_start_line_fields;
+	const char *uri_target;
+	const char *query;
+	char *hp;
+	const char *hv;
+
+	enum worker_result result = WR_OK;
+
+	/*
+	 * Read line 0 of the request and split it into component parts:
+	 *
+	 *    <method> SP <uri-target> SP <HTTP-version> CRLF
+	 *
+	 */
+	if (strbuf_getwholeline_fd(&req->start_line, fd, '\n') == EOF) {
+		result = WR_OK | WR_HANGUP;
+		goto done;
+	}
+
+	strbuf_trim_trailing_newline(&req->start_line);
+
+	nr_start_line_fields = string_list_split(&start_line_fields,
+						 req->start_line.buf,
+						 ' ', -1);
+	if (nr_start_line_fields != 3) {
+		logerror("could not parse request start-line '%s'",
+			 req->start_line.buf);
+		result = WR_IO_ERROR;
+		goto done;
+	}
+
+	req->method = xstrdup(start_line_fields.items[0].string);
+	req->http_version = xstrdup(start_line_fields.items[2].string);
+
+	uri_target = start_line_fields.items[1].string;
+
+	if (strcmp(req->http_version, "HTTP/1.1")) {
+		logerror("unsupported version '%s' (expecting HTTP/1.1)",
+			 req->http_version);
+		result = WR_IO_ERROR;
+		goto done;
+	}
+
+	query = strchr(uri_target, '?');
+
+	if (query) {
+		strbuf_add(&req->uri_path, uri_target, (query - uri_target));
+		strbuf_trim_trailing_dir_sep(&req->uri_path);
+		strbuf_addstr(&req->query_args, query + 1);
+	} else {
+		strbuf_addstr(&req->uri_path, uri_target);
+		strbuf_trim_trailing_dir_sep(&req->uri_path);
+	}
+
+	/*
+	 * Read the set of HTTP headers into a string-list.
+	 */
+	while (1) {
+		if (strbuf_getwholeline_fd(&h, fd, '\n') == EOF)
+			goto done;
+		strbuf_trim_trailing_newline(&h);
+
+		if (!h.len)
+			goto done; /* a blank line ends the header */
+
+		hp = strbuf_detach(&h, NULL);
+		string_list_append(&req->header_list, hp);
+
+		/* also store common request headers as struct req members */
+		if (skip_prefix(hp, "Content-Type: ", &hv)) {
+			req->content_type = hv;
+		} else if (skip_prefix(hp, "Content-Length: ", &hv)) {
+			req->content_length = strtol(hv, &hp, 10);
+		}
+	}
+
+	/*
+	 * We do not attempt to read the <message-body>, if it exists.
+	 * We let our caller read/chunk it in as appropriate.
+	 */
+
+done:
+	string_list_clear(&start_line_fields, 0);
+
+	/*
+	 * This is useful for debugging the request, but very noisy.
+	 */
+	if (trace2_is_enabled()) {
+		struct string_list_item *item;
+		trace2_printf("%s: %s", TR2_CAT, req->start_line.buf);
+		trace2_printf("%s: hver: %s", TR2_CAT, req->http_version);
+		trace2_printf("%s: hmth: %s", TR2_CAT, req->method);
+		trace2_printf("%s: path: %s", TR2_CAT, req->uri_path.buf);
+		trace2_printf("%s: qury: %s", TR2_CAT, req->query_args.buf);
+		if (req->content_length >= 0)
+			trace2_printf("%s: clen: %d", TR2_CAT, req->content_length);
+		if (req->content_type)
+			trace2_printf("%s: ctyp: %s", TR2_CAT, req->content_type);
+		for_each_string_list_item(item, &req->header_list)
+			trace2_printf("%s: hdrs: %s", TR2_CAT, item->string);
+	}
+
+	return result;
+}
+
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
+	 *
+	 * The important auth responses (401) we are handling prior to getting
+	 * to this point.
+	 */
+	if (write(STDOUT_FILENO, ok, strlen(ok)) < 0)
+		return error(_("could not send '%s'"), ok);
+
+	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
+	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
+			req->uri_path.buf);
+	strvec_push(&cp.env, "SERVER_PROTOCOL=HTTP/1.1");
+	if (req->query_args.len)
+		strvec_pushf(&cp.env, "QUERY_STRING=%s",
+				req->query_args.buf);
+	if (req->content_type)
+		strvec_pushf(&cp.env, "CONTENT_TYPE=%s",
+				req->content_type);
+	if (req->content_length >= 0)
+		strvec_pushf(&cp.env, "CONTENT_LENGTH=%" PRIdMAX,
+				(intmax_t)req->content_length);
+	cp.git_cmd = 1;
+	strvec_push(&cp.args, "http-backend");
+	res = run_command(&cp);
+	close(STDOUT_FILENO);
+	close(STDIN_FILENO);
+	return !!res;
+}
+
+static enum worker_result dispatch(struct req *req)
+{
+	if (is_git_request(req))
+		return do__git(req);
+
+	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
+			       WR_OK | WR_HANGUP);
+}
+
 static enum worker_result worker(void)
 {
-	const char *response = "HTTP/1.1 501 Not Implemented\r\n";
+	struct req req = REQ__INIT;
 	char *client_addr = getenv("REMOTE_ADDR");
 	char *client_port = getenv("REMOTE_PORT");
 	enum worker_result wr = WR_OK;
@@ -96,11 +384,16 @@ static enum worker_result worker(void)
 	set_keep_alive(0, logerror);
 
 	while (1) {
-		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
-			logerror("unable to write response");
-			wr = WR_IO_ERROR;
-		}
+		req__release(&req);
+
+		alarm(timeout);
+		wr = req__read(&req, 0);
+		alarm(0);
+
+		if (wr != WR_OK)
+			break;
 
+		wr = dispatch(&req);
 		if (wr != WR_OK)
 			break;
 	}
diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
new file mode 100755
index 00000000000..65105a5a6a9
--- /dev/null
+++ b/t/t5556-http-auth.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+
+test_description='test http auth header and credential helper interop'
+
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+
+test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
+
+# Setup a repository
+#
+REPO_DIR="$TRASH_DIRECTORY"/repo
+
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
+SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
+
+PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
+
+test_expect_success 'setup repos' '
+	test_create_repo "$REPO_DIR" &&
+	git -C "$REPO_DIR" branch -M main
+'
+
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
+per_test_cleanup () {
+	stop_http_server &&
+	rm -f OUT.*
+}
+
+test_expect_success 'http auth anonymous no challenge' '
+	test_when_finished "per_test_cleanup" &&
+	start_http_server &&
+
+	# Attempt to read from a protected repository
+	git ls-remote $ORIGIN_URL
+'
+
+test_done
-- 
gitgitgadget

