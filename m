Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795717521;
	b=MA3n4eagD8l3MFw9vaIHb2VxgaYBDUPiducCmSyWc0+m0GBWeLja3NdhJ/1yUCa94Qj3
	 udN0s6Q13yUx2eRH2X7G6Muskyn2NyaW9/ulHOQvAfto+1D75RlLSD9xG7gxsJqALTvor
	 PqkEZUesYCiTQi00UZe4Rszfa4PWSe0qTzLqdFBFisb8SobeURt7I/Cd8SPV0Yuu23BBJ
	 MpI94TQG6a07VCWUmuCFZLH266uexULpreB0deibKXlpqqOAbsrtVCYV+bacqMZy7vVoG
	 5GrH10T8rPVCboOJRDg6A8KkLxfQvWiA77GvqGwxSNWyiqUVNkmsI0MoIN+Xad/zvkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=NrY0RpF7TGQ8IS0t34KaRpBl1etrq1eEwGszriglgkk=;
	b=PQ97bzTmPrY6XYtTg2hXfnA3AQXLx+8qdAgGv9qweDuYSeBVPvW4ZEZNUb73GXDuNqjs
	 yspkHTFgDtvBW8BktZ6x6fQtOcZKCYJ7RVokB3X8y1XiH1R5qpKFcLlLL/VQnLm0wGwtL
	 whUrNmScZs+8lwBIpk3I96ya0VTUgeWlfQv8FNMioofDuNEbNBdJfIFl32nYh2zbpTo2R
	 X3Sh+9FTNuM0Ej71PWMuXtyKdJv0GbnrrkXL0QReHpLTP9ke7GW1fC63LIahQPXx86UV4
	 +S2GjHTK+KcIsYLHjX/JqeIFvTKLOEwdxdDgfyH80Gx40u5EWBBH5lufA9ArVT6rFKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hZHsghgu;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6238606A321
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 18:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6238606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hZHsghgu
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f03eeda984so40679075ad.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 10:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795717520; x=1796322320; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NrY0RpF7TGQ8IS0t34KaRpBl1etrq1eEwGszriglgkk=;
        b=hZHsghgudgernlY0EniTSq3sLjLNuiR/36kNaDIZtsglCexhygIk/kWT0uAJDC3Yfm
         hYViCxQdULu/yrM/q7d3eawVogfhWBEnnc1jEXkwhexRkZ0VNU8fqO9eHAuq4cBUE2kg
         rD2Wzcagxp71gYEk20EA18TBRmCggiMntdghCbaZY0dHZcS1P7DHI62q7YJMuAyRbbU+
         cI9kQl31x+QTcUyd+o/m68Vz02ntIRdg9EUPZGY4e12zgMvWiiJAmHQMGXqfrgFvqEhN
         dQCy1KAeEyT1LkrZCMgbiwS0cwjt088pNgiwpieTWnoZtVzFQzqIdzmyQbVqopA1yWYw
         DtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795717520; x=1796322320;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NrY0RpF7TGQ8IS0t34KaRpBl1etrq1eEwGszriglgkk=;
        b=hbK8u3FFYMmoaibngVnX6p6s6H8EUh6ae+fKPScpS+UZVu2OHnsxf/B+Kr7pSsXND0
         8YQMOpW0DhhF2Bn2Fiu5bjcXuUvzfTFX7NFetEEhrdvUlnsu0c3n970t7zG9rM8iQdez
         jMjoM+Vl7OKW4vML0O84xdk5qWs4URj966/tJp39i83Q7F/dzDypxEGuoUKYg4uCtnEN
         W7UpXSezYHO9exSmJXFYhv+G3Ojob4CC3WM94ZJ1LHIlohG64o1QPShR+3vepgn59Vj0
         G0o0sU+lknHTW+SwqFJ/ID8R29lnKEEPVlIzXvO8fE65m1A5168qi3r1nwEoyFMGRz32
         ylZw==
X-Gm-Message-State: APuU4Z/yhH4eVLJQajXDunARk/K3gsBhnXXxBL+mc+rKnlhO+pCJL68Q
	YFBCBBP6ESYy+K6DWKaX2DuHI4mv/aCyLAsIPCx7R68OKB6McdVFYz2oaAiWIA==
X-Gm-Gg: AZFdTZda3HRWgs8D+X70pIgprIqT9DNGGrCXzfZvtDpY+7rM3qCXpv5Ox/pdNuecMQG
	nLjhXqt6yT74oTY5wFlP0tbiH1nXXD8pTVsIkNhwpdgPh9UODk3XOy3tVkPDoM815mLGUPnzODF
	bhkQ5XtsgZzRpsxhM1AiM8w7lvfTAqhFJ3kGk3mmk4eftwdO5VBdA4ppwElY2P5RaO9TLvMHgvk
	DTqGQNGz8VSiaOnG7ze5+0HlFjf5UsSjeE5iYvPcQ9Un/nNQ9PJJ4wnJCupPNSVunkRcWO2BhF4
	iDgIlaVlGChNoc7khaxRSThKEptzXPoducNPdyj0gIS0dP2v7eBZ5d+b4C3kRCXaccGpIqu9w4o
	61IoDRPlmRGu/BJnf+q1bYSTXd5jM6NGHn0G+DW6Lzdy27hnluGhE3mAVfGM5HlZft1Mk60FjEZ
	7+1U6agnmgIy/NKsIMwWAhFCRng2lEmjCfVNO0FqPeJw2oqwkgKVuC1g1OIc2sE/wq7rFmJCyX7
	vt90KTiVR5cqnU3Gm0fYPAQd50L+m5Cip1uOT7tVt6BYX72gx33fBs9dNZXhY2tS4yowCtFaqAB
	K2qQXYxAuYOWoA/3IIpGfsyigSB30b21
X-Received: by 2002:a17:903:19cb:b0:2ed:2c40:6273 with SMTP id d9443c01a7336-2f03f1c08c5mr223322095ad.40.1795717519797;
        Thu, 26 Nov 2026 10:25:19 -0800 (PST)
Received: from [127.0.0.1] ([13.66.168.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f099a4d875sm66759505ad.37.2026.11.26.10.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 10:25:18 -0800 (PST)
Message-Id: <pull.2245.git.1795717517830.gitgitgadget@gmail.com>
From: "Bhushan Gaikwad via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Nov 2026 18:25:17 +0000
Subject: [PATCH] worktree: allow sharing root files with linked worktrees
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Bhushan Gaikwad <bhushan@alfredscholar.com>

From: Bhushan Gaikwad <bhushan@alfredscholar.com>

Ignored configuration files such as .env often need to remain identical
across linked worktrees. Today users must copy them manually or install a
post-checkout hook, which is easy to forget and can create divergent local
configuration.

Add a multi-valued worktree.sharedFile setting. For each configured
root-level regular file, worktree add creates an absolute symbolic link
from the new worktree to the primary worktree before running the
post-checkout hook.

Reject nested paths and source symlinks, avoid replacing checkout files,
and fail cleanly when symbolic links are unavailable.

Signed-off-by: Bhushan Gaikwad <bhushan@alfredscholar.com>
---
    worktree: allow sharing root files with linked worktrees

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2245%2Fbhushan%2Fworktree-link-shared-files-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2245/bhushan/worktree-link-shared-files-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2245

 Documentation/config/worktree.adoc | 13 ++++
 builtin/worktree.c                 | 78 ++++++++++++++++++++++++
 t/t2400-worktree-add.sh            | 95 ++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)

diff --git a/Documentation/config/worktree.adoc b/Documentation/config/worktree.adoc
index 0930183b91..ddd423caea 100644
--- a/Documentation/config/worktree.adoc
+++ b/Documentation/config/worktree.adoc
@@ -18,3 +18,16 @@
 Note that setting `worktree.useRelativePaths` to "`true`" implies enabling the
 `extensions.relativeWorktrees` config (see linkgit:git-config[1]),
 thus making it incompatible with older versions of Git.
+
+`worktree.sharedFile`::
+	Specify a file at the root of the primary worktree to create as a
+	symbolic link in each new linked worktree. This is useful for ignored
+	configuration files which should be shared by all worktrees. Paths
+	containing directory separators are rejected. The variable may be
+	specified more than once to share multiple files.
++
+The source must be a regular file, not a symbolic link. Missing or non-regular
+sources are skipped with a warning. Git does not overwrite a path populated by
+checkout, and warns instead. Shared files are linked before the `post-checkout`
+hook runs. The symbolic link uses the absolute source path. Worktree creation
+fails when symbolic links are disabled.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 77ecd0f71f..23af5f0beb 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -131,6 +131,7 @@ static int verbose;
 static int guess_remote;
 static int use_relative_paths;
 static timestamp_t expire;
+static struct string_list shared_files = STRING_LIST_INIT_DUP;
 
 static int git_worktree_config(const char *var, const char *value,
 			       const struct config_context *ctx, void *cb)
@@ -141,6 +142,14 @@ static int git_worktree_config(const char *var, const char *value,
 	} else if (!strcmp(var, "worktree.userelativepaths")) {
 		use_relative_paths = git_config_bool(var, value);
 		return 0;
+	} else if (!strcmp(var, "worktree.sharedfile")) {
+		if (!value || is_absolute_path(value) ||
+		    strchr(value, '/') || strchr(value, '\\') ||
+		    !verify_path(value, S_IFREG))
+			return error(_("invalid value for worktree.sharedFile: %s"),
+				     value ? value : "");
+		string_list_append(&shared_files, value);
+		return 0;
 	}
 
 	return git_default_config(var, value, ctx, cb);
@@ -455,6 +464,73 @@ static void setup_alternate_ref_dir(struct worktree *wt, const char *wt_git_path
 	strbuf_release(&sb);
 }
 
+static int link_shared_files(const char *path)
+{
+	struct worktree **worktrees;
+	struct string_list_item *item;
+	struct strbuf source = STRBUF_INIT;
+	struct strbuf destination = STRBUF_INIT;
+	struct strbuf primary = STRBUF_INIT;
+	struct strbuf target = STRBUF_INIT;
+	int ret = 0;
+
+	if (!shared_files.nr)
+		return 0;
+	if (!repo_has_symlinks(the_repository))
+		return error(_("worktree.sharedFile requires symbolic link support"));
+
+	worktrees = get_worktrees_without_reading_head(the_repository);
+	if (worktrees[0]->is_bare) {
+		warning(_("not linking shared files: primary worktree is bare"));
+		goto done;
+	}
+
+	strbuf_realpath(&primary, worktrees[0]->path, 1);
+	strbuf_realpath(&target, path, 1);
+
+	for_each_string_list_item(item, &shared_files) {
+		struct stat st;
+
+		strbuf_reset(&source);
+		strbuf_addf(&source, "%s/%s", primary.buf, item->string);
+		if (lstat(source.buf, &st)) {
+			warning_errno(_("not linking shared file '%s'"), source.buf);
+			continue;
+		}
+		if (!S_ISREG(st.st_mode)) {
+			warning(_("not linking shared file '%s': not a regular file"),
+				source.buf);
+			continue;
+		}
+
+		strbuf_reset(&destination);
+		strbuf_addf(&destination, "%s/%s", target.buf, item->string);
+		if (!lstat(destination.buf, &st)) {
+			warning(_("not linking shared file '%s': destination already exists"),
+				item->string);
+			continue;
+		} else if (errno != ENOENT) {
+			ret = error_errno(_("could not inspect shared file destination '%s'"),
+					  destination.buf);
+			goto done;
+		}
+
+		if (symlink(source.buf, destination.buf)) {
+			ret = error_errno(_("could not link shared file '%s'"),
+					  destination.buf);
+			goto done;
+		}
+	}
+
+done:
+	free_worktrees(worktrees);
+	strbuf_release(&source);
+	strbuf_release(&destination);
+	strbuf_release(&primary);
+	strbuf_release(&target);
+	return ret;
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -591,6 +667,8 @@ static int add_worktree(const char *path, const char *refname,
 	if (opts->checkout &&
 	    (ret = checkout_worktree(opts, &child_env)))
 		goto done;
+	if ((ret = link_shared_files(path)))
+		goto done;
 
 	is_junk = 0;
 	FREE_AND_NULL(junk_work_tree);
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index bdcca97633..0aa426bbac 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1288,4 +1288,99 @@ test_expect_success 'relative worktree sets extension config' '
 	test_cmp_config -C repo true extensions.relativeworktrees
 '
 
+test_expect_success SYMLINKS 'worktree.sharedFile links files from the primary worktree' '
+	test_when_finished "git worktree remove --force shared-file-wt" &&
+	echo shared-secret >.env &&
+	echo local-secret >.env.local &&
+	test_config worktree.sharedFile .env &&
+	git config --add worktree.sharedFile .env.local &&
+	git worktree add --detach shared-file-wt &&
+	test -L shared-file-wt/.env &&
+	test -L shared-file-wt/.env.local &&
+	test "$(readlink shared-file-wt/.env)" = "$(pwd)/.env" &&
+	test_cmp .env shared-file-wt/.env &&
+	test_cmp .env.local shared-file-wt/.env.local
+'
+
+test_expect_success SYMLINKS 'worktree.sharedFile uses the primary worktree as source' '
+	test_when_finished "git worktree remove --force shared-source-wt" &&
+	test_when_finished "git worktree remove --force existing-shared-source" &&
+	git worktree add --detach existing-shared-source &&
+	echo primary >.env &&
+	echo linked >existing-shared-source/.env &&
+	test_config worktree.sharedFile .env &&
+	git -C existing-shared-source worktree add --detach ../shared-source-wt &&
+	echo primary >expect &&
+	test_cmp expect shared-source-wt/.env
+'
+
+test_expect_success SYMLINKS 'worktree.sharedFile is available to post-checkout hook' '
+	test_when_finished "git worktree remove --force shared-hook-wt" &&
+	test_when_finished "rm -rf .git/hooks" &&
+	echo hook-secret >.env &&
+	test_config worktree.sharedFile .env &&
+	mkdir .git/hooks &&
+	test_hook post-checkout <<-\EOF &&
+	cat .env >hook-env
+	EOF
+	git worktree add --detach shared-hook-wt &&
+	test_cmp .env shared-hook-wt/hook-env
+'
+
+test_expect_success SYMLINKS 'worktree.sharedFile rejects paths outside primary worktree' '
+	test_config worktree.sharedFile ../.env &&
+	test_must_fail git worktree add --detach invalid-shared-file 2>err &&
+	test_grep "invalid value for worktree.sharedFile: ../.env" err &&
+	test_path_is_missing invalid-shared-file
+'
+
+test_expect_success SYMLINKS 'worktree.sharedFile rejects nested paths' '
+	test_config worktree.sharedFile nested/.env &&
+	test_must_fail git worktree add --detach nested-shared-file 2>err &&
+	test_grep "invalid value for worktree.sharedFile: nested/.env" err &&
+	test_path_is_missing nested-shared-file
+'
+
+test_expect_success SYMLINKS 'worktree.sharedFile does not follow source symlinks' '
+	test_when_finished "git worktree remove --force symlink-source-wt" &&
+	test_when_finished "rm -f ../outside-shared-file shared-symlink" &&
+	echo outside >../outside-shared-file &&
+	ln -s ../outside-shared-file shared-symlink &&
+	test_config worktree.sharedFile shared-symlink &&
+	git worktree add --detach symlink-source-wt 2>err &&
+	test_grep "not a regular file" err &&
+	test_path_is_missing symlink-source-wt/shared-symlink
+'
+
+test_expect_success SYMLINKS 'worktree.sharedFile requires symlink support' '
+	echo shared-secret >.env &&
+	test_config worktree.sharedFile .env &&
+	test_config core.symlinks false &&
+	test_must_fail git worktree add --detach no-symlink-wt 2>err &&
+	test_grep "worktree.sharedFile requires symbolic link support" err &&
+	test_path_is_missing no-symlink-wt
+'
+
+test_expect_success SYMLINKS 'worktree.sharedFile works with --no-checkout' '
+	test_when_finished "git worktree remove --force no-checkout-shared-wt" &&
+	echo shared-secret >.env &&
+	test_config worktree.sharedFile .env &&
+	git worktree add --detach --no-checkout no-checkout-shared-wt &&
+	test -L no-checkout-shared-wt/.env &&
+	test_cmp .env no-checkout-shared-wt/.env
+'
+
+test_expect_success SYMLINKS 'worktree.sharedFile does not replace checkout files' '
+	test_when_finished "git worktree remove --force tracked-shared-file" &&
+	echo tracked >shared &&
+	git add shared &&
+	git commit -m shared-file &&
+	echo primary-only >shared &&
+	test_config worktree.sharedFile shared &&
+	git worktree add --detach tracked-shared-file 2>err &&
+	test_grep "not linking shared file.*already exists" err &&
+	test_path_is_file tracked-shared-file/shared &&
+	test ! -L tracked-shared-file/shared
+'
+
 test_done

base-commit: c46c1e37724f0478939de636ab8ea5a89086d532
-- 
gitgitgadget
