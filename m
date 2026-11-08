Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794129019;
	b=oXV9W2QHrRpmYDvIpYjpvxB1WYHWsbcvPIWdnBzQXYlNQ3UMzsD/xCYexkNrg7+Iiggt
	 Kvs4lZYcfyXJ/0XS0v1sBCTXnQXS+tcg1BE/BwRO4CIImgNBOADiROvBSCxq/yjlllBmj
	 YjaG1i4ecGdxPQJ0mQGvIPt0Oudb9zwbfJMKW7ARFnmchIZrLGuwuuWQdMv3yCtiRAfIo
	 NmVVqJ95maeqYS10tSq2Mfss9AdF8bcdvvVwFYlatsSXJPJHb+axnidkZTxMbIsHoKLn0
	 CKCKx1oK8OZiP/Zgj9QgKIkf9thgFxa3WN2rkEF0zoaUXVtiIAgL1Rnh5V3DopErN8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794129019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=KqIr6pJwcQHC+6HpJxvQ3kNWSbCBnHuEQkPIqO7yuUw=;
	b=Fb2TiNcK2TcHDYve/yohlLeRD8y16rifiqQmiQg9ykKx74s/TfwS3vxygNxWu4ZllEv0
	 Ww+XoLOtCIdl2l51nZYaFIZfyE++qKpzovCalOL2Xwfp+Q6VGpgSoEMPlQoNiCQtlaEwf
	 n0GcileNqvBqZlTzD0gOMLRZAmYDDtmCNx22OTtmj/iqHDtsBfMb+zMo63WHnZ8c0eCFF
	 FHR2EYY14alxepH9PH4ti7tEpBXx35kNsyLxbMUDtjFqL0wimnnWd6pXXc/uVLm/qTzIg
	 5Byc2jU29g/d6rgWAG+GX6QpoEsL9TdrRy4IFTDZZI/Vr8WwtBkaMizVyD7g1QwQgRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=h1tHZYlj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24774606A321
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 09:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24774606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=h1tHZYlj
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d30639709so454666b.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 01:10:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794129017; cv=none;
        d=google.com; s=arc-20260327;
        b=pknrtsFK/NoI4Ayz3hWptFO8mAIh82eAFgfFs/5wm5fjB2VtMIWMAO14tRSBKiQKBX
         cE/1fQDe1FA/DkiUyhQZgQzOSnWD4wW4zgshhz/UovpEgPzB5/vaGWCsr/oGWfax/aDj
         YreV1xFAzwmRZ7CuZbvQGw6uUZCe1r0hdjj9+xHhy78SFsx4z+3boZd0YYL1fwCmc8xl
         iWtZ3QtDEdvtJM1oKKOe5I0kz8vRRkpioLtH3e0azG7dzViB8Roa2wvxXFEQcFWLWNyr
         nXenZrZfYnVdBuxSsy9y2RtF3HXcbhRn1zUZ/zQspcO2Njt466wnlH9L0/DLPBmiGf88
         HUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KqIr6pJwcQHC+6HpJxvQ3kNWSbCBnHuEQkPIqO7yuUw=;
        fh=ANTAhhyR25w30YOxnRxm6P6a3MFhIHanTOZ4+K+z8Wk=;
        b=nALhejSmzG6GHnc7IM3AaaaYTWHMscUx5CqzhwskcGUBUIXzfeiEV6xldRaVF6g1g5
         gTRuiGE3RVueLWxlebiAJaIrXTMYQk+P6ZCJosr209osZ+fwMjgJelL1XKEByXFi+1Xv
         i7Bc9gQHc7VdDXXlbFL4TLy2h9j3CCaocsL0xxfFKkiXIo2exgQP6h8OXYTUPFf5t0Dh
         FPWcn8ivR0RmUbDB74wd38d61KnPMM1m/vCkeui/BDc8Df63XFnP78sMMVMkKsZpaTRi
         aC1PfXVNRFewXrkP53xXaYvj0Z5PlXqHSTftPeP/1SCfp2pX8nL7KXpV1ILkM/L83nHt
         bmXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794129017; x=1794733817; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KqIr6pJwcQHC+6HpJxvQ3kNWSbCBnHuEQkPIqO7yuUw=;
        b=h1tHZYljgOsa0uT52qo1EPgey/nmIvqkgVD5IfOBc/13wTW71MdFTl/NRuOyHHK1pD
         p7RrZsUKXmfTFx9BRL0u0oJPeENXa3Yr5N8a55P04GG3e06UG33nmtqfgeq6htdazCit
         eNFVsLMC6NncHO9FRTiGIa6SHXUJXWaaS2YVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794129017; x=1794733817;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KqIr6pJwcQHC+6HpJxvQ3kNWSbCBnHuEQkPIqO7yuUw=;
        b=sQtcso39uLcnKsk3FC29B3f3+/kjtOkIaCgdlA2J23FDdyDFDh02UZUk2fhAX1sMLD
         lqEajSvW4/rtLKXc3NsT48sjHZBfVb3Ch5i3KkRcdBBEf+jeI7ZrztPCgqvlRUQizN8U
         efQOpwaKgQEEJ8hDtU3fY6Q+hTMXwd4n8hXJrI8q4AzCLdXjYsmxfDn6EiyLLP1SDOj9
         zTUd+Vb7hTAwKtZYGqImD+Xavw/nZPZAsGVeHM8zCoDIi7xR5/zqE0moJiF3gywditPT
         1GAO6U4r8kNlLiLnk9zxPQdeeO1z2o8lHcp1XDGa6D36nPqU4ld6wrdjKkxqwg9Ymfe0
         8axg==
X-Forwarded-Encrypted: i=1; AL+hErG7RYskd7XBfCGY8uCOatbX6T5vNvnx5ibWh1xGsMEwjVv8/HcurMLtSOuPTLe8XQlXQkA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sDvuLe2u98ypG1GStYpYXZxzN5DKCo/kEcIbLiQqFbTaOsa2b
	F5ie6wlO/XZCzG5+6ECqt3CG3SkGm3hJI3hwLKdOTiGx3GvVWXaYdfe9wNR0Vqs67BGpxabmr72
	geGsvBiEP54Kqds1DztMY6vqLlPtHpIiMbxssrMTmmw==
X-Gm-Gg: AYBFou2gmvaIo9TRRQpzNtb5HIbx1rKpy9+Hbtu3cB8jmgXXFW+my5zTKtCfyvSWvu8
	U+iX4u19C5pIuuQ7hygLv+D7iuiOGlcbo0/J0nmLcvfWhV7u/KfW9gta85mASXSrJOD86auJhqf
	e6f5ISqjOQvGwUDymwoOwVnBFXcEZoJe6Eg6Ks3bavGwVFd9Yh/GzBmhtNOLpJ84OAZgPEHatU+
	reRHTDCSYCQuAbMWtPJ+mKxmIydqJxJHj/Glm7P8aF/4VI4CMSOEOvkn3tqSGammMc6IzaWe3K2
	9mGn1ITeshTlVGRebXqmuHnIXdk8AziaTlpyCX7GdSD8iNO8svBKX1gAACBb3nKX9g6QQnSlNzB
	tsc1j8r3rn34KmNOnC5GNI4NoypheraeFRW2+I1hMv6F2T3Ayw9gjAnN8E2U=
X-Received: by 2002:a17:907:c5c3:b0:c46:9ee4:8f0 with SMTP id
 a640c23a62f3a-c4d6db1df40mr68760466b.10.1794129017422; Sun, 08 Nov 2026
 01:10:17 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <b4378b352769cdcc2e9cfdf40efe173123ea9ab4.1794063565.git.gitgitgadget@gmail.com>
 <xmqqwlqo8c8y.fsf@gitster.g> <xmqqpkwg53us.fsf@gitster.g>
In-Reply-To: <xmqqpkwg53us.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 8 Nov 2026 10:10:02 +0100
X-Gm-Features: AclHuK9D7BlT9KXAGIxFuU8Zd6jq5Lg4SRsyqXFlqJ-M2t0tsemxPkfNs3OkTbw
Message-ID: <CAL71e4MiH62mpy0poRG5pSz=GPpoLWo-qPi_inaav9CgqDn5hg@mail.gmail.com>
Subject: Re: [PATCH 1/3] t/helper: rename test-genzeros.c to test-genbytes.c
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Nov 2026 at 05:44, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Needless to say, with this patch applied, the following tests would
> > now fail, unable to find "test-tool genzeros".
>
> Not really.  Even though the source file is renamed, the dispatcher
> inside still recognises genzeros and calls cmd__genzeros.  In fact,
> at this stage, "test-tool genbytes" would not even work (and it does
> not have to work as nobody calls it).
>
> So, sorry for the false alarm, but my point about not split the
> rename + modification into two separate steps still stands.
>
[...]
> > FWIW, if you apply [1/3] and [2/3], squash them together, then give
> > a custom rename factor to the command, e.g.,
> >
> >     $ git format-patch -M3 -1
> >
> > to format the resulting single patch, you will see a modification of
> > genzeros while the file gets renamed just fine, and you would not
> > have to break these tests in the middle of a series.

When using the GGG workflow I think that option is not available,
though I will see if I can try formatting and sending the patch
manually for this one instead.  (Or try to submit a patch to GGG
to allow for configuring this too.)

I could squash it all into a single patch too, which I think
would make sense if we don't need the intermediate state
where both genzeros and genbytes exist at the same time.

What's your preference?

Thanks,
Kristofer
