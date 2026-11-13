Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794579331;
	b=RFUVXlb4CWnzWoGr/DEiO8KnAqsIm0towyABbZKbGbC8w93MkmzsZo/l707oqFWEjDJe
	 xwHO7vWANYO/PIQEY1GrWo/kbQcmL9rc+3QvTjja6YbM0CDMN8dW72mBQwKPlYQ1gksbn
	 hphAfmyxEVmyhznSMCMjPttagXXGyxTAhv5+0cjmlfvwIdVDEcktf8o5rld6rHJbLvnGF
	 +ixrk4c+3+kW+RXWUo11DVrb7I/BTqfG6Mlrd4XuDo2UekVUk+b5P1tSSI9zwstM4l14r
	 Y0b0Rh4XJmShygFtRn2aiyCWhu3XEJSzWyAy4Xm9UN982WrjTRUf0APghWzU0N3xSxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=+vmLGVWUBF00gW7TZMBdreYoOA752bxKK0KIB91OQyg=;
	b=pDefreewgiP9Y0XkZhyj34WB4/vkNlY3LfHgOvN2/4kpOD1m5zySEPbAYfmKbsfvy8ZR
	 7sw0aLUTzciQ7DNkEhCHSwSrOrmV6keEaYxoE6XYwieeSR+kvkez77d8VxzlcfKel15s6
	 V7ihMVQNJYF2EIzxeAd7XdnwOuKAXwWVxtYvV9JC3EudpsPWhAEzVgHM1WeI6DvIl5eB+
	 kTmdrP6iJJOVRbcX98GOjJUGyhO6J1AqNrl3XeiMGREtr8N3RDPUxzJzhzWU1fti00NwT
	 Wz8ErSrFLhfqmMhPepUQGwOB9n89t/qdzaU/gGB2ot/QaUYolQc/FIzNdSt61GR71JA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b="KXBGl/qw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE51606A323
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FE51606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=KXBGl/qw
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c5067a2411bso193892466b.2
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:15:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794579329; cv=none;
        d=google.com; s=arc-20260327;
        b=pWveLI0a45l3ighSHeOQConGIeEtHLBrV1aurr3O/aVGTPhYCKHyI6jwvbL0LoX2Jr
         JG1VNdoTvoaaLrB2Dj7cn2xO5/H0vFto7dY2yZBbejfsJ4IERfOy8Wcbpptwu9OFrKds
         jJVrbDKV0PssoUEpHxBwTX8voGWuxk3MHJ70e/WAO2fboaweiAYwERju+UtK87TjlHHE
         zGERIZ6IN7iC6CVYISH41Cr0nNRQfd8GIG1eR9p4u74oYrTgQhVI1kqWgfVq4QA5wjiZ
         S8JzHV6eaHioqmjX8dbBfLMnjNyrp9ZzvC/3Ht02iGsYgv4so4CvZz8n0Q2BwE4Ou1rS
         +a1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+vmLGVWUBF00gW7TZMBdreYoOA752bxKK0KIB91OQyg=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=sQMF3TKHrWnSsY1wzvcfY0Xw+04ZEdADkrp2J4t/9AduGe3skuNwQTa/7g32z4hDbO
         6z27RIE3tRQdxZAweFsMMfVP0KhB1EI5zhhXYFr84ydqFWBzKwCLvjytWwI0yKErLdO8
         ZTrp67JguEfBH2L9pR/ohnivOezySUi6L+7tG43pXK05D4570arvFCNdNbop19Ao30W+
         5txs0f95mqjsn/fTxPLQZUsziHqDSEVOCBqO3rBzSP+rVvK4opMX3WrnZ8jCyDSyJLvZ
         8434f03nVvuuHZ8mZMRTwnAZIo4FirFmSo5+wd/1fblfKzC1rPUkYVUaN/URENG656Vp
         KhvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794579329; x=1795184129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+vmLGVWUBF00gW7TZMBdreYoOA752bxKK0KIB91OQyg=;
        b=KXBGl/qwN+RyYjWOin+Lak8nO2eDZ6sRV/Fywit+QnrihfOlrjTp2oIslxA/Idd/d1
         LsrmTHdYaoImpDa8BgRukaSS5vxxUQBUG+DbBp6A4sFoo5yaVAFDOvRESbD3fayWCUMd
         cJPAYzX5UPhxGhdLGNMVfA+Gi6Gi2SEtlO+zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794579329; x=1795184129;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+vmLGVWUBF00gW7TZMBdreYoOA752bxKK0KIB91OQyg=;
        b=oOtmrUfCwzoph/o9ABw59w36A1/zXftO1yXpjl79rp3XGdg+eup946n1RwOtYwCUTj
         5lUgqozY+RGJ2isYGizIGEVBRmAhne4NUsbS9c8zJOQxYd+oQHy863Ll3CDKIY4FdX9S
         SK7xfUIkMonFQtO1UpRc6OxHByQXIxvm960iJxYH4gIb9XTT686TJQREBkUoAVVK7h+v
         +53IhLqst+ZbvteStUx01OqWw/96obdH8bx9+wZLeZ5F2nvMk4PC582WcgOmJAO6R9ar
         xstdLJp1NbP4tiFhav8yvEqQ1ddXJ8T6SsrnRpfH5tP8czmwvntzF+iZquEWU6tABIv1
         J25Q==
X-Gm-Message-State: APuU4Z/8hB90V1heoWMI7myGNVlYnTzTHMNVTyXGLBI5b63fKIdvTiBp
	q7FSLX1/0wECowjJaUm2fKchiZt86Yh5gTUzXZBKgTkDLkHKK9+zuw+JEkK4NrxkpLszJXgVbOd
	ODvErWwKgwqSAHRXcS45+tNLYvmAcoDTSINgmRctR6Q==
X-Gm-Gg: AYBFou1brzo2NxjU5PzoNqyJ5j1PzhxP/FLY3nMKfFFxoesXMb828NOf8dVS1JnM49q
	gf1sE+YCwmxLdemJFbpYeDI2ZxYHtwpBF9TWB4rQE8GwKeOF6DEcKOin7SqWTv2bAkgwXwZvUZ2
	X4nyMBGi1Am6L32unejefa+YGsRjU1cqrthAxvTBkP1IZVd1c0cqpEm28aNrWF7ktScpnhP/1Vn
	0KXRbMXAs4NgqCjgnEEIapPxbiOGcFMHWAUYJ/zB2oT+JaKCez6RAkMKmS5PPXww5JalsEvUz9B
	V1W1Tq3/57EL+oxmeQDlnbVq9Cr5G8cJf5DPWg9bssT97ZObWop/XwJPn24rAyb6pmvzeJhJzEJ
	5B9OiOKIp8rVynWvDhv9xBnzwiSDCyKLwBVtqpQ==
X-Received: by 2002:a17:907:1c85:b0:c46:88ef:2e46 with SMTP id
 a640c23a62f3a-c50961d1e48mr234233566b.1.1794579329526; Fri, 13 Nov 2026
 06:15:29 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im> <20261113-pks-repo-count-objects-speedup-v1-2-7ba4f29e74fb@pks.im>
In-Reply-To: <20261113-pks-repo-count-objects-speedup-v1-2-7ba4f29e74fb@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 13 Nov 2026 15:15:16 +0100
X-Gm-Features: AclHuK_WIPSfMKBPeqEC-8UstuOl6FldYtPxwesFPc5IQa61V9V5_ia5Eu6rOMk
Message-ID: <CAL71e4PscLozeuQbwNePkgn=QdDPhE1zqTtuGahnKWDN++B0Hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/repo: don't fully parse trees
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Nov 2026 at 14:06, Patrick Steinhardt <ps@pks.im> wrote:
>
>   Benchmark 1: ./git repo structure (commit =3D HEAD~) (10 runs)
>                   mean     =C2=B1       =CF=83          min     =E2=80=A6=
     max
>     Wall Time    9.635 s   =C2=B1   0.072 s      9.534 s   =E2=80=A6   9.=
799 s
>     Memory         3.4 GiB =C2=B1     0.0 GiB      3.4 GiB =E2=80=A6     =
3.4 GiB
>
>   Benchmark 2: ./git repo structure (commit =3D HEAD) (10 runs)
>                   mean     =C2=B1       =CF=83          min     =E2=80=A6=
     max
>     Wall Time    7.676 s   =C2=B1   0.106 s      7.568 s   =E2=80=A6   7.=
823 s            -20.3%
>     Memory         0.7 GiB =C2=B1     0.0 GiB      0.7 GiB =E2=80=A6     =
0.7 GiB          -80.4%  (5.1x less)

That's quite a nice memory reduction!

> But besides the speedup, the bigger win here is that we no longer keep
> these parsed trees in memory at all, which translates in a significant
> reduction in peak memory usage.

I took a look at this since it is very similar to what I
recently did for the incremental connectivity check, where
the tree verifier also reads raw tree buffers instead of
going through parse_object_buffer(), for the same memory
reasons (I only needed to track the oids, not the full objects).

Both patches look good to me.

Thanks,
Kristofer
