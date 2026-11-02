Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793631218;
	b=HMNg7TS+4cq6cY+YU7CzaruQnekDg4ghPZG6B5RQB8y1gBwJPkMomKbwLhKr1Rhmpbyx
	 PKhDQp6Fl14FFGBxZ+917Kz0/TKp7fMYiUgVDBh1ZfwskmACASZ9ZTZo6F230GsaUcKud
	 ar11N1VkUTiV+t7eNSBLrwkRlR7P6KsboeZeVKN/VrRzBnTxqn6byl+6IFFH08tqHvT21
	 hmJ5haDHH0k1LdTqVGF56oyorOSETYymPI5Yg9YT8P7RBChYeli2g+gDtGyykuEF5mi6v
	 zBYGtWK/AYGLKLjqgXOCq0J5Zag9e9ydj0s49qrP3r5m71WBzoY1qewdKTn2d9mty7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=q/9YJvFJ+nbXAGYeW9C7nzPx050uKYbBSpkeDQgzIT0=;
	b=AV8E+9t6oSnemh7xnCuchOPFE2u0IWVr/F4xtU7hKMkZGaNFOV9mIov7ylOlirYQl1kB
	 uyVlqRjmVmFw3Scy/5NgvoGKbs2N80ek9SdlX60dz+J5vIYptvStW1N6TTliF560jNe/E
	 Ji7CiXUttJA8VkI7SFDROf00ZqCf70uEtSZrx7xszOSjIdr3EnOtW+omrVy3y1b1uhzFR
	 P2g5aZ6lwb2J1Cf2pKfvuPpoKa8Q8Un0rfhFbbO4Ufrixb2PuI6Qa83TuBwCR1Q/JRFBk
	 UEmhCN6tAEnGUAPu8Ei7H5oa1DzM3gycg4p3NsFoHDoRasc6LDZa7Qrn4Ntr2Z5Fbiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dx+Jg8W+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35499606D821
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35499606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dx+Jg8W+
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so4349121a12.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 06:53:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793631216; cv=none;
        d=google.com; s=arc-20260327;
        b=Gh7RCDJQHn5HYKuDGU1TKnW/V45nT/isRXw+RQx2zBW/+B4Be+zIi4UHju5Wa5DbMU
         x1q7Bd/Q/gpsnOyC4fdox/eI2Y4eBzC0Aq40SITpSsVLMZMsrjteyTcfft6nKtY9D9BU
         9eaSL9ychjjc8fAxKo16LNUHgRsn8e20Hoqnp3x7ik3gG3ph5tGHz1ngJ93HQckzdnzZ
         Y/is/91SIDHmLTBDnkmQmisGrc1OFwaFy4ewQaGi7p18CsQPnL9OgDk2M8CHgWFmHY90
         g3VbRo2GgLfNltQ/iXm5eJTCUqS4N6aLCdgfUIMEzUm4VX1QpHgA1WzO6QQcJEl2WXIv
         h5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=q/9YJvFJ+nbXAGYeW9C7nzPx050uKYbBSpkeDQgzIT0=;
        fh=QP5+gFeuOyEMKdtzdgTBnnHDAN4JUc5c6VOv6CUaddM=;
        b=a4/r5ZAcdy4p0qvlO42eYDyf7a+wBsYwqV1SR/I341S9TTEMCJh/HH5zSHdjJXX5gT
         vddAYfKnWqhoJZk7cPo0dgjqtL6XWVhatgD+qG0es8JN5zmpPzBqzNa3MnoerxO/nSyC
         xKjXj5w057otLgumYAgUKagUOZdiPzxuby+rgk7myoGa9deKfT6qnD7oDyKDtNKW0wl1
         TyjwJzpJw0n46t+fNS4RD1S9hHYXmJ7CXPuBOLnmS2nNN4EVEXfK1TYUPNnJTadz85ju
         qsTD1yP/d737EGVQwXsUyVgu2n6ZzaO3QH08ph+O6tQL0o9QyrxweaIEWWc0rdxYsLL8
         yiqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793631216; x=1794236016; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/9YJvFJ+nbXAGYeW9C7nzPx050uKYbBSpkeDQgzIT0=;
        b=dx+Jg8W+jnc2aMT1kL7+7tjfM8y82BfwHjoahm3g4vHI2SeN84Fi/6FHDpfCeYbekM
         NrN2zax4oleDZ1YsvbB/wOLN09w8HJKffYnHt3/klQS1MZdxkx/JaG7uL2nSAeheDF2x
         San6E7K0+JaHl5BiTjTGhhr/NtvlJmYzYO2KHXcj1l7aD5upkNQbEcncQqK/KFriBLQk
         7rAHTnh3o31AaakIWj+pbeKjooapTD5E4nM82oURaOdqBVzGek6I4DsPsr2Gw4bD3DLU
         OdxJb93wX/353iO7vEny1SMcpSC9v2VWoIuCSgMrwb69o/tZQsRS6B8MRPLOcf8ES6Ru
         wFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631216; x=1794236016;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q/9YJvFJ+nbXAGYeW9C7nzPx050uKYbBSpkeDQgzIT0=;
        b=aw/rjFFpGEdVrto8BU6Avx5Y3rpl+/LsnXLLBKoT7Cu1IEg9DWxG2LyFaViAAUNRND
         uciDFqHInwObDaz01Q0E/xf0l9pNnsJ37IaqdCid2ZYXEj96XCNMDsNPWwfgT+x3eo9E
         ApCjBBqis5lWSJEprjoO3y1KkNWeeeStvUPyGlZZYLK/IBxHNZpC5KsPCdvnytcEDOc7
         zi6fcPepocWvrNE/gDyHRSn9UKPjpMUX9vB3iV0h86nNQylwSgJwjcrpbzB32MngTD5y
         bBPAT5x1sIFUx1whseZe3X+cxl878lMc2awZKClXKLKSuPs5/A++byVfDqNgS+DY5OtO
         SLTw==
X-Forwarded-Encrypted: i=1; AKwUvBzlSHcZiV7jrJ8beg3G0nmgnshcMezXOMIoXSMMKhrBF3KhMo9+Jo1BJiuomLcLQkZmcDc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OIuGoA+I9x0pxOXX42cb5IgvNKpiiddAs3aDCI7nX9MuAPSBM
	Y+JoIr2v85NytplX1CJDKyF+2kSfnFIXtg3EODpu/OL0gXOD1UDX4dLjTkGUnXhtBkb8JUpXics
	73teUHzcbBD8M3z+D0+poaZuMp0aPU8w=
X-Gm-Gg: AYBFou2SLz+QNmy+Zh7lOyCh7dyROTna/5QEg3h0HxePNE5zDwL5UFzo7oB+h/ZE7Mp
	aUQT3lzlNfD/lDtg4jKS+/Lo2WG535QmeyMtYC2wq58JCk1ZrFI3MmeTEFH6WfcK97SF3biUhm6
	+qDvl2D/uJzhiVY7C1memXNKPSCkKoPaBZcnARhMacSkAsMXkknEG8dFAcTWfqvk7yMWYx6jdAM
	xdORBZhE8ddGn1GCo0GVQPP9tGAFzSfhoyTHe0OC2iCuKSiud8OICfBL5vwMybFrf3+9Ll43A6E
	etm1RRIl3mFVYHJfwc64O1rWkAkrC9i7+IO/0fiH12ii2D9iCsTTQQpxBp+ofBhwTtOeby4NbU9
	T+Ioos11i2ZT0E7RqkpqterPsdx8G6qPEFL6/
X-Received: by 2002:aa7:da4c:0:b0:6b1:497d:1c64 with SMTP id
 4fb4d7f45d1cf-6b4d5ee7bc2mr5359699a12.45.1793631216470; Mon, 02 Nov 2026
 06:53:36 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
 <xmqqtslzlhbm.fsf@gitster.g> <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
 <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com> <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
 <auiBFhXI_xiBTPbg@pks.im> <50c6229a-336e-4488-9289-183f5ffc47cd@gmail.com>
In-Reply-To: <50c6229a-336e-4488-9289-183f5ffc47cd@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 2 Nov 2026 15:52:58 +0100
X-Gm-Features: AclHuK_u7B6tl-l3jSvGP179dXcg5RSiIi-AGpdbWlpOGzVjAo3wRu1pOm7fPgg
Message-ID: <CAHwyqnUiZeh=cM5b1okrDZoX3HD2MAnwMNp+dnvKFNy96zuzQg@mail.gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow clone
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, GGG <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> The CI checks that the tests pass. It does not tell is if there is a
> sensible amount of test coverage for the change that's being made.
> Stolee used to run a coverage report which was helpful to highlight any
> glaring holes in our coverage but I think he stopped running it because
> it was quite time consuming to maintain.

It certainly shouldn't rely on a single individual.

There are tools like Codecov, that can be hooked into GitHub pull requests.

> it was quite time consuming to maintain. Even having that doesn't tell
> us if someone has added a million pointless tests that slow the test
> suite down - that still requires someone to read and understand them.

Yes, but this is still a subset of all cases.


Harald
