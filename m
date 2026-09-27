Received: from mail-dy2-f36.google.com (mail-dy2-f36.google.com [74.125.229.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A3364E9E
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509546; cv=none; b=WP3jAkurv0P73DmjaklAcQ1BYx6mAt43wSSLJ3y127CFOyTEtEjfkyP59iakcRRw54o0gDOSo5orq/al844JJOD1E57wnh9tebJG+hXgaWW12pyLYezXj8JXNu4H1ZgWFTHEf3+H6WbAxPgZQqwTQc77ewIHchir3XbCPZ+79n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509546; c=relaxed/simple;
	bh=uLIk2/KCMmCahFqy+X3tCfEYZO4Od96W50dpAaCnVHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8PEEprr9F7uXs4uc3jpXnFIPAQR1+0y5C66xAGzgpRuRpF27tI51qHX0pfuutHOzoUEddGo0u+xJDZhilOgUwr7WWzeXcfh3DkhTjnao6rMwdloBsN40Afa/piRUM1gC+E8m37+s4oxrHOs1cfirmpqwZ1kX9oqgHArRnx+Hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNeUpmd3; arc=none smtp.client-ip=74.125.229.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNeUpmd3"
Received: by mail-dy2-f36.google.com with SMTP id 5a478bee46e88-328664c2da6so1696506eec.1
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790509544; x=1791114344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DjS0E5bRhpRpn+tsAV0Ql1ZDejiFW4ZmC1sxtNDMfYc=;
        b=SNeUpmd3wXuA1sFZyN8vhsOfMurjcARnunXuI2Z4fMO2SH8gjZ3ZVgb8t7EGVzHG8r
         y7yNeK1KeCyQoSCcb8pg8QGBY/5t3jH2GBJyrvJqyj2sl4b88JExeg9UmbG7GndJFFFP
         pyqoTz6drd7XJ3YgNfVCF3anFAuk0FmJTgz87fX+Wr+huLzgmuux5ssT7hgJVYOk/TzN
         zsahvUNV97A3RyrkR9d9s5Dq225tid44giYQ8dpIlclmKZ24wkgg0FpZRTHC852O3fgC
         K73XrwE71X/9AMYjSHzWewQFSmWhB4vrW0tZOyymAxCmCzA6/oszz1E+Xxw934agOeI3
         eviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790509544; x=1791114344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DjS0E5bRhpRpn+tsAV0Ql1ZDejiFW4ZmC1sxtNDMfYc=;
        b=zHrMNEZGCuY6QsYvKfSI7QZ6nTKxqq/keZVxIwYxUF8UdhswkX6u0qfZiWGvYFG1+S
         Y/atQwO4UUy+rwavK0RPokfwf3pceHz2rFYNW9JadbjvM4coVSO6yK/rOjoEOPs80+3H
         kzp+4ALTm9RRZtIA34faimOpHqcUMkfJlOxJe2BH3BmwDfidCuR7HShDAq5rWVZrAVHN
         VF/mlns90BNFv10EM4pZ3j0V3bPzKSIgPyUgHuQz2/3hKiC4BdnCl8oh8dLmAadBt0RW
         WTqHLAmLwlaNN5xsOS1AJTkjmlrHw2RJKg8EFlzTEeos3Uj0WdVrzeRHo9VteqW3qfWf
         Ifvg==
X-Gm-Message-State: AFuF++mwuXnZ6vfFIrVx1P5pNjLWoWz1ny9e7790HomdXmD66jyaP1Z0
	Fg6fWd3tBksEBoUt2gvX8AgCDoJc7Ft/RR8PdV3mvqF7pd41+3pB4nDf
X-Gm-Gg: AYBFou2Q0rthz8jI5Qo9Wk3z7Rrd4MzaqZ6CYKwcOCPmCM17Mb5qKC/UKIMqRVEgkX3
	0IXCdu8KqCPECttaCbJ+LSnXPoWzVPnePSVOIKA/NZ7Pwl/DiascN31fP2eBh3dr/MBrL9Cfzxh
	8KDbSyQI7s1Xz47RAFPQzIqc4b8xK920EWY8YCfF5mMd0yljX9Npff0iyQHzyAwfTM+fMFirviK
	QSHXWpBNLTQwtxIWIdSwKU4E0YFzSWEmgkM3J5BV8RDmDZ9sl64gF+S0/ZAmrc4ulvd0BPJYgeW
	o/eq27c0RqGsCqd7vCBwSl39AKtqTkZejmadoIqnMomyzHgl6DrsfF+jO/G0+76B3Qy1kEth57l
	pupRqTeikZGzW9cVcQjMOJTY/W4pOcKje8+fkhHvloa4ytHxuR+GyIzD/T/lSZFnhAcDzBkVPIv
	rjM4RHz6d2JjPvibO09nInAGxwz64wfOJh3e4R0NdL6yjpghSV0ibwY/E50zIMUEDrmkKbKvRfA
	d2kXlh7QkrW41EwSYZ4sumycrBeGPUZ7coaZxtE++3R+zIOU82pPtaEfmr4dg/VLjueo9peIJIh
	wEXB
X-Received: by 2002:a05:7022:ea8c:b0:143:4f53:5112 with SMTP id a92af1059eb24-146cdfbe301mr6248658c88.8.1790509543672;
        Sun, 27 Sep 2026 04:45:43 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm17450424c88.0.2026.09.27.04.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 04:45:43 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v7 4/8] repo: add path.hooks with absolute and relative suffixes
Date: Sun, 27 Sep 2026 17:14:16 +0530
Message-ID: <20260927114420.59724-5-jayatheerthkulkarni2005@gmail.com>
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

Hooks are an integral part of a repository's configuration and are
commonly used by tooling to automate repository-specific workflows.
Currently, scripts typically retrieve the hooks directory by invoking
`git rev-parse --git-path hooks`.

Introduce `path.hooks.absolute` and `path.hooks.relative` keys to
`git repo info`. This exposes the hooks directory as a scriptable
config-like key using standard format rules, allowing scripts to
retrieve it through the same interface as other repository path
information.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  9 +++++++++
 builtin/repo.c              | 22 ++++++++++++++++++++++
 t/t1900-repo-info.sh        | 28 ++++++++++++++++++++++++++--
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index e524a07f53..20836cf8f6 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,15 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.hooks.absolute`::
+	The canonical absolute path to the repository's hooks directory.
+	Respects the `core.hooksPath` configuration. If `core.hooksPath` is
+	set to `/dev/null`, that value is returned unchanged.
+
+`path.hooks.relative`::
+	The path to the repository's hooks directory relative to the current
+	working directory. Respects the `core.hooksPath` configuration.
+
 `path.superproject-root.absolute`::
 	The canonical absolute path to the working tree root of the superproject
 	if the current repository is an initialized submodule. Outputs an empty
diff --git a/builtin/repo.c b/builtin/repo.c
index 27ebb7a1c9..01666dc17c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -122,6 +122,26 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_hooks_absolute(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf hooks_path = STRBUF_INIT;
+
+	repo_git_path_replace(repo, &hooks_path, "hooks");
+	format_path(buf, hooks_path.buf, "", PATH_FORMAT_CANONICAL);
+	strbuf_release(&hooks_path);
+	return 0;
+}
+
+static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf hooks_path = STRBUF_INIT;
+
+	repo_git_path_replace(repo, &hooks_path, "hooks");
+	format_path(buf, hooks_path.buf, repo->prefix, PATH_FORMAT_RELATIVE);
+	strbuf_release(&hooks_path);
+	return 0;
+}
+
 static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
 {
 	struct strbuf superproject = STRBUF_INIT;
@@ -188,6 +208,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.hooks.absolute", get_path_hooks_absolute },
+	{ "path.hooks.relative", get_path_hooks_relative },
 	{ "path.superproject-root.absolute", get_path_superproject_absolute },
 	{ "path.superproject-root.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index eec576a1d9..1da5db4942 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -174,7 +174,11 @@ test_repo_info_path () {
 			cd repo/sub &&
 			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
 			eval "$init_command" &&
-			echo "path.$field_name.absolute=$ROOT/$expected_dir" >expect &&
+			case "$expected_dir" in
+			/*) EXPECT_ABS="$expected_dir" ;;
+			*) EXPECT_ABS="$ROOT/$expected_dir" ;;
+			esac &&
+			echo "path.$field_name.absolute=$EXPECT_ABS" >expect &&
 			git repo info "path.$field_name.absolute" >actual &&
 			test_cmp expect actual
 		)
@@ -188,7 +192,11 @@ test_repo_info_path () {
 			cd repo/sub &&
 			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
 			eval "$init_command" &&
-			echo "path.$field_name.relative=../$expected_dir" >expect &&
+			case "$expected_dir" in
+			/*) EXPECT_REL="$(test-tool path-utils relative_path "$expected_dir" "$PWD")" ;;
+			*) EXPECT_REL="../$expected_dir" ;;
+			esac &&
+			echo "path.$field_name.relative=$EXPECT_REL" >expect &&
 			git repo info "path.$field_name.relative" >actual &&
 			test_cmp expect actual
 		)
@@ -213,6 +221,22 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
+
+test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
+	'custom-hooks' \
+	'git config core.hooksPath "$ROOT/custom-hooks" && mkdir -p "$ROOT/custom-hooks"'
+
+# /dev/null is not a real, canonicalizable filesystem path on Windows,
+# so path resolution for core.hooksPath=/dev/null cannot be expected to
+# produce a literal "/dev/null" the way it does on POSIX systems.
+if ! test_have_prereq MINGW
+then
+	test_repo_info_path 'hooks with core.hooksPath=/dev/null' 'hooks' \
+		'/dev/null' \
+		'git config core.hooksPath /dev/null'
+fi
+
 test_expect_success 'path.superproject-root absolute and relative' '
 	test_when_finished "rm -rf sub super" &&
 	git init sub &&
-- 
2.56.0-rc2

