Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96A336EE3
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768043195; cv=none; b=LWB1xngQYERCpdZfMYQ7lpnETFvJMw2QPXRikWlbJc421AJfVOIJ8+SJKPjlNbMnNVilZ8JNb1juIEX5jXPoBQkyjTQ7NErpvSuc1Vw1yw461Q2EpIHEekeauEkY+/cREeIo2AKaOXhWm3660DpOwYJo1HyDYvqUsjkIJbF/OKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768043195; c=relaxed/simple;
	bh=rUJsEgFzSHxfDQAxjPk2t7QGQZc2GTPt5z+/i0VeTN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLisjWurEjc7xsemDCE8LP9e/3C4Uzge3Xca3+0zrs2s31jS3YPC1kibla90z9DIAFvsj7ca/IygqqirhiUWUOFbnVk0dIAMeMI7XuhDbyRk5RbuwK0sUfHOCy2K0On3ThuemRWwprfLoT/R1llSflAJS/d53f3gc3CtrEDhsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRNwHG9T; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRNwHG9T"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b7be7496dso2840612e87.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 03:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768043192; x=1768647992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VAvb+8ojgbSfdYaNlnzUtJr7F2/c1Lekn3wSmjyObU=;
        b=GRNwHG9TEP08GtTqCWa9FavJ8UzCi+QjpjGSF5OUGZ4o9rOnq1wUeXI4IJ/7BvToR/
         9ogd1JnC/SRex9qV+yhwxSNNaucMJVWbSTLNl+Qq9WhUyE2TweFOJOG0Iap6SK59OUcP
         +O0zwPQlveKS6tC0dRRW63ynf7EQFLNAVxYJw+3LloLngKsWUg4S7OLz4YKysq2pcp/N
         zigO/6rniMzHG4yRQq0d56KioE0fBT7e3wrTb3yxBbdWDT7lF05V17G8B0creGnP05cC
         GmZ/zHRAzA9lZ+YiFKaz4QZ1wTmp6augukOFeyEntU/mUmH6hz8IqIre68P2p+DGacpV
         I1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768043192; x=1768647992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0VAvb+8ojgbSfdYaNlnzUtJr7F2/c1Lekn3wSmjyObU=;
        b=CtiOfEhoQUpNNAHuDcJZggT8Di+gng4l9Mof1cFxHD7mF5wJ38141VdPUdI/hV8E+S
         /ig+TgBSFSTNnHcFn7fYdberORE1NEcDj9v44gE8uizT7y9AXqpih85x47zZ+9ouWb3L
         xtVkd549jzyj0vb4BePOnAMgy4YWejb3O1T2FwVlEHppQZQer1L3TiE1QO5GlSkz5cWh
         RjI/xwq6gKxLdYb1L74VUvV1TAbW7dNAZL5RMyqNYF8bwWg/yd8zyhP6bBsnl75yVd6E
         TiHju5rgcBd9fyk0BzDxiJgs2BxYTjRoBQFXqX2mrYdZwXJQtp0GmAcbAh+dJpfIPsS0
         yFpA==
X-Gm-Message-State: AOJu0YzzZ+nw2v9ZhKEE43T4sObdtJcJR7xrS+cLyCG603sbolNkmtVF
	6D9mPxyI+1rpaKGU1rasAkT973QmpafY/+UOS0A5ialGqJ2eoFTzKc4UkrgyNA==
X-Gm-Gg: AY/fxX4ToZHFIOiQ6pxfwEJ0EyfmFwSmurT3kvrEUPlfFWpNmfd1izUnqXObZcJLto4
	RkK2NoMbNvoVWy5SU7juBujTYuRFY04/t1IMaur5WFvrL3VUAwvv8IMs5AvfLDWi3fLi62Frvyr
	akjfxQcXNtct+QqXp9hNkYI8fzhJsSkDTM17zFVydd658baXvX3k4HyxQCOejTwH3HmDk0Rui30
	uZbz4U+H/H64n094l2XFQDhEOegqiraOS5ZgnIEB3sUCviieEjgFT1E3bDW0PID+GHHRDIQfZPR
	BGtSzoYDdYOADUYleKbCsCr1AW0d8R3nVa6EMy3LUCjf547GQ5IdLmEdMWHSes2Ilj8/nitUDsG
	psUNxWDBbzWreRLT5AC0wnYohRbU/0GaprEoUGhKAZ2dF2Ik8RKfi+u+JqZgLX8gMXO/Ifcw9T2
	56+au0uxS2KLrbnpAPl3x/cDBgh9Zu4JKd1HkkRtfKNWQodgFa3+tSNdgqCrnr3wNW7Vxofus=
X-Google-Smtp-Source: AGHT+IHYwMEFqbX4YS0IahS38A5MFreqMsqUax9Wy+iYO1JgAQ7VyEAiRkqVnOY5pCBuUzxjBwrIXQ==
X-Received: by 2002:a05:6512:1292:b0:598:fac9:fdb7 with SMTP id 2adb3069b0e04-59b6f04f6edmr4028387e87.35.1768043191268;
        Sat, 10 Jan 2026 03:06:31 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b6addaab0sm2980198e87.28.2026.01.10.03.06.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Jan 2026 03:06:30 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
Date: Sat, 10 Jan 2026 12:06:29 +0100
Message-Id: <20260110110629.18501-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqq7btqtdgy.fsf@gitster.g>
References: <xmqq7btqtdgy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's following my naming scheme where each push version of a base variable
tacks on _push at the end. Since the push logic introduces a second version
of most variables, it's hard to make it fully logical when the base versions
still retain their "unqualified" names.

I can rename the sti's to 'cmp_fetch' and 'cmp_fetch_push', but does it
help?

Probably best would be to create a struct for the common variables between
base and push cases. But that's a large refactoring, so maybe better done
as a separate follow-up to all of this instead? Here's what is looks like:

```
diff --git a/remote.c b/remote.c
index eba013b6b4..581a62c266 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,41 +2237,47 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+struct format_branch {
+	int ours, theirs;
+	int cmp_fetch;
+	bool up_to_date;
+	const char *full;
+	char *name;
+};
+
 static void format_branch_comparison(struct strbuf *sb,
-				     bool up_to_date,
-				     int ours, int theirs,
-				     const char *branch_name,
+				     const struct format_branch *branch,
 				     enum ahead_behind_flags abf,
 				     bool show_divergence_advice)
 {
-	if (up_to_date) {
+	if (branch->up_to_date) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
-			branch_name);
+			branch->name);
 	} else if (abf == AHEAD_BEHIND_QUICK) {
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
-			    branch_name);
+			    branch->name);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
-	} else if (!theirs) {
+	} else if (!branch->theirs) {
 		strbuf_addf(sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
-			   ours),
-			branch_name, ours);
+			   branch->ours),
+			branch->name, branch->ours);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
-	} else if (!ours) {
+	} else if (!branch->ours) {
 		strbuf_addf(sb,
 			Q_("Your branch is behind '%s' by %d commit, "
 			       "and can be fast-forwarded.\n",
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
-			   theirs),
-			branch_name, theirs);
+			   branch->theirs),
+			branch->name, branch->theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
@@ -2283,8 +2289,8 @@ static void format_branch_comparison(struct strbuf *sb,
 			   "Your branch and '%s' have diverged,\n"
 			       "and have %d and %d different commits each, "
 			       "respectively.\n",
-			   ours + theirs),
-			branch_name, ours, theirs);
+			   branch->ours + branch->theirs),
+			branch->name, branch->ours, branch->theirs);
 		if (show_divergence_advice &&
 		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
@@ -2299,33 +2305,32 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			 enum ahead_behind_flags abf,
 			 int show_divergence_advice)
 {
-	int ours, theirs, sti;
-	const char *full_base;
-	char *base;
 	int upstream_is_gone = 0;
+	struct format_branch base;
 
-	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
-	if (sti < 0) {
-		if (!full_base)
+	base.cmp_fetch = stat_tracking_info(branch, &base.ours, &base.theirs, &base.full, 0, abf);
+	base.up_to_date = !base.cmp_fetch;
+	if (base.cmp_fetch < 0) {
+		if (!base.full)
 			return 0;
 		upstream_is_gone = 1;
 	}
 
-	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
-					    full_base, 0);
+	base.name = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+					    base.full, 0);
 
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
-			base);
+			base.name);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
 	} else {
-		format_branch_comparison(sb, !sti, ours, theirs, base, abf, show_divergence_advice);
+		format_branch_comparison(sb, &base, abf, show_divergence_advice);
 	}
 
-	free(base);
+	free(base.name);
 	return 1;
 }
```


Harald
