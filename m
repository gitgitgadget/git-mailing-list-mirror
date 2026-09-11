Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A393612DB
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138067; cv=none; b=o6NJnEUsutDEZO0zB/HLoSDpzkx0niYcUJOpOqnxdn1ec1tYEK8OhTaOcCttR1vtYz8M5SIn+3NcxhgeifgFCLfLDHiYzizpwNQi7GjMt6CACwCE7FbOErBoyLPaRa0Q104pV8BpD6zdlcnkVcNI7Hm8o88u9HZSvI/3zY4r5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138067; c=relaxed/simple;
	bh=SNAK2wBuRIGS5jScHZCQUmHU9dla1Dfud2VOMwnrIMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVbMxnCEguYOoDWVKr6Qa03K279cjK4Kk5uQZkifYIu7DlQT04wHhypR5/LG+cxFVYE3G6x6fbiTJTx0WaNOLD0yAVaRIoqzWGLuX2TaRFvpNgxrUU0SLs++lr7sE0VlhgMJkZAMaL1DO5N7NCJx+R6NcZLuGqZcrAXtT05BbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFtg05s5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFtg05s5"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso976645a91.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789138064; x=1789742864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQlpnx4ANvChQoozxWxHe9IFmuUq0cZXEqSANgnVtzM=;
        b=HFtg05s5i+133ZE69PMoQerxHgVFBZ8bwgQCHgJrSKnx0JoX1t746GkiWa7XP5B9q0
         NbSNLjZZCx82uIr6biF1QceD9UjHDzh64t5GYXrgYJS87WzqxaRPuRe3vGJo8TM9WJU9
         RaBixYy38xdtLBN+K+Y7K8KfFf5AZ5a4lqkYaFyZxFXvY6h9e4lktGyfHJRRM3mLvJ87
         kGM66rNHdekaOvpZVrC8c/dHzux1sdmLRlL7/TQz9mYT7UrHnwCX3+BT0DLf5xYZ8LFS
         YFYAU9RhdKJZUFBXdn48X/aA0y5r4p3CLRqwCkD9tmQ2gQNvULyNnW+thdMJVONNs2xo
         KxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138064; x=1789742864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xQlpnx4ANvChQoozxWxHe9IFmuUq0cZXEqSANgnVtzM=;
        b=sHr6OQW/PDdHNQ/bXQiKevDFmjJME8SqHIYxuvCcV3mJU2Ydgtjayg7/tYwgghoyjx
         0yVKc+eptuIA4B5byNWZQ1C6mtQ6Z/8CMmOv/2MI0keXaSRtyjUbUCcKLOuSWfOpfWZy
         Dd9YCzYFcbBCcOWXU9mgFCD5JajvvCWmP2YYwjyeiR0eXz9qow0PYQEmdLJDd2WVzvd/
         XvtqFCXWWQLaXqMo+Up1cmL8fdpc3EWcUgR4ofv2X3PjH7W5Mu2qgtzrjydu+hfbcFQg
         DehvhZJskQ4nFUoqqZP55BRWCNVLiHAoVfq/HntqMvtXOhalhZdMO/qXIYCubYiicHFL
         AUPg==
X-Gm-Message-State: AFuF++l+5e5sqXNn7kUqHqAhSpz4jDP2Jkth+xH786sUz4gY6ohD9YBH
	XcXXDG3Qgv/41eC8WSEk30e++hYf6Jm9FwUEUyJujpRunp6CoItu1Phj
X-Gm-Gg: AYBFou3SbqokH7mJdCk64ZEloRXYtwOVbp6H487r6Lg91KxPz8BL+yMb/6xzE/hY7gx
	OAJ3AgwumnWL9wYQVHEbmCAghKGAo2YTvZ7dv5n661AsHXWLeS6n1kgmIS4jiYW8ovdiR+PTwvd
	SSHsEkiQSKued8/ftNuysRvrSqzokqJ6iWayQWqxe8g6773TxUMLCH56q2W3EZWgd0kWYJXYhI2
	tSEEU9FqrrHMSn467fRiLYOd7mwIzbFCTF1LPMlA6lCbMXXWFOWW54rTIrhcp07NSWaM9PGyy4s
	ZngMFBEaXn+hMw/Icz9E6Nps32+86Yejs/1cdFy4j2cpbPJ40Xr133VT8MvWhA3hmEU45+FujQW
	yuc6xA0xwSNsBuNUmclDVCuwgn7frcliKfe15B3vQEZgqtD1msN3zwFTlPRtyDfMC1KTzkCuNXK
	B2qZ+IJtJdl/5r4M3AtuNs5KGILDhxoguXr0JLWoDHmAGnJQtxSoSGVWiNjgT0I0cPk0NdQ8e75
	x9cvVnCno0jr4l6lKlSDgq4HaUFoW+vmjMdI6+snv4zcahBblSjBS3rJHdgqfR6LfPlo7pXLQjh
	QM5rmni58c9QP0FD
X-Received: by 2002:a17:90b:440c:b0:39b:57c6:e280 with SMTP id 98e67ed59e1d1-39d9bd65a3bmr7371749a91.7.1789138064146;
        Fri, 11 Sep 2026 07:47:44 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm7843335c88.7.2026.09.11.07.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:47:43 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v6 5/7] repo: add path.grafts with absolute and relative suffixes
Date: Fri, 11 Sep 2026 20:15:17 +0530
Message-ID: <20260911144519.1011780-6-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The repository grafts file specifies alternate parent relationships for
commits and may be used by repository tooling that needs to inspect or
manage grafts. Scripts currently retrieve its location by invoking
`git rev-parse --git-path info/grafts`.

Introduce `path.grafts.absolute` and `path.grafts.relative` keys to
`git repo info`. This exposes the grafts file location as a scriptable
config-like key using standard format rules, allowing scripts to
retrieve it through the same interface as other repository path
information.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 11 +++++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  6 ++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 08ef47750c..868ab0ed9f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,17 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.grafts.absolute`::
+	The canonical absolute path to the repository's graft file.
+	Respects the `GIT_GRAFT_FILE` environment override. The path is
+	returned regardless of whether the file currently exists on disk.
+
+`path.grafts.relative`::
+	The path to the repository's graft file relative to the current
+	working directory. Respects the `GIT_GRAFT_FILE` environment
+	override. The path is returned regardless of whether the file
+	currently exists on disk.
+
 `path.hooks.absolute`::
 	The canonical absolute path to the repository's hooks directory.
 	Respects the `core.hooksPath` configuration. If `core.hooksPath` is
diff --git a/builtin/repo.c b/builtin/repo.c
index 9f1858a127..33f97b03af 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -122,6 +122,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_grafts_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *graft_file = repo_get_graft_file(repo);
+
+	if (!graft_file)
+		return error(_("unable to get graft file"));
+
+	format_path(buf, graft_file, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_grafts_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *graft_file = repo_get_graft_file(repo);
+
+	if (!graft_file)
+		return error(_("unable to get graft file"));
+
+	format_path(buf, graft_file, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_hooks_absolute(struct repository *repo, struct strbuf *buf)
 {
 	struct strbuf hooks_path = STRBUF_INIT;
@@ -230,6 +252,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.grafts.absolute", get_path_grafts_absolute },
+	{ "path.grafts.relative", get_path_grafts_relative },
 	{ "path.hooks.absolute", get_path_hooks_absolute },
 	{ "path.hooks.relative", get_path_hooks_relative },
 	{ "path.index.absolute", get_path_index_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 80e025e040..7b0bb0ed42 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -221,6 +221,12 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'grafts standard' 'grafts' '.git/info/grafts'
+
+test_repo_info_path 'grafts with GIT_GRAFT_FILE override' 'grafts' \
+	'custom-graft-file' \
+	'GIT_GRAFT_FILE="$ROOT/custom-graft-file" && export GIT_GRAFT_FILE'
+
 test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
 
 test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
-- 
2.55.GIT

