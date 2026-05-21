Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7AD3806C1
	for <git@vger.kernel.org>; Thu, 21 May 2026 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365395; cv=none; b=IcYt9lA/51V3lj3m83HXDkScRp9cTgYWtEMZFTYnHuyWc2ICgei60ARMBI/oXLhNaFRe8tR68I2WCmm8AblBjmpN7MWWpqwXWD+vrwyA2KuJAl3oc0lZlXVSlxNu/0I2rTgnhx5QVAQjj9CtbeEhPTtyzHWdz113wMaID1F/Iy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365395; c=relaxed/simple;
	bh=++4k+GCSOTI94oXcPQ1+CvVjwbgpQeZE2/JmyFY6/qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmLZvZGBXb+/EGHb/i3FEPCymWJffe/zaGa3Pn4sGq6gI56Dgdz6ECrudNcTVH24tja+qnlI7ZBqLJO7bhJ5JJQc2pqm9nG28RF6fSYU33Pj1au4Fnkre/+cyC+i88LgEQcSyYm6ZfpJdZNlpdln5Bnp62c9bHxmr5sSLnig+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XdRhZFUj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T/tB92cv; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XdRhZFUj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T/tB92cv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4AFB21D00114;
	Thu, 21 May 2026 08:09:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 08:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779365392; x=1779451792; bh=lge2aOXG5a
	jNU/Ffd5xJfEtM2c450sB+E9Xo9KIbjh0=; b=XdRhZFUjg6ByBmJ2Yyl1y2c5XV
	RMLEMUWZg+1v7yvdlDYQstwhBwZ+f4C7/luFUzaNtONZaASY0xQMMNE+nPvkPLQw
	GjBG2rWzFZsvdYtBs8bOVDAdgkD9aQt2IOxYznOygBKN2GDMZiRato1loWSk7j16
	pu7H+ZOup/97dOEHXcY5u+NJWSAKNSLKKLP8rHvXPuJQkdegJfgQsCaP0XIfMXVJ
	W+28HNVMSpbCdNvgJAV9N7ctpNjoTV9OF5nxkUsy3uHmHElAW1Ml+/Ry9/fMTpDv
	LrUkrIsQruXfeSDl1/r/pY5FtaCD8JpmPvY3Dx3p6RGBR1ixaQLKzhfXyPzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779365392; x=1779451792; bh=lge2aOXG5ajNU/Ffd5xJfEtM2c450sB+E9X
	o9KIbjh0=; b=T/tB92cvwtWiBe7eFpsa4t0gnCkE/8UgnYi80WISP14KEQUF+tE
	NR7v63vjT0iVieOCkzxo3sYh0cxPC47c8LXV8eeWrLhIKRswDzPgLZZnO/mQuXuM
	+E+yFw9Lo8PyMg4HmrHASOlXJ04eSwbA+Tb+Obt2n8+jCzW6p3ChGb6NkOuS7Qhj
	XI+xxZ1Re/w25j273Xlsi4ZRMhRlfTRdq2Qej3xrkEqRNpjCEWMABwK37ChAOu0F
	XvYJPpKNtbo6HLjOM0MtAWj63lRv2CHCuHMaMH+EWhmIvSRzgwOXT0ewTcmXPSHM
	30ObRLeeOBIUUJo1U366eemhQvGLmgvvLbQ==
X-ME-Sender: <xms:EPYOamD7xokj89B7i1Nu7VA3xokUYR2OZvnUzsAdPouvGAz39hA-Pg>
    <xme:EPYOaiBysvEp67_vbHffJ07bOzdEVTsHrYOuEAeYESnSI4CFOwgdNv3qZRmxzjSLp
    VFJNe8KXizW9BfLtAc5UnHxwhGhak7ToVXIhLnVweFMxUWIhLwjFA>
X-ME-Received: <xmr:EPYOapoUGWbFgBD5-PuZ17RP9iNdj7fdVGVmS8URhzJytg8smKU7kcIX_29pMTf09dgmuI_0GPNd7q8JOlJk3kWKGAfC76hTjBFo8NGpI1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvges
    sghlrggtkhdquggvshhkrdgtnhdprhgtphhtthhopehphhhilhhlihhprdifohhougesug
    hunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:EPYOakl7JI85xfgv6H3-dZdA4uttOeWgPkcICUWimUdBsAnq2P-Qgg>
    <xmx:EPYOahxc0QRK8sDY4isN6QHix7LFTUU0jVPpLJn8eeXgLWzGPVaFcg>
    <xmx:EPYOak-hJk_KmayJXzU_xd4-EgqYfQVs6YtkC_Zi-uW-EMv45BSf2A>
    <xmx:EPYOalID9-f-wcgZkwyWJQBzE-qn0cSAwn6prdVf0F9RfGq6VM5DJQ>
    <xmx:EPYOahkYX04KQ-eMUgD8HfW9TnQIds7qW8TPGWRJa3DFAqK01wvof-sR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 08:09:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 55924b38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 May 2026 12:09:49 +0000 (UTC)
Date: Thu, 21 May 2026 14:09:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: me@black-desk.cn
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 2/2] config: add "worktree" and "worktree/i" includeIf
 conditions
Message-ID: <ag72CqZP7iFR8wWj@pks.im>
References: <20260513-includeif-worktree-v4-0-f8e6212d1fba@black-desk.cn>
 <20260513-includeif-worktree-v4-2-f8e6212d1fba@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-includeif-worktree-v4-2-f8e6212d1fba@black-desk.cn>

On Wed, May 13, 2026 at 04:08:18PM +0800, Chen Linxuan via B4 Relay wrote:
> diff --git a/Documentation/config.adoc b/Documentation/config.adoc
> index 62eebe7c5450..6299b1e3a019 100644
> --- a/Documentation/config.adoc
> +++ b/Documentation/config.adoc
> @@ -146,6 +146,46 @@ refer to linkgit:gitignore[5] for details. For convenience:
>  	This is the same as `gitdir` except that matching is done
>  	case-insensitively (e.g. on case-insensitive file systems)
>  
> +`worktree`::
> +	The data that follows the keyword `worktree` and a colon is used as a
> +	glob pattern. If the working directory of the current worktree matches
> +	the pattern, the include condition is met.
> ++
> +The worktree location is the path where files are checked out (as returned
> +by `git rev-parse --show-toplevel`). This is different from `gitdir`, which
> +matches the `.git` directory path. In a linked worktree, the worktree path
> +is the directory where that worktree's files are located, not the main
> +repository's `.git` directory.

Nit: I feel like the first sentence already says it all, and the
remainder is not adding much value. But I'm probably also quite biased
given that I'm familiar with interals, so I don't insist on any change
here.

[snip]
> +While `extensions.worktreeConfig` (see linkgit:git-worktree[1]) also supports
> +per-worktree configuration, it stores the config inside each repository's
> +`.git/config.worktree` file and requires running `git config --worktree`
> +inside each worktree individually. In contrast, `includeIf "worktree:..."`
> +can be set once in a global or system-level configuration file (e.g.
> +`~/.config/git/config`) and applies to all repositories at once based on
> +their worktree location.

Nit: I tihnk saying "global or system-level" is totally sufficient,
there really is no need to explain where those files live.

But again, I'm not sure whether we need a new version for this change.

> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index 6e51f892f320..07b6fb649cd2 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -396,4 +396,117 @@ test_expect_success 'onbranch without repository but explicit nonexistent Git di
[snip]
> +test_expect_success 'conditional include, worktree, icase' '
> +	git init wt-icase &&
> +	(
> +		cd wt-icase &&
> +		test_commit initial &&
> +		wt_path="$(pwd)" &&
> +		wt_upper=$(echo "$wt_path" | tr a-z A-Z) &&
> +		echo "[includeIf \"worktree/i:$wt_upper\"]path=icase-inc" >>.git/config &&
> +		echo "[test]wticase=1" >.git/icase-inc &&
> +		echo 1 >expect &&
> +		git config test.wticase >actual &&
> +		test_cmp expect actual
> +	)
> +'

Ah, one more thing I didn't notice for the last version: it's good that
we have a check for the case-insensitive behaviour, but we're missing a
test that verifies that we're in fact case-sensitive by default. That
test would of course not work with a case-insensitive filesystem, but we
can depend on the `!CASE_INSENSITIVE_FS` prerequisite for that.

Other than that this series looks good to me, thanks!

Patrick
