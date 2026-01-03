Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2AA1F4CA9
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767409710; cv=none; b=dsNdAa7WbHJ3T1iR7XwGfeq1E/nyUxMVk+pH3FblEMyrgozr38H9fypGAxdUaooU4UgDlHS0ZnJPZ7/l37CIj5g8NI7S9WIkhcX84tjJMRrw+vXIq3sGEwwlz41s4Fxb68XUQjVRhsJcavks741Mtd3KNn9k5+TLs8uC+3UdEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767409710; c=relaxed/simple;
	bh=tcH5+CUWBmTQCgiXBJmr/VW/kxfccqr681MZSkzLP8s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qfUdjoDYkMaecH89wBCCZQcWWv6P7H+9zrJ1QO/P4QZTJNXZ1yXlIWyEFkN2r4uHJjKECM2B91qjve3WzVGdySNySQtFKXoKZz8yH1ByHrbSnPukMKVg6SWnRLTDSJukfM5rxf39Se5yIbwt5ZRCsgv6Va/r6qrEYT9KVYazCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5LXsjx/; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5LXsjx/"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c7545310b8so6327906a34.1
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 19:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767409707; x=1768014507; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLPE4AzX7YbA+Eq0Cqvp2egi7K2VhlnSwXL2R17dGLY=;
        b=c5LXsjx/dSVSYSyhkoJeBaVq9jk9dfowQO9a0BuZZZgz9fHDMc38LL8pkVMOrkLhwc
         F5fEU9Ktgojb3jvY+MFFNkvVcPgC8PpgY48v6BKnWnDocuKqwe1Ls9AgVWSRz9dd9hN+
         Gw0W079WdvxHSSUQc1yA7BC+6Ky0PsvWrS9qHLi8mBx/z7YjYgXDKfgCFwLBqSIiLSUE
         b5aLCnGhc/yUCxVZH1XDZfR2lUq+vK6Wjf5JjBKW8omCLsa5gx6Ix3mFNRd17YYqf+Zi
         Rc/q+yeC/C0UXS2Eru8POYxbvatJyIPiMJ4yZUmI6QuNrRmgCj+udOinuF1PtGOkTMGv
         Pf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767409707; x=1768014507;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bLPE4AzX7YbA+Eq0Cqvp2egi7K2VhlnSwXL2R17dGLY=;
        b=a4CDJoEf9sND4bLqGpPJyV+Stq/zJHPFIiS8O3taJ51dBgN02yTlcu9ZDfXwhX+qeG
         p6deOLttynUsjOlCy4zyMvkad2zHDByI4XvPU5LGLY9H+aP3M8dtB6f3glzPcWL4qO30
         QzLIOzitMkmNzEPxLtJmXZaX+EixSeBLYSsZ1tRy+yVM1WsdnZ6Evj/lIQNCsXKTSERO
         BJP1APkaomtNH2rGPcUDgC0W+KUGQ9G0sTtZ+8Xlv01VSpVLb7YjNObNxEJW3F+ijGVJ
         ZA00clDk7o4GAnqqNUnVDaWJRnApH3tS5/4uru9A/pjsXboW8UlWDCVo2PzR3oUb0jV3
         S2bQ==
X-Gm-Message-State: AOJu0YwWZEkyGdd8bFfbklRgl+21DEV8vFK8mvM0FyGuX+1Tz++mXu8l
	ztTJ6XJwPnZl+n0dCI9uIXTFzbaqnswBfa53O0u2uQ9v+y5fneqxyEi/iqfMFxyx
X-Gm-Gg: AY/fxX6LXrty/0M/dSphBbz2Sx4URXrFLIQ+o/5vhe0Iwh4nE+NTv1dcEr4/YLLelre
	97YQVbGXs/WaYhtyIF7PuWwLc0DopPMn+yCTsjQ+EpBiU+X7Ix6oxLI7fR68n5cpMvTZejsH0B3
	StDEW8HaFlF7iub33aI6AkS9rVum+daqjXTs6xy2bH2IPlmctO5ZoxubJIW9K8PEE6hklEW8GA3
	lJyxDW1Pv1CgmDiw/FukM8SdmCFDhZa6HyfIoVuVNUiufDuEaJAtVyoqiny2jhDCyc1M0wkHpOH
	yT1sHDLZO97JYQuMTSUr0npC/MqmMUpAkMRAreprWKJAK8Os7CZ6WzuGR856VKUHO30uvlpE28F
	8WeT91EkqiqPK0PhvmOeaboyBtlmAzbGL6aBxTcyqybSq17FDBkR6OPGj6VmlNFuV6EwXC0vQzk
	LQ3sBJKTs/T1if7g==
X-Google-Smtp-Source: AGHT+IGh5hvDv5XT/Y6blVFcHYCRwAAIaRLeKii5qMwkUEu0bVjV1jC8aNcpHgwjJQAAVlC8szn2bQ==
X-Received: by 2002:a05:6830:90a:b0:7c6:e92f:41cd with SMTP id 46e09a7af769-7cc66a58371mr25158630a34.32.1767409706546;
        Fri, 02 Jan 2026 19:08:26 -0800 (PST)
Received: from [127.0.0.1] ([52.165.213.178])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66645494sm29330907a34.0.2026.01.02.19.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 19:08:25 -0800 (PST)
Message-Id: <a2c160c53ee0159a88234c64409f2a216d584cc4.1767409701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v13.git.git.1767409701.gitgitgadget@gmail.com>
References: <pull.2138.v12.git.git.1767389649.gitgitgadget@gmail.com>
	<pull.2138.v13.git.git.1767409701.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Jan 2026 03:08:20 +0000
Subject: [PATCH v13 1/2] refactor: format_branch_comparison in preparation
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

