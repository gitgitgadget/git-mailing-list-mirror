Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578F3A784A
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102028; cv=none; b=uZY2+cBLTNmhhhzu1+XpM+YDjnU3JtP4QVUvAJf+PH64/ykJq/dIY1qhLuigMcDjabOrAP2hzqw3Tz5WlYhMHhV41Qx5J8/LZT9LoCc2mgf/jqA7Mpc+qU/lOoU/X72bqpV6s/T8FRxGcNxCZaNgCT9dWvJC0tIqwGO0CKtbrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102028; c=relaxed/simple;
	bh=HGCIbfbRQfA16pZXuS9KJhKZ6nQvAjZqK3Hmbk4RxZU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AnjoDQjUlDFd9w9XLhadnCcP/2CQdY88+DmBjn59cBspb5oanRoJ4jwhwuHTgaBFYWXsXhoHL6TJeQwLGJy90aOk7EGu9hRjdtnwoxWxRyM5g7Zk6eMIiLLNn/w/7cQzktuSKQ32tdR6b6gKMOhAvcFEAwMJ6LNFUY9VPsSHK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifdR0gEa; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifdR0gEa"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506aa68065eso8025901cf.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 02:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772102025; x=1772706825; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJzyRLXLPvCJ2nqoPKedMe78GJdKzW2icxs2oH53vEo=;
        b=ifdR0gEa+eFNrFvqfegHmT8hoOp42RfXs75IJ8l5+HPUdIAfRYF07TEThVaZAuU9OA
         Rgf6SWO5tgS/ArIJT234b4Ew2ZWD9GVP9DZxr/Lt7jSWBN4FR1LrISWkw8MA8y197lNI
         SFGgBjpkVKk1uGJlELsdLx0x3JIKyaCT+ZcmkeVMpUrJSGp4LLjIVHV9Vped9Z7KKIic
         q8y02HtWaoAxv7J6NT9xsGgK8YlkC6sSWXQbB1U2tEtHcoFrAH0Ob9PmgusgVboVwspJ
         FQafiDswRMisKUqrdb5rzeOMG6IcPjr1q6O7Z5YUQUCx/Yz5bUvXnXbPh3xyq095WeFU
         952Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772102025; x=1772706825;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJzyRLXLPvCJ2nqoPKedMe78GJdKzW2icxs2oH53vEo=;
        b=c4ks2ZjiobMTgPtMW39ssKr+IYB12tmV0mUC0RBJn4ZY35VuBOVp3oZepop4xNk9wO
         G4WDTxYVCqmJuD5I8p6WHmkTTpbmrmkxtBrIk5J7WXRY8wSFJyReqD8LRyq64kuObJBM
         3xl4uc8r/bNunLUsoliqyEIr0WEqnoPJ0BIansirlOj97LvnFRgNKuuy7SD9uaBKg7I2
         nQt7NF+0c3yatRHJwwuD1FgPxXMQemBU9qywlP3QVe6gQ2C81rntkFSTcV33L3YoGYqq
         rCci6lNW4Ylrl9HbZuRMGRCpMwv75b6hm64De8OipSso/NmtJzFeS04wubo1IiU5iFJQ
         XmTA==
X-Gm-Message-State: AOJu0YwRU192UpNMRegQa2rk9m3uxU6VE7JZgtKkrj3PT+O3cs5Dhrrz
	F5PDUp0AhpEJpOzTtygqQ/2v2TAFr43hB6mJv/RRXv424aDxd95fiT6ICLmvXyhY
X-Gm-Gg: ATEYQzwwm0nYxRUMMBWnY1eknuMCIoZ1U5DjipLGV3CGp8PnQcYZ0E5NGBgFuUKBLUR
	xiKgsbq/UOowQQcY257gCI6o5yV6bLmmXtD4Y3DWJYceUiEeckIbzQp99JTKFc4fvsfFn25cbFY
	vdT1JKw0XuTc9vcvr9/fBpYnkHgXiXvWlS4ST3pqxfWcYWR3+v9/aSVt2xThXNrcfCFXxzNHeLg
	EnmFpQU3N6uw+VHOI+dAGFOcYi5sBpTP5WvQKgi9NBbZF0o3PLeFyzSlGIwyGOO62pLE7Npu7QB
	7cONBWD+di2A8GkuB4GNnxBLrNzOg6WPgalRB1t7lg1KDut6mQAccZcxu0jXaXfqZwz4HxrbZlp
	TftX9vfTLKyIXGdwxgAaEdokfJoLWc/gg0/YTXrd/d7A+1egT3//oAe/q8CYkoRzsed8IdoL6CA
	sHK9k2NLaPwwR0FV16QOCLPaRD
X-Received: by 2002:a05:622a:48c:b0:4ee:280:2e49 with SMTP id d75a77b69052e-507460f356bmr16207191cf.66.1772102025196;
        Thu, 26 Feb 2026 02:33:45 -0800 (PST)
Received: from [127.0.0.1] ([52.150.29.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744afbba3sm17853371cf.33.2026.02.26.02.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 02:33:44 -0800 (PST)
Message-Id: <7f517b8c7f866c99a7e298bdb29011865e98b6a2.1772102022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v30.git.git.1772102022.gitgitgadget@gmail.com>
References: <pull.2138.v29.git.git.1772056263.gitgitgadget@gmail.com>
	<pull.2138.v30.git.git.1772102022.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 10:33:41 +0000
Subject: [PATCH v30 1/2] refactor format_branch_comparison in preparation
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
index f6980dc656..e9e2f56ed6 100644
--- a/remote.c
+++ b/remote.c
@@ -2234,42 +2234,21 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
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
@@ -2278,7 +2257,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
-			base, ours);
+			branch_name, ours);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
@@ -2289,7 +2268,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
 			   theirs),
-			base, theirs);
+			branch_name, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
@@ -2302,12 +2281,47 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
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

