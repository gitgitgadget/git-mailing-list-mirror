Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0318D30F94B
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768051839; cv=none; b=Z+kmhmG9AbpLsXb8F4gAg/DxQKiX/0hzx3rdT4zV9+NBXfHhHuXKSlxJM+v+vvJeffsmHxYqSkWuWHmpbXugNTLhvWlrb+IUiA7VRQJ9L4Lr0jSGS12u06GgUoRXKZCdzHDF9FBTbdVa9mmFuiCm7RXW0hR9tdAD1kGUkeZVaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768051839; c=relaxed/simple;
	bh=lCBY9Mk34/KiQ+qn6yKuBvS5UXLsIc9RWA176aoCE1M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jVMzby3Rdy1n7h8rndejF6xS8+WJ/78X2u7hZViK7LwUaKpavnqVX9SRkjpBnCZKpcA8dzdlyjV9ueUv9/lmsIkwZzYQhmJYxuIVySPMofSA2LDV0M7XH7exLUtzGx6zmR5Fw3nL1K6AwVqaouwapREjNKN+HA9o1BQz2Nt/TOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBLE1ARn; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBLE1ARn"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c701097a75so3061994a34.3
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 05:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768051836; x=1768656636; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngGNl24qLMWl53n3IJr39ErvJ589Yqy1fAlkJgouYU8=;
        b=VBLE1ARniyutff4Qe8+w4NaBJWUZ10hnegCouOTh+Yf2jRzxiILLdxu+9SRxdifBvT
         mwFkTj3SS5UI3cI7OVlZaqD/twdcXISrzVbSIP/8tEgHFXnhlATlmfnqkHYyN4bFf/x7
         84myu9RHNTh609AYyvGmvukNAp2XdhJH0PiAMDVj/0gVvOMLoaEJvoPkV42x00huUIKw
         cxf9pa1wEgWojILJ3fUOH+sVai3E5bPFtEQo8GUuwBh+ELzer5iByNVUIrwD1ecd4Zko
         tikKkv+SdXvXnm8jNHDjvVpWJhrAr1UxumadXthpBLM5fwhr642J+jRZ+TVhR3BmMelJ
         WAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768051836; x=1768656636;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngGNl24qLMWl53n3IJr39ErvJ589Yqy1fAlkJgouYU8=;
        b=kxNOzedHnpS/Kk4FPKHesdXcZ/OjKMGfzZByM6ZOE+hBN+pI+18TeAjmhDQM/Cb3Se
         RomGRl5ccGJnV7DClI2SxrmYzPPrk9f/nmxF4E1BnQwl1Inz6Yfq7MjTgg003KUJzoPQ
         gtZaqKoyunefblATxWB4nQrlF/zXC42As9zLTvGaODVMgYE+wx84lprkLtm4fsafCYHh
         /TjjZRo60qw0J36kfB2K3sXx9L6oNBjgoWr5ae0Td6Gq9A8fbb6a6U22lwEX1kD8kOL2
         ycxMUqyQxC+82i0UoWws3yYozFwutSxTzjJbHkkkJMQQSqBZpIWvB1nJCNk0e71CNk7c
         C2xQ==
X-Gm-Message-State: AOJu0YwxfalN8leD0pZMM2L9XMLPjSgG1CgS+SBoduWH8AOCFxIwhc0F
	Ih44fMAadY+7DNmOtve19yfTn2eyVf/goMxDB1NnqKFgDL1wwa6KCmB75m0SsWU+
X-Gm-Gg: AY/fxX43PUbJW3qnZNU+n6YTIEYKTHY0GPM29luUxE3gLxGB+ZRM+Qug88nGGYbPe5C
	pFMsd4vq3hPi0cYHI6fc1tU9BLFyL34YrmuZt9hGStUjWTkKCEgz0pmq0ueLKztYDwjRCZw2n/r
	Mx1cJcMUiyxhpb3XL+4dAW6As+pxGAopYekHUikWqSfNGCjJLnuHFw/vztoZg0oBXnfFQN0Morb
	PXgxybO8iHUn+ainhepa+KLFXQAdkgT+kfN57/TJoGzdXeamL/4CsUEZWRNaZYM6c7LXoOAUxGm
	425JTcQuIWro1LuR2Riyq6G8UzIAGkbRyP1jYAZKeqQd8V1ukDDeCU1iwojnAvv0u3p4mXFLEnP
	AKscAuhLIH4X5cwTf3vD3OPgwyS6OY90q9Jqte6DftrGt5j1mNVcAoqDWb5RFUXpDhmho8N/GBR
	2EuFdnx9kVQFSGQQ==
X-Google-Smtp-Source: AGHT+IHr7BJw+6Q0fAHnsW6c8lKINQsrqjmpsrb3kHcI6KTKrpj0sRynibDRTExWRZxWx/ohV8z0sA==
X-Received: by 2002:a05:6830:2b07:b0:7c7:59a1:48d5 with SMTP id 46e09a7af769-7ce5089afafmr7546439a34.1.1768051836498;
        Sat, 10 Jan 2026 05:30:36 -0800 (PST)
Received: from [127.0.0.1] ([132.196.82.130])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478d9c2esm9607595a34.21.2026.01.10.05.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 05:30:36 -0800 (PST)
Message-Id: <bb3e00863b57ddbd8cebc6f8795629b12ac1a717.1768051831.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v20.git.git.1768051831.gitgitgadget@gmail.com>
References: <pull.2138.v19.git.git.1767984037.gitgitgadget@gmail.com>
	<pull.2138.v20.git.git.1768051831.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 13:30:30 +0000
Subject: [PATCH v20 1/2] refactor format_branch_comparison in preparation
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
 remote.c | 91 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/remote.c b/remote.c
index 59b3715120..b053d4e443 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,42 +2237,21 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
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
@@ -2281,7 +2260,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
-			base, ours);
+			branch_name, ours);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
@@ -2292,25 +2271,55 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
 			   theirs),
-			base, theirs);
+			branch_name, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
 		strbuf_addf(sb,
-			Q_("Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commit each, "
-			       "respectively.\n",
-			   "Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commits each, "
-			       "respectively.\n",
-			   ours + theirs),
-			base, ours, theirs);
+			"Your branch and '%s' have diverged,\n"
+			       "and have %d and %d different commits each, respectively.\n",
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
+		format_branch_comparison(sb, !sti, ours, theirs, base, abf, show_divergence_advice);
+	}
+
 	free(base);
 	return 1;
 }
-- 
gitgitgadget

