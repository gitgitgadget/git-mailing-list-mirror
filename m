Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DDF472768
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220661; cv=none; b=Z9fIeNxXnX2tcacm1lMVIlc8i78MG6JEo8UG4mdJcsPl2q2zd1UV8/37DAGffaJBIFEY6YFYeSutm5XsGMdkPzTIkFXpezWqb5uCZNLD35zIzv7a0SQW/tXz0rUohh7XV0f7F0wABuLQstoeX1LgPZyji3rvKWqddSjAU7PfwpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220661; c=relaxed/simple;
	bh=nan0tvNNh6+YBZ0wgfmbvaXawXQya17K3g7U99/GTdY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HkUIbadEMfbq+ytggCLvGq0h+BhHoj6qQyST2UO+AuRhuV/nrzmCFKH1oab3Iify/gbQu1jM/ILUzVOnMMOV0sa5KdLXHFfjjHsxewruWW/5/1v/0bnjZPmzI6JFfagFVV+XYohVufeWYC1UcdXgDdjW4rDHvQcVVh9vxzWMwVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Msu30nIb; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Msu30nIb"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bdcfbd0779so2788584eec.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220659; x=1772825459; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STQwLaw2n2AkzyZX9Cu/e88Co8KO38oRAzsqopajUNk=;
        b=Msu30nIbcb+DmVwPx/Q3lDDbrp6ZKJo0a+T22LwNRmhsMY+W2rAzKCN+zi3RQI8lel
         bz5mvTrYxowOaitri1vDD0OkZDN5kYkSEdyhjfy9lnnHsR+m5sTaS18mmOlP+KudIR+Y
         9cwFUDWiKGIL0y3Q/LPd4akqVTwmylXwsrliNb2XOf9ZL7l4wg+ES/o4OsGRp0wAnxxE
         QCr+pYRbyI9pHZhiiOzqVvqsda3Rnd1RycYgixJ9m1E0cKEsyh/v6E7fmBl15ZqMJCps
         RhtYFQIoHjJf6UbGmm6pyXqZktWsQbyIrCBIzZCOx/WAKn2ZiUNOluOJ83eWJkzhkH+6
         Ls3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220659; x=1772825459;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=STQwLaw2n2AkzyZX9Cu/e88Co8KO38oRAzsqopajUNk=;
        b=akkWFYCd3H31xvcgq4w/IABkaoAzCqQEsAidDp8dWwSRC3MDhdZXTklOISXiburHoF
         Qshv8X2aL7IepuaEU7u1mPW1aiO3k1omhQJaGV98mceFPrBbx5OV6Ph7HMKFaJcrvfSa
         Vl0XQS3nHcm+whfEHdkHio7wEOokDWBwfDUknSu0lEUl1oJoeGD5V4Bab+O3mBIs0Kvj
         5cKxDW5dwHk8FteRmZSaSsyaLZjX+QwE4StOZEpHLloWqDDPzf2mba9qgFKW4TDshy2S
         gMBiCB7BoUur5GGfIsaWtrBqhGHpnHYCtDP2mJZ4VjDacwaR3zKOpiWihgpc+ecIbBK0
         qUPw==
X-Gm-Message-State: AOJu0Yxid0QUIGKkBMDpCLSZ55g1bsFRif7i4QYPPgy9oiUfPYJXfEpE
	mVQmkfWo/q+i1moYDU8017uWyiRLlGAFVnUa/GjPFgN4JIPI6EVgBN8Go4PghA==
X-Gm-Gg: ATEYQzzKw86JsCNqz4rBcoHAc3gC8tWhFg1ddu4hVxA6gec79Bpce1EgRWNUMuvjJgM
	07l8JM5YspBoTTxh8jGYFVbLbnTJ8Es9lvj5vET436DwSCn1G5D1zG1/bLxfoFSC5Upl+iXt2vz
	z+okNQgWD6FhJHv9Q5revVYpXUpW+71kaMzci2qELVUR9dkbDAhRkuPAl/6BJLIF56yCdHTw+WJ
	6HDmIUHA3GB/GEP5RB0PutJ3zcPNwppMD/WffqvfVUeFBeBOU1O5eDu7WIsoCz8GmDSDFS0pL1H
	CNeQsI5CqFZt8M2L/eqLkH9hcVD3V0TymWJKv+ydk9Xvc24cpLiTuYs4g92Y1LWoW8UctFiCp76
	LzXpHFP9EU2lKR+6z0RR7TzbHRIKrTF+lsFWDjgPcVTPUlaKkK2bheJT1Din5aE9zAFrQ5ymUvc
	bDkf0OSkqxG1E4sfpI/4CsXYo0kqM=
X-Received: by 2002:a05:7301:5795:b0:2ba:99d2:403a with SMTP id 5a478bee46e88-2bde1bacc2bmr1452026eec.10.1772220658494;
        Fri, 27 Feb 2026 11:30:58 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bded67cce6sm869667eec.6.2026.02.27.11.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:30:57 -0800 (PST)
Message-Id: <8af17ad83115882ed174434e566523cf0bc376d9.1772220640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 19:30:40 +0000
Subject: [PATCH v5 11/11] repo: refine path keys for repo info
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Rename path.git-prefix to path.prefix, add path.work-tree as an alias
for path.toplevel, and drop reflog/ref-file-oriented path keys.

This narrows the path surface to keys that are less tied to direct
file access while keeping tests and documentation in sync.

Also normalize prefix handling in repo_info context so path.prefix has
a stable empty-string behavior.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 Documentation/git-repo.adoc | 14 ++++-------
 builtin/repo.c              | 45 ++++++++--------------------------
 t/t1900-repo.sh             | 48 +++++++++++++++++--------------------
 3 files changed, 36 insertions(+), 71 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index b575977a4b..3d34c6edca 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -114,7 +114,7 @@ Here's a list of the available keys and the values that they return:
 `path.git-dir`::
 	The path to the git directory.
 
-`path.git-prefix`::
+`path.prefix`::
 	The path of the current working directory relative to the top-level
 	directory.
 
@@ -127,18 +127,9 @@ Here's a list of the available keys and the values that they return:
 `path.index-file`::
 	The path to the index file.
 
-`path.logs-directory`::
-	The path to the `logs` directory.
-
 `path.objects-directory`::
 	The path to the objects directory.
 
-`path.packed-refs-file`::
-	The path to the `packed-refs` file.
-
-`path.refs-directory`::
-	The path to the `refs` directory.
-
 `path.shallow-file`::
 	The path to the `shallow` file.
 
@@ -150,6 +141,9 @@ Here's a list of the available keys and the values that they return:
 	The path to the top-level working tree directory, or an empty string
 	for bare repositories.
 
+`path.work-tree`::
+	Alias for `path.toplevel`.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index ecd9d3aee5..9fbd13a358 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -109,10 +109,9 @@ static int get_path_git_dir(struct repo_info *info, struct strbuf *buf)
 	return 0;
 }
 
-static int get_path_git_prefix(struct repo_info *info, struct strbuf *buf)
+static int get_path_prefix(struct repo_info *info, struct strbuf *buf)
 {
-	if (info->prefix)
-		strbuf_addstr(buf, info->prefix);
+	strbuf_addstr(buf, info->prefix);
 	return 0;
 }
 
@@ -137,39 +136,12 @@ static int get_path_index_file(struct repo_info *info, struct strbuf *buf)
 	return 0;
 }
 
-static int get_path_logs_directory(struct repo_info *info, struct strbuf *buf)
-{
-	struct strbuf path = STRBUF_INIT;
-
-	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "logs"));
-	strbuf_release(&path);
-	return 0;
-}
-
 static int get_path_objects_directory(struct repo_info *info, struct strbuf *buf)
 {
 	repo_info_add_path(info, buf, repo_get_object_directory(info->repo));
 	return 0;
 }
 
-static int get_path_packed_refs_file(struct repo_info *info, struct strbuf *buf)
-{
-	struct strbuf path = STRBUF_INIT;
-
-	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "packed-refs"));
-	strbuf_release(&path);
-	return 0;
-}
-
-static int get_path_refs_directory(struct repo_info *info, struct strbuf *buf)
-{
-	struct strbuf path = STRBUF_INIT;
-
-	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "refs"));
-	strbuf_release(&path);
-	return 0;
-}
-
 static int get_path_shallow_file(struct repo_info *info, struct strbuf *buf)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -201,6 +173,11 @@ static int get_path_toplevel(struct repo_info *info, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_work_tree(struct repo_info *info, struct strbuf *buf)
+{
+	return get_path_toplevel(info, buf);
+}
+
 static int get_references_format(struct repo_info *info, struct strbuf *buf)
 {
 	struct repository *repo = info->repo;
@@ -217,17 +194,15 @@ static const struct field repo_info_fields[] = {
 	{ "path.common-dir", get_path_common_dir },
 	{ "path.config-file", get_path_config_file },
 	{ "path.git-dir", get_path_git_dir },
-	{ "path.git-prefix", get_path_git_prefix },
 	{ "path.grafts-file", get_path_grafts_file },
 	{ "path.hooks-directory", get_path_hooks_directory },
 	{ "path.index-file", get_path_index_file },
-	{ "path.logs-directory", get_path_logs_directory },
 	{ "path.objects-directory", get_path_objects_directory },
-	{ "path.packed-refs-file", get_path_packed_refs_file },
-	{ "path.refs-directory", get_path_refs_directory },
+	{ "path.prefix", get_path_prefix },
 	{ "path.shallow-file", get_path_shallow_file },
 	{ "path.superproject-working-tree", get_path_superproject_working_tree },
 	{ "path.toplevel", get_path_toplevel },
+	{ "path.work-tree", get_path_work_tree },
 	{ "references.format", get_references_format },
 };
 
@@ -378,7 +353,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	enum output_format format = FORMAT_KEYVALUE;
 	struct repo_info info = {
 		.repo = repo,
-		.prefix = prefix,
+		.prefix = prefix ? prefix : "",
 		.path_format = PATH_FORMAT_ABSOLUTE,
 	};
 	int all_keys = 0;
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index dcacf84cc3..2351b772b2 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -13,17 +13,15 @@ REPO_INFO_KEYS='
 	path.common-dir
 	path.config-file
 	path.git-dir
-	path.git-prefix
 	path.grafts-file
 	path.hooks-directory
 	path.index-file
-	path.logs-directory
 	path.objects-directory
-	path.packed-refs-file
-	path.refs-directory
+	path.prefix
 	path.shallow-file
 	path.superproject-working-tree
 	path.toplevel
+	path.work-tree
 	references.format
 '
 
@@ -31,17 +29,15 @@ REPO_INFO_PATH_KEYS='
 	path.common-dir
 	path.config-file
 	path.git-dir
-	path.git-prefix
 	path.grafts-file
 	path.hooks-directory
 	path.index-file
-	path.logs-directory
 	path.objects-directory
-	path.packed-refs-file
-	path.refs-directory
+	path.prefix
 	path.shallow-file
 	path.superproject-working-tree
 	path.toplevel
+	path.work-tree
 '
 
 # Test whether a key-value pair is correctly returned
@@ -172,12 +168,12 @@ test_expect_success 'path.toplevel is empty in bare repository' '
 	test_cmp expect actual
 '
 
-test_expect_success 'path.git-prefix matches rev-parse --show-prefix' '
+test_expect_success 'path.prefix matches rev-parse --show-prefix' '
 	git init path-prefix &&
 	mkdir -p path-prefix/a/b &&
 	expected_value=$(git -C path-prefix/a/b rev-parse --show-prefix) &&
-	echo "path.git-prefix=$expected_value" >expect &&
-	git -C path-prefix/a/b repo info path.git-prefix >actual &&
+	echo "path.prefix=$expected_value" >expect &&
+	git -C path-prefix/a/b repo info path.prefix >actual &&
 	test_cmp expect actual
 '
 
@@ -209,27 +205,27 @@ test_expect_success 'git-path style keys match rev-parse --git-path' '
 	git -C path-git-path repo info path.config-file >actual &&
 	test_cmp expect actual &&
 
-	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path logs) &&
-	echo "path.logs-directory=$expected_value" >expect &&
-	git -C path-git-path repo info path.logs-directory >actual &&
-	test_cmp expect actual &&
-
-	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path packed-refs) &&
-	echo "path.packed-refs-file=$expected_value" >expect &&
-	git -C path-git-path repo info path.packed-refs-file >actual &&
-	test_cmp expect actual &&
-
-	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path refs) &&
-	echo "path.refs-directory=$expected_value" >expect &&
-	git -C path-git-path repo info path.refs-directory >actual &&
-	test_cmp expect actual &&
-
 	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path shallow) &&
 	echo "path.shallow-file=$expected_value" >expect &&
 	git -C path-git-path repo info path.shallow-file >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'path.work-tree matches path.toplevel' '
+	git init path-work-tree &&
+	expected_value=$(git -C path-work-tree rev-parse --show-toplevel) &&
+	echo "path.work-tree=$expected_value" >expect &&
+	git -C path-work-tree repo info path.work-tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.work-tree is empty in bare repository' '
+	git init --bare bare-path-work-tree &&
+	echo "path.work-tree=" >expect &&
+	git -C bare-path-work-tree repo info path.work-tree >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'path.superproject-working-tree is empty when not a submodule' '
 	git init path-superproject &&
 	echo "path.superproject-working-tree=" >expect &&
-- 
gitgitgadget
