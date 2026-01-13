Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1B38759F
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298125; cv=none; b=KErXs/G/vl16BaEk/kGW6OlGymJuhAKez2HoSWcyWz3Ko0YWvb4q5dFlLGoTks8MP3ZIVJ8QuV25kfoR3h7eyeJO8VHngagJM26NWJ+UPTAIvq+fWm79dCtQTgRRjg07k/p778W2+eUGLNCB9Kvryg2lI/bXHrXaCW6dfDs4eWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298125; c=relaxed/simple;
	bh=/KCWDI/gLJVAoNUhnOspoFEL7iVPFjhXlM4AHyE8cck=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lipvK4ejanx1DrTarGeHIZIeBCUAp73EJeo5lSBjZxeLIGna5NAIS0ppW8ZEhW+YeSH78ke2aI+sqvhhOHozNHahBVT/iCNDZdgYVq+/K+jlZdxgagut3ihq1jCVWj9zd62DyyFNHwGXCEFd5+pFOIBZcMGyuAlIMKdWwMI6+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy05rWz7; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy05rWz7"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ffc3d389a8so3806766fac.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 01:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768298122; x=1768902922; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jSblwg08uUHaixd6aqo0ilvrCGTSgeZCaCPBzT//h4=;
        b=Zy05rWz7Edemz3nxU3adN7fiOBod1pAqMGAEb22Hg8Sw1pTT+06I4vP2Z0ybtUtHi4
         FF8V+QKmcrqE7t+wZPlLtDitelvxGfRjA51IzVpkdK3ea8yBfpEqn3pMuYBnwWaLfMOt
         b4MoEefdYiwIrGBCz8QNIM+65rKZ4OqjLoDDvplPEeTfl8D5Zf5z2lsO4xq4kbUkFoUo
         9BTXyyTUedfNromiuaSZjvmvas3suVyrVNi4aFq3GPMiABIwkHrOmLylFx7DN5qbMiRV
         i4YLqdtR/bJtrzVaoxjTWiviKwx0TtSFn7zLH8UOuc3m/1ocOnOgIedDqH5xbQCcgwzc
         erhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768298122; x=1768902922;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6jSblwg08uUHaixd6aqo0ilvrCGTSgeZCaCPBzT//h4=;
        b=eh32vUZvtTnh7nmiagqnNRcyo/4sskHg0enIDmY32YDfSW/p5RwkxB2pAJ3xczLXBr
         Bq9W6fWbA5iEPddqpQzOm336Fbt1VjoMk/GMZddUYlV04LrFxVsh4G2+VYVDn7LA0lOI
         dysPTaIjgir65gsHwFEUUrz8IUvicKd2zT2IBksbo8rjoH+X8eYvCTh6Rul/Kij1iEL2
         sW4w1Vf1ZCd4s09poPGBpqxkIPfKrnu0aRcIk9FCTpK9SavRSLvPpZkCCK5oY4xXD53Q
         +JcYiPjPW7F/x0aeVL4ca3/7ys4a2xOioygNRxpoIDIiFYpuEXc61yEE8WlXxneb04Qj
         fd+A==
X-Gm-Message-State: AOJu0Yy4ZG4QJ0L4YO/9/+ST2iV2fP5t8DFX2CUT06N0PWjRVBxA+IHV
	sfPpe7IvFnz17iCrD/XKWHx30QDPtf8ga03P6+rxCmE3hw8glGMm4bTeLdNYdw==
X-Gm-Gg: AY/fxX4bksMBN/DbDeyfmRCICyJdPJcSmz3zNN3SOc56V1F4bD+/T56PPeWYpEHWlcU
	WAqwExK5EvBri+iGTUy2PO0oIXqYFctrBJ3DAjAhC84WKWxFTNt7L514EqptnMxg3s7HafjsPvf
	7XdHOeMrkiX1LHDDMHO8jovyLJfF2aFyejMfjg6zCuon1tULQ/k9RU+XAI47HUGKyo2seLv+ljY
	JVbikQttW73YLhcK4TNlCotZz2rrmgjCx5mZsgmBM87yqlZg4UwOown1mWDZNkFKV/R9CSIu45G
	X2fCPELtAJmMUrEXMDEHjLmLAFQA/F8vdvp6znOpad/OoYZ7dpCYwrRKxohnMLE4RoMWubrUhXo
	S89d6Llq7ZvgOktsXfcl6GA7vjrLfNxCeBuyEleujxaX7DWYX8ccq4oWWfgkjnwJPGKkpIxyc06
	fUELhiB+jK0JEOoXCVOeISbdt4
X-Google-Smtp-Source: AGHT+IHqZnhk0mw3hUkITzKoY3eIRy2We5XXRFImJoac+BBbU/ao/5RlbEaVCs/2imBG6ic+gePUpg==
X-Received: by 2002:a05:6871:a84a:b0:3ec:4657:83f3 with SMTP id 586e51a60fabf-3ffc09b541fmr13179039fac.14.1768298121662;
        Tue, 13 Jan 2026 01:55:21 -0800 (PST)
Received: from [127.0.0.1] ([52.173.219.149])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4a9099csm13962450fac.0.2026.01.13.01.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:55:20 -0800 (PST)
Message-Id: <pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v23.git.git.1768249586.gitgitgadget@gmail.com>
References: <pull.2138.v23.git.git.1768249586.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Jan 2026 09:55:16 +0000
Subject: [PATCH v24 0/2] status: show comparison with push remote tracking branch
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: show comparison with push remote tracking branch

 remote.c                 | 175 ++++++++++++++++++++------
 t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 402 insertions(+), 35 deletions(-)


base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v24
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v24
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v23:

 1:  fd05c7b778 = 1:  fd05c7b778 refactor format_branch_comparison in preparation
 2:  f1ad7a1b6f ! 2:  138b79a0b9 status: show comparison with push remote tracking branch
     @@ remote.c
       enum map_direction { FROM_SRC, FROM_DST };
       
      +enum {
     -+	BRANCH_MODE_PULL = (1 << 0),
     -+	BRANCH_MODE_PUSH = (1 << 1),
     ++	ENABLE_ADVICE_PULL       = (1 << 0),
     ++	ENABLE_ADVICE_PUSH       = (1 << 1),
     ++	ENABLE_ADVICE_DIVERGENCE = (1 << 2),
      +};
      +
       struct counted_string {
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
       	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
       }
       
     -+static char *get_remote_push_branch(struct branch *branch, char **full_ref_out)
     ++static char *get_remote_push_branch(struct branch *branch)
      +{
      +	struct remote *remote;
      +	const char *push_remote;
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +		return NULL;
      +	}
      +
     -+	if (full_ref_out)
     -+		*full_ref_out = xstrdup(resolved);
     -+
     -+	ret = refs_shorten_unambiguous_ref(
     -+		get_main_ref_store(the_repository), resolved, 0);
     ++	ret = xstrdup(resolved);
      +	free(tracking_ref);
      +	return ret;
      +}
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
       				     int ours, int theirs,
       				     const char *branch_name,
       				     enum ahead_behind_flags abf,
     -+				     unsigned flags,
     - 				     bool show_divergence_advice)
     +-				     bool show_divergence_advice)
     ++				     unsigned flags)
       {
     -+	bool want_push_advice = (flags & BRANCH_MODE_PUSH) &&
     ++	bool enable_push_advice = (flags & ENABLE_ADVICE_PUSH) &&
      +		advice_enabled(ADVICE_STATUS_HINTS);
     -+	bool want_pull_advice = (flags & BRANCH_MODE_PULL) &&
     ++	bool enable_pull_advice = (flags & ENABLE_ADVICE_PULL) &&
      +		advice_enabled(ADVICE_STATUS_HINTS);
     -+	bool want_divergence_advice = show_divergence_advice &&
     ++	bool enable_divergence_advice = (flags & ENABLE_ADVICE_DIVERGENCE) &&
      +		advice_enabled(ADVICE_STATUS_HINTS);
      +
       	if (up_to_date) {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			    _("Your branch and '%s' refer to different commits.\n"),
       			    branch_name);
      -		if (advice_enabled(ADVICE_STATUS_HINTS))
     -+		if (want_push_advice)
     ++		if (enable_push_advice)
       			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
       				    "git status --ahead-behind");
       	} else if (!theirs) {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			   ours),
       			branch_name, ours);
      -		if (advice_enabled(ADVICE_STATUS_HINTS))
     -+		if (want_push_advice)
     ++		if (enable_push_advice)
       			strbuf_addstr(sb,
       				_("  (use \"git push\" to publish your local commits)\n"));
       	} else if (!ours) {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			   theirs),
       			branch_name, theirs);
      -		if (advice_enabled(ADVICE_STATUS_HINTS))
     -+		if (want_pull_advice)
     ++		if (enable_pull_advice)
       			strbuf_addstr(sb,
       				_("  (use \"git pull\" to update your local branch)\n"));
       	} else {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			branch_name, ours, theirs);
      -		if (show_divergence_advice &&
      -		    advice_enabled(ADVICE_STATUS_HINTS))
     -+		if (want_divergence_advice)
     ++		if (enable_divergence_advice)
       			strbuf_addstr(sb,
       				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
       	}
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       	const char *full_base;
       	char *base;
       	int upstream_is_gone = 0;
     -+	unsigned base_branch_modes = BRANCH_MODE_PULL | BRANCH_MODE_PUSH;
     ++	unsigned base_branch_flags = ENABLE_ADVICE_PULL | ENABLE_ADVICE_PUSH;
      +	int push_ours, push_theirs, push_cmp_fetch;
     -+	char *full_push = NULL;
     ++	char *full_push;
      +	char *push = NULL;
     -+	unsigned push_branch_modes = 0;
     ++	unsigned push_branch_flags = 0;
       
       	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
       	if (cmp_fetch < 0) {
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
       					    full_base, 0);
       
     -+	push = get_remote_push_branch(branch, &full_push);
     -+	if (push && strcmp(base, push)) {
     -+		push_cmp_fetch = stat_branch_pair(branch->refname, full_push,
     -+					   &push_ours, &push_theirs, abf);
     -+		if (push_cmp_fetch >= 0) {
     -+			base_branch_modes = BRANCH_MODE_PULL;
     -+			push_branch_modes = BRANCH_MODE_PUSH;
     ++	full_push = get_remote_push_branch(branch);
     ++	if (full_push) {
     ++		push = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
     ++						     full_push, 0);
     ++		if (push && base && strcmp(base, push)) {
     ++			push_cmp_fetch = stat_branch_pair(branch->refname, full_push,
     ++						   &push_ours, &push_theirs, abf);
     ++			if (push_cmp_fetch >= 0) {
     ++				base_branch_flags = ENABLE_ADVICE_PULL;
     ++				push_branch_flags = ENABLE_ADVICE_PUSH;
     ++			}
      +		}
      +	}
      +
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
       	} else {
      -		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
     ++		if (show_divergence_advice)
     ++			base_branch_flags |= ENABLE_ADVICE_DIVERGENCE;
      +		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf,
     -+					 base_branch_modes, show_divergence_advice);
     ++					 base_branch_flags);
      +	}
      +
     -+	if (push_branch_modes & BRANCH_MODE_PUSH) {
     ++	if (push_branch_flags & ENABLE_ADVICE_PUSH) {
      +		strbuf_addstr(sb, "\n");
      +		format_branch_comparison(sb, !push_cmp_fetch, push_ours, push_theirs, push, abf,
     -+					 push_branch_modes, 0);
     ++					 push_branch_flags);
       	}
       
       	free(base);

-- 
gitgitgadget
