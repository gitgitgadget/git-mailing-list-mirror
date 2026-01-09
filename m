Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE2286D4E
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984041; cv=none; b=qj/dGu2k2a9A6WoyCHEilSdhRAs9ks+f+ppUt+sKKAP50MOgmkVHd/32mSotkfSmQah9gp5woPJaFDAs3+IenJ6mrehSzYyGlTR5qb15i/7Vw5tuGV+A2+ukbWpGZMl3Xf58rqDcYBay861VAW+K7fXSLZa6FdR2a2SlzXcxheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984041; c=relaxed/simple;
	bh=W6uekhFWw+hYcp4pDrtdm7XCdYhRaAQvHKfD9mSiMJQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GZLcEn6pNGvjNy30ir8iwnU/1N9LNO9+yJH8++CZaV///y4rc6feQVv2rN3wJH8nSok+TSXCJH7ShG29nF58diCndwRipyHRkEHIn4cClVbKGlWnq6e1XHrxUm0skLRhHiOpEQlE9sN7uI+dgvSPgjIdj1ZUX8jP8/O2bCKUKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Trd6TdjQ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Trd6TdjQ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8907f0b447aso46561226d6.0
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 10:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767984038; x=1768588838; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g54YHmzhewBo+WO2NCJc5TeTYntgpPz2aobqwWqBG1g=;
        b=Trd6TdjQrfs6kxqP0E73Gfux1yHu1/VBZdfg7CPkhWlf9U2d0Bay5mnI2BwET0cRAw
         snxsugBa0eGqVv3jvfd5xaGxh2RSY68NPmHS14QLJV5yI7crbBjRFAfiJ5+vfV6yrh9r
         aFM1t/JScwTHzl+oyMuHB8Jz3l4+i+Xxl6OxkmSIb71L4jIiBe9dtDVlUchzfMf3C/A8
         O+G44COl7sGBjs2xGgg37iHyUU2buN/e4Y0ld6u+d9R3wVx0gPBec0EeiJwraLjfAyd2
         h4TKX1FxmXLDlS6crY6cqxKWRQfShQZv8FaIwOCUDXCFqIQgV6JJmkWs9be5Bjr00evq
         2nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767984038; x=1768588838;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g54YHmzhewBo+WO2NCJc5TeTYntgpPz2aobqwWqBG1g=;
        b=MgV87LxT8I/ZB0sq7YNk0Onjv3LqpBmMkzX3zh9l6MkRWSCFCCSfHiipJl8aLEVl6o
         30CW5PX1nMU/FMFmxnwmM/G8eUl6X7EaoMuAn7XfSRP4Ot9w2lqzN7GRNdj6NhCiP/J4
         Mp9DO6xlcVHFG1j/IpOMIwxr/ZOO1kUFRWgXh88Dyl53xCLr8wl8HruwuJOoZ2Y+HI1z
         zHJ1cvhVsWlNVGFRilIcTjh7rPdyhd8F/uqccXnEGNWvh5mlH9Qxz9dsPmzCv+1uaxnc
         dsg4FBSifmE6vdBrh8RU+jB6fEQuZt1fKQCHTq02jzTGmO0yxWc+1+oHdXx1vBoSKN6e
         1UhA==
X-Gm-Message-State: AOJu0YxmYFNLZ/LEnkEon5iDpqRefCVmOBSp8c9ypxY3yq1Lv/dntkOA
	3Irg8uO2Kq+N6BAAHv+6MCuYOmezkI9BnzlDMN8aQg20P132oBioNVHY5yfvQg==
X-Gm-Gg: AY/fxX58E2kX0GcwkU5g2Nl6mq4iOiM8trdgNTlZDlBrAxxFa1HbvqHt4QnQn8p+htN
	C5n3exU9Z3owlYv5jFOZJBgD9kyEvSW2DgJT8exHGqxYHwE2I76G/rMI1KzP+PTbwdVUZ/dyHvs
	5tva8Gi5sZwv3NKDbuFABAIf6/v39yn0r+QXBRTNABaLgk9GQtNqMQG+jvRAfU0Guy2zsZjCMb7
	6yIdellEggSsTvRzp7todZGDnenHRpbY5vNN1OvpyneK5TJJbHj4H89JIKX6Yxi+cxDR1LrWuf8
	m6fOrRia5P9a3T5J1vCCeF1MNkCUXRMawhJ7Yk28oP0QbBqNq6LUdbIzTq43jeT5VL4/jC5ZJ32
	WOQgrqk7jVhIaYtR0yx1pyy98sC/gA7fcDimFnPo2y1/DH6kcDIuFXyBBWF9OiA+SBPlnsm7i2D
	dy2YIGNE6Y0qDEQCcrohLI/sIR
X-Google-Smtp-Source: AGHT+IFIfhnhakOcIf68cCUBTBXvUaACjuNpbBIAaNEOysLKK3EckEyDCCx2YfVPjlj2LHaJ38E85A==
X-Received: by 2002:a05:6214:2f11:b0:880:52b8:2fa4 with SMTP id 6a1803df08f44-8908417a833mr142652626d6.9.1767984038210;
        Fri, 09 Jan 2026 10:40:38 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2aa5sm81502306d6.19.2026.01.09.10.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 10:40:37 -0800 (PST)
Message-Id: <pull.2138.v19.git.git.1767984037.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v18.git.git.1767976906.gitgitgadget@gmail.com>
References: <pull.2138.v18.git.git.1767976906.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 18:40:35 +0000
Subject: [PATCH v19 0/2] status: show comparison with push remote tracking branch
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

 remote.c                 | 174 ++++++++++++++++++++------
 t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 401 insertions(+), 35 deletions(-)


base-commit: d529f3a197364881746f558e5652f0236131eb86
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v19
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v19
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v18:

 1:  451d7a4986 = 1:  451d7a4986 refactor format_branch_comparison in preparation
 2:  02476eb8e6 ! 2:  dc8ab23158 status: show comparison with push remote tracking branch
     @@ remote.c
       
       enum map_direction { FROM_SRC, FROM_DST };
       
     -+enum branch_mode_flags {
     ++enum {
      +	BRANCH_MODE_PULL = (1 << 0),
      +	BRANCH_MODE_PUSH = (1 << 1),
      +};
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
       				     int ours, int theirs,
       				     const char *branch_name,
       				     enum ahead_behind_flags abf,
     -+				     enum branch_mode_flags advice_flags,
     ++				     unsigned flags,
       				     bool show_divergence_advice)
       {
     -+	bool want_push_advice = (advice_flags & BRANCH_MODE_PUSH) &&
     ++	bool want_push_advice = (flags & BRANCH_MODE_PUSH) &&
      +		advice_enabled(ADVICE_STATUS_HINTS);
     -+	bool want_pull_advice = (advice_flags & BRANCH_MODE_PULL) &&
     ++	bool want_pull_advice = (flags & BRANCH_MODE_PULL) &&
      +		advice_enabled(ADVICE_STATUS_HINTS);
     -+	bool want_divergence_advice = (advice_flags & BRANCH_MODE_PULL) &&
     ++	bool want_divergence_advice = (flags & BRANCH_MODE_PULL) &&
      +		show_divergence_advice &&
      +		advice_enabled(ADVICE_STATUS_HINTS);
      +
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       	const char *full_base;
       	char *base;
       	int upstream_is_gone = 0;
     -+	enum branch_mode_flags base_branch_modes = BRANCH_MODE_PULL | BRANCH_MODE_PUSH;
     ++	unsigned base_branch_modes = BRANCH_MODE_PULL | BRANCH_MODE_PUSH;
      +	int push_ours, push_theirs, push_sti;
      +	char *full_push = NULL;
      +	char *push = NULL;
     -+	enum branch_mode_flags push_branch_modes = 0;
     ++	unsigned push_branch_modes = 0;
       
       	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
       	if (sti < 0) {

-- 
gitgitgadget
