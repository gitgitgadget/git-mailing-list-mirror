Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1D29A1
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340365; cv=pass; b=lrcGLdlVnf1A8JRH9T2+5b7cJF5Y9D33ot+MDdCZ/e3g0XzGj4l6Yj21dp07cfRCEufsoFn/ZqwAQ9D8E1ajbK6Uy9o8t4T2Yqf5//HVSNHN32Evk/YiV6b72Q5NbHlNP/GoQ7ECpnW2aaO5JzwZix0IPwmUT2EmP1w3tJm6Gow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340365; c=relaxed/simple;
	bh=/1jyxVoL1sZfAkFe8auoIAAtVBEWW1xufZM7wSVPvJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGBV7CAq2Ryqtd8nvZEjb1RvSsZmLp2tK2eSvjOxa76InI9cNetu8e5Xuu7JNy6qDARhrUo9PNNIz2VCPbZ3OwrnnMNEwxVrk3hUcXxWT3jrQGuzzw573RiZAV6LzMiWWxR+A4MkiH4Y+4APGGHNyuUXUtIDnkuTI3pG3aU6bWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z92MyhQ4; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z92MyhQ4"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79414ab1497so31998597b3.1
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 03:26:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769340362; cv=none;
        d=google.com; s=arc-20240605;
        b=SXSpXLxHGPP2kvv7+IO92LkrM5pO9mZPJDupxMqr8a2ZjhrF8o8TtcmsB2NFsR0ZuF
         jmSNp80c65y8Yo5ESHK8qfFOaosb3Dmmg5VhKRXdGtVPHJor/fFu3i4I5CXm3AG4BSPg
         NdQ2ghN38WSrJTvD00baOHnBh1PIXjOdxvkZhPaNEXqzBMOH/Vx9VpiiVadhNhzJXqEx
         lerwibpcBZNgiGCvw4vJ/P+4HjeFInuZQsXjcipyHWZAu43ai1/87BiQEFTLQMBoeOtl
         WTMZTPY1+bAYjlqvimQFiS3fEk6+uJxBbsPKhpbfafReq5zjgo0KNHlj+sEyDeSotyKj
         55Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=an3rsjOWcHZm3xzWEhJBQC+qLrfTmuYPXZFzOsKNJCc=;
        fh=2NhxXAgqwynpj1LoL6hkNuKV0JIBnEXChUGwN726it4=;
        b=YhrHcmo9lkX6TEUSBO+B2cYyO2ocDqetLs1MmuMdw1PxiOjcIK/wp4fEX4b3ahhBZ4
         HkUfxwfiJ83NRTEA9OuBz9yliuhODmhDBqHFP6XmhmOU19kr11DTeznAdVUM35Cwywek
         v98iK/nE4e8q/cC9VcWsAD4MZO6pn/zKuLGQsxwmHRuh0OhQjIAwT7qnBEA/yAqmR3im
         +L782bM9kBootORjMd1pJGAWxsuAnF16G1HpPXGHtFsaH8EoUXt6sXcTgklyZNUUNWHS
         1vx1CANLpKC0BfdlHjza4QqA8c0rtQnBn51+ZFMmKXfMg9cAcni1zaFGZ3BVPH8KfdM5
         xQkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769340362; x=1769945162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an3rsjOWcHZm3xzWEhJBQC+qLrfTmuYPXZFzOsKNJCc=;
        b=Z92MyhQ4mdUZaw8q4IIFIL2B2JkD3vphCJNbslYglPIU4KWffJIqI2wyEulCBZvvjc
         q4uZvjgUHK+N6i1hETKtR5VQh9SsJ5oBpsnwPnNSPHCCtKyXwUIROQAlh5OsaEZ8JSHU
         L8Fyk1OfD5aiH1J1U2qzwNykcS6+vLcoUkI94QSTWMIyW9Vhed7wHZiPjMZ8sbImXUTw
         5v5mDwn8ALMgHok2+HvPoeuu8NhshaU4z55H0fKYySd3jSGaZRShJDppEk6jPVs3unx0
         ctEcUJlU1i74+ChlB3tCopy40/BM15S36z6B08TOJmqQP2474qIoW4X65EfSPAJ9hzMp
         Nf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769340362; x=1769945162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=an3rsjOWcHZm3xzWEhJBQC+qLrfTmuYPXZFzOsKNJCc=;
        b=Os9tf0lQCRLZaTX9ti+AZou5QuqZDoVT1o3nCzlehnfTBuambbqwvBtF5Yslk8oKo5
         ODSM2qz3+pyfaH7rMcS8E3uAjY3+a+HS19V7pciIzVc1E5JKbw+8srZLOLSkc1XqF3Rw
         DYUr7j9ZVPCqve+ANNj9eqm7H3P75h/jYscmA2mvZt/erUXzBpKZrOTQRed/2BSz9dmi
         jSLo6S/+UAqPN5xGoA8sVzKBOndcH3sIhpF82BIc9OHLlSXPLP4ZE0hD8lYpEk5fz+OZ
         Q0HsN754NW2D76LFuLe88BhGoggFwYv0B93FQxhuwgDJq4k90FAHEU14uE9WlSJ7ZsUZ
         EeLg==
X-Forwarded-Encrypted: i=1; AJvYcCUXVcKw9D7gyb6i67efANlKZNeLCoWAJDCgljYhb9YESNKf5DOvXeGWmdldkhgyDaUemS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcfLYpLGtxDwa1ARst91PTOpYXQbntRMmhhGoVojnC4TmK0s1E
	xLL7jjKN2qBj8HVFFOM/PnZuSAjJO6lRPV5c1MXVuQe926LQqQlHmkOHTdIlSceQ+8u6pxwlwBP
	ms5PS8uK4XCFezzSSrae5keeS/ivXmZS2RRWW
X-Gm-Gg: AZuq6aLKZYvgtjFL8IvRmsrOSSq5CDaf+c8Al/QuoiaaShRLHTkoanY4qaqvwQMMhBN
	RkjCKUfHkD+EBQ964vFVvzRxj3NbXkuE4H0kVVssA33l5PjlaK2kLJTgbha5LvxhxTxXhejuQOb
	hQI4Fzn12aqBEHC4Duh6PvvRLaBO0zTeaaYZw1lis7jSeW/YMSF81UYpldqkR6m3oGwgjuKo9DH
	3aP/ZiMyNv6DBgN62N1RDqkNr4WwIhKrRMAethUsKnzWysLcJkrYDmOceb6bv6/ztP/dAkQDM02
	QQeB
X-Received: by 2002:a05:690c:d92:b0:794:2fed:5369 with SMTP id
 00721157ae682-7945a89710amr10809757b3.24.1769340362380; Sun, 25 Jan 2026
 03:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADMnYXDDbVBwZgETsFhwkOyn8cM8QU4+YQs2rRfTac6ec49-5A@mail.gmail.com>
 <20260123210643.GA2728629@coredump.intra.peff.net> <xmqq8qdogdmu.fsf@gitster.g>
 <20260124072814.GA3455597@coredump.intra.peff.net> <CADMnYXA6_uCZU42NR2vFKM9uhfaWOdu0tkzPi6Ya8WW2rzknGg@mail.gmail.com>
 <CADMnYXAF5VV9jKbxm1rduR-x96TFEso572zCAVOU-JoMpnX1tg@mail.gmail.com>
In-Reply-To: <CADMnYXAF5VV9jKbxm1rduR-x96TFEso572zCAVOU-JoMpnX1tg@mail.gmail.com>
From: Klaus Sembritzki <klausem@gmail.com>
Date: Sun, 25 Jan 2026 12:25:51 +0100
X-Gm-Features: AZwV_QiLnYHyfkBdPjYv9TnaP0wp3W_aaEMLBTWS9QM0bBrFkBZX38b1HvX51N4
Message-ID: <CADMnYXDBSTDHynvVcpfpU79V=BXNOksi1W0pHFRWgZBkqTf5Hw@mail.gmail.com>
Subject: Re: The SHA256 of "xy\n" (ASCII, no CRLF) contains 1337, ACBAD in za,
 and I am 1aa
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 10:47=E2=80=AFAM Klaus Sembritzki <klausem@gmail.co=
m> wrote:
>
> On Sat, Jan 24, 2026 at 10:25=E2=80=AFAM Klaus Sembritzki <klausem@gmail.=
com> wrote:
> >
> > On Sat, Jan 24, 2026 at 8:28=E2=80=AFAM Jeff King <peff@peff.net> wrote=
:
> > >
> > > On Fri, Jan 23, 2026 at 02:36:41PM -0800, Junio C Hamano wrote:
> > >
> > > > Jeff King <peff@peff.net> writes:
> > > >
> > > > > On Fri, Jan 23, 2026 at 09:16:46PM +0100, Klaus Sembritzki wrote:
> > > > >
> > > > >> $ # My initials (ks): 1aa
> > > > >> $ echo ks | sha256sum
> > > > >> $ 1aa44e718d5bc9b7ff2003dbbb6f154e16636d5c2128ffce4751af5124b653=
37
> > > > >>
> > > > >> $ # 50566750337
> > > > >> $ echo thinking | sha256sum
> > > > >> $ 50566750337beb9e98e553fd9196d10576f9eb0cbc6b66e2586b9d73af4f35=
2f
> > > > >
> > > > > Oh man, I've got deadbeef!
> > > > >
> > > > >   $ echo jk35252822 | sha256sum
> > > > >   33f1a74529870456c56ad97c59cfed6bdeadbeef9b9bc3f4ff49bb203e36f96=
b
> > > > >
> > > > > What could it all mean?
> > > >
> > > > Sorry, but I have to admit that I completely lack humor receptor
> > > > cells.
> > >
> > > Probably because it was not that funny. :)
> > >
> > > The original message seemed to be looking for Numerology-style meanin=
gs
> > > in random data. I wasn't sure if it was serious or not, but I could n=
ot
> > > resist either playing along (if not) or trolling (if so).
> > >
> > > But here's my deadbeef brute-force program for fun.
> > >
> > > -Peff
> > >
> > > -- >8 --
> > > #include <stdio.h>
> > > #include <string.h>
> > > #include <openssl/evp.h>
> > >
> > > int main(int argc, const char **argv)
> > > {
> > >         const char needle[] =3D { 0xde, 0xad, 0xbe, 0xef };
> > >         const EVP_MD *algo =3D EVP_sha256();
> > >         EVP_MD_CTX *ctx =3D EVP_MD_CTX_new();
> > >
> > >         EVP_DigestInit_ex(ctx, algo, NULL);
> > >         while (*++argv)
> > >                 EVP_DigestUpdate(ctx, *argv, strlen(*argv));
> > >
> > >         for (unsigned i =3D 0; ; i++) {
> > >                 char buf[16];
> > >                 char *p;
> > >                 unsigned char digest[32];
> > >                 EVP_MD_CTX *copy =3D EVP_MD_CTX_dup(ctx);
> > >
> > >                 p =3D buf + sizeof(buf);
> > >                 for (unsigned v =3D i; v; v /=3D 10)
> > >                         *--p =3D '0' + (v % 10);
> > >                 EVP_DigestUpdate(copy, p, buf + sizeof(buf) - p);
> > >                 EVP_DigestUpdate(copy, "\n", 1);
> > >                 EVP_DigestFinal_ex(copy, digest, NULL);
> > >                 EVP_MD_CTX_free(copy);
> > >                 if (memmem(digest, sizeof(digest), needle, sizeof(nee=
dle)))
> > >                         printf("%d\n", i);
> > >         }
> > > }
> >
> > Incrementing the MSB instead of the LSB (indexing naturally starts
> > with 1 in that case) seems to improve the performance, and it finds
> > different solutions, if the program is terminated early.
> > The rationale is that there is autocorrelation in the observations,
> > though I cannot judge what that means in this concrete example. The
> > speedup is not that dramatic here, so SHA256 seems to be pretty
> > random.
> >
> > #include <stdio.h>
> > #include <string.h>
> > #include <stdint.h>
> > #include <openssl/evp.h>
> >
> > #ifdef POLYFILL
> > EVP_MD_CTX *EVP_MD_CTX_dup(const EVP_MD_CTX *in)
> > {
> >     EVP_MD_CTX *out =3D EVP_MD_CTX_new();
> >
> >     if (out !=3D NULL && !EVP_MD_CTX_copy_ex(out, in)) {
> >         EVP_MD_CTX_free(out);
> >         out =3D NULL;
> >     }
> >     return out;
> > }
> > #endif
> >
> > #define REVERTED_BIT(n, position, width) (((n & (1 << position)) >>
> > position) << (width - position - 2))
> >
> > uint32_t revert_bits(uint32_t n, uint32_t width) {
> >     uint32_t result =3D 0;
> >     for (uint32_t i =3D 0; i < width; ++i) {
> >         result |=3D REVERTED_BIT(n, i, width);
> >     }
> >     return result;
> > }
> >
> > int main(int argc, const char **argv)
> > {
> >     const char needle[] =3D { 0xde, 0xad, 0xbe, 0xef };
> >     const EVP_MD *algo =3D EVP_sha256();
> >     EVP_MD_CTX *ctx =3D EVP_MD_CTX_new();
> >
> >     EVP_DigestInit_ex(ctx, algo, NULL);
> >     while (*++argv)
> >         EVP_DigestUpdate(ctx, *argv, strlen(*argv));
> >
> >     for (uint32_t n =3D 1; ; n++) {
> > #if (COUNTER_WIDTH !=3D 0)
> >         uint32_t i =3D revert_bits(n, COUNTER_WIDTH);
> > #else
> >         uint32_t i =3D n;
> > #endif
> >         // printf("%u %u\n", n, i);
> >         char buf[16];
> >         char *p;
> >         unsigned char digest[32];
> >         EVP_MD_CTX *copy =3D EVP_MD_CTX_dup(ctx);
> >
> >         p =3D buf + sizeof(buf);
> >         for (uint32_t v =3D i; v; v /=3D 10)
> >             *--p =3D '0' + (v % 10);
> >         EVP_DigestUpdate(copy, p, buf + sizeof(buf) - p);
> >         EVP_DigestUpdate(copy, "\n", 1);
> >         EVP_DigestFinal_ex(copy, digest, NULL);
> >         EVP_MD_CTX_free(copy);
> >         if (memmem(digest, sizeof(digest), needle, sizeof(needle)))
> >         {
> >             printf("counter width: %2u | n: %10u | i: %10u\n",
> > COUNTER_WIDTH, n, i);
> >             return 0;
> >         }
> >     }
> >     return 1;
> > }
> >
> > cc -DPOLYFILL -DCOUNTER_WIDTH=3D32 jk_evp.c -lssl -lcrypto -o jk_evp_ms=
b_32
> > cc -DPOLYFILL -DCOUNTER_WIDTH=3D31 jk_evp.c -lssl -lcrypto -o jk_evp_ms=
b_31
> > cc -DPOLYFILL -DCOUNTER_WIDTH=3D30 jk_evp.c -lssl -lcrypto -o jk_evp_ms=
b_30
> > cc -DPOLYFILL -DCOUNTER_WIDTH=3D29 jk_evp.c -lssl -lcrypto -o jk_evp_ms=
b_29
> > cc -DPOLYFILL -DCOUNTER_WIDTH=3D0 jk_evp.c -lssl -lcrypto -o jk_evp_0
> > counter width: 32 | n:  103832253 | i: 1588397616
> > counter width: 31 | n:   62413559 | i: 1003915120
> > counter width: 30 | n:  166340413 | i:  396135154
> > counter width: 29 | n:  137077701 | i:  171728193
> > counter width:  0 | n:  171728193 | i:  171728193
>
> I have to admit there is a bug in my previous code, it only works
> correctly for even numbers. It should have been:
>
> #define REVERTED_BIT(n, position, width) (((n & (1 << position)) >>
> position) << (width - position - 2 + (width & 1)))
>
> uint32_t revert_bits(uint32_t n, uint32_t width) {
>     uint32_t result =3D 0;
>     for (uint32_t i =3D 0; i < width; ++i) {
>         result |=3D REVERTED_BIT(n, i, width);
>     }
>     return result;
> }
>
> The actual performance measurements are:
> counter width: 32 | n:  103832253 | i: 1588397616
> counter width: 31 | n:  103832253 | i: 1588397616
> counter width: 30 | n:  166340413 | i:  396135154
> counter width: 29 | n:  166340413 | i:  396135154
> counter width: 28 | n:  268041599 | i: 2281045247 # 2**28 is close to
> the first finding when counting by incrementing the LSB, so this is
> slow.
> counter width: 27: This does not find anything, because 2**27 is lower
> than the first finding when counting by incrementing the LSB.
> counter width:  0 | n:  171728193 | i:  171728193 #
> math.log2(171728193) =3D 27.35555166834193

As an interim solution, it could make sense to leave small input
unmodified, and to permute large texts to get rid of the natural
language manifold.
