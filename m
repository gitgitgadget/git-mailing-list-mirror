Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8D12115
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542924; cv=none; b=DTaRHIDmYDfHxtDhUvb7WIbD7C66UrTLDjcTYQ4lBNDXsn5OsTyRTXV/TTKSPtSk+eP0kLr8WT7VwyFxPaqjY1Omb7BueD9NbZGti2+TU5KKK0bLup5x35RlnV/iI8aXNcLUAUeDRIjY/lQqeEhtwo0vfhPta9vPwxyRqaQ3OWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542924; c=relaxed/simple;
	bh=02goR1oUIRqaAX6wkSZ6kwyZ0o5zwu0LRjNURjZXLhA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=C4izqzBJ/TAzRyFRpf1S5OlCjLaDta0htyENLj4NyUztJR3s8w+LmVe7sq1P42A9G45NzpDYaGOCBBnR50a1g/A9NXk1kzKxAHqj/NFUC1oYCLlyv7BJ87F5gaG5VTHG8ilVB8ky/Psy+Ip6nY+A3KLrtV0p2x0E/izPb6hvdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSKyO38p; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSKyO38p"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-337d05b8942so79328f8f.3
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 17:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542920; x=1706147720; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvQKSY9TRfwOJuLTaN1VfXvLnXYDZbW+dUt2kJaOjdg=;
        b=DSKyO38pJ/9ZUKlAMEJwpZa6IZQqjVq0WPCFBnSj8kJnBnxHbV2yphhl13XRFVxE/E
         N+LmLHPCVevqf9vVFb1PvKK7jIa3gpFdKTx5h32qMmoAi2xClA5kimdUDoXcRmc94YsU
         DG5TIYYFMf+PvZBAXF7SrRHFRy37IfuToKENgHnWsmB6DLwTfPy38l2pt8ocHblvhle9
         kpTezMHs/GSSzC+KT1V6uzaZnEv0+2FINlxb8aX5gD3LCvjH12T85szm1GRf0E9EOgje
         tO77EijYQKwIRA7mZfbKuia7ecrDRpJVCZnNqK7USItCaAWngMUq8RE9HU9fn9yaEOvN
         KtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542920; x=1706147720;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvQKSY9TRfwOJuLTaN1VfXvLnXYDZbW+dUt2kJaOjdg=;
        b=MTVAO1p0XFmzSXRFkhNKlwUa3oqrL03i84PpgTH1cInEev/yET0nC4Kebw/NNhicfQ
         i7/KEcB3vc76NaEFltrM1pZ491cLinPE65p1+t/6IVVIOAX/tZREoSW8bnNDO+lxrApu
         /cESpm7O8LGIGa6cgIkpA1rs9vVtyvVjkxqtFxt6t3UzblGSdh4O+iOi5Jj9pGriq7+G
         3ezqBcyaqlKoqlYRsRvKaFPGGl31MTIq7sCjxer9aPZBv4LsEAwwJUiXs1Jx+t2XbOFb
         UQagKEVN6f6psMJzo87BwBoGJlK/HGRO+hzU8J7ljUgACYiS7KckSzs6pKU13rGynM6m
         HiNQ==
X-Gm-Message-State: AOJu0Ywcwbj9X6EhWPK230wvOOF3k7pWbA1nf6Igzf+1XaYZw+LyYpkn
	pjFj1ABEzRWNDYpRbuVPv0maP96PzrUPMxlK1hs7gmVBNa3v69TbJgLeE95F
X-Google-Smtp-Source: AGHT+IEjdqcp9FDFsokuj68qFe7wpgB+K8vDeunv77IRs1G7A0TQQw8bIwBj4EKPH0RCWxPzP1Qofg==
X-Received: by 2002:a05:600c:168a:b0:40e:8000:3180 with SMTP id k10-20020a05600c168a00b0040e80003180mr57283wmn.50.1705542920301;
        Wed, 17 Jan 2024 17:55:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay39-20020a05600c1e2700b0040e92521b24sm75657wmb.30.2024.01.17.17.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:55:20 -0800 (PST)
Message-ID: <ce1de0406ef782c80b5e9181af2b8df991452787.1705542918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
	<pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 01:55:15 +0000
Subject: [PATCH v2 1/4] submodule-config.h: move check_submodule_url
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Victoria Dye <vdye@github.com>,
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
@@ -1047,138 +1046,6 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
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
@@ -228,6 +230,138 @@ int check_submodule_name(const char *name)
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

