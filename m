Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4E1A6801
	for <git@vger.kernel.org>; Fri, 29 May 2026 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093256; cv=none; b=rlJaFCKKz2z9c4q7CNDQFdO43Jri5KTTQnXlYucsCDpSLDv9khL/mF/Rc0ADtUh5mq+H30B8ZQxak6QZfY8yU9NEKkGlS5EORcBMl+61JMd5A5VDcj4Bfve0PRTK6IZuGmD0IFcnVNTxVQ16OsF0wL4zM581/mc6sV0A1/nCel8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093256; c=relaxed/simple;
	bh=Us6DRjZLvtUnXujOyRLMAeylTaAJ1e7T8tav8MkxDV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNEn2ZSzsc4j4O9TIWT4Ps1BEwuCBug2ZD4u9kiGELt7eAfMyZ8E65YafKcMDclTgc0C/Vei990DhWhCtAn2Wj/NgldLOcrCqzcmhMrcaB7P077PFF7CPkR4veDzTth10A16zRxnLsJnShL/EiVQ46mW3uLzihiJwaGw1pVo2WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ZzD/EeRG; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ZzD/EeRG"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66058b880e9so871570d50.2
        for <git@vger.kernel.org>; Fri, 29 May 2026 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1780093254; x=1780698054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pv9TYOBTqaL4ETSN8KHL1ic49/oEjoCL9vyvlzL7iBQ=;
        b=ZzD/EeRGjdIYvCktCjwGWOjoRPLN8IZRTVWfevx0na2lW00F49AGiTG9OK/wmn0kiv
         LQP3RM2mNnmBZRh8+4+UedyTfC/uZykYu8mvETaooWjmu1/YN5EXRuestdgDgX7FDaYe
         144vniJIhfYr9Ryw9kaLfbGfdB+AFP+spAkmu4Ci/cIRJnyTz0Mn8xCP3AJzLp/+WGMB
         5vGROs0U3QaZpKH0SlkSC0Le0ItSEqvNgzjAG+4L3zV+qTjrmzoZM51tbmctAULiRBKw
         G3+8kkYeC3QqRulsSKSkeIkJ7zhT6xTvQET1S6f+gK8cE2yR8aiDyM1aQ0KJmLLZ0x9h
         UhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093254; x=1780698054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pv9TYOBTqaL4ETSN8KHL1ic49/oEjoCL9vyvlzL7iBQ=;
        b=Ua9uCYN66sirl7tN5XtUvAeBtCM+h3glucaFDPnfzi8arYGVayOlu7vcs7pVTeqwWK
         uDTBJf9elHTZI1+QK2s4zecAtKl35KB7jXymzHGMDv90zT8c9Bg09dqLu5dC6wFSH/AQ
         yGqM2IKgCcQJRnU4ieRZNk/B9rWsNhrnTx1G1nvQpVKFGRi8SXr4VzF5tuvltBxx/Npi
         EhLvTzBzNE4ZSYmOnbI1Y72cd0QUff5B+OC5/GnRenRuljs9Yx+fh8wHZa9n59LyO8b/
         /wExmRoeOF8qO5khwbgiS+aRpr0v2C+n0sLSn8B/zmzYL1Y28lkaZuOkDknEFyamz/kJ
         PLTg==
X-Gm-Message-State: AOJu0YyJ70QDc30wE5mXQsook07y6mHl2V9+E8SPousX4ZMboF//Xtza
	dFYngrfXJfYipjduEY6urN+YL1EVs/BbBgBTM95+3SMRlCtVbThsnpgchw/6GqkmOoT+9awOFGK
	RJ0rno2w=
X-Gm-Gg: Acq92OF2wBvbHh/wv3POKFtY6pbxcUxPGFcpF3/uoZEZAT1+mKnVKToIoemqf/Ghu6I
	6fd7aFs3r6HyY47Zduq8kEA0fJ1DgGtlcEPh2QQXFYpCXy/vtp6Loahc/0WgFXpW+Lj4XUAGhzI
	zggQidNk8a/GDjYGCg9kV7CcFQSHrCZ6ygegmxYF9x9kvcvSblGb7Kz1MKaADfzu/o9u6FpOKEj
	7CUfQktCjBqQjl22c1OSY8pntgZutIgYg+W9XezR/Y5XANTzsiuq0bI+EOx25WScPtvxBGqUlZc
	j2baQSdRZCfqjuMvqa+DZSzDIUVW6Oy5EgQZQBJyzW7iA1iIyXi+PS55SyTa0ZIJP/SmmdGnski
	frlVMD1WjL+oHFisF6jQsvH+Lp2J/EuYYR4Iceu6DfLvOtHfO5eM60m2sCTueFX4K1PObnGS0WI
	sccoUBXXKZR9MpkWiHVC1ktwiF5MB58HY6jn03v9l5cg4dwpih+v+2qhrvznA+hJa3QqWYqvB5M
	+zBjPri/9IksFk48AhyXyN8zLSzjrKZSMenEWdJPVfAoqFP5GCJQNLWoa8qpGOPrK29C3NpUnb1
	frBRTq4cpkwnzpE2lfmuGX22fiE=
X-Received: by 2002:a05:690e:4812:b0:64c:c616:c349 with SMTP id 956f58d0204a3-6605ef9948bmr917445d50.31.1780093253949;
        Fri, 29 May 2026 15:20:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660536b434bsm1177772d50.9.2026.05.29.15.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 15:20:53 -0700 (PDT)
Date: Fri, 29 May 2026 18:20:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] pack-objects: support bitmaps and delta-islands with
 `--path-walk`
Message-ID: <ahoRQZX6OXYKPCmd@nand.local>
References: <cover.1779923907.git.me@ttaylorr.com>
 <a708e23d-e0c2-48c9-86e9-1227f12edd53@gmail.com>
 <22a7e32f-f645-4f00-bc5b-6b4309e483c2@gmail.com>
 <ahnx/oBWe9yyBZFg@nand.local>
 <2d68fdb2-ac05-4331-b53e-53c2e9a2b3d4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d68fdb2-ac05-4331-b53e-53c2e9a2b3d4@gmail.com>

On Fri, May 29, 2026 at 05:28:32PM -0400, Derrick Stolee wrote:
> > My reading here is that we get significantly smaller packs (i.e. all
> > 'test_size' tests drop from HEAD~3 to HEAD) in the same amount of time
> > (i.e. that all 'test_perf' tests are roughly flat).
>
> The sizes don't shrink, and in one case increases by a small amount. I'm
> happy to count those cases as noise from multi-threaded delta calculations
> being less deterministic.
>
> The _time_ taken to compute the packfiles is what decreases, though, which
> is promising.
>
> > That lines up with my expectation here, which is that even though we're
> > using bitmaps at read time, that's effectively seeding the verbatim pack
> > reuse over a significantly smaller pack, producing a much smaller output
> > pack as a result.
>
> Can you double-check this reasoning with my read of the data? The size
> isn't changing, but the computation time is.

Yeah, that's right, and my apologies for being in a slight rush when
sending this to you ;-).

The size staying flat makes sense, since both packs were generated with
--path-walk, we're just changing the way they're served. In HEAD~3, that
pack is generated on-the-fly and sent over to the client. At HEAD, we're
doing verbatim reuse over an already-existing pack which we got via
repacking (also generated with --path-walk).

So I think you get to the same end-result (more or less, modulo usual
delta patching via pack-reuse), but the time to get there drops
significantly since we don't have to (re)compute the pack.

> > +test_repack_with_args () {
> > +	args="$@"
> > +	export args
> > +
> > +	test_perf "repack with $args" '
> > +		git repack -adf $args
> > +	'
> > +
> > +	test_size "repack size with $args" '
> > +		gitdir=$(git rev-parse --git-dir) &&
> > +		pack=$(ls $gitdir/objects/pack/pack-*.pack) &&
> > +		test_file_size "$pack"
> > +	'
> > +}
> > +
> I see that these tests are extracted from test_all_... below:
>
> [...]
>
> Because the --use-bitmap-index and --write-bitmap-index args
> aren't appropriate across these different commands.

Exactly.

> nit: the diff would be more obvious if test_repack_with_args
> was defined after test_all_with_args so the hunk of existing
> tests wouldn't appear in the diff.

Fair enough :-).

> >  for version in 1 2
> >  do
> > -	test_all_with_args --name-hash-version=$version
> > +	arg="--name-hash-version=$version" &&
> > +
> > +	test_all_with_args "$arg" &&
> > +	test_repack_with_args "$arg" || return 1
> >  done
> >
> >  test_all_with_args --path-walk
> > +test_repack_with_args --path-walk
> > +
> > +# inverted order here: we want to test using reachability bitmaps on a
> > +# pack written with --path-walk
> > +test_repack_with_args --path-walk --write-bitmap-index
> > +test_all_with_args --use-bitmap-index
>
> So this allows us to test all of the different modes.
>
> > --- >8 ---
> >
> > I don't have a strong opinion on whether or not we should include that
> > in this series or elsewhere.
>
> I'm interested to see some results of your new p5313 test
> to make sure that we are getting expected size changes for
> the repack, since the p5311 tests were more focused on the
> thin fetch pack (and didn't show a change in size).
>
> For that, I'd be interested to see this test be included in
> a patch for future reference, too.

Will do.

Thanks,
Taylor
