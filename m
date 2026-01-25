Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320291C862F
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769334476; cv=pass; b=gMar2wvkQVAmTY0XAgJtMsF+vB6LEaWBRy73Tay3mV15IWEBvp8SBhge+nTCM92iQAUWIMCDUhRS3kwo6pAoaA77G2MYaJRefHkrVIP7JOdLJgpky25CRIsFyOLKGSAFpVXdZrpSboYL0TjW4chSklSj6g/yGb6zR1TzwxivV2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769334476; c=relaxed/simple;
	bh=C/iYBaiVxAduiLrsvGhlLGgFmDy+RbPxNS+ynFh8n/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIQOmDqgCOwCyjwgmQbdpdrknsOzgdUAVnutXNMC0tfBZvucPNj4+i/VBnexZteH/wsD6IVjySJk4ADUvTDmSJub5CoX4d9pXsPkm6yvheEiXfkXT7YUC160qD/YUmFoNK+kOHflAixkFJn/JagJjSfvG7IOEhArzpQfaSWWGjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9jw1AvR; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9jw1AvR"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79273a294edso33878987b3.3
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 01:47:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769334474; cv=none;
        d=google.com; s=arc-20240605;
        b=bk5Uz2Oqj1aeCk/auFebT6Ift6a5cZbaFen8wkWAp1fo148k1dElsADI6bh7bb++li
         zJd8LcmXbQNsR4gI1txwDovcUh+F71zEkeyebhozod+j7ThjkszD2Kyf5ZmMrR110wFv
         UIRZlVSRnN6kdFmMy0Pe5TKxgpN2ZCtNFQw8BzNHSnClsZ4XAzQaBp39UPASXmybjqB6
         IPApmgtLB9Ap5URAOZUh8Bs4G8g4xToFycnvk2fm05Z7/mcn+KfthkoB+CxocevUQVer
         ZtC026xg24SZVVZhy4RY2pn/DQa6uT17p1Y5qFzbvxTzMCgNKv/L7giwih3/q9m2Nu/+
         u5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Apw4ezmE8sHsIV2Wr3jjfvp2ywCEN247PReYVgbBwq0=;
        fh=afJ/3956SJVLkj6w3Z5TDegOU5WfURb2rVoAds6isbU=;
        b=T6aXH666SLuu1i8UuSospfTCvumYAHod19oXg9vruKKsDNjQyF0YK2HX5vOXdti8yb
         W/JjGr/tfVglsOc/OmVkgV2wHqPc23t9IzufI8OBeYOh6o5tkoCiZjB43PAM67uBwUuy
         VODnbQPxWGnzoP0loA9tVIf7HttzIpFXZOLl02/FJNRI2CjsPP3hl8RhruM9bmH6V8Np
         Y1IF331jJoP3khQXeJ2Q8+kxvglWC5tmMBI2x8MCQBZWcLF2HnB/EUjVrA1Q+N7muAwX
         H7H8t81kaFKWsmxxjHMlfNZ045j3CVEoTs+caSFszUZqxA4BimD1PXS5LY9Bp8mvD6sF
         g9WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769334474; x=1769939274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Apw4ezmE8sHsIV2Wr3jjfvp2ywCEN247PReYVgbBwq0=;
        b=W9jw1AvRj2XLVVUNH5dg8WYz9YXUCxyrl0jXCbxbsk5NiX/3vbKuLsY0jttO6NrA1P
         wsaTwQgXnjFiV/OomPuwT+rCTEQtJ+WaE2VJ8LzFxRZrLrbiAtigs607ttvyrp1bkvVk
         ZJIhTCJcosoC6ER/rQSn0PzwspT8GQWQ17mqSxts6ODE4LH/hzfz4ceNRDsd2N3Aq8aL
         58ZuO3vlJEAM2AMmo0Ug9Wq3SUFZWiXJblShVGKlIqlD6qXTQGw37thB8vPmYnI70165
         AyqyAsK4w+7+5o7qoqwd85Xo0X9WZ/5XvSVes50nHhh5vOOVuDX5hp+aGk+HeHbJ3PpH
         NXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769334474; x=1769939274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Apw4ezmE8sHsIV2Wr3jjfvp2ywCEN247PReYVgbBwq0=;
        b=WEg9GZgRO1ekkjExQdRDut7GiYBm380ky4gzXiLOzqPY609ASovyIP2p0mlXNzx6RV
         kwlz4lmZwWC3v2Annt8X0MbSqSd4goHmiQSSmdpSXW6rFf/15Faasu1CqjAROP2W2qwY
         YCZHEVto7tiaYQROEnDXhQHgmxKDJej+Qo06B2VijIgfR1erzHwzvIdZBreuLcXJ7pq0
         uEEkrKH9yvAi68jNoaSj+54La9STG43/j4YNONbBTE/sVO8WEYwsSopkJ1Z2Q24dfpw8
         aBjp2TlKv7/qFe59KL02f3UzXtjBdVqmamIJnkTkwHRJzevw+/VDfB6A4oKekQIYNByW
         75rA==
X-Forwarded-Encrypted: i=1; AJvYcCURhDwFhEO3IuNYP1aI4GWMbJbVQqHRwM8fdESGvgHa8ipCTDYCzf4f6JNVzx+xcYhene0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzezXlbrYxXnS1pFTsfB23w6kZv6DhPLwmd0AnvVMWvaZROZd3D
	hSZHDMswckrA2g39S27KYvVoIDZWOuDsj8IURrI9U1HwknYCwBZGBztG++ignG2YHokHbLru6pU
	lCkQxXSyZ0ws/qm9sImaOc7RyNuthEek=
X-Gm-Gg: AZuq6aIlgmmfZ5XILdYXX9SjDmkzB9+R4w1yJFQcev5gAF9qF4x/+DIa25RkmCLvrcO
	j37De1QJ5x8BPQhXGFSQqiYGm0iuqkpnYX8+d9L/MqeEw2znhhCVwGNltD2HmmcESSS+zzkP1Eo
	li/5Ykz1fNfIDFu/EzZuO49vJwJ4WZS+UFrNDiRsC+W0tybd3mgba4+kpzzLKd5eUNpGarm7aPA
	CaM4vmRlcS/jF3A5oF7iKprhNiZRtX41JVOt+lUL78GpdMxOt9t08aA/lL1OhZvKo+Sfxx3Rbom
	+8KK
X-Received: by 2002:a05:690c:6c0e:b0:786:4fd5:e5e0 with SMTP id
 00721157ae682-7945a9a26bdmr6539847b3.47.1769334474055; Sun, 25 Jan 2026
 01:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADMnYXDDbVBwZgETsFhwkOyn8cM8QU4+YQs2rRfTac6ec49-5A@mail.gmail.com>
 <20260123210643.GA2728629@coredump.intra.peff.net> <xmqq8qdogdmu.fsf@gitster.g>
 <20260124072814.GA3455597@coredump.intra.peff.net> <CADMnYXA6_uCZU42NR2vFKM9uhfaWOdu0tkzPi6Ya8WW2rzknGg@mail.gmail.com>
In-Reply-To: <CADMnYXA6_uCZU42NR2vFKM9uhfaWOdu0tkzPi6Ya8WW2rzknGg@mail.gmail.com>
From: Klaus Sembritzki <klausem@gmail.com>
Date: Sun, 25 Jan 2026 10:47:42 +0100
X-Gm-Features: AZwV_QgRs6a6AgRz_EMpTxhPF31-l0jpxu19J2I9sWqyg_o4w-CYnFNGYKG7uEM
Message-ID: <CADMnYXAF5VV9jKbxm1rduR-x96TFEso572zCAVOU-JoMpnX1tg@mail.gmail.com>
Subject: Re: The SHA256 of "xy\n" (ASCII, no CRLF) contains 1337, ACBAD in za,
 and I am 1aa
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 10:25=E2=80=AFAM Klaus Sembritzki <klausem@gmail.co=
m> wrote:
>
> On Sat, Jan 24, 2026 at 8:28=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> >
> > On Fri, Jan 23, 2026 at 02:36:41PM -0800, Junio C Hamano wrote:
> >
> > > Jeff King <peff@peff.net> writes:
> > >
> > > > On Fri, Jan 23, 2026 at 09:16:46PM +0100, Klaus Sembritzki wrote:
> > > >
> > > >> $ # My initials (ks): 1aa
> > > >> $ echo ks | sha256sum
> > > >> $ 1aa44e718d5bc9b7ff2003dbbb6f154e16636d5c2128ffce4751af5124b65337
> > > >>
> > > >> $ # 50566750337
> > > >> $ echo thinking | sha256sum
> > > >> $ 50566750337beb9e98e553fd9196d10576f9eb0cbc6b66e2586b9d73af4f352f
> > > >
> > > > Oh man, I've got deadbeef!
> > > >
> > > >   $ echo jk35252822 | sha256sum
> > > >   33f1a74529870456c56ad97c59cfed6bdeadbeef9b9bc3f4ff49bb203e36f96b
> > > >
> > > > What could it all mean?
> > >
> > > Sorry, but I have to admit that I completely lack humor receptor
> > > cells.
> >
> > Probably because it was not that funny. :)
> >
> > The original message seemed to be looking for Numerology-style meanings
> > in random data. I wasn't sure if it was serious or not, but I could not
> > resist either playing along (if not) or trolling (if so).
> >
> > But here's my deadbeef brute-force program for fun.
> >
> > -Peff
> >
> > -- >8 --
> > #include <stdio.h>
> > #include <string.h>
> > #include <openssl/evp.h>
> >
> > int main(int argc, const char **argv)
> > {
> >         const char needle[] =3D { 0xde, 0xad, 0xbe, 0xef };
> >         const EVP_MD *algo =3D EVP_sha256();
> >         EVP_MD_CTX *ctx =3D EVP_MD_CTX_new();
> >
> >         EVP_DigestInit_ex(ctx, algo, NULL);
> >         while (*++argv)
> >                 EVP_DigestUpdate(ctx, *argv, strlen(*argv));
> >
> >         for (unsigned i =3D 0; ; i++) {
> >                 char buf[16];
> >                 char *p;
> >                 unsigned char digest[32];
> >                 EVP_MD_CTX *copy =3D EVP_MD_CTX_dup(ctx);
> >
> >                 p =3D buf + sizeof(buf);
> >                 for (unsigned v =3D i; v; v /=3D 10)
> >                         *--p =3D '0' + (v % 10);
> >                 EVP_DigestUpdate(copy, p, buf + sizeof(buf) - p);
> >                 EVP_DigestUpdate(copy, "\n", 1);
> >                 EVP_DigestFinal_ex(copy, digest, NULL);
> >                 EVP_MD_CTX_free(copy);
> >                 if (memmem(digest, sizeof(digest), needle, sizeof(needl=
e)))
> >                         printf("%d\n", i);
> >         }
> > }
>
> Incrementing the MSB instead of the LSB (indexing naturally starts
> with 1 in that case) seems to improve the performance, and it finds
> different solutions, if the program is terminated early.
> The rationale is that there is autocorrelation in the observations,
> though I cannot judge what that means in this concrete example. The
> speedup is not that dramatic here, so SHA256 seems to be pretty
> random.
>
> #include <stdio.h>
> #include <string.h>
> #include <stdint.h>
> #include <openssl/evp.h>
>
> #ifdef POLYFILL
> EVP_MD_CTX *EVP_MD_CTX_dup(const EVP_MD_CTX *in)
> {
>     EVP_MD_CTX *out =3D EVP_MD_CTX_new();
>
>     if (out !=3D NULL && !EVP_MD_CTX_copy_ex(out, in)) {
>         EVP_MD_CTX_free(out);
>         out =3D NULL;
>     }
>     return out;
> }
> #endif
>
> #define REVERTED_BIT(n, position, width) (((n & (1 << position)) >>
> position) << (width - position - 2))
>
> uint32_t revert_bits(uint32_t n, uint32_t width) {
>     uint32_t result =3D 0;
>     for (uint32_t i =3D 0; i < width; ++i) {
>         result |=3D REVERTED_BIT(n, i, width);
>     }
>     return result;
> }
>
> int main(int argc, const char **argv)
> {
>     const char needle[] =3D { 0xde, 0xad, 0xbe, 0xef };
>     const EVP_MD *algo =3D EVP_sha256();
>     EVP_MD_CTX *ctx =3D EVP_MD_CTX_new();
>
>     EVP_DigestInit_ex(ctx, algo, NULL);
>     while (*++argv)
>         EVP_DigestUpdate(ctx, *argv, strlen(*argv));
>
>     for (uint32_t n =3D 1; ; n++) {
> #if (COUNTER_WIDTH !=3D 0)
>         uint32_t i =3D revert_bits(n, COUNTER_WIDTH);
> #else
>         uint32_t i =3D n;
> #endif
>         // printf("%u %u\n", n, i);
>         char buf[16];
>         char *p;
>         unsigned char digest[32];
>         EVP_MD_CTX *copy =3D EVP_MD_CTX_dup(ctx);
>
>         p =3D buf + sizeof(buf);
>         for (uint32_t v =3D i; v; v /=3D 10)
>             *--p =3D '0' + (v % 10);
>         EVP_DigestUpdate(copy, p, buf + sizeof(buf) - p);
>         EVP_DigestUpdate(copy, "\n", 1);
>         EVP_DigestFinal_ex(copy, digest, NULL);
>         EVP_MD_CTX_free(copy);
>         if (memmem(digest, sizeof(digest), needle, sizeof(needle)))
>         {
>             printf("counter width: %2u | n: %10u | i: %10u\n",
> COUNTER_WIDTH, n, i);
>             return 0;
>         }
>     }
>     return 1;
> }
>
> cc -DPOLYFILL -DCOUNTER_WIDTH=3D32 jk_evp.c -lssl -lcrypto -o jk_evp_msb_=
32
> cc -DPOLYFILL -DCOUNTER_WIDTH=3D31 jk_evp.c -lssl -lcrypto -o jk_evp_msb_=
31
> cc -DPOLYFILL -DCOUNTER_WIDTH=3D30 jk_evp.c -lssl -lcrypto -o jk_evp_msb_=
30
> cc -DPOLYFILL -DCOUNTER_WIDTH=3D29 jk_evp.c -lssl -lcrypto -o jk_evp_msb_=
29
> cc -DPOLYFILL -DCOUNTER_WIDTH=3D0 jk_evp.c -lssl -lcrypto -o jk_evp_0
> counter width: 32 | n:  103832253 | i: 1588397616
> counter width: 31 | n:   62413559 | i: 1003915120
> counter width: 30 | n:  166340413 | i:  396135154
> counter width: 29 | n:  137077701 | i:  171728193
> counter width:  0 | n:  171728193 | i:  171728193

I have to admit there is a bug in my previous code, it only works
correctly for even numbers. It should have been:

#define REVERTED_BIT(n, position, width) (((n & (1 << position)) >>
position) << (width - position - 2 + (width & 1)))

uint32_t revert_bits(uint32_t n, uint32_t width) {
    uint32_t result =3D 0;
    for (uint32_t i =3D 0; i < width; ++i) {
        result |=3D REVERTED_BIT(n, i, width);
    }
    return result;
}

The actual performance measurements are:
counter width: 32 | n:  103832253 | i: 1588397616
counter width: 31 | n:  103832253 | i: 1588397616
counter width: 30 | n:  166340413 | i:  396135154
counter width: 29 | n:  166340413 | i:  396135154
counter width: 28 | n:  268041599 | i: 2281045247 # 2**28 is close to
the first finding when counting by incrementing the LSB, so this is
slow.
counter width: 27: This does not find anything, because 2**27 is lower
than the first finding when counting by incrementing the LSB.
counter width:  0 | n:  171728193 | i:  171728193 #
math.log2(171728193) =3D 27.35555166834193
