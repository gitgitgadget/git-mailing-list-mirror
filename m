Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05323191CD
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572725; cv=none; b=okBMPEJ71wfLix5FZC//lsxJ70v8dmrjbSlguZZg4ZRWFr3/vvehDA2iV2ItCvUmqlLOU9vnGFayduA/RaGD0TPWdnaIYpsOpRDhfR54rMOsc5M91fR3KiIdeis9oI5BgIWnop0bqrKfS6vsb1ctWiyvdHIdKmVwAQab7ybxSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572725; c=relaxed/simple;
	bh=R6cVNSGf6cv+Q0Bp6XhJtfldfDQPLLJUxcWhQJTC8Ds=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y9Y2BRs5XbY0t8W3pFpWoJvy8AUJxP/sKE/zX2ej8pv3x63dTpmW8MP5B8KQRI7gdJmONlWN4/ZPTQZUX6HL6lhYYhorqi51/aoQzrEx9v+Qy/pdmhBGkODbjbitJajN62aYTij90pUdY2o3TQojy/w0/81GdzkIkPOKRv1iVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFlYXgRJ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFlYXgRJ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88fe44cce7eso8895436d6.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 02:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766572722; x=1767177522; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK3Nyt0Spl7S5ovEhMaOrBfJxy4qKpKBc+fBFhbb5tI=;
        b=YFlYXgRJm/jo7xTncwlQbwtBCtPdT38gy+e06KsDb2HOqmg87gs3Pt6trSOFlLhekz
         f5aW+8WkjZUYFN/qnzpr3kQ38Q7sdix+UMSbpTTYQNuaVlcQBkA1SXjXcd7AJ3PESVlr
         cuWeHXgUa9ZEZQd+4aBex2wx/tt6DzXff6kkhyfNRxJlywvYhbUSimM/hRNRtZ54t34L
         VoyhYiKyBiXKyKt26tY0FFDYJbXS+NMXZndrjuCBOqsau0gHHSPW11wtQF5erfkaWCtP
         P8z4ctBAkTYkR0/1hVveVdTERCnv+F4FJPmV3G0GA4iUJ18I6Pu8sZ3+FnlrWD2Zx50I
         xrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766572722; x=1767177522;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HK3Nyt0Spl7S5ovEhMaOrBfJxy4qKpKBc+fBFhbb5tI=;
        b=i6mW1vbnSbidkW0R1pggoKhnpvU8JRbk+ZVhXpW2Y0PnIDNuodTB6l0b92AEiJdi+7
         i+Xs5QOaFgQg8SLElSaTleTiXzuL/8x/JA3UwqNM8FDJw1ruxMdl/Lh78TEEhpQNK6Lk
         5hH3+CC/c1Jgzm/SNZ3pHDT31M6S2CPt+ykKmTPXLWQhG0kDeGbKg0Sh+u0Nl8c0kkks
         sCyQSmmUeZOVQeFUNnf4evMvEK2tk3GV5DQ+mKnRkjtD/bVy7qa6TYCm+G4+i4s3zLiG
         8pMAg3juvaTY24MP8AUensqFOKK7i6QbZRstEPiie2ERhJNgOLxO1R1ftK+eWKs4lx6N
         LNVg==
X-Gm-Message-State: AOJu0YymL+Kzx+8d2e2yAHqJnD+0/EDSWChRX7UlbUau5p8iIsmsqM37
	Dk+qH79kWVcsPNh40KzwfDby7chpK9A+jEshncEq0INfPb2/0l6N079q5+jFmlwN
X-Gm-Gg: AY/fxX5J9mSv+moBIaCAmn+DKvpeJhm3lOfX3eamjcn13hdYFyvAOlLy4a36BEZTXJd
	zFQUpLXnRXyZUoaLEj003usTwfgWkNPySp/QyJekSj/zbkCA4N1lgMWxtvPZyBlq6CsqfpzjL/3
	aGS5S88I8pSHv+dmOkv7wHTDlb0p1yPKheSQpJj3b1BhaXEj0ksXx8FZhG93rV7IhKv6+T7a3PX
	D+NAOMArIwMuSKIoy6coAd4eoTrfTLtYEHrQtfkWEBIhICTfpMNKPtIH8U+cUKXVQy74mdprjAX
	mZDFDNy7oxyocL1f9DmEpMJ2vgoeKsswd8P1ssjxnA7nVSzsKarWPn1ZzqyogE2byCNosR6hTIL
	qS53/kL1H1cq4wrJ8MBRKpmscEhSItL4N/mYdnCjzTXr+QZj/+52FVRMQKhg2h0lElm4otIcu9Q
	pDQlg3Sqc+db9D
X-Google-Smtp-Source: AGHT+IElvpwhvVpxtA5505467hrIaApQKUtGDJ3m5/CFN2QIo3gtu96aBlMoIXU32ppAxr2Ky7j4Sw==
X-Received: by 2002:a05:6214:1943:b0:88a:2841:bb11 with SMTP id 6a1803df08f44-88d8213e38cmr326531186d6.27.1766572722073;
        Wed, 24 Dec 2025 02:38:42 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9aa363e3sm126126376d6.57.2025.12.24.02.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:38:41 -0800 (PST)
Message-Id: <0e308141da0b639ba4ba15c640b8e4260689a42a.1766572715.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
References: <pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
	<pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 10:38:34 +0000
Subject: [PATCH v5 4/5] Rename default_remote to goal_branch
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

Rename variables and functions from 'default' to 'goal' to better
reflect that they represent the goal branch from config rather than
a default remote. Also move the goal branch lookup to where it's used.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 63 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/remote.c b/remote.c
index edb6d374e7..99c0e18df4 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,7 +2237,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
-static char *get_default_remote_ref(char **full_ref_out)
+static char *get_goal_branch_ref(char **full_ref_out)
 {
 	const char *config_value;
 	const char *resolved;
@@ -2253,8 +2253,11 @@ static char *get_default_remote_ref(char **full_ref_out)
 		return NULL;
 
 	slash_pos = strchr(config_value, '/');
-	if (!slash_pos || slash_pos == config_value || !slash_pos[1])
+	if (!slash_pos || slash_pos == config_value || !slash_pos[1]) {
+		warning(_("invalid value for repo.settings.statusGoalBranch: '%s' (expected format: remote/branch)"),
+			config_value);
 		return NULL;
+	}
 
 	strbuf_addf(&ref_buf, "refs/remotes/%.*s/%s",
 		    (int)(slash_pos - config_value), config_value,
@@ -2277,38 +2280,38 @@ static char *get_default_remote_ref(char **full_ref_out)
 	return ret;
 }
 
-static void format_default_branch_comparison(struct strbuf *sb,
+static void format_goal_branch_comparison(struct strbuf *sb,
 					     const char *branch_refname,
-					     const char *default_full,
-					     const char *default_short,
+					     const char *goal_full,
+					     const char *goal_short,
 					     enum ahead_behind_flags abf)
 {
-	int default_ours = 0, default_theirs = 0;
+	int goal_ahead = 0, goal_behind = 0;
 
-	if (stat_branch_pair(branch_refname, default_full,
-			     &default_ours, &default_theirs, abf) <= 0)
+	if (stat_branch_pair(branch_refname, goal_full,
+			     &goal_ahead, &goal_behind, abf) <= 0)
 		return;
 
 	strbuf_addstr(sb, "\n");
 
-	if (default_ours > 0 && default_theirs == 0) {
+	if (goal_ahead > 0 && goal_behind == 0) {
 		strbuf_addf(sb,
 			Q_("Ahead of '%s' by %d commit.\n",
 			   "Ahead of '%s' by %d commits.\n",
-			   default_ours),
-			default_short, default_ours);
-	} else if (default_theirs > 0 && default_ours == 0) {
+			   goal_ahead),
+			goal_short, goal_ahead);
+	} else if (goal_behind > 0 && goal_ahead == 0) {
 		strbuf_addf(sb,
 			Q_("Behind '%s' by %d commit.\n",
 			   "Behind '%s' by %d commits.\n",
-			   default_theirs),
-			default_short, default_theirs);
-	} else if (default_ours > 0 && default_theirs > 0) {
+			   goal_behind),
+			goal_short, goal_behind);
+	} else if (goal_ahead > 0 && goal_behind > 0) {
 		strbuf_addf(sb,
 			Q_("Diverged from '%s' by %d commit.\n",
 			   "Diverged from '%s' by %d commits.\n",
-			   default_ours + default_theirs),
-			default_short, default_ours + default_theirs);
+			   goal_ahead + goal_behind),
+			goal_short, goal_ahead + goal_behind);
 	}
 }
 
@@ -2323,8 +2326,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
-	char *default_full = NULL;
-	char *default_short = NULL;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2336,14 +2337,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
 
-	default_short = get_default_remote_ref(&default_full);
-	if (default_short && !strcmp(base, default_short)) {
-		free(default_short);
-		free(default_full);
-		default_short = NULL;
-		default_full = NULL;
-	}
-
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2398,13 +2391,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
 
-	if (default_short && !upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK)
-		format_default_branch_comparison(sb, branch->refname, default_full,
-						 default_short, abf);
+	if (!upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK) {
+		char *goal_full = NULL;
+		char *goal_short = get_goal_branch_ref(&goal_full);
+
+		if (goal_short && strcmp(base, goal_short))
+			format_goal_branch_comparison(sb, branch->refname, goal_full,
+						     goal_short, abf);
+
+		free(goal_short);
+		free(goal_full);
+	}
 
 	free(base);
-	free(default_short);
-	free(default_full);
 	return 1;
 }
 
-- 
gitgitgadget

