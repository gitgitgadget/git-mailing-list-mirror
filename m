Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A423CC9E2
	for <git@vger.kernel.org>; Tue,  5 May 2026 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965757; cv=none; b=BB3LkF2i4/151eNLl0oFJL+eIhUsAUXaEKiCaPPlEb/WNkvEzf4v/uEN9zAy6M54czJaqkAxFdcia0e0onz5hCBSgpt9i0hLkCKNrr6FiSfdM66Z9ymv3zbE/qFIkQ6iVcqk2Lzr7FzuI50Ov2Kg4zPl/sTDyuf++lLqYO2qhx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965757; c=relaxed/simple;
	bh=1gcUePTcjxKfedR/adt+cIzlkWB0vnvfbO6MYGKgTsw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Hb5fp/RXOElpaJ2QT7IEC8fDosP4cFeRIj60xKjBxVPzcYXcEVm68/v9C5V1HTx7ZNiqWIGxhsz3YTkAvOgx21S2gcRgbIG1TBVet9ZOZ+Asty9nVweLi6K6gFDonO49KWR1jMdHmbwYcX5P+jYTOZcrMs1N9+rxAPKPDZQDtyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjrM+wzK; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjrM+wzK"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50fb4a7d704so40178071cf.1
        for <git@vger.kernel.org>; Tue, 05 May 2026 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965754; x=1778570554; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHmZh4duX4oine/vSRhojzu/fu/W0t4JMuffp91h5Lg=;
        b=qjrM+wzKHX3782S3xhuSOq8Z5bI4YQx1qnDw2nL+jZa7fBkAaQiL7eJ0Ez7XTj1YoR
         GEfQFlwIJWokl7aZ0XyBJ/PL1Q0Qca1/PC2n9N2aNJ93s8Ozbc4ZLrBPjJA3K0QSsLEI
         0RzDK/OoxnRHn7UJU6bajVCKYDY5FKucUBQBgV61qNuB6/BhOX/O0XYuwZox+vtJvaN2
         WuQZ/WSqygqJgyCaAxYv6HeRzLbw0Z6nP9I19khfzT0Cbjx7OkHZ1N5PNSz1kIs0IKBL
         GBD/tZT3OrGeL5AVMZTQziQOVok6Pu/2EEJGicVSrfq7gn2ROpDzuxLqvqSjYhZLzcB7
         eXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965754; x=1778570554;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHmZh4duX4oine/vSRhojzu/fu/W0t4JMuffp91h5Lg=;
        b=CzP29SrGE1fqrFp506y2hqX95h++494udG5GY+jDstwdHRB4anNfHkgVpJAzzTYE05
         w0S0VFcCyyqXHOyiKHneyyL6JXW56SFNnQqiAF5TYueCiNoNuDxZCCHUk07ZTnO3Iko0
         bylSgaZiiY5om7jurdAiA2JBYrqLSf+6LlptSUdWfoyq3exil95kl4PRc2fZhdA+DsfC
         JdLlrlKlgoo/eJAN8G4wQ8wcPhrARvAtyYt6w2rKA+FwAeI+lvuD5+XEW3SDu2wUltLM
         sQ5h1C5cD8K7wsitkIX/Tp4BKXrI96X+gb/m96LQPmHOkIEO1Ii5cwyGcBaZAWdT0Pi5
         qIpQ==
X-Gm-Message-State: AOJu0YyMhIPU4i1EqS3+3Gg09/JNc06W2F0d5Gxk4DFTvNTDDtI5ryRB
	UYAZjnG3sNAHcp1jLGXMJvVDZ+4VaWXNSa9Br3FQG8+tHmLjfJHyjV3d9irGuu+d
X-Gm-Gg: AeBDieuGnqzXL/EUuULeElHyjg0hrBzuVtQw8BlepQSs2/D07fOr4YPOqbJZWcBiOzd
	DV5/OxHgMC7bl55Lr7YIUGbAWWdq7IO3JrmKerruBldYfv1GqSSnSv4phVfscBOmmvYZBp8yiTq
	aHkDnLqa1OeyUV0uYGNJPetMvvaFhRB/OD6WuJOU5bNBX4rrlFWRMKPnmrqeUhLLxglHwMBNDyh
	sr+0OPU/GbuORDKdD6UtwcTQ58zk1jfPEv8kxPfKHl+fbxVojEDUYfJg8+htYtgGlDwGQPH+m+d
	5mlbAnkvS3wdoVHsI8b0qkiJuKJrz/w5zwkUcUJJWYXyH6oQZuW1ovC4bX4G1CWdoNv0D2alsxa
	aRcRf5+9Y3nSqrkzBERL1VFN9ihbnW1uLktbOebcQouDA8+HV2kfNhRf3Q2acX4WTifBL2Xxl80
	bMF3FXaz++sY/fXtzXvyF7DZWvsRSwcVEkZ6OU
X-Received: by 2002:a05:622a:4cf:b0:50f:ca25:fb45 with SMTP id d75a77b69052e-5104be0e35fmr184987331cf.8.1777965754069;
        Tue, 05 May 2026 00:22:34 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040ba8acdsm120664131cf.31.2026.05.05.00.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:22:33 -0700 (PDT)
Message-Id: <938bf7c794631f2dd3429ba338d443bcbb16b9ee.1777965747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
References: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
	<pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 07:22:25 +0000
Subject: [PATCH v3 4/6] fetch: add --prune-merged
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

After a successful fetch from a configured remote, run
'git branch --prune-merged <remote>' to delete local branches
whose push destination ref has just been pruned.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/fetch-options.adoc |  8 ++++++++
 builtin/fetch.c                  | 20 ++++++++++++++++++++
 t/t5510-fetch.sh                 | 31 +++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 81a9d7f9bb..afbd1f60b8 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -185,6 +185,14 @@ See the PRUNING section below for more details.
 +
 See the PRUNING section below for more details.
 
+`--prune-merged`::
+	After a successful fetch, run `git branch --prune-merged
+	<remote>` for the fetched remote, deleting local branches
+	that fork from this remote and whose tip is reachable from
+	their upstream remote-tracking branch. See linkgit:git-branch[1]
+	for the exact selection rules. The currently checked-out
+	branch is always preserved.
+
 endif::git-pull[]
 
 ifndef::git-pull[]
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a22c319467..5451bf3b5b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -82,6 +82,8 @@ static int prune = -1; /* unspecified */
 static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
 
+static int prune_merged;
+
 static int append, dry_run, force, keep, update_head_ok;
 static int write_fetch_head = 1;
 static int verbosity, deepen_relative, set_upstream, refetch;
@@ -2189,6 +2191,8 @@ static void add_options_to_argv(struct strvec *argv,
 		strvec_push(argv, prune ? "--prune" : "--no-prune");
 	if (prune_tags != -1)
 		strvec_push(argv, prune_tags ? "--prune-tags" : "--no-prune-tags");
+	if (prune_merged)
+		strvec_push(argv, "--prune-merged");
 	if (update_head_ok)
 		strvec_push(argv, "--update-head-ok");
 	if (force)
@@ -2382,6 +2386,15 @@ static inline void fetch_one_setup_partial(struct remote *remote,
 	return;
 }
 
+static int prune_merged_for_remote(const struct remote *remote)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	cmd.git_cmd = 1;
+	strvec_pushl(&cmd.args, "branch", "--prune-merged", remote->name, NULL);
+	return run_command(&cmd);
+}
+
 static int fetch_one(struct remote *remote, int argc, const char **argv,
 		     int prune_tags_ok, int use_stdin_refspecs,
 		     const struct fetch_config *config,
@@ -2457,6 +2470,11 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
 	gtransport = NULL;
+
+	if (!exit_code && prune_merged && remote_via_config &&
+	    prune_merged_for_remote(remote))
+		exit_code = 1;
+
 	return exit_code;
 }
 
@@ -2520,6 +2538,8 @@ int cmd_fetch(int argc,
 			 N_("prune remote-tracking branches no longer on remote")),
 		OPT_BOOL('P', "prune-tags", &prune_tags,
 			 N_("prune local tags no longer on remote and clobber changed tags")),
+		OPT_BOOL(0, "prune-merged", &prune_merged,
+			 N_("after pruning, also delete local branches forked from this remote whose tips are reachable from their upstream")),
 		OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-demand"),
 			    N_("control recursive fetching of submodules"),
 			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6fe21e2b3a..b94fd2bda0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -386,6 +386,37 @@ test_expect_success REFFILES 'fetch --prune fails to delete branches' '
 	)
 '
 
+test_expect_success 'fetch --prune-merged: setup' '
+	git init -b main fetch-pm-parent &&
+	test_commit -C fetch-pm-parent base
+'
+
+test_expect_success 'fetch --prune-merged deletes merged local branches' '
+	test_when_finished "rm -rf fetch-pm-clone" &&
+	git -C fetch-pm-parent branch one base &&
+	git clone fetch-pm-parent fetch-pm-clone &&
+	git -C fetch-pm-clone branch one --track origin/one &&
+	git -C fetch-pm-parent branch -D one &&
+
+	git -C fetch-pm-clone fetch --prune --prune-merged origin &&
+
+	test_must_fail git -C fetch-pm-clone rev-parse --verify refs/heads/one
+'
+
+test_expect_success 'fetch --prune-merged skips unmerged local branches' '
+	test_when_finished "rm -rf fetch-pm-unmerged" &&
+	git -C fetch-pm-parent branch two base &&
+	git clone fetch-pm-parent fetch-pm-unmerged &&
+	git -C fetch-pm-unmerged checkout -b two --track origin/two &&
+	test_commit -C fetch-pm-unmerged unpushed &&
+	git -C fetch-pm-unmerged checkout - &&
+	git -C fetch-pm-parent branch -D two &&
+
+	git -C fetch-pm-unmerged fetch --prune --prune-merged origin 2>err &&
+	test_grep "not fully merged" err &&
+	git -C fetch-pm-unmerged rev-parse --verify refs/heads/two
+'
+
 test_expect_success 'fetch --atomic works with a single branch' '
 	test_when_finished "rm -rf atomic" &&
 
-- 
gitgitgadget

