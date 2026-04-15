Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6834C989
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251526; cv=none; b=NR4WUHBRwGIb8JmdXvr/vFKm6mq4dnyJ4Jm+PbRZLqgQKKnM2/W9sB2faUaUNayp3VhIYNSbS3hbu0FMU3uIJVH2fQHDb5GGLe+C3EA+53XXsc9xSebrCSyleZvqUJ1NuSGbrKvR+sKVYzZydtFqPBEA9pAehzrThSi09MSXL6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251526; c=relaxed/simple;
	bh=9doLdqCCR8VO8bHpSRG3evo3Ugo6OKckbno5wK5HnzE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZSC+15HwUuj91RvWCxsEP4n1eAbLBUfozl9Go3+srE2wSWEo0EWxSAaShkrZs8zKcvn/RP6JLYcr+73cZo28jZr2NBsSmMZ6Ogu1uSZTwekM9oswTqh2ATkDz8GLnK8T2jyP1NMCOJ61G5ltQQEj1Q1yEs6Lz9aoU0V0TGbAcjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P682Kxgp; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P682Kxgp"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d68f702851so1003886685a.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 04:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776251523; x=1776856323; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHCBMUFaxz36CYwWnIRQgJOAB030NGCGw9Gn6QtUMFI=;
        b=P682KxgpyN/D+ZIWqkObxRytqkYhlwebc4/bxKVggozL/35+PvVD7SnL2MgMCoyYM4
         IX+g5HHLmsQ2CBU7eaU0zfv7A0axgJIVZwpCAg+6Dnm1l0WUbi30eBbMwQqSVwN2J5P9
         ubNGBs43O/eqo6Gly25XGf3bvTS+h+r9DHwXJpk0/tfe3HcQoH5NqvsPQoA1uWIpXPke
         vnnLIQuLnH6kTqPE/ebLnPnvLsKK6SmRbueToxEksXyJ4vhaiAIyNSSh9ZalW1pRHPV6
         65SvXCJXgghdrZlnAwaj4HbPi6q2hUxLv9/rB0iBRLRaPxgs43AdGtki3vHKbSDYYx0m
         qwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251523; x=1776856323;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OHCBMUFaxz36CYwWnIRQgJOAB030NGCGw9Gn6QtUMFI=;
        b=KW8w+NHKyAG6ioaMVfgSXaXMCqrn4Sy8n95THvtOKjX+JdTPEB/X0KgIyhS0Yu7BdU
         SgRuq7wHFSAl12N3E0GDnlxpclGb8yr6mKiO2ekUxp81vlM83Z6vXhPex7wkvlaNAzhK
         xysFKgxB9lrgSbJ5EifMI9rqJPPasjhUSFeew7pH3Cjdj6kg9fQJUWDuOlzkQ/YwSq4C
         AiohlfnbL9awDFYtmVmmCCfaXedtEzN2GRFpnqBiyDKf7bQxVr1xn3jOqPJHaUxCggdc
         PrzLyGNjce9NyduJhzkdmoySQi5qiHCuguxT0kJUpHY0Eud81WOsu44KTk2w8t00bQQL
         fAfQ==
X-Gm-Message-State: AOJu0YxtWLvIVsJg37CfoaaAAOmRDdNdo6gCPYAX4SjTetOdrXZkabpR
	OfnesUHhn48WQWWhjleYkoEE6wFOk+gGR/xv5u9gksmmcqU0wCYty/cuQkEDxfCd
X-Gm-Gg: AeBDiesCCyFG+JZGf4Z+Yqogr+oCtDJlrLRsbVeXlgxRZZPLeKniNIojgSAV39280Ch
	rtkcUBfZ4BCUMCE/829/EOSTFWK7P6co10ORj2J8KHA/reA+zwsKraeaMM9rqAG6lZaIMCer/bP
	SYLkC2NEbnjQcQZPdyVaoPDc1S+UzypCrjb4Nt+Q9XBr1t8ufPw6GSAQJqFgXWPjM9Mq4K5zbTs
	OM3D3NuOsuhAGgwJLMEa237S9MoRLWlI/WCWSuHuQYdztBn8cAk3X0uA709xdnV4Q4VysXzSQYl
	NgWAOFW7JUvJ9rkzxoV4Ns22mFFAw+e83dbcqh8vDZYgmVp/dkZCV3TMwoQSXangJvOi3BfcQhB
	8kjJyTjFZlZo2iunRFqius+Up7+uTL2UOVaYUnjb/8rQqp4FOlj4T7VRf2Qt0CnbOulQdqkcz0n
	4pPWLYLAX3TOwAkKRx3ktNaP+jKDo4
X-Received: by 2002:a05:620a:40d4:b0:8cd:93b7:ec10 with SMTP id af79cd13be357-8ddd06966afmr3088520485a.64.1776251522491;
        Wed, 15 Apr 2026 04:12:02 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.227.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33bc4csm92224385a.12.2026.04.15.04.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:12:02 -0700 (PDT)
Message-Id: <b279d1dac8f61cfd60b09cee7996f9b17c11cd3d.1776251517.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
References: <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
	<pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 11:11:55 +0000
Subject: [PATCH v13 3/5] sequencer: teach autostash apply to take optional
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

