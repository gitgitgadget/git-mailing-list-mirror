Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5221CC5A
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162197; cv=pass; b=iwI/QN01BIgFOEh6vjIRJy8I3TA89UXZcKJgc6B+OE+8+GLtuD8uB4MbXhf/snllYGkDg0bSPtq7jtNN21fN1QiiWpFvp5QdmDU6Mf7GeYsU9l3Gm0jpHrgjmeMws06mhNJ4EowfoqgENWfR8eLlCVYMdPjX8MtzzG69Nqhhn2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162197; c=relaxed/simple;
	bh=de30YoriCmbOPc0LRrsGFMc68bXBQjO0AZSoUBJu1Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxL12qEtIqNqcFoqOXfErsz/DY+oLbs21ojztemr9GJ4aGsLxnx5IrmCWukFeqpQHr7ijhsH6IcQoyOvp0BmF0qLMGpgkzA8w90c60lQndjSKIycXlforbAdLPXrkhypDavZDcV/NumgmY/vuvcDGtUa8nfg9gsBAjR4prSz2YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=dq7X6ZHx; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="dq7X6ZHx"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6626cd98209so4357514d50.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 14:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782162195; cv=none;
        d=google.com; s=arc-20240605;
        b=B2rjvSevoi/BTk/6LwxZx0W7Q3e154ANhGRlCJlH765QmoIadfnaLrPj2RpSdxtjf0
         2PI+/1AwlQ+OqdZge3RKST6t4WiI82f7eeVKIZmnZxJL1rpZI3LZEOzxokZWHnRBVjL/
         h6RBfNHtbEy7/P0n/IxxHK+gfYFO1k9hMNNxkWXE0tINGo5MxrPHFtkO4/AGncOaJi/M
         9tuu9IrRxAYyKLScDVrqqDtczGBGxT4k4p4qtH8ISbBM6vA1ELntyhEfon9Gi92XSf57
         4V2SNML4rUZXNVADy5QyxHrv3iKWxMkYQblQavbB9FUXPZxhVvnsT88iezE8Z5PTfZHz
         01PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C3uGYu/bvw84ga9cAxXffsq2Ps7GKHcRvhhkrcegCSs=;
        fh=N9vdXATzUjHEU3dUjq/Z0ZOtmRtECjTipPg9fXVWDLE=;
        b=bBijosO2tRhyigGOsAPUNny65AoI/VrW9LcJpRhMs50jX40mgfArGui4JmZPPNQM9X
         fsPG4NND607uS7fp5DaAzDiX8SGKfggT1xyLXCka5ZFXdX5Ss6iFGGApJN6IZTbrYw3B
         BlY0c3PqqOyHKKttuupVwzwqO5vknMO4zc4+SPVzrw8VvW/tD6MyktATyKVFMyX2Nw93
         C7kUbbypWcEHJXyP6IxfnF6uZzGIjFdGf7IAW1+s+IxiBuD1ih00H7IlmP1BOODZgW15
         7Ma0aaj15LouAPUkKQwtj58mrKy2+lpZANpoGjRRChbCiplS4AiCuN9qkaN52GVaJP1V
         hdcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782162195; x=1782766995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C3uGYu/bvw84ga9cAxXffsq2Ps7GKHcRvhhkrcegCSs=;
        b=dq7X6ZHxFyrCBUcL0bENjMMTetA4j7KVgQQ/Qr6h9V4mKNqemkyakykbN15fms0uOs
         bPlusJ6HpSRJYJLKyKDV43Fel492mEYgAQuktGzPwwpxfPPBl7euAM/lWqYMZyd9wOG4
         um7PUwQwIhhflOnEnk1f30KS5mcuaN4CTh+JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782162195; x=1782766995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3uGYu/bvw84ga9cAxXffsq2Ps7GKHcRvhhkrcegCSs=;
        b=SdCCLXrxUVTkcD1XZNPanJG7kdwJTGkKUQ+1yCxR315szIY1ekc3b1rchxP3Da8h4P
         FYxORGrw7WmkGjdPLbtqnavibot2jVke9LJlnJkXOYo2kEwUrPv8zCr2ieuDzsxDKQUH
         MHaxq0DBVu9onrnNaxgwvWBg0BJqBmM1Ze3u+Qwv3dVD4APMlJoz/u2JcgU/XMCI1efJ
         c3sxqkrDWjEmXdFELNWPbtG6DhE+Oh3uH5tN0AJUpMPZQvyBsl6lT5y+4pjKsf9K678S
         8We/FYl6pcT5HuhD6smZTTJR+dBWgrn+0UoHqQPc9bfFd/wu9njLmx375OwE9YmlwwiR
         YLnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCy3KLVn/uM59Bbdl1++Uz8oQWkLj/oed/Evs5dSim1AEkQC88u9emvOgSbrX7n6fNoOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNt8eTrPl9jZlcIqavwq+ekISfwj0LA6dKOMsHdkWFGsiLocS
	5y8YOkueuNX2JRhVMl4eZuVfRlB60SXls2gbK8T1IvQdc1OFRgeYnDzZMu7F/nU8vLTTtLPIagV
	DsXOsTXnJZDYcJIBtzkVyzDjA0LDjF81sWWSZNOXXeA==
X-Gm-Gg: AfdE7clQXwoXxuTmeYrTjgCWcvWTdqFH2esucCPLHQHU7oDPG/C5hkTPOGL79TbTGA+
	cyQ0JO9OzimspWarDgX/xnwV8zDoLIfvAeH7rqsOYW2r1/rlhkp+vZMutHcImi71y/LpwbS1owI
	PBELeFwUlo2s97Kqd6xVN7DR6CrU+mRtawQq6LwGyNAM9JY+XKRZACLsMkWgwGmbOFt4kTzoU/s
	31Od0Ge2WbBfk6o8ORjW64y5UN/lp86vvb/l6OC8Wc8es3tFk8/V7adD1dKSSmUW4x8VVF+5w==
X-Received: by 2002:a05:690e:1306:b0:65d:b511:3ab1 with SMTP id
 956f58d0204a3-662ffcfe22bmr15923642d50.25.1782162195449; Mon, 22 Jun 2026
 14:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <ed12a5cb5b76925cff08d2ab61efeda382b4477a.1781951820.git.gitgitgadget@gmail.com>
 <5c43f6ce-4dfe-47dd-b96a-80de57ecf108@gmail.com> <CAL71e4NJZ9c_=0W4djRFCYPw4z_dkh_ZHEDWBk8cuwXhxT9jgw@mail.gmail.com>
 <4f9cae3c-5cef-420b-954b-d1981d9d5a67@gmail.com>
In-Reply-To: <4f9cae3c-5cef-420b-954b-d1981d9d5a67@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 22 Jun 2026 23:03:03 +0200
X-Gm-Features: AVVi8CfANPCgI9Mh-OM2xvuVbfVmYNIShnNoQXbHWxpBS4rVChGoIFYH71UQLG4
Message-ID: <CAL71e4O7hKM=_M4K9hJE0MH9PdHUHxo7hyAbUSLbyk2wpiGxmw@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/6] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 at 22:26, Derrick Stolee <stolee@gmail.com> wrote:
>
> I've used hyperfine [1] when doing specific performance tests
> in the past. You can build Git before and after and have hyperfine
> run the two modes and compare them:
>
>         hyperfine --warmup=3 \
>                 -n 'old' "~/git-old/bin-wrappers/git -C $repo merge-base $A $B" \
>                 -n 'new' "~/git-new/bin-wrappers/git -C $repo merge-base $A $B"
>
> [1] https://github.com/sharkdp/hyperfine

I can definitely use that, but I was thinking that the overhead
of operations such as repo_parse_commit would be high relative
to the overhead of the new paint_queue struct such that it would
be hard to properly measure and that it would be easier if I could
spread out that cost across multiple internal runs (which requires
a custom binary of some sort), but perhaps it's enough to just
show that there's no measurable regression here and then
hyperfine is indeed the right fit. I'll start with that and see if I need
to do anything more complex.

Thanks,
Kristofer
