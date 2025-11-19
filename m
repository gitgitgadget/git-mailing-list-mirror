Received: from sender3-op-o12.zoho.com (sender3-op-o12.zoho.com [136.143.184.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED762F7469
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586718; cv=pass; b=TVKV5KDg4I5dRN6CaUdNNaMKBDeV8GHWzWtKJxE9sO8GkXhZzQmoLNRQMHxaQz/qa6Lmz1kQi0pN9dCPhsdl5XrJEzJ8eLoo+5otp/Cw0ablVzALeNuDAE27VxpkqVUkTiHSRNwfUVRr0aOkw5IOmOh1HpF0mxD3he67goRLHJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586718; c=relaxed/simple;
	bh=RhdUpmETaV8uw6ZonhNLgEAuMPLkLMWuOB2o+J7qdFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9C8B6L/6VjUN8CShnTxYKh23pGne+FQM1ZBwNzeES14htdWMNai1vXtdHwbuXIhlb/50d2gIDafmnqemumjSyCb6po33pjlS2MZm9ZQOwfue25paJgrZBqsDtv4jh4Kt6T0yF9X51U24c8ADHk5UNFFz81vp7G9gYHpRU68MQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=aa0DBVD7; arc=pass smtp.client-ip=136.143.184.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="aa0DBVD7"
ARC-Seal: i=1; a=rsa-sha256; t=1763586690; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UWs+bhkZrODBvt/mCpkM5N8AWnrO/hkib4G3//Nz52umw602S2nMlm1YF2DMv0pmlzIofhjk4zWDINTegl83O/ccxEHeA4evBmxL0EBzhH0CpAvUzSgLUc1PFIGjrWMVzJORHw7Lo5bD3dLynb8NIjXak+b0TU+77W7pgFmZgaU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763586690; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8VvaqxC7a7YJ/0UhUcW8DRbsrizyxtHe8F9OwsxP7P0=; 
	b=AHeqSg76utLz+XN0VqjbgnNhwcBEGvNSOLDyGq2qIW6ORMaD3yJsTa+8t2bYjZBky8Su2/9q8Lpi0+eb/7I04c5jfPawTWsBOKL/upC/pHxjWV05VW4I3c0IOupLsU8hy7S+3L5CtE5EpW/TlFxa5aSiUtuJKc1EfebJmJDabzI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763586690;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8VvaqxC7a7YJ/0UhUcW8DRbsrizyxtHe8F9OwsxP7P0=;
	b=aa0DBVD7Fv3Or1nAA7wLXD4j4IGANLN6PVnX9XiE615djoFtk1ecjkemw5fPuue5
	jsmdbtfJOnh/LJCiasgdmuK50lOYolO8tgpRFNU6viPFBncTD933QYYgsrrpWfAfc2S
	kx29giDDI0xFxc1GcxmGzunVAodKpLFh4trJSuBE=
Received: by mx.zohomail.com with SMTPS id 1763586689236618.7524375355379;
	Wed, 19 Nov 2025 13:11:29 -0800 (PST)
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
Subject: [PATCH v5 5/7] submodule: fix case-folding gitdir filesystem colisions
Date: Wed, 19 Nov 2025 23:10:28 +0200
Message-ID: <20251119211030.2008441-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119211030.2008441-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a new check when extension.submoduleEncoding is enabled to
detect and prevent case-folding filesystem colisions. When this
new check is triggered, a stricter casefolding aware URI encoding
is used to percent-encode uppercase characters.

By using this check/retry mechanism the uppercase encoding is
only applied when necessary, so case-sensitive filesystems are
not affected.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 submodule.c                   | 79 ++++++++++++++++++++++++++++++++++-
 t/t7425-submodule-encoding.sh | 35 ++++++++++++++++
 url.c                         | 12 ++++++
 url.h                         |  1 +
 4 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 07cb4694cf..b3f74f7e3c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2238,15 +2238,58 @@ int submodule_move_head(const char *path, const char *super_prefix,
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
+	FREE_AND_NULL(modules_dir);
+	return ret;
+}
+
 /*
  * Encoded gitdir validation function used when extensions.submoduleEncoding is enabled.
  * This does not print errors like the non-encoded version, because encoding is supposed
  * to mitigate / fix all these.
  */
-static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodule_name UNUSED)
+static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodule_name)
 {
 	const char *modules_marker = "/modules/";
 	char *p = git_dir, *last_submodule_name = NULL;
+	int config_ignorecase = 0;
 
 	if (!the_repository->repository_format_submodule_encoding)
 		BUG("validate_submodule_encoded_git_dir() must be called with "
@@ -2262,6 +2305,14 @@ static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodu
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
 
@@ -2650,13 +2701,37 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
 		return;
 
-	/* Case 2: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
+	/* Case 2.1: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
 	strbuf_reset(buf);
 	repo_git_path_append(r, buf, "modules/");
 	strbuf_addstr_urlencode(buf, submodule_name, is_rfc3986_unreserved);
 	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
 		return;
 
+	/* Case 2.2: Try extended uppercase URI (RFC3986) encoding, to fix case-folding */
+	strbuf_reset(buf);
+	repo_git_path_append(r, buf, "modules/");
+	strbuf_addstr_urlencode(buf, submodule_name, is_casefolding_rfc3986_unreserved);
+	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
+		return;
+
+	/* Case 2.3: Try some derived gitdir names, see if one sticks */
+	for (char c = '0'; c <= '9'; c++) {
+		strbuf_reset(buf);
+		repo_git_path_append(r, buf, "modules/");
+		strbuf_addstr_urlencode(buf, submodule_name, is_rfc3986_unreserved);
+		strbuf_addch(buf, c);
+		if (!validate_and_set_submodule_gitdir(buf, submodule_name))
+			return;
+
+		strbuf_reset(buf);
+		repo_git_path_append(r, buf, "modules/");
+		strbuf_addstr_urlencode(buf, submodule_name, is_casefolding_rfc3986_unreserved);
+		strbuf_addch(buf, c);
+		if (!validate_and_set_submodule_gitdir(buf, submodule_name))
+			return;
+	}
+
 	/* Case 3: Nothing worked: error out */
 	die(_("Cannot construct a valid gitdir path for submodule '%s': "
 	      "please set a unique git config for 'submodule.%s.gitdir'."),
diff --git a/t/t7425-submodule-encoding.sh b/t/t7425-submodule-encoding.sh
index f877887549..093238939a 100755
--- a/t/t7425-submodule-encoding.sh
+++ b/t/t7425-submodule-encoding.sh
@@ -161,4 +161,39 @@ test_expect_success 'disabling extensions.submoduleEncoding prevents nested subm
 	)
 '
 
+test_expect_success CASE_INSENSITIVE_FS 'verify case-folding conflicts are correctly encoded' '
+	git clone -c extensions.submoduleEncoding=true main cloned-folding &&
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
index 0fb1859b28..057e6e5c6e 100644
--- a/url.c
+++ b/url.c
@@ -14,6 +14,18 @@ int is_rfc3986_unreserved(char ch)
 		ch == '-' || ch == '_' || ch == '.' || ch == '~';
 }
 
+/*
+ * This is a variant of is_rfc3986_unreserved() that treats uppercase
+ * letters as "reserved". This forces them to be percent-encoded, allowing
+ * 'Foo' (%46oo) and 'foo' (foo) to be distinct on case-folding filesystems.
+ */
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
index 131a262066..92e3c63514 100644
--- a/url.h
+++ b/url.h
@@ -22,5 +22,6 @@ void end_url_with_slash(struct strbuf *buf, const char *url);
 void str_end_url_with_slash(const char *url, char **dest);
 
 int is_rfc3986_unreserved(char ch);
+int is_casefolding_rfc3986_unreserved(char c);
 
 #endif /* URL_H */
-- 
2.51.0

