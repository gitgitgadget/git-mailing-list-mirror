Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E65310636
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298128; cv=none; b=o+QSi6oq/HDk+SNR1InygAOP4Cv8JbrtxCN013/RItIQh3piuzXEe1GCJa9avw9Ia5ES80XGi77/WOFVUu/MnU2W2Wj+gp+1426vr6aqRqT/A8EIgtM7FtK/XIgWofikjJ85FU/wWgIW4vuWTDDHIf7J0f/qao7z9m1liZjUaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298128; c=relaxed/simple;
	bh=hvaFgUfinjZIgeJ3QHsxahSWfHO8GXT5K0VY9CQ/M+A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lArkG+bOZsXUqJX+IP8GinciBPRJlDa87lLWxEYw70N9p88OCo6NYHwdWnS3jXBLDinEReIJSnZcOoXb0veehoOORFBQhurAU19af93p+nB1S3ZwpjFjaFp1P+9Ipgjz6ueJ9jDDZeJZKNOpEx6VXVYUOarqFkbJsu49UF1sUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhX6b7KG; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhX6b7KG"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3f0c93ecf42so4109289fac.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 01:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768298124; x=1768902924; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4r8h+bI4iflLCMRaiiguOyi2Omzn95RD919H6vq9AA=;
        b=hhX6b7KG6JQCRfHsjFwrHxcMO9LbzP5BBi8VkPIjwr1jZ+Na1da2kJPO74jIegLLiq
         iGC3lNNs2XUE3YGEhbOsqy/+Om5irWYVFu5uZx7W/C5tkLQBLDwNHCaBorm713Q+9UID
         PBLA7RCxT28ctX1TfTOYKqiSIYFZv925y4VX6YDm+V1sizQL18Uc00R85Yk90y9H5dBz
         p0L7j6a0MJygolIp7CAoBt6w98zLo6cXcPve5g3gFnoXeaz6fO2lfa4qNpqChWjZotvm
         64fQVmOOfU9LXdSUx0jSBeHQUTfZHQinoX8k5yB6L0n9LCL14U4jp/gPSVYBNNU/RyUo
         A+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768298124; x=1768902924;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4r8h+bI4iflLCMRaiiguOyi2Omzn95RD919H6vq9AA=;
        b=BlzM6Morzoc1y7JWU2XzEke5uCrCPktjzUx+HbK6wW3Mf43thZZ2rNEL5uCMuVpLjE
         mdhzFYFS/YR05ZX/KLl2fSxQFdigUUfhPIAB9XKagbJM23GrDnLHTxG41Z9XE+wi+CiQ
         pCpGfKafNg31X6n6kmsMmK5cFghhTbsnIaI8V2cU1f3sbJ/fQiCIWLJeEE9+b560OuXy
         5G7f/ygdXfinIqKksDwVqLREKyZg3niOoybWWjyBoRr02EwE6F/j2nhfkJWqaVjuhcEV
         8G7V4Gue4rVEAg5m8uVNzsFIM7KBU4WCIcnmMpZVPEVlbei4j1yklqui7OHnlekZ+v3z
         UVzA==
X-Gm-Message-State: AOJu0YyeRT1YEwiGqg1kN7ppjfGYYqWjri7Y+JF+wv3DaNS2YoO20Xq/
	7eN66gJS0hhoBw5Op/UJDe2Z7vOSDRAIs8dOY8Rdw7WAqydZjEKlBFJodtJ99w==
X-Gm-Gg: AY/fxX6QWeS9Lf1uoQEwPb4Bw5gYAALINiz+yG3XQ/gnPL2ZCCuq3cas4GO5W8KpgDi
	Sec8ISZJQSJFFvXmBeSn4/l1EvfeMHZoJCy2LIuePrDzDiLy3aSBtgmy9m7/hZ96nxD3gop/zKZ
	+qRsbqWYPR4dE6AMMkvQX9Cg2D64hfWpzctf98f6YY9cgLCgWzEHoTFvze1cWjGJ4BMMCPz/7xw
	90mVODQAFY9vVCKcoIAVUloFBAhF2VWwEdB17p85XTqw4ojAJEVSulBbypwtO0BJYuaH4hKBedt
	Unp/G8re3GeFWic6/1g9/ivvg8maNOjCZEOu8sSEidwui0RrvHP18ZzEh8ctb4UzW1lC/VglmGh
	zEEKx2aiwclUgELCk0vbCl9rGzsNH5E39/XkEz0sANFn3IWxo9gFDCBNpCWAXT/bYwRWE8KBpeh
	S9tMfQyrBPaLR+8Q==
X-Google-Smtp-Source: AGHT+IG1zXwmWWSNDgfB6SwIj/9NNf7d48rLxlOvHvqDdkTwt5MKfmOYTonwB6UwJyaVljA7oYGfnA==
X-Received: by 2002:a05:6820:f02e:b0:65f:712f:7e with SMTP id 006d021491bc7-660f29f6f59mr1264510eaf.31.1768298124513;
        Tue, 13 Jan 2026 01:55:24 -0800 (PST)
Received: from [127.0.0.1] ([52.173.219.149])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48cb03d4sm8626597eaf.12.2026.01.13.01.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:55:23 -0800 (PST)
Message-Id: <fd05c7b7786892b2a1efe3a3daa74bb57546830d.1768298118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
References: <pull.2138.v23.git.git.1768249586.gitgitgadget@gmail.com>
	<pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Jan 2026 09:55:17 +0000
Subject: [PATCH v24 1/2] refactor format_branch_comparison in preparation
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
 remote.c | 82 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/remote.c b/remote.c
index b756ff6f15..fd592ec659 100644
--- a/remote.c
+++ b/remote.c
@@ -2230,42 +2230,21 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
-/*
- * Return true when there is anything to report, otherwise false.
- */
-int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf,
-			 int show_divergence_advice)
-{
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
+static void format_branch_comparison(struct strbuf *sb,
+				     bool up_to_date,
+				     int ours, int theirs,
+				     const char *branch_name,
+				     enum ahead_behind_flags abf,
+				     bool show_divergence_advice)
+{
+	if (up_to_date) {
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
@@ -2274,7 +2253,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
-			base, ours);
+			branch_name, ours);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
@@ -2285,7 +2264,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
 			   theirs),
-			base, theirs);
+			branch_name, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
@@ -2298,12 +2277,47 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
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
+	int ours, theirs, cmp_fetch;
+	const char *full_base;
+	char *base;
+	int upstream_is_gone = 0;
+
+	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
+	if (cmp_fetch < 0) {
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
+		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
+	}
+
 	free(base);
 	return 1;
 }
-- 
gitgitgadget

