Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97008158873
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025493; cv=none; b=hM2EEkAXwEtAynsO+oRppId97IKobykp4dAlzZ9OtuQitwUG7VQYi3VtCO5KxmfCvA+aqfYTrm66F+FynH0WbF5Se707NCHi7cIxowxCQ4Qyx5f5fwMBqH2rR1hczDIxFkGaoEGGQzQjPUTiBXktZMYPJ+mPzCQ4zURVt3Zlnxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025493; c=relaxed/simple;
	bh=PZUiUBTWOZ1M0S+PJEpgd+qmjnt2kCtziPKiRUImXPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpm3NEEU51bjR0oVyf33YDcYzTdjig6LClZbJCeE+Pi+4hqMe1XquvnxHL60Ts4R53Tstbv6dDAqcwpGW3Uc/LeJTGFxUGjAdPsA/QkLSsh4amRevpqJF4L27gzsrT4rH/EeqdfkJ5bV/usCYFsWT0nKHrjliAaCDHCExic10X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LymOCmkn; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LymOCmkn"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-434d0a63151so10000771cf.3
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715025490; x=1715630290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cOlBV6WmN6f1f92ABtfkbX3nWChiRzYKVH4L+R0yX+k=;
        b=LymOCmknY64AG8A/4qLNVRTG/7mzzi8CVzRAunUFve+q0Q4pA0vZ76V9tA8fPSdfHu
         5Q2nzeqKVvacxZLUIFV/5DM+7enZrQy/1ZkUTSwZbiqgyaB7Sauh1F3w5HEM3aD085WQ
         vfD2J4hwxnrCIG/GHJWqjuRcbC7Xw4aAnJLLcXZ02fS852YaMm0DPvxWz8NRV3Hm5d8H
         oux5sCfN3NJ4AQGIPGZ4TstXFv8d0lmjIoI9kDVLW2KrpU7rjujx8YwHNqgRwV5fsmmb
         g8RWrVnMAuJoqfHfR8NqwfK8gOXJWwHMisqP7At1K0gx9uZE9rhjPfSGdAz1zlIAnD4m
         BO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025490; x=1715630290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOlBV6WmN6f1f92ABtfkbX3nWChiRzYKVH4L+R0yX+k=;
        b=OCfD9IkjED7MZ08L3HeKFWrlHsKlywIYesFd9xzmK5r9kcEv4V6BSu7ehZH40Qt6vu
         kVD+FzPDe1PnBdZ03D/jptB+HghUtSh3tzhBBNFkWgJHxeqnlBpIfFh7TAqNCi4hRCXG
         Lhpic6bkvmm+2oadiJ+/zDgux61D5Ne2+e5haJ20qyY4RJpgQV2Y34Z0hk6Lkh8fJ6UI
         Kd887KeRaDm7v/Nrz1DX20LBB+yPDIWgwj8WZ+y1fgtZGBPCJUtOR+08RPzITcDmMi+x
         zulgzTiCap9Jj3XRLjZhChgr7h/CwqPrjpv2FnYiZH8Wrky5Nc6oPpaLjnxFR5OyPfAj
         m0Xg==
X-Gm-Message-State: AOJu0Ywc5ANFPaa1DgPjBD0YRobYFP/P1xYeCwsbCCnGxLlN2xQquw7q
	QesLfSaozzFm8USnZBIDlNUuXpf8Bfzz4kQ/5qXOOEAF2DGYcMrm9lJDSe29ZWLwktawRxS8ac9
	y5N4=
X-Google-Smtp-Source: AGHT+IHxd3xHESxBJjQM2Wd1sWnPyPaPoe6rioMJvQtX5I6WxxDB0x4J65011OUJLaPuiOJsTA3/aA==
X-Received: by 2002:a05:622a:55:b0:43a:c554:e64a with SMTP id y21-20020a05622a005500b0043ac554e64amr13995545qtw.26.1715025490291;
        Mon, 06 May 2024 12:58:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id hd15-20020a05622a298f00b0043aa9ad3859sm5545395qtb.43.2024.05.06.12.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:58:09 -0700 (PDT)
Date: Mon, 6 May 2024 15:58:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/23] pseudo-merge: implement support for selecting
 pseudo-merge commits
Message-ID: <Zjk2UIV3kEwZUDW+@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <86a1e4b8b9be99563836d1539fbf2ed4c4a6920d.1714422410.git.me@ttaylorr.com>
 <ZjjEnVukDDpuP6X6@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjjEnVukDDpuP6X6@tanuki>

On Mon, May 06, 2024 at 01:53:01PM +0200, Patrick Steinhardt wrote:
> > +	for (n = 0; n < group->max_merges; n++)
> > +		C += 1.0f / gitexp(n + 1, group->decay);
> > +	C = matches->unstable_nr / C;
> > +
> > +	return (int)((C / gitexp(i + 1, group->decay)) + 0.5);
>
> Why do we cast the return to `int` when the function returns a
> `uint32_t`?

Oops, great catch. This should cast to a uint32_t, not a signed type.

> > +}
> > +
> > +static void init_pseudo_merge_group(struct pseudo_merge_group *group)
>
> Nit: Should't the name rather be `pseudo_merge_group_init()`?

Sure, I can change that.

> [snip]
> > +	} else if (!strcmp(key, "decay")) {
> > +		group->decay = git_config_int(var, value, ctx->kvi);
> > +		if (group->decay < 0) {
> > +			warning(_("%s must be non-negative, using default"), var);
> > +			group->decay = DEFAULT_PSEUDO_MERGE_DECAY;
> > +		}
>
> The decay is a float, and your decay rate examples mention a rate of
> 1.5f. It's impossible to specify fractional rates though because we use
> `git_config_int()`. Should we introduce a new `git_config_float()`
> function to implement this properly?

Good idea. I had addressed this with the sample rate by making the
configured value a percentage (0-100) that was scaled down by 100, but
for some reason I neglected to do the same here. I'll introduce a new
float parser.

> > +	} else if (!strcmp(key, "samplerate")) {
> > +		group->sample_rate = git_config_int(var, value, ctx->kvi);
> > +		if (!(0 <= group->sample_rate && group->sample_rate <= 100)) {
> > +			warning(_("%s must be between 0 and 100, using default"), var);
> > +			group->sample_rate = DEFAULT_PSEUDO_MERGE_SAMPLE_RATE;
> > +		}
> > +	} else if (!strcmp(key, "threshold")) {
> > +		if (git_config_expiry_date(&group->threshold, var, value)) {
> > +			strbuf_release(&buf);
>
> Instead of having multiple exit paths where we need to release `buf` we
> should likely have a comment exit path.

Good call, thanks!

> [snip]
> > +static struct commit *push_pseudo_merge(struct pseudo_merge_group *group)
> > +{
> > +	struct commit *merge;
> > +
> > +	ALLOC_GROW(group->merges, group->merges_nr + 1, group->merges_alloc);
> > +
> > +	merge = alloc_commit_node(the_repository);
> > +	merge->object.parsed = 1;
>
> Why can we mark the object as parsed here?

We have to mark it as parsed since there is no object buffer underlying
this fake commit node. If we try and parse it later on it will fail
since we won't be able to find a corresponding buffer.

> > +	merge->object.flags |= BITMAP_PSEUDO_MERGE;
> > +
> > +	group->merges[group->merges_nr++] = merge;
> > +
> > +	return merge;
> > +}
> > +
> > +static struct pseudo_merge_commit_idx *pseudo_merge_idx(kh_oid_map_t *pseudo_merge_commits,
> > +							const struct object_id *oid)
> > +
> > +{
> > +	struct pseudo_merge_commit_idx *pmc;
> > +	khiter_t hash_pos;
> > +
> > +	hash_pos = kh_get_oid_map(pseudo_merge_commits, *oid);
> > +	if (hash_pos == kh_end(pseudo_merge_commits)) {
> > +		int hash_ret;
> > +		hash_pos = kh_put_oid_map(pseudo_merge_commits, *oid, &hash_ret);
> > +		CALLOC_ARRAY(pmc, 1);
> > +
> > +		kh_value(pseudo_merge_commits, hash_pos) = pmc;
> > +	} else {
> > +		pmc = kh_value(pseudo_merge_commits, hash_pos);
> > +	}
> > +
> > +	return pmc;
> > +}
>
> Can't we simplify this to the following (untested):
>
> static struct pseudo_merge_commit_idx *pseudo_merge_idx(kh_oid_map_t *pseudo_merge_commits,
>                                                        const struct object_id *oid)
> {
>        struct pseudo_merge_commit_idx *pmc;
>        khiter_t hash_pos;
>        int hash_ret;
>
>        hash_pos = kh_put_oid_map(pseudo_merge_commits, *oid, &hash_ret);
>        if (hash_ret) {
>                CALLOC_ARRAY(pmc, 1);
>                kh_value(pseudo_merge_commits, hash_pos) = pmc;
>
>        } else {
>                pmc = kh_value(pseudo_merge_commits, hash_pos);
>        }
>
>        return pmc;
> }

Nice suggestion, I think that should work great.

> > +
> > +#define MIN_PSEUDO_MERGE_SIZE 8
> > +
> > +static void select_pseudo_merges_1(struct pseudo_merge_group *group,
> > +				   struct pseudo_merge_matches *matches,
> > +				   kh_oid_map_t *pseudo_merge_commits,
> > +				   uint32_t *pseudo_merges_nr)
> > +{
> > +	uint32_t i, j;
> > +	uint32_t stable_merges_nr;
> > +
> > +	if (!matches->stable_nr && !matches->unstable_nr)
> > +		return; /* all tips in this group already have bitmaps */
>
> It's nice that there are some comments, but there are quite a lot of
> non-obvious things going on in this function that would warrant an
> explanation that expands a bit more into what exactly it is that we are
> doing here.
>
> I may only be speaking for myself, but I basically have no clue what we
> do here :) Something something pseudo merges, I guess. But there is no
> in-code explanation at all what a "stable" or "unstable" commit is, how
> exactly we match commits and other higher-level ideas.

Very fair. I added some comments throughout to try and make this
function's purpose more clear. Thanks for all of the great review so
far!

Thanks,
Taylor
