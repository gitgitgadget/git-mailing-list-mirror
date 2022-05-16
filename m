Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59387C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 20:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbiEPU3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 16:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348794AbiEPU1t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 16:27:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6F118E3F
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so232319wmj.1
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rG6jjBs5VSUk2EQErUa63hyA+/r1QGxnxgw3w++B1kw=;
        b=WOF2dhYKaQAji7j6TxBLwn/fcAIACMkDx+VOdiHHSN0fIaAfNTo3wnn9EW7b1N+Hg0
         ws1Sv/Ja+p3OH3F9+9FWlS8IYpJ3Kn6gJMzXhCiWqY/0rdHja9WBw0Lmxigmkzmvx2w7
         A4W0DpZ7PJD6KdR8uc8ewGFRCaujzDH8tvuTbzq3fBKo/QW2hc+X4Ojh0R+4mDMnjfzz
         iDLU2ZkZuCCiejWRb+lgFe7bCBGqGAUh6ke+t3tfQtkPTX2A6Zs+130ymJ00fgFZf0oq
         j9UAhI+TmU5wtpxHHQNVHgiKJwnt7NZfSkeaFDh4xd+6ebz8AJZE4DN45a6v05lDBQtx
         pWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rG6jjBs5VSUk2EQErUa63hyA+/r1QGxnxgw3w++B1kw=;
        b=78B7x0M2CZSfFfJuwCJ9h1mjs4WMhAXxFNnFlP7NEbWqjfrszhiBiSSYhTGH3MI2+i
         aqaoBkxjsmn4vz76V605wgO75S7Q3MaAYApO5WMmwkJDqnMlngOk9XIusaLrAiGS8P4y
         96ojh1pzxC93cI8/CEn8Wyw2sVDGDLj+w+HNZGFKn4i43ZakIlICp1nsUDHlZGr8xm0d
         n3tSKzM8Ai2gidqCv9s8RCW9fSnA4Io57M3Z1gkrqdaTicKF/TKfEAFHHCzyFWKW7Iwx
         /zT2p7tUmc/05g0on8dMK0dCosyzh02tcT6Psc0BipkQbyftXdGtUdL8YEPNMQbcskJM
         TCiw==
X-Gm-Message-State: AOAM533ya3oH9/8kCv982OFLE8QLTt/+/HY6oRfZQgqY8Gw3MBjSNM07
        2AwDauvkvwSDSPvsMiSCfVs5ycK3PXU=
X-Google-Smtp-Source: ABdhPJxn7TB1mobK35L8NKrLB9lSFX02J+LjUzM0+Vucacck2ihscgxgywXHFYxEDnebb83EnYNBrA==
X-Received: by 2002:a05:600c:365a:b0:394:58e:6a5c with SMTP id y26-20020a05600c365a00b00394058e6a5cmr27994198wmq.122.1652731875371;
        Mon, 16 May 2022 13:11:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020adfa507000000b0020d012692dbsm7751003wrb.18.2022.05.16.13.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:11:14 -0700 (PDT)
Message-Id: <de94c4732bd33bee68fe292676f0cefc1d8f6fff.1652731865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
References: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 20:11:03 +0000
Subject: [PATCH 6/8] remote: move relative_url()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, albertqcui@gmail.com, robbat2@gentoo.org,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This method was initially written in 63e95beb0 (submodule: port
resolve_relative_url from shell to C, 2016-05-15). As we will need
similar functionality in the bundle URI feature, extract this to be
available in remote.h.

The code is almost exactly the same, except for the following trivial
differences:

 * Fix whitespace and wrapping issues with the prototype and argument
   lists.

 * Let's call starts_with_dot_{,dot_}slash_native() instead of the
   functionally identical "starts_with_dot_{,dot_}slash()" wrappers
   "builtin/submodule--helper.c".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/submodule--helper.c | 141 +++---------------------------------
 remote.c                    |  91 +++++++++++++++++++++++
 remote.h                    |  31 ++++++++
 3 files changed, 134 insertions(+), 129 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b68102bb3ed..86f38e489b0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -72,135 +72,6 @@ static char *get_default_remote(void)
 	return repo_get_default_remote(the_repository);
 }
 
-/*
- * Returns 1 if it was the last chop before ':'.
- */
-static int chop_last_dir(char **remoteurl, int is_relative)
-{
-	char *rfind = find_last_dir_sep(*remoteurl);
-	if (rfind) {
-		*rfind = '\0';
-		return 0;
-	}
-
-	rfind = strrchr(*remoteurl, ':');
-	if (rfind) {
-		*rfind = '\0';
-		return 1;
-	}
-
-	if (is_relative || !strcmp(".", *remoteurl))
-		die(_("cannot strip one component off url '%s'"),
-			*remoteurl);
-
-	free(*remoteurl);
-	*remoteurl = xstrdup(".");
-	return 0;
-}
-
-static int starts_with_dot_slash(const char *const path)
-{
-	return starts_with_dot_slash_native(path);;
-}
-
-static int starts_with_dot_dot_slash(const char *const path)
-{
-	return starts_with_dot_dot_slash_native(path);
-}
-
-/*
- * The `url` argument is the URL that navigates to the submodule origin
- * repo. When relative, this URL is relative to the superproject origin
- * URL repo. The `up_path` argument, if specified, is the relative
- * path that navigates from the submodule working tree to the superproject
- * working tree. Returns the origin URL of the submodule.
- *
- * Return either an absolute URL or filesystem path (if the superproject
- * origin URL is an absolute URL or filesystem path, respectively) or a
- * relative file system path (if the superproject origin URL is a relative
- * file system path).
- *
- * When the output is a relative file system path, the path is either
- * relative to the submodule working tree, if up_path is specified, or to
- * the superproject working tree otherwise.
- *
- * NEEDSWORK: This works incorrectly on the domain and protocol part.
- * remote_url      url              outcome          expectation
- * http://a.com/b  ../c             http://a.com/c   as is
- * http://a.com/b/ ../c             http://a.com/c   same as previous line, but
- *                                                   ignore trailing slash in url
- * http://a.com/b  ../../c          http://c         error out
- * http://a.com/b  ../../../c       http:/c          error out
- * http://a.com/b  ../../../../c    http:c           error out
- * http://a.com/b  ../../../../../c    .:c           error out
- * NEEDSWORK: Given how chop_last_dir() works, this function is broken
- * when a local part has a colon in its path component, too.
- */
-static char *relative_url(const char *remote_url,
-				const char *url,
-				const char *up_path)
-{
-	int is_relative = 0;
-	int colonsep = 0;
-	char *out;
-	char *remoteurl = xstrdup(remote_url);
-	struct strbuf sb = STRBUF_INIT;
-	size_t len = strlen(remoteurl);
-
-	if (is_dir_sep(remoteurl[len-1]))
-		remoteurl[len-1] = '\0';
-
-	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
-		is_relative = 0;
-	else {
-		is_relative = 1;
-		/*
-		 * Prepend a './' to ensure all relative
-		 * remoteurls start with './' or '../'
-		 */
-		if (!starts_with_dot_slash(remoteurl) &&
-		    !starts_with_dot_dot_slash(remoteurl)) {
-			strbuf_reset(&sb);
-			strbuf_addf(&sb, "./%s", remoteurl);
-			free(remoteurl);
-			remoteurl = strbuf_detach(&sb, NULL);
-		}
-	}
-	/*
-	 * When the url starts with '../', remove that and the
-	 * last directory in remoteurl.
-	 */
-	while (url) {
-		if (starts_with_dot_dot_slash(url)) {
-			url += 3;
-			colonsep |= chop_last_dir(&remoteurl, is_relative);
-		} else if (starts_with_dot_slash(url))
-			url += 2;
-		else
-			break;
-	}
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
-	if (ends_with(url, "/"))
-		strbuf_setlen(&sb, sb.len - 1);
-	free(remoteurl);
-
-	if (starts_with_dot_slash(sb.buf))
-		out = xstrdup(sb.buf + 2);
-	else
-		out = xstrdup(sb.buf);
-
-	if (!up_path || !is_relative) {
-		strbuf_release(&sb);
-		return out;
-	}
-
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s%s", up_path, out);
-	free(out);
-	return strbuf_detach(&sb, NULL);
-}
-
 static char *resolve_relative_url(const char *rel_url, const char *up_path, int quiet)
 {
 	char *remoteurl, *resolved_url;
@@ -592,6 +463,18 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int starts_with_dot_slash(const char *const path)
+{
+	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_SLASH |
+				PATH_MATCH_XPLATFORM);
+}
+
+static int starts_with_dot_dot_slash(const char *const path)
+{
+	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH |
+				PATH_MATCH_XPLATFORM);
+}
+
 struct init_cb {
 	const char *prefix;
 	const char *superprefix;
diff --git a/remote.c b/remote.c
index 42a4e7106e1..87656138645 100644
--- a/remote.c
+++ b/remote.c
@@ -14,6 +14,7 @@
 #include "strvec.h"
 #include "commit-reach.h"
 #include "advice.h"
+#include "connect.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
@@ -2727,3 +2728,93 @@ void remote_state_clear(struct remote_state *remote_state)
 	hashmap_clear_and_free(&remote_state->remotes_hash, struct remote, ent);
 	hashmap_clear_and_free(&remote_state->branches_hash, struct remote, ent);
 }
+
+/*
+ * Returns 1 if it was the last chop before ':'.
+ */
+static int chop_last_dir(char **remoteurl, int is_relative)
+{
+	char *rfind = find_last_dir_sep(*remoteurl);
+	if (rfind) {
+		*rfind = '\0';
+		return 0;
+	}
+
+	rfind = strrchr(*remoteurl, ':');
+	if (rfind) {
+		*rfind = '\0';
+		return 1;
+	}
+
+	if (is_relative || !strcmp(".", *remoteurl))
+		die(_("cannot strip one component off url '%s'"),
+			*remoteurl);
+
+	free(*remoteurl);
+	*remoteurl = xstrdup(".");
+	return 0;
+}
+
+char *relative_url(const char *remote_url, const char *url,
+		   const char *up_path)
+{
+	int is_relative = 0;
+	int colonsep = 0;
+	char *out;
+	char *remoteurl = xstrdup(remote_url);
+	struct strbuf sb = STRBUF_INIT;
+	size_t len = strlen(remoteurl);
+
+	if (is_dir_sep(remoteurl[len-1]))
+		remoteurl[len-1] = '\0';
+
+	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
+		is_relative = 0;
+	else {
+		is_relative = 1;
+		/*
+		 * Prepend a './' to ensure all relative
+		 * remoteurls start with './' or '../'
+		 */
+		if (!starts_with_dot_slash_native(remoteurl) &&
+		    !starts_with_dot_dot_slash_native(remoteurl)) {
+			strbuf_reset(&sb);
+			strbuf_addf(&sb, "./%s", remoteurl);
+			free(remoteurl);
+			remoteurl = strbuf_detach(&sb, NULL);
+		}
+	}
+	/*
+	 * When the url starts with '../', remove that and the
+	 * last directory in remoteurl.
+	 */
+	while (url) {
+		if (starts_with_dot_dot_slash_native(url)) {
+			url += 3;
+			colonsep |= chop_last_dir(&remoteurl, is_relative);
+		} else if (starts_with_dot_slash_native(url))
+			url += 2;
+		else
+			break;
+	}
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
+	if (ends_with(url, "/"))
+		strbuf_setlen(&sb, sb.len - 1);
+	free(remoteurl);
+
+	if (starts_with_dot_slash_native(sb.buf))
+		out = xstrdup(sb.buf + 2);
+	else
+		out = xstrdup(sb.buf);
+
+	if (!up_path || !is_relative) {
+		strbuf_release(&sb);
+		return out;
+	}
+
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s%s", up_path, out);
+	free(out);
+	return strbuf_detach(&sb, NULL);
+}
diff --git a/remote.h b/remote.h
index 4a1209ae2c8..f18fd27e530 100644
--- a/remote.h
+++ b/remote.h
@@ -409,4 +409,35 @@ int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
 int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 
+/*
+ * The `url` argument is the URL that navigates to the submodule origin
+ * repo. When relative, this URL is relative to the superproject origin
+ * URL repo. The `up_path` argument, if specified, is the relative
+ * path that navigates from the submodule working tree to the superproject
+ * working tree. Returns the origin URL of the submodule.
+ *
+ * Return either an absolute URL or filesystem path (if the superproject
+ * origin URL is an absolute URL or filesystem path, respectively) or a
+ * relative file system path (if the superproject origin URL is a relative
+ * file system path).
+ *
+ * When the output is a relative file system path, the path is either
+ * relative to the submodule working tree, if up_path is specified, or to
+ * the superproject working tree otherwise.
+ *
+ * NEEDSWORK: This works incorrectly on the domain and protocol part.
+ * remote_url      url              outcome          expectation
+ * http://a.com/b  ../c             http://a.com/c   as is
+ * http://a.com/b/ ../c             http://a.com/c   same as previous line, but
+ *                                                   ignore trailing slash in url
+ * http://a.com/b  ../../c          http://c         error out
+ * http://a.com/b  ../../../c       http:/c          error out
+ * http://a.com/b  ../../../../c    http:c           error out
+ * http://a.com/b  ../../../../../c    .:c           error out
+ * NEEDSWORK: Given how chop_last_dir() works, this function is broken
+ * when a local part has a colon in its path component, too.
+ */
+char *relative_url(const char *remote_url, const char *url,
+		   const char *up_path);
+
 #endif
-- 
gitgitgadget

