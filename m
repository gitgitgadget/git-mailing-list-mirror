Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510062;
	b=TVvDqe9dpb6EHjeZW8NTRilec3HgtMHkcBWmo0nwCUgCBAjBPAfZcyw8IIFEeRMzMyci
	 ITtu+Shiu8nP5fDGbLweRYfIt0GVdd9NHEcL/1YiMp6euQZ+skc9l4MiDNahUjepjW9Ai
	 1Ed5gGYZJikKxGaM1Nc+ZoWpFC+Vp25wGLsfQld3yXjYVwyI+MwkoKUOhK3+Vge9fxJfa
	 9cjkgRl4ataUY1RaddX4R+v2rwJJwT09bl6OhajEfrNiohTDx8IfwFmwBMtkZwF5hxkga
	 Jeqp1wTE8sl+UqjsWVGS4Wa091lLNAKQR1G3su9VmoDVAKxjKGq78sxbg4Tn+f0qlGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aL5HDlpYh3fI8ABz77Cyi1PKueVa7lfQidb3/N9cMq4=;
	b=hRKFsAd97nV1Mby+D0isGjfIuKkxGrDwwTFmL6fk+2wsIfiPRgEoK3hMnimxQwGhxl1j
	 Yj9XEQ+Uo/YmebDUoQwDVKL9VwcXD7m3ciBqALNiFPgYr91GKgegIeo6d6BvmqgdI63uG
	 asb4btGCd3v0J//V0oj9kQIYNSG92JbTfDCNNRJie5WJaoXl6Xs3kkgD9IuXfCWejnlvn
	 /E95Ur9rv6S/G6W0yPI+O6pW3zh+l4jgld8aZjRitOaTKgBtGHXHl25+7CbXL6sliXFto
	 z4lnETukx2/gNi+nZdjjxxUTpBKHL2krtnWDZ6xwVe1XeA2dIegHVp6MsxK64A7+8WA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHwUqJyh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21876606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 08:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21876606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHwUqJyh
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b30cbfa628so30543287b3.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 00:47:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795510061; cv=none;
        d=google.com; s=arc-20260327;
        b=LN6ztvhILQZSiADCg3UCCHNtdT0vdYyfGvnU8a6UzvpYRxTnIf8S6CxITl3xZJJISK
         5gBL1fy0jO77inRWq6gzQFo1vpC8zDC1HXWFolRoVY5TaMRnGiLDb2eM4zSNegz2KTBa
         Ee/WLXA6gDLeYcXIhw/avsVqxRbMMQxDqd33qP/X1QaViF2o0E6zc/BgTgRASPV1bsOr
         BuyFVbriw/1MV3LC2sk8PrYlLuw33HkFUEGP7AxCccyOYb84lea4e/cZAX1n69PWZnh3
         FuDwj8KvEWKLEgwZu8hg0USber1W2nbd6ICGXM88XjHw0VVxqeSBtHZ2VVWP8pDNIqOh
         X/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aL5HDlpYh3fI8ABz77Cyi1PKueVa7lfQidb3/N9cMq4=;
        fh=PAjj1C9K1hPPM4TqmxTyFadGtAoFxDNtbjsyY4NMbPQ=;
        b=DLiXNCB2DnAt+ozUYkzpL/gjcuSQIkI5+C/H/w5XsJBVkcrd1KVxSMByIy1LJNGcrM
         7pUbZ1VL9p7G1JylIifCUNLsD4ovbouzw1PjyxAqqcKNsO/GIhl9uERmt91USuoAdB+8
         2KZ8yyHtHPtf0H04z6viKCzGRUmexPZyNfG7Id0kLSEGMI60ik6k2+FK+3bYw1rF8eQ0
         0XI9B5sHnHrdyyzlbE8i5b4W9C6YuzosAHq/mKJRRHUIBbRDaPqR9GxmA+dWtcJjEb2A
         vIMhMBVFqjo0XQCRsm2Yqb2zX4gdvCR6qyfmSNToirh+tJrAfqmz4W25GQWpEF8id0GA
         ypyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795510061; x=1796114861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aL5HDlpYh3fI8ABz77Cyi1PKueVa7lfQidb3/N9cMq4=;
        b=xHwUqJyh5Ij/MRe6k3ydL7f1sDWROcHiUYemo1mpRuwUmy/PfaOlD1FM/K4sQ9cjJ9
         23wDiS4/eUdDoF62eeT5TpxRVxxxARgSHBEsefUwuA9m8R59AfWTR0/jrgLQNyWnLaz0
         XtkBE3IPTqsrookaPv8tce1hYgWzF7xMNrW5XuOcsCZD5iEnZv1x6hRAoG2w/hg8320R
         busWYzRvuwgWW9YoszhN/z5I29gOxq9gPXMqtsJrXFBzB2cTOCnQ8vby490P5Z5gKyjf
         /aG4EPZAGOAX+Q9VUQeEvSPH2fXimeD7hIm+aJbKsTkLqK3TFJPLO3u2oWVbvveM0Ymv
         ariw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795510061; x=1796114861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aL5HDlpYh3fI8ABz77Cyi1PKueVa7lfQidb3/N9cMq4=;
        b=WQm68ulBH0mnu+aYBTO1Nmk4i9zmHBiifwqK1BL3pLpdyZzQw1TUA9dyOEkInZS/jM
         G5ja0mLNQgc9Hf7oZTsdBvSNJug4lniFnJvrNd2oWiwVw1CdTqqmd9TtGzr2+NVTw22o
         eoR9BXveMR39QQfmoqLQxbkFPYyZEKw2xE/ywjimRkTzSX83LHnKSll8KOD3CzTfvP6L
         4stbTt1MOO7+TntIhLoZbsIQUKJpkDIgnpWR5Ohsu3714XrDQoRyYaep127pC5cVChd5
         x79RLSdErd1QKW0DqbsE72fxTbBmyxkea6TFD9IXOxKVRRX9Xi3RXybIElyeMeITm6Fd
         hjGA==
X-Gm-Message-State: APuU4Z+qyBxUWE1WLTznD7HTOZ8n1hmKFlS3NlgIFNzE/kNsVDjgNXgy
	6WBF2eKYPQMoXHWlSvMcCv39axzDNa2HVbxE0GEGfHjcmHyRyxpoFYkSjdAYhQfkvlpk/wuuN0u
	IvepEhLNwPOQwPsiOoMXyUmwuYKFfMlQ=
X-Gm-Gg: AZFdTZd4GfMHAc3oEBkez0RyZ7YUtBFPeTL7nK/w1Fwe6/uYPRFQ3g40siC2xvG/uoI
	/wXtkgRzqx1MSpBp85CVPcWzCsX67Ox1EOKYB6PBA5TrWGuzVsiaUFia6mLLxLOTgOUVuuC4ccz
	EBemIo6HgqFK2X+hTuQDxV+1Fq/otOLadjr5ZtxgiCnIlzroFUa7pb1keN33SfkMFp1JaQb1qLA
	VMLOPbYgiJVT6hKn/foTlvFW1RmK3x0unnt0GQFSfCOu1T9BKsivuC4wLGtBPrnLOjw+tj5w/N5
	KDIk8r+N3kpsEqWYPb5DEYEpfCZTEcFT2wWbsOajC1NEcOPa8YvaDnvGMp/CZam8BajqB95n3zM
	pb2WTEVRk5Iyd6tRLN2eE2bvhmY7ns1f6nSKZdIeFC+IQuVe1XAj0S4ZhChVxyxy5QvhT4NOxrZ
	TyqU5MIKmyPLxS6Mk57EQmG0xpAsTIXQFCwonpmAmQKZiENKZ9uAR89Q7y9g8WwhHcQSf1Cux6p
	ARDzoV+igTB69xII8nBv4j46/jAEsMaCKl3q/4=
X-Received: by 2002:a05:690c:7203:b0:8b3:35d2:c49e with SMTP id
 00721157ae682-8b520556fb8mr51898517b3.68.1795510061053; Tue, 24 Nov 2026
 00:47:41 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027153429.14131-1-okhuomonajayi54@gmail.com>
 <20261103155038.87456-1-okhuomonajayi54@gmail.com> <CAP8UFD31EuSF10wkSAqZxswKVvTG_m-VesbHSXZT_Df-FrqV5w@mail.gmail.com>
In-Reply-To: <CAP8UFD31EuSF10wkSAqZxswKVvTG_m-VesbHSXZT_Df-FrqV5w@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Tue, 24 Nov 2026 09:47:29 +0100
X-Gm-Features: Aa3M54plHmdgVAcmtRF-h2jcfz0T9oAryx1odrXUPD_JAnEp3o9OiyLjoaXz4b8
Message-ID: <CAFpMFfDMvkR86p+bRS1_U_fALzsi2aW-hiuRVG9S5=FseXyWVQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] negotiator/default: stop using the_repository
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 9:41=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:

> This version 2 looks good to me.

Thanks for the review, Christian.

Okhuomon
