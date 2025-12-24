Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B95313267
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571597; cv=none; b=Nnh7OtayeSr79HXI/XcW5EEZWkzpca35hdjOn4t6TMhsG6YBoLSYC4PEM7TGryFMU3Gft190D9GMyPFAi4/e0nIj9u3fPbH5+PrvjdC8BABeCVut9U26wCrkIdpcu1ni9kJE/3Gjz1iQNg4jqhQax6zXhRxXCirG6s6PLOvq3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571597; c=relaxed/simple;
	bh=R6cVNSGf6cv+Q0Bp6XhJtfldfDQPLLJUxcWhQJTC8Ds=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ktsre2cB15+E3f9F9aa/7vC0zoEcbWtfn9LJr3Nee2le44HgHEUqsP/Q/qZOgn2WJoWTkxWkWBb0Fx5B1b9FowBg67uCWh2VDBIlz0u6hXuK9sQxpS8RBe4bwS6zFWeGqlePrJ2HPkYJvc7ccNVnKiveiT65NaNahCZCXeRNt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mg/QtQw0; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg/QtQw0"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2627269d5so626873085a.2
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 02:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766571594; x=1767176394; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK3Nyt0Spl7S5ovEhMaOrBfJxy4qKpKBc+fBFhbb5tI=;
        b=mg/QtQw0d6fvZTN87VJOiTP6XLLgURkiXFeOFKyJuqOCoPgqjse2am6aP9RPW3F2ao
         JBdPT2KuczjK1kSBd6kWy+K8nmLMn721DyHfnWAgfpIWEuOCSzlw2IFxEZk1FhVns1QT
         P4y/bW1lWjl7iRfZBaHeNrx6AQImy4PQDZ5/Ah6PKjby6AK5tZ7NQLaepPbj9Vv5H3cz
         0ljBRAUeTW3zAhOiz4WFoqShD+llDxUSpTJ3ENrC3916c+g0uEHbKOgvf4PpcHJA8ruF
         ztn6gUIS9ZeXKWqTThH32ZNYp5NM9Nve+yS6Mbm3Mrb+f6WNbVx/7k2Wt5G7f6u0IWmI
         tt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571594; x=1767176394;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HK3Nyt0Spl7S5ovEhMaOrBfJxy4qKpKBc+fBFhbb5tI=;
        b=jJD2RDX8ixRxqK50ig/7YjQ5plGvQmyG9KU2CfmB4y15i9cQvmitgkAmRoOZTJa9u/
         ZYjpHpWaw500Dfe7B+zhPG3DblMjA232Ogk3cdmmIhCnE4DCcS7j1+QiGc4ZX06Pyrh8
         N94mmKsvZ9shagoKdZ/22tWkQEyqmRNRZe3YHLBRAYUAOFD1YgC+ijHaiXh0LtaEB5Wa
         vWxzVfoCk2H5xWFS+brbLVumKTLjCro5h/8UbJ+B/0K7/etmWfTHKlfAi7xfEN/vy+cQ
         WWIi4F6TnaJ2tWXPnRlxgn3qMwIlipQPFzlnicGk/hG6jWeyuSe+QvQJV7hVwJhOmzfh
         nF0A==
X-Gm-Message-State: AOJu0YwyKIQLE945g2LAr4mXdST4fXj71EgRqPRlQZUuH46X0LWvlerG
	5QFVMG4+v/cvIXvuJsOFhPcE/uxOfy/hhsMbk/1qHwQNRgAeRiE44caVwvWrug==
X-Gm-Gg: AY/fxX5IRp/cxsKFY0PAV/1ZRbwpOSE5TXUnXM2d9YMVtLxMnN7fYscwu5YveoTMbCX
	Ag9VhkoSw3BRHyQUSkMb/GQwOTgYinIsJtvtyqYdvyWCy4M65hjouXOMCg59rAwXhmamQkH5ZjQ
	jPQO1oh/UTv7G2OI8d5c18vYntA0FaPnS2f5jx9s60jeZNeG1rgEy4RBtody5nMqDYwas/J1ufo
	+jQM6kpptfB9GTA+5NJ8xsBfrTeNGudPD3O2mRILxxAIHtmpN/yOcmFbN6piUzMUSEp++713j7F
	+39hiQFcyZnHiwYVCe1kb80lb7BT88CZFxfZb/WlWOBVdNKB5ZYNFrl+PoHGpP6fx7qH6B96YRa
	V6SZ5p8rthLF85+0oNeDMhdHQkAMxqu28ZVmIIJd3kv078MDlB2hP8VE2Ri4GhYSh9hxhsM2yAp
	tHcItWvfwS8hdE9g==
X-Google-Smtp-Source: AGHT+IE3NZYBom4UNCTAOZJ/HvK1xOV+QNUZ9amZGmJs0FSRwHZPhuI1NMvVAp6S1BAAWNF5y/JfgQ==
X-Received: by 2002:a05:620a:3196:b0:8b5:9fc7:812b with SMTP id af79cd13be357-8c08f654cbamr2632093385a.6.1766571593655;
        Wed, 24 Dec 2025 02:19:53 -0800 (PST)
Received: from [127.0.0.1] ([64.236.142.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783657sm1455552485a.1.2025.12.24.02.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:19:53 -0800 (PST)
Message-Id: <0e308141da0b639ba4ba15c640b8e4260689a42a.1766571587.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
References: <pull.2138.v3.git.git.1766568665.gitgitgadget@gmail.com>
	<pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 10:19:47 +0000
Subject: [PATCH v4 4/4] Rename default_remote to goal_branch
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

Rename variables and functions from 'default' to 'goal' to better
reflect that they represent the goal branch from config rather than
a default remote. Also move the goal branch lookup to where it's used.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 63 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/remote.c b/remote.c
index edb6d374e7..99c0e18df4 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,7 +2237,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
-static char *get_default_remote_ref(char **full_ref_out)
+static char *get_goal_branch_ref(char **full_ref_out)
 {
 	const char *config_value;
 	const char *resolved;
@@ -2253,8 +2253,11 @@ static char *get_default_remote_ref(char **full_ref_out)
 		return NULL;
 
 	slash_pos = strchr(config_value, '/');
-	if (!slash_pos || slash_pos == config_value || !slash_pos[1])
+	if (!slash_pos || slash_pos == config_value || !slash_pos[1]) {
+		warning(_("invalid value for repo.settings.statusGoalBranch: '%s' (expected format: remote/branch)"),
+			config_value);
 		return NULL;
+	}
 
 	strbuf_addf(&ref_buf, "refs/remotes/%.*s/%s",
 		    (int)(slash_pos - config_value), config_value,
@@ -2277,38 +2280,38 @@ static char *get_default_remote_ref(char **full_ref_out)
 	return ret;
 }
 
-static void format_default_branch_comparison(struct strbuf *sb,
+static void format_goal_branch_comparison(struct strbuf *sb,
 					     const char *branch_refname,
-					     const char *default_full,
-					     const char *default_short,
+					     const char *goal_full,
+					     const char *goal_short,
 					     enum ahead_behind_flags abf)
 {
-	int default_ours = 0, default_theirs = 0;
+	int goal_ahead = 0, goal_behind = 0;
 
-	if (stat_branch_pair(branch_refname, default_full,
-			     &default_ours, &default_theirs, abf) <= 0)
+	if (stat_branch_pair(branch_refname, goal_full,
+			     &goal_ahead, &goal_behind, abf) <= 0)
 		return;
 
 	strbuf_addstr(sb, "\n");
 
-	if (default_ours > 0 && default_theirs == 0) {
+	if (goal_ahead > 0 && goal_behind == 0) {
 		strbuf_addf(sb,
 			Q_("Ahead of '%s' by %d commit.\n",
 			   "Ahead of '%s' by %d commits.\n",
-			   default_ours),
-			default_short, default_ours);
-	} else if (default_theirs > 0 && default_ours == 0) {
+			   goal_ahead),
+			goal_short, goal_ahead);
+	} else if (goal_behind > 0 && goal_ahead == 0) {
 		strbuf_addf(sb,
 			Q_("Behind '%s' by %d commit.\n",
 			   "Behind '%s' by %d commits.\n",
-			   default_theirs),
-			default_short, default_theirs);
-	} else if (default_ours > 0 && default_theirs > 0) {
+			   goal_behind),
+			goal_short, goal_behind);
+	} else if (goal_ahead > 0 && goal_behind > 0) {
 		strbuf_addf(sb,
 			Q_("Diverged from '%s' by %d commit.\n",
 			   "Diverged from '%s' by %d commits.\n",
-			   default_ours + default_theirs),
-			default_short, default_ours + default_theirs);
+			   goal_ahead + goal_behind),
+			goal_short, goal_ahead + goal_behind);
 	}
 }
 
@@ -2323,8 +2326,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
-	char *default_full = NULL;
-	char *default_short = NULL;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2336,14 +2337,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
 
-	default_short = get_default_remote_ref(&default_full);
-	if (default_short && !strcmp(base, default_short)) {
-		free(default_short);
-		free(default_full);
-		default_short = NULL;
-		default_full = NULL;
-	}
-
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2398,13 +2391,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
 
-	if (default_short && !upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK)
-		format_default_branch_comparison(sb, branch->refname, default_full,
-						 default_short, abf);
+	if (!upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK) {
+		char *goal_full = NULL;
+		char *goal_short = get_goal_branch_ref(&goal_full);
+
+		if (goal_short && strcmp(base, goal_short))
+			format_goal_branch_comparison(sb, branch->refname, goal_full,
+						     goal_short, abf);
+
+		free(goal_short);
+		free(goal_full);
+	}
 
 	free(base);
-	free(default_short);
-	free(default_full);
 	return 1;
 }
 
-- 
gitgitgadget
