Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD52749D6
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769350932; cv=pass; b=eCzx9zzPFjKe4Fm5v9O9FSntbiNTI3SbAsCT1pTQpdNetsWfwy1YH5zwx9CQfMzI27NHOMjYFH6EnCL6BAtEqYePGuyAQiji+MZ4cVzAhPzT7XZ+6TCSIDzN+HRw4tNPFuy1+GMr44lemN104IYyF1TrhtbfvFbO9jWYc6ofaD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769350932; c=relaxed/simple;
	bh=9OReEzsWm62zN+I46iCi0M2OXuQxc0geMdpEN7f6JII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbp2CLmDvpbfDfArElGmkZi5Xy3FGUBHaQ02nIN12p8zxyQevHrmOvTAjUn3VBss5zj8bTOjDly1qwwalAoWO4sL++a9b/wxdlZgalABWmTAZvp9fvwcTsZm2YT/rD2Izk7FwuH5OUZjpbyo0LQzIlBpQVoYkWUcSAr+Lb8N8m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCnCGFJ0; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCnCGFJ0"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7942fca0da6so23784237b3.3
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 06:22:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769350930; cv=none;
        d=google.com; s=arc-20240605;
        b=YfAR0d9fPYZtGuBwTfzCWGiCNFbkpn8Xqu/qB3GJZ7obcL79oOwOLRwMo+2bJMC+yA
         jIcl9ueL+CRs7N3Iy66BwIOuiZ4lWj08k35/tztsMKfzTVIK3DbaQAbM/FiYkgLtk7MH
         zCyLUom9aqT0eBQoEPgnvYx2yiO79n8B6jfYcRkCqnSG9giz2ZHlezfBXxoVTn7RdEZA
         qKWJ4wvInsBWRfhg8BZ2CP+QoK+ZqLwDPZ2A1qlk0OhNRSzZaGiX6ImrqVElgsENAkHN
         UuFktz7tU4WYWgnaBM8jH3A6OgTcV93jObPBBrproYMzRry/PFyos0RR9HyI3B9bezpT
         b0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qHT2UybDx6wj8wmxk9jw2unb0V65zNvLIS1lZdz2+tA=;
        fh=3xxawToruWZEFpWQ02ixhWjVvoMtVVZ1wo4yJ5t5/gE=;
        b=FDw28+tnmLED3wZhOAv+ueBhOGTIl/+9xkOCqBv8Cy6ov159D9iCQYD4oc5Vhgm/97
         WvMtd2zQ3qABgqF8AASvADTymM+anz4Iox8mgd/KRyG5XYGsaRNyB/o/9d007np3pPjx
         1aEfQe/90qq5ulCz32Ceg/P5RizX6uXjnQ2dUn3TJkkQ0kc8lSOFfpsuG6SUyIfy2bQ6
         SuGDhJ52WRmaeRLB1XiXS50XqW0FY4keD7DDpYlSL1NCkci1N3osLADQWYBcLzffpaCr
         bxoQ+GAcWyEgWirCah/Bh0eYVOre27tGGj5w1JFEJWad75dwwuWgVhMGp1PLoiZVpzc1
         TBxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769350930; x=1769955730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHT2UybDx6wj8wmxk9jw2unb0V65zNvLIS1lZdz2+tA=;
        b=MCnCGFJ0waj1s/uBicJQheLmOLmk8byOng8MMVKrIfDHkDKwGENLapxlkdC9nsrL6c
         dsWhNSxwy3aU8wBvxSenNEFPFjnE3lp/gBJL0IHOD+4qlDQ5HPPTC7S+t+6vk9Dc5iQM
         yHJF7WWejaKmeVtPfeVM8xg5I+6m0bHUfEMwZaUGm7IGPmfSQHZJ3xjzQWCjIzbJIMVx
         mqDBYFHD4M+kxaiI/RG5v9J4Gs8wwV/yUV6c1fVSCbOdQqGHyznLfxYlq+LsAseCPYaD
         QiFGaFtrzi3KcfavljK/SD5tmtBHcL8U4SYAeXc4pCO0t+KGeQDHs1Y9mePjPmU5BTmN
         Y1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769350930; x=1769955730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qHT2UybDx6wj8wmxk9jw2unb0V65zNvLIS1lZdz2+tA=;
        b=E0d7DT9tSvGt+VTadbQDZhyGMZbq4GjFm4i/OFwkAfFcit12wgRxNO0kNfODL/KxVf
         LfyXM1YjOzopdbl3jx6qU8sZ/r3Mpc8PW6TOj06mv9cq8ZC+hWIkswIblJNPDIqk8aWG
         EobJKAUK2mlyYk6Z8YT8zIFTUNjAtex2GGdI7UewvHSXuOfwrXUeoXasl88KqCI7RCes
         OzFl5frRSnoeRfCNcNhLoR61KMbaumlsyiOEigLG8v4aOWlXI0aZOlplPiuHEhkW0Tjd
         ZXsmXfefwGXAyzriVZhkM0Hnp9W3+AL5tlCo+540DWlat5kxRibyR5RBssfUGPyyQMwG
         ySyA==
X-Forwarded-Encrypted: i=1; AJvYcCVM6gfydmq8e6tLXoV88FOKbvXRFup5EOpP9CL8n9cZ1V2YhEJdjvl9v3jFqWNymr02yOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+7x4DHPMjsYVyq8p/wdmdduc+Pk7w9jKtADebdIkIeO7859h
	jboUOGhdGVEqDcu4HvaInWeGb1cYgx4E2QIr8/FI4hj+9mXEJh31hYN+hhTjz9EcipzKHCAEYYw
	GdOAAUeCFdaUsXCipTb9uyiFhWBLQfmYMUA==
X-Gm-Gg: AZuq6aKz0zcvsNnfjXL2O2gQRSDX4Gz4b7r3pkU17PIvBBtfa3+rs0Gyu+RxR9q0Yyk
	RDFhrN3JCz49tBUJTZGGXR/Cn9WG3ZoYtIe+1MKI6GJFSMYVK+JnTEBFCEa5gsIsvyRpX5Qr1y3
	KMeoE0kOkGO78wxbED3vFuObeGiSUlxn4Bbn9MX2M+oufh0PRP/iIbQeUhO04yrEbNsOsZKvR5P
	j77EfnP5jQRPofGrh7xPx+LkT4PU4s3ce8BS9VoDs4+KbB0ApC6+UeSOatcTUA4HXAO914cUQH2
	eSPe
X-Received: by 2002:a05:690c:6604:b0:792:7113:a305 with SMTP id
 00721157ae682-7945a8a1816mr14630687b3.29.1769350929568; Sun, 25 Jan 2026
 06:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADMnYXDDbVBwZgETsFhwkOyn8cM8QU4+YQs2rRfTac6ec49-5A@mail.gmail.com>
 <20260123210643.GA2728629@coredump.intra.peff.net> <xmqq8qdogdmu.fsf@gitster.g>
 <20260124072814.GA3455597@coredump.intra.peff.net> <CADMnYXA6_uCZU42NR2vFKM9uhfaWOdu0tkzPi6Ya8WW2rzknGg@mail.gmail.com>
 <CADMnYXAF5VV9jKbxm1rduR-x96TFEso572zCAVOU-JoMpnX1tg@mail.gmail.com> <CADMnYXDBSTDHynvVcpfpU79V=BXNOksi1W0pHFRWgZBkqTf5Hw@mail.gmail.com>
In-Reply-To: <CADMnYXDBSTDHynvVcpfpU79V=BXNOksi1W0pHFRWgZBkqTf5Hw@mail.gmail.com>
From: Klaus Sembritzki <klausem@gmail.com>
Date: Sun, 25 Jan 2026 15:21:57 +0100
X-Gm-Features: AZwV_QiMYRXs8awelTzeajmhFuxG3FoCPj9kc1q6qZJ5b4gGz8wWcl7_faQl8_c
Message-ID: <CADMnYXByAseQWja24JpfRaKGU1=v+d5b_J+EEXRV_iv1gEY3og@mail.gmail.com>
Subject: Re: The SHA256 of "xy\n" (ASCII, no CRLF) contains 1337, ACBAD in za,
 and I am 1aa
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If vanilla-SHA256 continues to be used in vanilla-Git in the future, I
suggest that platforms like GitHub hash internally.

On Sun, Jan 25, 2026 at 12:25=E2=80=AFPM Klaus Sembritzki <klausem@gmail.co=
m> wrote:
>
> On Sun, Jan 25, 2026 at 10:47=E2=80=AFAM Klaus Sembritzki <klausem@gmail.=
com> wrote:
> >
> > On Sat, Jan 24, 2026 at 10:25=E2=80=AFAM Klaus Sembritzki <klausem@gmai=
l.com> wrote:
> > >
> > > On Sat, Jan 24, 2026 at 8:28=E2=80=AFAM Jeff King <peff@peff.net> wro=
te:
> > > >
> > > > On Fri, Jan 23, 2026 at 02:36:41PM -0800, Junio C Hamano wrote:
> > > >
> > > > > Jeff King <peff@peff.net> writes:
> > > > >
> > > > > > On Fri, Jan 23, 2026 at 09:16:46PM +0100, Klaus Sembritzki wrot=
e:
> > > > > >
> > > > > >> $ # My initials (ks): 1aa
> > > > > >> $ echo ks | sha256sum
> > > > > >> $ 1aa44e718d5bc9b7ff2003dbbb6f154e16636d5c2128ffce4751af5124b6=
5337
> > > > > >>
> > > > > >> $ # 50566750337
> > > > > >> $ echo thinking | sha256sum
> > > > > >> $ 50566750337beb9e98e553fd9196d10576f9eb0cbc6b66e2586b9d73af4f=
352f
> > > > > >
> > > > > > Oh man, I've got deadbeef!
> > > > > >
> > > > > >   $ echo jk35252822 | sha256sum
> > > > > >   33f1a74529870456c56ad97c59cfed6bdeadbeef9b9bc3f4ff49bb203e36f=
96b
> > > > > >
> > > > > > What could it all mean?
> > > > >
> > > > > Sorry, but I have to admit that I completely lack humor receptor
> > > > > cells.
> > > >
> > > > Probably because it was not that funny. :)
> > > >
> > > > The original message seemed to be looking for Numerology-style mean=
ings
> > > > in random data. I wasn't sure if it was serious or not, but I could=
 not
> > > > resist either playing along (if not) or trolling (if so).
> > > >
> > > > But here's my deadbeef brute-force program for fun.
> > > >
> > > > -Peff
> > > >
> > > > -- >8 --
> > > > #include <stdio.h>
> > > > #include <string.h>
> > > > #include <openssl/evp.h>
> > > >
> > > > int main(int argc, const char **argv)
> > > > {
> > > >         const char needle[] =3D { 0xde, 0xad, 0xbe, 0xef };
> > > >         const EVP_MD *algo =3D EVP_sha256();
> > > >         EVP_MD_CTX *ctx =3D EVP_MD_CTX_new();
> > > >
> > > >         EVP_DigestInit_ex(ctx, algo, NULL);
> > > >         while (*++argv)
> > > >                 EVP_DigestUpdate(ctx, *argv, strlen(*argv));
> > > >
> > > >         for (unsigned i =3D 0; ; i++) {
> > > >                 char buf[16];
> > > >                 char *p;
> > > >                 unsigned char digest[32];
> > > >                 EVP_MD_CTX *copy =3D EVP_MD_CTX_dup(ctx);
> > > >
> > > >                 p =3D buf + sizeof(buf);
> > > >                 for (unsigned v =3D i; v; v /=3D 10)
> > > >                         *--p =3D '0' + (v % 10);
> > > >                 EVP_DigestUpdate(copy, p, buf + sizeof(buf) - p);
> > > >                 EVP_DigestUpdate(copy, "\n", 1);
> > > >                 EVP_DigestFinal_ex(copy, digest, NULL);
> > > >                 EVP_MD_CTX_free(copy);
> > > >                 if (memmem(digest, sizeof(digest), needle, sizeof(n=
eedle)))
> > > >                         printf("%d\n", i);
> > > >         }
> > > > }
> > >
> > > Incrementing the MSB instead of the LSB (indexing naturally starts
> > > with 1 in that case) seems to improve the performance, and it finds
> > > different solutions, if the program is terminated early.
> > > The rationale is that there is autocorrelation in the observations,
> > > though I cannot judge what that means in this concrete example. The
> > > speedup is not that dramatic here, so SHA256 seems to be pretty
> > > random.
> > >
> > > #include <stdio.h>
> > > #include <string.h>
> > > #include <stdint.h>
> > > #include <openssl/evp.h>
> > >
> > > #ifdef POLYFILL
> > > EVP_MD_CTX *EVP_MD_CTX_dup(const EVP_MD_CTX *in)
> > > {
> > >     EVP_MD_CTX *out =3D EVP_MD_CTX_new();
> > >
> > >     if (out !=3D NULL && !EVP_MD_CTX_copy_ex(out, in)) {
> > >         EVP_MD_CTX_free(out);
> > >         out =3D NULL;
> > >     }
> > >     return out;
> > > }
> > > #endif
> > >
> > > #define REVERTED_BIT(n, position, width) (((n & (1 << position)) >>
> > > position) << (width - position - 2))
> > >
> > > uint32_t revert_bits(uint32_t n, uint32_t width) {
> > >     uint32_t result =3D 0;
> > >     for (uint32_t i =3D 0; i < width; ++i) {
> > >         result |=3D REVERTED_BIT(n, i, width);
> > >     }
> > >     return result;
> > > }
> > >
> > > int main(int argc, const char **argv)
> > > {
> > >     const char needle[] =3D { 0xde, 0xad, 0xbe, 0xef };
> > >     const EVP_MD *algo =3D EVP_sha256();
> > >     EVP_MD_CTX *ctx =3D EVP_MD_CTX_new();
> > >
> > >     EVP_DigestInit_ex(ctx, algo, NULL);
> > >     while (*++argv)
> > >         EVP_DigestUpdate(ctx, *argv, strlen(*argv));
> > >
> > >     for (uint32_t n =3D 1; ; n++) {
> > > #if (COUNTER_WIDTH !=3D 0)
> > >         uint32_t i =3D revert_bits(n, COUNTER_WIDTH);
> > > #else
> > >         uint32_t i =3D n;
> > > #endif
> > >         // printf("%u %u\n", n, i);
> > >         char buf[16];
> > >         char *p;
> > >         unsigned char digest[32];
> > >         EVP_MD_CTX *copy =3D EVP_MD_CTX_dup(ctx);
> > >
> > >         p =3D buf + sizeof(buf);
> > >         for (uint32_t v =3D i; v; v /=3D 10)
> > >             *--p =3D '0' + (v % 10);
> > >         EVP_DigestUpdate(copy, p, buf + sizeof(buf) - p);
> > >         EVP_DigestUpdate(copy, "\n", 1);
> > >         EVP_DigestFinal_ex(copy, digest, NULL);
> > >         EVP_MD_CTX_free(copy);
> > >         if (memmem(digest, sizeof(digest), needle, sizeof(needle)))
> > >         {
> > >             printf("counter width: %2u | n: %10u | i: %10u\n",
> > > COUNTER_WIDTH, n, i);
> > >             return 0;
> > >         }
> > >     }
> > >     return 1;
> > > }
> > >
> > > cc -DPOLYFILL -DCOUNTER_WIDTH=3D32 jk_evp.c -lssl -lcrypto -o jk_evp_=
msb_32
> > > cc -DPOLYFILL -DCOUNTER_WIDTH=3D31 jk_evp.c -lssl -lcrypto -o jk_evp_=
msb_31
> > > cc -DPOLYFILL -DCOUNTER_WIDTH=3D30 jk_evp.c -lssl -lcrypto -o jk_evp_=
msb_30
> > > cc -DPOLYFILL -DCOUNTER_WIDTH=3D29 jk_evp.c -lssl -lcrypto -o jk_evp_=
msb_29
> > > cc -DPOLYFILL -DCOUNTER_WIDTH=3D0 jk_evp.c -lssl -lcrypto -o jk_evp_0
> > > counter width: 32 | n:  103832253 | i: 1588397616
> > > counter width: 31 | n:   62413559 | i: 1003915120
> > > counter width: 30 | n:  166340413 | i:  396135154
> > > counter width: 29 | n:  137077701 | i:  171728193
> > > counter width:  0 | n:  171728193 | i:  171728193
> >
> > I have to admit there is a bug in my previous code, it only works
> > correctly for even numbers. It should have been:
> >
> > #define REVERTED_BIT(n, position, width) (((n & (1 << position)) >>
> > position) << (width - position - 2 + (width & 1)))
> >
> > uint32_t revert_bits(uint32_t n, uint32_t width) {
> >     uint32_t result =3D 0;
> >     for (uint32_t i =3D 0; i < width; ++i) {
> >         result |=3D REVERTED_BIT(n, i, width);
> >     }
> >     return result;
> > }
> >
> > The actual performance measurements are:
> > counter width: 32 | n:  103832253 | i: 1588397616
> > counter width: 31 | n:  103832253 | i: 1588397616
> > counter width: 30 | n:  166340413 | i:  396135154
> > counter width: 29 | n:  166340413 | i:  396135154
> > counter width: 28 | n:  268041599 | i: 2281045247 # 2**28 is close to
> > the first finding when counting by incrementing the LSB, so this is
> > slow.
> > counter width: 27: This does not find anything, because 2**27 is lower
> > than the first finding when counting by incrementing the LSB.
> > counter width:  0 | n:  171728193 | i:  171728193 #
> > math.log2(171728193) =3D 27.35555166834193
>
> As an interim solution, it could make sense to leave small input
> unmodified, and to permute large texts to get rid of the natural
> language manifold.
