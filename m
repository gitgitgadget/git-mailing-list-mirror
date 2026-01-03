Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A2176ADE
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445241; cv=none; b=IC1+RUtm85R2VTMUvT04DBxaZ4vUE8s3YQSmZVczp4HgaIEVbD4H9qzEBHHEYjdJOMjAPS8E1HyNQX89swVV+4Z9/qlgw7BgCJUn/GNQxEZ0JW2bKH2leTeVvMlXbxvnp351Yw6HVoZs9O7crZAsGyblhnL6xkUZ3SELdwu7FrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445241; c=relaxed/simple;
	bh=tcH5+CUWBmTQCgiXBJmr/VW/kxfccqr681MZSkzLP8s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=id+DWB+AmY0o16p3roaphQG88m0Ix3dcGi5gZ7AH1bMLKT58Xpiv4ylONMAmgp+56s44ArHe0CC2KMyoVhYCEJGjfPDiNuVlXMZ8MlUY/5G+UMvBCQX7cNvhrxx8Q8b3luOYDHPXWtusKg3ADXQTl4+KGFfsrfDVL7Z8yiTxd+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COjVD4cT; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COjVD4cT"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b1bfd4b3deso1161350485a.2
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 05:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767445238; x=1768050038; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLPE4AzX7YbA+Eq0Cqvp2egi7K2VhlnSwXL2R17dGLY=;
        b=COjVD4cTUjmJJ9ujMAWzsXZ7JONlX5fCKmbrcE4LSN4E/AsxnrIn5R7CzgwjM9Ag3w
         ng7lflFxjOUlnsJpyRqTBT28PDloSrKOQnGxoUYxmeVGWPZsZ7JryjHxcEV4aQKxaE0w
         FLoXQHfcQXyrvkywno+a+uFRvHk4eCx2Ygx0CFcWAsjQ3i4EdyBPxl0o2mVdcjok3cuv
         NK9YJR8vTNY7WBxo2jA8O32RgtSa/Ot4UJs1XNrDNkUW+ciH3M29nptUpCUD80cwQCzH
         fJXTzZJxw0Vl5LK0yHhszJt44ksxMz0VGxbzo/nFn6L9I0FYoaU6wdlMu8Dc6P7Rix35
         yXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767445238; x=1768050038;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bLPE4AzX7YbA+Eq0Cqvp2egi7K2VhlnSwXL2R17dGLY=;
        b=X2AYygfdPKP52+UEOd/eDEcGzLCSK9xYg3ECvAupWMD0R/SSWPIqCPbMWbbPdW8Gaz
         GX2118OYiJzrlTKGkuSr8SIPnQVTPzJK8wjYFTaCa2/HL120K6WWT8zPw2lFnkTPnpcX
         qyKhFx71sx0/Mw9ighMV+4WMMKeb17VYSADysKP/4VfzgrXCdURwgXvtd1qBPlk4NAWn
         AUwWY0KIswiJgV2dYir53yypue45WL6pIjPkarqD7fAkfTA8Mj2PpJ+PPD/6O75M5uUT
         fRG8rmdWJGTpi38nWoy/0NNbG2HoeqmWbHSqk24McOR1AgOShcngK1Sy7FQ6FZf7PyJ0
         3vYw==
X-Gm-Message-State: AOJu0Yzxy6Z7jUs5VJ3WpJMgMkliUw1FAqDkUiJ00kJNrexqguL0CfEG
	dJwacOFcaXYBExp0lSm0k8PeHrXTBn/HBi0rBTZXbhfVvHvGKoJJTpkmZ6FJvw==
X-Gm-Gg: AY/fxX6k4h2z1Jwqf2wnd/yBO8eCgd3H1v+ySN1s6evjnvA+sJSImBJ6oAgvmqBd1Gb
	H1IHDzF+wmFw3h2k9fwq4iIWeu5ZIZhms94FHCcvSk7uUnRcgL9YhTrelN2ISzb85wXrzcR7uD1
	rMeYMdpVy5MVEXXnmm0c6rzB/MymWVUa5KzxvROHGCttApQJY1HoaB+gS1PbcLJ7+v+FLobLFQp
	RTjL1nhQZrKoV4XAHIFzfi28VTRBQkoliFP728YPY7ADW02l8V1crSzmFM7s4JQrBi1GyGCIn/8
	6Fg5V9GNj/mtFs7fSBKsVCwkMXL9V7niVicfoYckqpMKAHFxVfQYYBdsrbrUA9viqD5cSU2eWxM
	qKTXbNT7MNuh8u7ijJwF/17BXu6vy0SIB2Of8XZlvL7Vdbnh28Rpvfu+nf7bFXzTsc+cCE/Ecia
	Y2TP7H8puJzPwS
X-Google-Smtp-Source: AGHT+IGxjivcHzs+C+CHlO/IQb/cn5KMoxxkSBCWiur9I+Jd4GEkTBzESgPrD6JM05x/iIZpfWQzrQ==
X-Received: by 2002:a05:620a:4049:b0:8b2:7224:b254 with SMTP id af79cd13be357-8c08fc011dcmr5958583685a.13.1767445238124;
        Sat, 03 Jan 2026 05:00:38 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096781f33sm3386188585a.11.2026.01.03.05.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 05:00:37 -0800 (PST)
Message-Id: <a2c160c53ee0159a88234c64409f2a216d584cc4.1767445236.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v14.git.git.1767445236.gitgitgadget@gmail.com>
References: <pull.2138.v13.git.git.1767409701.gitgitgadget@gmail.com>
	<pull.2138.v14.git.git.1767445236.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Jan 2026 13:00:35 +0000
Subject: [PATCH v14 1/2] refactor: format_branch_comparison in preparation
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

