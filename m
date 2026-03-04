Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A553309DB5
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610183; cv=none; b=UTXKcZzTO9aIHHayVPma+LkNlVMDYJvAunLWJPN68dB/Bxf6Q/B1aj2OMDili2yyPspcF3YpvmegZY/yRkbcVFW40uxTEFjS4pKvHrGQMmrnf7rUim4H9NMSurfda1MzZHme+I6zTHhx5tqd8xtjeRck9dOBVWiWu+IFnLmd+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610183; c=relaxed/simple;
	bh=EGvvYIVxFiAByy/zxivrkXYB3jCToY4gymISKzU1EcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKp2a+g3+ycETYH7B0I2bSnuqzfVeHTK7Fyahh2mcHBlN61hqZfUaTRg1WZcLHM0X1daL66RsprxYpWos+Z6KyJlhkekCxwspjY5HAg9H+3LHfnw9Gm+KwV8GyiU02pFoUKKFFdVd8Xq/Yp1f8GgPdh6ZE0R4Si2MYiobse4p7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e7XG7voB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ahKQCwt2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e7XG7voB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ahKQCwt2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CEE601400191;
	Wed,  4 Mar 2026 02:43:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Mar 2026 02:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772610181; x=1772696581; bh=fHfMS+H37Q
	JGGsCaMCNMHob5/9J043l49mHevagNJCc=; b=e7XG7voB2a+SDiEAl6NeKDXLHd
	sZo4KjZ1loSEMgCq1n5y0jzSfnw8ppgxWPYK+oFw3r1Zb4Vqyc8z5SSVwYKkviI3
	XInYoIU3n2T9vgrfBr/T7W7KhgLuazpOcLhd+xj+TIkVY+ZxP4NoBYMA6UQRrG5Z
	ujYg7YQUyQXpVMkR8RXGafvngT+pkFkQpI2j6fef5B2quPSjBhNZnRPzVOp+LRsM
	MSDx7kdBKk12pXFpfxHHsUIIoHSI417d1bU0HhaIQEjbcems380h7FVoOGwxTdp+
	xALYunN0G/FFbJWOGDtKWUVoI8tprV8iEQtEvnWgrLtRwubU42lwHl2Fe9Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772610181; x=1772696581; bh=fHfMS+H37QJGGsCaMCNMHob5/9J043l49mH
	evagNJCc=; b=ahKQCwt2ry24o4+RIQJ7XnSvSnvfxHQNPm+Ihf09dgzjV2dvARt
	6CVtmYPHTSzaC/uMnnqAs67pn+kKIprHIJ/6hdN28s3WwAhdgtJHXS2c6jnuvYGB
	mjkH1tzYAPhWn3FHUWEG4ugtxDHY/kkHB+KwB9qPihHapfyZtQqy7XhCqUdtwxP8
	qFn/gMzkrouJfXK8RHONBzCO/Pep6oYDp5i2Y8sNe8lHo0Dkck6dxopthnCaBvTT
	dXnVlFx9qIaHPm16fPjgII9hb4NvqvcqgFCBO0zMkRhN62cRI4qPlxalxfnW/+sE
	2IXoc5VGLulMvR3RKmIbUPdYByWHDAi2KWA==
X-ME-Sender: <xms:heKnafYcf_Wf7bfL7HCU3H_zHynMkHMZ2NkkrvtIZsitLT4k5kMaNQ>
    <xme:heKnaV1QvnPYHYqItLND3sBZIaXVpjN8e8qYOzEmcxXZsC5aIkhP37XpbxE3Bzvvt
    IP8HGMux2DIbXfm6ke5a-7rylTO5oakpJ45zvVQngrfkXXpzV-fmg>
X-ME-Received: <xmr:heKnafXNdTSsoFK8b-ut_iiSnrD8TQ2QjuZUunsoQdL4IXxsoff6LazOSL0I0ofe5eqOMvt3yZj-2FP0_sWIQCL4xvz_Xqpoe0I_GX7ufP_8sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhthhhusgesphgruhhl
    ihhsrghgvggvkhdrtghomh
X-ME-Proxy: <xmx:heKnafVS2WnEwX1xF_tF6qiddA_T-fYVkknxSy4Zf3CQjDEUBZv2kQ>
    <xmx:heKnaefrTawH-qUHGj0dnyTNaeCxmC4caJa_WfUIrY-eRTySAAAz9w>
    <xmx:heKnaYV8pDTPHrRo-Sz3Zgt56XC8OjrB3HBsKdBi9bLrmsZA2yGucg>
    <xmx:heKnaXeMV8ADE_ety61ourFL60dk8jVYHMQvfp-FywYL3pdOsdfyJQ>
    <xmx:heKnaWSewsqE8vhGCP_GSJpeesfSvXL9dkxhAWuD9GfeBFbBRAfQDtID>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 02:43:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2dea1b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 07:43:00 +0000 (UTC)
Date: Wed, 4 Mar 2026 08:42:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v7 05/10] fsmonitor: deduplicate IPC path logic for Unix
 platforms
Message-ID: <aafigc1QiysIByhM@pks.im>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
 <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
 <037ae2a03f8576a73feb889cd61220ba69d97fea.1772065643.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037ae2a03f8576a73feb889cd61220ba69d97fea.1772065643.git.gitgitgadget@gmail.com>

On Thu, Feb 26, 2026 at 12:27:18AM +0000, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>

Nit: we're not exactly deduplicating just yet, but are rather preparing
for that as there is no second implementation using this yet.

> diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-unix.c
> similarity index 96%
> rename from compat/fsmonitor/fsm-ipc-darwin.c
> rename to compat/fsmonitor/fsm-ipc-unix.c
> index fe149a1b37..d34a6419bc 100644
> --- a/compat/fsmonitor/fsm-ipc-darwin.c
> +++ b/compat/fsmonitor/fsm-ipc-unix.c
> @@ -27,13 +27,15 @@ const char *fsmonitor_ipc__get_path(struct repository *r)
>  	if (ipc_path)
>  		return ipc_path;
>  
> -
>  	/* By default the socket file is created in the .git directory */
>  	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
>  		ipc_path = fsmonitor_ipc__get_default_path();
>  		return ipc_path;
>  	}
>  
> +	if (!r->worktree)
> +		BUG("repository has no worktree");
> +
>  	git_SHA1_Init(&sha1ctx);
>  	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
>  	git_SHA1_Final(hash, &sha1ctx);

I think these while-at-it changes should be removed from this commit.

Patrick
