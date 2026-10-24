Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792813498;
	b=vNfof8DmwCEA5wQa/3dgF8BOiBfST5tNRxh3TMSUCZFmYjLiJVTmfz82LsyEtjgNozDK
	 j+mJkJvSvX8E3tpBWEe+xPitJ8DQzsUgXehrEO+XEAY/4a17rugA2yar7vqB0sBXF0zZB
	 xM5CgMXm/zbQ6jOyfxWyPLsDsq8euon5M1pZWXRxCF5zmjKJaRcQy0sugM56z8S2+HELm
	 STx/dSg60+NdEFJEd1kZKMh/piLIiPkvOBpthUnlU304Ye76CHUX+wdRBJOIFJXaAhTTy
	 aTsJ/zb1YP7nrpEB+Y60nniUo1IQD+CSoyjjBxrgVR7InG7vNMYL+rPkWHMJBaaTiMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792813498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=brq4MMUn2b/x5PChyDUrIi68kNt0TQ+uDCvzxjSTUvA=;
	b=Bucr368KeOlb62+vYdeUuQy4G8xPHogIQ4DeEPKmvDxFQ1+EzTubSX9U/DRi4IPt8qLu
	 4mai/9lPSqhheOLAGICqDOsq+ERmSArh8aDUophh1KPtIF/I0nILZ1tTrMdsaiScLmTsx
	 r83JxHulyVn99+JKSbQVPJF6VN+t52xPgjxSb5gEdtO7w4oA61Z32DQ8nJSXSwHnFi+fy
	 8A9PJkgcaEN37VsKTla6GPEzSlT5eBmlgl7OE3Bo1taEPkspwFXYOwTs5D+qolGbqtFRU
	 wA2+2xn8tacizFjOmksR8//J5LrNWh0HCPy0rdsMlMPTrR+C9x3ukjUR4T72N5KvJVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OowuOzdB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB6606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 03:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10FB6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OowuOzdB
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-917d595138fso9771016d6.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 20:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792813497; cv=none;
        d=google.com; s=arc-20260327;
        b=W5pDQHCy32rSii280bD5uGD0k4KwXK0CplQZemrH8MM9xbwbSB/Tgv5pyB5a68moTX
         2WbbMb1cqMf+tp7+NclK39yCGEwz6zGqiT4rtRTSY5ljUeJjv4AoenFf5H0RJP3y7fuW
         ZJP8fShX9YQTDeyX1SmXuKbFQJ+WsltpPFHr4nnK/IgGZSE8KlheVotBKFj14Ki/g+47
         QB5PLGPby168GVLObfLsPfjYIowWkPhcLseYMk2ivzVv8wvB9ZS2Bq/G+ZfvPGDaVkcX
         CVraGrdUbqbQB2Zr3JwjrBUUBbAKpPhJU/9EkPodnPlfe35aP5qnnn7OjqHDNShAsE25
         xHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=brq4MMUn2b/x5PChyDUrIi68kNt0TQ+uDCvzxjSTUvA=;
        fh=s0hqf5qUFeDcmDmZJLeMbjQ9NAlF3m5J21XszjRuCK0=;
        b=DsxbUCU39Br2rJsNYAMk/zVXcAYaSrqICK3l2rx2v6SoXQbvv4XT9Hg0GhaNuXKTU3
         oWIRNwkwX3F/WgpE3XrNobTTVDsJdvwLISmmw8H6Yc6veTRF6G7uWvUGCm40Z/1Q7RBQ
         f+UFhFomwvUC8T8TYOEX45ZDt4KZx1il2/taO5mctGZSVGz3dYLzP++a34nCy8ZW5s12
         N4ZgX+TzScB3e27uoML0pgIIkSnuEZWrmsdxswwobQ8BNTRWcUrnvGKZ28FGYVla7WoI
         kNmoZY7eW2z8z1j4r6Mt0uDjFala3bhuHSN9QHugtgKB41utNaxbdMxk3gQKNhtj5gxm
         JsFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792813497; x=1793418297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=brq4MMUn2b/x5PChyDUrIi68kNt0TQ+uDCvzxjSTUvA=;
        b=OowuOzdBwIVVKhBtI1O6SDSfSi2MlABqDCkxWI9yUfVJngsccOB89GQ19UTgDyjQIk
         5W47GwGGX4X7pNyklskvvXcgDXf7cKWrxkqgPg3VbC1gFENNXHhspbrTsRCnZ1zVz+OT
         W/kOj0EqixAWQNcUrp9uLB7vtFxXjPch38VB5unQ7/1VNBNZkyBsNqYkFlIvO+1pv2Jb
         YUdQuQR+TrC768yL30+3187ak/QQzDSeJKNLPimLsT8pG3/6D/V7hL3+Z5mFA8E0wNe3
         YgLyxnRN6taGEr7fBgoG++cImSZhY13L6aG9fMVSA/zrr15Ls/g0iY+5Q0P72oBRClY+
         Le6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792813497; x=1793418297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brq4MMUn2b/x5PChyDUrIi68kNt0TQ+uDCvzxjSTUvA=;
        b=MBrZwYLN05WYRn/XvFCOaIcMelvZQ+dKfntn9fsQLlH7CJNKrSYba8Od2iZPRo0ggK
         2lnh1TTGicOqF7Di/xS+hLaLalNongGHBjp/OJOCv0dVpBj1hjZ4I619LnrtUUUbEEkl
         fjgIwj8f1Kw3qYMRCJ7UsaTHnT+0bJ82W+DY/pQ5iugfY6y620KrKTNabKzQmCg8GbB4
         w+H7BwZMLq4umebP/0gWtoMfsSKdLKlB+Ff0ij72Qzb4Du3DuEfKJR2xobbehoVDJwuB
         JBePukDWcGNqE23jdUL6oTyTH29961Z45ffM9Goztfbni661aqz365pxd58cinDxvk6q
         0RRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwC5jEC6YIQnKvGN/4am5bXhoRv9MPcUUJgpcEn9h1lnzaLe00eAe8AvzcnedvOK+QmSbc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJw7uORaDOig61AyOcPwIZ/qmOpVv7+6YhYBe6pjBqvZkkbPdqB
	dQTer1mfUXswZUgE0nWMbu2DLGzLJpfceeYns2pZSEphYJETzTMgdD26BSwI/Mvi8zsANj8SV5a
	x4V6xyQlME/n4EuhtGCqIDzJogTjVIvE=
X-Gm-Gg: AYBFou1ncw0k7o1nQrNvvnotQN+GwkiqnLMDklGex8hfixaedfH/lDCWB3fpGPp7ADX
	4lAVVtEP35cIQV0wxi/kGGc5Lygxp2f7K2FZnWYxWSuc0RTA9n6Vvy7cGqEcYJTXSVDUPyr9Qzr
	FrydP2BydCbqj7c7BIVpTfq8a+n0hIGZTXpcvy9IObEPrQ+INQtscPRwqtsK9qolMFKEqIF0/7l
	pGzoGDnqvsWf+aqyoZ+1v59ObCAOs7cQePfqZDE+DqfuuXBCnN6JS4diATJsn1joYIpImWaOMQL
	p71MTJ2/UI7+ZhPWCk9nVrfh7u96VcWAU8zhcJrfP7tol1TMuX/PaH5bmFV3/9LCtYwcRkCLDGD
	gmT6hyMqte/IucsVf0cig5tso1O6kA0FsDfewp1ioQZUwwCWZCfTZnNCIf65aVFXqIRvsj/Tk/h
	DYG96fvSk7osL1yhABTw3DOUkXTCq4QYyAilG4BlQDkU+zLQAIY4HZhplKNA==
X-Received: by 2002:a05:6214:4990:b0:91b:5d3a:5109 with SMTP id
 6a1803df08f44-91c48e88528mr16433106d6.55.1792813496939; Fri, 23 Oct 2026
 20:44:56 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
 <pull.2276.v2.git.1792734993812.gitgitgadget@gmail.com> <fe3d651a-d1af-47a7-9b7b-a4ff242ca303@gmail.com>
 <xmqq8q3o5k1q.fsf@gitster.g>
In-Reply-To: <xmqq8q3o5k1q.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Sat, 24 Oct 2026 09:14:47 +0530
X-Gm-Features: AclHuK-q0tvZApDs5UuQXKuh7F16Lpae22EeIV2OVIBEC_0ep07idSW0WDmrewY
Message-ID: <CABh_KWj9wbanf6MSscwfurkgsaSgJvL_tg17sTt69TfWufnVyQ@mail.gmail.com>
Subject: Re: [PATCH v2] diff-delta: use safe integer arithmetic
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 12:19=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> +    memsize =3D st_add3(sizeof(*index),
> >> +                    st_mult(sizeof(*packed_hash), hsize + 1),
> >
> > What are the bounds of hsize? Can adding one to it overflow? The
> > alignment is off here as well, all the arguments to st_add3() should be
> > aligned.
>
> Very good question, and I think hsize is capped at 1^26 in a code
> early in this function, which makes this safe.  It needs to be
> explained why it is safe in the log message, though.

Hi Junio,

Thank you for analyzing the struct alignment and memory allocation limits.
I have updated the commit message to explain why st_mult/st_add are
necessary on 32-bit platforms due to padding, as well as documenting
that hsize + 1 is safe because hsize is capped at 2^26.
I also fixed the code formatting using git clang-format HEAD^.

Best regards,
Srujith
