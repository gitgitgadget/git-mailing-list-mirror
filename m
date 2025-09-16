Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C926D528
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 00:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983082; cv=none; b=EwUVxBsejAchuVpPxxB4KkG4qL38yvLCgKYs6V0iAjNAgpRYIafFEDy5M3DWH/R/w+7nUfPbLdl2+arAfVd13q6jhOHkvFhO2dTuIrt/2TtL3pnai9dkehCtK2Qfw6ZzyhATz6BkFp1pHz4512wnmo8IqxEbFtOBYz4kJ5Tfgqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983082; c=relaxed/simple;
	bh=OYZesGU69TCrmc8C7LsWP9oiBeW9pras7UVri653YW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4LmJFWUHKlM9mF3lUXlO3yFMBN3ZtAzqsN4dPk1fvdeRGAkEATTGiWVC9cuCibU+4MRfgOYzj6LPalpas5feOVVmK6gwByc+9q0bv9LQD4g64YCndQ8Ppc9QNT9Vk7+gJ5ylApdW+BvdSgX1TMMgF+DSs5Qktz4w7r0kI3yTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGowUXFV; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGowUXFV"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so2901585276.1
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 17:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757983079; x=1758587879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BAnUM6uWRFsLysAvFgtdEjjtrUyTY9OdK31eMlTN9I=;
        b=HGowUXFVmXA46ndAqSFI8ObI5BVltUG2mAxKEO1BrbzmPRDxiJw0Nriyq496qsDds8
         Xw43PpzjEbM9+Hx/D/2nudTBpLWDu4ImqHilr11zpjjDzCmRURKJa7UEspnL7+AD9QoQ
         b/IJKSRjVKu3s+qR1H8Ke+posItDnYbgD9T4MoYvo19rqcAbAzM+uwJSddVvQv1X/KF9
         Ih6MCEisNVBONH2mkSIJhSWcSKnpABBWjzunj9g213v7ZMTy+goOz+PrF4hRtJ5Oz0il
         CBMFrIjegyHszcRizQFrHyXqhzJAKR38mbJCKTtxxlPkdvnCH3JiQcFzxgT9ZBjlLFII
         1HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757983079; x=1758587879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5BAnUM6uWRFsLysAvFgtdEjjtrUyTY9OdK31eMlTN9I=;
        b=QfF4idU6jYJWEH5AFV9Oykqflc627V08PHqsY9SEOc5cDVdrrUuXaTyF9YRUyWggN/
         b55R0vN485aPDtH/JvaTP6O30++AKtrIl833JLTCPRF1B3LxsZjnLmfFF4kfX5rbV718
         biuAnO60BEbtLmNkOMjBj4C9B1JCtMGrv0XH11vm/BjUmkHrvH0ErBG2eiAyZW/K5O58
         W0S9TKw5zoAHQTmwv0I+xMV/ir5AdKO4sONUJAAoxGqKf7sp25t/NhnLbp+/u/GMixKj
         HsWd8DgTcA6E6L4/te+lJJzBlDjejNFgQh/5n0QjyFpwnfrB8M31gmXJBA+sP3t9/6Tu
         8nTg==
X-Gm-Message-State: AOJu0YxezYE0K6lQof5w5P0CEq9YzzkxdEzE8rXOa16rZVluzu6siC0/
	c+Qt+p2u8lV5Aou1lrPBY/bWnD8LholDEnsqnbg5nBT9R8YandNgGhaGitLTy4uq
X-Gm-Gg: ASbGncsbCuiMwhoQLt5MRC7VqHU9mtxik8rXhx8qHEenK+IHoxloGTpbMXY+lijlqEU
	AF8cb/3lu1kRxC5C2cRKMlPQDvBRw3mpG1owNuUsWaoZpfsmc47jWiUN56SL8teday62Y/3Nrbx
	ct5qANHDcr8kftz36V3lMtnJZS6OTyFd3jnuw7GnFzsVFKv6TYr2IgyplqzNvynRPf2eAQLqAwh
	RacjsKrgK5HFtBJONHRssn3IUPd9M7wduJMzj+5ab+j1Z1QVMUH3/qYU/MV9oyiUhGkPZT7DTGK
	Z3iS9Zyai3KC5RyWQ8FGkrDCRM7qZcQVeNJIviQdovVSMkIzx/KOx0I4jEqqWeBxnmSIkEGUjRG
	Mxrwmnuq+YA1VqLk3qOAPRlHy9K5QOnGLiWAmfMJC2oSgTvjrnDomBwMETFrg52irPg==
X-Google-Smtp-Source: AGHT+IEA0ii72FTlexdGI1ZKFDuzalkMblqGwUkQTgne8oehkmnWgVmPeAWxd+lYR79chb5A1ezMQA==
X-Received: by 2002:a05:6902:f89:b0:e8f:eb74:24b7 with SMTP id 3f1490d57ef6-ea3d9c9cd4cmr12336144276.49.1757983078763;
        Mon, 15 Sep 2025 17:37:58 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:6545:4857:11f:cd8a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3feaeeab8sm2333167276.5.2025.09.15.17.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:37:58 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Glen Choo <glencbz@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 4/4] stash: honor stash.index in apply, pop modes
Date: Mon, 15 Sep 2025 20:37:37 -0400
Message-ID: <585e124467dcb1ec1de71fa72e749140d44dc367.1757982870.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757982870.git.ben.knoble+github@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com> <cover.1757982870.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With stash.index=true, git-stash(1) command now tries to reinstate the
index by default in the "apply" and "pop" modes. Not doing so creates a
common trap [1], [2]: "git stash apply" is not the reverse of "git stash
push" because carefully staged indices are lost and have to be manually
recreated. OTOH, this mode is not always desirable and may create more
conflicts when applying stashes. As usual, "--no-index" will disable
this behavior if you set "stash.index".

[1]: https://lore.kernel.org/git/CAPx1GvcxyDDQmCssMjEnt6JoV6qPc5ZUpgPLX3mpUC_4PNYA1w@mail.gmail.com/
[2]: https://lore.kernel.org/git/c5a811ac-8cd3-c389-ac6d-29020a648c87@gmail.com/

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/config/stash.adoc    |   5 +
 builtin/stash.c                    |   9 +-
 t/t3903-stash.sh                   | 155 +++++++++++++++++++++++++++++
 t/t3904-stash-patch.sh             |  11 ++
 t/t3905-stash-include-untracked.sh |  48 ++++++++-
 5 files changed, 225 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/stash.adoc b/Documentation/config/stash.adoc
index ec1edaeba6..e556105a15 100644
--- a/Documentation/config/stash.adoc
+++ b/Documentation/config/stash.adoc
@@ -1,3 +1,8 @@
+stash.index::
+	If this is set to true, `git stash apply` and `git stash pop` will
+	behave as if `--index` was supplied. Defaults to false. See the
+	descriptions in linkgit:git-stash[1].
+
 stash.showIncludeUntracked::
 	If this is set to true, the `git stash show` command will show
 	the untracked files of a stash entry.  Defaults to false. See
diff --git a/builtin/stash.c b/builtin/stash.c
index d9b478d1d1..8a0eef3c70 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -130,6 +130,7 @@ static struct strbuf stash_index_path = STRBUF_INIT;
 static int show_stat = 1;
 static int show_patch;
 static int show_include_untracked;
+static int use_index;
 
 /*
  * w_commit is set to the commit containing the working tree
@@ -662,7 +663,7 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
 {
 	int ret = -1;
 	int quiet = 0;
-	int index = 0;
+	int index = use_index;
 	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
@@ -759,7 +760,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix,
 		     struct repository *repo UNUSED)
 {
 	int ret = -1;
-	int index = 0;
+	int index = use_index;
 	int quiet = 0;
 	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
@@ -864,6 +865,10 @@ static int git_stash_config(const char *var, const char *value,
 		show_include_untracked = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "stash.index")) {
+		use_index = git_config_bool(var, value);
+		return 0;
+	}
 	return git_diff_basic_config(var, value, ctx, cb);
 }
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b8936a653b..1d53a94165 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -111,6 +111,19 @@ setup_stash()
 	test 1 = $(git show HEAD:file)
 '
 
+test_expect_success 'apply stashed changes with stash.index' '
+	test_config stash.index true &&
+	git reset --hard HEAD^ &&
+	echo 5 >other-file &&
+	git add other-file &&
+	test_tick &&
+	git commit -m other-file &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 2 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
 test_expect_success 'apply stashed changes (including index)' '
 	git reset --hard HEAD^ &&
 	echo 6 >other-file &&
@@ -150,6 +163,21 @@ setup_stash()
 	test 1 = $(git show HEAD:file)
 '
 
+test_expect_success 'drop top stash with stash.index' '
+	test_config stash.index true &&
+	git reset --hard &&
+	git stash list >expected &&
+	echo 7 >file &&
+	git stash &&
+	git stash drop &&
+	git stash list >actual &&
+	test_cmp expected actual &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 2 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
 test_expect_success 'drop middle stash' '
 	git reset --hard &&
 	echo 8 >file &&
@@ -170,6 +198,27 @@ setup_stash()
 	test 1 = $(git show HEAD:file)
 '
 
+test_expect_success 'drop middle stash with stash.index' '
+	test_config stash.index true &&
+	git reset --hard &&
+	echo 8 >file &&
+	git stash &&
+	echo 9 >file &&
+	git stash &&
+	git stash drop stash@{1} &&
+	test 2 = $(git stash list | wc -l) &&
+	git stash apply &&
+	test 9 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file) &&
+	git reset --hard &&
+	git stash drop &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 2 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
 test_expect_success 'drop middle stash by index' '
 	git reset --hard &&
 	echo 8 >file &&
@@ -236,6 +285,17 @@ setup_stash()
 	test 0 = $(git stash list | wc -l)
 '
 
+test_expect_success 'stash pop with stash.index' '
+	test_config stash.index true &&
+	git reset --hard &&
+	setup_stash &&
+	git stash pop &&
+	test 3 = $(cat file) &&
+	test 2 = $(git show :file) &&
+	test 1 = $(git show HEAD:file) &&
+	test 0 = $(git stash list | wc -l)
+'
+
 cat >expect <<EOF
 diff --git a/file2 b/file2
 new file mode 100644
@@ -328,6 +388,22 @@ setup_stash()
 	test_must_be_empty output.out
 '
 
+test_expect_success 'pop -q works and is quiet with stash.index' '
+	# Added file, deleted file, modified file all staged for commit
+	echo foo >new-file &&
+	echo test >file &&
+	git add new-file file &&
+	git rm other-file &&
+	git stash &&
+
+	test_config stash.index true &&
+	git stash pop -q >output.out 2>&1 &&
+	echo test >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
+	test_must_be_empty output.out
+'
+
 test_expect_success 'pop -q --index works and is quiet' '
 	echo foo >file &&
 	git add file &&
@@ -1178,6 +1254,19 @@ setup_stash()
 	test_path_is_file bar
 '
 
+test_expect_success 'stash -- <pathspec> stashes and restores the file with stash.index' '
+	test_config stash.index true &&
+	>foo &&
+	>bar &&
+	git add foo bar &&
+	git stash push -- foo &&
+	test_path_is_file bar &&
+	test_path_is_missing foo &&
+	git stash pop --no-index &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_expect_success 'stash -- <pathspec> stashes in subdirectory' '
 	mkdir sub &&
 	>foo &&
@@ -1194,6 +1283,24 @@ setup_stash()
 	test_path_is_file bar
 '
 
+test_expect_success 'stash -- <pathspec> stashes in subdirectory with stash.index' '
+	test_config stash.index true &&
+	rm -r sub &&
+	mkdir sub &&
+	>foo &&
+	>bar &&
+	git add foo bar &&
+	(
+		cd sub &&
+		git stash push -- ../foo
+	) &&
+	test_path_is_file bar &&
+	test_path_is_missing foo &&
+	git stash pop --no-index &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_expect_success 'stash with multiple pathspec arguments' '
 	>foo &&
 	>bar &&
@@ -1209,6 +1316,22 @@ setup_stash()
 	test_path_is_file extra
 '
 
+test_expect_success 'stash with multiple pathspec arguments with stash.index' '
+	test_config stash.index true &&
+	>foo &&
+	>bar &&
+	>extra &&
+	git add foo bar extra &&
+	git stash push -- foo bar &&
+	test_path_is_missing bar &&
+	test_path_is_missing foo &&
+	test_path_is_file extra &&
+	git stash pop --no-index &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	test_path_is_file extra
+'
+
 test_expect_success 'stash with file including $IFS character' '
 	>"foo bar" &&
 	>foo &&
@@ -1224,6 +1347,22 @@ setup_stash()
 	test_path_is_file bar
 '
 
+test_expect_success 'stash with file including $IFS character with stash.index' '
+	test_config stash.index true &&
+	>"foo bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash push -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	git stash pop --no-index &&
+	test_path_is_file "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_expect_success 'stash with pathspec matching multiple paths' '
 	echo original >file &&
 	echo original >other-file &&
@@ -1312,6 +1451,22 @@ setup_stash()
 	test_path_is_file bar
 '
 
+test_expect_success 'stash without verb with pathspec with stash.index' '
+	test_config stash.index true &&
+	>"foo bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	git stash pop --no-index &&
+	test_path_is_file "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
 	git reset &&
 	>foo &&
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index ae313e3c70..fe402f6ab5 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -42,6 +42,17 @@
 	verify_state dir/foo work head
 '
 
+test_expect_success 'git stash -p with stash.index' '
+	test_config stash.index true &&
+	set_state HEAD HEADfile_work HEADfile_index &&
+	set_state dir/foo work index &&
+	test_write_lines y n y | git stash save -p &&
+	git reset --hard &&
+	git stash apply &&
+	verify_state HEAD HEADfile_work HEADfile_index &&
+	verify_state dir/foo head index
+'
+
 test_expect_success 'git stash -p --no-keep-index' '
 	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state bar bar_work bar_index &&
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 7704709054..5407f11030 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -7,7 +7,7 @@
 
 . ./test-lib.sh
 
-test_expect_success 'stash save --include-untracked some dirty working directory' '
+setup() {
 	echo 1 >file &&
 	git add file &&
 	test_tick &&
@@ -23,6 +23,10 @@
 	git stash --include-untracked &&
 	git diff-files --quiet &&
 	git diff-index --cached --quiet HEAD
+}
+
+test_expect_success 'stash save --include-untracked some dirty working directory' '
+	setup
 '
 
 test_expect_success 'stash save --include-untracked cleaned the untracked files' '
@@ -108,6 +112,32 @@
 	test_cmp untracked_expect untracked/untracked
 '
 
+test_expect_success 'stash pop after save --include-untracked leaves files untracked again with stash.index' '
+	git init repo &&
+	test_when_finished rm -r repo &&
+	(
+		cd repo &&
+		git config stash.index true &&
+		setup &&
+		cat >expect <<-EOF &&
+		MM file
+		?? HEAD
+		?? actual
+		?? expect
+		?? file2
+		?? untracked/
+		EOF
+
+		git stash pop &&
+		git status --porcelain >actual &&
+		test_cmp expect actual &&
+		echo 1 >expect_file2 &&
+		test_cmp expect_file2 file2 &&
+		echo untracked >untracked_expect &&
+		test_cmp untracked_expect untracked/untracked
+	)
+'
+
 test_expect_success 'clean up untracked/ directory to prepare for next tests' '
 	git clean --force --quiet -d
 '
@@ -221,6 +251,22 @@
 	test_path_is_file bar
 '
 
+test_expect_success 'stash push with $IFS character with stash.index' '
+	test_config stash.index true &&
+	>"foo bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash push --include-untracked -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	git stash pop --no-index &&
+	test_path_is_file "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_expect_success 'stash previously ignored file' '
 	cat >.gitignore <<-EOF &&
 	ignored
-- 
2.48.1

