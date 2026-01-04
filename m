Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A122286D5D
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767527639; cv=none; b=PyLnEnxFJPnt7RVFJKh+OAee+NOupjX/ULnHE9NNsAQwQx6mknuGeWdOZGOdu8sE8rxCQevQnYvqLZseUA283bzQWmQqEjnxoasifC1U4p2E3Spn2Q8swTuZWeq3Fa1VokLfHr9g04MfPEpOuaGOAeX8iwuoJEq3GtPBm3e6osw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767527639; c=relaxed/simple;
	bh=EYtkCVT8irgL47apphFxDd9VqL2lVbx4hMHtAKwgUGs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qoml45B9vWzcBGBQH/StUw48zh7tsBua7463t6XDGdK7t4MEDVNifqYEiftU2iuPPA/+CHBP+u3YWTD1PeliCHaqArGDqK1n8XUaJJ4+aPG9rRb4caBWXE2Fvab65Ippj5GY+3JFw8Qusxwrb2peFDnbtf5r5GMX9pG0FqL2vNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbXVi7EK; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbXVi7EK"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a2b99d8c5so106215006d6.1
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 03:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767527636; x=1768132436; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQdpU13hOWKZRaVwfDp09LDPRKDO5qbBALjjq8zaOxM=;
        b=HbXVi7EKdVKHzJ+cIMWDaS43j2DNjpUiT56FnAEB81PwBDjUDHaeojzpO0Vu+MFVG2
         A0k6pAD1ZzQ97fwCzyOid9807uoa7vQbkdJDEgbI7Wci92uV+Q2e8OCir0RuPs1DYiyc
         a/uP3+ZfTf0A7cIzFJfwsf6B0YUWLU7rybCJ2gS4MJMJOWY7ib9GGjgGt/0O+2lJTfsK
         Dr6vTFbZp96iDjkDvo/wwqelyCIuSFWdwzYL/pPIeJedwryhGiZtVufTxA2M5Fwm7v61
         B9V7MVEO5Tw3NcTlTaKl9zewfAOzW+2iz3sZsFMmi0zMHTcuc6tqBBzEaKpN8BN+sY/a
         YoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767527636; x=1768132436;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YQdpU13hOWKZRaVwfDp09LDPRKDO5qbBALjjq8zaOxM=;
        b=gm3DXZZQHES2CLW4wzk0QrSBboH8cTJHzT/zhCZdkv2ck4A6NBX9/BOkBDgJx68tS/
         0oIY4gnUPh6GloWdTnKDTtGAiwPdfMhw7Fu78onTnQVRNXlkdwtSH4wzs98mvRV0BP95
         v31Dgk8+VJ60V3udQ+GYZfiCBcr+Ax3ewevrEUCZvCffvvkaK7qp29yoCEm8sa1vpUw0
         Q9UptGCavl8lpEjLgRQEA6ebOspaue+sKzD4+bJElGjf64mSfTkAFuxFsdn+uZ6zVM8e
         u/PX7Zl36czmG2NEl6Bzvz0EVLI8k1YGFYlIByG1A7uJz9SvFNZT8TvaBPQ5vBZqOj6g
         ctLw==
X-Gm-Message-State: AOJu0YxJ79bUWaXRcltYb9m8WRM160M4T01aSHV3HBBeW6Pu8IN5y5Ms
	bYvzuMF30pRGARMhdCLYZ1Og+GIolRCpCMjNWncfa2U5SSdZydwbWjAdHiPf8Q==
X-Gm-Gg: AY/fxX4gqzTUwKUOGNr2OMPl7BAclwmGajFCnUK7j/0lZu5C79zBt4GoZ71oE0KOHZl
	Qg8/LakKEdx3tV+VRP49hWwYIEKCbEEQrwuyF5wU0pREXqol3EO8lwCpQkP6d6LfoYQWNtt0MtG
	soLBjFftRUamjJQsMvRlJO5Hv3apen0HfsgKUc6FXc94Rp9h9y/wibrPSHDJBMpS/YnJoJRUnOC
	BDqbHVwYXip0C5FWPUJ2cCdDV2FsxS1cpCJ3jmXsFdclOYTiwUFbmmLbxFBj7iN2VGvcZqIcTEU
	eUjRVcFtJAtEnENHTeoPi1ZDB0i/CgKnma+Hw9w2/rex1WCDpkZ46ZdlzBKRSRu5igsheSQxiu3
	+4Avxd9xPq8rJFUDkzWNVvg9/+gd1YsZl0sTL8hgc7fj8d1SbYka7MhOmIKxggz0jyDft8fru3O
	9Kxs+yEB17zZU=
X-Google-Smtp-Source: AGHT+IHx2q+vXivFegd4C5r5fYRM9wJmC1+nhTBtMGScRydB1m/gXsuXgC/MYgmhaRigYf8UlX23xw==
X-Received: by 2002:a05:6214:400d:b0:888:23a9:7b01 with SMTP id 6a1803df08f44-88d833b5f6fmr763434196d6.42.1767527635542;
        Sun, 04 Jan 2026 03:53:55 -0800 (PST)
Received: from [127.0.0.1] ([74.249.78.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688dcedsm3539050885a.12.2026.01.04.03.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 03:53:54 -0800 (PST)
Message-Id: <pull.2138.v15.git.git.1767527634.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v14.git.git.1767445236.gitgitgadget@gmail.com>
References: <pull.2138.v14.git.git.1767445236.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 11:53:52 +0000
Subject: [PATCH v15 0/2] status: show comparison with push remote tracking branch
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
cc: Nico Williams nico@cryptonector.com

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: show comparison with push remote tracking branch

 remote.c                 | 168 ++++++++++++++++++++++++-------
 t/t6040-tracking-info.sh | 210 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 342 insertions(+), 36 deletions(-)


base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v15
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v15
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v14:

 1:  a2c160c53e ! 1:  cf4e9779c5 refactor: format_branch_comparison in preparation
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    refactor: format_branch_comparison in preparation
     +    refactor format_branch_comparison in preparation
      
          Refactor format_branch_comparison function in preparation for showing
          comparison with push remote tracking branch.
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      -			 enum ahead_behind_flags abf,
      -			 int show_divergence_advice)
      +static void format_branch_comparison(struct strbuf *sb,
     -+				     int ahead, int behind,
     ++				     int ours, int theirs,
      +				     const char *branch_name,
     -+				     int upstream_is_gone,
      +				     enum ahead_behind_flags abf,
     -+				     int sti)
     ++				     int show_divergence_advice)
       {
      -	int ours, theirs, sti;
      -	const char *full_base;
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      -
      -	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
      -					    full_base, 0);
     - 	if (upstream_is_gone) {
     - 		strbuf_addf(sb,
     - 			_("Your branch is based on '%s', but the upstream is gone.\n"),
     +-	if (upstream_is_gone) {
     +-		strbuf_addf(sb,
     +-			_("Your branch is based on '%s', but the upstream is gone.\n"),
      -			base);
     -+			branch_name);
     - 		if (advice_enabled(ADVICE_STATUS_HINTS))
     - 			strbuf_addstr(sb,
     - 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
     - 	} else if (!sti) {
     - 		strbuf_addf(sb,
     - 			_("Your branch is up to date with '%s'.\n"),
     +-		if (advice_enabled(ADVICE_STATUS_HINTS))
     +-			strbuf_addstr(sb,
     +-				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
     +-	} else if (!sti) {
     +-		strbuf_addf(sb,
     +-			_("Your branch is up to date with '%s'.\n"),
      -			base);
     -+			branch_name);
     - 	} else if (abf == AHEAD_BEHIND_QUICK) {
     +-	} else if (abf == AHEAD_BEHIND_QUICK) {
     ++	if (abf == AHEAD_BEHIND_QUICK) {
       		strbuf_addf(sb,
       			    _("Your branch and '%s' refer to different commits.\n"),
      -			    base);
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
       		if (advice_enabled(ADVICE_STATUS_HINTS))
       			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
       				    "git status --ahead-behind");
     --	} else if (!theirs) {
     -+	} else if (ahead == 0 && behind == 0) {
     ++	} else if (!ours && !theirs) {
      +		strbuf_addf(sb,
      +			_("Your branch is up to date with '%s'.\n"),
      +			branch_name);
     -+	} else if (ahead > 0 && behind == 0) {
     + 	} else if (!theirs) {
       		strbuf_addf(sb,
       			Q_("Your branch is ahead of '%s' by %d commit.\n",
       			   "Your branch is ahead of '%s' by %d commits.\n",
     --			   ours),
     + 			   ours),
      -			base, ours);
     --		if (advice_enabled(ADVICE_STATUS_HINTS))
     --			strbuf_addstr(sb,
     --				_("  (use \"git push\" to publish your local commits)\n"));
     --	} else if (!ours) {
     -+			   ahead),
     -+			branch_name, ahead);
     -+	} else if (behind > 0 && ahead == 0) {
     - 		strbuf_addf(sb,
     - 			Q_("Your branch is behind '%s' by %d commit, "
     - 			       "and can be fast-forwarded.\n",
     ++			branch_name, ours);
     + 		if (advice_enabled(ADVICE_STATUS_HINTS))
     + 			strbuf_addstr(sb,
     + 				_("  (use \"git push\" to publish your local commits)\n"));
     +@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       			   "Your branch is behind '%s' by %d commits, "
       			       "and can be fast-forwarded.\n",
     --			   theirs),
     + 			   theirs),
      -			base, theirs);
     --		if (advice_enabled(ADVICE_STATUS_HINTS))
     --			strbuf_addstr(sb,
     --				_("  (use \"git pull\" to update your local branch)\n"));
     --	} else {
     -+			   behind),
     -+			branch_name, behind);
     -+	} else if (ahead > 0 && behind > 0) {
     - 		strbuf_addf(sb,
     - 			Q_("Your branch and '%s' have diverged,\n"
     - 			       "and have %d and %d different commit each, "
     ++			branch_name, theirs);
     + 		if (advice_enabled(ADVICE_STATUS_HINTS))
     + 			strbuf_addstr(sb,
     + 				_("  (use \"git pull\" to update your local branch)\n"));
      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     - 			   "Your branch and '%s' have diverged,\n"
       			       "and have %d and %d different commits each, "
       			       "respectively.\n",
     --			   ours + theirs),
     + 			   ours + theirs),
      -			base, ours, theirs);
     --		if (show_divergence_advice &&
     --		    advice_enabled(ADVICE_STATUS_HINTS))
     -+			   ahead + behind),
     -+			branch_name, ahead, behind);
     -+	}
     ++			branch_name, ours, theirs);
     + 		if (show_divergence_advice &&
     + 		    advice_enabled(ADVICE_STATUS_HINTS))
     + 			strbuf_addstr(sb,
     + 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
     + 	}
      +}
      +
      +/*
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      +	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
      +					    full_base, 0);
      +
     -+	format_branch_comparison(sb, ours, theirs, base, upstream_is_gone, abf, sti);
     -+	if (sti > 0 && abf != AHEAD_BEHIND_QUICK) {
     -+		if (!theirs && advice_enabled(ADVICE_STATUS_HINTS)) {
     -+			strbuf_addstr(sb,
     -+				_("  (use \"git push\" to publish your local commits)\n"));
     -+		} else if (!ours && advice_enabled(ADVICE_STATUS_HINTS)) {
     ++	if (upstream_is_gone) {
     ++		strbuf_addf(sb,
     ++			_("Your branch is based on '%s', but the upstream is gone.\n"),
     ++			base);
     ++		if (advice_enabled(ADVICE_STATUS_HINTS))
      +			strbuf_addstr(sb,
     -+				_("  (use \"git pull\" to update your local branch)\n"));
     -+		} else if (ours && theirs && show_divergence_advice &&
     -+			   advice_enabled(ADVICE_STATUS_HINTS)) {
     - 			strbuf_addstr(sb,
     - 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
     -+		}
     - 	}
     ++				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
     ++	} else {
     ++		format_branch_comparison(sb, ours, theirs, base, abf, show_divergence_advice);
     ++	}
      +
       	free(base);
       	return 1;
 2:  b9b2f15498 ! 2:  a435cf4ce4 status: show comparison with push remote tracking branch
     @@ Commit message
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## remote.c ##
     +@@
     + 
     + enum map_direction { FROM_SRC, FROM_DST };
     + 
     ++enum branch_type {
     ++	PUSH = 1 << 0,
     ++	PULL = 1 << 1
     ++};
     ++
     + struct counted_string {
     + 	size_t len;
     + 	const char *s;
      @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
       	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
       }
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +}
      +
       static void format_branch_comparison(struct strbuf *sb,
     - 				     int ahead, int behind,
     + 				     int ours, int theirs,
       				     const char *branch_name,
     + 				     enum ahead_behind_flags abf,
     ++				     enum branch_type bt,
     + 				     int show_divergence_advice)
     + {
     + 	if (abf == AHEAD_BEHIND_QUICK) {
     +@@ remote.c: static void format_branch_comparison(struct strbuf *sb,
     + 			   "Your branch is ahead of '%s' by %d commits.\n",
     + 			   ours),
     + 			branch_name, ours);
     +-		if (advice_enabled(ADVICE_STATUS_HINTS))
     ++		if ((bt & PUSH) && advice_enabled(ADVICE_STATUS_HINTS))
     + 			strbuf_addstr(sb,
     + 				_("  (use \"git push\" to publish your local commits)\n"));
     + 	} else if (!ours) {
     +@@ remote.c: static void format_branch_comparison(struct strbuf *sb,
     + 			       "and can be fast-forwarded.\n",
     + 			   theirs),
     + 			branch_name, theirs);
     +-		if (advice_enabled(ADVICE_STATUS_HINTS))
     ++		if ((bt & PULL) && advice_enabled(ADVICE_STATUS_HINTS))
     + 			strbuf_addstr(sb,
     + 				_("  (use \"git pull\" to update your local branch)\n"));
     + 	} else {
     +@@ remote.c: static void format_branch_comparison(struct strbuf *sb,
     + 			       "respectively.\n",
     + 			   ours + theirs),
     + 			branch_name, ours, theirs);
     +-		if (show_divergence_advice &&
     ++		if ((bt & PULL) &&
     ++		    show_divergence_advice &&
     + 		    advice_enabled(ADVICE_STATUS_HINTS))
     + 			strbuf_addstr(sb,
     + 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       	const char *full_base;
       	char *base;
       	int upstream_is_gone = 0;
     ++	enum branch_type base_bt = PUSH | PULL;
      +	int push_ours, push_theirs, push_sti;
      +	char *full_push = NULL;
      +	char *push = NULL;
     -+	int show_push_comparison = 0;
     ++	enum branch_type push_bt = 0;
       
       	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
       	if (sti < 0) {
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      +	if (push && strcmp(base, push)) {
      +		push_sti = stat_branch_pair(branch->refname, full_push,
      +					   &push_ours, &push_theirs, abf);
     -+		if (push_sti >= 0)
     -+			show_push_comparison = 1;
     ++		if (push_sti >= 0) {
     ++			base_bt = PULL;
     ++			push_bt = PUSH;
     ++		}
      +	}
      +
     - 	format_branch_comparison(sb, ours, theirs, base, upstream_is_gone, abf, sti);
     - 	if (sti > 0 && abf != AHEAD_BEHIND_QUICK) {
     --		if (!theirs && advice_enabled(ADVICE_STATUS_HINTS)) {
     -+		if (!theirs && !show_push_comparison &&
     -+		    advice_enabled(ADVICE_STATUS_HINTS)) {
     - 			strbuf_addstr(sb,
     - 				_("  (use \"git push\" to publish your local commits)\n"));
     - 		} else if (!ours && advice_enabled(ADVICE_STATUS_HINTS)) {
     + 	if (upstream_is_gone) {
     + 		strbuf_addf(sb,
     + 			_("Your branch is based on '%s', but the upstream is gone.\n"),
      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     - 		}
     - 	}
     - 
     -+	if (show_push_comparison) {
     -+		strbuf_addstr(sb, "\n");
     -+		format_branch_comparison(sb, push_ours, push_theirs, push, 0, abf, push_sti);
     -+		if (push_sti > 0 && abf != AHEAD_BEHIND_QUICK) {
     -+			if (!push_theirs && advice_enabled(ADVICE_STATUS_HINTS)) {
     -+				strbuf_addstr(sb,
     -+					_("  (use \"git push\" to publish your local commits)\n"));
     -+			}
     -+		}
     + 			strbuf_addstr(sb,
     + 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
     + 	} else {
     +-		format_branch_comparison(sb, ours, theirs, base, abf, show_divergence_advice);
     ++		format_branch_comparison(sb, ours, theirs, base, abf, base_bt,
     ++					 show_divergence_advice);
      +	}
      +
     ++	if (push_bt & PUSH) {
     ++		strbuf_addstr(sb, "\n");
     ++		format_branch_comparison(sb, push_ours, push_theirs, push, abf,
     ++					 push_bt, 0);
     + 	}
     + 
       	free(base);
      +	free(full_push);
      +	free(push);

-- 
gitgitgadget
