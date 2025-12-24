Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9C313555
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571594; cv=none; b=XCzgIpbNW6ZZvUd42W38iA8Ffk6amY/voddN5K03f9rwlSPBDgM3evc82XAR0PEinzsJi1tv8sy/cApFuW1YUvxBF5LXCcnC5PUIbhKpjfAv1oTAPtgn/pPQAT4F3UuB5VuVUAPeK17ZArDtvWQVr9n8CjyxgVsXIJpTRtX4gRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571594; c=relaxed/simple;
	bh=olXSpMFt9hAOLB3xsCFG60EeHYKe6/5tDFJKC4AYkK4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=npttX5uzSB+lKv6iyn4Y7Y1TTo+atFak7Hnz5qejh9W0Um5ZrQ5BiFnoT5VFd8iV+BE1HK5zM+pHeS4L8ApGvA2iDQ7peqB4Nll2JRQXXlC/kh2kQzQN31weE9lf4BYaYH5y16YAVZum4mAYYIvhJMBRRWw+aB6o+kR5A0qBoOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMMa0eEK; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMMa0eEK"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b22b1d3e7fso568969585a.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 02:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766571591; x=1767176391; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87FO33ycJoRW4/p4RjOFV29Otf8eIYFHCwHjBiNEPBo=;
        b=RMMa0eEKI1QYV2eE15cPLiVv/uUkRpzDaSO5fw6xFeIAJl6wqLHdeYEaFiO71kptom
         tTikd9ATc9fUmMTHePlbeuOmU5x6C9BCMUQfyCpYs825pO7Q6OwQowF8LeYL0T1tOMhY
         /SYwqvxnKdrXrCF10GEOd4mrvu1PNW3T58pjzOKqAuGVjiowX2j03F7t2+47ldzqM/8T
         gpQ82L7wi7npaGxXu1C0QvM4AxFTTN4B+86XOxIIAi01csvE5CIJiLdqlvawnwAnJekH
         GW2NUl/j9m257egbCQbVMXIRHqQHKNH4V40ebk5f5dqgEI8ICFlBFCDSaxp40I81m917
         aVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571591; x=1767176391;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=87FO33ycJoRW4/p4RjOFV29Otf8eIYFHCwHjBiNEPBo=;
        b=SaXetrPjNQNU+WQEDB6FHcIRIJks/0x22oMRoW0/jkbD/RfeN2SX041svKlGnJDlAw
         ltqszMhX7fO2QBzUKhCkdA5gE73xtn+kSTdHA31vGTrw6f4L4ukbdJeWHc7C0eJSUoES
         QilHLFETWIuWrIri6o17k13EWh581umlj890xSwh9hr4xFt1HJuWkCMBpss4F+mBpQ43
         kqDTV/7WgLfmMwIrhQmmKAO9875wbIEHxNkaEYeaZ1s/c+RpmOEiaTtDlcpDAV/y9Ir2
         d4TAwhlrqO5vemOgu0WIiK4mEjORhS+u56wQmBGLjH65vyah4NZ0TbuulEneT49wL+62
         XKEw==
X-Gm-Message-State: AOJu0Yx72wcmMKfa+U6bA5dZ2Hgoi1BaoJfg87ixSCSFTpnL2t5h70tr
	tCouysfb+TAwAQML/3IXtWoNrMytARGn7vcWliSQ7OxlU6iM5AGEhD2z7Hkfxg==
X-Gm-Gg: AY/fxX5uRveMQCyCNeoC7M4oFKGPSTX2ze8DPAtHpKEdujLN+kVaceu8PDmzSYyM/GN
	BN7bClYqE4VXrPptp/wD2nf0TFp71hmd31yCRyjiWIGC2FaH5bDYtlok0WDxhQQJVB9gqUiECdi
	tLkhbMoaBqAjJN5VD+zUuviX+h94OvAUrw43OvtpFo20Gulyt3G/m/l1YOXvQVzb8SP/fNEjROK
	Pq0Zx6KWY5FLN8K07e90sKIWd46M9axaJ5ZbLCNuuaOkb1ePVkmrqcxRARPg9TWzYvOmWupDLV7
	3DFnSPhyhKR35E4EuwbCWTDjX3A6KtVcHtqQIPzk9pkr63a9St3EqlUR7VTD6TtmObVRC6/3n+k
	0Cu/2gGh80LS/O4Oe4/XP1pV0y4Ortuj5tIgF/dcSA6A601eDLh3rrzQWlh6PL38sBCPWmIxpIa
	tFJR0ggdpOBd/NRA==
X-Google-Smtp-Source: AGHT+IEDjeFeTz/sRkvYcFY5esSN04Mk3gp3pZ3zfCM05TXrYVKb35ErZ1CtT7eiu+L4qWdBkVyu2w==
X-Received: by 2002:a05:620a:1996:b0:862:f354:ec3b with SMTP id af79cd13be357-8c08fab9c87mr2436553685a.61.1766571591335;
        Wed, 24 Dec 2025 02:19:51 -0800 (PST)
Received: from [127.0.0.1] ([64.236.142.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783657sm1455545785a.1.2025.12.24.02.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:19:50 -0800 (PST)
Message-Id: <417f2075fb876cbf5a00cd9877fb867ceddf7f6d.1766571587.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
References: <pull.2138.v3.git.git.1766568665.gitgitgadget@gmail.com>
	<pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 10:19:45 +0000
Subject: [PATCH v4 2/4] Simplify default branch comparison logic
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

This maintains the same functionality while reducing ref resolution calls
from multiple to one, and eliminating unnecessary memory allocations.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 59 ++++++++++++++++++--------------------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/remote.c b/remote.c
index b2a1e980b1..f3831ef3be 100644
--- a/remote.c
+++ b/remote.c
@@ -2267,41 +2267,17 @@ static char *get_default_remote_ref(char **full_ref_out)
 	return NULL;
 }
 
-static int is_default_remote_branch(const char *name)
-{
-	char *default_full = NULL;
-	char *default_short;
-	int result = 0;
-
-	default_short = get_default_remote_ref(&default_full);
-	if (!default_short)
-		return 0;
-
-	result = !strcmp(name, default_short);
-
-	free(default_short);
-	free(default_full);
-	return result;
-}
-
 static void format_default_branch_comparison(struct strbuf *sb,
 					     const char *branch_refname,
+					     const char *default_full,
+					     const char *default_short,
 					     enum ahead_behind_flags abf)
 {
 	int default_ours = 0, default_theirs = 0;
-	char *default_full = NULL;
-	char *default_short;
-
-	default_short = get_default_remote_ref(&default_full);
-	if (!default_short)
-		return;
 
 	if (stat_branch_pair(branch_refname, default_full,
-			     &default_ours, &default_theirs, abf) <= 0) {
-		free(default_short);
-		free(default_full);
+			     &default_ours, &default_theirs, abf) <= 0)
 		return;
-	}
 
 	strbuf_addstr(sb, "\n");
 
@@ -2324,9 +2300,6 @@ static void format_default_branch_comparison(struct strbuf *sb,
 			   default_ours + default_theirs),
 			default_short, default_ours + default_theirs);
 	}
-
-	free(default_short);
-	free(default_full);
 }
 
 /*
@@ -2340,7 +2313,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
-	int show_default_branch_comparison;
+	char *default_full = NULL;
+	char *default_short = NULL;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2352,7 +2326,13 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
 
-	show_default_branch_comparison = !is_default_remote_branch(base);
+	default_short = get_default_remote_ref(&default_full);
+	if (default_short && !strcmp(base, default_short)) {
+		free(default_short);
+		free(default_full);
+		default_short = NULL;
+		default_full = NULL;
+	}
 
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
@@ -2365,8 +2345,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
 			base);
-		if (show_default_branch_comparison)
-			format_default_branch_comparison(sb, branch->refname, abf);
 	} else if (abf == AHEAD_BEHIND_QUICK) {
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
@@ -2383,8 +2361,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
-		if (show_default_branch_comparison)
-			format_default_branch_comparison(sb, branch->refname, abf);
 	} else if (!ours) {
 		strbuf_addf(sb,
 			Q_("Your branch is behind '%s' by %d commit, "
@@ -2396,8 +2372,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
-		if (show_default_branch_comparison)
-			format_default_branch_comparison(sb, branch->refname, abf);
 	} else {
 		strbuf_addf(sb,
 			Q_("Your branch and '%s' have diverged,\n"
@@ -2412,10 +2386,15 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
-		if (show_default_branch_comparison)
-			format_default_branch_comparison(sb, branch->refname, abf);
 	}
+
+	if (default_short && !upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK)
+		format_default_branch_comparison(sb, branch->refname, default_full,
+						 default_short, abf);
+
 	free(base);
+	free(default_short);
+	free(default_full);
 	return 1;
 }
 
-- 
gitgitgadget

