Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E8480953
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374774; cv=pass; b=C1n868tJLzopA22PnqrLblmgbR2n84qJ5K1c1qB45kIHmtJvWfVBeMoCWaahPQeKX03e5Yd99u1cxBGtxw4D3oWmJi2fpbil1sp6Ks8Pvgo6Rsc9KYWhKGRTf1yYhETKGfLXu8MCbt/GNkS1/7mmmb/SXqmh8icpvN3CG8+BkBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374774; c=relaxed/simple;
	bh=2BDlsmeLnR0bDF1U9akvw8/StUf/cFrhS7dz1JwOHdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ReQyC/jamJI5uufpimCwZXHva9/S/zcHPLycIyypF+ALe6wtbx7CZ6YZlXMon9FWdacGFwPJLApdeBTPTzOitxjuuMDU2S50mtnwylAf747+5Haa7Ea9dSjLsZ63on09w92vTr9dHVv3flSTOtP12DSL+iTdIoW7b0zTifsb7iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=DIm0oXMk; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="DIm0oXMk"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-667627ae83aso2586965d50.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 14:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783374766; cv=none;
        d=google.com; s=arc-20260327;
        b=T1lSw+T0b/cPQ2+w0AvOw/m5I7rSXrcV8phv3x8DPdseQVOXfMT1uIn3g5thIlHPRG
         otGXDT2W96mXli14rmbH4BGJPPb6c8yCToI2c8Kd0PktTEWGo3BvejjCiYNESzQ1qkpE
         Hjf8M/mOaa2M+y5bPlz8Qxke/itnsvMLJcCT8t1nGptVmKuTXEfyNFBDOvP9I9fvoF1d
         yQYQj5Prz7yO/QsMct+xZnBWMbanlgo9eFcy3kP+t1wNNzjSNSchRsB+c1zOUu9uhChs
         ArnDzktNsTA12QG+UsE0DzCaEDKLov0Tsds8zP9ZWYHZ6YQvLKIIA8iz8t8ZoLZX8Wdl
         FPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vfCgt7m0zgtyoaY8YXfjA9ldfZfBBMi2V5HS3EjMu94=;
        fh=D7MxG65u15Vc90giVcXohNh1UInsLykXV1FPxfXLKjo=;
        b=CyH7rBjQ/l1uuk0P0+gtcQeQDoV9kZdtseOaO1KEy/p6RXA5wiWXv2ke0pKmsXpN/3
         hcayMZcAdd49S/MgZfUB+50KTL+2W6IN3EgVoGtfl2zBEXhxE4h1LiwBoVWjTWHyqJV3
         +HDV/MQ/NKZ294eO4fRUAd5XvlcW+WCx7iN1zijdNTUQZ6Hd3fIh4y9TBkb47tVLrUlj
         FsI8aw22NUNJXG1Wmg7U/fyz670DWTVfWvIuxsnKfVqWAQFNdPOF0FqVkfArxwzxzGWJ
         EKmojIivIKCkjOAZ6YGrfeuLGFVZO9VYgYpQELezjOqk4XEs0DLQgqtZGbkwKOfJcyyD
         1y3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783374766; x=1783979566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vfCgt7m0zgtyoaY8YXfjA9ldfZfBBMi2V5HS3EjMu94=;
        b=DIm0oXMkzc1QHfZiPLDZFaPKK+jWbfuhaM18c/NtS87BIIFmr7S8BVMW3hO3/wwkfn
         fDa81/cG4myZlqlCyokl3t/XdZBR3mWY5ihCFrXbEVg+Hk2OP+SGaO/6CrQ9HjAnq0YB
         4l5af6jovd6rN8meJ+o9fknZ2xzZOo7hdutcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374766; x=1783979566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vfCgt7m0zgtyoaY8YXfjA9ldfZfBBMi2V5HS3EjMu94=;
        b=k0Zx9CyEdmriUF/xAx51ImW+ESG5DtIv5JIeq5RZAVvBqlId7xjqvI7U8fbnFAvAcx
         LWPp9fySXPy1ccckkEOE9xhQiojclQzSj0j8REeVOLQxPXDPnMLiQBbyd2ujPOG+tnNP
         gSKgT981ecJssM4gXCQc41YjscDRpTIhSRM4DYCFmpKxR++O2TdOgHCulwgSOncyFKSE
         sG2+dh8UYDv9VVOxo4lE96Tyg0e8WbdT8sAC4ERs77wuZZN+Qlbc6hkIC0QHkEXXnp1T
         SYbeG0hYdu7u6/ATk1gZMpfDmIEbTx+ioR5D9TpheUzDgeN5+qRSM/hGq48eE1XdbylJ
         8rHA==
X-Forwarded-Encrypted: i=1; AHgh+Rqv2sWM1xC7/C6T9YH5J6TiWc/g+ijPY0utwVuDLjzGot7j7lO4qiIMZ94cOZTdJWXIDvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUqsFvPT+jGOnCD6C/J370LN8JRtvR248YQ1FR6BOQ28Tdl7l+
	8utBNgYBl0MZQn99itKbzW7duMeEm3Sk9SpdT6Tq3wHK/vIepUup122mCNl7lZu+CRqs5TmuU4P
	yl+QwKnbK971Lt6ljYsL3Ym7GTrshg5sCo/G+k/B83w==
X-Gm-Gg: AfdE7cnCzGilG3BBMUIgoR8aYMddPaKv27z3oMY4V8rxRJrsaXGbExw+d4zbqq4sz4K
	KCRLbETLzFHA6JSQVOs4leG7OUFy98owcXiCwQ4wSn39XRgMxNg72w9wqopgTmp7gy2AraFAcTd
	atbySE0P20K0VxuLisvzIM9Ot3IzbGcYHxpLRmL32rbaVdKgED2o9qQGMhDu+ZXCeqlNX/auB3B
	hUHFTz/TfPU4QT7j0JqUchWE+GFeGnIlb+IuIRsRPviyOyQyphpyFd6CwFTG9Ux/A/j0FU3u3YS
	XI6Bl2Go
X-Received: by 2002:a05:690e:14ca:b0:666:390f:e8f1 with SMTP id
 956f58d0204a3-6677fd15f91mr1916917d50.74.1783374766206; Mon, 06 Jul 2026
 14:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
 <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com> <90270818-c52b-4611-8da2-6cee20628fc2@web.de>
 <CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
 <CAL71e4PV-1aDvn1JnweMa3OR1xxB75fWjzJOBvM54KOWqC0stw@mail.gmail.com> <1aa5b755-0f74-46d5-bd6e-a9cb7f3fbb12@web.de>
In-Reply-To: <1aa5b755-0f74-46d5-bd6e-a9cb7f3fbb12@web.de>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 6 Jul 2026 23:52:34 +0200
X-Gm-Features: AVVi8CfZZsM8bIKJx7E0PtkMmlWRwPybC5ndlc6RPdWwQ9L1dEvj2jF_uBXxhz4
Message-ID: <CAL71e4NZYdpw5cvi6ARn1req8xaRGGg9X4xhZKp6S9Dz4K23aQ@mail.gmail.com>
Subject: Re: [PATCH v2] prio-queue: use cascade-down for faster extract-min
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Jun 2026 at 09:30, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> So I guess we keep the full sift-down for prio_queue_replace(), knowing
> that sometimes we have a lot of items that end up at or close to the
> root of the heap.

The lazy-fold series (kk/prio-queue-get-put-fusion) is in next now.
I rebased this cascade patch on top of it to check if it's still
useful.

With lazy-fold in place the regression scenario you identified
is resolved. The only remaining change is in flush_get(),
where unfused gets now cascade instead of sifting down:

  -    queue->array[0] =3D queue->array[--queue->nr_];
  -    sift_down_root(queue);
  +    --queue->nr_;
  +    sift_up_rebalance(queue);

plus the ~20-line sift_up_rebalance() implementation.

I benchmarked this on the linux kernel repo and on a large
merge-heavy repo.

The results are consistent: a real but small 1-2% end-to-end
improvement across commands. A prio-queue microbenchmark
would likely show a larger difference, but the queue
is only a fraction of the total work in any real git operation.

The lazy-fold optimization cannibalized some of the value here,
so cascade only helps the remaining unfused gets. As you observed,
cascade is better there, but there are fewer of them now that there
is more fusing happening.

I am on the fence about whether 1-2% end-to-end justifies adding
another sift function. If you (Ren=C3=A9 and Junio) think the benefit
is too small for the code cost, I am happy to drop this patch.
Otherwise I can submit a small reroll on top of
kk/prio-queue-get-put-fusion (or rather next, in practice).

Thanks,
Kristofer
