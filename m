Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9020377A94
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295102; cv=none; b=KGv25Ca1E5+X7CVR0cf2gPMyykf3EbtTAWD0jed4H1OJIkPdriBlKznSGhaa0zvb3XBH79GStcDQG54dmJYYmuRysKBtAuwvWWkcoz1/xhT1byww0nhlJC+BMPmmKGXaGg+KQk3pmVLlaQv6kkRqGKsWxLXJ8XsDKPUULY8FAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295102; c=relaxed/simple;
	bh=HW7s/iKJcFiYpIJ/oBWNUp5EVNoxeA8WOGBGzw+yC1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0rIKf+32d+7+8WyTAQoNGmDW+UTn/YHjFRgGnaaTpziPIlSg/Zm1sOwisiFxtXvuanA+AiHxohd59OghOVudqeaEW1ee+a+bsmOLb7MchY+avLW+iqKUK7HNvQHFuxezTGlZKkspgeSn2tTOEJjFeKiwyb8yndH/28NS/gy/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7bFOkX3; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7bFOkX3"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a378f187bbso2078250eaf.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784295099; x=1784899899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqLtY1pIMDFxHEBpyrjnsIsRQiasQFf0PmrhcaXPWv8=;
        b=Z7bFOkX3Y85uX00ZpKA2th9+TtzgIRsCDQI8HxGz8sj62oPM2Bvd5CihW/lTgVosYr
         Wn7HOs6w6trKbFYYu5kopF+9OqIiX8TWdYEv1RrqQj2d1xQeJZdRqKY2vmzwcApaVA7V
         kA2ya2WKvmL5zwrgEMMeEog6Ow+aKcUezNg+9k3iTxvUSGXKwgoQEeHG/m8Z2d88Vnwd
         xHCI2UZ2hWP8H++Ka/DHQ1ma6FNdzHRXAk6YyBtioauRu0EiE3E4MqpKUV2e4IT6yRE1
         lun7d4IQU/fv18iSdsh5GRqyal9kxrG2YQ/6XwClB7blDAMappXR/+wxRejSrLM+R4Ch
         0hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295099; x=1784899899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SqLtY1pIMDFxHEBpyrjnsIsRQiasQFf0PmrhcaXPWv8=;
        b=gefPW4JVkVgBvmu6CeTN1p0NtQhrwYYuhSZMj+HrkRPr3SKC3TcCcwWvPMOtqTStpy
         Kp1FuZQP1zSi9F39bYduFHmmfDz+tViG7Wi3GoBqaUDndO++N+MU5FXg3gda49O7rIzL
         a3YIIvq1PiIBqynnv8RNebN86176rCrBHstHpIeCbUOt7Y7iOcKAIRyhAkSXBle5WooC
         Z0nqXme06/x/ZWeG4QjKFSwy6he28SebAOCqCOu+NJu3izDFmogYDrE1ba538s2x8XJ7
         +xdn1ZNsdhuw4GwLpDuOuIWZv/n7yzkhNgunVk0mSRuA3iqWGihaozzzVL/zXKyBq0tl
         P/Fg==
X-Gm-Message-State: AOJu0YyWX80uUmqyrlwSsZ8Rmt5tsErz1KrNcGeGqvyIQxbpzVoCpq97
	Why83BlT18J4TtNXDwxdxrPJJw0MxdTnouP/7+IXLKmJXKdT6qvxTDvHUhK7Bw==
X-Gm-Gg: AfdE7cn0DZ7LRVTedzRnU9g8WBI17CoHikBjxYfacn2lxoogxn4cXS94UTWRLjFhfBB
	knFWhBafcA2/W4UL19M2/0IGcYXhkwxKhwwR5qdmAyr5bo5kJ96ynSiyiJcyK1yL2V4fHnMcQTy
	UxHDILJPEvbhOVIRv0zm7z7wVCuDmsPZgQi09vjOs7PrUBXjKOlXXj0LeyLStc0+U4Y2CBspgKj
	K1bWiq5zGwDR691LxwDnbF3DL+cqrb+rJQvLCRwHgF/8cpiJkwauqbAVxXde/TXO+IcEnFf/QLM
	oZj3C5m5EiHbUfNk2/+l43m64u5Fm/WRzHdziuHeLpe2ZHDBOznVme6a4N5HqrBwMaGYNcl0pgy
	zLuD5f1lcN0FTGgfHKDclZ62dx0rsDZFB1Cqn5nLV3aqjuxZjN6pWZng8To9iVV5qaQl6i+rYG1
	qT+4vjYFvzoHH17y74QXi5RU5dFj5q8BPoG153w3U/CiuwEhy+NTNDT8cZ5HvARTxBDn4DmGO6B
	KtqmIzy2ZGO
X-Received: by 2002:a05:6820:1509:b0:6a1:11a5:32df with SMTP id 006d021491bc7-6a53686b2acmr1057552eaf.50.1784295099166;
        Fri, 17 Jul 2026 06:31:39 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm7867411eec.30.2026.07.17.06.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:31:38 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v2 1/7] repo: add path.toplevel with absolute and relative suffix formatting
Date: Fri, 17 Jul 2026 19:00:09 +0530
Message-ID: <20260717133015.32040-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts frequently need to find the root directory of a repository's
working tree. Currently, this requires using `git rev-parse --show-toplevel`
or inferring it from other path components.

Introduce `path.toplevel.absolute` and `path.toplevel.relative` keys
to `git repo info`. This allows scripts to retrieve the top-level
working tree path in a predictable, strictly formatted manner without
relying on `rev-parse`.

If requested in a bare repository where no working tree exists, the
command returns an empty string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 28 ++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 30 ++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..e34abe5fea 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.toplevel.absolute`::
+	The canonical absolute path to the top-level directory of the
+	repository's working tree. Outputs an empty string if the repository
+	is bare.
+
+`path.toplevel.relative`::
+	The path to the top-level directory of the repository's working
+	tree relative to the current working directory. Outputs an empty
+	string if the repository is bare.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 042d6de558..194757eb18 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -121,6 +121,32 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree) {
+		strbuf_addstr(buf, "");
+		return 0;
+	}
+
+	format_path(buf, work_tree, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_toplevel_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree) {
+		strbuf_addstr(buf, "");
+		return 0;
+	}
+
+	format_path(buf, work_tree, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -137,6 +163,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.toplevel.absolute", get_path_toplevel_absolute },
+	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index ae8c22c817..fbb9063ee5 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,4 +213,34 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.toplevel absolute and relative' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		mkdir -p repo/sub &&
+		cd repo/sub &&
+
+		ROOT="$(test-tool path-utils real_path ..)" &&
+
+		echo "path.toplevel.absolute=$ROOT" >expect.abs &&
+		git repo info path.toplevel.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.toplevel.relative=../" >expect.rel &&
+		git repo info path.toplevel.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.toplevel returns empty in a bare repository' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+		echo "path.toplevel.absolute=" >expect &&
+		git repo info path.toplevel.absolute >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.55.GIT

