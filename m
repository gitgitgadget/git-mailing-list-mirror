Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A531229B38
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767568888; cv=none; b=kuIlO2aMxf3E5Vf0Rd3Cspwk7zi6eaiKn+c5hP8+Omn/7ek/mmScALmKo4M6F1qmWbGUmVCddCDlbgQNFmn2gfYl75vQCbbNGg1SwajNhbPtAOjhj/w/LQmpQqkoZkmfKkdvYCz8uJbOpzx7QV/gQ0b1CtgMDw6t6jQO/MN3fJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767568888; c=relaxed/simple;
	bh=0xb6GbH2ZnhWYInRD63Rq9pi16UzNFixFIy1Hfpd5cI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OVWBjRIU1hXb+817U/YU/Im/HnmGU7Qta15Bbgbzgbplev29jnrzGQ4RcFUbz2mbTFWNCfToOiiddDAYGyyRkpjlccpFVUjz8bC4+t+XZwT7BC9+fnyOindjLedk4oU3TMmFP4Uo8i+784NXnMK0Lb+fUoh0MtUVD55n8U5VVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3mIkhLM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3mIkhLM"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b31a665ba5so1518194285a.2
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 15:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767568886; x=1768173686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wxf4RNYBgkjP3iqG3fr+vZGJl96LsKv7Bf4WMkmBCA=;
        b=h3mIkhLMzqBgjUmLcV+4UurRv+Tez/RwRn6n17Wa9YXxH+/omcaezxxaMXxer5SckB
         xG6TqudkbiXp0xnEB3qSXNFQry8CvDkRZ7tnNouWYX0uvQNvRyXVAbVhPtEuCneYu7+S
         ZyWnoVGPEJH7zPDXHoX01AeZmtbXCi2dQ3xt0rEJcTEEZgvnatmILpuFoJE698680Ult
         yHfTVULzj54+GIaIPKxdwOL2oAQQJiMt3lzI+q9OX/2fnjTvCCtSkY0anbs/7SKtIRBv
         uF9dzqrBTzrNtfJIRfBXnpCLQXvIrKOUrv1Lp3KLvSFsf5ZrUUexghGSrLeG+ND3vpBO
         bywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767568886; x=1768173686;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4wxf4RNYBgkjP3iqG3fr+vZGJl96LsKv7Bf4WMkmBCA=;
        b=ul8Yr7eVkTtQsgOeq0u7W198OOgNgN7Zd3pqjJuSUiS2THb2UQftFB2QTDHfELIjDx
         bbOEsz0oUfQJSbJYG/SaL98bz5PzLKuyuELD4iwbAXfCKRRFXFp0BrPUd4TpfbSK33L7
         Vm7houmfjXScGXtbEbxH+8favzMVW6rozuOXKTGFnzY2OVLgIlB2hlJI94AMZuIJYdDe
         XXVZiERVkLFGAI5lwJtknBifqfdN1joWWJTusUveYUOEcoiWFIgC7Q9bNz0DSXokStof
         hPSbsfnOuSTbQn++Z5xbhTZAccLHIYmWK7Xaqg+GxWOCvLurmU50Z9xIyBJNxiGo3VEF
         xsig==
X-Gm-Message-State: AOJu0YwfqiQ11JZO4Awdx1r4sTiIfc/nJZBbcg219EBPNKoIqcyFhfmW
	GHH0kEttyAcdH3V+sJtnuhTDXv0xVYRazJwBQPv3NB17RM0C45E/y8F22osx/fZf
X-Gm-Gg: AY/fxX66uBumJQbT/B4wOPL2iZhoivPyvBt1vbB2h0sZAlD9C/9k6Lts6/UAsttPLtu
	uRSPLqxjXTYqnKbTm+g5sxHADa2qq+gkNks6fdQWNQ8SMYiHkPXv4ObITlKcOlLJKTto3S477oj
	RkJNbk/3LDBAxxk2UoQpFY3ALCVpIhTY15IKOW0LiJ2vh5W72F01p7CMB9gMWY+vHB7cP5xPacx
	1hK8vYSlDEhhgnCD0hVwYBprBnryGws4FUaUK9tSzopjmo/VyQQ/2gpN4E2PxCg9o5vyGqHheEE
	NfxA/Sl8uD4wDyAwXCKeJ/wpj9ejLkCh8dQE6uga5uFPZgI57g+dgCspAeD1/q3genkb2lHvSNQ
	TxxOzenFGN7R2hGahP1ja35NpWEnvzaHrPx0PgD+f3L9xzcsyy26uxe1LUMrsdBCcu2kZ0c7MgN
	VN404QfLUxVRUeFA==
X-Google-Smtp-Source: AGHT+IGcbdTgtk30BJ+jIWU0xQi4KpTUqxcHrWk3M/Ft7etk/Rpc3mEHG5VPg3sDkaSEOQOh8iZqTA==
X-Received: by 2002:a05:620a:3190:b0:8b2:e9e1:400f with SMTP id af79cd13be357-8c08fbc81e7mr6718448985a.4.1767568885676;
        Sun, 04 Jan 2026 15:21:25 -0800 (PST)
Received: from [127.0.0.1] ([20.102.223.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973ef6bbsm3650740885a.43.2026.01.04.15.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 15:21:25 -0800 (PST)
Message-Id: <cf4e9779c5d47b22bd4a04fd9b2b138d5602145a.1767568882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v16.git.git.1767568882.gitgitgadget@gmail.com>
References: <pull.2138.v15.git.git.1767527634.gitgitgadget@gmail.com>
	<pull.2138.v16.git.git.1767568882.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 23:21:21 +0000
Subject: [PATCH v16 1/2] refactor format_branch_comparison in preparation
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

Refactor format_branch_comparison function in preparation for showing
comparison with push remote tracking branch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 85 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/remote.c b/remote.c
index 59b3715120..b6a9e14376 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,51 +2237,29 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
-/*
- * Return true when there is anything to report, otherwise false.
- */
-int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf,
-			 int show_divergence_advice)
+static void format_branch_comparison(struct strbuf *sb,
+				     int ours, int theirs,
+				     const char *branch_name,
+				     enum ahead_behind_flags abf,
+				     int show_divergence_advice)
 {
-	int ours, theirs, sti;
-	const char *full_base;
-	char *base;
-	int upstream_is_gone = 0;
-
-	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
-	if (sti < 0) {
-		if (!full_base)
-			return 0;
-		upstream_is_gone = 1;
-	}
-
-	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
-					    full_base, 0);
-	if (upstream_is_gone) {
-		strbuf_addf(sb,
-			_("Your branch is based on '%s', but the upstream is gone.\n"),
-			base);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
-			strbuf_addstr(sb,
-				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
-	} else if (!sti) {
-		strbuf_addf(sb,
-			_("Your branch is up to date with '%s'.\n"),
-			base);
-	} else if (abf == AHEAD_BEHIND_QUICK) {
+	if (abf == AHEAD_BEHIND_QUICK) {
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
-			    base);
+			    branch_name);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
+	} else if (!ours && !theirs) {
+		strbuf_addf(sb,
+			_("Your branch is up to date with '%s'.\n"),
+			branch_name);
 	} else if (!theirs) {
 		strbuf_addf(sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
-			base, ours);
+			branch_name, ours);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
@@ -2292,7 +2270,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
 			   theirs),
-			base, theirs);
+			branch_name, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
@@ -2305,12 +2283,47 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			       "and have %d and %d different commits each, "
 			       "respectively.\n",
 			   ours + theirs),
-			base, ours, theirs);
+			branch_name, ours, theirs);
 		if (show_divergence_advice &&
 		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
+}
+
+/*
+ * Return true when there is anything to report, otherwise false.
+ */
+int format_tracking_info(struct branch *branch, struct strbuf *sb,
+			 enum ahead_behind_flags abf,
+			 int show_divergence_advice)
+{
+	int ours, theirs, sti;
+	const char *full_base;
+	char *base;
+	int upstream_is_gone = 0;
+
+	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
+	if (sti < 0) {
+		if (!full_base)
+			return 0;
+		upstream_is_gone = 1;
+	}
+
+	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+					    full_base, 0);
+
+	if (upstream_is_gone) {
+		strbuf_addf(sb,
+			_("Your branch is based on '%s', but the upstream is gone.\n"),
+			base);
+		if (advice_enabled(ADVICE_STATUS_HINTS))
+			strbuf_addstr(sb,
+				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
+	} else {
+		format_branch_comparison(sb, ours, theirs, base, abf, show_divergence_advice);
+	}
+
 	free(base);
 	return 1;
 }
-- 
gitgitgadget

