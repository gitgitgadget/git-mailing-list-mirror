Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C187530B513
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766225804; cv=pass; b=t/dCNOUnlBi3WyHI8cO+8DB/MI35u2i1pVY1s94UlF/tejnA8AZpR7CfCvQhBFnF9J4Kj2LACNWu4teZp0wI2EgeydYbJ8A/Wie6JEInRsFGeNxnZROCT5UBCT9G0t1kpI4NasEbO+L5sj7GNsk4alhZ0ePghI05kZb06bLxuDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766225804; c=relaxed/simple;
	bh=t8ONYTUZ5kgVIugu4XtBZd3eLNlbrMTqiw0iOeIzWTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0nU3/zMnpxQliyy2AwFAgnvbWCcwo8eQ+Q7m4w3HS0iWQGh2Xt4BKG0aOBZiCe/+gjFWtt77w8IA6xPxLA604mxdUE/gCyy63I2Dj2+sn1JS+Hm2c3fvsduf0L6sq0KWyOdymnjjqdm5o36SWMtaaFRvBwsDwRqzRbiNBtzGCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=kJfDkg39; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="kJfDkg39"
ARC-Seal: i=1; a=rsa-sha256; t=1766225785; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YTAdB2r4QPU0gDyTThK0lR17tHc4KAhr/Ry8xw4tFUKZzBxlsOFxvbMkkTeJTKmdkdam0bEY5QWVX6r/iJdhmbEpsgXHqsv1rHQYtSbk0b3qaGVy3BjDeyMqTF8jxeKXx6dUA2e1rzjC9isBg0JdfaaAyBfFvw3u4hD78a9bLj8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766225785; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JS5p2DAN7HTCb0IT+7XqDcUQkFW1TjWI0yqZCUqwqEM=; 
	b=U+klQJCIoKh5VDULpkUPsAeuZNTSGofaRcdHtvajl+TYoveypdOwdo1xa4Ma+XNmYr/B9r8JlmsagsovG6YS7xAu1ffAJlQdAkSBeK8e8Xl3YabUxslbTURoxivNxWj52aeKHo7oJ9Ij/tMtTh/VdkXoqNRnmYKC/e06NLulIbI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766225785;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JS5p2DAN7HTCb0IT+7XqDcUQkFW1TjWI0yqZCUqwqEM=;
	b=kJfDkg39eMkBkRLZABSnJmJPEdVY1ETUVH7UfF/MhgTHgFACIpoanDoYGhVJMfr/
	5uwCr4m61eCJRgyX6RNV3pEmLS8sJ7Cq7U9Y/mHB7dakZtwvrYI0//w2hUvLb6GqqsK
	5K4tpwMqO6SuvO5o5EZRM4ypWmYlntRJHowsy7cs=
Received: by mx.zohomail.com with SMTPS id 1766225783089566.0438458851179;
	Sat, 20 Dec 2025 02:16:23 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v7 09/11] submodule: fix case-folding gitdir filesystem collisions
Date: Sat, 20 Dec 2025 12:15:26 +0200
Message-ID: <20251220101528.1227487-10-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251220101528.1227487-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a new check when extension.submodulePathConfig is enabled, to
detect and prevent case-folding filesystem colisions. When this
new check is triggered, a stricter casefolding aware URI encoding
is used to percent-encode uppercase characters.

By using this check/retry mechanism the uppercase encoding is
only applied when necessary, so case-sensitive filesystems are
not affected.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c                | 26 ++++++++++-
 submodule.c                                | 53 +++++++++++++++++++++-
 t/t7425-submodule-gitdir-path-extension.sh | 35 ++++++++++++++
 url.c                                      |  7 +++
 url.h                                      |  7 +++
 5 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 81ba95d11c..d601306882 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -473,7 +473,7 @@ static void create_default_gitdir_config(const char *submodule_name)
 		return;
 	}
 
-	/* Case 2: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
+	/* Case 2.1: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
 	strbuf_reset(&gitdir_path);
 	repo_git_path_append(the_repository, &gitdir_path, "modules/");
 	strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_rfc3986_unreserved);
@@ -482,6 +482,30 @@ static void create_default_gitdir_config(const char *submodule_name)
 		return;
 	}
 
+	/* Case 2.2: Try extended uppercase URI (RFC3986) encoding, to fix case-folding */
+	strbuf_reset(&gitdir_path);
+	repo_git_path_append(the_repository, &gitdir_path, "modules/");
+	strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_casefolding_rfc3986_unreserved);
+	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name))
+		return;
+
+	/* Case 2.3: Try some derived gitdir names, see if one sticks */
+	for (char c = '0'; c <= '9'; c++) {
+		strbuf_reset(&gitdir_path);
+		repo_git_path_append(the_repository, &gitdir_path, "modules/");
+		strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_rfc3986_unreserved);
+		strbuf_addch(&gitdir_path, c);
+		if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name))
+			return;
+
+		strbuf_reset(&gitdir_path);
+		repo_git_path_append(the_repository, &gitdir_path, "modules/");
+		strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_casefolding_rfc3986_unreserved);
+		strbuf_addch(&gitdir_path, c);
+		if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name))
+			return;
+	}
+
 	/* Case 3: nothing worked, error out */
 	die(_("failed to set a valid default config for 'submodule.%s.gitdir'. "
 	      "Please ensure it is set, for example by running something like: "
diff --git a/submodule.c b/submodule.c
index cf32872ec7..834c794b7d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2247,15 +2247,58 @@ int submodule_move_head(const char *path, const char *super_prefix,
 	return ret;
 }
 
+static int check_casefolding_conflict(const char *git_dir,
+				      const char *submodule_name,
+				      const bool suffixes_match)
+{
+	char *p, *modules_dir = xstrdup(git_dir);
+	struct dirent *de;
+	DIR *dir = NULL;
+	int ret = 0;
+
+	if ((p = find_last_dir_sep(modules_dir)))
+		*p = '\0';
+
+	/* No conflict is possible if modules_dir doesn't exist (first clone) */
+	if (!is_directory(modules_dir))
+		goto cleanup;
+
+	dir = opendir(modules_dir);
+	if (!dir) {
+		ret = -1;
+		goto cleanup;
+	}
+
+	/* Check for another directory under .git/modules that differs only in case. */
+	while ((de = readdir(dir))) {
+		if (!strcmp(de->d_name, ".") || !strcmp(de->d_name, ".."))
+			continue;
+
+		if ((suffixes_match || is_git_directory(git_dir)) &&
+		    !strcasecmp(de->d_name, submodule_name) &&
+		    strcmp(de->d_name, submodule_name)) {
+			ret = -1; /* collision found */
+			break;
+		}
+	}
+
+cleanup:
+	if (dir)
+		closedir(dir);
+	free(modules_dir);
+	return ret;
+}
+
 /*
  * Encoded gitdir validation, only used when extensions.submodulePathConfig is enabled.
  * This does not print errors like the non-encoded version, because encoding is supposed
  * to mitigate / fix all these.
  */
-static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodule_name UNUSED)
+static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodule_name)
 {
 	const char *modules_marker = "/modules/";
 	char *p = git_dir, *last_submodule_name = NULL;
+	int config_ignorecase = 0;
 
 	if (!the_repository->repository_format_submodule_path_cfg)
 		BUG("validate_submodule_encoded_git_dir() must be called with "
@@ -2271,6 +2314,14 @@ static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodu
 	if (!last_submodule_name || strchr(last_submodule_name, '/'))
 		return -1;
 
+	/* Prevent conflicts on case-folding filesystems */
+	repo_config_get_bool(the_repository, "core.ignorecase", &config_ignorecase);
+	if (ignore_case || config_ignorecase) {
+		bool suffixes_match = !strcmp(last_submodule_name, submodule_name);
+		return check_casefolding_conflict(git_dir, submodule_name,
+						  suffixes_match);
+	}
+
 	return 0;
 }
 
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index dbe18f2925..eb9c80787c 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -384,4 +384,39 @@ test_expect_success 'disabling extensions.submodulePathConfig prevents nested su
 	)
 '
 
+test_expect_success CASE_INSENSITIVE_FS 'verify case-folding conflicts are correctly encoded' '
+	git clone -c extensions.submodulePathConfig=true main cloned-folding &&
+	(
+		cd cloned-folding &&
+
+		# conflict: the "folding" gitdir will already be taken
+		git submodule add ../new-sub "folding" &&
+		test_commit lowercase &&
+		git submodule add ../new-sub "FoldinG" &&
+		test_commit uppercase &&
+
+		# conflict: the "foo" gitdir will already be taken
+		git submodule add ../new-sub "FOO" &&
+		test_commit uppercase-foo &&
+		git submodule add ../new-sub "foo" &&
+		test_commit lowercase-foo &&
+
+		# create a multi conflict between foobar, fooBar and foo%42ar
+		# the "foo" gitdir will already be taken
+		git submodule add ../new-sub "foobar" &&
+		test_commit lowercase-foobar &&
+		git submodule add ../new-sub "foo%42ar" &&
+		test_commit encoded-foo%42ar &&
+		git submodule add ../new-sub "fooBar" &&
+		test_commit mixed-fooBar
+	) &&
+	verify_submodule_gitdir_path cloned-folding "folding" "modules/folding" &&
+	verify_submodule_gitdir_path cloned-folding "FoldinG" "modules/%46oldin%47" &&
+	verify_submodule_gitdir_path cloned-folding "FOO" "modules/FOO" &&
+	verify_submodule_gitdir_path cloned-folding "foo" "modules/foo0" &&
+	verify_submodule_gitdir_path cloned-folding "foobar" "modules/foobar" &&
+	verify_submodule_gitdir_path cloned-folding "foo%42ar" "modules/foo%42ar" &&
+	verify_submodule_gitdir_path cloned-folding "fooBar" "modules/fooBar0"
+'
+
 test_done
diff --git a/url.c b/url.c
index adc289229c..3ca5987e90 100644
--- a/url.c
+++ b/url.c
@@ -9,6 +9,13 @@ int is_rfc3986_unreserved(char ch)
 		ch == '-' || ch == '_' || ch == '.' || ch == '~';
 }
 
+int is_casefolding_rfc3986_unreserved(char c)
+{
+	return (c >= 'a' && c <= 'z') ||
+	       (c >= '0' && c <= '9') ||
+	       c == '-' || c == '.' || c == '_' || c == '~';
+}
+
 int is_urlschemechar(int first_flag, int ch)
 {
 	/*
diff --git a/url.h b/url.h
index e644c3c809..cd9140e994 100644
--- a/url.h
+++ b/url.h
@@ -28,4 +28,11 @@ void str_end_url_with_slash(const char *url, char **dest);
  */
 int is_rfc3986_unreserved(char ch);
 
+/*
+ * This is a variant of is_rfc3986_unreserved() that treats uppercase
+ * letters as "reserved". This forces them to be percent-encoded, allowing
+ * 'Foo' (%46oo) and 'foo' (foo) to be distinct on case-folding filesystems.
+ */
+int is_casefolding_rfc3986_unreserved(char c);
+
 #endif /* URL_H */
-- 
2.51.2

