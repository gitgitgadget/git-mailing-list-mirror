Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794415715;
	b=gjywyyHvGclZqubHq9pdy2HfLvGlT26gH21y/0J2J5mSQMniY0/7AidL2aZAUwWm+ocq
	 vpie86nXqGKL+uUiiX3oeWMWfisXY2KKW0Svzmn0PRyepERUNgEpAGC6TAPs2ZDLa/hNH
	 kgcA3aW4vlCs0LXbrJfrSfVuaDGlWm8Cdy3KB6qUG7u3o4SM7ih9A/Niaty/UybSNq+a/
	 Nkc09tD9kjsqOBfR9iyA3j44GcOIBqSA+Zdi/TQ6RblcMhEDhXvwyIe8CVYLygMqYYp+P
	 Izoz0PKOsI1u1sdK66n09ODxyZXaSjhWVaSoSA4ZW1S7ilxF2gtSR8SVaWOltWdRMlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=EJWSL2awbMKoN4FvB10Y3GzY6+n0ylfWshG9/qey43I=;
	b=BoWbM99G3K0mf0zsJCTIMKuypK2dSSWAlyeAn+qGsuCvYRLX2HlIKudI48qG0F6/Pq3z
	 AHN8IrcZGkwFCMyiAWex841k4tm8zbD3JpTHAC5G5OVh8+YUoxRy2oXGRdNXFAFnaLYyT
	 43SgbE8+TcOe8cMeTX6hUWjtaO2W5OYVFI3R4ovFXmckYh/ZRTgMCBw+kznhZHS6yWtmA
	 27ie+xFl71BxmC6KG7SWYe+3buvQOAqiYr8f2tedyPBiogtbosZPIVWrAMZ7owwgDtOoo
	 CYJHcm35TQXGL1LcobZIvc8+YMh2fscfdwHa4uRntEjkDiLNi4YIE5c8zaTjmIO3tmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJZd9eZM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A044606A331
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 16:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A044606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJZd9eZM
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-998d151f441so891468241.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:48:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794415714; cv=none;
        d=google.com; s=arc-20260327;
        b=MEzsqE49kCcxP2U6XAMJZoRDvUYK2Cv2GMlBeKZt9nWSAUr5EXcFIoKaEqXbhu/XPq
         nwszIo6vDDN3XLvrmHhlG7WJZVHzfS1h5k+PQwowYt1Ae/xe7rYE9hhG8anO6z/Vd37x
         22+Px5kdcq2+HF8Z5LCIWi4joZIX/TYz5nWY749svahGJ0oOdB/b6jiHbPlq97Tu75xp
         5mR/Y/XRsfwtxxoM9ffT+En7t0nuFIBfcBWzVbEocG7OVg3fOU/LtOHAHqjc+FgOOaIP
         TzSn9teF0vy6e5wHJTC3rnBdyTffcOLoLlJwpZyQRPLvCHpvVu1aswR0h+qC+foQ8UyL
         6vFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=EJWSL2awbMKoN4FvB10Y3GzY6+n0ylfWshG9/qey43I=;
        fh=wBc5/Fa0spMzP86/M5t5NqzujSWlhgygg/9lbvbMQck=;
        b=Gp62VPGCtQp3Lf1PDF556MtzNULtpUYbjpADx9ZLjzyndNmjkzvLYt5ILcFW1kuHK6
         fS2Bikcl+ng0nQiYq2hc5Jiy9Do5DTvjXWyhW00Foqgje0f0JOzEyQuLXUluwV5sk4Ll
         GR+EB85hXZFD4Dps9JhHG5vrkFDSQopFqAepX2R/LWAU2F2q3y+jl06lCLEjkfBDThXd
         F1JodK5w9OgmGbOoTpdsSkqBjJzCtXjDK1FIf/DBX5Wf9Bb1KTwQzaam6554liZ0jDhc
         myO0F1RFGb2bfIHeI/mB3KnQ5V3y8Ht+HxFEMvYN8zHBxZWFSib5VJVcA44PPTuzqh9R
         NMkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415714; x=1795020514; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJWSL2awbMKoN4FvB10Y3GzY6+n0ylfWshG9/qey43I=;
        b=OJZd9eZMbQSRgY3iHF4NxjdTZToEBSlqtzoY1ok0ItzFPB1GmE04bzgwGQGzzbPm03
         YYjYLtQoyDiB2nCY4/ATb2fXhI6g62+k9AdeT44ta47RoXRQbjVCEqy/MgfHnJ/JZOJp
         5UbNp8luwbDP4y27fN0AFjfGQ29754B6myRM93Ej3bIeOemJM0HAF/hH+ZgEHjL4g35S
         RUqaPKA/t6/g6ud6myKIZMktSQ8r4A8lZ+hLDEu6lVw4RySNgajlcvEBajRWqVbaB8Yz
         B0UawfaXyw0BF9Xf5UnA9GuNKAOjEjYgfrJoCNf8ruYD3C44tTywEuYk2qX/rOxOomXN
         0GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415714; x=1795020514;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EJWSL2awbMKoN4FvB10Y3GzY6+n0ylfWshG9/qey43I=;
        b=hVzb9VpXaBlcYpa1Z0piqxIAfj7O6fe3wfyyMARebCYlYkMAP7KH/RxuqUty7wFfht
         5nh5WQygqRrPVjVXhNvRmhHGA337X+U5HXz7epx3Et+prMTPGkOb4p3+yx8+ML69QVsn
         SyFrH6gds/yJ2/7e7DKX8edXhn1o+2rDpxmLsXIXhLlQHAenKlWTvYuTm9xnaQMnQVd2
         qGPsp7b1tf5euSl44VmNtkeGEg3cF+vtT4Pl6zolHoLbN1xTnKItrVRhb5cmYm5R98jG
         yWUNUOAdSfbRh2ZAOgHIip/4LgOPgQdKVPa4L4N1jTzEUfOcuCixfBMbctkhRZRv1SQE
         DnEQ==
X-Forwarded-Encrypted: i=1; AL+hErGWmSv/DBdoNlWqmhLGulsFOfWNTF4RpUZEDc5tRk5MUdPLGVdXr+0LOVVm8OE4+zF+eIs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+R3gjUptXAd+USEhC1BYPXrlqlIk4Az3rYY5tuLDBRKtj9/WgX
	Nih51Da6N+U8PZxZvo9N/oRImiFt/45thqBkpEoA1A3XKJNS6n1MyT8wGKpYNhqozozt087A3Yh
	5yrD+439IlId0y/P7Kr7GRHYnBVT9pOZRbg==
X-Gm-Gg: AYBFou1g8c+M3AEiStmh4p4tzpVhN+rVdxuxDTtUbBqwsDTZyLeCpcP2AHJwaGy/JAo
	YeNvCRW1hX5SSzLiZ7UyAn0p8P6JH2tAaaeZmRTo1iVI+TnI8HqK+zgDT+rrEddBPj8ByHzAkCi
	khXF7fAs4aqXRE9/lRjXcEIt4gy8ni29y+h5PP95v9xBHFBVZb9xS1OUc8rCOAheQIkq3UI3Kqp
	qgl/W2OT/328pT3C40WyRXw7eJS0sMJek6qaiLnEZ90Q0/IpuYUBABHWXCi+hfjxuLLQyOlbxcF
	DxXmnAQLn8X5bYNklr/7srBdD6MyEalo3wdZ4iqpA05ZSHgCbFk+Q08m3CxSxQvYQr7weXx+z7U
	sO5RZAyfBP4oCo7I2acPj17kb20yMq4aLk73d/8xteLF6DMaYo2xMd6Mi+REV8ep49azuvwXq7T
	X10c+tUupj5Uz5GU6CjJ2UP3+cRA==
X-Received: by 2002:a05:6102:26d4:b0:7d2:9f38:c45 with SMTP id
 ada2fe7eead31-7d4fb24e284mr951400137.8.1794415714445; Wed, 11 Nov 2026
 08:48:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Nov 2026 08:48:30 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261110002251.2007617-5-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com> <20261110002251.2007617-5-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 11 Nov 2026 08:48:30 -0800
X-Gm-Features: AclHuK_x3M_y0l288Reve6nYw8VEJ2GzEUcNsq03wwKU5ll6LyJ0JYnGEJBvaKc
Message-ID: <CAOLa=ZShhVC=7uYs4_CP6pUSuiYziQrbN8EbJhpqYToixPV-VA@mail.gmail.com>
Subject: Re: [PATCH 4/4] object-file: create ODB transaction temporary
 directory eagerly
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003d4e21066002f70f"

--0000000000003d4e21066002f70f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Justin Tobler <jltobler@gmail.com> writes:

> By default, ODB transactions for the "files" backend create their
> temporary object directory lazily once the first loose object is about
> to be written, and only if batched fsync is enabled. Transactions
> configured for git-receive-pack(1) are the exception as the directory is
> needed to quarantine incoming objects up front. Lazily creating the
> temporary directory in this manner is awkward for a couple of reasons:
>
>   - Writing loose objects has to know about the transaction internals to
>     trigger the lazy creation of the temporary object directory.
>
>   - Whether objects are staged in a temporary object directory, and thus
>     whether they become visible at once on commit, depends on the
>     configured fsync method.
>
> Create the temporary object directory eagerly for every transaction when
> it is started instead. This also ensures that no object is written to
> the main object database before the transaction is committed.
>
> Note that committing a transaction migrates every written object into
> the primary object directory even when batched fsync is disabled. This
> adds some minor overhead to ODB transaction callers that previously only
> used a temporary directory if batched fsync was enabled. The following
> benchmark uses the default fsync configuration and adds 10000 files of 4
> KiB each to a freshly initialized repository via git-add(1):
>
>   Benchmark 1: git add . (rev =3D HEAD~)
>     Time (mean =C2=B1 =CF=83):     895.0 ms =C2=B1  23.8 ms    [User: 545=
.3 ms, System: 340.7 ms]
>     Range (min =E2=80=A6 max):   866.7 ms =E2=80=A6 928.7 ms    20 runs
>
>   Benchmark 2: git add . (rev =3D HEAD)
>     Time (mean =C2=B1 =CF=83):     956.3 ms =C2=B1  26.1 ms    [User: 541=
.4 ms, System: 405.2 ms]
>     Range (min =E2=80=A6 max):   923.9 ms =E2=80=A6 993.6 ms    20 runs
>
>   Summary
>     git add . (rev =3D HEAD~) ran
>       1.07 =C2=B1 0.04 times faster than git add . (rev =3D HEAD)
>

The explanation hre is well written and nicely explains what the cover
letter didn't _cover_. Nice.

> Typically large numbers of loose objects are not expected to be written
> into an ODB transaction so the overhead here should be marginal.
>

Question: why is that?

> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  object-file.c         | 56 +++++++++----------------------------------
>  object-file.h         |  1 -
>  odb/source-loose.c    |  6 -----
>  t/t0004-unwritable.sh | 19 +++++++--------
>  4 files changed, 19 insertions(+), 63 deletions(-)

The changes itself looks good.

--0000000000003d4e21066002f70f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cd92ec83a8f48f65_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yMG5GMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1FSREFDYWRGRzlDZW1qU1BsVEJZdU1uT05Yb1VTYQpmR0ZnYThZMWx5
dmFSNEtMY1B4dzJUdzdweGFpeWhWY1pHQ0FkR1Z5TC9wN3VqM2FJaVpMdy9SeitnQXppUFpCCmkz
RHNITkhzZVU5ZWp0ay9hUGY3VE1nNEdNK0k5UmRTV3B6WWhVZWpjNkU1dGxEeVAwT3Brc3ppMkUv
bmhBUVoKK0t6V2l0QlZHcWEzUktnU0xoNGsxN28zd1MwMlMzQlpyeUU5cFhBSXpWUzBNUUQwaElI
WHdMNGU4eWR1UWJuTgpkeVlRa2VldDRtcGUydGQrMWlUeUZaSTlpRWtQYWtUUFVEVGRMemdrZHNn
NHF4R2tRYVRST00vMzJqVTZxWERLCm9yczBQWHFIWVVqOFRyN0dHMWs3RFpSRVhyZjhhNlZZZnRm
TXRRUGVHTzJ5bzZuV3hTaTB1K1NYWWRBaGpHTlkKRVduTHdPcDlCMkxlbGZCSDZZbzZ5QzJCZ3kz
cjdoZHdnRHdUNlBzbjNrbWJhRnJEMTh1VkJKTU9MeVZLUWNiSwppODBBWEZzbUNXb2VYZnQyWFJQ
THhWK0M4V0hwY2t3eTMwdUI0VStoclowdjNRRjdCVEFCZHNpdUhiRjJJc2NUClB0VTRiaG9hb05l
RUNCN21JbTJMVlZtV0JvTGlBSGMzL2RtQ2hWcz0KPWZlakcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003d4e21066002f70f--
