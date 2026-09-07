Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3A38DC52
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 06:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761020; cv=none; b=uca5mEhQHSQF7LPckt4jHF4d9rllswpJAbzw2MFbyRA7ngHy1/GKIpRV387lnv0kNf/FzJDAZDpXYixF0AbIJ0KA7xXXZ0SvpGrNoqhNFyT394v/rveFTXEmO6blm5yeIO8+JIsEQCp4K19A7aFdTSv5B0brwxi74Yu8b2SPTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761020; c=relaxed/simple;
	bh=d8XGHZC4S2sw6XnK6JPR/laTkHXf1lWjZjn1IqG9LR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8+/7I7b7FTJHHOsep+KFTeWW4w5GrUAZ6jGNgTw3dq5Bb2uNIvQCSId/IL3OIf0XTTs0BApKkxEOXdnrZIeSW7iWVu9ps9NqXPxpLKjadpG80rE+HmaApyWRti1xl6eonSpa8WcMpTnoU9oNiYbeVvhfXazMo+JtmTkwHgSRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ui37R9SW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jbXog/v6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ui37R9SW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jbXog/v6"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id A4720EC024F;
	Mon,  7 Sep 2026 02:03:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 07 Sep 2026 02:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788761017; x=1788847417; bh=cktD/l0tmg
	7syOyPdh6Nkyz0NWreMX4gzzBdGK5h3tY=; b=ui37R9SW6rhJZMpe+RmjRbIPqU
	gnsua/2qhwrb8MaCUI9Nor8rAfXKHN3tMWL+osKn+kY0aqgKQPk3t3DSbHYrS/YO
	3GlE/UjmWniekB7ypW4ebWX/Qd7aY4s2gFA9nd8Ey07XXLQK/XO5TvXCrqH/iciJ
	UEMrtGqH6u2Xj7fzUTNRRZBxCBzPjtu/fp96UuzaSzWgKJfRs+nT8nKgNKFWaN2+
	Au9BGrWKEw6Ag2cZlcxb2IVH6p3MiQ7ZqLQcualleLuzGCzfCWtMLmuQPlJ54V8+
	Pi3gHsuV9/OdtjIlY/NTH86bAMUoTcoKe+POFlh3AhtAU9xslrKLXh+ZEbCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788761017; x=1788847417; bh=cktD/l0tmg7syOyPdh6Nkyz0NWreMX4gzzB
	dGK5h3tY=; b=jbXog/v6G69U/acHzWGuz4uOG04JOi7k/bHlfG4NnJCn+7+cGc7
	O6XZ6QRAuGP62H0F4/9QUWIaPrqe/YUYyAxRXJeUOEJdMi+H1cj+l4XHHjDZIOW5
	JRGZEdf+waGFLSdBo6UPniUQMAkfNpQDuJMWuhZZfIJdoYCZrAMgM5DYa3vh8sxQ
	ZNEI1RU5E2nSoYcdBFP9VGmxOkpYE2kn2XwMAVV6ju9BWvB1ztZEI7H1LWyW2PAc
	kiA9wbnFR5AeyeTGua6s/ysuqNUcsj25JkQBbW2FWgj+V7W0PxnyxSQdlRqMAptZ
	wVe4j27xUVWfwAwYmX+a8mZP6w9YzfC5xRw==
X-ME-Sender: <xms:uVOeao6tQ9VFdDopPRSdNEJDrxm0Vnlmk17oADCnQ-Nd1kQ03hMjtA>
    <xme:uVOeahVxeHDazQOMaYJFlrVpkRWDEQ8qlY6sJ7VzIGdqwjCWm2poqlNziLpwGLmPC
    4NlDM6zyQVRFNiArJRllsCceTp_L9g37T8hFGOAq1tCxS7doFzAwQ>
X-ME-Received: <xmr:uVOeak0Mu8IetH1N17rv7RPgEnrMgy_V8fRKF0tPFnaHau8TXsiNEA>
X-ME-Proxy-Cause: dmFkZTEYWsycDLGtjdBzz7fze4UUowfVSm6JMIMjQEmhsw5NNy7h1VRq8nTC8xiJcNbaFL
    1wQC8hUc9yai6tvQa3H22K0DwZVH+NNw53M3rSwRM2F4DT3rbP2RyIRQXinI0C30EjdWSo
    aseg/cQPIOuznaGmdZabBxgHzip9Ps9SWF52GCmQ6BKazdG6GJ+mKIhDulWDQmYafH5/79
    TkzLrDOfdA7HG5GEjJQ9Ifb0R9elEHEM+p9QKrS9XpJxHoj6e+09kr3m0mKHFiBW0LnHj7
    zqDdNNnd0B+7M815gMGjYRdJLEda6Tf0x7H23urGD0FtM54N93vw/KP/viagXSblboa1Ss
    vtIkEZmkVJcjYVyLJuXyUfRcurLloKSnCRCpqmdIaTu2W5ufIM39wlJ9Ir0kn6rj4bsZw+
    lNH+rl8z/7ESRBPoyNGmiizAXZyGFf2hyv0yFqaQsEAWgR/Npogd8wbxq4Tk1THQxcs1YE
    N335tBcYbJUZcPEqo50acNsBwpH78FRTn2FeK+SF08fYEdi+h5snCwwanQjYN+qC2sKspF
    BZoDyhFMH7x5ERmsA6Xzs6OnwpISOZArPS4wt/I67sBmnA9vpTB/9cPfh/ZVXkBx51EgF3
    ABQursxITb3zZumZzoLRn6Lhrjd+tCjsxAV8260zbUwxCM1k4bdGhYBURjuw
X-ME-Proxy: <xmx:uVOeam3ud_wbjctW5i5NEzERrvwxIrl6WUukGtgnTdKvm1r1l6PavQ>
    <xmx:uVOeav_tI_zugjlWs6HN_yGYx6u9fi_AYe8Uv7iXLy9lNprVquo1Tg>
    <xmx:uVOear3wxDa1IE3RtvrlzKqzkeJkgcd7ov1j6FXlmqAlcGRIlJU7dg>
    <xmx:uVOeak9YM4Qe1VbUjhAEg0SuWnABfqalzu1ca5FbRl7veh22PeuYjw>
    <xmx:uVOeajaj2e5s9NSpDGFLpUyeVb1ISy0O3_nZ7dZCpeIoUwLNc-4_0cr4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 02:03:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b7cf65d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 06:03:36 +0000 (UTC)
Date: Mon, 7 Sep 2026 08:03:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] ci: bump debian-11 job to debian-12
Message-ID: <ap5Ttt-2NmM5dRZl@pks.im>
References: <20260905135822.GA3914811@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905135822.GA3914811@coredump.intra.peff.net>

On Sat, Sep 05, 2026 at 09:58:22AM -0400, Jeff King wrote:
> Debian 11 just recently went out of its LTS period, and is unmaintained
> by the project (there is "Extended LTS", but it is a paid service
> provided by a third party).
> 
> The point of the debian-11 job was to cover older releases in the LTS
> state, per ac112fd4f0 (Add additional CI jobs to avoid accidental
> breakage, 2024-10-31). Bumping to debian-12 will cover us there for the
> next 2 years.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I started looking at this because I got an apt failure on a debian-11
> job today. It might have just been a transient mirror failure (although
> it reproduced for several minutes afterwards). But this seems like the
> right step forward anyway.

I noticed that the Debian jobs became flaky lately, too.

> I tested the GitHub job, but not the GitLab one. They should be pulling
> the same docker images, though, so I would expect it to Just Work.

Yeah, same.

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 205325eb33..a0c3f53c6d 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -411,9 +411,9 @@ jobs:
>          # A RHEL 8 compatible distro.  Supported until 2029-05-31.
>          - jobname: almalinux-8
>            image: almalinux:8
> -        # Supported until 2026-08-31.
> -        - jobname: debian-11
> -          image: debian:11
> +        # Supported until 2028-06-30.
> +        - jobname: debian-12
> +          image: debian:12
>      env:
>        jobname: ${{matrix.vector.jobname}}
>        CC: ${{matrix.vector.cc}}
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 0242283c3c..cd6fd4a504 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -71,9 +71,9 @@ test:linux:
>        # A RHEL 8 compatible distro.  Supported until 2029-05-31.
>        - jobname: almalinux-8
>          image: almalinux:8
> -      # Supported until 2026-08-31.
> -      - jobname: debian-11
> -        image: debian:11
> +      # Supported until 2028-06-30.
> +      - jobname: debian-12
> +        image: debian:12
>    artifacts:
>      paths:
>        - t/failed-test-artifacts

The changes look good, but I wonder whether we want to swap to the
"oldstable" tag instead. That points to debian-12, too, and might result
in less churn going forward.

Patrick
