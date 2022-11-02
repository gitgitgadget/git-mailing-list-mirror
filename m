Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F1C43217
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiKBWKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiKBWJr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:09:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC75162E5
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:09:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t1so26840wmi.4
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+u+0cAjz1+TrMNJ0vQOg929e3nZQu9IrtC17YCqzI0=;
        b=LvuY6CJOkC+PH3kztFVXDVR3jyaRLhEP11xMl1LxSneWIxoRVpwIsMeo5BC0hHx5bp
         wSiFWPbA9RKK5Km/rSi4tkUU9cm5ilxPvUc61IMaYHY3pw609qzjVn+H9OZ2xtr6NlS/
         APu2YX+Ucs2hZjOv3nld87dsaNKM6WLew5Xli4XptcgyPdoTn2bOfNiyLGQjmfxT9q8t
         BYo36xdZJmf0w25usw38ib98IKh5h/wj91sk4El74Jful58lE2N77x7o7iGsS2EHphpM
         YWMPgeyK0hIMlyvGN+uUdc2Q6NJL0PSdoeZux1UxGpQj9bVxhJ0AZw8ceLHtqdGNJsOC
         wEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+u+0cAjz1+TrMNJ0vQOg929e3nZQu9IrtC17YCqzI0=;
        b=cxTVsaU1VZtKWZ8GSIxRyEfFvvyMjClZcn3aZwpL+hsdLNwji7ZixtVgz3Q4z2egu7
         ZOwag7nUqClz8qdG1wsp+s3bfMVdYOkhqBGIPLF934rD6uyCBO8baJG6KYkc0u6Gyl0p
         paoPLCjpgFx0I0N/ICX/MzARpFJjcYZRv8C5yqd8aqtsqW9LIoFJx88mGod9lC4Vod24
         eIKxLNEaBvU/1ZhZD6ErnJ/vGdHCrVQqWqP0qignQt2YY/7dfpKUiLWaOOHWU/nnO683
         gqR3TTPdix04hmhhnAXqgglUwrH0E5U+swHUIofRJYd1sP9gP2EVBqj++UfD3bAH5KQB
         C5fA==
X-Gm-Message-State: ACrzQf12jvZHZx6QM6ZxHjX9r+HoczohCFNTKdtGse5/gOFiMbIHc3LH
        fJanYJ98f0jHRumoNQGZdJe1WV9ZgV0=
X-Google-Smtp-Source: AMsMyM4fD//nScuA2zfBOymArF1egI/STwZeNVgVligFN9Cv2Rlx/1X3l6J4KY4B59e+0pQobSIQ0Q==
X-Received: by 2002:a05:600c:1c04:b0:3cf:5fd2:1f74 with SMTP id j4-20020a05600c1c0400b003cf5fd21f74mr19788245wms.45.1667426983846;
        Wed, 02 Nov 2022 15:09:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d480f000000b002366eb01e07sm13734936wrq.114.2022.11.02.15.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:09:43 -0700 (PDT)
Message-Id: <192f09b9de4d1b93348a4d0cd3b35fd0ea9ba60d.1667426970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
        <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Nov 2022 22:09:28 +0000
Subject: [PATCH v3 10/11] test-http-server: add simple authentication
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

