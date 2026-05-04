Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F253E715F
	for <git@vger.kernel.org>; Mon,  4 May 2026 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919260; cv=none; b=bw1ap1Hg6A8eQoHh5MN9ABQSWxYbHmQ8mNfq8ovUTuCSjtB1tD6/SZhAhqoffA5Vsk1MaBVtNsYDdXEouB3xJ/veyUnTQ0RDRdAxstSftwPoqazQxJUPDbx8XcE+hA9ApT3FkGJB8oyyCX1mdWs3IdGLSzUWVMmzmil1fBNqPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919260; c=relaxed/simple;
	bh=qMY8Qha49M7X/2xXprXOqudKnL65l3YH/0xpufgT+LM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nG+qcUMMllNStSVr5mbq5mT7QvV3uxF4uvmXW4sK2o4JkHNShf12S4ITG4FzuvzvisvNMFnUhvVlCUxPHelwEZbVvbC9CRPoskuOMtcURa50CCqwk2NLBH9dlw5z9BfzgARhSH3Ef4+nPFh17AuQEsE1/sef/jUz0Y14p3JkNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip9Odkmx; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip9Odkmx"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79ab5fd969aso47167157b3.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777919258; x=1778524058; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBb91yolBM1qBTXwCNcbCbFvq405A5jzr5dLYNVo/ns=;
        b=Ip9OdkmxqLuhPGsU7RJoNCdluYJoYVOpAWDHxC+jgIB0eLSpWhwuFOkKbxq9I0tZWo
         jm+vh0tq/CZDvoEkakM2LXzzqo7B+RAKxW9OHrHS00FIZne/Zr6Jwb+XU5+zewow9dJ0
         bMNv81qpCp63lKxSef0KLbcUb2a/6PIyFqSI4FrTKTFOV/6Xdi8fPHPf0HFcNAJnnkrp
         8vh4Q0ODH2Hy6HAGvS9XxmMvVPXfCPqWu/rBe00QAFk3hUh1dQcS6I073W5rDD606XWD
         hfizwxWzecuBX26Tj0VgZIiUdLLB71eK0AlzdsSoCIzuszgGGRCMvOGLJIq3v9U+/gyY
         PxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919258; x=1778524058;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBb91yolBM1qBTXwCNcbCbFvq405A5jzr5dLYNVo/ns=;
        b=Aavkfl5/sWw+vaI12apsYJNMI9x/EAJx6vRpT0ENX46q/6v4/7X9x5P2FJFEcXTb0x
         R83wkjXXwRxMpr0SrvdH1ON/EnJZQq46Z4KH5Dq64L5huNB4QLoBi1pWmUGKR7y8o9V2
         vXvRur9mareSMVHpOkax59nFGF7zXpI9Y9m1AuxNDROzJDxegOSxssx5C4e0m0WgYmDI
         1YBcYL0NeIq5+26pE+GrOfTRtXw2eMoq6OxjY2REgXo0v3gbO29E99UDStfnzCjQF/cJ
         M9iRyZlaEsmooOgCFg2csCikqTnenKzkz/0a1npmqCkh0m3asFtFvF/YlPsyg6GTU1ky
         NYzA==
X-Gm-Message-State: AOJu0Ywb0CY7r1D7Gop0P5y3TPjaYAUnOUcY7rIsPQq4npXvlbWvFaJ0
	MzFh2yIC5NZvgjjeoIPBLLuShTaMH4C46M2DjMxZj070FBxjemlRn1IYIYopEw==
X-Gm-Gg: AeBDieszF7wJnNfhhjAXMxuME4N54C4VUI9FIpSn+AHkAn57DZA1Yu3Q6r+w3jWUt7k
	mWd5Hk+3pgsiVV5axuNS3ROp19IVk+V2fqDPcPy/lNP0yuvEgyZ2M1AFrvTc2z7LEj8w5THrzhU
	oy4Jnjc2kchlHFyUEfNjooBxU8qFh1F+a4aWhUP4Vv8lJ8pijjm4/RENO6CT5lfiNFhZswzSTF/
	//e8tt4vyjTnTqWrGmjFqsk1+l2ZAY5gQindwKhrfcEtV0ukwhS3mdAsktJgYvkpZUX7i3cko8q
	sgqDe/DxREzHcvN3Ys8lbJ94RDOcWF57kAxsCpsWlVddJGNBu6wtD0AFIj280YhVZb0NW9u9Zpi
	C79/DX7Gkq1jrv5p2jCQxbqnFlTTM7UoUaguQVpka8oGcTbWjpWk8KKJPthAuGP7mjFt2a1dwRQ
	/YPeNC6Op39GmjvVXkdKIeKxQ/uuGQdGcIDFo=
X-Received: by 2002:a05:690c:e3e1:b0:7bd:577d:7828 with SMTP id 00721157ae682-7bd7708abdcmr113527597b3.31.1777919257338;
        Mon, 04 May 2026 11:27:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.30.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538a293dbsm144458936d6.2.2026.05.04.11.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:27:36 -0700 (PDT)
Message-Id: <e979fd238bdffd772783f47f42fdc6d8c2dc0205.1777919250.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
	<pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 18:27:28 +0000
Subject: [PATCH v2 4/6] fetch: add --prune-merged
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
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
index 81a9d7f9bb..d863a9184e 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -185,6 +185,14 @@ See the PRUNING section below for more details.
 +
 See the PRUNING section below for more details.
 
+`--prune-merged`::
+	After a successful fetch, run `git branch --prune-merged
+	<remote>` for the fetched remote, deleting local branches
+	that fork from this remote and whose tip is reachable from
+	their upstream remote-tracking ref. See linkgit:git-branch[1]
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

