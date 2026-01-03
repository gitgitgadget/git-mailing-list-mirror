Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E1E1FB1
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767409707; cv=none; b=OVA/glqsoLQqFGylcXADniEEL9qE+npQWD6vN1B/CDsFyua8z5pJIRO6PFL69z19W2bnZAR784un8cLW/vnNFMHyTpz7f1dxutEVrxlwFQOdjJLrip8ko041HOtsWyaYZyZPQRW9Eo9IuzczRT2Cg0J9O47o3RtJJ4Pnklxv07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767409707; c=relaxed/simple;
	bh=W22HcjwOn+2nSJPkiQh/c6AFIklyKbHTyrNuopWu178=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IUSdT6IPSqMPeNTr6zfv/qm1o566KmkdqJ28tHXJnb6vHowqfqUJCNYlXDb/2J0Cp0zk7zUjwduSUhXoM7Q14jgyxMy/IBvatr+3z2uxdXHro3MsTzwONqL9ZWYH6Jo7UFhSnqjj0VN01iwuQVxxKUwdcM32TvMD///g9wne8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAt6ASZ+; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAt6ASZ+"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ce2b14202fso249324a34.3
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 19:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767409704; x=1768014504; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0Kce2EPWGjBxRDL8DCYF3ckZB/NXdrk8eHJomtAzu8=;
        b=NAt6ASZ+BzOpngjbPZ0tRC023o+sIqrImEqjg36Ej85OhW8zihSMAMJm+Aaq3+Lg0p
         WJYt3uRbGSbYSXvL+fCr9qtlsKWB3Yn9xeHcend2E0hIy58rNQJk+OKwOuKnHYO4VmGC
         cDHx43MBd8lwkbQXxaKyi9duPDTpe6F9Pwqjwz4U9w2tR7vhIetLPBT9A8z7kr+34sGb
         EFH3XJbizqfRguhDsqo7ac1czsO1+lPQP5BtuUEwzFDymQLTZHVdZFgLRBLHs1DZqVCJ
         srnjUQrHSsb0C6CU2t3wkpbeYwuhjITX73H2jv5eB/hKZdY8YWO8RKEScVbTV4SWfUyA
         UudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767409704; x=1768014504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0Kce2EPWGjBxRDL8DCYF3ckZB/NXdrk8eHJomtAzu8=;
        b=TFcBo6bVQSkOIERxaLI2Tn52Es29baQPcG6CiKNmWuzkKBSmIvJ9MgK+lp5vyR0D4G
         OCr7XEuN0vxiVWsvWsw9CULgIkUc9t3NdUmqupD3k469Jjw71CmXfr+j90S0ktw/gpkg
         +sm783PLpa3aUMfvfege/JrGz1NLTyVyO0nu4cTvGcryqii3MRrmh7R3wkpTBgwVaAeh
         SjS+1X66S9rX3uwJFN9xho9GGvfBIabiCezzottzlBdo/y4tVkfVvc0+iJ4Jenqhy/th
         dBFVRZgttAmHCzB3ZcS7TeIi7sojT2GRdD5JQeFS93yMXKeyiKIGhN0kcefIg+MifPcV
         UObQ==
X-Gm-Message-State: AOJu0YwnawG7ilJEyW+NcYX/eT/gHVHB2OjSbJM3smIWVrxq2AwU4M79
	+XyGIZNP0bsAjalCnrDmzG23sQ2zATd0/v5b+dMwJxF+syDYVjm1rU5wCUk7tA==
X-Gm-Gg: AY/fxX53/sf1camPew1UTS1IfM8QDG06AFz7l/U1N99+gtbQKCgQhrp3bfoZ1PbLJqr
	O2F5B0DLujvfUD17sU7yH/DTivEPVIkeJhUOEOb0SD6Ta203AGCLn+iWAxRO+izS2eLx57+K9Am
	BaW1tLLSYqeKcT9VkmI7eGmqT30wDrMyG3UkZmhP4cIIfu0OdY33E0lATt9UifntNhJB0fktoWm
	KQdzUMSW9oYQjdJB6TjvuzUeKTE/A01o2tmYWQYmTKXiysYm9TwAyvVLVj6CUmnpVivH11gz/IC
	Jxhw5/8zhxtCU5On9EV7VU2WJMNbPwlH12SCZjSc/kOg6WPAXwVCCdZ42iSRBQaKtIazWq1L7rm
	qQrltyn00ni6eb3bn48m4cfIy5T6IZJaDHcGLMO5JZBfjREq+W3K9YuQCv17qpOokpBBD9+e17V
	k8fvrd9gD/momEJQ==
X-Google-Smtp-Source: AGHT+IH1oibUyTDyRK8yYPFmIgAgVbMDxOjzaUXHBQXzuy0h/SuepsvU6hJk2CVv1jsNYE93kvlxTg==
X-Received: by 2002:a05:6830:dc6:b0:7c7:1c77:f107 with SMTP id 46e09a7af769-7cc66a9e05dmr23015661a34.34.1767409703740;
        Fri, 02 Jan 2026 19:08:23 -0800 (PST)
Received: from [127.0.0.1] ([52.165.213.178])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667d4f57sm29227941a34.18.2026.01.02.19.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 19:08:23 -0800 (PST)
Message-Id: <pull.2138.v13.git.git.1767409701.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v12.git.git.1767389649.gitgitgadget@gmail.com>
References: <pull.2138.v12.git.git.1767389649.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Jan 2026 03:08:19 +0000
Subject: [PATCH v13 0/2] status: show comparison with push remote tracking branch
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

Harald Nordgren (2):
  refactor: format_branch_comparison in preparation
  status: show comparison with push remote tracking branch

 remote.c                 | 152 ++++++++++++++++++++++++++---------
 t/t6040-tracking-info.sh | 168 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 283 insertions(+), 37 deletions(-)


base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v13
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v12:

 1:  a2c160c53e = 1:  a2c160c53e refactor: format_branch_comparison in preparation
 2:  a586038d1f ! 2:  891239211e status: show comparison with push remote tracking branch
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       	const char *full_base;
       	char *base;
       	int upstream_is_gone = 0;
     -+	int push_ours = 0, push_theirs = 0;
     -+	int push_stat_result = -1;
     -+	int will_show_push_comparison = 0;
     ++	int push_ours, push_theirs, push_sti;
     ++	char *full_push = NULL;
     ++	char *push = NULL;
     ++	int show_push_comparison = 0;
       
       	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
       	if (sti < 0) {
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
       					    full_base, 0);
       
     -+	if (!upstream_is_gone && abf != AHEAD_BEHIND_QUICK) {
     -+		char *push_full = NULL;
     -+		char *push_short = get_remote_push_branch(branch, &push_full);
     -+
     -+		if (push_short && strcmp(base, push_short)) {
     -+			push_stat_result = stat_branch_pair(branch->refname, push_full,
     -+							    &push_ours, &push_theirs, abf);
     -+			if (push_stat_result >= 0)
     -+				will_show_push_comparison = 1;
     -+		}
     -+
     -+		free(push_short);
     -+		free(push_full);
     ++	push = get_remote_push_branch(branch, &full_push);
     ++	if (push && strcmp(base, push)) {
     ++		push_sti = stat_branch_pair(branch->refname, full_push,
     ++					   &push_ours, &push_theirs, abf);
     ++		if (push_sti >= 0)
     ++			show_push_comparison = 1;
      +	}
      +
       	format_branch_comparison(sb, ours, theirs, base, upstream_is_gone, abf, sti);
       	if (sti > 0 && abf != AHEAD_BEHIND_QUICK) {
      -		if (!theirs && advice_enabled(ADVICE_STATUS_HINTS)) {
     -+		if (!theirs && !will_show_push_comparison &&
     ++		if (!theirs && !show_push_comparison &&
      +		    advice_enabled(ADVICE_STATUS_HINTS)) {
       			strbuf_addstr(sb,
       				_("  (use \"git push\" to publish your local commits)\n"));
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       		}
       	}
       
     -+	if (will_show_push_comparison) {
     -+		char *push_full = NULL;
     -+		char *push_short = get_remote_push_branch(branch, &push_full);
     -+
     -+		if (push_short && strcmp(base, push_short)) {
     -+			strbuf_addstr(sb, "\n");
     -+			format_branch_comparison(sb, push_ours, push_theirs, push_short, 0, abf,
     -+						push_ours || push_theirs);
     -+			if (push_ours > 0 && push_theirs == 0 &&
     -+			    advice_enabled(ADVICE_STATUS_HINTS)) {
     ++	if (show_push_comparison) {
     ++		strbuf_addstr(sb, "\n");
     ++		format_branch_comparison(sb, push_ours, push_theirs, push, 0, abf, push_sti);
     ++		if (push_sti > 0 && abf != AHEAD_BEHIND_QUICK) {
     ++			if (!push_theirs && advice_enabled(ADVICE_STATUS_HINTS)) {
      +				strbuf_addstr(sb,
      +					_("  (use \"git push\" to publish your local commits)\n"));
      +			}
      +		}
     -+
     -+		free(push_short);
     -+		free(push_full);
      +	}
      +
       	free(base);
     ++	free(full_push);
     ++	free(push);
       	return 1;
       }
     + 
      
       ## t/t6040-tracking-info.sh ##
      @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '

-- 
gitgitgadget
