Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50CA3976A0
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680792; cv=none; b=JVKOGCGUD1EtSuAMZzQzVOOQmYwLyp37OzkXIQT0xrzjGIvtM3GBnbwhFnVm3NLGoKYLxEtKw8fnOAeDoKekE003pVmvcX+zRkNiipU7aVxYanC/MOLXmHlUbSbO/8EWEqpGPcDI95F4MzbGLaILXmrp+w0s+Ei9THdm2mn5t7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680792; c=relaxed/simple;
	bh=eINptiEh0HEgBrHo5vogclRzSwd9RuBh7zwDy4QeSe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZ+ucZP/g7w+Ls2rQawzNX1swroOd7pfpV2JV6MqOuafICif9AAYzqbkyxrTEZZH003uli8NfGjPUGzu9AO/j+VI7MKRzCn0vrF5bgRH0z1q4TIQbN+cr5q1Bdt8/VtTXXlrwaRu8+uDQ4Bjpl2gfoBJ+mbB849rQ7J0nOEp7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJg1Jiq/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJg1Jiq/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cace91f112so2051295ad.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787680789; x=1788285589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SxSJKRRZHo38ev0TfyUAZr4zl6AYoUU8UwlROA5fxPY=;
        b=eJg1Jiq/n10TZ1QF4RChaTUQw4kdYxjRY3gGMDMd0U8+IR0N+cZMgJCG9WaqDtHHaG
         lJMQj/KNyvAk/mRjVQq4UFfdqzdEIoYuHBXmZR2anK8NkR3VNEVpCcbpMnOB+hPj7fNk
         +h/4a3+PzWE/tamstqaVPZmB8xuIU7temxu7ef8/nUsUHAV8AfFKCSx98YL7ZjRTF1Os
         s10neff6xDNGaUamZwHYbPouyiIe9SpRpd0hSJM25VfXR2fCULey6A7GbhaTWHUpOMaZ
         JJs893KX27PWRKCPCcJtG5odgGO2ZJDs4ZmD1BSYA3XCwV8BBGAaBa55jPJ2pS8VHptU
         79Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680789; x=1788285589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SxSJKRRZHo38ev0TfyUAZr4zl6AYoUU8UwlROA5fxPY=;
        b=JY4vGLJ9dzZ2y0tVwwLGT8p91Vz91xH2A1CQ9X7HlEoYbEiSGF8UxF31lJaTFHlafr
         U72nua+Gq3FN23CSlBCbm8g7VNEP7ceGKwJOa0pt535Ob/vSoVy01IFxND9oiPnwmyfJ
         GOX7KUn21MsiF1iF2G53ZLJw/Z0GJloShFqkbrNwtEu9dYxTCIGD7XsMn153ePyjo1Zw
         sI01aZWdu/npHvApsMLBDo5G3pnwP6IoX/HdTCtZ+QNHqVSZxjChsYa6+7yr9CNWt+0l
         q4kjkXmAAlAHotgFdxZFrDVkEsLee1ySznnE3VKq49jYIGJbeZwm2ZIaDKu1IMMQ0ffr
         HsSg==
X-Gm-Message-State: AFuF++kPvK+PxRm0WYrTCo930NPkjDRbmz5IFsykl+yJ1uf430gMPbIP
	lV/CTSs7OGqw42WSfumW/pQTqtNMQ452Ll0dgbEls4eMjDuQeA40vj/f
X-Gm-Gg: AR+sD119crhVrsLiFzejh5wrGxzJNIsRsZNYsyljuxcVzRzO1kFfkdcbGjir/hcKwdO
	vMX8vWGbDdgXqLARvzPRZjSBXc7VGTSmW//+Ecq4FI6xMMDPj/hdfylV66wPzavlLob66Xxkaok
	BL3dsovWhRgpIyIKwq+TdKoaoI1J1WR6vOaYmg7xmYeTgn5/iMoxqkaaqTHlqK3crfWfPwO5V4/
	PjQ8OOmjkY3y2NXSc+vVfDjs26SCETapBcw6pUcOo7YFMSFQ7CKx5rUrgVnf4T/C36N2NXmEjgU
	WdKzFH2elxPzaSN/RDDYx7y+MRFB/B6ZpZ0OyXUlQ2MNMj3QdRxWwv3v9ziOrprtU9KKMrzSWbF
	ZbSyXXo4sBBtmSB6UH9uFHs4guwHX8HAUr9EbidRW1spoghIx2UZS/U/3r8Ge4F7txr6IsUmGkP
	qM2grMkmu4FBfsp19LEy+bq81OkD/M26MGtoLVY4Nt3NiWvMotvCTlI1bGOrZJHi26ThBsYhZUi
	kEsWjXNdSWQeSMmcw+qmGUS823cSDvJv+5AgFuPLxrwJr/Tja335EZmM+t8tg7X2ONM1tg=
X-Received: by 2002:a17:90a:e70f:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-3966d4587b7mr1902179a91.12.1787680789169;
        Tue, 25 Aug 2026 10:59:49 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8e118fasm954417c88.0.2026.08.25.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:59:48 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v5 4/7] repo: add path.index with absolute and relative suffixes
Date: Tue, 25 Aug 2026 23:28:15 +0530
Message-ID: <20260825175818.645579-5-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The repository index is a fundamental component used by Git and related
tooling to track the working tree state. Scripts that interact with the
index currently retrieve its location by invoking
`git rev-parse --git-path index`.

Introduce `path.index.absolute` and `path.index.relative` keys to
`git repo info`. This exposes the index file location as a scriptable
config-like key using standard format rules, allowing scripts to
retrieve it through the same interface as other repository path
information.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 12 ++++++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 20836cf8f6..08ef47750c 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -128,6 +128,18 @@ values that they return:
 	The path to the repository's hooks directory relative to the current
 	working directory. Respects the `core.hooksPath` configuration.
 
+`path.index.absolute`::
+	The canonical absolute path to the repository's current index file.
+	Respects the `GIT_INDEX_FILE` environment override. Returns the
+	configured index path even if the repository is bare or the file does
+	not exist.
+
+`path.index.relative`::
+	The path to the repository's current index file relative to the current
+	working directory. Respects the `GIT_INDEX_FILE` environment override.
+	Returns the configured index path even if the repository is bare or the
+	file does not exist.
+
 `path.superproject-root.absolute`::
 	The canonical absolute path to the working tree root of the superproject
 	if the current repository is an initialized submodule. Outputs an empty
diff --git a/builtin/repo.c b/builtin/repo.c
index d7c451a771..2a15327094 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -142,6 +142,28 @@ static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_index_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *index_file = repo_get_index_file(repo);
+
+	if (!index_file)
+		return error(_("unable to get index file"));
+
+	format_path(buf, index_file, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_index_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *index_file = repo_get_index_file(repo);
+
+	if (!index_file)
+		return error(_("unable to get index file"));
+
+	format_path(buf, index_file, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
 {
 	struct strbuf superproject = STRBUF_INIT;
@@ -210,6 +232,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.hooks.absolute", get_path_hooks_absolute },
 	{ "path.hooks.relative", get_path_hooks_relative },
+	{ "path.index.absolute", get_path_index_absolute },
+	{ "path.index.relative", get_path_index_relative },
 	{ "path.superproject-root.absolute", get_path_superproject_absolute },
 	{ "path.superproject-root.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 1da5db4942..431a4842d4 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -237,6 +237,29 @@ then
 		'git config core.hooksPath /dev/null'
 fi
 
+test_repo_info_path 'index standard' 'index' '.git/index'
+
+test_repo_info_path 'index with GIT_INDEX_FILE override' 'index' \
+	'custom-index-file' \
+	'GIT_INDEX_FILE="$ROOT/custom-index-file" && export GIT_INDEX_FILE'
+
+test_expect_success 'path.index in a bare repository returns default index location' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+		ROOT="$(test-tool path-utils real_path .)" &&
+
+		echo "path.index.absolute=$ROOT/index" >expect.abs &&
+		git repo info path.index.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.index.relative=index" >expect.rel &&
+		git repo info path.index.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_expect_success 'path.superproject-root absolute and relative' '
 	test_when_finished "rm -rf sub super" &&
 	git init sub &&
-- 
2.55.GIT

