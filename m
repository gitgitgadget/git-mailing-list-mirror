Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4D3195EC
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249591; cv=none; b=D+QJbhfHLcu8XldnP0po8H70StBIxgRiHtXq45gyY0OQKPKFjYumBUdkK1GaocAdcAEhNhcZEhuzvS0er1zxoBU3e/MEMIgV1fm5IpwXT5T6qcDqmbL2u7LzYawMdlMM26w3Cqw3/RNYuN9tLJ3I9higA0afbJJy3WK0j/C64Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249591; c=relaxed/simple;
	bh=hvaFgUfinjZIgeJ3QHsxahSWfHO8GXT5K0VY9CQ/M+A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HM9jyEsvaVHBiukShwW7wHhquDZC1wHmJjdAvRYvy2Z2aAc7XdQ/9r76j6KoH3G/Xx2jYJNSqKD5o117KFusjDH9xFLfjo31Bn2bN8fxYOqYRiJSPzcQKj0DTG2VP1VZZXvZrRK/jeRvgwLsXFXLuTqu7bHSKZCBZcghFSdeVPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XO7+cvEA; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO7+cvEA"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2d56eaaceso779920385a.0
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 12:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768249589; x=1768854389; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4r8h+bI4iflLCMRaiiguOyi2Omzn95RD919H6vq9AA=;
        b=XO7+cvEAtk4zPn9J2xSX+4qM66tuGfpbWObj2o/myhWkVrrlOPGRTCyEt1a1qrwb7c
         OgkHckKJNBwMOFo9MX7cUtOoBi6moB6yk0EtovQngMbJMpgjnq/+lCik71eb5b9pVT2j
         VgCuCCGw7WpKTgw8XqMMldYLPL45WlkVCJ8m/AUrP7ALLitcYrK9MMXvUkSwrI4GKkWA
         Hvl3il1tu3RHcR/R1iPexiLXvVMksosPSSKAATRKS5tNDisnnBuBapn0hSHKFaS1GInC
         4PuwDr7/4GGEpECmN9CJ/cn2FvHoDCyz41xNIMZXCJRkNbmPXxHRho9VtD86YNcUfjw4
         KDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249589; x=1768854389;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4r8h+bI4iflLCMRaiiguOyi2Omzn95RD919H6vq9AA=;
        b=ZmERfxK3hZaQTKPvYq/N3im9rfFBGOkBNE3Wk7mPfRn1usi9kQzCHcvGlBmDAkpGZ+
         VRDMhrhS3UEfhNvLAEcZJBIXn4LpevpLm/uOfFlykp/DJ7w/JWmrnpcKV9QMM3nBPhXK
         i/+TH4gQQx/0lUkBnJFJ0e8HpoX2DEwI2cRYr65FgHK198P8XTFkc+P7SUcrpUM0ga64
         XNmD2pAfd7UlKwvxnjSCfg7stT3I35hn2U4blnUDoxcpEn9Ib3ZkPbdMnRQMSJ2i1O2E
         rcUzCqAdrFoS0Xshk2dBBXP4JCMnzMLNhW99NyTO8VhSJiErGXJlE4mnUlvahysZMcGM
         5LqA==
X-Gm-Message-State: AOJu0Yyi26h6a5+2Fjm1C4J1h9xDwO9NuZBgrVIDEZZRosABSiKJJVRw
	mfoExrhVAUX7sLJh/jkFrwtLiADhEzLdLhUxwPZvs8cRGv3v2l643wsTgFtBhT08
X-Gm-Gg: AY/fxX7rlJGHPUA8mYo6JwoOfcJ6SNuipM6QQZHJlZEdJIh/7pZf+cyF+hmN5Z8nHuE
	kO5iTWTFTtphyoIDLaIb2KszoClEwuaJxxvoWEXlunV8khpxALfOHe6nsP1OzjA7X6A4fWiZgJc
	DV2HNEIlLbtgez2qM16mE1HSH21DnrvPOjE87IQ9Yty8qUBqRH523v+vbTvpyP9d0G/5e6Xml3Y
	+UBqHWbSOYmXBwl/vYw/jO+kGN9yZvn1A68V6AzLKtlvJTEebUqPlWXylkgNBp8HNuyGhIEDZSn
	2HruzfkLVULfb2eMSZPG7lA+pUt4+MHZXeLXqNro1Qmqffx9spUnXJtALz5t2pYHhnM9na//U5m
	TjbvKZ3Cy+z/HeJTR/QpANAiKcMM20pWTgbaTJZW7JbnMFuo8rKuZ+VzOGucjGs39gDy7+1+hGG
	iUWMBeLVi+UEkH
X-Google-Smtp-Source: AGHT+IEL3rylXFWypHSNuogeculhzcJX+LBgesxl7qP9434deaza9n8SuntssO0b52CJmjyjmoln6w==
X-Received: by 2002:a05:620a:1a17:b0:86e:21a4:4742 with SMTP id af79cd13be357-8c389417262mr2677998085a.77.1768249588595;
        Mon, 12 Jan 2026 12:26:28 -0800 (PST)
Received: from [127.0.0.1] ([20.161.30.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b917dsm1636872585a.17.2026.01.12.12.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 12:26:28 -0800 (PST)
Message-Id: <fd05c7b7786892b2a1efe3a3daa74bb57546830d.1768249586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v23.git.git.1768249586.gitgitgadget@gmail.com>
References: <pull.2138.v22.git.git.1768074976.gitgitgadget@gmail.com>
	<pull.2138.v23.git.git.1768249586.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Jan 2026 20:26:25 +0000
Subject: [PATCH v23 1/2] refactor format_branch_comparison in preparation
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

