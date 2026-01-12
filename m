Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC223C506
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244092; cv=pass; b=qZT4AcEY17b3h3gyNKdK0ODojriZXIRD6kstkJP0ACaFkmXd9Qh7BIoQmHT6zh1lQmvLpzoyEGaRjQpEmiXqg0rXmFcIgJiP/M0XhRUO7k7cLEBvo4/dAQJSdtoV1Xk4rKy9yZmcKpM+Xl7F/Y5qnbTLsPiCQe/NgjZ2r/dVWaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244092; c=relaxed/simple;
	bh=3GzzG0jrDxnmaUd+FzxElRBRJVcFtn1pL3h1QvNJHiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKmpNy6GyrQrnzzCorxkTRuWolVg4mi8nBtyCfQQ9xTSwMIGy3YmeP2hvDmlQVY5OqUhrZAf/45bZtH+H+XsGcu9ZRm+kXd7R5+8xKNYtuIJDrzbjFz8J5bICfUJ1fJEBT2L0VVOZAmUW7EdcP3YH8tXaGI81YzmqApRgnO7FdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=DhTo4Phj; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="DhTo4Phj"
ARC-Seal: i=1; a=rsa-sha256; t=1768244076; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V3dfS8NsKrzeUoC0yyV9S9i2TGA7fSn4uS44TLAphKGNt4VHiBMJs4eA1if5hvUBlDkktl98PCdrzGI5JpStRW4BYGmHomssbE9Qrpq+7+MZnWYs1M8cdxnrOK3ouIBibcmvFszBUPELG1WudTMaRmxFYqaYYou6Qm4cwUPSVY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768244076; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mYcgnrZ/JCCOW5Ub4Z92rV4Fj0wj5M5HR179xKDgcTo=; 
	b=l2kRGckb3eMeJp8HhJ3VKcDFrXX2XQh/MIIv6/LQUjngNVrm3ZmOPz5+pYMCjVnUGnVXRgXv49MDwWujkDIq+lLlD5VXe6mAoijbdaL02HxOWWAFzUeBRGsMgdlAxJusf6cIf4deOcE4MoLe8fTAba5E8nre80pOgMiU0SZ0Mjc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768244076;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mYcgnrZ/JCCOW5Ub4Z92rV4Fj0wj5M5HR179xKDgcTo=;
	b=DhTo4PhjHRjTPNKerpZPRs3mWSgnW9cbgO6Dd6iyaf3JQ8vuGJ8lp13POUC04he+
	q6wB3C/2YK5MRvu3QKPDElKCk2ew0wK6BsjzuWrspyLakalSzl6xqdTARXcBSsHQS2I
	hr8CbmO52JbXEpTO26TeW3TRHilQaeCX2JmRaTgo=
Received: by mx.zohomail.com with SMTPS id 1768244073943553.8672958595632;
	Mon, 12 Jan 2026 10:54:33 -0800 (PST)
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
Subject: [PATCH v9 09/11] submodule: fix case-folding gitdir filesystem collisions
Date: Mon, 12 Jan 2026 20:46:30 +0200
Message-ID: <20260112184632.1334495-10-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112184632.1334495-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260112184632.1334495-1-adrian.ratiu@collabora.com>
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
index 2c61810644..3d5a81201e 100644
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
index 9dc0938340..2fb0f404fd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2248,15 +2248,58 @@ int submodule_move_head(const char *path, const char *super_prefix,
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
@@ -2272,6 +2315,14 @@ static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodu
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
index ce1428a2ff..3cca93c897 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -403,4 +403,39 @@ test_expect_success 'disabling extensions.submodulePathConfig prevents nested su
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
2.52.0

