Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091D1377ABD
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138044; cv=none; b=RHrj2XDLMkLG6tU0cMuY2OKCHXFx7OVAicZJE52xJCNP0yOk5ruyA/L3Tkh6lGmNQPi+TkjqpTLqp9TGXmBwtJ3KrfABZiJ/Fkg7bwBJbcuR7CHGb0qG0JwQWtaBRvsYM+n3vMsc9+RTolUHZJLvvFWsV4lz5l81DW1PQIbKSE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138044; c=relaxed/simple;
	bh=iXentSB28mu5meAJMEBQGnxexwDb+EfcDsVHvv6XQHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q66/OhkTO25RJgWXpp2Z9Q8ze/8FnMZYwRe8elcmDueBt+Zw4W5dfjlu6+JdSKcSQl7K3XJ8ks+yx9ap08IPzAuUPRx13n2ZB3tRafI/Dk1MaPLoODe0xEtat6Ffj3kRj22hVqfzVWkWOtF8IW+W5qodPydiYSG3EPqQnjurKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIFZKRYo; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIFZKRYo"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b35cc0a8c3so950519eaf.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789138040; x=1789742840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ITgdltRGMp7Z0bcT03Glmnd6WrurQ6zg1nd+oe7W6U=;
        b=GIFZKRYoTR1g+LXXA5IxiTYtIEaZ1vcDpB9A0cAhQyPTbHdCBIRSaaLQFYiMop+JqS
         vuYL8Ktqzx0p+j8IKhD1yKbvxXdLQOFrF8149rqnsT2ogmy6TiG6dFV2mlrRlVqyLVKJ
         noERONa+fwLMvb7TobRJb/f5TIOB9yVwhJUlDweKSO1angtUe2UkzvQM0G8JKL5FGvfa
         waBGxl1Z/wQI24LlVYyg9Re7tf/Snxzb/Rnn9es9iEnuDR1pQhE8zvGXnd/CHbikd/K4
         DyyAdp/rqnflidS+uvRM93eUFksZt6t6IuJrMmnBAImf1p66B7jzUpV+p0ho9vf2IVSj
         JO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138040; x=1789742840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ITgdltRGMp7Z0bcT03Glmnd6WrurQ6zg1nd+oe7W6U=;
        b=kn9knhxcSpp3Xx1NOyqFsfQZtdJKhOw4xB7hnjitQxo7UjkUIFeiREoxxLYFdO9u2I
         DquXd1fgwwYXgi/SwUqR8t6ycPXgluMcyRnB6A2XSrJDvrs27cauURn6FPsq6j1YeJI+
         YyQIChhkEzLqGMbkVOF/EUjedADZif7QibNqVfjxeoH6/Zr7n/ojtVT0VPi3jXdSc3lp
         j5rIkEjJyJFf7bVSXDjoKZqeyQ29QkpYjCkJBRwcx4Zpb+dxWrLEb6LmZbYhmd6f0B/m
         l5rvZirijpYv3G5g6o56KrYwwgY/5iBPCtXVHV0sP/TDQvhk219QRY+XDY11DH+YOOML
         TEXQ==
X-Gm-Message-State: AFuF++n+ObYh1Mf6rTOlkcRy1C5UEMswKUDVHD6M+zhiYt59T+1xnH0O
	xzp6iEBbsXHzPfLej/3FQfLRonDKPtUCCvXcKRsTPBFCT7Y/YkECdN5A
X-Gm-Gg: AYBFou26M108es54m8o/ic0HQ38rVQtxRjL9zuNUbADh4XoxVSxqKaYekd2ckN+vixn
	bUCN2SQ+6bUZPbP1452Za0+CgQCSY0cELbE9vHaiFGXXY9OgIV1GHrXnWwZrKXxEcIDWhjg0UKu
	pJ92QOGu7w/k8KxSoFnrbjdcMfsR9+sE4nk0JFLTfv6Irpxde5WY74OC3k48x9xEqbXm0hao71f
	DOqcnUxN0CknTIivwiY4rBrTD5vG2HHIRqZylhn8FuNAMiI4EpcFxZy5d4vJvObFEsyrBh6Q/3j
	tg8ZLMZtKp3loyoXqO0aUZOFrzjztneJhUJm4Lx2y9mtOAfA+pXtopVbDzse5mCtWl0ikzJpTDA
	zFnGRtCRk8e24faTS8gY1z+i/Wnf2eDOeRVAu9aIwEbICTzqAPryVjR3Be0BMaY4WN/n2Aed+9I
	2QC4ces2NYLxNMNDzYeH+I3LPSn1nv0Pe2SFQ1P29XFC3KP58K9xKnp0lZOaXHiQD7GPZLkFA5l
	w1QjJO/IJmSp6SoLxbF/vuz7YRyxd8jEJ4SESAyf/L39qBT93tJ1Vyyc2lwWezBiq694ty8LODJ
	iQM6Z8HyH/5DUhG8
X-Received: by 2002:a05:6820:7097:10b0:6b1:c40d:635c with SMTP id 006d021491bc7-6c0baa1b16cmr2581235eaf.15.1789138040185;
        Fri, 11 Sep 2026 07:47:20 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm7843335c88.7.2026.09.11.07.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:47:19 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v6 3/7] repo: add path.hooks with absolute and relative suffixes
Date: Fri, 11 Sep 2026 20:15:15 +0530
Message-ID: <20260911144519.1011780-4-jayatheerthkulkarni2005@gmail.com>
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
index 2dc0c0fbc5..2e7b3867bd 100755
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
2.55.GIT

