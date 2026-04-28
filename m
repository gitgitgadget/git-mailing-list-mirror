Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C247B41D
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401562; cv=none; b=lDimecWckymoeyXAKJr6Fb6OkDkvmiiHQC8sqQllf1GDOEJekrqZmwUSwuJULKrJH05LJlAjjbtQSLBqxDev4XihOdmGYIr78KSfpz4uExfr6Wirw4r+lFDC8ICcPDQg3IH0vyukYf4tAQDPE/2zfhC5/VhhMApOX73UuApbkHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401562; c=relaxed/simple;
	bh=9doLdqCCR8VO8bHpSRG3evo3Ugo6OKckbno5wK5HnzE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OQ7AIUlLYk3qLQ+E8akXL8XZqM24hPhW6pmURMA0jRiN+SjSXiCnIifCl3v3OelntZm1h1YPwHfh+2CRUd830fpcj4WLMhrHhmH67ahJAdatbSi+jyj8aTI16m3gWuZm9P3elil5eZAxSe7vjIckyRJ6Xf/0lKz0sQftz2ZO8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gis+22f7; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gis+22f7"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so4499316eec.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777401560; x=1778006360; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHCBMUFaxz36CYwWnIRQgJOAB030NGCGw9Gn6QtUMFI=;
        b=gis+22f7J2pWVD5HAyPu9Y21kmPbWlohkDRFYx7AFkJL8PlAQpu8bMkKC97wO6agYO
         8pXeN1kLxukEaDtniItfmECueBif0DAp9ziUTNkJ4QLCZNq25EqGCAgbS07nRrs71Ox/
         64mIqaKMypsQX3CEI6K74AdPsn0KyOueLAqOF6P38r5QWyCfVlkWTYYjxnBstmZEqA+3
         9MTL0/+EBYuLJzUiO6H1efrHf3rUuPLjoWJvN08JanUBkUoSQN3PXPRkDVwuO3HiOJFs
         WElJpP7F35zTV/8NsvP7Sl5PArkeu/4jR3LIDnDvigSi4UvpPCjq/MUwdAyxLHCEFu56
         Y7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777401560; x=1778006360;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OHCBMUFaxz36CYwWnIRQgJOAB030NGCGw9Gn6QtUMFI=;
        b=W4jaR7E8UXaCjmb3dpa1LrBe6RwdgrnVWYoVEabzfZWhgQLy1fvVO3tgBY/8rY/E3+
         qMLABGBBI9q/sYwyNblzaM9LKaLo37KCSdBupKbG/HF/5lDZy4U1h1/JjHneGAeC78gJ
         Jx/x4SSGkgVayEv4CDCgVBrpeQRvcDqo9uyPlK4TVY9hkQJ4HLN1wACvXO9thQfUGNmf
         swunfq15yUr4w36ISpCh36WeRaOiOpwHsIUjAMxOxvMoRFexWkyU4hQyhkusdhNif2Df
         pwOAZYMcPtwan6YegM7OipZaAlYGZ75h8l6HcOVQT10xypMDNxqHHpZuE44EEh9+uWiK
         YDMQ==
X-Gm-Message-State: AOJu0Yxi9182PJLPMfQV+Ca+hUxzE241ufPvMpsAZRSjdDbuvk5HosHL
	h1jaDR0ZWe+oorbP94WV9zltIoarWjFdqdCcqF96ehGaO9ngoUYd+jJvqcaCug==
X-Gm-Gg: AeBDieu3RfGgRbZ2soW4BgmnXTaHJhwRSuSLrS/i6QAEra2D93H0PR4OykG7wxqBd3V
	2bhGd4nuudcjq3CisabHcL5l2NHhfNtcLLI+kaezr39f8H8hluCAp/GrXaEujykcF0d0J67r0Nq
	XSkPzDKx6W/MJUqAmLL4hnf4D2IGQqaCj/D7Gz4pQMKvI+ADlkihpK6KJRvbBRN0Z3fXvEoveyV
	lknjuiHYGQOEVBhbEQSCmQ+D64SLxTjZADe5+HiyoXkDVUAtmuPvTWPPi9yj5AzHanZtX+/X5dl
	LJnglMOu/9FOcq9KMnrqgMddzh2kmE3X0t3QN913BitcHHbSEegtXFQ6flb/2jLqYohv0eI+Tzu
	HjHRFL8o673wJUXBosD/P72WCnnac8stmIIev2HkrsKuPeT5/S6eIxalkT5EoNLkZd2MebrW6iV
	5PdYiRzsyybK0+wXYxKMEgSfess47rX0Un0yz/
X-Received: by 2002:a05:7300:8628:b0:2e6:e7da:7c30 with SMTP id 5a478bee46e88-2ed0a0f1139mr2233885eec.17.1777401559842;
        Tue, 28 Apr 2026 11:39:19 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.83.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a13eaafsm2720785eec.28.2026.04.28.11.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 11:39:19 -0700 (PDT)
Message-Id: <a428ce73281dd288f0c4f44c4f92c03129556b7f.1777401552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
References: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
	<pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 18:39:10 +0000
Subject: [PATCH v16 3/5] sequencer: teach autostash apply to take optional
 conflict marker labels
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add label_ours, label_theirs, label_base, and stash_msg parameters to
apply_autostash_ref() and the autostash apply machinery so callers can
pass custom conflict marker labels through to
"git stash apply --label-ours/--label-theirs/--label-base", as well as
a custom stash message for "git stash store -m".

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/commit.c |  3 ++-
 builtin/merge.c  |  9 ++++++---
 sequencer.c      | 38 +++++++++++++++++++++++++++++---------
 sequencer.h      |  4 +++-
 4 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a3e52ac9ca..28f6174503 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1979,7 +1979,8 @@ int cmd_commit(int argc,
 				     &oid, flags);
 	}
 
-	apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
+	apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
+			    NULL, NULL, NULL, NULL);
 
 cleanup:
 	free_commit_extra_headers(extra);
diff --git a/builtin/merge.c b/builtin/merge.c
index 3ebe190ef1..aacf8c524e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -537,7 +537,8 @@ static void finish(struct commit *head_commit,
 	run_hooks_l(the_repository, "post-merge", squash ? "1" : "0", NULL);
 
 	if (new_head)
-		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
+		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
+				    NULL, NULL, NULL, NULL);
 	strbuf_release(&reflog_message);
 }
 
@@ -1678,7 +1679,8 @@ int cmd_merge(int argc,
 					  &head_commit->object.oid,
 					  &commit->object.oid,
 					  overwrite_ignore)) {
-			apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
+			apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
+					    NULL, NULL, NULL, NULL);
 			ret = 1;
 			goto done;
 		}
@@ -1851,7 +1853,8 @@ int cmd_merge(int argc,
 		else
 			fprintf(stderr, _("Merge with strategy %s failed.\n"),
 				use_strategies[0]->name);
-		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
+		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
+				    NULL, NULL, NULL, NULL);
 		ret = 2;
 		goto done;
 	} else if (best_strategy == wt_strategy)
diff --git a/sequencer.c b/sequencer.c
index ff5258f481..7c0376d9e4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4727,7 +4727,10 @@ void create_autostash_ref(struct repository *r, const char *refname,
 	create_autostash_internal(r, NULL, refname, message, silent);
 }
 
-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
+static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base,
+				    const char *stash_msg)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
@@ -4738,6 +4741,12 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		child.no_stderr = 1;
 		strvec_push(&child.args, "stash");
 		strvec_push(&child.args, "apply");
+		if (label_ours)
+			strvec_pushf(&child.args, "--label-ours=%s", label_ours);
+		if (label_theirs)
+			strvec_pushf(&child.args, "--label-theirs=%s", label_theirs);
+		if (label_base)
+			strvec_pushf(&child.args, "--label-base=%s", label_base);
 		strvec_push(&child.args, stash_oid);
 		ret = run_command(&child);
 	}
@@ -4751,7 +4760,7 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		strvec_push(&store.args, "stash");
 		strvec_push(&store.args, "store");
 		strvec_push(&store.args, "-m");
-		strvec_push(&store.args, "autostash");
+		strvec_push(&store.args, stash_msg ? stash_msg : "autostash");
 		strvec_push(&store.args, "-q");
 		strvec_push(&store.args, stash_oid);
 		if (run_command(&store))
@@ -4782,7 +4791,8 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 	}
 	strbuf_trim(&stash_oid);
 
-	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
+				      NULL, NULL, NULL, NULL);
 
 	unlink(path);
 	strbuf_release(&stash_oid);
@@ -4801,11 +4811,14 @@ int apply_autostash(const char *path)
 
 int apply_autostash_oid(const char *stash_oid)
 {
-	return apply_save_autostash_oid(stash_oid, 1);
+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
 }
 
 static int apply_save_autostash_ref(struct repository *r, const char *refname,
-				    int attempt_apply)
+				    int attempt_apply,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base,
+				    const char *stash_msg)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
@@ -4821,7 +4834,9 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 		return error(_("autostash reference is a symref"));
 
 	oid_to_hex_r(stash_oid_hex, &stash_oid);
-	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
+				       label_ours, label_theirs, label_base,
+				       stash_msg);
 
 	refs_delete_ref(get_main_ref_store(r), "", refname,
 			&stash_oid, REF_NO_DEREF);
@@ -4831,12 +4846,17 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 
 int save_autostash_ref(struct repository *r, const char *refname)
 {
-	return apply_save_autostash_ref(r, refname, 0);
+	return apply_save_autostash_ref(r, refname, 0,
+					NULL, NULL, NULL, NULL);
 }
 
-int apply_autostash_ref(struct repository *r, const char *refname)
+int apply_autostash_ref(struct repository *r, const char *refname,
+			const char *label_ours, const char *label_theirs,
+			const char *label_base, const char *stash_msg)
 {
-	return apply_save_autostash_ref(r, refname, 1);
+	return apply_save_autostash_ref(r, refname, 1,
+					label_ours, label_theirs, label_base,
+					stash_msg);
 }
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
diff --git a/sequencer.h b/sequencer.h
index 02d2d9db06..3164bd437d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -235,7 +235,9 @@ int save_autostash(const char *path);
 int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
-int apply_autostash_ref(struct repository *r, const char *refname);
+int apply_autostash_ref(struct repository *r, const char *refname,
+			const char *label_ours, const char *label_theirs,
+			const char *label_base, const char *stash_msg);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
gitgitgadget

