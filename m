Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797A2FD68A
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768766361; cv=none; b=fk1fg5e6MFa9rmGu6b0dNxre5PaZ7Dcq2cNa/JdDXd7okS5NVy71uOvKKpMMMDKX5NEa4SR8dt98JDsGQzIqiUalhWmp76+snmWfVfmaru0PHy4rTUEaPcZbuKNrZyqDq3dMEcbfzC3nUDjW8Xo0NkcnefCGdzvVje0EfoZbhjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768766361; c=relaxed/simple;
	bh=hvaFgUfinjZIgeJ3QHsxahSWfHO8GXT5K0VY9CQ/M+A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EmIBUAkd2TD5uKKrQQAtEKDVVVCntZeeNEXE7W2vdP96uw5VJfQOlwwzCctowjmuTM9qN242thyvgKtqjGw0TMt3tzEWT5p9deVMfhZhXjZG9BghsXbOMznYncZnOkJmTEmCR8i1ClYCQwjHHPugS3V4nA2f91p5IT+jbrHd3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqoWrYiX; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqoWrYiX"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c5384ee23fso409191485a.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768766356; x=1769371156; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4r8h+bI4iflLCMRaiiguOyi2Omzn95RD919H6vq9AA=;
        b=CqoWrYiX4cUja0uEKB8OVwH88H3JbcJy45CcRqgDPJqH9XFjeB6mPdkvwDb85UzQB0
         e/QChIQfqw2BCbtAXOoWMa+pP5F/bDp/5tEluIExQErnrRzFGcM/8lscModEvDRe052e
         LZCbZ1r1DpC4Ug+zKnyi7Mas/JaKxJ4sXXlG+d13mNmkaYWlWvCm+SGaynxr4Zbkmetn
         OA+EsiTRhgNLiVY43aXX/VT4o0soLRQI3xky6wZekrlfutucW8fUM8foNtitjrd0yArY
         yfBQeT1+CMzcPWJ6ndlHrT5dALLyremYDcxZQrA1TR3Nhq6GfqP5WBa9c2Iy1LU8VrrP
         0nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768766356; x=1769371156;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4r8h+bI4iflLCMRaiiguOyi2Omzn95RD919H6vq9AA=;
        b=E+MteQRG10HGYmVB36ch/6ehfToo1k4muSvad+4w9q3VntEZ8Brt8nq4b3BT0UZpGd
         e47bj4Pb4tgh2E+HhYDGqLcDtUtKkKyICrXXStEiwmarDY+ToaTG164DWdk5ZD2G38aZ
         gDJ2CqDc8i/M6DkxYtJaWu5FzOT5T1p+oqc/gPK3CGtIskHVrFVzFMzWc32erx3pdstU
         /EfckyoxlOclResToMmW4w7vHUTDnDTKUxnHQ26zWKd2a/pn0djYg5q9UbSuSWRLUqof
         z/wzr5A3PkE0tmCaVz2y9eRXxVXRPtnglYtLrUu6ay+GIB+scvGN47+ajMwYqr+9LGrF
         Ni0A==
X-Gm-Message-State: AOJu0YzraZKucMZKKspm5anT8dxZYb8SmDD8/Hs6+cat9B6VV42XlAKP
	BE/tjUGaJemKyFBd0IcZXaFtYLaLbPLrHhlTkL8e0SKHXqzRmxogwJ4EzGkfiA==
X-Gm-Gg: AY/fxX4exG77fgAscJPcg6gZazkHhcgqhaJ721aFz1bu9+oreqqG/dZdVx+IqT72HNW
	wD6p9hqWRTmGrOH+Mvb4RNwhDrVkI6C7pOI4ps4mNuMAryZAOvLdS4fVn4PNL89/jUGkmTyNQYE
	+Rsp+4neKhynVtfy6hCTMfdioql+2dpa2rxrxGZH1jMCHI/TWETlaP7qxgopBqpT6UApk16y7by
	s9cyDPRkR00LhlOwcDV8d122YKg5fpPI3ev6ZWANKLRNA778hz6tHrjiwtKEGOA4RUB7q1LZLMw
	AR8qL9Dv6ylIHYLSIc0QTjzwi1EVOfz0Z1qff37uyIQDLL3FqS0QqgVGUD18YKayYRGTZTBCiGf
	4G1FP7bU7R9IVQtSGn22q5JV37XfuehhBffz1YLvqlLGHoD3oikcyUJVC/bssE42xRt6YcqY/wa
	760DANjIDN2x8=
X-Received: by 2002:a05:622a:14c6:b0:502:9b1f:ca3d with SMTP id d75a77b69052e-502a1fadd2cmr125636531cf.78.1768766356519;
        Sun, 18 Jan 2026 11:59:16 -0800 (PST)
Received: from [127.0.0.1] ([20.161.30.51])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1ef8b4fsm60548271cf.27.2026.01.18.11.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 11:59:15 -0800 (PST)
Message-Id: <27a46f8d9cf41674ff2eb5b60ce772a39d43ca3b.1768766353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
References: <pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
	<pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Jan 2026 19:59:12 +0000
Subject: [PATCH v26 1/2] refactor format_branch_comparison in preparation
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

