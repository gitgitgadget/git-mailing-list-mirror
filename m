Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD0346FA7
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306322; cv=none; b=GlP5WpBDGpw1Du3jqGNoDDaKeEBpnREqGf/XAn+5lmuJUEKMyfqjQByIm5OI28i72yTiq9sJl7Z5214vsUjupbmee6ml1K/DmF0FAESRM1NW3RNzHaGoZUDgkC74hmuo6zX0ty0+RbR6JYB6QzxJo6Y/6KFT5IxOzlmfk3Sv+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306322; c=relaxed/simple;
	bh=hvaFgUfinjZIgeJ3QHsxahSWfHO8GXT5K0VY9CQ/M+A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qxx7bSEkJcdjxzk6u9JnjVcfhBcwBoO4cB6UUb4+CMB1EIyIwEq4hIpHwOdi3aS9jSb0j4pA3KxP4FkffaIKsrDHr4mXju004wzZ+QY4hhlejVJ4KrqepdGzH5JtChbBqRlGBJ6sV34kej1G28fHeUNYZQMsYkybPhMQTJ6DTfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQvMbXUg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQvMbXUg"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4f1ab2ea5c1so110045131cf.3
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 04:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768306319; x=1768911119; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4r8h+bI4iflLCMRaiiguOyi2Omzn95RD919H6vq9AA=;
        b=gQvMbXUgr05uSjm/RwA0/8Y1kXzAXc5t9fkRLHdHh+ebk79dsa4W/oxXZilfLswm5u
         m+yoL4xRyYz5Y8NWxbx7OXSiGuJOpWfIRn2wlhRasAHcn+tkHLAA3ztWCaDXaLh6c++1
         jUZUuIypcwArtMU/jO5kuvO4KOSnB/CkyY44baEnHUzMw5jkkeEdUXqFY4MAGm9Cf2Hj
         KPDpTEUQGMcDRS3a1F0fa3hef3IDxh/nLCFXGzE3vniCyoeV+7SfJwyZx8nCEwiWzgER
         Afny30k8Qwc26DVpL+a9ydnR76lOL4j3UOXiMQR3TCo7UEuaucK1NTDH1rX4b/OeLcPV
         /pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306319; x=1768911119;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4r8h+bI4iflLCMRaiiguOyi2Omzn95RD919H6vq9AA=;
        b=o2+cSPoZuLk6zAyp7jZY5c1SDpBaW7ZqN32EP0ElQ2Hp7ZaejmtfravmYBJtqNBs+F
         0r98oJV1oGc1v2oIwjpcMZBcdYwbS1cEc45ePZlLkYNb9+NaO/AfqDKBVPte9OHrHsXu
         iryJf7XALNJpw9+heY4FcPECav29MPslISASSJtFmOb40OSr7Q2NkMYsOM5puyVNRM8D
         vy/Gj5T3FY3hScx+bxFQbWG71mTmbJtIhJscZeFgkkybDAJyZrbC+kuJdy2y9K2rK64D
         9XeW/30oJb/BFGu7MbYxKgTJsQT5Q03vgKzKpKcawao67XE1ybxZrbE1+g7ZL9ITOn8I
         PZCQ==
X-Gm-Message-State: AOJu0YwMU0W1+ZPB+n9Yaw8E6gXkA/gy2YinIAnr6MUnCMcOSOA+l/Ha
	vKTErJEfjtdQHl4/HZK1G7qWaayo2XAsRiEnkHW9xE1DPsZr1iUqDNSk3FkJiw==
X-Gm-Gg: AY/fxX7l9G2GKBRSBx8XkfpMatanGZR2RJQ3+uoVsRbyFED1FTHGGM8/gk06DTsBhvE
	SK2j+ZxRiUr+7hu+z6mdLc2vAn3+LNFZD9hWFzjJ9ksX203GRNu5wa3N/1zSx+NOOifkq/6QVdQ
	YPk2NzPrcObLMcCuAEd/Qo0zD92yEkry/xBBVIstKiu/DSR6mmcgw+NbrH9U+eOSulOrniBuSMz
	BTQiKZitq+C8P5m77eNrJJ+fgIwUdUt1+71y9u+GG/voF11HJkHZufkm2JApLlV0h+T0sJPZ5xA
	5aLR3Oqrb8gWIgLUUmDTZfZUuWUCuvtjpYBMICxpVzpuKK9+DXwwGLiwDNqSiwRnPMkMFZHl1hu
	mUlp+pmWnp6011kljNw5cGeoh6TKhwOwS0XNEO3jjud35g5kSzTZxMoDUIT8rvEiRU8vVqGJlRN
	mH2b5WSrwkh6szEyLF+Qi4Mn3j
X-Google-Smtp-Source: AGHT+IHdDhCj5N/60Xj9VqOPgPiD4YqJeXO3dlJqulaDWDCfRofEiVVhdQLWp9VViXeCg11vtPPqFQ==
X-Received: by 2002:ac8:5cd1:0:b0:4ee:60a6:ee03 with SMTP id d75a77b69052e-4ffb49f5dd9mr267233251cf.41.1768306319429;
        Tue, 13 Jan 2026 04:11:59 -0800 (PST)
Received: from [127.0.0.1] ([64.236.142.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077267e14sm156266226d6.49.2026.01.13.04.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:11:58 -0800 (PST)
Message-Id: <fd05c7b7786892b2a1efe3a3daa74bb57546830d.1768306316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
References: <pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
	<pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Jan 2026 12:11:55 +0000
Subject: [PATCH v25 1/2] refactor format_branch_comparison in preparation
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

