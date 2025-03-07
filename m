Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBD21771F
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346262; cv=none; b=AcRrW0T8vBvoiVn+hIbo4nWDUVfavePdWV1erks5jDR4TIXt6govDh/6y74nNjw3ArIAmIFA6PwO4nuBAT60LBYpsvsPAonUMIQGKO8arqxB3XIT28X99EduPXpAJc4Lcq6XlQcIijYk+xTXsxuVzNvWv/ruScwotV2y9ZGvyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346262; c=relaxed/simple;
	bh=ve1t6t4NVDBecRrb01FdVw187MV4RdGzoq9v+zdzNDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dh6lRkAYMDxNs3f9UjY8/nAOVFODIz14Iprta2wHKlEHLJSCzHKOiaR+1S2S14RllL+9y0zC7MS6rppLPp/7NWhSy3HGmCmoOKgznfr3dRfA+kEiBFzq7TNk6HsopL3tKgoEJ1VejI11U95uvPSz82P8diKR/N6/5Aynm5Lhv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT0RPA/I; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT0RPA/I"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac0cc83e9adso578762666b.0
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741346259; x=1741951059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivK0lQDRvZ5+cBtxxqlPI5DTBlZfAf2ONc1nTenVwQc=;
        b=CT0RPA/I7SGauYivJ/kQY9t2NVSunlJVrB0k90zvPngfE6bxPqlVUMMmgCIPo7VZZo
         9PKRIYiaHR2h4UZErrD12XBjikGnC1Dwo2ZWoTMUqGjylPZPzMa3xPVASKKkYZq1z63h
         xCA4DOA4h6PADadkSug33mMJtBItmQPhZA29jFrQMYaPgfCmMa+j81cbLO4mU30T6mkM
         kM+AJf5VVb6eNewKWLDT560sJ+rumZIJuCHNMvB5ztH6ragMeO4+rLeR5kN4CXNogeO1
         /+5yslYoUhIi4CJiSrabZo5qoiLgikwsK0iDQ7yTicOZb4IBYnuBdw2nyHjzc+ulzocz
         qBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346259; x=1741951059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivK0lQDRvZ5+cBtxxqlPI5DTBlZfAf2ONc1nTenVwQc=;
        b=Xr81ez+ynN3avVpfLAlxuC9oDZ65AJKj2W7HonFVXdftTPQTv8hvrS0cttDfVWd+12
         Q+DsGwDfsLOaD1iU6EnZbahxGv64M6WQMXI+0X56/br9r4tUOMXo7hrEkDSojo5vezqD
         Eagaw0HCwEbJH7xuPz32BT9tQYFttPhrUlMo/oekBQD+DJa61IPKUizG5sjUe32GpAQd
         ydShWqiEVBhhHGksKkpGfttB/ZscBZpjB8ScRIXGyCVjmm3Il3s+dbXci3cyObq5JBql
         d6ht27ZMHdxLtUNA1DBwgV/nqix2+O4nW46vCdiSTdwjT6AhoPdnEpM4C/0oNCwIkaOs
         FeNQ==
X-Gm-Message-State: AOJu0YztvJ9vvGa6ryaWacq8C2T4xnu10aIPN6WfJXPrmbcJyyZf7902
	nUPLOi0iJbrUQRB9An/M37GlCI/uX/q1A6zxmZVA3nvRi0LcPE5Aox+swRET
X-Gm-Gg: ASbGnctJKODjV1ybqCaS/B0770WgiLNuLVY+gq68xjf7rtDlEseVPlrK0JC1SbCJOPB
	u9DAY9MvjLdgcVMWELugdpHgqJ88J26HANC3OAHT11fDqZDJ5pfu231mRiopCzYafinNz0sSTPv
	wK2MVTvcZudQVydU3gmVVvVM7L5B3sYCHeuRfLnjtltbCzWvgH92ZLMOmU4iZdK8hFaSS5jonwu
	pKguQTQxN9XIQrz0DkAwnxGYsbJC2j4KBI2aXA4KkcqjAF937APLfYpgFUu90NI3qBGjSlCPVI+
	gD0ejIUhbiSlCP8Oma4o+MXxAgCFaEoUzNQbd+hwx/sp
X-Google-Smtp-Source: AGHT+IGjo6DWpOtlT1d896M97s1YnQcfPCBy6HsAe2gf9usRcY2bE/l63hcZwhtHgAQug5qhLszgCA==
X-Received: by 2002:a17:906:6a20:b0:abf:6d1c:8f4a with SMTP id a640c23a62f3a-ac22ccf822bmr759557166b.18.1741346258506;
        Fri, 07 Mar 2025 03:17:38 -0800 (PST)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988bdc7sm261464266b.133.2025.03.07.03.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:17:38 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 07 Mar 2025 12:17:26 +0100
Subject: [PATCH 2/2] reflog: implement subcommand to drop reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-493-add-command-to-purge-reflog-entries-v1-2-84ab8529cf9e@gmail.com>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
In-Reply-To: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6303; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ve1t6t4NVDBecRrb01FdVw187MV4RdGzoq9v+zdzNDg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfK1c98sbop0PrAyN2vC0kAIY2NflRCPEjRz
 o3o0q+gkaQhjYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnytXPAAoJED7VnySO
 Rox/HY8L/0o55OYHYnAt1CokNTpLYz76Dp3KktY5Pu1jsQXDTeCImVwOw75nRWir1dmP3Oo6Ar+
 7hzOschoCsbQ32/01rKHaW8NHiI9FixVnk3+eTwNvnCT1ZDYYEk3vmimL/RsdD1HYomkGDH6t0t
 vljJvDwqETVrq0DQyAD/05NMLD4dcTQBs9nnjjd8XOhk4Qod70d0R9bxOH+w3qHeS9KuvVyfWne
 6KgozPTT/r3LTZpgPQ+BRE31Yc8GzeII0I/8F8nNK4rWD+UgaTIpYC7ki6kWOUSICzre923ViZ9
 LG8bKFKiEVOI+sEP+5ZgJJj8Yz+riRzFdrhllXUf6/MdUwlf5uR+UNWvHBYVxtZV9ymkArRriRj
 24fUcXvViaSLHbNRUU/sOXgV0Uu/pHIEdoDoL5IwzXx4shZwjXZAui88WGwYMBmu4ZHtws5EooB
 hRhIr5YTFGlLlulDZEQ4KRtQFI6IRo9Iu5Y2C+qcdXEHaokGxgel/6oC2+uLGAUMFGnWv/L1Xm4
 98=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Add a new 'drop' subcommand to git-reflog that allows users to delete
the entire reflog for a specified reference. Include a '--all' flag to
enable dropping all reflogs in a repository.

While 'git-reflog(1)' currently allows users to expire reflogs and
delete individual entries, it lacks functionality to completely remove
reflogs for specific references. This becomes problematic in
repositories where reflogs are not needed but continue to accumulate
entries despite setting 'core.logAllRefUpdates=false'.

While here, remove an erranous newline in the file.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-reflog.adoc |  6 +++++
 builtin/reflog.c              | 58 ++++++++++++++++++++++++++++++++++++++++++-
 t/t1410-reflog.sh             | 55 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index a929c52982..4ecee297de 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -17,6 +17,7 @@ SYNOPSIS
 'git reflog delete' [--rewrite] [--updateref]
 	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
 'git reflog exists' <ref>
+'git reflog drop' [--all | <refs>...]
 
 DESCRIPTION
 -----------
@@ -57,6 +58,11 @@ The "exists" subcommand checks whether a ref has a reflog.  It exits
 with zero status if the reflog exists, and non-zero status if it does
 not.
 
+The "drop" subcommand removes the reflog for the specified references.
+In contrast, "expire" can be used to prune all entries from a reflog,
+but the reflog itself will still exist for that reference. To fully
+remove the reflog for specific references, use the "drop" subcommand.
+
 OPTIONS
 -------
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index f92258f6b6..232602c1a6 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -27,6 +27,9 @@
 #define BUILTIN_REFLOG_EXISTS_USAGE \
 	N_("git reflog exists <ref>")
 
+#define BUILTIN_REFLOG_DROP_USAGE \
+	N_("git reflog drop [--all | <refs>...]")
+
 static const char *const reflog_show_usage[] = {
 	BUILTIN_REFLOG_SHOW_USAGE,
 	NULL,
@@ -52,12 +55,18 @@ static const char *const reflog_exists_usage[] = {
 	NULL,
 };
 
+static const char *const reflog_drop_usage[] = {
+	BUILTIN_REFLOG_DROP_USAGE,
+	NULL,
+};
+
 static const char *const reflog_usage[] = {
 	BUILTIN_REFLOG_SHOW_USAGE,
 	BUILTIN_REFLOG_LIST_USAGE,
 	BUILTIN_REFLOG_EXPIRE_USAGE,
 	BUILTIN_REFLOG_DELETE_USAGE,
 	BUILTIN_REFLOG_EXISTS_USAGE,
+	BUILTIN_REFLOG_DROP_USAGE,
 	NULL
 };
 
@@ -447,10 +456,56 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
 				   refname);
 }
 
+static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	int i, ret, do_all;
+	const struct option options[] = {
+		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
+		OPT_END()
+	};
+
+	do_all = ret = 0;
+	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
+
+	if (do_all) {
+		struct worktree_reflogs collected = {
+			.reflogs = STRING_LIST_INIT_DUP,
+		};
+		struct string_list_item *item;
+		struct worktree **worktrees, **p;
+
+		worktrees = get_worktrees();
+		for (p = worktrees; *p; p++) {
+			collected.worktree = *p;
+			refs_for_each_reflog(get_worktree_ref_store(*p),
+					     collect_reflog, &collected);
+		}
+		free_worktrees(worktrees);
+
+		for_each_string_list_item(item, &collected.reflogs)
+			ret |= refs_delete_reflog(get_main_ref_store(repo),
+						     item->string);
+		string_list_clear(&collected.reflogs, 0);
+	}
+
+	for (i = 0; i < argc; i++) {
+		char *ref;
+		if (!repo_dwim_log(repo, argv[i], strlen(argv[i]), NULL, &ref)) {
+			ret |= error(_("%s points nowhere!"), argv[i]);
+			continue;
+		}
+
+		ret |= refs_delete_reflog(get_main_ref_store(repo), ref);
+		free(ref);
+	}
+
+	return ret;
+}
+
 /*
  * main "reflog"
  */
-
 int cmd_reflog(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -463,6 +518,7 @@ int cmd_reflog(int argc,
 		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
 		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
 		OPT_SUBCOMMAND("exists", &fn, cmd_reflog_exists),
+		OPT_SUBCOMMAND("drop", &fn, cmd_reflog_drop),
 		OPT_END()
 	};
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 388fdf9ae5..b6e44ce6b9 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -551,4 +551,59 @@ test_expect_success 'reflog with invalid object ID can be listed' '
 	)
 '
 
+test_expect_success 'reflog drop non-existent ref' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_must_fail git reflog exists refs/heads/non-existent &&
+		test_must_fail git reflog drop refs/heads/non-existent
+	)
+'
+
+test_expect_success 'reflog drop' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit_bulk --ref=refs/heads/branch 1 &&
+		git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch &&
+		git reflog drop refs/heads/main &&
+		test_must_fail git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch
+	)
+'
+
+test_expect_success 'reflog drop multiple references' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit_bulk --ref=refs/heads/branch 1 &&
+		git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch &&
+		git reflog drop refs/heads/main refs/heads/branch &&
+		test_must_fail git reflog exists refs/heads/main &&
+		test_must_fail git reflog exists refs/heads/branch
+	)
+'
+
+test_expect_success 'reflog drop --all' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit_bulk --ref=refs/heads/branch 1 &&
+		git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch &&
+		git reflog drop --all &&
+		test_must_fail git reflog exists refs/heads/main &&
+		test_must_fail git reflog exists refs/heads/branch
+	)
+'
+
 test_done

-- 
2.48.1

