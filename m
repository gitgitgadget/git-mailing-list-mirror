Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE364252D1
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188726; cv=pass; b=M71ltrA605CABWeCEYw0015wZDrM95Jmt+MkZhUOdiQYHOAc/bI/1xFn5FROL9qcOJLYT/2QubBA3vgEF0JpjS5LCme/KskFyFs1meEDBprgPYM2bCiPlk5UMhJBcbFAZMhajsjJJRu3+pieR/so1fjK2DPZZ0h07pLSiF6sRuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188726; c=relaxed/simple;
	bh=WwzzxfNgRrd4lUdC4TMRoblIfJSuWt3Chzs3kt4j2ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXWohfo8Z5muz65p5Xk4zGok9CuvL+Q8nVDsp4hRLaDpl9X/oe8GcU5p4fXxja9NtrPsClRNpze9uBu4yZKKEnPbmZ/crSF8UQ2z9JRzHEr+q1tTtubJ3KWuG/nLv1LqU55Fu2ZNs5wGYBLeByMzav3S20uIN5NN/aG2YT0HVgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFALis6u; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFALis6u"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a30521ef15so9571261fa.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 11:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790188723; cv=none;
        d=google.com; s=arc-20260327;
        b=N054FQLwxSe+Xn0u9X5YzprbaYuonOgiq1C8VwvQSRb0PUCv5l22Y91EDqIz3WRYZV
         odHTWkIw+n4FStKYsGLjn+TiRYhfOHf9cJaaZTsXsSSYgYpXnR7xzSrCP7QfUgykjAjF
         c5NLHPq5gfE3RTIeZAhs8NmMjiZTA7ARo+0pvAAcS2HlyQMJ3xqllQwW9/7FJ4CIUSHo
         d3u4+yTw1axsy8j3eySUZ2peS0a2BY5czD4nQ0gbbmEWPo++bYgts/XmUXlQ0RIhljRV
         tsjGfehPUimG20CiRMjUIVgGYrWbbrkV5Ap2mLa6OFIZIgsqedt5D0o8p3TvQQV6WQ2l
         ldDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WwzzxfNgRrd4lUdC4TMRoblIfJSuWt3Chzs3kt4j2ec=;
        fh=5BR9BwTvwsykZDFo8vHeyDG6iP3DBd8vsud9x0mL0lQ=;
        b=FTdbcI1BQOro8L+iCzAPFsSNPZWOpwHo5in5zaty40L18+j4ZX4dHSAW3brCFvjnN3
         bV2ga2KbAyZW+2YbbRCSS1HOrI7bHOggXujZdW4oDAxbDDhDd4M0Ucc3vYeFrVu4pglb
         m0x6EtcPzKtQ/nOgH/fZaIPlcRnOmv9FPsy/JA5z4D/H8wlJ/n4woPi5VUxwJM8RVGy7
         PAnPCqjwoaIFmnbWd8l2ZjNG4mej39KFKvxaUQ6R7bdAD3F4P/lx6nuN0C0HtQjH+W6g
         5NtqgLmB1Oi08XaVyZ40zFgp2GQbSWznkFr2BXdb/LBIAQfwjrQG8kKntbx2ytxpJjHy
         AxYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790188723; x=1790793523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WwzzxfNgRrd4lUdC4TMRoblIfJSuWt3Chzs3kt4j2ec=;
        b=qFALis6uK067pNY+r+bcCstczV9wD5N20ZgeOabuudyNqHVolM6KF0yChMkI/AwgF5
         LOn4CzjyMQlBrLrqEVrnmo19nSJP9voRQV26plI7RKVeONTtrvOKCywcQyku34MDbJ7u
         Ewe6PYwJKnyug9Jv8k+lRFU5RlPcrmYDhdFPAQSmJXGDS848SP1j33m00mLi1IaTbp9R
         z5wGFtM2vxbJzvY5i1wduzFewFzG4Dsc3wJnWDXx9LkNprHySABS+86e8nvePUy0ddrn
         AUbTXl4SJ7fSTTojoNUs+Ibc0CVYqfUHqMdf8dT2rkkdatrIPXz9ixM4OTf2+mH4X4ra
         ejqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188723; x=1790793523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WwzzxfNgRrd4lUdC4TMRoblIfJSuWt3Chzs3kt4j2ec=;
        b=GkVogDVSomLahB82ZBoz8F7IWmSTb2NQjUBAd8G4CVAQ2OJwfXAl2sgW40col8f7CL
         etSuEOmrKyYXBctzRQtidq66QKWrcKNwCwn2iP0AbM9oSVUPc9UrNi+T/ocPTDRo/chP
         TknSi5No9jIy6VPXHK0YIvkD6KcnK0HF9mm25Y1Sbo8i1QvsrI/LeovsrCDIQJcCVei2
         0Q/hBt53Ex9ka0RfnWtcm0OELPRVW0MfItPfBKdvExqtMlErnhiVdQryBO8L2NCTavC0
         eFfX8AhvDmCzcQUAILaa9PcX211vINAzNmqkBXZvD3k8wxMVx8UXzi7vIUNpHIiDDCMA
         SU7Q==
X-Gm-Message-State: AFuF++m93as/0BFowyTbitqt+xupw58sZcR5KhfncaN7JNhboP7jaTps
	0koYwTiJX0yHcgpyKkCc9GzfDMjEmK4UGMVjfZ2/lfx38ZDnF/T5H+7EuFhkthU+7m8NtOomgmr
	V0sOyMsTrH975PhNgMF/Z0XtnoekadtHjSfVY
X-Gm-Gg: AYBFou1+hTLK9sC2fnw6UcF8UJdLrz6mqkZkPTCZMdT2jQ2dtMYJXJIgh+8tYIEuLgi
	5AUQGLNpcuHUvN+UzLCKiGvvzlpPQuBHg1yBNtRFkyV75Dq5uEUmSJSMDIjHZnZNw8V74CPPnCM
	KKwqaj4rXKAbgKGxh7pbp25eGjT2GNfxvf9TKFwyb73/sX7MN4LCyGtRmKY6bTeI76vpEFmjeWi
	POiEFUFfPJhd7BEbLrRW8jMJtV14sMtPsBMyaYZ77loAVD15yJRKGiD+FHGbTGgrlmrgNQg5F2c
	ksqlyVJL2y2ucddZdehPtk7f7phJqUE9K/sRT3rgXfW5H3C+k5OzDQuBCx8OpcVxWCq3958drvl
	4dbZK/PTwBQJxCm6grN5Vxi/Y5frnqZagF7sBUEz+S7R20VLmPC51s+a/mwLcM8oR/pepkTMOtt
	UQbvE=
X-Received: by 2002:a2e:be20:0:b0:3a3:7681:6d70 with SMTP id
 38308e7fff4ca-3a63c30522fmr161351fa.25.1790188722771; Wed, 23 Sep 2026
 11:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-ls-files-untracked-cache-v1-0-08db4cc1efdb@gmail.com>
In-Reply-To: <20260923-ls-files-untracked-cache-v1-0-08db4cc1efdb@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Sep 2026 14:38:05 -0400
X-Gm-Features: AclHuK_ajQFpkWvsqsfjPDYEDWPiXQbBJrFXJ_SdLP20F5JMsnO7fEZQ16sqi3s
Message-ID: <CAJ-ks9kW4nb8PFMWj+TDx8GtOwt_fTOcmoGvgqpqw04sNeYkqA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ls-files: reuse the untracked cache
To: git@vger.kernel.org
Cc: Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 1:10=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Uncached controls were noisy; the apparent slowdown in the first batch
> did not recur. Literal-query results varied in both directions, with a
> separate five-run hyperfine check measuring 17 ms before and 20 ms after.
>
> Prepared with Codex, including code review and benchmark work by separate
> Codex agents.

Jeez, sorry about this slop. This was operator error on my part; I did
not intend for these to go out in this form.

The first commit is in reasonable shape but I'm still iterating on the seco=
nd.
