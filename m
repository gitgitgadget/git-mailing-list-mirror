Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B523C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiLLVhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiLLVgf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:36:35 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9615B7D8
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:34 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q7so13640357wrr.8
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+u+0cAjz1+TrMNJ0vQOg929e3nZQu9IrtC17YCqzI0=;
        b=it4WNTznGVVO2GSvB9ifeJik6A5jqCxF3NYGtH0jZ/1bXGepkp5r8iE8SQRiBGxAeq
         TwuDSK6EdhJapw4kULXPpToGo6+eXevD7bES6H7gJjLd7W1evx2/OwuHI68+y15A/jeH
         8awIgaAimMFimcXa1votJz21MOYgDv1Sq0gipRK1VSDJGeaV2gBM/RhqBixmsqz7uMpP
         /cHvFg1WeB+4HRi+EDFPqCOMW9LIAN/lRV4+cdvamVAxvyaWVQl4GdtiSbJixZptv2f5
         ngqx1Gys2Ptu6Mk2EOg6ONhd91mXQ4Y8f5AkOqH0Me7cRbAsWRxjvUchv+xDuAIwjEJG
         heNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+u+0cAjz1+TrMNJ0vQOg929e3nZQu9IrtC17YCqzI0=;
        b=NxrRFPWD8voRS2bG6KXEfTNc22+IrBHJiSVJtIebsloGSxjssC/BxSMswAlX8mmiCL
         m6hPmSoMGsvxBMtqPdwBbDA43ycUNtyRGxIN2MgHRLx4/1MYWawcgJ4d8F/PxbMex3iy
         RiYk7KWnm50ULCNzdGTyGYnn8qtvfQNs++qQulwhD2p6YBlKBKSDYhbMp8yo6NQhTBq0
         14M2cGtUiBCRe6ymc/ajxXyp2442XLFFFXROnrs80R1djFkh/ug0Jvi1pwYNbBB0aG+M
         MpBh0d740FI9CE2Ipg7U3J4d5YMtrka+HQ2FM4d7JiySjPpfDX2l1Hr7QgFEWlJ0tUUg
         q55g==
X-Gm-Message-State: ANoB5pmFVmlnyaeB9se9rQZ3tAIX+oIZ8jmuMroxC3qxWFMlDEqVVxZ5
        /02RVNUVqC/44A8PzJMzIMMv9dydIJc=
X-Google-Smtp-Source: AA0mqf7Faj4vERfMn6zc2rkGufL7aTYnUXwJq4P4TLm/XH6Mjl+xXx07XG9wHP3dvTgEZh2Q1cjICA==
X-Received: by 2002:adf:ffc1:0:b0:232:be5d:5eb7 with SMTP id x1-20020adfffc1000000b00232be5d5eb7mr11671203wrs.14.1670880993113;
        Mon, 12 Dec 2022 13:36:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20-20020adfaa94000000b002367ad808a9sm9869112wrc.30.2022.12.12.13.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:36:32 -0800 (PST)
Message-Id: <794256754c1f7d32e438dfb19a05444d423989aa.1670880984.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
        <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:36:22 +0000
Subject: [PATCH v4 7/8] test-http-server: add simple authentication
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
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add simple authentication to the test-http-server test helper.
Authentication schemes and sets of valid tokens can be specified via
command-line arguments. Incoming requests are compared against the set
of valid schemes and tokens and only approved if a matching token is
found, or if no auth was provided and anonymous auth is enabled.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-http-server.c | 188 +++++++++++++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 9f1d6b58067..9a458743d13 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -18,6 +18,8 @@ static const char test_http_auth_usage[] =
 "           [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]\n"
 "           [--reuseaddr] [--pid-file=<file>]\n"
 "           [--listen=<host_or_ipaddr>]* [--port=<n>]\n"
+"           [--anonymous-allowed]\n"
+"           [--auth=<scheme>[:<params>] [--auth-token=<scheme>:<token>]]*\n"
 ;
 
 /* Timeout, and initial timeout */
@@ -358,10 +360,136 @@ static enum worker_result do__git(struct req *req, const char *user)
 	return !!res;
 }
 
+enum auth_result {
+	/* No auth module matches the request. */
+	AUTH_UNKNOWN = 0,
+
+	/* Auth module denied the request. */
+	AUTH_DENY = 1,
+
+	/* Auth module successfully validated the request. */
+	AUTH_ALLOW = 2,
+};
+
+struct auth_module {
+	char *scheme;
+	char *challenge_params;
+	struct string_list *tokens;
+};
+
+static int allow_anonymous;
+static struct auth_module **auth_modules = NULL;
+static size_t auth_modules_nr = 0;
+static size_t auth_modules_alloc = 0;
+
+static struct auth_module *get_auth_module(const char *scheme)
+{
+	int i;
+	struct auth_module *mod;
+	for (i = 0; i < auth_modules_nr; i++) {
+		mod = auth_modules[i];
+		if (!strcasecmp(mod->scheme, scheme))
+			return mod;
+	}
+
+	return NULL;
+}
+
+static void add_auth_module(struct auth_module *mod)
+{
+	ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
+	auth_modules[auth_modules_nr++] = mod;
+}
+
+static int is_authed(struct req *req, const char **user, enum worker_result *wr)
+{
+	enum auth_result result = AUTH_UNKNOWN;
+	struct string_list hdrs = STRING_LIST_INIT_NODUP;
+	struct auth_module *mod;
+
+	struct string_list_item *hdr;
+	struct string_list_item *token;
+	const char *v;
+	struct strbuf **split = NULL;
+	int i;
+	char *challenge;
+
+	/*
+	 * Check all auth modules and try to validate the request.
+	 * The first module that matches a valid token approves the request.
+	 * If no module is found, or if there is no valid token, then 401 error.
+	 * Otherwise, only permit the request if anonymous auth is enabled.
+	 */
+	for_each_string_list_item(hdr, &req->header_list) {
+		if (skip_iprefix(hdr->string, "Authorization: ", &v)) {
+			split = strbuf_split_str(v, ' ', 2);
+			if (!split[0] || !split[1]) continue;
+
+			/* trim trailing space ' ' */
+			strbuf_setlen(split[0], split[0]->len - 1);
+
+			mod = get_auth_module(split[0]->buf);
+			if (mod) {
+				result = AUTH_DENY;
+
+				for_each_string_list_item(token, mod->tokens) {
+					if (!strcmp(split[1]->buf, token->string)) {
+						result = AUTH_ALLOW;
+						break;
+					}
+				}
+
+				goto done;
+			}
+		}
+	}
+
+done:
+	switch (result) {
+	case AUTH_ALLOW:
+		trace2_printf("%s: auth '%s' ALLOW", TR2_CAT, mod->scheme);
+		*user = "VALID_TEST_USER";
+		*wr = WR_OK;
+		break;
+
+	case AUTH_DENY:
+		trace2_printf("%s: auth '%s' DENY", TR2_CAT, mod->scheme);
+		/* fall-through */
+
+	case AUTH_UNKNOWN:
+		if (result != AUTH_DENY && allow_anonymous)
+			break;
+		for (i = 0; i < auth_modules_nr; i++) {
+			mod = auth_modules[i];
+			if (mod->challenge_params)
+				challenge = xstrfmt("WWW-Authenticate: %s %s",
+						    mod->scheme,
+						    mod->challenge_params);
+			else
+				challenge = xstrfmt("WWW-Authenticate: %s",
+						    mod->scheme);
+			string_list_append(&hdrs, challenge);
+		}
+		*wr = send_http_error(1, 401, "Unauthorized", -1, &hdrs, *wr);
+	}
+
+	strbuf_list_free(split);
+	string_list_clear(&hdrs, 0);
+
+	return result == AUTH_ALLOW ||
+	      (result == AUTH_UNKNOWN && allow_anonymous);
+}
+
 static enum worker_result dispatch(struct req *req)
 {
+	enum worker_result wr = WR_OK;
+	const char *user = NULL;
+
+	if (!is_authed(req, &user, &wr))
+		return wr;
+
 	if (is_git_request(req))
-		return do__git(req, NULL);
+		return do__git(req, user);
 
 	return send_http_error(1, 501, "Not Implemented", -1, NULL,
 			       WR_OK | WR_HANGUP);
@@ -854,6 +982,7 @@ int cmd_main(int argc, const char **argv)
 	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
 	int worker_mode = 0;
 	int i;
+	struct auth_module *mod = NULL;
 
 	trace2_cmd_name("test-http-server");
 	setup_git_directory_gently(NULL);
@@ -906,6 +1035,63 @@ int cmd_main(int argc, const char **argv)
 			pid_file = v;
 			continue;
 		}
+		if (skip_prefix(arg, "--allow-anonymous", &v)) {
+			allow_anonymous = 1;
+			continue;
+		}
+		if (skip_prefix(arg, "--auth=", &v)) {
+			struct strbuf **p = strbuf_split_str(v, ':', 2);
+
+			if (!p[0]) {
+				error("invalid argument '%s'", v);
+				usage(test_http_auth_usage);
+			}
+
+			/* trim trailing ':' */
+			if (p[1])
+				strbuf_setlen(p[0], p[0]->len - 1);
+
+			if (get_auth_module(p[0]->buf)) {
+				error("duplicate auth scheme '%s'\n", p[0]->buf);
+				usage(test_http_auth_usage);
+			}
+
+			mod = xmalloc(sizeof(struct auth_module));
+			mod->scheme = xstrdup(p[0]->buf);
+			mod->challenge_params = p[1] ? xstrdup(p[1]->buf) : NULL;
+			CALLOC_ARRAY(mod->tokens, 1);
+			string_list_init_dup(mod->tokens);
+
+			add_auth_module(mod);
+
+			strbuf_list_free(p);
+			continue;
+		}
+		if (skip_prefix(arg, "--auth-token=", &v)) {
+			struct strbuf **p = strbuf_split_str(v, ':', 2);
+			if (!p[0]) {
+				error("invalid argument '%s'", v);
+				usage(test_http_auth_usage);
+			}
+
+			if (!p[1]) {
+				error("missing token value '%s'\n", v);
+				usage(test_http_auth_usage);
+			}
+
+			/* trim trailing ':' */
+			strbuf_setlen(p[0], p[0]->len - 1);
+
+			mod = get_auth_module(p[0]->buf);
+			if (!mod) {
+				error("auth scheme not defined '%s'\n", p[0]->buf);
+				usage(test_http_auth_usage);
+			}
+
+			string_list_append(mod->tokens, p[1]->buf);
+			strbuf_list_free(p);
+			continue;
+		}
 
 		fprintf(stderr, "error: unknown argument '%s'\n", arg);
 		usage(test_http_auth_usage);
-- 
gitgitgadget

