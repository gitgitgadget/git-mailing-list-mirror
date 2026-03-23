Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E795474F
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 02:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774233222; cv=pass; b=dQgLlZXsx2BauQe2W2XnmW0b7wd2lAOyPZH15E79IwkNbrN3If7Eqi7Y/2FwfEucULt7rt56Tzf4izRqSi0gZrMBK2dTt1ImA7aqPPMbs1RSwfbyOeBGWMkj2LgKfHcCW7wlSaPccGk+JJU99dJVBYH+Q3WX4EqKlKtMtIRjeZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774233222; c=relaxed/simple;
	bh=FXlGgM2FxsyLjTU8K+dbxj5KFvF/js66Zbn6XgyfVD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlZhRciIMBevDn22HzzRpSJfH1iXPnCQ5EQxv/QZJ90m5CeTkS5C2Ad7lgpDoYqjUnFU2nY/OcgIy+HeWZz8uwaoWKtMNf5q8V2tgPvyJ6kehVPS/fQYyzUWYZzLKirJqm3N74Ys+6dTG4m64ZPYraR0J/K3XHBa3JFIa7Kn0hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RV5rLoQp; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV5rLoQp"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ad79df972so2835279d50.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 19:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774233220; cv=none;
        d=google.com; s=arc-20240605;
        b=hnXiCe8sc6P7JEWyYK3fsk2fF72mBHUQvbI3ANzw/hjb/6ToIIfI/ZvoNSVqhm8WWP
         xQ/86jH/M+q+Pa97HoypgSIx1/WP4h2QVQEo6dlo4dQBbqoXwQ3nTYZVV1pn34908HRI
         UyemPGgaKRCiQQlhzo6cZhnCInAbKaxrpy3/C99agWvFMxiKDU00/jHAaZe+Sl337+S8
         dpwKlvf8KH7Hz8BRMGNjWiggV7Rrg3S08WYVDtANe+X4CvD0drdKPWPsJXRTbwD7dIlS
         RYXnCf7vv1oGZ7OY9Qa45wvCZWu7fxt7ZQggDjRp/RxXwKBlhmq6TGZaYlWAcL9BAxxB
         wxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UBw/N4cDhSjx34sQ2ikdEm+KPZwAiysNsHthGMxtr3w=;
        fh=03HLbGa0e3psWcJheEf5VUIwRHDfcnEAToDnAmqBNcs=;
        b=BcIlMD5aFB8EqEL0iyCoGt5dBQwNnb7K3IaHkNZj4FxdlhQQ1TmFg/cO9TqJX9y4Ks
         RJ9pU/eHmlb8Ril/lypuL5rpk27zwjTC2gsCN4K5UE5gvVM4cq3NaVtImIrfEN+RpFCe
         Mnrq+d7hXnctV8l2fOar/p6oTFhC2Ctyp570d0CP/I+DZxvsCEqi7SkoJwqpBklHADGR
         fG0UcX+j1K7mTe/iM3OgcmE4fWGA1fBRPs4km/d6DJXmPLTh9+xWAU0bK8clofQrlrcj
         keAFckahgz0Al3OViDM86/loKv2py9ioa4X+AnKqm8/JigvCBM59K0mg4Ecpz3Z/f+wj
         WT8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774233220; x=1774838020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UBw/N4cDhSjx34sQ2ikdEm+KPZwAiysNsHthGMxtr3w=;
        b=RV5rLoQpEBrniF1fEMW05YaubKSb5VCtCIztcq7e4GXOyOHj4TLPTl1pevHCX1UcVO
         X8YQlm/VcVW+FEzkKpNYlGDvlMtSStdH8XUFmkTFp4U5p+FGMmLbcpJxQXQSpHRmIcPT
         wqvDu/ezgop4ybUGixPDu82nLIVW9s29/iB86x2xogKYtgeyLOdB/MlYYMNxFiMNWBvw
         y3UoM8VT9Ao4TCQHU/HUgCCXp4gdX2IzH7me2N6OQ0HaVLjjPNcqbrx9rsbrTYjOZuIG
         uxnUOdkk3ZVTpx91xhX1VHPvc286OPzskzudHRrTLroIpHQy/miZLgRJqEtJrzbepuf1
         dtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774233220; x=1774838020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBw/N4cDhSjx34sQ2ikdEm+KPZwAiysNsHthGMxtr3w=;
        b=RU4QfbMARhSJ/V47grwFdsOwsjDX2ObsVaqXpK0OtBk7RsrubgieSoJWgAFemxgd8T
         czUUQM0W2l4NdLDGNHwdKnXcxQrAECEVLKxBzLWkJjQV1X2KGH4DagyRkSGJWmF+hKn2
         MYD/1GzYxhh/H1tBMiHE5uYAtIj8eLmJA+SD7/kkP/taQDcp2xrBZLX1yUPxLqe7I7fp
         Gs8OAWgpZhAp7vSFA7qdecAEo2clE5Z7U8ZRATvGWVjaYJsISsjVKGt/NjHl/Iq0AYtE
         LxhrwzsuQyVRD8AY/1msmEqYEU40W6qfGvRpj0Y5XVaTn5GsSVQ+jFjjIFazjnV+tPLv
         6uQA==
X-Gm-Message-State: AOJu0Yz1yoOaQJ0tpH1PlJbe9sl6HuwlH+41NNUDjx7Ao1mTTuf3EXmS
	kcKbVVTQXbFXMXrT6qQn8Nv1jNVgKv2CrCPMC+H9eKfbcvoiny1oBUARM/+aleZ3i4n3cJou/Ml
	UPKrAccnGuDfwiN9GCK/mZey3SyM0QdA=
X-Gm-Gg: ATEYQzzo+o6gS5eyWInD/kSuIGaj1kpuN7QhKC/19jqxbWS4CBd32vA/ikme+7YQyvw
	6CX5jArg7C8T0yX8eZkmhh5ZgjXifbN65Gj8/KUPnNNJyJkNnmTTH5dX09UGEpvI1UZS1VxmO7x
	tAWGAaocQD/gV73H/Km0Lvmtdm1DzkmJHDb/feCb1cvhClCGnuXqQsmBlvysTL4dlEZbw+htYt9
	puaEdxuRpmZbDXZRGsWpKj+3sEkUiyhntrrUiVk39N75tzBfFwt9eZvzElOCcDcD8SEHMgKgBOc
	0ifoMRogtGbPQXVkfnPsJP6rWEb3DC+JJvXGDQO8fml8N1Q8xHNPO8rWQ0gCOi8ludl0Vz9RZOS
	XuM2WXIyAgP6lNHg+O7F/Vwg=
X-Received: by 2002:a05:690c:3346:b0:798:244:1fa6 with SMTP id
 00721157ae682-79a90aa328emr117844197b3.4.1774233220034; Sun, 22 Mar 2026
 19:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260322203801.637769-1-pabloosabaterr@gmail.com> <xmqqeclb7byr.fsf@gitster.g>
In-Reply-To: <xmqqeclb7byr.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Mon, 23 Mar 2026 03:33:25 +0100
X-Gm-Features: AQROBzBQxKDgIHom3_TXQUxgj1XogP70JZqG8h-_I72bTwkHxieGCQ-_nqLTDJ4
Message-ID: <CAN5EUNQ8rnBAezRLgATwotnw4EC--EAa3p+52nWb4KCtB7uySQ@mail.gmail.com>
Subject: Re: [GSoC PATCH WIP RFC v3 1/3] graph: add --graph-lane-limit option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com, j6t@kdbg.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano (<gitster@pobox.com>) writes:

> If you have active branches, whether they are merged to some very
> small number of integration branches or they are left updating
> without getting merged for a long time, you'd end up getting very
> wide output from "log --all --graph"?  Or is this a problem only
> when these active branches are merged and having to show merge
> commits create the need for wider output?  I cannot quite see which
> from the above description.

The graph gets wide based on the branches active at the same time,
each one occupies two columns, merges don't create new lanes.
I'll improve the problem description.

> The implementation detail that you happened to choose a C
> proprocessor macro instead of hardcoded constatnt to write the lower
> limit is not something readers of the log message needs to know.
> They can see that in the "log -p" output easily.
>
> What is more helpful for readers to know is what you mean by
> "graph-lane", what you are counting, and why you want its lower
> limit to 1 (instead of 0 or 2).  These reasoning behind the design
> is much more important to record to help future developers who want
> to fix bugs in this code or who want to extend the feature this code
> adds, without violating the underlying assumption and design goals
> of the original author (i.e., you).

Ok, I'll focus more on why, rather than how.
the minimum is set to 1 to have at least 1 visible lane, even though it could
accept 0 it's the same as not using this option, 0 it's treated as no limit
and I found it better to not give the users the option to place it
because no other option
seems to behave like this, so I thought the best would be to force the
input to be >= 1 to be valid.
in v4 I'll make sure that this is clear for others.

> This is "unsigned int"; don't we want the other places (like the
> on-stack local variable handle_revision_opt() uses to parse the
> value from the command line) and the parameter used in
> graph_needs_truncation() helper function all consistently use the
> same type?

I saw that other options like max_count, min/max_parents use int instead
of unsigned int, so yes the most consistent would be to have it as
int also, but it would make no sense to have -1 visible lanes. I thought
it would be a good idea to keep it explicit that it can't be negative.
this examples, max_count, etc were the closest examples I saw, but
parse_count does return an int so i can't cast it to unsigned without
checking if its neg that's why this

> int max_lanes = parse_count(optarg);
> if (max_lanes < MINIMUM_GRAPH_COLUMNS)
>         die(_("minimum lanes is %d, cannot be set to %d"),
>                   MINIMUM_GRAPH_COLUMNS, max_lanes);
> revs->graph_max_lanes = max_lanes;

where it checks if it's < 1, now max_lanes has to be > 1 and it fits in an
unsigned int. But i do understand to keep the consistency and
the coding guidelines, i'll make it an int.

Thanks for the feedback!
