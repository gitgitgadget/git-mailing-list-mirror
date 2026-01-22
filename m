Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87D34F48D
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112485; cv=none; b=JNHCZsKmKU3tzduwwDpVOx0PtqB9yNdqC4dkVaNvSQNn1fp5heHklS3B4VNiKFi0xoWVyxY5B4qDKGw4BVhWTT05Fka0Px6/EZXQTzKaqCi8bCRfxAKstB69u1Wh+n3NduM6fz5tPs6woBdG4gQ27McnkhHXBQwkxEx6tzMD7Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112485; c=relaxed/simple;
	bh=hvaFgUfinjZIgeJ3QHsxahSWfHO8GXT5K0VY9CQ/M+A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B2jAsDwh0SkM76o7hwq/PJhddpuoyUlKAtB/443/usOxAR9qY0kJCyEj0zIS4sH4CExLhV4NnN44VIiK1EHAWY680U4pt2Ml6KDIMtvHGGFH3gss7TlmBbJCRRXHGRYNukMFYvK6VZl6WVQoq1iOVxYJ8hy1CTZrdMjndXzdFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cljOGwqf; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cljOGwqf"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2251003eec.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769112474; x=1769717274; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4r8h+bI4iflLCMRaiiguOyi2Omzn95RD919H6vq9AA=;
        b=cljOGwqfSgQKkY6GHVq6uu/+xJNCzIfT1z+K2UhH7naR/M+z4k+ywMtkh5w9SssnS8
         0doavb4at4cSxqN8rUbXWjmVfu8sJ0bzCbTL7kD7JlZplXKFizRmbVpEyC8T7E7q0NVs
         Aaa524zz4n7B1n7f2PJhWBJqAVaa3rWhxR2wMAd79YW5rYx3s50Vh2FDzoLETQ9SPPa6
         rK/2y/4xM/2EHsH37aEHLiq4j5+qVRsGQRXujwThySoWuZ8q1VL3MBPYDSaUfgnbTVx6
         SsjD7OqIxq1ust6B3nOyLP5m5aq0gy6ZulBg40n2+LsYmduilWBj7xh1LL2B2+kexR/N
         MFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769112474; x=1769717274;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4r8h+bI4iflLCMRaiiguOyi2Omzn95RD919H6vq9AA=;
        b=ABcAJUkk6hkrj81sD9BF/KRH9R65PF/uDiz84Vl0SFY/FILpI7QGCIOZ7E/2eeg4iY
         8EiGljb5WQ2SMMaZv1r1UlhFL43/zQA6tb8dxRtKPERKF8kysv0z0GmeVSeK4Uam4/90
         d9TlK8u19/05Bf5+qju3rqlswLn4byWEHGdX851iDkxbS5oJyg7VL5Z2Q+O5MfQy6LLK
         QPNX3dEjNvu1HZvxO+75/coM9qKlHfOFuOZKJBdNC9pduTv1F4yRCCjKZEr/hbcbJdDt
         jwssnddpp8O+q3e3vruNJgnta2qR4aleFboIbBS11kVOCJYU3uzFUGgemwqPMuBShDJY
         c/Hg==
X-Gm-Message-State: AOJu0YyPh9Z3+oRNtYd9gFmBvJOKIXwINKs5Li3nJ6zqRQXZMRI1uwKN
	TuZ1okGXtSe2ZJoM1AXSCiourzKLiM74Zbp8RzUW+1LJCZLK8fROwKseab+G+w==
X-Gm-Gg: AZuq6aJPWNA5deP8d8pZ617E2MpOx7dLmudFru1D7NIxe1MV/nm+N2i2rCZrUWX92ab
	2fVaxZvnn9tSdAjEGj/AUO9lBBs7nsM5QERYkON/0DukzGOUYsE7CLVpqrINU+vgdqk0fzWIqw4
	3cQ5bNrFHcu7G4geHnl9u3YSydOibiVykvd5+vCERHBCgjRPrXUJbYY6gpQvFuRp2nBeemxwLle
	x8PSaNlL9tNKXkkSfes5Mo8T1jUsybs0x1zi/ysCtBiQWdJV78qzpoKp36mjFt3XuQUeUO5Rr/N
	bpfVf3+2NT7RqGXOvgOW7b+KUG4u2SV0aHMTY4OSsWR8BTH16+et761kuaSi5UXAAzRTcOo/yoo
	Wl9qAXG61DAa9Q92bWDvv0/uyZkrC3GSrAq65j33YCXF2dk5PdeOxFwyml5RAsJ0SpKLWdteATh
	Czh6BUVEzHPt1ff3YzF766S14=
X-Received: by 2002:a05:7300:bc05:b0:2a4:4884:e03d with SMTP id 5a478bee46e88-2b7399956c4mr253791eec.11.1769112474109;
        Thu, 22 Jan 2026 12:07:54 -0800 (PST)
Received: from [127.0.0.1] ([52.161.51.150])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a691d85sm497003eec.1.2026.01.22.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 12:07:53 -0800 (PST)
Message-Id: <f3c8c782b0ae7d20cf023a315e373a38c1fe9511.1769112471.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v28.git.git.1769112471.gitgitgadget@gmail.com>
References: <pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
	<pull.2138.v28.git.git.1769112471.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Jan 2026 20:07:50 +0000
Subject: [PATCH v28 1/2] refactor format_branch_comparison in preparation
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

