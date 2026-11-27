Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795803938;
	b=zWeUtm1ys4eL16UNrucYgNYU8t6sBAUXxKH8+K0aOmBXKNIw4OEGU+5idz2VAw17nym6
	 BeZ3X2+EicUMF54zz6RQzqDDbk/mQzR6MWWb+zLVoGiqLNKU6GTvs0nNWJvIGc2WGTd3R
	 nU5IYl3IJwLkgu30NwcHZZZM4BSoTtw/1Wup13xB/JeNBe8Wm3JyMdERndjIVqvUcuOlJ
	 gDaWoCKpky2mfWvyjfK+cAWk0XVrfg+D6qu54qESqrZb7vo1H7v79zyS3aGKlHBO73DIJ
	 APUHhH0QRCVQ7/uGLP7k2p2Nhh7B/gnpmlj0u4cbFXhMd9lM14acYShDjDmPnBvS85g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=uCzFf0X5XIiSMBeq+xGgEbRfBy4HhQzS8InaZ2+iTYc=;
	b=lrVa7cEwtSFPKMVg1CsjwtLwxBu3UjQOfm9IqbISZvzHhuDxB4yR3GaX7JPUusPGtVGO
	 Imh5+pR5LIyvbIXLK9T8ETXg/Clpi2EC/KDoiEuZ71G/QUyerMsbx+OAL8meq2hX7MubG
	 49ucqdrj4cC0/zVd4h/tuAOM4nKdft8GHLyA6W+KyU8u0mDUl148ZtWycQvnJL+g2CIej
	 ScJMlMsUG9yjRKGb0tgU+4qvydvYao43M/NVHvn7hCE0EwnTgUNwjOe6TXZPYW/jb1JSy
	 2bSjhVZmpb6jf1sQKaKWKfjvUDcrLGHM82XtyD0IfDakZnTskX45Ek6g4j3bso96yAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ss73k83v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62E606A31E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 18:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B62E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ss73k83v
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bfbc67991cso5761536e87.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 10:25:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795803936; cv=none;
        d=google.com; s=arc-20260327;
        b=CUfUZB5PfL2vOCdh4NHy+/T/4ij23VFmv3GZxVLIqerxWnVWSgpHavZIzn8xvookxM
         dzXTt5Ym8Ftv7rEsFL4v+OZvMkA7iU9nNo1HFwET30fa9Irw2ALWrKDBDvOIIeKwqFV4
         eWhUb5bP4aqCAafHaeFuQQqzEfD65/Fu/LDnqWNTQQGpu6un9s7KuZsgvPqaErSU4gDO
         Vb+KULoKPj6IrsF5folB5dDPy3QR3TCu/voXYcwwPn7dozcAkUB85ULqFMOUrEH0ziUR
         qG1I0A9cpC/k2CyZc56DtHSCPbfBce5TyK99mK0ZnFcpiIa/tZk/+bi9uDXQpkLCRPJl
         +Avg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uCzFf0X5XIiSMBeq+xGgEbRfBy4HhQzS8InaZ2+iTYc=;
        fh=sPTNGmjnvKn5n8onHLoZRwwrnRiiwdfyqGsiFkptxd8=;
        b=OIDHvsTdEbOSV6m3NmSWM7dJMGyQVUWzg6Bqd74Uc3VoXIwUfAXgMZh6OUoOqudJ+p
         xPcfVpIXHKuu+zkaqqx2o5XEvcFfD81KKTkk4xRaT1yQ5g2HBqMX0fpAUvyXijwgnK7t
         HyYZtm3185oeSkj49jO6kflEXfm8czRQUhKROryw2vyQv9/+XNZb8349dP2fLpJYm7tq
         IW3j3/D31LR95z0wMybmdGfrArSto1SeHdtIcnn6P9bkAyUZrT0bxUzopCwhFoJteonv
         BaZ2YpH/qmZKCeQI0EIQ44r0svJqJIeUeR9oq9dPqu7emXZmi+2eY8wxUqZyQZecUCHt
         O65g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795803936; x=1796408736; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uCzFf0X5XIiSMBeq+xGgEbRfBy4HhQzS8InaZ2+iTYc=;
        b=ss73k83vH7OiGh06tMc/qUHexEAgi1o53QUktFxNhEf8TfxUjsKD8X9Tdo4boKZ9m2
         nQVHK3zTYK1wcs6kJPw1m0wwMrX3Upja3W+gKACZnCtYOOBF1rlO6O0iNjaglJmggxrI
         Mx3OIASkSiPof64/5Y8gyBH37apfhVhO9N66aNamXh5XvVygkboR9WuYHJvESi9WhLJI
         o1PoKVVuXZVnftb7YhiULk4CBBFevg6XMYn1nMtlzEtAQ0I44+OOreoHvs+CeRCA7UgK
         UAWJcx61AIiVSmOf62+u1sJFIfLfAuQBuWzJA2UjQ1E8J0TqxpadPixSj/hJBjjWTgIr
         MIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795803936; x=1796408736;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uCzFf0X5XIiSMBeq+xGgEbRfBy4HhQzS8InaZ2+iTYc=;
        b=KZuTbH9O3mAFFg4wia1jqqR+Px9RPccmv8TUHlieUpfiKghPy3k+GX346pPEqw0m9R
         sl7WD4lbhO6hWTVREWYAL9yJls4bGoeAJhHsLWSHAnw9JF3MJUyhoQeyFs/Ny4mGHOYg
         Bx6IRnedMOh9Qktqkz3wqGboVSfNOaOaJwePn/QQoKFDwOEAZQmXzx1a5PEGUuK7gZ5F
         OLQmREq+4wyBouoPE0c56rpWG4wzwJX7rqO7gtSBEj+VSU9qJIvfPHkm5PURHATTf3v5
         kkeOLkcZTKwQdcoinhHTRR5WrV3IJ7V0AlJWTCLRnCO/Ru9LA7kV48KzCNTuSDfnMpZH
         NTEQ==
X-Gm-Message-State: APuU4Z9LNUDlXT8ombL1Tc9spla7IUaQCS72CbukFVgg5rZnTk47mJOa
	NxjCEaZMbxqrBdYBJ2MlDNUBZ5gY505PrjYqe0hJeRpaLGP7xGxujILjXAuisPmI4E3zm/gcSSb
	4Yct2CPUHC9O9J/lpyRJy0HktG8Dh8+CDn4lH9OE=
X-Gm-Gg: AZFdTZcK1UXnOsiTnPE9fnXPrWNQgSPXp4EX0rtiJt57uAgEBDzjcLaWXWop5cEpYkm
	arf+WDSyhvu6BD6y3Nezu3XoO5A4/NAH0GZ6B2ye/GGjDehR1dCG4LVc7PNRuP4wf5QfQH2oPTq
	b2yYCETeonJq0X+hUEdGhasfmjriLEP6htH/gzzOZRLrkhaQBz1BXKw9OGvsRoyfC4vi6XnOnGT
	9qeMJqbYENMfIwvZhktwW2181rbxDuTUohY4i8daPvxR4+1yhVM4jYF1vM4+i5vglmuEihBF22a
	hczxMi4hQxKc4n1aL0TOXegfKPvICSI4iiLTp7y102LLZdyGQ82Zj/sn6odSDF6DzYT8KUT88Ew
	Oxt+Wp9yd4chixPv5wPabv/j8+cew9h4FBmI=
X-Received: by 2002:a05:6512:131e:b0:5c1:5b12:1f7b with SMTP id
 2adb3069b0e04-5c1bc844852mr7649522e87.56.1795803936228; Fri, 27 Nov 2026
 10:25:36 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ee7de58093c69fbbab686a68b5b781bc60d90a2b.1795798429.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <ee7de58093c69fbbab686a68b5b781bc60d90a2b.1795798429.git.phillip.wood@dunelm.org.uk>
From: Nahid hasan Sagor <nahidhasan141400@gmail.com>
Date: Sat, 28 Nov 2026 00:25:22 +0600
X-Gm-Features: Aa3M54ooPXkJvYACd06j-2HiHie5RNnZEZ_Ch-HSsRYf3VSm4y5g_amoI-bP8jE
Message-ID: <CABQNq+mnfJKohF5F4aQZ8APZk1bvOKo0F6e4FPrMuBvG1CpanA@mail.gmail.com>
Subject: Re: [RFC PATCH] quote: make sq_quote_buf_pretty() prettier
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Ben Knoble <ben.knoble@gmail.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> +       /* '~' is only special if it is the first character */
> +       if (*p == '~') {
> +               quote_it = true;
> +               p++;
>         }

I may be misreading, but I think a leading '~' gets lost after the
'p++', so it never gets copied by strbuf_add(dst, p, q - p) later. That
would make "~foo" come out as "'foo'".
