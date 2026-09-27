Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8636A34F
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509508; cv=none; b=jhL6uEZfmqRjLrPTWkvTAb4tHsm2qgIA5oVUs8D4s4+zbk3c9xSXbhyhXpk5bIJ6HFSjyqqpS6yPKpwlJR+dGJVZL0vuipau5TJeYtHXavMTR4kpkg/TtEFM/7TyR9Ut7ReEkiGfKJugLSa6f5tBo8wa5IXn7zuHHlYAwI5umKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509508; c=relaxed/simple;
	bh=RjAXzPY7fFTZlsb8MVZl1kXOBNo5QuhufM8STTsn2Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/+NE2gPF9h2OUzRTipsYvtRXuvfkerXzQXjlDeu4Ag8+cHJ81zpqyYuKeDR96v0wQwPbIXGlCLqYVtLmUVFJ/gghMqiR2ofraBwlUl1Auz/3aM95M0aS7IvpeBeCY6XUvytXSDdwbM0txrcB/r7C5g91zfpoHEjQL/qxXrmk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pi9X1FJo; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pi9X1FJo"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so1929466c88.2
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 04:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790509506; x=1791114306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4wgBgVj3MUo1VDPUzvH+Fz+Ph4snb/XERY/7VuHoEYk=;
        b=pi9X1FJo/jG93mAIxNwVZtc9qRA6vDWMq9sMbZg2+c1dRQRivtJrYf2tcM0Q+/JIJE
         8M7Jiiq3ujDTz1dsA4It4G1bjvUj/mxgh2xXB7Ks8oXLtHFs6ORFySwvpfj08GYJKReX
         3kwm7y7CibsElQlMyO1+oFSZjDpso0bp8QtdoNkOqh+/VZshndPY4q2J1xTuzF1LNnGV
         cZ3JEAM0GQfsk30NlKdDg6ApZDh2vyjOXi8TdeL3mcTbaz5eKdQupvZpAO7tilyhIJYU
         d9fD3ufK8/mpQM23FlEs/4n3hZi4gGqD9j+lD8j0MDxktIi3m4AyO6bb8oMy3ayLpctk
         UZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790509506; x=1791114306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4wgBgVj3MUo1VDPUzvH+Fz+Ph4snb/XERY/7VuHoEYk=;
        b=IeheEINeAYS+N6GgJ8sEyt5ntuQKBGB1WZ11ftF7562E8lYcBZFB3iev+hoiomc9EC
         Le05rSAvzC8dJ7n/ha6QFOzmItNgVjMtWveTOhzUGmSgFPZQksUcVgXFPKw6/I1USKDz
         jCh4/EYGqTTH1dp19j55Ra1hW+ZTVbZ5HAnBJGv6xOcI6EEC3iU+srQE1V9z2/A9MtKQ
         kT2eSJMxQvWsMYllrzNvpryHpNZ/9E8X49TiP+19paSQzl8jrHrExReF2dbLPJEq9cry
         SDHmMquphDjqf3YfmXDlyt5kU7tFlUSvHf+8fnOF97WI5PYduntIuGtPtVNlay6biVoC
         QTQA==
X-Gm-Message-State: AFuF++nt+PnWBJWXnvg9J/ZZNNGHNXS7FnVPgWyOVdnBK2kliSYp6N11
	LSfD7WYP9SLo2Oiuxdgm7l02WF8ZtkUO4qadyQJkT4rP2aDAI3r2oIu7
X-Gm-Gg: AYBFou1fK0ZZ3ENK5xdUAFW5LUmhOHOPGzE5DFKJJUCyAJHj50Kcrv8OhqhM6HUF6OD
	2snz1+TE8+QnQ2s687U/nCTvXzxKjb/V1NN725SY2ptt4JhZDBGFm1ArBpv0OzdY7IKnlzscWdO
	ibpMOt1W6Z6l8AtaNU0aQ5zBm91FDKldwAtAgC/CQndSYUurXBzKMnjEOV+GwiloQM1V+zJ6b98
	CSicApmCdWPlJn2qxP1EytncfPaDnlh+1vqY9M7T2vyFgPmo08AXcV/DJcs+YusU2Qjxh0lqGNz
	Tk4esEwOS73mfliIdUFLqFINYuiZPTrFEH/kPbwuNNxeHfzQIs7P3No+qtgqi93NDVpFMQl7Lzv
	DkmIDfJ+OmtUezz8XKmVv04A5+nOu0zVEDXMcwq86tQIQXblnOf8JsgU0T48sa8qx4ua3cmjM/z
	22bRd5m/1aSkgyuqT8hL3cw+PxRHS4Xg6y27G/ILCkmb+ZZYnKO9SFnIyAvSkBv4ZhUG8ghvsa7
	7c0phE60BCsJUQHkGkQdPHWMeanGDFYG09xlL8DVQdxtvrEqnkmRNUgTmAyzB8ph+UPjrQytPWa
	y/+/
X-Received: by 2002:a05:701b:418f:20b0:143:2719:566e with SMTP id a92af1059eb24-146d077cfe5mr5976129c88.42.1790509505209;
        Sun, 27 Sep 2026 04:45:05 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm17450424c88.0.2026.09.27.04.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 04:45:04 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v7 1/8] repo: add path.toplevel with absolute and relative suffix formatting
Date: Sun, 27 Sep 2026 17:14:13 +0530
Message-ID: <20260927114420.59724-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.56.0-rc2
In-Reply-To: <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
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
2.56.0-rc2

