Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86860C8F0
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976911; cv=none; b=MjwnqOEftcpDrR5FmeM4cdbe5nyg8AU8hmjBBqcaLFSi8stF7VTjU8oLXPdBUTMBRNGck9Gq5L5EVWItJpzBrXY0nQnG317W4slhf6gSdNp7a89hxB0zi8E3zlvlUjhEy1wn7RTRBmwN+cprrOZ6PtYqJc02HxulRCSVHpqGHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976911; c=relaxed/simple;
	bh=8ryG2hFTyaLbyxcrgm9DfGeWDedWFEIl+F1HlPsbvF4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YfYieW9O2Q2xpU43MbbLJcuHZ0wZmLFY93juTrtq5tDzooYDtiyq4DtON/6a4d6fdhyScyrUrAsckY5tV9kJm0m+ONN69IEpp7JTuz7gDvpKrz+uPv74diMH7pYtojmct5mTxR5XeCSNXOvI66zbP0pyeXSLT1vGYa7weV3lFI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLnXLFcS; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLnXLFcS"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8bb6a27d3edso442061385a.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 08:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767976909; x=1768581709; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZzSB9ePBcRXQOQ8QyW9ss1jeWshIwso8pIGq51d0mg=;
        b=kLnXLFcSXcUzflVxmCj9NxEr2vvrJiCCjcXpzZgmcnD1O20ajy52lO3OgswTU/Qjvq
         rQvVR3oI5XM9UMvnq220HLf8/32TSxoYeILfY2j1+TD59gvKi0D1hEBAHTW5nC/og9cn
         Fm52c1G7BSqznKvgebiPjMY22/J9X35Y1WyIv5i+1Jb/dggUNg0LV9wkWUqAhzurVqof
         S2HhBFDnzr69gkkcGmEg5Aqb9KtXjcSXKwDwfQjkWVrrbd0Cs87EDPzzOa23ftfZLFlx
         eo1V/rlXT8hKKkbexx3M8oL1GWQHwz9aLvQ+c/48GNyI7VP7849UEWxKK8422RVD9Bxf
         ZcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767976909; x=1768581709;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZzSB9ePBcRXQOQ8QyW9ss1jeWshIwso8pIGq51d0mg=;
        b=KyZT8jgSl1XLP1saAJ5awrTFrzhAZZ5kddNkrL8g/5a5R3ESaUO3wWem6k10U0nyFG
         axrLasU995lXal/QBmC6ZUnis18Y6jNTLy3nJ80DAhmmpy2cBEq0PTYA/+vPW3dlILDh
         VjFD07+1l4wgauvwyX+zuAy4oKSajSj15YPRWFdv/MLXUsK3TOEfAod2c1jATZpP1hcX
         tnte8WScWCXdvs9z+6vaMx9qXS223WEISLvJHRT8LbQHxWwQa1OOrzSeR+W9aHonLMNp
         8uVedNgNPL8EywHWcxRbH+suriUGp9DJIpm9lCPIiBfaVAvBmNd2B4FQZqdyvgSXnSQo
         EUdg==
X-Gm-Message-State: AOJu0YzHzH0Sv6aYfSoRduRBZ956bD9oqHECRSKB1EGRu+rPNjT6gGTA
	2INI3OpSERinXQ+pn8HglMMpbDNPfY6BoKwHMuPmF1cuiOy4sTtA7Omti6+tww==
X-Gm-Gg: AY/fxX7nPBF2zvzyq9Pln5YFQGC3Sa21CGKL3bmeV4RzUPEpMNBvzSo9fx57MWcc3pV
	syeUbnBo5Mp0ju5Fb+A9QsKLw3Zy/y7cOx8TD/qP7z9Wtbw1isN+GyCUGkmfA5YyTXRMR/xziTp
	ObopT6cE9amcf/SXopozlY43Rh2oDB0qNXuJox1pPtfxQreT+oR9tIakXlCm4emy3yJxAS0WFsd
	ljcAXT/XI2n/lOoVDWma+5lhq7Qjeyd4z4LL6iLiuzQhfdYfXC3hzhTUFxNDS7zkHAqQGsXasks
	VxzDmoYnc22DJ6V6jZeiBoY8/zsdHmraA91wLaP0em5M9eTFm6DmJZ/Nm0JJJr2ZSWa1lcDsLTg
	jynIuZsCXz+PAI/ZNyYafH173vBcAebdAhZXln4S7UnRPWIWK3WluQXIf0MlY2iThH8cAs12Gpd
	nIt/Zqh1rKUiJYT0pZMt13w20i
X-Google-Smtp-Source: AGHT+IGoY1bbBRZY0GzLjG6usaYHPvT+ZkUd5p4sZWEDtGjhcl1tcnFU8JsYONwwB+gBJdQRWgOtNQ==
X-Received: by 2002:a05:620a:7005:b0:8c0:d344:47b5 with SMTP id af79cd13be357-8c389432a87mr1254808985a.77.1767976908976;
        Fri, 09 Jan 2026 08:41:48 -0800 (PST)
Received: from [127.0.0.1] ([172.208.127.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51bd5esm854750685a.31.2026.01.09.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:41:48 -0800 (PST)
Message-Id: <451d7a498617fbcbeb08ee644cb621cbf6af0bd5.1767976906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v18.git.git.1767976906.gitgitgadget@gmail.com>
References: <pull.2138.v17.git.git.1767608269.gitgitgadget@gmail.com>
	<pull.2138.v18.git.git.1767976906.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 16:41:45 +0000
Subject: [PATCH v18 1/2] refactor format_branch_comparison in preparation
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
index 59b3715120..eba013b6b4 100644
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
@@ -2292,7 +2271,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
 			   theirs),
-			base, theirs);
+			branch_name, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
@@ -2305,12 +2284,47 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
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

