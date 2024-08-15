Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7B7DA8D
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720925; cv=none; b=iXnRxvyjBSzhCiR2ts+OP4z9oUyqDxwEKgIJlLcZwiziR9EZBM1gLkYz16+dCiVNZCjHL0z1PV2fKhu895hLl9K7sE5k1vk8FRo2EgsoMsvrH/vRILE7jfhm42kvbGgvItORvBV1NFaQaeiuv9mVXpi5nTvDCpbUYdMvOSu50ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720925; c=relaxed/simple;
	bh=mHjNYG1WDkb9Q0g+m3z+/l6dIhlHLuOvVJRScyjLsN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3YIE4k+7Vk8QeWrHkqulhLE4GOy3cm6719XymuIFv+R74jODO/KuiNxnoAH2V7lpm41OZfI44UWPL78vOWI9DL7cKbtSeIoYtnGv6g2SNglCZjjOIvuMVbEKzGxNdo5xeLcy26VPpeuny99iNr/8xrN38xIcxTwx9Ih5q9C51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YGuzyiBJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KRmYLzpL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YGuzyiBJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRmYLzpL"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4021C114C791;
	Thu, 15 Aug 2024 05:12:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 15 Aug 2024 05:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723713151; x=1723799551; bh=z58f7QW4tB
	A8XTO8mw8XJZ2bImhnctMbyJRlm5H3Km0=; b=YGuzyiBJeLG7rp2jKgE0NzOB2K
	DOriv3q+9zAuWPSRvJhK616kB0FYO3bOEN0lJWrrPNtxKS8YkKeMvUbNuKg7ycyU
	Lv9RYJaWfAaSTecDF+KzD0yBZBK6dl3bdFXVUWFfeypR1tRMrFvY3246gD8tQA1E
	kUhQpE+eGEJafUWuO+MekTadrfur54aq9q9vZW5qdL2CQ5s40FLOOxSIHQy/xScC
	LVT1FXR7LMUIVWsN4Ip47hSmEqp3mbmAYKwcCkR2szkkdyWFT/bjcxYPET67XN0P
	oeaSkWzQP9qGaVsGtTXtVqJdRp6P4UmMPtHnmJI2xI/vkfMbT/XVQrSXUDOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723713151; x=1723799551; bh=z58f7QW4tBA8XTO8mw8XJZ2bImhn
	ctMbyJRlm5H3Km0=; b=KRmYLzpLHKDz4bgOSDNBuiM54rsfiSUwIXqS845Zcx+e
	tVmTvVdRyfYk7am4b4KMUXGii2gWmkf1A7tebJEBVLOniIpGbSp+Ghrm1yQBzRuw
	5rHsglvOrci65fmS2yVglfJQqol8NXsIg6IQjhODoCA+Tbjqz3y3zf1Sh9yEqq6p
	6SR2OJBDM14RtU+ZR/U6dhRS+xPvSl4Ey9hruuyMW4hvsl5OivzA/xdU89tvaMgs
	8Cxk6/k/m33MS6z3zQWtWwrqImE1Mzlg4fN+Sh3DUjBU7Y9EB5spHHPS99rnzAtX
	PCYDMxb6pwF1U9lRfaIn5p957IYtIF2py6QEoYK2AA==
X-ME-Sender: <xms:fsa9ZmYwWHybFHwCwdk3pAJE1Jx90HUhvFvrFgQhLbCQi6ApepGlJA>
    <xme:fsa9ZpZbBofGGH44-kX_20ckKF8Av9V4hpu7WqyIZU68HVGrtjZePI2K4q3ChiiZj
    C9bY7oUW4JJv903VQ>
X-ME-Received: <xmr:fsa9Zg8bpq3bYktPBq7PQv9S8E4F-EDGPJIAxpy_OHfOEUs6T4W7-TguFeFf87pE42g7LeOpCd_jgZ2k5FujdL2qwxW5wklD8MlgyVfFAaCYWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:fsa9ZoprwGTY0haCS271aQyW36CQ6aDLMEt9zK5ut2G-E89sMiwa_w>
    <xmx:fsa9ZhqKB9IWkP1D8grNExuyUJYhhq1sshX6K6DUYxRwFSo71uLp9w>
    <xmx:fsa9ZmTFJ5DVnzVhjM9dR-cT4ATS2qVmFqhB1Xo3SivylfzkpcJ3bQ>
    <xmx:fsa9Zhp1FD-OCCxhmHSyJ3LxshuevNe-xKJiYQ_aV32B3sEf3oYkgQ>
    <xmx:f8a9ZinNET7FtQI8DHcoty8DcwWBLBMObtTMF7bN5-oqmBakV5OpvufF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:12:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e56cb945 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:12:06 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:12:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>
Subject: [PATCH v2 0/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
Message-ID: <cover.1723712608.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723533091.git.ps@pks.im>

Hi,

this is the second version of my patch series that fixes how
git-maintenance(1) detaches: instead of letting its child process
git-gc(1) detach, we now optionally ask git-maintenance(1) itself to
detach when running via our auto maintenance mechanism. This fixes
behaviour of git-maintenance(1) when configured to run non-standard
tasks like the "incremental" task.

There is only a single change compared to v1, namely a rewording of the
final commit message. It now clarifies that we really only fix the auto
maintenance behaviour, and the default behaviour of git-maintenance(1)
remains the same when ran by the user.

Patrick Steinhardt (7):
  config: fix constness of out parameter for `git_config_get_expiry()`
  builtin/gc: refactor to read config into structure
  builtin/gc: fix leaking config values
  builtin/gc: stop processing log file on signal
  builtin/gc: add a `--detach` flag
  builtin/maintenance: add a `--detach` flag
  run-command: fix detaching when running auto maintenance

 Documentation/git-gc.txt |   5 +-
 builtin/gc.c             | 384 ++++++++++++++++++++++++---------------
 config.c                 |   4 +-
 config.h                 |   2 +-
 read-cache.c             |  12 +-
 run-command.c            |  12 +-
 t/t5304-prune.sh         |   1 +
 t/t5616-partial-clone.sh |   6 +-
 t/t6500-gc.sh            |  39 ++++
 t/t7900-maintenance.sh   |  82 ++++++++-
 10 files changed, 381 insertions(+), 166 deletions(-)

Range-diff against v1:
1:  040453f27f = 1:  040453f27f config: fix constness of out parameter for `git_config_get_expiry()`
2:  ff6aa9d7ba = 2:  ff6aa9d7ba builtin/gc: refactor to read config into structure
3:  310e361371 = 3:  310e361371 builtin/gc: fix leaking config values
4:  812c61c9b6 = 4:  812c61c9b6 builtin/gc: stop processing log file on signal
5:  ca78d3dc7c = 5:  ca78d3dc7c builtin/gc: add a `--detach` flag
6:  06dbb73425 = 6:  06dbb73425 builtin/maintenance: add a `--detach` flag
7:  8d6cbae951 ! 7:  6bc170ff05 builtin/maintenance: fix auto-detach with non-standard tasks
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    builtin/maintenance: fix auto-detach with non-standard tasks
    +    run-command: fix detaching when running auto maintenance
     
         In the past, we used to execute `git gc --auto` as part of our automatic
         housekeeping routines. As git-gc(1) may require quite some time to
    @@ Commit message
         housekeeping tasks, stomping on each others feet.
     
         Fix this bug by asking git-gc(1) to not detach when it is being invoked
    -    via git-maintenance(1). Instead, the latter command now respects a new
    +    via git-maintenance(1). Instead, git-maintenance(1) now respects a new
         config "maintenance.autoDetach", the equivalent of "gc.autoDetach", and
    -    detaches itself into the background if not told otherwise. This should
    -    continue to behave the same for all users which use the git-gc(1) task,
    -    only. For others though, it means that we now properly perform all tasks
    -    in the background.
    +    detaches itself into the background when running as part of our auto
    +    maintenance. This should continue to behave the same for all users which
    +    use the git-gc(1) task, only. For others though, it means that we now
    +    properly perform all tasks in the background. The default behaviour of
    +    git-maintenance(1) when executed by the user does not change, it will
    +    remain in the foreground unless they pass the `--detach` option.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
-- 
2.46.0.46.g406f326d27.dirty

