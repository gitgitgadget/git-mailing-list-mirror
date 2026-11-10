Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348348;
	b=PyF8q/3XXQTylfcEsSl/Ql0Skt6YbiqzMfXWNfbKkWQPFE+vbCM9Z9WJt+bY1VnQW2B0
	 wxh3lIJLKW7RSiDy/1KUpXjQwXJWpmeOhT2xaZ8K+h8Lu4DUFvANxp/NPefdr90OAavw8
	 nA5rM4SCqHSjgnoDoOoKCDB4dofYC9giIFvvcox1buLXlm8V9YVAnYjFvsxsez9hxHx/z
	 O8QU5CH5zVw9DiH3qznyGlQYnrhADDI7vs8DA/odAvtTA+fbqxY61t2m89XLZC++8/1+r
	 nkCgWOGIspZrdjRazGgsAMlxs7xz71dHUfHqDM3Lx/OnBokMSjLTZACu0OI8MsDyD9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348348;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=+DwQIx2VMtiWG3fmtEaaFxZNpRXWJlTedkrCl7mKS2o=;
	b=N/WDd74nycDoyXQ18haqNKUqDVeHOa+QQiV6UK65lRzIulbmU88tbaXOAtFJmb6UtqxF
	 T/N3zW2Fl+u/aAyFJrp4kUxa/DlZ/UL1dFZ+WVMLeIyNdhW1VP6+/Hvy5kOcP5oeIpw/4
	 bxh1L15FJAN+MkQrs7//L2zU3hJEKPOyFddMJdeeVUfaLVngjYrx0/7tO/8+ig3BESQPU
	 sFPm4qGK3WHrtIL6kp7ZXo+e4laRs1+BAG3SqOmzmXZZB5TIrZXIUjm82TNtN4V7CL9ee
	 rldOZ1LFibxAjMi2er1/JdrWsp/74VzMJ7GlK00dcQnZF3deSRygVH+umLgEG5hstQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PLLg9Gb6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cOJTAelY;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC1606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 22:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FAC1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PLLg9Gb6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cOJTAelY
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 932777A026C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 17:05:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 10 Nov 2026 17:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794348347; x=1794434747; bh=+DwQIx2VMt
	iWG3fmtEaaFxZNpRXWJlTedkrCl7mKS2o=; b=PLLg9Gb6R1/NFKh45mfJW18wq5
	J8hJLMusl1OenOm0byIrO8rO3MCQgzYYSVoOFF7Pq2RoVMAgpzRQmpAfgT0ditQ5
	m7e93rVPUGRG2MjXxSqwrZZmKAg3JijzpeL+I5Od0k4Ij0FHV5KSaUvuOxlvPdTB
	Kwy7RU8Go/UULwxcaX/XJfIphpBQTSxn3rau18Z0+yHUGHT0/R+HyLwefPAJub2V
	V1I57JcJInuZQNwsirwbPe3MFhCyoBeVFtE8/GEmQrbw7/GXUtXrOWVfwQAmzJHO
	KszXT6kLBtm5m3MeeV5DMIUcG5bEf6zjoyPPU71U68ha6WnF3KXnuoth0XFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794348347; x=1794434747; bh=+DwQIx2VMtiWG3fmtEaaFxZNpRXWJlTedkr
	Cl7mKS2o=; b=cOJTAelYM/4uzxqj52LXtHk8Hhi++uO47P87rhkj0EEnJquxcUY
	AHnb6knQBoNwxbQsXx8/oosYr0lgn6CV/6iVpmH8ycXhLPbFvaY5xOhYA5Rsx+cK
	U4lK4/ddaATljRKqWpC/g0CLZ0QrhHnrTU66ewfQmZYM8k3x8OZHn066sJzXWqNM
	dHFD13dr1Auw7GanwBRpadrwwmwdHA4j6/HQQqExvEA4SP6u19oSySlVO/tmBWim
	4aOH0eC5e2xqGKy6+MeayWG9aQ1AWJ0L+UCkMlPBUN2d2mxLGxCGc4yeBvvN9dUZ
	KfqBczwH9b45ksEjbcPIKEse5Nvz+5pS54A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794348347; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CsMn3roQioEBWJTFSBA1fIGU6+xQ5M4hGDESDdCDxa5IiTB
	6K8CBN+yrKgK8mF3njq2LZko+GlbsPRUQAqR9up0IppnMGuM6uoMT9euaGoiD7Sn
	mWJCVHSRV/85inIL4gNQw38+rxpSCjKd2LzRcCnoyD9PWOGCK7v/YgtTMsd6B9QS
	1bP4wknF1HEPxSFqcT4bf5KSWY/g6FtQoTJxxQYYW4IAdFfrsc79HtcHBwZNVwj0
	F5kUOJyCcNNse+r17EFXSwHd3dPv7KHw7vFuS+Btsy7mHQAPOxv7jht5WaMPf8xp
	5qJPdvPjcxZbEnPtX/8F+6/ewOVN3e+0iQpM9ZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:EAM2qliRAeoNdBO0Vm4BLPo8J2IDSCyiwPn4jXuLEho=:nqJlU7z24mkGxg8YJc8jTwmat6J5i+IkaUahK9NRx04=;
X-ME-Sender: <xms:O5Xzavqb6pcAuv8HJ09rVd1elrnzeJDSat1sVGOm3gMXwUzm-uZsxA>
    <xme:O5XzatVG8ASyNc1rTvr3GCKIgC2-R7yow1AtBKGdvtQ3xfcDd8LORASkmkS8ab8kJ
    1Rmj45ByBwamlIRDhkJYPRCLKY44m2Vc-6Oq1okxMU1DSrFQQIQzw>
X-ME-Received: <xmr:O5XzamDhEEWtu6-Z0kkYGPi18SZJeA0Y-zzR3v8i8oAlqMGQ2wh8Z3jlLAjM5b7iOFzGEVL3o38dRo0kl5UGFjlUq7Baxl-ie3k8>
X-ME-Proxy-Cause: dmFkZTFScax+U/bsytFPP9U6UVnsDNCVM29Jtpfjkbs6O1TydnbsAX69SM0qfIMKqzPVC9
    oCELwsVMZEXaaDacl3ONMAAj9kc7woKZ6Z1jL0ZBy1Ry26N5q19pBNVtWJZs12FfEbe35i
    KaVZq5h60FiBbKX0WrYjl8y522ixODmswnxW5qXh9BObs4+Ox3k+bwt7Y9qCqnyNgdRlJs
    6rxxWsTKxPrxDbK/+ld62sx2tIA0abdWulC02Fygnme5tn9DSCfq2sfrYzmYINim7BSy9a
    bNubqwGctbj4KlKJzhxTZY/KSgRv4jAvCLBSE4dLAEqid9B1Mbp9DxoUgT+FyF9BNBeLtV
    pR3JYTsLXRllEBtLOtWx30Vs2ApkR0HunFUn9NzExW7/eajgq8+Bl7kLkxzRpH7swQ2fAM
    t4xAJp2KPc7M5SZ+LOtFb6tqb1Xq1f31+KbUT829T0wi2vxxIFmvRbMFdCj/GHg3/mP/v4
    EuTqr2+cl92sqI8BBWAl1zNgNU99TaLk0gj0uYOGNW5Akx2jDG8BFqZ4Ksm8ggHCpU/QA+
    4oi+TlbrdaEOho+s7cn9O/KPdfKFcP8/wMCa5CjxEYbg0g0nOv6C0Rwso9knM6aK3XgjV9
    2xq4aVfm3cN+rs9ibVBloslIqKJArt2s1MHhGx+iO1XeyxgAU9El7HZRmcOg
X-ME-Proxy: <xmx:O5Xzap2lGXsYey0zWS-wlbfm-FV6urN_iD9sgn57-N2T2OXanGZsjw>
    <xmx:O5Xzag1h6K1MIYukbdh2AbdrpuXgpqWLOYf0Caqsv4lKYpuG6tFXAQ>
    <xmx:O5XzamAfTyBP7Jk6SV2d0W_O29Zj7LWmjTT9Km_RtWYBN14TZTXPJQ>
    <xmx:O5Xzan4SaRIAu4kiST7NMKh8ByzDvkdQfSFlCs3EABj8fZTcSz_iDA>
    <xmx:O5Xzaj-4Sbo4giTYY6zIaS_oSCZFVoHKUvtue0shAjzlch7DS_ttLjEB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 17:05:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wyatt Holden via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  wyattj.holden@gmail.com,  Wyatt
 Holden <wyattholden@microsoft.com>
Subject: Re: [PATCH 1/3] checkout: make orphaned commit checks configurable
In-Reply-To: <6aad1a1cd34a65939be6f64a0d8950e0bc23870a.1794337920.git.gitgitgadget@gmail.com>
	(Wyatt Holden via GitGitGadget's message of "Tue, 10 Nov 2026 19:11:58
	+0000")
References: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
	<6aad1a1cd34a65939be6f64a0d8950e0bc23870a.1794337920.git.gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 14:05:45 -0800
Message-ID: <xmqqa4ngpcjq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Wyatt Holden via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Wyatt Holden <wyattholden@microsoft.com>
>
> When leaving a detached HEAD, checkout enumerates refs and walks
> history to warn about commits left behind. This work can dominate
> checkout time even after the working tree has been updated.

Interesting.

I often am on a detached HEAD but never realized this particular
check was expensive.  The size of changes between the HEAD and the
next branch would affect the time it needs to update the working
tree (the larger the difference, the more expensive to complete the
branch switching).  What factors are involved in making this
"orphaned commits" check more expensive?  The total number of
branches?  The length of commit chain we are leaving behind?  I am
trying to see if this is something we can aim to optimize or if it
is a lost cause and a cop-out to introduce an option to disable the
check altogether is the best we can do.

> In an automated checkout of an internal monorepo, unpack_trees ended
> about 12 seconds into a roughly 204-second run. Stack dumps captured
> the main thread in orphaned_commit_warning(), enumerating loose refs
> and opening ref files. Using --quiet reduced the observed checkout
> time to about 14 seconds, but also suppressed unrelated output.
> These observations motivate an opt-out; they do not establish how
> much of the delay came from enumeration versus history traversal.

So, in short, the answer to my earlier question is "we don't know".

> Add checkout.orphanedCommitWarning, enabled by default, so checkout
> and switch can skip the check while retaining normal checkout output.
> Automated callers can opt out when they do not need a warning about
> leaving detached commits behind.

Sounds sensible.

> Follow the configuration precedent of 06b324c1d71 (status: add
> status.aheadbehind setting, 2019-06-18). Unlike status, introduce no
> dedicated command-line option; callers can use git -c for a one-off
> override.

I am not sure how justifiable the design decision to leave the
command line option out is.

The automation can run with "-q" to omit the overhead altogether, as
well as squelching any other output the automation would not read
anyway, so I would not worry too much about them.

But for human users, what are they losing by passing "-q" when they
do not want to pay the cost of this check because we are not giving
them an easy to use command line option?  What other output are they
declining by "--quiet"?  "The following paths have local changes"
list?  Anything else?

> Add a Trace2 region around the check to make its cost visible in
> future investigations and to verify that disabling the setting skips
> the routine rather than merely hiding its warning. Document the
> setting and test both checkout and switch.

Sounds sensible.

> @@ -1132,6 +1134,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
>  	struct rev_info revs;
>  	struct object *object = &old_commit->object;
>  
> +	trace2_region_enter("checkout", "orphaned_commit_warning", the_repository);
>  	repo_init_revisions(the_repository, &revs, NULL);
>  	setup_revisions(0, NULL, &revs, NULL);
>  
> @@ -1155,6 +1158,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
>  	/* Clean up objects used, as they will be reused. */
>  	repo_clear_commit_marks(the_repository, ALL_REV_FLAGS);
>  	release_revisions(&revs);
> +	trace2_region_leave("checkout", "orphaned_commit_warning", the_repository);
>  }


Quite straightforward.  There is no early return in the middle, so
entering at the beginning with leaving at the end is the only change
necessary.

> @@ -1253,8 +1257,14 @@ static int switch_branches(const struct checkout_opts *opts,
>  		}
>  	}
>  
> -	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
> -		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
> +	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit &&
> +	    new_branch_info->commit != old_branch_info.commit) {
> +		if (opts->orphaned_commit_warning)
> +			orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
> +		else
> +			describe_detached_head(_("Previous HEAD position was"),
> +					       old_branch_info.commit);
> +	}

OK.  The call into suggest_reattach() via orphaned_commit_warning()
is the more expensive part, and it also is where "Previous HEAD
was" comes, which we do not want to lose.  It makes sense.

Another thing I noticed is that the loop in suggest_reattach() stops
showing each commit after showing ORPHAN_CUTOFF but keeps counting.
I wonder if it becomes palatable to introduce a configuration to
stop it early, instead of disabling the orphaned_commit_warning()
altogether?
