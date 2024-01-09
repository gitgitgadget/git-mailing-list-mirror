Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C508D3B797
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+silnmS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e47dc8b0eso19938335e9.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704822819; x=1705427619; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT897d8vKATZrDkrazHwdmM4uBpBI7FyslVfKjXdaTQ=;
        b=Y+silnmSy36Wft9diYo7UP+IUmw6m1BpIJMfQjHgj6dntSCN+y9EDOz1wFgfKACYxs
         JZg/VZh8NBUt2tMKKJW5xJtaqs/3FSHtdlsPnRDrRNvvN4fR4Hq3FRRs6ZT3VsxsHWxl
         VaSsUr2j/O7fkXeo1eXT1FdSxN5mpD1NNvc4SqWAK7L9CIqbKY2Y7sBA6Qbx6G3f+xZM
         ya276x4/WDa8fR2ZvN0BSyJnzjuO/ba6De2S21p0kSjF0WTn/4mnUR1rnL8kK1cCesjy
         0t/EFP90ioaFZ4hZ9TaA8Qtx3wGRqZdl1TmksaAMV4mS8kdezN1ikC4u6j3X/93zKw86
         Otxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822819; x=1705427619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OT897d8vKATZrDkrazHwdmM4uBpBI7FyslVfKjXdaTQ=;
        b=N2FwhqbJBhI3o6CyTXX/nfDS3QLYxcc8dZ5BsYOOrzw0Bic04s64umIcmV4+GClCPk
         HYMK2bKKs2q7xmnu3ur+setumUaqmth91kwMvFZGrs6iQqBO6QkpxyFgX1lkDKAnK/Wa
         0H6vsKo8q7EWs2FHMlHi4FY+6/i9l27REE7k+ybMtSUQjxs/Ko9XsqgzTrgx3PLJ7UoY
         b2k4BMzD8SuNQhlJpB88VihF623wdzjrxgJyuyiwVVCEXSYQqLfvJNxBLmON8BIjRmIH
         TtJOSW/pIkcmFtN4hDOz20RYBwr73Hskw8cibg4mu8zCE2vjETyVh5b5mtjzwW/ita1Z
         OgnQ==
X-Gm-Message-State: AOJu0Yx0kHaiqORWm2vmKz9pyEMqnUg++rL6YVwc552U14KqejwN9ubp
	W1kdTSDLNbxOzmZnk9fICuM6ihXdev0=
X-Google-Smtp-Source: AGHT+IGqejcJurPHd4jafxpTrA7SLUpRQKNU93nFikVuZQj7XCE5bCn9IIBb7GihZRRb1dFjmB9J3w==
X-Received: by 2002:a05:600c:4e8b:b0:40d:560c:eeab with SMTP id f11-20020a05600c4e8b00b0040d560ceeabmr3354979wmq.58.1704822819023;
        Tue, 09 Jan 2024 09:53:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c314400b0040d7c3d5454sm15487745wmo.3.2024.01.09.09.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:53:38 -0800 (PST)
Message-ID: <588de3022d7703cfacfca3362655531a56ea161e.1704822817.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jan 2024 17:53:35 +0000
Subject: [PATCH 1/3] submodule-config.h: move check_submodule_url
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Move 'check_submodule_url' out of 'fsck.c' and into 'submodule-config.h' as
a public method, similar to 'check_submodule_name'. With the function now
accessible outside of 'fsck', it can be used in a later commit to extend
'test-tool submodule' to check the validity of submodule URLs as it does
with names in the 'check-name' subcommand.

Other than its location, no changes are made to 'check_submodule_url' in
this patch.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 fsck.c             | 133 --------------------------------------------
 submodule-config.c | 134 +++++++++++++++++++++++++++++++++++++++++++++
 submodule-config.h |   3 +
 3 files changed, 137 insertions(+), 133 deletions(-)

diff --git a/fsck.c b/fsck.c
index 1ad02fcdfab..8ded0a473a4 100644
--- a/fsck.c
+++ b/fsck.c
@@ -20,7 +20,6 @@
 #include "packfile.h"
 #include "submodule-config.h"
 #include "config.h"
-#include "credential.h"
 #include "help.h"
 
 static ssize_t max_tree_entry_len = 4096;
@@ -1047,138 +1046,6 @@ done:
 	return ret;
 }
 
-static int starts_with_dot_slash(const char *const path)
-{
-	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_SLASH |
-				PATH_MATCH_XPLATFORM);
-}
-
-static int starts_with_dot_dot_slash(const char *const path)
-{
-	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH |
-				PATH_MATCH_XPLATFORM);
-}
-
-static int submodule_url_is_relative(const char *url)
-{
-	return starts_with_dot_slash(url) || starts_with_dot_dot_slash(url);
-}
-
-/*
- * Count directory components that a relative submodule URL should chop
- * from the remote_url it is to be resolved against.
- *
- * In other words, this counts "../" components at the start of a
- * submodule URL.
- *
- * Returns the number of directory components to chop and writes a
- * pointer to the next character of url after all leading "./" and
- * "../" components to out.
- */
-static int count_leading_dotdots(const char *url, const char **out)
-{
-	int result = 0;
-	while (1) {
-		if (starts_with_dot_dot_slash(url)) {
-			result++;
-			url += strlen("../");
-			continue;
-		}
-		if (starts_with_dot_slash(url)) {
-			url += strlen("./");
-			continue;
-		}
-		*out = url;
-		return result;
-	}
-}
-/*
- * Check whether a transport is implemented by git-remote-curl.
- *
- * If it is, returns 1 and writes the URL that would be passed to
- * git-remote-curl to the "out" parameter.
- *
- * Otherwise, returns 0 and leaves "out" untouched.
- *
- * Examples:
- *   http::https://example.com/repo.git -> 1, https://example.com/repo.git
- *   https://example.com/repo.git -> 1, https://example.com/repo.git
- *   git://example.com/repo.git -> 0
- *
- * This is for use in checking for previously exploitable bugs that
- * required a submodule URL to be passed to git-remote-curl.
- */
-static int url_to_curl_url(const char *url, const char **out)
-{
-	/*
-	 * We don't need to check for case-aliases, "http.exe", and so
-	 * on because in the default configuration, is_transport_allowed
-	 * prevents URLs with those schemes from being cloned
-	 * automatically.
-	 */
-	if (skip_prefix(url, "http::", out) ||
-	    skip_prefix(url, "https::", out) ||
-	    skip_prefix(url, "ftp::", out) ||
-	    skip_prefix(url, "ftps::", out))
-		return 1;
-	if (starts_with(url, "http://") ||
-	    starts_with(url, "https://") ||
-	    starts_with(url, "ftp://") ||
-	    starts_with(url, "ftps://")) {
-		*out = url;
-		return 1;
-	}
-	return 0;
-}
-
-static int check_submodule_url(const char *url)
-{
-	const char *curl_url;
-
-	if (looks_like_command_line_option(url))
-		return -1;
-
-	if (submodule_url_is_relative(url) || starts_with(url, "git://")) {
-		char *decoded;
-		const char *next;
-		int has_nl;
-
-		/*
-		 * This could be appended to an http URL and url-decoded;
-		 * check for malicious characters.
-		 */
-		decoded = url_decode(url);
-		has_nl = !!strchr(decoded, '\n');
-
-		free(decoded);
-		if (has_nl)
-			return -1;
-
-		/*
-		 * URLs which escape their root via "../" can overwrite
-		 * the host field and previous components, resolving to
-		 * URLs like https::example.com/submodule.git and
-		 * https:///example.com/submodule.git that were
-		 * susceptible to CVE-2020-11008.
-		 */
-		if (count_leading_dotdots(url, &next) > 0 &&
-		    (*next == ':' || *next == '/'))
-			return -1;
-	}
-
-	else if (url_to_curl_url(url, &curl_url)) {
-		struct credential c = CREDENTIAL_INIT;
-		int ret = 0;
-		if (credential_from_url_gently(&c, curl_url, 1) ||
-		    !*c.host)
-			ret = -1;
-		credential_clear(&c);
-		return ret;
-	}
-
-	return 0;
-}
-
 struct fsck_gitmodules_data {
 	const struct object_id *oid;
 	struct fsck_options *options;
diff --git a/submodule-config.c b/submodule-config.c
index f4dd482abc9..3b295e9f89c 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -14,6 +14,8 @@
 #include "parse-options.h"
 #include "thread-utils.h"
 #include "tree-walk.h"
+#include "url.h"
+#include "credential.h"
 
 /*
  * submodule cache lookup structure
@@ -228,6 +230,138 @@ in_component:
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
+static int submodule_url_is_relative(const char *url)
+{
+	return starts_with_dot_slash(url) || starts_with_dot_dot_slash(url);
+}
+
+/*
+ * Count directory components that a relative submodule URL should chop
+ * from the remote_url it is to be resolved against.
+ *
+ * In other words, this counts "../" components at the start of a
+ * submodule URL.
+ *
+ * Returns the number of directory components to chop and writes a
+ * pointer to the next character of url after all leading "./" and
+ * "../" components to out.
+ */
+static int count_leading_dotdots(const char *url, const char **out)
+{
+	int result = 0;
+	while (1) {
+		if (starts_with_dot_dot_slash(url)) {
+			result++;
+			url += strlen("../");
+			continue;
+		}
+		if (starts_with_dot_slash(url)) {
+			url += strlen("./");
+			continue;
+		}
+		*out = url;
+		return result;
+	}
+}
+/*
+ * Check whether a transport is implemented by git-remote-curl.
+ *
+ * If it is, returns 1 and writes the URL that would be passed to
+ * git-remote-curl to the "out" parameter.
+ *
+ * Otherwise, returns 0 and leaves "out" untouched.
+ *
+ * Examples:
+ *   http::https://example.com/repo.git -> 1, https://example.com/repo.git
+ *   https://example.com/repo.git -> 1, https://example.com/repo.git
+ *   git://example.com/repo.git -> 0
+ *
+ * This is for use in checking for previously exploitable bugs that
+ * required a submodule URL to be passed to git-remote-curl.
+ */
+static int url_to_curl_url(const char *url, const char **out)
+{
+	/*
+	 * We don't need to check for case-aliases, "http.exe", and so
+	 * on because in the default configuration, is_transport_allowed
+	 * prevents URLs with those schemes from being cloned
+	 * automatically.
+	 */
+	if (skip_prefix(url, "http::", out) ||
+	    skip_prefix(url, "https::", out) ||
+	    skip_prefix(url, "ftp::", out) ||
+	    skip_prefix(url, "ftps::", out))
+		return 1;
+	if (starts_with(url, "http://") ||
+	    starts_with(url, "https://") ||
+	    starts_with(url, "ftp://") ||
+	    starts_with(url, "ftps://")) {
+		*out = url;
+		return 1;
+	}
+	return 0;
+}
+
+int check_submodule_url(const char *url)
+{
+	const char *curl_url;
+
+	if (looks_like_command_line_option(url))
+		return -1;
+
+	if (submodule_url_is_relative(url) || starts_with(url, "git://")) {
+		char *decoded;
+		const char *next;
+		int has_nl;
+
+		/*
+		 * This could be appended to an http URL and url-decoded;
+		 * check for malicious characters.
+		 */
+		decoded = url_decode(url);
+		has_nl = !!strchr(decoded, '\n');
+
+		free(decoded);
+		if (has_nl)
+			return -1;
+
+		/*
+		 * URLs which escape their root via "../" can overwrite
+		 * the host field and previous components, resolving to
+		 * URLs like https::example.com/submodule.git and
+		 * https:///example.com/submodule.git that were
+		 * susceptible to CVE-2020-11008.
+		 */
+		if (count_leading_dotdots(url, &next) > 0 &&
+		    (*next == ':' || *next == '/'))
+			return -1;
+	}
+
+	else if (url_to_curl_url(url, &curl_url)) {
+		struct credential c = CREDENTIAL_INIT;
+		int ret = 0;
+		if (credential_from_url_gently(&c, curl_url, 1) ||
+		    !*c.host)
+			ret = -1;
+		credential_clear(&c);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int name_and_item_from_var(const char *var, struct strbuf *name,
 				  struct strbuf *item)
 {
diff --git a/submodule-config.h b/submodule-config.h
index 958f320ac6c..b6133af71b0 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -89,6 +89,9 @@ int config_set_in_gitmodules_file_gently(const char *key, const char *value);
  */
 int check_submodule_name(const char *name);
 
+/* Returns 0 if the URL valid per RFC3986 and -1 otherwise. */
+int check_submodule_url(const char *url);
+
 /*
  * Note: these helper functions exist solely to maintain backward
  * compatibility with 'fetch' and 'update_clone' storing configuration in
-- 
gitgitgadget

