Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793977973;
	b=WJ9CSfJd0wHtUAsRsZKixgRhd6vfpZvtPYBbZCwXU8tqT0HaRg7Zmig3HRRyLh8QE7nz
	 WQceTQ4JN2Lp6SFoe0vkPMxqWg3iY5Hqaar5kK0SCUqkAREqNVugKey/h8wH1i2OYnkgT
	 3K/VMRYKkCg4yrTuZKQiCDZmDaAS+AReVzO7p36L6t+6+9dhrG76UXyXqOZRfKoAD2gST
	 /zAYeXVNCbG1dLF+mXyW5EKdTmmcEEr0Nyru76x47tVoYTS/rwgYyUOE30jD6nvsk7w+e
	 nJJNjYzBcctMFZUPmQggs5iUpg/vmtSpir0qnhetfTg0hvFh+l4Ku011i2EtkAOspmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=V4i9eAuYO9KQev+QRNf3goj7b7pNTluG8WV8p8VtWEA=;
	b=17RJ/wscbA2bvjwqcj8wNsDhNnPPh3SHv0tg7uUUZQFx0CEX6tRm0Rn1FQgThKY2Dvsc
	 ns4bCQ/j2HCXbQCsujbwhCoMMooOsUpLXwltVW96CtkF69vZPexEzXxm0X+B1NvICvWP4
	 ifVNi2TXz9xcxYMoaWUg02btmsHOCFG4ZXMq64B0nEZDamti/HUQ5vKTggDgiqYSCXaCs
	 bwkL66TwqKaxRLZzGpJEK90oSb7TeCYw21zw9yHgY87RgCT6L7LZHWbmBEL2XKfTyaFey
	 Vs+gSAbZniRp9LJ+/Tk3FSigMGERnXDQNG2J6nA7EzkrnQKL9bFFnu57520/YSCmeAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=FZITRPwM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF7606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFBF7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=FZITRPwM
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c40e30c26a4so154110566b.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 07:12:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793977971; cv=none;
        d=google.com; s=arc-20260327;
        b=VWvVIzT6OKaWe69EY4Mp5Szhmy9R6CjyWqTsQsYUIfbpNJ2M1TKe9smz1b4fYokeHe
         WPV6VVU9K4S8oKJnCTw3J39eqjmRwqJ/eDmNQdWQwEQzLWQbr+4JjP/+tVfTXh6OicpK
         zYWTdTKpG6O380yyFCatiP6D8LvS1tseYdEkKtTXU4gKvCWsm4UTXqHpyVsNHdPyjTD7
         9hXl2EM2oWxDrODZkpJHOr0kH/NrJRLeFy0nI2XZLspH5xllupn4y7I7aSvy9dqDgf77
         i2n4PN9CdpStqKICuVMjpRMFqbtVfpil1e/8N3n5jW2BXJjVonTDyEODe1tSH/HQDuwW
         ci1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V4i9eAuYO9KQev+QRNf3goj7b7pNTluG8WV8p8VtWEA=;
        fh=7CDHtSG+LSrDPODPrdSZ+yURph134Kme/j08n06YFGM=;
        b=LuoCw6JQUY4MUeOoovj1z9SP+m/i0UDodFdYleXBeejfRlTii9bXIuKwBJ1QSfkU+G
         bfSIOEuko/V3nwE7oPZQLQa08fgikUuFiA3B5naC7kci42luf4EJ34Tc37WQajybIBAt
         cKJU3G9aJ4gk1u9C1q6dny55ED1kD/hIItSJO+VWGl3KI5fNOzJphjjuFOQZuKiHwVEL
         7//fWVDXxWl0glTKufjtAfOTLdHWhcdPpa3nCFLwxbwUvNxjI1O9Dfx6C1zG4x5DwrzE
         f6C2He16+4jtX5q6pi8wlAQblKI1reLMJzg5nMLgu98b38nmjuMWBdz2XRNSZHbE8Grn
         IiaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793977971; x=1794582771; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4i9eAuYO9KQev+QRNf3goj7b7pNTluG8WV8p8VtWEA=;
        b=FZITRPwMa3FfsYXLIhJBXGcFX0/MNBtgbwmbNSK9YqLUn0BotD0g7JNNADmu0i4AMm
         FGf3P7oYjG4jGZ8SaEm8eIu3/LxIrEk2ZsJNgm1IQ3dXuSKVOAyORyaaKJWLtaARqsgH
         Afb4G30MM0Y2TsYV2zYNHlEZaASnoyHlaAtLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977971; x=1794582771;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V4i9eAuYO9KQev+QRNf3goj7b7pNTluG8WV8p8VtWEA=;
        b=RoZH3WPuA0kZkDorJ75THh77/S/FA+Erwl3bKNALEFxDVEto/qdxeYh9VGB2nctKQa
         EwTRSdFW3aMbTQgfBsOeXX+wwzefdpbc/sbhz0SoNrLF2WARkkgtcZn4aCEGzsbs6/mN
         kRVQmPZbiKdyJFt2P0c+kQJYUOWHVgpoNyiT5qxIwsNxjBXiE3GvDJ/L3YnphZ/J3G3w
         sDuDM2sLA/jrvZXk9fIRyLigzws+ap4AoUdtxnkz6qCB5O11oQgkps/mibf8aFP/3Ii9
         JqDDFtSh7ykm+puBhr5lZUQWbMCXd0I20e9V7Z67MJxGcaAhXiQEWoozdGTGb7jJmmwn
         6cGg==
X-Forwarded-Encrypted: i=1; AL+hErEs7lETGPr94WdFs+3FAapi0cMvCNSPvjpc7EKT7iHMnBPF8eo0FOJSJ5z1QOSDGI37rUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oIVh88dxdIaLkjd4xumKt47IPr63+YZloWrSSKPO3yXKywsyP
	ghMl+jIogihCLmPER+436AP1qyK27Z+t3TvHGyvxMOipSBsaXJQn+YII3qkiSfu9vhZLxJBAP4P
	sc4GrtjXkaJJVOIz1t7VSOP2F9ToaPTBDSPsK5f3aFvJxrP+J3oTwCeka/Q==
X-Gm-Gg: AYBFou10WCnWtZ0Lz/BxMp8VMZl5VoZAPVofJKU5BdMkcQyuQ3f3QJoxKyp3Qqd+k0J
	gx8JIZ900C+w7kjueJxiYQo9ZfmUjuRL5U8jHfu2Set9Pdi/PlVeZo0MB+2zuOO5cKSAsLjJd/S
	b6BGwBwOkHIQOoE2gcRYXK4LsJFuGHE62IeY480BQ+2TRWZJ+yu7qWI37irUqfzMfLhCM9BYgMU
	l0GEszAjQNh1TyMCzu5R0PScMBhB3GgcimGT41Ek8SIsXR0T3ky4YZMdhHFLq99qxJixv7dEtvF
	BL/Zx9l5NfbI0EbsLQiEE3Rz1vEL96L+GUNLeN05o7ws/yy+sr1Ed1i3I5l4LOVTti4+ePP58wf
	LetXWmdk4x2wOFM0QzqVAH7lePmUmTzPFDFEWxJ4=
X-Received: by 2002:a17:907:d30a:b0:c2e:62af:b6fe with SMTP id
 a640c23a62f3a-c4d35447ff1mr216347866b.8.1793977971059; Fri, 06 Nov 2026
 07:12:51 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2299.git.1793969476.gitgitgadget@gmail.com>
 <6c6abee65cb3987978b982e69f227e408c0bf408.1793969476.git.gitgitgadget@gmail.com>
 <au3qKLWlM45rByWg@pks.im>
In-Reply-To: <au3qKLWlM45rByWg@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 6 Nov 2026 16:12:38 +0100
X-Gm-Features: AclHuK-e0X6v1FWKbEgd27PD1GrxLLTbRCDvChJ4q06PKNFT3SAGF4cYuXhxXRw
Message-ID: <CAL71e4PmJ1an8jwJNRGmU9w_HAM7WHC0Xk3rMKqQFxB_KNTA0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] t5608: assert that the packs involved really are that large
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 at 15:54, Patrick Steinhardt <ps@pks.im> wrote:
>
> > The ">4GB object" tests added in 4b220cafbe (t5608: add regression
> > test for >4GB object clone, 2026-05-08) have a similar problem.  They
> > are meant to cover a fix in both index-pack and unpack-objects, but
> > "git clone" always keeps the received pack, so setting
> > fetch.unpackLimit in the unpack-objects variant has no effect, and
> > both tests use index-pack.
>
> So this test in particular never exercised what it was designed to?

Yes, I think that's the case (though I could be wrong about it).
In any case, I think regardless of if it was broken from the
start or not, it makes sense to ensure it can't be silently
broken by any other future optimization that shrinks the
pack file sizes.

> And the preceding patch fixes a third assertion that we'd otherwise have
> seen fail here, I assume?

Exactly, I would have preferred to just send the test
improvement but it turned out that fixing the problem
was easier than making the test more flexible, so I
added that as a prerequisite patch.

> > +test_expect_success 'setup produces a pack larger than 2GB' '
> > +     test_has_pack_larger_than 2gb-repo/.git/objects/pack $size_2gb
> > +'
>
> Nit, not worth a reroll: I would have folded this into the test itself.

I did consider that, but figured this was not too much
overhead, and made it slightly easier to read.
That said, if I need to reroll for other reasons,
I can definitely inline it into the setup instead.

> > +     # fetch-pack on the unpack-objects path.  This needs "fetch", as
> > +     # "clone" always keeps the received pack.
>
> This is a bit of a surprise to me, I thought that it would apply to both
> git-clone(1) and git-fetch(1). Did you by any chance check whether this
> is intentional or whteher it's another bug?

It appears to be intentional (and old). In the commit ad89721508
(fetch-pack: -k option to keep downloaded pack., 2005-12-14) says:

  We earlier had something like that on clone-pack side once, but
  the list discussion resulted in the decision that it makes sense
  to always keep the pack for clone-pack, so unpacking option is
  not enabled on the clone-pack side, [...]

and the builtin clone kept that behaviour by always setting
TRANS_OPT_KEEP, since 8434c2f1af (Build in clone, 2008-04-27).
So the unpack limits have only ever applied to fetch.

> Other than that this looks good to me, thanks.
>
> Patrick

Thanks for the review!
Kristofer
