Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5F43F8246
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011662; cv=none; b=t5pO5EJWQqkz5QImECJXxW968Z3OZhqBq9jvtitGOCMWje88qyuj27f7phhjBnqjOLAtVWYlRtj4agI3sU3SUkrlu0jd75fWl5x8lFXJsUvCWtRpLl6FVgP56a0M5uRbnbh1b/t+zAXxnW98l/D7CvyBb42YrBBaO/niO5wnW30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011662; c=relaxed/simple;
	bh=fe7+oKPtpBQ/vCfnOroilLNTMOY+si7QCnmfJ0W5FQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RH4SWH8rHziFgrUu1p/viqNtzyNK+VjeTEWFwvDdWAEhjHqgYm/VcXjZGZBE4sXn1wKrjRMTSiFEXSzfhA3476KcZshPx9ZuymvdTIFariMNxN/ZvzFrtH4PYxzBuEPhyF2iF2kO6mLsPiAT33E+lt5e40vlpvEoVkqbeCn2pbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FchKr17f; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FchKr17f"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf50c6f235so24600865ad.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011660; x=1786616460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ku4QfXZxvsi5Mw/JwJW1bggO/MqZJQzRT8QMxmkn9i4=;
        b=FchKr17fsmW4mtH5F7eAGIBR5vWkmkJFZrAr5mmCmMuqDamDDVHMS8Y8IwLwo6ZrHe
         eEzHkCNmLyrkvGA4+6CO33ch+4RKuM8k81Y/T8jGTcnv6IYe8EuzDkPcUW3Po19B5xqF
         KcWckQ29SFssKXOchd+75e+eSvNwQuXoB1O7UaoQTSiFo+kF79Flf+wsQ2jwV7dR9gWy
         TLtZbIq1sLNnV0Yvt93T2y+kIgICB3jFO5tKtz/5mDjWlmLCNnMeyX9HFHbnLEFPWDC1
         BKLFP6bATneFxva2wVbcuecW4SUHzLPm/iY5VnzSFPJ5tR1YMelDn5W0aWnagePhYW5W
         05/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011660; x=1786616460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ku4QfXZxvsi5Mw/JwJW1bggO/MqZJQzRT8QMxmkn9i4=;
        b=FIYh8zmedDeY1H3V0snploJCCOBn8ZRoKDKHgVs+KHCfkANQCi3htTJFulh3to7RlF
         qgMGe6Df2Yk4gZobemdCx/rj/kjf8VMhEXx3RosEuF8bij+3b3YbGCiabdLiWHIuhAHk
         Z530ME3zffFcHYFciHvWEmOb0Bs6bzAe/EvsvnT036yINQ9PohlMjaUik+Qy+qGC35WC
         CpLUg3bFvl3mzqh8Ba4FQdb2KUK/TdiT8dQZKI8OkbkS8c9xAc1B82OUrqUfi1hoUvtO
         /Xcpq+FgdrHSai/c8bzDU3JmU19Hy4BQQBnZizBQrK/IwX+oH3GeXwEkcrmdszYmuTOx
         3xxQ==
X-Gm-Message-State: AOJu0YyYIrlNjXivtFDXJbKxZb9PyR8+c+E77FYH+3SddqwL+jlTj6fU
	m0QfrNLP4CZEW1ORWZEOHN+Rr8ml+vMry6Z5quZAhqalXQGyqKoEyZSp
X-Gm-Gg: AR+sD13d9SZBYr0O228l7MSxChaOhN/JZIIA5FBRqKi17LO4OYHzIOc3JO5nj8tBDpU
	vmEodk/zsSgU1Vk7QQwJjuXohyOkQGPD8UVWzefijdflxmbpAwwA9oBuZ4SPEU8lL/V02Jk/Ivi
	DxnRP6iXCvQqmSYIh6Fz04Fh8555Im4SznTk6prFyECOb5WVdMAErFigYbxprkdj05DpzqvHWBO
	tMsRJUT7Ffxq8kckuHRZyx+0DSiQwmaGBxg9I/cAEvWc0mD8sHsrbm+sFUEoCSWYqJa65tbzYdU
	s7F3KePCsTS2I3RByce52XFe5DVS9WDEk3s3qfRVckIlRCxlfZwlnhx0uXgq+JGjwhjX3PQMt7M
	OBKcjZAmSV+W6mYrWDLqr0ErGaQBgJa0lbfyJ+O+zxBCs5Pr/PbJu0ooZ1L1Rc9JfhC3AAz3kOP
	HEMyglmIUkIOIhv4LU39jJaLeRdzm76748bUDSP9Ux2vnA0gpei1KPp/272mTN9buFjn68oEwx2
	KYJY5vq0tD9fo6pgP8EUrdNcsJViiAOX5XdF1VWsN8MQnA63h/rabXX8sXbGXTbYIWBQ44=
X-Received: by 2002:a17:903:4688:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2d0ca7fbc9amr174236955ad.10.1786011659989;
        Thu, 06 Aug 2026 03:20:59 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b76cfsm25525901eec.4.2026.08.06.03.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:20:59 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC PATCH v4 1/7] repo: add path.toplevel with absolute and relative suffix formatting
Date: Thu,  6 Aug 2026 15:45:50 +0530
Message-ID: <20260806101556.162940-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts frequently need to find the root directory of a repository's
working tree. Currently, this requires using `git rev-parse --show-toplevel`
or inferring it from other repository information.

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
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

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
index 84e012f83f..c31e9cfa70 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -121,6 +121,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree)
+		return 0;
+
+	format_path(buf, work_tree, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_toplevel_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree)
+		return 0;
+
+	format_path(buf, work_tree, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -137,6 +159,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.toplevel.absolute", get_path_toplevel_absolute },
+	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index c85d390f43..9417d1ab65 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,4 +213,39 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
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
+test_expect_success 'path.toplevel absolute and relative in a bare repository' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+
+		echo "path.toplevel.absolute=" >expect.abs &&
+		git repo info path.toplevel.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.toplevel.relative=" >expect.rel &&
+		git repo info path.toplevel.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_done
-- 
2.55.GIT

