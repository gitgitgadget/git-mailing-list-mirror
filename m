Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13F32AABD
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993677; cv=none; b=QM0+Y34bGZWGW5dYgYO3/5n7N9A543O9GqG0nphCbqObWUOfneCI2Aqg/im6Pv+OFBbxJZAqvJTU5ObuJ+8kBt2rCgAZa+sYcahkKEHYzXEi11Etl0yWsWaHm7f7jBtAOnUaBHs2cSPTQHR/iXfPqKiGLDB8ExjxyLtqrxlvtJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993677; c=relaxed/simple;
	bh=8GgrbZT53bgNOXlhsc7kw1J4SCLOOYKEhL/3551g3Ao=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ODoc4ZNsGZsKG2WSeUlnxdUbRnYlZC37ZcnOGINoBuc5386Ow+aT53N56+m536S3k537eDiUbPRLkNi0PpqfIRXffF3MrfI9LLVdi4RkHcQtoYzl96yeJ1pWN+YkzEwTkU6f7EgzmcuThijMFh6g7nSXkCaU3FYCryEVsoRMpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4Ed8z2c; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4Ed8z2c"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3811f512167so1278319a91.3
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784993674; x=1785598474; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zZm2zgdU+Gog6IfqVC4pB6f2DFpdN3LLiIUdON5shZQ=;
        b=G4Ed8z2cMvXsxcddgdrSWwEZ9W9pjIdH0u5bROwYy2WlKeHzsN7rUxlJaz9razSxnQ
         zsqfvr4jQrmwLpIueKh/Yv0nMvWyv2QzSeyUAk6NxQLC49ODHb/VOJ4YkgnCtS4Ryr0/
         57MwTWKjpLzJYh3fB+5drD9MG3wT5bb62Oa4P8R9/zrSZnFbnMg67ZNwi1srz8VIBu0E
         W0+p12qx16UsAxv4OMozCTadslMUB39aqCGN2Dzd+PBWHv45oOAihVJELpL7zLueJtRC
         t2zrljlB3VBM3xl0b/St6qtFCpyt8vd456KQMN57FsMGmov9jShCi6MbC1Zkq/3YNwbB
         bYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784993674; x=1785598474;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZm2zgdU+Gog6IfqVC4pB6f2DFpdN3LLiIUdON5shZQ=;
        b=Uw6U+8yZ2zX/KQqjjhEKMSDyh6OgOJRbkAyvuTM3YUhfI4m07Bs4vxgG2/rV5CbTXO
         N7KQH1Iig7tHb9Yq60b4MifuBx3zkRGzzO/Q88chMjqsLe+bX64nvOTkG7toUk+qFpBB
         vkZbT3az82iDCh9E5MwSyf1EcvPui5gDGF8znufD3U/9vRv6RblTigoYHp30nyFCUVMI
         CnrvEVswoX9zGB+MTKRQ8NvNH9CbSBgY3zIzavbH3y/ZPf7Jp3bOirzDGEu05aL+6Lnf
         q9cxnmqBYO68JHofbIVf6n/UHwYDUVNWikc5XRpjPjo0m8pDmhMLyJfSXFiOORhaStp8
         esHg==
X-Gm-Message-State: AOJu0YzBkZMMKZChDBgLie+vORMyK72/O54QgKao+fRD/5Cvg0bVDQyU
	beir/8JLBCLULP67tTZu05F8tT7b8bHfO9Loiozq3VJwp+ozEmN/NjunmzVG1alP
X-Gm-Gg: AR+sD10cZ7WsXg3Djqps1pv2Q/Zgf5zSlyqhjCnhoJMCnZLrU6SHmfzMOxdJuuIoJJK
	6HBPMyQwla1LjY7hWLUbxcfOBXUIL6xhDwyOTewUnWjoRwjOTPj8XcvIfpfPSFXHsRRbXmIgTX7
	/jC3O5KWhg3JFZyxKVdWPveyjOsNrxgcypZeZr1a7FWGk0DNgtb/QqS9eSZrTlZ8/jR40EeuXbI
	T9pFnEWUtkDh///EKLDlHQdfl2l09WAM2RLWiPyrm2ihj4aHRJlEeM7PX1GxD0davGkdNUMkE4L
	eX97/M3SxOv8Rxak6qwfJzxoaUYtJ9iWIJcGHI402eduyk2XZ5i3Zqnz80Fw7ZuwzbyJeE/N4ap
	owLeAlCD74qs1mPKtXt9ZtKGULxQ/MVaTsW1AHTzqS6w9ZDAE4EOeRDkeCSn6peKIRncYXIN/3m
	FS
X-Received: by 2002:a17:90b:3dc4:b0:38d:e658:595a with SMTP id 98e67ed59e1d1-38f293cd055mr2642223a91.2.1784993673937;
        Sat, 25 Jul 2026 08:34:33 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.7.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f292d2eafsm888281a91.8.2026.07.25.08.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 08:34:33 -0700 (PDT)
Message-Id: <b501b5fcd0b9dde65c1ce358e2f4014dfa340c37.1784993669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 15:34:28 +0000
Subject: [PATCH 1/2] sequencer: teach autostash apply to report conflicts
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

Add a conflicted parameter to apply_save_autostash_oid() and
apply_save_autostash_ref() so callers can learn whether applying the
stash resulted in conflicts.  Thread the parameter through
apply_autostash_ref() and update existing callers to pass NULL.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/checkout.c |  3 ++-
 builtin/commit.c   |  2 +-
 builtin/merge.c    |  6 +++---
 sequencer.c        | 29 +++++++++++++++++++----------
 sequencer.h        |  3 ++-
 5 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index aee84ca897..72aafa4049 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1242,7 +1242,8 @@ static int switch_branches(const struct checkout_opts *opts,
 					    new_branch_info->name,
 					    "local",
 					    stash_label_base,
-					    autostash_msg.buf);
+					    autostash_msg.buf,
+					    NULL);
 		}
 		if (ret) {
 			branch_info_release(&old_branch_info);
diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..d678a81865 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1980,7 +1980,7 @@ int cmd_commit(int argc,
 	}
 
 	apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
-			    NULL, NULL, NULL, NULL);
+			    NULL, NULL, NULL, NULL, NULL);
 
 cleanup:
 	free_commit_extra_headers(extra);
diff --git a/builtin/merge.c b/builtin/merge.c
index 5b46a596f0..cecb8fb716 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -538,7 +538,7 @@ static void finish(struct commit *head_commit,
 
 	if (new_head)
 		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
-				    NULL, NULL, NULL, NULL);
+				    NULL, NULL, NULL, NULL, NULL);
 	strbuf_release(&reflog_message);
 }
 
@@ -1680,7 +1680,7 @@ int cmd_merge(int argc,
 					  &commit->object.oid,
 					  overwrite_ignore)) {
 			apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
-					    NULL, NULL, NULL, NULL);
+					    NULL, NULL, NULL, NULL, NULL);
 			ret = 1;
 			goto done;
 		}
@@ -1844,7 +1844,7 @@ int cmd_merge(int argc,
 			fprintf(stderr, _("Merge with strategy %s failed.\n"),
 				use_strategies[0]->name);
 		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
-				    NULL, NULL, NULL, NULL);
+				    NULL, NULL, NULL, NULL, NULL);
 		ret = 2;
 		goto done;
 	} else if (best_strategy == wt_strategy)
diff --git a/sequencer.c b/sequencer.c
index 1355a99a09..91a70e39a1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4748,7 +4748,8 @@ void create_autostash_ref(struct repository *r, const char *refname,
 static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 				    const char *label_ours, const char *label_theirs,
 				    const char *label_base,
-				    const char *stash_msg)
+				    const char *stash_msg,
+				    bool *conflicted)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
@@ -4783,14 +4784,16 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 		strvec_push(&store.args, stash_oid);
 		if (run_command(&store))
 			ret = error(_("cannot store %s"), stash_oid);
-		else if (attempt_apply)
+		else if (attempt_apply) {
+			if (conflicted)
+				*conflicted = true;
 			fprintf(stderr,
 				_("Your local changes are stashed, however applying them\n"
 				  "resulted in conflicts.  You can either resolve the conflicts\n"
 				  "and then discard the stash with \"git stash drop\", or, if you\n"
 				  "do not want to resolve them now, run \"git reset --hard\" and\n"
 				  "apply the local changes later by running \"git stash pop\".\n"));
-		else
+		} else
 			fprintf(stderr,
 				_("Autostash exists; creating a new stash entry.\n"
 				  "Your changes are safe in the stash.\n"
@@ -4814,7 +4817,7 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 	strbuf_trim(&stash_oid);
 
 	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
-				      NULL, NULL, NULL, NULL);
+				      NULL, NULL, NULL, NULL, NULL);
 
 	unlink(path);
 	strbuf_release(&stash_oid);
@@ -4833,19 +4836,24 @@ int apply_autostash(const char *path)
 
 int apply_autostash_oid(const char *stash_oid)
 {
-	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL,
+				       NULL);
 }
 
 static int apply_save_autostash_ref(struct repository *r, const char *refname,
 				    int attempt_apply,
 				    const char *label_ours, const char *label_theirs,
 				    const char *label_base,
-				    const char *stash_msg)
+				    const char *stash_msg,
+				    bool *conflicted)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
 	int flag, ret;
 
+	if (conflicted)
+		*conflicted = false;
+
 	if (!refs_ref_exists(get_main_ref_store(r), refname))
 		return 0;
 
@@ -4858,7 +4866,7 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 	oid_to_hex_r(stash_oid_hex, &stash_oid);
 	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
 				       label_ours, label_theirs, label_base,
-				       stash_msg);
+				       stash_msg, conflicted);
 
 	refs_delete_ref(get_main_ref_store(r), "", refname,
 			&stash_oid, REF_NO_DEREF);
@@ -4869,16 +4877,17 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 int save_autostash_ref(struct repository *r, const char *refname)
 {
 	return apply_save_autostash_ref(r, refname, 0,
-					NULL, NULL, NULL, NULL);
+					NULL, NULL, NULL, NULL, NULL);
 }
 
 int apply_autostash_ref(struct repository *r, const char *refname,
 			const char *label_ours, const char *label_theirs,
-			const char *label_base, const char *stash_msg)
+			const char *label_base, const char *stash_msg,
+			bool *conflicted)
 {
 	return apply_save_autostash_ref(r, refname, 1,
 					label_ours, label_theirs, label_base,
-					stash_msg);
+					stash_msg, conflicted);
 }
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
diff --git a/sequencer.h b/sequencer.h
index 64a9c7fb1b..b39528b6d0 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -237,7 +237,8 @@ int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
 int apply_autostash_ref(struct repository *r, const char *refname,
 			const char *label_ours, const char *label_theirs,
-			const char *label_base, const char *stash_msg);
+			const char *label_base, const char *stash_msg,
+			bool *conflicted);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
gitgitgadget

