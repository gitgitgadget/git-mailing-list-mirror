Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A64A01
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768058657; cv=none; b=gbsDYfBzwSICPKAV3KDH+1+2cLvcl1E1Jz1gsDFWfexoaFaNkyRtQG6dYeOV2Dh+hFoWygFnw00RZcFwUX4R7vKyAKrnAEj42VaEQTI6TR8tieoqpKYo4wqeWJ3slQKL66cSYjpvfAZ3/qBuTwbQw+ltBDZ6E9rZYg9Vyid6EfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768058657; c=relaxed/simple;
	bh=utTXsCfFobofbQs2hMq8g56NAK9ANmYRRU4NgQ+tgW4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=senZc9vZ6Z5YrMjFinyiGitTnf+hjk2CFj4WgL1SuNTU7ioUUpiQhKoMGIhmVa14Oq8jNLBaS2JMm+Elj+3sWpnrYaE2Xm87X6MMvlBdMNrmuDyWXn5dQr6fEPpKuhudbm2JxZaEQ01jYk5hetpmOgzzp2l3pFTdViSt+zsM3R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVB9TNiY; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVB9TNiY"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2aef8e4a569so4152078eec.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 07:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768058655; x=1768663455; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcloH6+hGdxFLpA14wTmc11F8NhsHqbY6IsqGdONCwo=;
        b=bVB9TNiYa2r4sFKOULnwE2o8kq5ZscMxl/M4RzksOZT4kOrAZ6JxdCsxrUiUFD1gUl
         l0yuQsWViUZjVZWbsNKrv6ReLWsA2+Hu+fZI6L8x1Zp3MnZ/ockJCmLuXHCjY+D/xZ8O
         zw+eZa6ZXQIhvaSkmpNYyON4zYTNkhCJZ4zCDGBU0HDHSq47iFMaxzmP5gZKt807Eg/B
         7XnrNjtulnYngTwPu9ZzR0qKaSDVlKlcsFqsI/T9VrmG4UwC8+IrWl20IupHVKMyEo6H
         wrxEcVLNYUISZijCJj7wSt65cCW/90/vupIq7PhZ04cnUgLDwV3psvoY7VkMK+5ctwOn
         sLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768058655; x=1768663455;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wcloH6+hGdxFLpA14wTmc11F8NhsHqbY6IsqGdONCwo=;
        b=Upbx6VsOA+g1kPAPk+COewnb+/MqKUwa1PPkCrbmrjesX4jNR1hPSQRQK7zom2wUrV
         KCCaWkVYuPLwKvTV9CHvqiCPp/Ie4kBHRYQRRa438yzl2zEoUMqmQY6HCtpdZ2tqCAyR
         Rm5I5wHRWvyvu/CuXJVIjofv5AKVYwiBh3iOT/C+HNsZ+vDkEZeeYAbWivbpFYjzGg6K
         ZvMKzit9Mk3IL0xnGpEqJ2D0sMJen7o5AwQ0dtf27wGw2HAHXkqNO7YzERcea8cUKCm1
         FkqJvFSY0yvdfUsuHmX6L4/EdbIPVoumdwi8yOGYD4RsfXuBYOY0qJWd6QUR35Q+epyj
         cCWw==
X-Gm-Message-State: AOJu0Yzi9/GNw3HKuO7XPcI+NGalp45BdCXlDmJDTgFdLoI6NVSPvHl6
	pwDVo5FcDNqpdvvSaFPBQN6fGvHpvJL0de9zjvYA9EPTIaO0xScHX9dWNWL+TQ==
X-Gm-Gg: AY/fxX4Y4LSlNjTUpq0QqtX3qYjjAZmZAldI/k7hYQ/1XrWzQaoo3PPW0MlI3Tdtfut
	Q5jN2OfEacLB5vBYq89wTlMz3ggo5fzcosZ7zG1b0tHjSWlnGUHD8JEmZXVmmWxZ3rG/5FRiMwi
	Y/T4OObvkYidQEf0v0kgI9EhcGpNnERmreQYSVpJtr7/ZIxQn89R1RejIf4ziKIDDdo6gRe1q1J
	oREkizN7M3pZR2dSZiaMDqiyxw0n1Diyi9IP1v0FjZfAPFLTvbyowEwG/tv1LP9RCL1SdFamYuu
	az2jyTM6H2GL9CdnrDs8i5nKxrHYgEQXYp3m/jNVfTZe0lZoQt4fRLqs3Bu/HT3KVdvKX1bIB+p
	gdvEJAqIQLc4wQss57QJRc4TPhArcCpkeqy+uylFpTT7mYse9RiUHaP2hXK5YgtqezRGegPfakL
	b6zT/jW7Z/rWxK
X-Google-Smtp-Source: AGHT+IEqEHvRs/VjCnXCnB/4HiTEOEJ6JuR1Vxkq60AnYx4HY8O+yJtPgwPPgy7DjUAadWmK6IRbeg==
X-Received: by 2002:a05:7300:f0ce:b0:2b0:4c33:8e41 with SMTP id 5a478bee46e88-2b17d2e398cmr7667639eec.20.1768058654902;
        Sat, 10 Jan 2026 07:24:14 -0800 (PST)
Received: from [127.0.0.1] ([68.220.58.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b13bdsm12300827eec.24.2026.01.10.07.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:24:14 -0800 (PST)
Message-Id: <pull.2138.v21.git.git.1768058653.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v20.git.git.1768051831.gitgitgadget@gmail.com>
References: <pull.2138.v20.git.git.1768051831.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 15:24:11 +0000
Subject: [PATCH v21 0/2] status: show comparison with push remote tracking branch
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

 remote.c                 | 183 ++++++++++++++++++++-------
 t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 403 insertions(+), 42 deletions(-)


base-commit: d529f3a197364881746f558e5652f0236131eb86
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v21
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v21
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v20:

 1:  bb3e00863b ! 1:  ce1f1eebb5 refactor format_branch_comparison in preparation
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      +			 enum ahead_behind_flags abf,
      +			 int show_divergence_advice)
      +{
     -+	int ours, theirs, sti;
     ++	int ours, theirs, cmp_fetch;
      +	const char *full_base;
      +	char *base;
      +	int upstream_is_gone = 0;
      +
     -+	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
     -+	if (sti < 0) {
     ++	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
     ++	if (cmp_fetch < 0) {
      +		if (!full_base)
      +			return 0;
      +		upstream_is_gone = 1;
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      +			strbuf_addstr(sb,
      +				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
      +	} else {
     -+		format_branch_comparison(sb, !sti, ours, theirs, base, abf, show_divergence_advice);
     ++		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
      +	}
      +
       	free(base);
 2:  050197eac3 ! 2:  51d8486fe0 status: show comparison with push remote tracking branch
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       	char *base;
       	int upstream_is_gone = 0;
      +	unsigned base_branch_modes = BRANCH_MODE_PULL | BRANCH_MODE_PUSH;
     -+	int push_ours, push_theirs, push_sti;
     ++	int push_ours, push_theirs, push_cmp_fetch;
      +	char *full_push = NULL;
      +	char *push = NULL;
      +	unsigned push_branch_modes = 0;
       
     - 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
     - 	if (sti < 0) {
     + 	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
     + 	if (cmp_fetch < 0) {
      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
       					    full_base, 0);
       
      +	push = get_remote_push_branch(branch, &full_push);
      +	if (push && strcmp(base, push)) {
     -+		push_sti = stat_branch_pair(branch->refname, full_push,
     ++		push_cmp_fetch = stat_branch_pair(branch->refname, full_push,
      +					   &push_ours, &push_theirs, abf);
     -+		if (push_sti >= 0) {
     ++		if (push_cmp_fetch >= 0) {
      +			base_branch_modes = BRANCH_MODE_PULL;
      +			push_branch_modes = BRANCH_MODE_PUSH;
      +		}
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       			strbuf_addstr(sb,
       				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
       	} else {
     --		format_branch_comparison(sb, !sti, ours, theirs, base, abf, show_divergence_advice);
     -+		format_branch_comparison(sb, !sti, ours, theirs, base, abf,
     +-		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
     ++		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf,
      +					 base_branch_modes, show_divergence_advice);
      +	}
      +
      +	if (push_branch_modes & BRANCH_MODE_PUSH) {
      +		strbuf_addstr(sb, "\n");
     -+		format_branch_comparison(sb, !push_sti, push_ours, push_theirs, push, abf,
     ++		format_branch_comparison(sb, !push_cmp_fetch, push_ours, push_theirs, push, abf,
      +					 push_branch_modes, show_divergence_advice);
       	}
       

-- 
gitgitgadget
