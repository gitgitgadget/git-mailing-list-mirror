Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96E371D02
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772627137; cv=none; b=qDro3Lqyvmwl5gp0iC4yI5Azw5KGoSc8ZIPnhF1cQZwyKdt8e6hKAMwkS/hXozqoABiXhGjpiiZyYldaFhfk1fYUGYVpmP2j7GZ0TDt2fCfOJmcWqSza7MUzR7hbLqMlDbNugtBkzWeq3ZJM2cmcjS1DFM0F2s/FKlxZzaDo2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772627137; c=relaxed/simple;
	bh=HGCIbfbRQfA16pZXuS9KJhKZ6nQvAjZqK3Hmbk4RxZU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=STn/uiEwQdC6Yw9HOe8ELZXgKnvQMUfhl5BD/BJD9/WOrv7jTaXP7ydiVr/kr3qX/lcPHzL38Zt4ZvouBdPWoCm2myTJLGK8+trSsEwLfj4LCZBu0r2UiTK9rpM+E7UXLB6lSlxvT5BsTj9pj3y4LuutBgrC+Zxu/v4W6pSZQQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atftSK2a; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atftSK2a"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50335b926c2so63607171cf.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772627134; x=1773231934; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJzyRLXLPvCJ2nqoPKedMe78GJdKzW2icxs2oH53vEo=;
        b=atftSK2aEOFwTjdBRjGJ0vGjYXtMcQUhxuWWneOAeTu58bSk3dAgUemPqwwB6M58WG
         L84JX2jOnJ/k91NlViUbxDb13v1yEszHb6mwcsG58MUwmYeQzpyB7myf0WufZcXCkWYL
         AU/QtKsq6cvyDiOIop3K4DmzH5UxlP/Gb8eNE8zrlAVSityInmNl+cWwrpjpExYspwlh
         oexFrlMZqrXbKhclHC5GoXIVypepScD9nW0+mQE06E8ZplUnwQqPPZPw2ZYN3ZOha0jU
         OfSMjxuV4o3prDRTOJ2r+ZGsCD4/Pro3WrhZWCCnb0cvaA/XPeCEXhLbk9sJmeaWNRr6
         knnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772627134; x=1773231934;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJzyRLXLPvCJ2nqoPKedMe78GJdKzW2icxs2oH53vEo=;
        b=obcx5DPUcRB5UANbupcE10s8gNpy5xOHhfUFUvPKinv9v0zQEUERGvkedQRxltRpGT
         fGO8/HWpiSB9K3VbHDrFSitROMpI6rEDGnK2g2J/n99k6kBYnuwP7K0Nj4staBGSp8sg
         Hqg5QBChsho3xjoEfDPMYj4nW9bRUKcCqq1V/Aq2bjgIyl+DV49RVTSN+q2g2WHiX0kG
         nzO8cFvDMpdIo/CHI7bOFg0BA5f7DdzklphmjfC7kfK6dh7dNHxh0E3XegYH1qdE3oje
         IMpic9TtZVlvlEVcqDAZ3N064SY3iILq4FBTaA+zAAvauCZ8mTqzcZQyadr1KfR6Y0iP
         swuQ==
X-Gm-Message-State: AOJu0YymMstv7y+Qmtl8MAmowvB0wCJda8uUi3rdh3MK8m4bBqJmuOYv
	XJlwMlXdAnKFFBmBPO/RzS7yKk6wNJZz7AJ3KkEOWZLrxeitZwv8q7beMyKuAg==
X-Gm-Gg: ATEYQzw0m8svqZgwUJ5we2fz6jOdNYMfLioaheGe/hm4nZk35oyELTYVvH4NUtp5ATk
	CszT1DpYZadhoXgv95F+OEdw72b2cIHIBNCffL/GWGJCyRmb91/UgJ8wvw5NNmTwrRg3IKYnP+S
	RaOSoS0QMts/Ik5S+UZc859O7VtbjGV9vY4x51CNOiMmM8W3ykO2JVw1QSYmz4rbJzD1o17jwns
	MZv8agK1NFuueM7Jl9o3bWj8bRLFfDEeAF/2xQboyN7oGv1jwqeX6QE+fH6Rg2ekcwA/9r+3HeZ
	4UQExGjVCNelnIE3YfX3Yw7PxVqX99cStYQItJ25xfgPuuvnPG8WMFOIzgHDZzUNKjY7xOKXx/8
	N7SNUkTe5qHe2c5cIie79crAD4fzmJGVg8OWxNAOTxpc3YkNJc4HQLQuOk3WXAHQLf0mxpMhZEP
	4hHkWcLTDFWu2oUT80Kj+4L0VK
X-Received: by 2002:a05:622a:112:b0:4ee:1d84:306a with SMTP id d75a77b69052e-508db43b758mr21495761cf.71.1772627133682;
        Wed, 04 Mar 2026 04:25:33 -0800 (PST)
Received: from [127.0.0.1] ([4.227.135.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744af0731sm172532621cf.31.2026.03.04.04.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:25:32 -0800 (PST)
Message-Id: <320c1ce55a428ea87fde4a8f67a61acdb60466f3.1772627131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v31.git.git.1772627131.gitgitgadget@gmail.com>
References: <pull.2138.v30.git.git.1772102022.gitgitgadget@gmail.com>
	<pull.2138.v31.git.git.1772627131.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 12:25:30 +0000
Subject: [PATCH v31 1/2] refactor format_branch_comparison in preparation
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

