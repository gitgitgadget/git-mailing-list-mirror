Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6718B273805
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765334938; cv=none; b=DCS4SM0YUH2mLv3X8c6ee7C3R7CmdYGwxYn1VHlZx/xvKo22EnX678LVhZ1ddoNvHp+txA+rkOQG6RgR1qDfs+kr4W8/ykQG7AfVXq2bcxVBngYxCVgqyb/sxjxiMDDSMrwnjYLv/vCxKfiiTr6cQup5l74RC/m/fDdbw1c2hOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765334938; c=relaxed/simple;
	bh=EbXnrs0MYGkr64xNXfzE809TEOtwf78F8betreQH7qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apgkF/ZqDooL3KBpIOrxKBpCHwc99jTcDwYndscCbOUHye5GEWZXzdsAS68Bps9HW+oGh097bNOqVr5ZG5GJRzONOKN/b5pV398qGxKazC50KMP91wMJXgiZY0Ca7zm4LowLEaHVbTE847gQ6knNlWwXFF/yIuYoO4RUVkx8KF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=aRo23RWa; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="aRo23RWa"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640d4f2f13dso6333281d50.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 18:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765334935; x=1765939735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lY4+NOM8Jk1Q2kiib+pie5h2o7cvA/7tlwzJJkSnlmM=;
        b=aRo23RWaI9fx0HoXy3ornQHZu68B3N0xndPCxloh/AgHXtzRHAUKGSNcEsEQGkD66G
         MLGpIi23ufSwxAdFIkmPFhGKnARQPslml5osj5v4Fb7XMHAhx0inK6T3ccRjW3valaWL
         qbKmJFv7YlRI5WGd3SrBjyyAHNXDFjBeIyCh51m3DwU2HlAfGJ3Pi3oQT1UWWbN5/+YI
         jmbicYriuCY13hSy0tymsxqvbF238yTRvaiLwCLynYaW63+Fvb5w2ejs97jVl3kSK08R
         D/QiYsy8qpPEA85OKa3IE1ojFboOP9qAFV/uJhdKb7dgp2fQiOGOU9Kn9ylwhKou460o
         KwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765334935; x=1765939735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lY4+NOM8Jk1Q2kiib+pie5h2o7cvA/7tlwzJJkSnlmM=;
        b=MpxQOTDDzBQFmXCCBK8a2krwF0bF/9dQqCcFC2RbITPUFojGJHS8kvjnV17yuIIOwr
         v1DMKsXZMDNiG6tu7ccymWvlw4AXsdfuEMLylpF9a2bjy/ONr3bFj/+tUt0bGuIgMatf
         h0i9AQXEvW2nIKCUS7L6QNkd9AwxSLENsxBeOYtxl0xmHoVn5vTV0lRfrxGxH4f1NIi/
         d+751TqdtoWM7E6xTzERfg/1ZgXBniFRX7TDtmKWaPFgoxqQpCFN0Ekj4XJGWkSfyrJ2
         YlukCNs5VvThG8CfE6lgUQYT0XF92jfOsqNFu9rW4K7imZUIrc78YCz34PuCz/9z6g+X
         lwPw==
X-Gm-Message-State: AOJu0Yyr8RIYU1qCDqMQBavKrR9uPtQxPmFeCg5NjnDTAQM/3Cy1n1IX
	+pqs98fM4fDMP/m+0PFnYOMypuQeSRxdt+LZ6blKiYGaJitivT9/EqnmnaXioXHwAOA=
X-Gm-Gg: AY/fxX4otpWx9ZCcaSet8FkhCybPUleJFUvMIEUEWY/3hwxdTFPe6fxj4BmyBkPSmPX
	nNc2rQOhsLGwCREng6EjcEPqIFA/feYdrlqXkLBFcfe4SL0teKXF93KrwOEkCLlChcqQzxPpHXb
	vl37/8z+KdUyMh2b1bRq1u19pTUjxsUN48g/tifjlruNSWwUGDzW1EV869S/H9uWfWm71+1T3ak
	eK8uR690VAPOoa4QX1Z95fFkjaOUWPGtf4jaeu7AE0C1BVl+EZchcVqJo04MRiliPI8lbD6Nw3t
	WSgD81tMDaBy4cEFLeh6+h0ENFJ5iVcCtKMubNCIfk7pnAIVOw5lWBJ7EWKQtteX8SnHbYooQ8r
	DdyfeBpcG+1Ei8CVJE9PSywvK74pK4osxJNsQiRieF+ck2pygewv2bjlON9kvmsxiyyLHfu827S
	yRA8jUDEGDu8rxLX+x0CrQVSrI5GOfKIFrB1ftQOwPefYaq5LIi+tQGp4Cv/GmFblXrP8A3RIRB
	6KqJchNSSg3f+7yttAi7Tnpa/bo
X-Google-Smtp-Source: AGHT+IHxAwRWvy1HKOMoWHGRi4YrIjcudBLbwnxDoMaK7Rb/N56jqF3VfPOqT1WN73rbRYLEWol2Bw==
X-Received: by 2002:a05:690e:2511:20b0:640:d038:fb02 with SMTP id 956f58d0204a3-6446e922bcfmr818325d50.25.1765334935276;
        Tue, 09 Dec 2025 18:48:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b4acfcesm67262547b3.1.2025.12.09.18.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 18:48:54 -0800 (PST)
Date: Tue, 9 Dec 2025 21:48:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] builtin/repack: don't regenerate MIDX unless needed
Message-ID: <aTjfj45uFl/f3b4K@nand.local>
References: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
 <20251208-pks-skip-noop-rewrite-v1-2-430d52dba9f0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251208-pks-skip-noop-rewrite-v1-2-430d52dba9f0@pks.im>

On Mon, Dec 08, 2025 at 07:27:15PM +0100, Patrick Steinhardt wrote:
> Address this issue by introducing a new function that determines whether
> a rewrite of the MIDX would cause any user-visible changes. This covers
> the following cases:
>
>   - No multi-pack index exists at all.
>
>   - The user asked us to write a bitmap, and we don't have any.
>
>   - The request preferred pack is different than the one that we have.
>
>   - The packfiles covered by the MIDX are changing.

I can't think of any cases beyond the ones you listed here that would
require us to regenerate the MIDX. One kind-of-exception here would be:

    $ git repack [...] --write-midx --write-bitmap-index
    $ git repack [...] --write-midx

where the second repack would generate an identical MIDX, but does not
want to retain a bitmap. That case is already handled in the MIDX
writing code if you search for "want_bitmap".

That makes me wonder whether the repack layer is the most appropriate
one to handle this logic. It seems like write_midx_internal() would
reasonably be able to detect whether or not the MIDX we have already is
up-to-date with respect to the given input.

I think that makes some things about your patch easier and other things
a little harder ;-).

 - On the "easier" front: while both the MIDX code and the portion of
   the repack code that drives it receive the same set of packs to
   include, the MIDX code already has the packs it would compare
   in a standard format. That would avoid you having to handle ends_with
   ends_with(include_name, ".idx") and ends_with(existing_name, ".pack")
   as special cases, which would be nice.

 - On the "harder" front: when driving MIDX generation with the
   '--stdin-packs' option, we *don't* load an existing MIDX ever since
   0c5a62f14bc (midx-write.c: do not read existing MIDX with
   `packs_to_include`, 2024-06-11).

I don't think that "harder" one is a show-stopper, though. Commit
t0c5a62f14bc has enough gory details around how we generate pack IDs and
various subtle assumptions about how and when we load packs that I am
very hesitant to recommend changing it given its fragility (though we
should examine and harden any fragilities within midx-write.c, maybe
just separately ;-)).

So I don't think that we should make that change ahead of this patch.
While you can't rely on being able to read 'ctx.m', I think you could
load the MIDX belonging to "source" ad-hoc after we have computed the
packs to fill from the MIDX's perspective, which is right around where
that want_bitmap code lives.

I suspect that that may simplify some of your patch, though please let
me know if that turns out not to be the case.

> Only if any of these conditions trigger we decide to write a new MIDX.
> This allows us to significantly reduce the time for repacks that end up
> doing nothing:
>
>     Benchmark 1: git repack --geometric=2 --write-midx -d
>       Time (mean ± σ):      3.183 s ±  0.078 s    [User: 2.924 s, System: 0.219 s]
>       Range (min … max):    2.985 s …  3.260 s    10 runs
>
>     Benchmark 2: ./git repack --geometric=2 --write-midx -d
>       Time (mean ± σ):     102.5 ms ±   1.0 ms    [User: 89.3 ms, System: 12.7 ms]
>       Range (min … max):   101.3 ms … 105.3 ms    28 runs
>
>     Summary
>       ./git repack --geometric=2 --write-midx -d ran
>        31.06 ± 0.82 times faster than git repack --geometric=2 --write-midx -d

Makes sense since we're effectively timing just MIDX generation here.

(I'll avoid reading midx_needs_update() too closely here in case you
make any changes based on the above. Glancing over it briefly, it all
seemed reasonable to me.)

> +test_expect_success 'up-to-date multi-pack-index is retained' '
> +	test_when_finished "rm -fr midx-up-to-date" &&
> +	git init midx-up-to-date &&
> +	(
> +		cd midx-up-to-date &&
> +
> +		# Write the initial pack that contains the most objects. This
> +		# will be the preferred pack.
> +		test_commit first &&
> +		test_commit second &&
> +		git repack -Ad --write-midx &&
> +		test_midx_is_retained -Ad &&

Should the MIDX be retained in this case? I think there is a reasonable
argument to be made in either direction here.

On the one hand: we performed the expected repack, and doing so did not
cause the existing MIDX to be invalid, so we left it alone. On the other
hand: the caller asked us to repack without writing a MIDX, so could be
surprised that one exists.

> diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
> index 9fc1626fbf..980599961c 100755
> --- a/t/t7703-repack-geometric.sh
> +++ b/t/t7703-repack-geometric.sh
> @@ -287,6 +287,86 @@ test_expect_success '--geometric with pack.packSizeLimit' '
>  	)
>  '
>
> +test_expect_success '--geometric --write-midx retains up-to-date MIDX without bitmap index' '
> +	test_when_finished "rm -fr repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +
> +		test_path_is_missing .git/objects/pack/multi-pack-index &&
> +		git repack --geometric=2 --write-midx --no-write-bitmap-index &&
> +		test_path_is_file .git/objects/pack/multi-pack-index &&
> +		test-tool chmtime =0 .git/objects/pack/multi-pack-index &&

This portion is very similar to the new function added in t5319. I
wonder if it's worth sticking that in t/lib-midx.sh or similar?

I was wondering what this test was exercising that wasn't covered in the
earlier script, but since the geometric code path is quite different
from the non-geometric one, I think having coverage there is definitely
worthwhile.

> +test_expect_success '--geometric --write-midx regenerates MIDX when preferred pack changes' '
> +	test_when_finished "rm -fr repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +		git repack --geometric=2 --write-midx --write-bitmap-index &&
> +		test_commit fourth &&
> +		git repack --geometric=2 --write-midx --write-bitmap-index &&

This part is a little subtle since we're relying on the geometric repack
to pick up any loose objects that don't appear in existing pack(s). I
might suggest something like:

    for c in first second third
    do
            test_commit $c || return 1
    done &&
    git repack -d && # ...

, to make that step explicit, but I don't think it's a huge deal.

> +
> +		ls .git/objects/pack/*.pack >packs &&

Here and below you should be able to use $packdir instead of writing out
".git/objects/pack" explicitly.

> +		test_line_count = 2 packs &&
> +		preferred_pack=$(test-tool read-midx --preferred-pack .git/objects) &&
> +		other_pack=$(ls .git/objects/pack/*.idx | grep -v "$preferred_pack") &&
> +		echo "$preferred_pack" &&
> +		echo "$other_pack" &&

Stray debug output?
> +
> +		# Rewrite the multi-pack index with the current preferred pack.
> +		# git-repack(1) should decide to _not_ repack the MIDX in that

s/repack the MIDX/rewrite the MIDX/

> +		# case. This is mostly a sanity check to verify that the reason
> +		# for the repack really only is the changed preferred pack.
> +		rm -f .git/objects/pack/multi-pack-index* &&

Same note as above except here you can use $midx. I don't think you ever
have a .git/objects/pack/multi-pack-index.d here, so a standard removal
should do the trick. If you did, you would need to pass '-r' as well.

> +		git multi-pack-index write --bitmap --preferred-pack="$preferred_pack" &&
> +		test-tool chmtime =0 .git/objects/pack/multi-pack-index &&
> +		ls -l .git/objects/pack/ >expect &&
> +		git repack --geometric=2 --write-midx --write-bitmap-index &&

I'm having a little bit of a hard time following this one. Are we
guaranteed to pick $preferred_pack as our preferred pack here in the
second repack?

Thanks,
Taylor
