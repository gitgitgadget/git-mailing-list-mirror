Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671F3DDDDD
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283076; cv=pass; b=oooX6dXTyqtMV7rJxFs2Zpmub1gJrIokooS9LMswXgufOx8blZP+6/M0A+e2RgzLufd2cksp1oAVcJae497k9yMB76jcJkp1qj+TTQO/IM8TCObIPqVvSwgXO7fv+NtZrs9mMxzRMPFJC/QzOeRmuYMTBdsD+RxG7Jp5zVxN3mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283076; c=relaxed/simple;
	bh=6EF0+w7zYrXHR8VCOcmkbzvnYQhcfNPaArF2bTWERKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa7rUU91gJtulZCoftrIPx6Lpj8+5ckan5QKCifBGmRVz54BPyH8yeTQkpdCowNhZk9bFSU6T7tBLOfmGa7MuTkyo23/Ke0rmAzulsuH1SLGndhhI1/yZ9Vz2fN8q/GqKyn9UOoL9rXCldcRpk5Aenn5beYHsxFrLUdEw4S6axs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=bHAshVRg; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="bHAshVRg"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-677bc4704cbso379567d50.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 03:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791283072; cv=none;
        d=google.com; s=arc-20260327;
        b=SQd2KzqW9dfGpiGQDbxBIB217RZy62I2yGc0+ScR5mKzqmvCoKY5YwK9427HLI59ph
         h4a625R4QjNLQqIB1RSjiHDcBtfgLEr3CeymlKdTEg0IixORnPN+YGtB13e1hwrKuqSD
         MuLfvsGoBt87/kYRNgrOnnwBCCKkc9udvwDvxjHZlbaLfqB2PxvTdJdhfVAKdot1y4c2
         6FzlWuoe2OJheAcgWTsB3DpN4UE2D2QAh1dS0lJq/KR8TuXUylEeyMUl54BPJhnLiRX/
         tZHkf2fqdK7QH5EHsr02Ggf0m9839KPm2JUrEF9GIZK93lMb4rS1lHmaqDCQ6YVKFdXl
         7c2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vuPvo+IELA52BELZ685z1M7/fqklNSuJ9Oc4fl+VZE8=;
        fh=fqeg7iAc3C/7n5OnTd0SdG/I0d7ad16qkzp4+mNlmpQ=;
        b=sQ5CBiYZymjOShsxjpuT7ocWUntN09pl1cyx5zqhP8FDBqaUBh+e1CPvfblRPVoNdJ
         0RE5rBhp/ifaSr+pUDCg8o/MxvGgGkGD0BahouftUEy6F+p2K9G5R1vNiiCi0EH0TFmt
         d9aQJQ2sVVIq2Xb32OaK4xgz2fI6uznOPgk6A88I6VC9wYPugNFCUExYgUmVFNrJAa6+
         vnNlx3/bU1fEet50P/VGlcelSg6gTK3vnh9fzoI4gS9EqmvLq4dCvkETyoZtfHpSA5eA
         vBUJfk2hJHe8pN6yBGttTtw3yFDhY2vePUAEXTYWKDzHgX913+2pZ5X8GwaGuA12E7Cv
         /xqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1791283072; x=1791887872; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vuPvo+IELA52BELZ685z1M7/fqklNSuJ9Oc4fl+VZE8=;
        b=bHAshVRgEtb0d/HdiYYntTEDDxu6uzs8OWY0JTshPwQJfNiwjWOg9cJseZWkfeKncY
         R6zdWuBBvax92oxBgYCL2VlnWI5WGDHVx4gRggDseEk1AvPSkR+EVuL4aq6PUx6lLI60
         j9+7DVuB8Srt9xH3mmbWfeC7Sk/LYoltL+6GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791283072; x=1791887872;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vuPvo+IELA52BELZ685z1M7/fqklNSuJ9Oc4fl+VZE8=;
        b=Ma8h3kz1ZJ5z1Mak3ACZGv/P5VId20rbhOX9YAgB3BTySqFk/CgDiaeP/Fv6HftlJG
         tv6uoBRoPZ9SaRb/1fZz6ULXju3xcl4PDsmQhNj0KyKzSWUb4+i2UgSVCU5DQR56ZD0A
         RyWHD4lS/erKnPs4cOnBiqEqKnQSlnb+yfkjZtJa/2oTqeT558YQ9jcYv7+mcu52MYIA
         F02pMXLH3pVAAou2GFpmBkk8YG/YbQblki9bs8Rj48IcJXsOAz0A3pBBjFNylnr38gI7
         5eI4Vng3GHH98jFMDz90d/ma9paBLllJ8gAagaaHU9qgdCG35hnuy3UNDzb7y3suZuNT
         L4gw==
X-Forwarded-Encrypted: i=1; AKwUvBz2VTYt6fci9TxGS4kNLIwPWF2nQpHlLvy3GqkTJVhWFO653IQ703XO1M0Ef7xAKEtr5HU=@vger.kernel.org
X-Gm-Message-State: AFq9FYImDJXC1Dc469ZV8Wq/90C3narlLTJSRkMtvezKDdvHdzz4r4Vt
	XDwfkBZ001XF2/MyShz0gUv7Y335UP1fIMbv7llRYUAh5XwMr8gul7wnhFmUTaXWSFjjiPeXdl+
	CEoHksbnfhddz6gEHtNom1BX5qxV4WEBpJWkEWqiaFFXBrtP2Oixqb1NOFg==
X-Gm-Gg: AYBFou1nWe35Wvjlc5WEqGe9i5DSKUuJVhmbZKnT5ERwLdEeS6T6uD9SDRAN108/XDY
	gKuxosanlR4M48xkvl80wbtK/Dl4UKRfbE0UHRvkFTelXs72qsBupnXF6/6H2tOdV5tLJkDh3zM
	j0ZBY5bxUB9omCEdos2626aIMIYu1dS7/iMBhIUT5MPdxldmvX71SOfEOuJf6XT+gD+a6yVxJ8K
	XrCKWp5UIEM2Wbj5+XU4whI4QuWkVHyIFcCEOYw4ZgDi99gP4IuSdAVxjhZJMdwqOk/X7ndBpg9
	v6ZVhZ9A2h2Gf2By8MhjMnYa9DlfX3MYtLY7QzD3AH0rVTVQ0IpDJpM=
X-Received: by 2002:a05:690e:d0f:b0:678:907b:3014 with SMTP id
 956f58d0204a3-678fcdde7e0mr246685d50.63.1791283071810; Tue, 06 Oct 2026
 03:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v2.git.1790600552.gitgitgadget@gmail.com> <6ad528f4bb42a960910eb4fe917a3766fa55d598.1790600552.git.gitgitgadget@gmail.com>
 <asNZD7AOC6QL9q1d@pks.im>
In-Reply-To: <asNZD7AOC6QL9q1d@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 6 Oct 2026 12:37:40 +0200
X-Gm-Features: AclHuK-cNy0Fg4LnyD2-ig0FMdDmAQ9EjXBB8XC_jUpBwbbzGguUK9KZvKNgZfY
Message-ID: <CAL71e4PFpMPoSxFdnscRFiMB3ozudr64TjeQc8VKcO_M_MfJ=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] connected: add incremental connectivity check via rev-list
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Oct 2026 at 10:00, Patrick Steinhardt <ps@pks.im> wrote:
>
> ... whereas in the new world you propose to skip marking trees/blobs as
> uninteresting. Instead, the idea is to compare the trees/blobs of the
> old tips directly with the trees/blobs of the new tips and only verify
> those parts that have changed between the two?

Yes, kind of, but I am not sure what you meant by old tips and
new tips -- to be clear (and I should also write this more
clearly) we only verify the commit-trees for all incoming
commits, and the comparisons are always between a commit and
its parents (i.e. X and X^1, X^2, ...).  The key insight that
makes the approach work is that we can skip any object we have
seen from a trusted base (e.g. a commit that was already
reachable before).

>
> This can of course cause us to verify significantly more objects in some
> scenarios. But it does have the consequence that we scale with the
> number of changes, not with the number of preexisting objects in the
> repository. And that's something I'd really appreciate, because marking
> reachable objects as uninteresting is extremely expensive.

Yes, that's the goal in the happy case -- and I would argue it
does not produce significantly more work in the worst case,
due to caching and remembering everything we've seen so far
(only more work within a 2x bound or so).

> One thing I wonder though... does this help with the scenario where we
> have tons of references or do we still end up passing "--not --all"? I
> have seen many times that parsing the refs by itself is dominating the
> time of the connectivity check quite significantly. So ideally, I'd like
> to have a solution that also catches this case. Your benchmarks do not
> cover that scenario though.

Yes, the problem of scaling out with number of refs is a real
problem (and often a bigger one) and I want to address that
too, but it's out of scope for this particular patch series.

> May I suggest splitting up this patch in the following way?
>
>   - One commit that introduces the new option, but for now only accepts
>     "full" as the algorithm.
>
>   - One commit that introduces the benchmark.
>
>   - One commit that introduces the new flag for git-rev-list(1).
>
>   - One commit that then introduces the new strategy.
>
> That may make it a bit easier to focus on the actual change.

Yes, I can definitely do that.  Initially I was thinking that
since it was basically only additions no obvious good in-between
state, it wouldn't help much to split it up, but I think you
convinced me there.

> > +The incremental mode, selected by
> > +`transfer.connectivityCheck=incremental`, avoids traversing the
> > +full tree walk of the boundary commits.  Instead, it verifies
> > +each incoming commit's tree against the already-trusted trees of
> > +its parents.
>
> Can we define "parents" here? Specifically, I wonder how you define
> "parent" in the case where you perform a force push or when creating a
> new reference. Is it the parent of the first new commit? Is it the old
> state of the ref, if it even exists?

Parent is always defined relative to the commit we are
currently verifying.  For example, a push may come with
3 commits (let's call the tip T), and then we do the
following comparisons:

    T   vs T^1, T^2
    T~1 vs T~1^1, T~1^2
    T~2 vs T~2^1, T~2^2

T~2^1 and T~2^2 must already exist and be reachable and
so we can trust them to be connected.  And since this is
relying on memoizing already seen results, it's important
to run the checks bottom-up (reverse topological order).

I will see if I can make this more obvious in the commit
message or documentation somehow.

> > +Trust model
> > +~~~~~~~~~~~
> > +
> > +A tree is trusted when its transitive object closure is known to
> > +be connected.  Trees reachable from commits on the
> > +already-connected side of the boundary are therefore trusted.
>
> Where the "already-connected side of the boundary" is anything reachable
> via a reference.

Yes, precisely.

> > +Incoming commits are processed with ancestors before descendants.
> > +Once an incoming commit's tree has been verified, it is trusted
> > +and can be used as a comparison base for later descendants.
> > +
> > +This gives an inductive correctness argument: every parent of the
> > +commit currently being verified is either already connected or is
> > +an earlier incoming commit whose tree has already been verified.
>
> Right. The big question to me still is how you identify
> already-connected trees without having to read all references.

That part works just as before -- rev-list finds the
already-connected commits implicitly with the --not --all query.
It actually finds all the new commits, but we can deduce the
boundary from there (and the pre-existing rev-list code also does
that).

> > +Worked example
>
> Worked?

Hm, I suppose I could just use the phrase "Example" here instead.
Will change.

>
> [snip]
> > diff --git a/tree-verify.c b/tree-verify.c
> > new file mode 100644
> > index 0000000000..5c11c2251a
> > --- /dev/null
> > +++ b/tree-verify.c
> > @@ -0,0 +1,316 @@
> [snip]
> > +static void verify_commit_tree(struct repository *repo,
> > +                            struct commit *commit,
> > +                            struct verify_state *vs)
> > +{
> > +     struct oid_array base_trees = OID_ARRAY_INIT;
> > +     struct commit_list *p;
> > +
> > +     /*
> > +      * Parent trees are trusted: boundary parents are already
> > +      * connected, and earlier incoming parents were verified
> > +      * first due to the topological processing order.
> > +      */
>
> I feel like I still miss where exactly you establish the trust boundary
> between preexisting fully-connected commits and new commits.

This is the same as before -- git rev-list produces the trust
boundary based on reachability.  I think the only new thing here
is the inductive leap.  Once we have verified a commit just above
the trust boundary, that itself becomes a new trust boundary.

> > +     if (commit_list_count(*commits) < nr_before)
> > +             die(_("cycle detected in incoming commit graph"));
>
> I don't think we should just die, should we? That may not interact well
> with git-receive-pack(1) and others that expect a broken connectivity
> check to bubble up errors so that they can properly report those to the
> client and clean up their local state.

This is one of the advantages of running within a sub-process --
we can safely die without breaking things -- and this is in fact
how the existing rev-list based implementation work, it will also
die with an error message / return code that the parent process
picks up.

My original implementation tried to do it all within a single
process but it became painful because a lot of the internal
machinery did not have non-fatal variants.

That said, I think long term it would be good to rework it
into a single process and have the right infrastructure in place
to avoid dying.

Thanks,
Kristofer
