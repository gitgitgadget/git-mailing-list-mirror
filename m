Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168D71C5D57
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769246765; cv=pass; b=uvRqLNOUiRxyyQcfIlkZDuzUtMroXb7VCJtrvJCkHWsRA1Nf5PMNhRF7+bTjn1QR/aBjcAevSIKxKwqigRr2+xTabltlU+vv+SeCFDFX/GBOJ7c7WNLQmtk56FSX7F50SectU7F2B6hyxgTaQfVEaDylcDviYZTK4MYXolqr4W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769246765; c=relaxed/simple;
	bh=b94fZtzqbPE6ThahkV8pg/8SUdQYjiay+jTjLcHhZ6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rK8s2rQmNpCXJd3OtVG+cDT+kCEqWjWEJRQ8P9I516iOfoJXQyKIQsZcOcafhXE7IzpJKCZn7vLCoGPurDCCXQ4pERnw7uRiUQbHfE0SWmEKttcpZ4vG27DSXl5/JjSvWYRooDYT3afpoTulCtyIL4QcMHrGo6VPupQkgU1mR3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9XBz8jF; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9XBz8jF"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79274e0e56bso29536287b3.0
        for <git@vger.kernel.org>; Sat, 24 Jan 2026 01:26:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769246763; cv=none;
        d=google.com; s=arc-20240605;
        b=D+f1GOzIWjrkPXKsWYwWYawv+Cxz43fK3IXLjbEMigvUvBqur1a9KISsLI32+UxB1z
         EcTnzmhu0KPIcjA+mSLBZ106XgXWWcLvkMAb9W6gh7EE1gpIog7UYcSrovoQfhOMYQGy
         +qwVBFKqmkdPSxF+yYfukB5tnk75D7inGkIysDCQ7wdFCBtxEU+/MpGJFedpd8roWv9K
         rwUsnC7RW4TZNd1BkrHM/ASthG2FsKKMC8cTMsOABp/KD1fa7LuydKTtX0Hcpn0YhbVH
         Pil3w3OrtZYoyTIxL8HkpgEZWqs9vTihCM6gpz3Q9c4ebGo7cHE8CJ0sYMkK2LWcokAz
         UdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HQj15ChGxx0iW3butK8q0aWAKCcsJquGRfA1lgL+hoA=;
        fh=U4ycHPA0pzA9WcxEru6mDyTXVE3t6jSiFfiPdOnSqJg=;
        b=i8zi+/1nNAhu/eTLzDpydmtqxY80GFo7XFaY0Ap5N830GkfA8CEFo5J9nIF6tAuYvm
         pMxyQsMWYtbkRPdcWb6AQL8LxbIW8IwnacdApfCz8ugmIPBM3zzqaOMXSVSV4q6qUO8P
         QxXA+L0160d9jQdXlkG/zONyeOFolcUV+wH10XQ6BhKvSYBA/QEw7ZQjsmWl+EI5z4jF
         4MpYq22s2YZLeek0tIubaob3xMLw3Fr946keDtOnSsThStSd3VSVoH//zT31RdLJIPWA
         91nOGZBFSpifBuxJulHmo5Bq13AIoN1XX/Xq7Zw1r7aE+Fyny6I9rv98C33G4A8htnPz
         O4AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769246763; x=1769851563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQj15ChGxx0iW3butK8q0aWAKCcsJquGRfA1lgL+hoA=;
        b=k9XBz8jFYo2qktG2e8MnZvK+h+loPVHSHtcXhrJG9Tp0OLXG+1jH9CuEV2hhNxJSTj
         LiBYeeYmcyGG1m4c0jvQvp8B1x560pLfDi6IcVQ+YCBj9AAwEFSFFArA354kZZzqNc/Z
         zkh+CPo/OTebzNwHuHK3wbthNHdfvDxNJyPj3Lt1xgSfx++r+Ch1cBsqStHe4lqTCzE5
         8XldDmOaJm5v8Vk2lTHkh4CadBIDn4OutU1Txtr2sdxpeoYrjtNbb7tMxZISOxCl3exB
         EVTl+ncgSqrrc0PpMHLf1riEloBEJTDz3MQc/l1cdOw0RQbtSqhsju19/1D2ft9i0SUS
         JEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769246763; x=1769851563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HQj15ChGxx0iW3butK8q0aWAKCcsJquGRfA1lgL+hoA=;
        b=U8nd/3npx8xNJG2mGudDVGWhWnf9GffBt0p+h0eTdnYEf5PWZLmlgZb2sPyjj+u6WX
         8VSRqcmHPaIWKU9+wL+lEOatFzd1PTGjt7N9xU/e3mAdbEkPVvCYRbFuF44CWqAMG2en
         JpyDTWFREbrZmecDQODCCjC9TbGfyE8Emp+pUSrrkaXA3zpw5ABLv89RK89RZk/b4ufP
         uvqhk6+s6/G9mlo/ieRYufD30VQoxOlaDaWVTo/SUDPYgbmn0Eb3Gf70juxHhnR6WA1C
         BkMyTSQyVWJNt8hzxNfHEuw/4/+d6LZkQ4aQlVhPTS1i1gDYt9foB5XwFHz9jaurHC1M
         ru4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXoGS64vkO4azYUQqMSaXuYoDJcby4MB1MgWvcStpvW188QERHsw9rOxZev4Y47V4YD3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmlji8RykzJjutaq9zx16C4cnMOHdUPQZCpvC1pZt8O0P7CSoN
	RpGxuJIoazh4dqillyn0XA6Fwuzzev5yxyUKC841Xe423FDxpZfsyV/qn6RWkMRVWwqjRJaIGXY
	KUr14EoRO6tCuoVNL6Jvv0I/Dx9RBUnA=
X-Gm-Gg: AZuq6aI+W1ZXcChT5ACf4csbcFAfguNe0qGxBCMqvniQN4WPTUtHKBmlZq8w7GmHhL2
	p5g08/7Vq9gD6McR4wPvVg9e+cLF3/W5jiRI8qkl2/zEuyqIsC6jX0phxf+YPPCo2u4dkjC4tKI
	xb81xUea2VlAEsMzI2mjuVgeVIay80ETuUgEFINex5uRBSxIOf3IHgrzx/ZAAkuNUpVFmxRi2Th
	AVGRUDYb2ryuXyR9MFGar4Qc0nReZa/z3jXi9SwowDfvDAFcdGyeLknxiP0mYjgqsF8HaCJd9vk
	b2tyBg==
X-Received: by 2002:a05:690c:3513:b0:789:33a3:8da3 with SMTP id
 00721157ae682-794399d191bmr55028747b3.58.1769246762904; Sat, 24 Jan 2026
 01:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADMnYXDDbVBwZgETsFhwkOyn8cM8QU4+YQs2rRfTac6ec49-5A@mail.gmail.com>
 <20260123210643.GA2728629@coredump.intra.peff.net> <xmqq8qdogdmu.fsf@gitster.g>
 <20260124072814.GA3455597@coredump.intra.peff.net>
In-Reply-To: <20260124072814.GA3455597@coredump.intra.peff.net>
From: Klaus Sembritzki <klausem@gmail.com>
Date: Sat, 24 Jan 2026 10:25:51 +0100
X-Gm-Features: AZwV_QgWIpSSgJQ2kGTG-N7vVg-BK3_H0_KcKco2-kI8jQssCz2XSlI67ChTlFs
Message-ID: <CADMnYXA6_uCZU42NR2vFKM9uhfaWOdu0tkzPi6Ya8WW2rzknGg@mail.gmail.com>
Subject: Re: The SHA256 of "xy\n" (ASCII, no CRLF) contains 1337, ACBAD in za,
 and I am 1aa
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 8:28=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jan 23, 2026 at 02:36:41PM -0800, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > On Fri, Jan 23, 2026 at 09:16:46PM +0100, Klaus Sembritzki wrote:
> > >
> > >> $ # My initials (ks): 1aa
> > >> $ echo ks | sha256sum
> > >> $ 1aa44e718d5bc9b7ff2003dbbb6f154e16636d5c2128ffce4751af5124b65337
> > >>
> > >> $ # 50566750337
> > >> $ echo thinking | sha256sum
> > >> $ 50566750337beb9e98e553fd9196d10576f9eb0cbc6b66e2586b9d73af4f352f
> > >
> > > Oh man, I've got deadbeef!
> > >
> > >   $ echo jk35252822 | sha256sum
> > >   33f1a74529870456c56ad97c59cfed6bdeadbeef9b9bc3f4ff49bb203e36f96b
> > >
> > > What could it all mean?
> >
> > Sorry, but I have to admit that I completely lack humor receptor
> > cells.
>
> Probably because it was not that funny. :)
>
> The original message seemed to be looking for Numerology-style meanings
> in random data. I wasn't sure if it was serious or not, but I could not
> resist either playing along (if not) or trolling (if so).
>
> But here's my deadbeef brute-force program for fun.
>
> -Peff
>
> -- >8 --
> #include <stdio.h>
> #include <string.h>
> #include <openssl/evp.h>
>
> int main(int argc, const char **argv)
> {
>         const char needle[] =3D { 0xde, 0xad, 0xbe, 0xef };
>         const EVP_MD *algo =3D EVP_sha256();
>         EVP_MD_CTX *ctx =3D EVP_MD_CTX_new();
>
>         EVP_DigestInit_ex(ctx, algo, NULL);
>         while (*++argv)
>                 EVP_DigestUpdate(ctx, *argv, strlen(*argv));
>
>         for (unsigned i =3D 0; ; i++) {
>                 char buf[16];
>                 char *p;
>                 unsigned char digest[32];
>                 EVP_MD_CTX *copy =3D EVP_MD_CTX_dup(ctx);
>
>                 p =3D buf + sizeof(buf);
>                 for (unsigned v =3D i; v; v /=3D 10)
>                         *--p =3D '0' + (v % 10);
>                 EVP_DigestUpdate(copy, p, buf + sizeof(buf) - p);
>                 EVP_DigestUpdate(copy, "\n", 1);
>                 EVP_DigestFinal_ex(copy, digest, NULL);
>                 EVP_MD_CTX_free(copy);
>                 if (memmem(digest, sizeof(digest), needle, sizeof(needle)=
))
>                         printf("%d\n", i);
>         }
> }

Incrementing the MSB instead of the LSB (indexing naturally starts
with 1 in that case) seems to improve the performance, and it finds
different solutions, if the program is terminated early.
The rationale is that there is autocorrelation in the observations,
though I cannot judge what that means in this concrete example. The
speedup is not that dramatic here, so SHA256 seems to be pretty
random.

#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <openssl/evp.h>

#ifdef POLYFILL
EVP_MD_CTX *EVP_MD_CTX_dup(const EVP_MD_CTX *in)
{
    EVP_MD_CTX *out =3D EVP_MD_CTX_new();

    if (out !=3D NULL && !EVP_MD_CTX_copy_ex(out, in)) {
        EVP_MD_CTX_free(out);
        out =3D NULL;
    }
    return out;
}
#endif

#define REVERTED_BIT(n, position, width) (((n & (1 << position)) >>
position) << (width - position - 2))

uint32_t revert_bits(uint32_t n, uint32_t width) {
    uint32_t result =3D 0;
    for (uint32_t i =3D 0; i < width; ++i) {
        result |=3D REVERTED_BIT(n, i, width);
    }
    return result;
}

int main(int argc, const char **argv)
{
    const char needle[] =3D { 0xde, 0xad, 0xbe, 0xef };
    const EVP_MD *algo =3D EVP_sha256();
    EVP_MD_CTX *ctx =3D EVP_MD_CTX_new();

    EVP_DigestInit_ex(ctx, algo, NULL);
    while (*++argv)
        EVP_DigestUpdate(ctx, *argv, strlen(*argv));

    for (uint32_t n =3D 1; ; n++) {
#if (COUNTER_WIDTH !=3D 0)
        uint32_t i =3D revert_bits(n, COUNTER_WIDTH);
#else
        uint32_t i =3D n;
#endif
        // printf("%u %u\n", n, i);
        char buf[16];
        char *p;
        unsigned char digest[32];
        EVP_MD_CTX *copy =3D EVP_MD_CTX_dup(ctx);

        p =3D buf + sizeof(buf);
        for (uint32_t v =3D i; v; v /=3D 10)
            *--p =3D '0' + (v % 10);
        EVP_DigestUpdate(copy, p, buf + sizeof(buf) - p);
        EVP_DigestUpdate(copy, "\n", 1);
        EVP_DigestFinal_ex(copy, digest, NULL);
        EVP_MD_CTX_free(copy);
        if (memmem(digest, sizeof(digest), needle, sizeof(needle)))
        {
            printf("counter width: %2u | n: %10u | i: %10u\n",
COUNTER_WIDTH, n, i);
            return 0;
        }
    }
    return 1;
}

cc -DPOLYFILL -DCOUNTER_WIDTH=3D32 jk_evp.c -lssl -lcrypto -o jk_evp_msb_32
cc -DPOLYFILL -DCOUNTER_WIDTH=3D31 jk_evp.c -lssl -lcrypto -o jk_evp_msb_31
cc -DPOLYFILL -DCOUNTER_WIDTH=3D30 jk_evp.c -lssl -lcrypto -o jk_evp_msb_30
cc -DPOLYFILL -DCOUNTER_WIDTH=3D29 jk_evp.c -lssl -lcrypto -o jk_evp_msb_29
cc -DPOLYFILL -DCOUNTER_WIDTH=3D0 jk_evp.c -lssl -lcrypto -o jk_evp_0
counter width: 32 | n:  103832253 | i: 1588397616
counter width: 31 | n:   62413559 | i: 1003915120
counter width: 30 | n:  166340413 | i:  396135154
counter width: 29 | n:  137077701 | i:  171728193
counter width:  0 | n:  171728193 | i:  171728193
