Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793312145;
	b=nxu3U2hJZmJrDCeTikRLt9JLFJeFIFHtbdoVMCN7xqBfpdeUWICgPIUoXsp71WLz5ULO
	 K1nc33dXIQVOjAYyG3fUrNb1PHSP3+8JUE0/XxtbPITwvfDInMWo/zdmTX7Uag2dujsJ4
	 +7xEn6ZpsB+xo9ziQFRHkzefhj+VYZrWiabsifJwmJ3q+w/mAOqWxpDgNPavKxtEERTb3
	 m4UD3etJr2zCoxnx5GGHwk8pekCAbCHRwkDLaQFdSvqLIL0Zfz6U1+iwowME9rp8COZwA
	 wfWtEiVgPF2fDhxnhNWxhcx51YmuuC4A/+vfMcUaWTFGsOyKkxDj1rSRkrCEOGqewaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=2PvFEy79OU1wRPVz9yLiYMttdXjNd6XTuyjUACcqdCo=;
	b=V7P8/ckP/O/1IR+VkX+ZvXpG4uBAnupb8HGPM5pX8kVFI0gy5yY5E07KcE0FRolUrWjv
	 iXpKVIqOqY4/yxew4esjnQOYpCh8xsbqjD6ktY2T+rDlNdJU0hk3mpOtNoU0ItUqVQlq2
	 5aQ4tczAaA82t8rNrrFMM90dTxD7q72uMM7ORMFsYDWOqbDL+K+eOiIzrdJpBcHVYKFr5
	 XeMtGU2vWrpTPlGiv0N9MjW12zn66j9zZSoh7obT4UaQ57WsMvgxe2SlrHxpWY8JfzfMA
	 ejumqb1FVG2L81U/sNQaZ3Aui0hJJOM5wc+i97UQws7Ui9y9KLtTVaFF29GsfSPkuzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IGlUi5Xt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3D606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 22:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65D3D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IGlUi5Xt
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c434376dbebso22774166b.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 15:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793312144; cv=none;
        d=google.com; s=arc-20260327;
        b=jt5jJj1TAiPFlb4ZN2Fq3w69tFzgRoAPBrdtSMP7yVQYofph/qxpttdye4qNQVdnqm
         UN3R1mOGqjgR+p0ug9yrF8ZbC1Gd7GGJ6w2LKoNEHVJ727CkzfO7VH5MZohfHxrgXnyL
         eUPTlqq7cybVl5CnIZkEG3d6mov8JduSdFju6YL7LHcDDhTOyKqlYiWeOQOu0rf0Uhwc
         b6WB1AQVeUZ5FMc1+k4WYpD6vINSvym7p4GdXnjh2fl0ecNjMs2iOXMQpSywhvdATZmW
         +mqSpYOz0TnrvcGb6rLR8gajSvKamGOtGU/pU22T8ZY43/QXTs7zqcimQZcaUZ094swi
         gsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2PvFEy79OU1wRPVz9yLiYMttdXjNd6XTuyjUACcqdCo=;
        fh=iwv/I8bFu65XOVw25/qFZGC/634pDu2bQo4RNKvkZfs=;
        b=KnQ65pUuUYTVXelA9fjEXybVKF8yPeii5OD/Ddf0ik5zP723b34IY5r6H8/rtc3afw
         +CXTQ19gQCIt7R5TMMWCa+Fpd5kFxkbMPwT8jltIxfcdhH8C3Qq+ILDmCj/R8Vo/a5Wm
         Pz3lgtxs7iWDoAnglGGBPkvWa7TVrg//yXIOGyWo+Nge5UrKIrO40e/iaXCApXwOgazP
         XIX7ygn7MDhINuTl5aLZ5H2aPd3GWyAOFsKMWnuXcqgYf0X4hjfqdnByvvSyFhSKZGah
         blae02KkgWQE9fFVvA9vdfc+Bk5lsrLZ2kJMuUfv8jOOh6+8u6LwY8Xx+KtrRU9i+Wo/
         Mbuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312144; x=1793916944; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2PvFEy79OU1wRPVz9yLiYMttdXjNd6XTuyjUACcqdCo=;
        b=IGlUi5Xth+B+REI7RXeFLtbrtqmnyOTPq1DIlNAvv54HfqbY1esZ5r/DNlDZJ3FSDM
         /FOAda0pahwm3QMjzQnnNW5oAVvX5UOlNkACn9qtDXQPRz0fgyQ7J6nHBfvRV4DrpuG0
         g/T+2FCFaUkB7drXQ5mB/8fhWkI6ZxE7qsLEuC7XzSUCvQkoA40GGXzladBLaSjRByAX
         RR4vBG9E8PPb/A9zYSQ+YWfI7WFstfLB3uW6FdpgCJa+M/R9yLSTVSZ84TPm8lZ57kpv
         q5OJ9clGGgfFyAusWnI0/w7xJNYoY7FZg1IGb3grbyvx+W/yfd1zTuYJHxJNmYvYwlLK
         DDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312144; x=1793916944;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2PvFEy79OU1wRPVz9yLiYMttdXjNd6XTuyjUACcqdCo=;
        b=1VCWn4Ot4oW9oOFGWcQ6GfFCx5ILe5A7IcxVJAuAWmiE3tzqOI4I6bun+48udpSAO4
         gUgp+YGRBWXnfYUZpPQsoGBMVV92/5p0R+S9TRL7gHWXvjxQzOFarIU554YfFbSKxf2/
         uzUZrfagZqP2YRS0Hb0FMykXHbmfuIeG/ibVXgmEBSrm5/vVqwdfWFeyjjJ61MVXqv1n
         Sz2xLCXKDL6fpUrNQsbao6fXx5iRrrfejeMibrrxsEE1GRH4cusp1CurQ0h7zjYVPEBj
         WkoPd4+SNT2TB+1k9bvTA8sTMJ3i34IVxmyXGrjq+6pAfHMJ9+cZBSmuBGV8AVtP0hAP
         j9yQ==
X-Forwarded-Encrypted: i=1; AKwUvBx466KyNtESeNOqS2p9dn49cR//toSx15NK/VnuwtQh11IvDtbzvDSf00f8jkslhALPmlQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYICI7WMbwWn3B1/KyGRKHWyrcgKWCPo2Wkop1+O8ReO6yah8r6X
	cX6/xuy/OhvOLOJWF7grF0VpQHDl1LJcsibvUYTm4mu/rlEOpWPzvTcti12WlWLlH0tnHmuUAMB
	aQC2UZGbvMGFsz6PcUO+BDjCUDZBC4yw=
X-Gm-Gg: AYBFou39/ShHoTZs8YnnR2V+6yy/eGH5oHzvzByJo/R25NNl4gny50SHHluCLtmqchZ
	Ad17NDKhvkE8O0SMPF1L/ibk0M2tmvHrcZz2L5q2YX2t6jgfyVn0SaGl88o5PaKp/AYXW9539kY
	Q3hX3FUQC5e5j7MXI2FHlwUKrZwiTGU15f6U0v4WCc0fZTSerKZmAiTrQC27NNZqtZHpxW56w8N
	+Yyw4vYuf7DV/kCpfkZVizUyJPVB7IyBhHnGZY1bfTpQ2dSbzqctCDIT2/SL2ztdHod7WuzlrO1
	f9IPjY65pko2Mi/ZVpvXfcSqjLPl0ZBuqSHoWH9QWZ9e6lzO9sn+1J30TGWdos62ZqKKDiFwxxt
	MW1HGC2kqJkQjSW94EIB0c77zMcEo/H/LgtCfc+oNV//p+IIvD1VMAdJSslSu+wImMflSGA==
X-Received: by 2002:a17:907:7f9e:b0:c25:5159:6a25 with SMTP id
 a640c23a62f3a-c49d1285bb1mr367034866b.6.1793312143571; Thu, 29 Oct 2026
 15:15:43 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2466.git.git.1793105039624.gitgitgadget@gmail.com>
 <CALnO6CBxMrv01NMqEPCLbGbCPXX9T2Jgjax-L5s2z9s-eUpNDQ@mail.gmail.com> <xmqq8q3g4cv1.fsf@gitster.g>
In-Reply-To: <xmqq8q3g4cv1.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 30 Oct 2026 00:15:07 +0200
X-Gm-Features: AclHuK9x0L-4ZF7jrXj1aq-hkS_tTgMOjqjjZS_9d7CpeB6xSVwX-IzQ1CWPw8M
Message-ID: <CAHwyqnWSAu6ZqC2HcL8a0HSMKRHZGwvfqx0bi_vRMWc=t_-b+Q@mail.gmail.com>
Subject: Re: [PATCH] remote: resolve "simple" @{push} when pushing to another remote
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >> +                       if (strcmp(remote->name,
> >> +                                  remotes_remote_for_branch(remote_state, branch, NULL)))
> >> +                               return tracking_for_push_dest(repo, remote, branch->refname, err);
> >
> > This certainly matches the logic described in the log message, and I
> > think it's probably right based on that description. One thing I can't
> > decide is whether it should come before or after the current set of
> > cases, and I'm undecided. On one hand, it's a new case, so I would
> > think it should come after. OTOH, it's a fairly straightforward case,
> > and I usually like discharging those early so I can focus on the
> > complex stuff.
>
> I actually wondered if the existing case for "simple" becomes a
> subset of this new code?  After all, tracking_for_push_dest() asks
> where the thing gets pushed to, no?

Yes, both resolve to the same branch. The same remote case only adds a
check that the upstream has the same name, because "git push" refuses
otherwise.

> In any case, all the case arms in this function is getting a bit
> unmanageably long and this block is, with an extra artificial block,
> unnecessarily deeply nested by one extra level.  I wonder if we can
> move the code for "case PUSH_DEFAULT_SIMPLE" case to a separate
> function and make it a bit more readable?

Good point.


Harald
