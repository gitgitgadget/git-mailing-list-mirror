Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816988;
	b=MbEbnpDz2nWmPJ0l7GGOyXMWjbUOw1Tx3jxNinwAaSHCyDzJa4tC2vO7jwaevl1SzmxZ
	 ggJtmIrVV646UQTrtWJL5ViRDJBZjwJGzd95mt/C+pHkjgB9d0+zQZWOIJ5sBHizhMyrr
	 XQ71wyadGFdQXCuTvUldcMAYaS7es3KCykMbj46sB/oYKh2aFN18HylEGkYIU5+C7pZc+
	 e0QC3iLfIeeozrPYQQTa7+5vhXy4XhcyXkPXdD5EN8U9oZUBWbzT5czt2w4DIO8YtQzy0
	 75AVD3a6SesxJMc0aFugyLsM/7wwdmR0VV2iRZwtz2eKwF6Iln0BveS87ltujnVuhHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=8313CjPtveodkJsRjdyBll5d/nE7ISfUeRDaamRTfhA=;
	b=Ga7A20VHuYpOorXLK7P2Pfd0rrLkjROLPr5uXDGbbJ5o7NyzTepCJ2oWb8qedwgwyR1S
	 b4UJbbhm2QEV1fTj1CIFiORFhvDWaVvyxMr2npQrbFckzWQwE9X+tuK1fmkV669VSalfm
	 Zj8/ia92vvkRBM+ENJU2ZNTwZHNAbekQfyqUmbQkwfBFDo6t7QGjjq5YaoKkDozfI5olM
	 YMLhHNojZXQU4RkP+lPAgbw6lOIZVKeBTFfn3si3UZyXmvc6KBhmr1SBDxGdDb96akhka
	 9opKg+AHXf65p57kmLJMUPh72MxPO0n74YQyLhC8aFVWO09Y7zCwZVnoznV9FhE6wOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Muk9ugwD;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60515606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60515606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Muk9ugwD
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4ced671398so153760566b.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 10:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793816986; x=1794421786; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8313CjPtveodkJsRjdyBll5d/nE7ISfUeRDaamRTfhA=;
        b=Muk9ugwDZPFqznPuIqELDcfE0wY182J5mDY2tEPT/5YLQwltPuKMsle8DP93AD5jTw
         TDXFk0zyHwT63gBgTWqcUr4XzUlC+u9izufhgO//vT/2gfSGLswx01R44egJNB7oaY3I
         iGEznfRkaYRHzoX5oKjAQueJI660JTqmTkoFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816986; x=1794421786;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8313CjPtveodkJsRjdyBll5d/nE7ISfUeRDaamRTfhA=;
        b=T26l8DNk6+a4ttfoAPH+SJCkUYiZoj3CDQicP0f54ib7gPTXzE2xbNgw1vu22P1Bgm
         LchvwHeI6Ki4PRFOv+5NK6/dadg5YrAO33PU7HsJsFlw9YJnYpQsG8qUBKgyLcBFDD8B
         y+So3yxLqix29/mnO+SfAVqykmKlAX79SsugdsEiQ1cZL198CwAxbQFnd+wSQ56yrf/o
         6JLf+Ewz7//bNpaj4cp/eEqryKB8EmGhO9YkUa95Q5Q1FayCcHyHtvBga2ujEgssuwXZ
         Xl0/6RGZse/nfOttbnqDBvC8Aq/fxxpbun/rUcyxWD5J15pe2ePjoa5+22d4S0dvb47C
         RIWg==
X-Forwarded-Encrypted: i=1; AKwUvBz6j5cJ6czTma6kJ05rHNMOwu+UXJDY2Y0tDok/P6+7+TMzkjTf69Xcj6BC0vZXLPlf2Cg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aTQq3JpxeMjLMc/EPBjzlaqtAxnnQOsMA3HXs/QN6o8KVIlOX
	7KMDggwY8L8ElB2cR2a1jdM/Duq2Iv/IxJTYBjVzVRrbU/y6M0Kl5+GXV4QoGMRmRY82ypL7S1Q
	eZ43yOEmnJg==
X-Gm-Gg: AYBFou3ZMn+rD3OjZ5cbE5H5GFdh5lJECAfen+xnB9cs5FWd1ZYdAkGy/g5kpl8W4ZU
	z0LJjt2uVCb2w42OeVO6yBztxQtudZn9vHi44jInrSAiSVUeRvA7F7VYaEX2oQaMc06CFVKNujX
	Me/sWqZjzBsC6RLouinOeQtcD8L4UYp9aArOtLhQWF2iqIUTivyuts36ASe7t8DXWj8cDU6ihBm
	szw+PaxZe+0fk8NDh0i3gfKoIECqrpkBUF1mPUHEE7Z/xN9Vmy0/Yfs64FhrgzV/VAAYdFWH5ip
	3ZL6yG6rfFrXLj1ZLhKzyWTL0IGKPveVc60MX6PbgdKOpRxpHnjH+45Pl4haTXK6vBM3hsvem7h
	TFTEUOnajy5iD56ufGPQ/hXZIxufbcs+PHb3BSjPd0iFSae5CpJscPHjMAtJ3y9XtD5DyNStCjx
	ekPYpRziS5Z0locvu1pca3GH/ZSMx1qwMaAT35bmu0YY2sWXBfSe/jiWEzTxBzXPDN1t/KvYHJ4
	3dWKd5xvLkDvKaGA2BY7Od69nKdpnEbc9OvjVoTDWUzF+Elf5B1WbZfSPubt68aHAnCvjs+5Q2G
	y0GHr1b/MBYKxBsUH5dL7aEWQdTn3+iPQXlXPCgnA1Qjrv5hBkrf+96AWyeS/8HWJY5ZwHRj/Sg
	bvA==
X-Received: by 2002:a17:907:d9f:b0:c40:b477:dfa0 with SMTP id a640c23a62f3a-c4ca7a46ab6mr1371124466b.18.1793816985660;
        Wed, 04 Nov 2026 10:29:45 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e4a7797sm95587066b.87.2026.11.04.10.29.44
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:29:44 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so1289722a12.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 10:29:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByhsY0e7hX4DOkOdREauuc7VkI53GZkPcAvZ9JkXggKGangBsufSUvJ1EjlYrQOpk9Hg2o=@vger.kernel.org
X-Received: by 2002:a17:906:7951:b0:c26:19de:9aec with SMTP id
 a640c23a62f3a-c4ca7aa4c55mr1492734966b.43.1793816984350; Wed, 04 Nov 2026
 10:29:44 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031065525.19883-2-torvalds@kernel.org> <auiGP4XhObUzC9vD@pks.im>
 <CAHk-=wijLfduoJyOM+AW6FS6c02cuEFRAuQWLE+uf7SGhj8jXA@mail.gmail.com>
 <aumKXUS7_x0i7ZU1@pks.im> <xmqq5wyd4epv.fsf@gitster.g> <CAL71e4PqEQkGoont3tL5wJWd1_itsaaxfX+DOkLj64x-S7xR1A@mail.gmail.com>
 <xmqqv76c1mwb.fsf@gitster.g>
In-Reply-To: <xmqqv76c1mwb.fsf@gitster.g>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 10:29:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj-5hp+FZBAqryzTwJ8DKvuNHub2e0kUG3g_+7borFfEQ@mail.gmail.com>
X-Gm-Features: AclHuK-BCRxgIWKYH_BHYNBcFuVaJSg_k3df2vg6ZHnabY9wiH71rap1pcHNrqo
Message-ID: <CAHk-=wj-5hp+FZBAqryzTwJ8DKvuNHub2e0kUG3g_+7borFfEQ@mail.gmail.com>
Subject: Re: [PATCH] describe: count the distance correctly when commit dates
 are skewed
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson <krka@spotify.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 10:18, Junio C Hamano <gitster@pobox.com> wrote:
>
> Unbelievably bad clock skew.  I wonder if these people do not check
> their machine clock at all, but knowing the answer to that or learning
> why they don't would not help the issue at hand at all, so I'll stop.

For the kernel, people figured out what the issue is: it's not clock
skew, it's intentional bad behavior by the gitlab Marge-bot merge
logic. Quoting Sasha Levin who root-caused it:

  The media dates seem to come from tooling too: The media CI merges MRs
  with Marge-bot, a GitLab merge bot, which rebases each one onto next
  using --keep-committers [1]. That copies the original committer date
  onto every rebased commit, so an MR landing after a newer one ends up
  older than its new parent.

  [1] https://gitlab.com/marge-org/marge-bot/-/commit/3fb8ab74b8781505530c21a28ac08080bc7deedb

I have told people that I won't be pulling this kind of garbage in the
future, but I don't know what insane workflows gitlab has forced on
people.

That flag is evil. It's intentionally lying about commit times. And
it's what caused "clock skew" of up to three days in the kernel tree.

People should not use gitlab and this disgusting flag.

Don't ask me what complete insanity caused somebody to think that
keeping the committer name and email should mean that you should also
lie about the commit *date*.

What a complete shit-show.

            Linus
