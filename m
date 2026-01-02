Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F432AE70
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767389654; cv=none; b=N8QEcsR+rNimVADQZhL8rUEGiUfqCck2Vwa9Cde7A5iBZnrknpmimWtLF67rBLD1gRTffgAKa1iR7Vd19uAtbc/Ba1Lh94HJG189OOB5Tde6PL9v+T89SAykHgyvrUZQOOgHH/8NWak8zIunxmvv5uCtCaF/ABY8rG30JhI3KvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767389654; c=relaxed/simple;
	bh=tcH5+CUWBmTQCgiXBJmr/VW/kxfccqr681MZSkzLP8s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HdX6/mynhCwsJr4csJ2bLjXTlfjL0618tLvZ+wMpK7XmDNZdNR5/Vv7p0UaKln4wvrhRb495Hh0kVqXDT4+B9OBpAkdhl6X+uZf27obF22tRPUTQf77Z+YkHDWnegLubStg/wKdYdkQ454qDUhJ1j3HF/b6EwuTW9V+JuR0OZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3Qe+rJx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3Qe+rJx"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2ed01b95dso1286185885a.0
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 13:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767389651; x=1767994451; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLPE4AzX7YbA+Eq0Cqvp2egi7K2VhlnSwXL2R17dGLY=;
        b=d3Qe+rJxB2gxDkU5Ws9H6o4TWcqvjWUaVK+56bcX9l3Tm/31eFUOuWIREArwFDATf8
         j6YGh+bdT6RwdHQhj1oReEongLbG+HPAKOWvfRHEHAfFI4UBGbc/iQhRmNGwhMxuIebO
         9tRvPTx0j9cJFtKq1yxBPjmB/wTvo4ivhR2oGtvdGFKB8j12OlSnyamnWoixVZEZmVsP
         R4XELRJgtxGXYzm/apq4uXS4cT0ynZx6HK9YCCxzjYfnA8jEkpphKCaUZ9JinXLcOpQp
         bd4NbLZRaDZBmz2g88v3itPsWkJ5kJMFXrhynbrXMsyPA0s1MPKmfmTamAuzmZrY/2Yc
         etyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767389651; x=1767994451;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bLPE4AzX7YbA+Eq0Cqvp2egi7K2VhlnSwXL2R17dGLY=;
        b=kFY2XtgAmrdK8WIo95a9SV0hiK0i/8Jz4I4q3vu9NkxiNS68NCT3CYg+OgVW3jQ40R
         C18CyYclt2uFZR2V7iwLfg2iJWovwWkqmIzU2Z4B8IcXZF6HZi2PrK4eYP1jscfh2KbF
         1cuFk/gLjLDdd9ZzttN8EvTqW92yFcrwjrR4sBMTax47g0CHGHiER2F8ju3F895Xg5ZC
         Lk+M0PrN/P0xn7elODskXSpoioMTXePuJwnKLKaz7ZppR7iUnpXlQ35Ye7Ycr9wNFXGI
         dVGXdoomrbXr9WKqpYJLiIErZdrRgcNXhyWlmmrwBw0WsbUJXz4Yhy+BWbntKg479vP9
         /XTA==
X-Gm-Message-State: AOJu0YwFqD3cKK2Ln7xXjNlNj9EKkcVLcy4mFceqITkcfbYcvfOXQyci
	MZZv0SHFqfBGh8LcpREuMWDDfpQAOYr1x1VHQVitQFJyaQuKiX8ivIh6csCHIcky
X-Gm-Gg: AY/fxX7VuY0PcNyfYr2sS6H97TTsLDPKC/QRuZo9lUxyewIFWOqC5rOWBKd+A0SBonH
	W0Qi0dazLGdOsla31xlW1XUjZo1GA+/ZRoadGUHGYGYIWcRsUP6WuqWQDD0Ar7E9PeL0vITX9Nf
	Wl29HaTc92kfqeTvW/7xJlDhF+C+PB84IgEsZ4e1+h5Si6/+CYvuiyGdX0vB1r/PMZ7gPMkc8XP
	FJG4KOX7taneR6olEv6PrwwAQjhRpEYRtdP3GMTcnr0k2Z3W1PMZ+whCwLCQZZtpoCqrdH+wrsV
	nDqopyKq6EEX/tY3fv1j/RGS+l474oBHqPF2txkXIhwB+YG7uBLi0mymLwCmHGL5jJzCjjy6AKc
	gbw2Mz40Be/SbNK7/UhsLOPqet1C21SEomX7nZzYtncV8Oe8FDwEJGkVMGT1eAsCvB7OhsWPcDl
	iaqYHROOKs7zoK
X-Google-Smtp-Source: AGHT+IEs73jEBY6ReAZWSj58Gjpy7VJCfIBQFwHmbMG/FgFDPS0pavzhQUu7yrvfTxTU6h8yZ7xLDw==
X-Received: by 2002:a05:620a:469f:b0:8b2:e922:528a with SMTP id af79cd13be357-8c08fc0d556mr6461900185a.19.1767389651353;
        Fri, 02 Jan 2026 13:34:11 -0800 (PST)
Received: from [127.0.0.1] ([20.161.70.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fe5sm3278328185a.26.2026.01.02.13.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 13:34:10 -0800 (PST)
Message-Id: <a2c160c53ee0159a88234c64409f2a216d584cc4.1767389649.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v12.git.git.1767389649.gitgitgadget@gmail.com>
References: <pull.2138.v11.git.git.1767352663477.gitgitgadget@gmail.com>
	<pull.2138.v12.git.git.1767389649.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 21:34:08 +0000
Subject: [PATCH v12 1/2] refactor: format_branch_comparison in preparation
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
 remote.c | 99 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 40 deletions(-)

diff --git a/remote.c b/remote.c
index 59b3715120..58093f64b0 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,66 +2237,50 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
-/*
- * Return true when there is anything to report, otherwise false.
- */
-int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf,
-			 int show_divergence_advice)
+static void format_branch_comparison(struct strbuf *sb,
+				     int ahead, int behind,
+				     const char *branch_name,
+				     int upstream_is_gone,
+				     enum ahead_behind_flags abf,
+				     int sti)
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
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
-			base);
+			branch_name);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
 	} else if (!sti) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
-			base);
+			branch_name);
 	} else if (abf == AHEAD_BEHIND_QUICK) {
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
-			    base);
+			    branch_name);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
-	} else if (!theirs) {
+	} else if (ahead == 0 && behind == 0) {
+		strbuf_addf(sb,
+			_("Your branch is up to date with '%s'.\n"),
+			branch_name);
+	} else if (ahead > 0 && behind == 0) {
 		strbuf_addf(sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
-			   ours),
-			base, ours);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
-			strbuf_addstr(sb,
-				_("  (use \"git push\" to publish your local commits)\n"));
-	} else if (!ours) {
+			   ahead),
+			branch_name, ahead);
+	} else if (behind > 0 && ahead == 0) {
 		strbuf_addf(sb,
 			Q_("Your branch is behind '%s' by %d commit, "
 			       "and can be fast-forwarded.\n",
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
-			   theirs),
-			base, theirs);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
-			strbuf_addstr(sb,
-				_("  (use \"git pull\" to update your local branch)\n"));
-	} else {
+			   behind),
+			branch_name, behind);
+	} else if (ahead > 0 && behind > 0) {
 		strbuf_addf(sb,
 			Q_("Your branch and '%s' have diverged,\n"
 			       "and have %d and %d different commit each, "
@@ -2304,13 +2288,48 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch and '%s' have diverged,\n"
 			       "and have %d and %d different commits each, "
 			       "respectively.\n",
-			   ours + theirs),
-			base, ours, theirs);
-		if (show_divergence_advice &&
-		    advice_enabled(ADVICE_STATUS_HINTS))
+			   ahead + behind),
+			branch_name, ahead, behind);
+	}
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
+	format_branch_comparison(sb, ours, theirs, base, upstream_is_gone, abf, sti);
+	if (sti > 0 && abf != AHEAD_BEHIND_QUICK) {
+		if (!theirs && advice_enabled(ADVICE_STATUS_HINTS)) {
+			strbuf_addstr(sb,
+				_("  (use \"git push\" to publish your local commits)\n"));
+		} else if (!ours && advice_enabled(ADVICE_STATUS_HINTS)) {
+			strbuf_addstr(sb,
+				_("  (use \"git pull\" to update your local branch)\n"));
+		} else if (ours && theirs && show_divergence_advice &&
+			   advice_enabled(ADVICE_STATUS_HINTS)) {
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
+		}
 	}
+
 	free(base);
 	return 1;
 }
-- 
gitgitgadget

