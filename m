Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97093DE440
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270268; cv=none; b=cdP2PX4tkuaViMLNJmm4mnmyGJVY33AmECyRJzk/Y6RICBoKBboiNi8FCBCwCNEcl5yyaxCSDHWm/JayM1VfLK2S0jUteBQeczId7s9N6L8rCTkngpsfF5zrwb3ddOFyL6ZZVf9nRjzP/M7tWme9cA+p8djqdktHC7PGwXy9LFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270268; c=relaxed/simple;
	bh=9doLdqCCR8VO8bHpSRG3evo3Ugo6OKckbno5wK5HnzE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IHnp8koj/cFaSFvWyP5iv9kDOvBKiSy2iV6LAKGuaogFtx9H55ZOWfwF8KKVOesRccqIS7C+2q6vi9jT9Tq4hVl07Tp1OP3LMnxZiNO5MvOTAfX5fNbkEn1JSN4b/q7HScD0AOgkIr03sfdqK72cF3nHyVMGTNMmk9VIeOt5V5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0md4DrG; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0md4DrG"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-689f648d0adso2186691eaf.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776270265; x=1776875065; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHCBMUFaxz36CYwWnIRQgJOAB030NGCGw9Gn6QtUMFI=;
        b=B0md4DrGQMFaqmLP5wBEu2dNd6PdJUsex35FROs9jmL1w5I4fesS3SGAr7IXXVox5x
         sG736s5Fetn9vSDzr39SUfC4MyKMZrz7oGDhD3vzxmnWvcVmslvz7rwNOk8Jc04YNwdq
         vDoWaoxYEsYBreST5teNeY9kqmk0PvdHg/R0Jq0MttgbV6UpoM+gQcO1lk8A1B6/f3km
         577CSE/sS7sZzzbzXA8HcPXzbbY74MMQlw4+QlGQhATpG/yuliVzy2lAWGMQj3NA4I8l
         Iqo4imaZ2n8oT6wwktIJHl1hxEcvNXySi409d8V7QtvGbxIrVA/MChmcURDvYnVtp2rZ
         EvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776270265; x=1776875065;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OHCBMUFaxz36CYwWnIRQgJOAB030NGCGw9Gn6QtUMFI=;
        b=phtAiQsDNo13DiEqgQPsEFYBkcuwQ6UtKwBfGmEtrVJ6p46/9wHtb1GOBvkSmyf+9F
         iDBF3qJgw0n7Wuqc947nQhps1tLvyx6Mrl2c272CAo8W276WMshE55yX4Zf8Ht/MfNg7
         77LtYcGAiPpgSKPDGeJ8SPo5TNBG/NPkEL4M+2jLyDRFXgZtckW8QPiCdbpxxWP44BcW
         lmbgTb6wTNXYV26oIKeye0SwnJp0XEt9HEIK08SSZ9MZrmybwHO/Jq8xJbP6ZSCMgG/P
         4SHR5MhD7uX3qVR2RQ3Y3C+RE0m4/qbqW2L/cp7GhD3TV/rvXxEoR/9rppd8llF5o0vQ
         +64Q==
X-Gm-Message-State: AOJu0YyBm0DldO4YzcUfIGO+B1fD3XGRNa/wv8tOEXpcPHgzAgDHZ8qD
	JZ70GYpT4KmP2RPWevSMu3G4ZB8VNst49knV7E+BlUyIJz2Xu3XjGE7UE1bnvg==
X-Gm-Gg: AeBDieu8TXSo4SCyoUeMuGH1jG68sv3f8Xmkcv5f3InkJ2igIaCtjdcNkywc/0SpVOj
	2zsjS6K57TsNsXKmhRYO6aAni+sOy1YIRq5mgbElfOAFNb/+LoJtNdYSIR5qdcLOpZlJuh48t3x
	NYFzUSCBQbp+GtExHgs8tPOnussP7cm5SWL10jo/+cAxD21CH2B8RyqhnbH9y4beBYh/1eqhTzs
	NL2GJMcBpMv9/2Ch7zAYWy+TwiWRwn/Mkvz4xC8bFLZRg7PFt+bYJyBEmjWnpcMj1XpxAmZ9feD
	AFn/pcTuN4NAVkCH57yC9KOTl58vd/Mlw8oZpWWiS4mnuVmpn49szn2YSHPXJq3n+vzAHTdyZgA
	WngV2b1Z7lSmABVZ+abF8/Lk6atf3ynG9XIMXY3Voe2OoZ3ElZS8ROE5qSLGwMQXZTAfFlgi7HX
	0aazYpewQvHlOmg+z1Na5JjTW8
X-Received: by 2002:a05:6820:2211:b0:693:7a6f:b31d with SMTP id 006d021491bc7-6937a6fb619mr1337404eaf.5.1776270265218;
        Wed, 15 Apr 2026 09:24:25 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.21.53])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6932dfb8d5esm1111697eaf.10.2026.04.15.09.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:24:24 -0700 (PDT)
Message-Id: <73051d1762b2a76ec59adb9a40ba344f808e5b66.1776270259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
References: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
	<pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 16:24:17 +0000
Subject: [PATCH v14 3/5] sequencer: teach autostash apply to take optional
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

