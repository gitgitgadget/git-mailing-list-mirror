Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C4A20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 15:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbdFAP6C (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 11:58:02 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34096 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdFAP6A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 11:58:00 -0400
Received: by mail-pf0-f179.google.com with SMTP id 9so30895263pfj.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4e+OID2BMTOfw4SLQTDeVYwi10UrbqiSWFNP6wsIjFU=;
        b=BrD5qr0cO+wjSVM6JMz+ZG14elrmDxtVtBzLYQM1Z/NRlQ3je0VoeyZDTDyJzMoOHy
         LJ1COc1sRH2nWHjqF8z86l8ONbfj6nXTQNLVlsOSn+3ybT/Rxx/ncRvgeheA1Wr4BgVz
         tlLmAAH0fezxe6sMjGdvohi6wlK6knW6/Mr23Bgo8jBpLt/iOUi9+qvyVRYdo5sr2lX+
         H6m7ODAMALjCNPc+dTEnYZIkER8u8tqD63UKsvtmKzIzoA+sSuYBeYAXn27ljc8DTkoK
         SUG9McNkcS4Se8Y3QoVTI/kwWO5PGfn0Ko3eDqK1nvV1uqSVAgxU0BQuVc14fj1koNQK
         YZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4e+OID2BMTOfw4SLQTDeVYwi10UrbqiSWFNP6wsIjFU=;
        b=VfUcXC/QZeEjqDCCplIcaZOgACNP/eACh3h3OTFNFp0tI5GuFSSghgHlPGBxYddlBK
         Ec5rERADbl1vpCo2W9f+8CByXHsqxf2bORIq0TKLq41v+ogIFuIp4DC7xgvAHvAKu8JR
         P8OA6lmR5yQ0gHyDCL6UjuIyx+Jrs2LPb0nuOSv8rK9h8b9/ScLyQfDCf/TepUgpk9Vt
         pkhycrEO8WyFL9JDeVnpEbz7781xiKZbFEmqlgx/+Ml+qVz2OmL6AoInBItNT+IV0iQk
         fPQAGtBZwz6l1ojYe0MIPP+qKPLKemfRn9Jl4F2MtZniJ7m27AsJ5jlBtDQ6suRBXmIx
         P9nA==
X-Gm-Message-State: AODbwcAuAR7vCXDHSLzaVax5x/HHDh0BrX6Bc2Wo8xVzFJI9gljHrfeP
        5ATWHgaxANUVizWAPfDkRggoWpGM5w==
X-Received: by 10.98.62.65 with SMTP id l62mr1679085pfa.114.1496332669406;
 Thu, 01 Jun 2017 08:57:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.137.233 with HTTP; Thu, 1 Jun 2017 08:57:48 -0700 (PDT)
In-Reply-To: <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
References: <mvm4lw0un5n.fsf@suse.de> <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> <mvmmv9st3yv.fsf@suse.de>
 <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
 <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com> <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 1 Jun 2017 17:57:48 +0200
Message-ID: <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
Subject: Re: Unaligned accesses in sha1dc
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Andreas Schwab <schwab@suse.de>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1 June 2017 at 13:53, Martin =C3=85gren <martin.agren@gmail.com> wrote:
> On 1 June 2017 at 12:33, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
>> On Thu, Jun 1, 2017 at 12:26 PM, Martin =C3=85gren <martin.agren@gmail.c=
om> wrote:
>>> On 1 June 2017 at 12:08, Andreas Schwab <schwab@suse.de> wrote:
>>>> Even if the architecture implements unaligned accesses in hardware, it
>>>> is still undefined behaviour, and the compiler will (eventually) take
>>>> advantage of it.
>>>
>>> I tried to optically follow the macros and ended up on line 87/89 in
>>> lib/sha1.c of the sha1dc-library, where there is undefined behavior if
>>> the address is unaligned, which it seems it could be. Maybe Git uses
>>> some particular combination of macro-definitions and I went down the
>>> wrong path... There might also be other spots; I haven't thrown UBSan
>>> at the code.
>>>
>>> Using memcpy on those lines should not be a performance problem on
>>> platforms where unaligned access is ok, of course assuming the
>>> compiler sees the opportunity.
>>
>> This is what the upstream version of sha1dc now in the next branch
>> does, i.e. just does a memcpy() on platforms which aren't on a
>> whitelist of CPUs that allow unaligned access.
>
> Ok, now I get it. Undefined behavior can occur on line 1772 in
> sha1dc/sha1.c on "next", but only if SHA1DC_ALLOW_UNALIGNED_ACCESS is
> defined. I don't think the macro does what its name suggests, though.
> To me, it behaves more like
> SHA1DC_RELY_ON_UNDEFINED_BEHAVIOR_TO_DO_THE_RIGHT_THING_BY_CHANCE...
>
> So it seems the call chain of commands and macros could be redesigned
> to work with "char*" instead of "uint32_t*"... Then the lines I
> mentioned earlier could be converted to memcpy and "should" be
> compiled to efficient loads where possible. Yes, I know, patches speak
> for themselves, and no, this mail is not a patch.

I looked into this some more. It turns out it is possible to trigger
undefined behavior on "next". Here's what I did:

diff --git a/Makefile b/Makefile
index 7c621f7..e3fdad0 100644
--- a/Makefile
+++ b/Makefile
@@ -402,7 +402,7 @@ GIT-VERSION-FILE: FORCE

 # CFLAGS and LDFLAGS are for the users to override from the command line.

-CFLAGS =3D -g -O2 -Wall
+CFLAGS =3D -g -O2 -Wall -fsanitize=3Dundefined -fsanitize-recover=3Dundefi=
ned
 DEVELOPER_CFLAGS =3D -Werror \
     -Wdeclaration-after-statement \
     -Wno-format-zero-length \
@@ -412,7 +412,7 @@ DEVELOPER_CFLAGS =3D -Werror \
     -Wstrict-prototypes \
     -Wunused \
     -Wvla
-LDFLAGS =3D
+LDFLAGS =3D -fsanitize=3Dundefined -fsanitize-recover=3Dundefined
 ALL_CFLAGS =3D $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS =3D $(LDFLAGS)
 STRIP ?=3D strip
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index a1c13f5..d4e1463 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -24,6 +24,8 @@ int cmd_main(int ac, const char **av)
         if (bufsz < 1024)
             die("OOPS");
     }
+    buffer++;
+    bufsz--;

     git_SHA1_Init(&ctx);



Then I ran

$ ./test-sha1 < ../t0013/shattered-1.pdf

in t/helper. No doubt an experienced Git developer would not patch the
Makefile and would not run the test like that, but that's what I did.
UBSan reports an unaligned load (the UB happened already as the
pointer was cast). Of course, tweaking the alignment of "buffer" is
cheating, but similar alignments can supposedly occur in the wild, or
the bug reports wouldn't be coming in.

This "fixes" the problem:

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 3dff80a..d6f4c44 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -66,9 +66,9 @@
 #define sha1_mix(W, t)  (rotate_left(W[t - 3] ^ W[t - 8] ^ W[t - 14]
^ W[t - 16], 1))

 #ifdef SHA1DC_BIGENDIAN
-    #define sha1_load(m, t, temp)  { temp =3D m[t]; }
+    #define sha1_load(m, t, temp)  { memcpy(&temp, m+t*4, 4); }
 #else
-    #define sha1_load(m, t, temp)  { temp =3D m[t]; sha1_bswap32(temp); }
+    #define sha1_load(m, t, temp)  { memcpy(&temp, m+t*4, 4);
sha1_bswap32(temp); }
 #endif

 #define sha1_store(W, t, x)    *(volatile uint32_t *)&W[t] =3D x
@@ -309,7 +309,7 @@ static void sha1_compression_W(uint32_t ihv[5],
const uint32_t W[80])



-void sha1_compression_states(uint32_t ihv[5], const uint32_t m[16],
uint32_t W[80], uint32_t states[80][5])
+void sha1_compression_states(uint32_t ihv[5], const uint8_t m[64],
uint32_t W[80], uint32_t states[80][5])
 {
     uint32_t a =3D ihv[0], b =3D ihv[1], c =3D ihv[2], d =3D ihv[3], e =3D=
 ihv[4];
     uint32_t temp;
@@ -1639,7 +1639,7 @@ static void sha1_recompression_step(uint32_t
step, uint32_t ihvin[5], uint32_t i



-static void sha1_process(SHA1_CTX* ctx, const uint32_t block[16])
+static void sha1_process(SHA1_CTX* ctx, const uint8_t block[64])
 {
     unsigned i, j;
     uint32_t ubc_dv_mask[DVMASKSIZE] =3D { 0xFFFFFFFF };
@@ -1759,7 +1759,7 @@ void SHA1DCUpdate(SHA1_CTX* ctx, const char*
buf, size_t len)
     {
         ctx->total +=3D fill;
         memcpy(ctx->buffer + left, buf, fill);
-        sha1_process(ctx, (uint32_t*)(ctx->buffer));
+        sha1_process(ctx, (uint8_t*)(ctx->buffer));
         buf +=3D fill;
         len -=3D fill;
         left =3D 0;
@@ -1769,10 +1769,10 @@ void SHA1DCUpdate(SHA1_CTX* ctx, const char*
buf, size_t len)
         ctx->total +=3D 64;

 #if defined(SHA1DC_ALLOW_UNALIGNED_ACCESS)
-        sha1_process(ctx, (uint32_t*)(buf));
+        sha1_process(ctx, (uint8_t*)(buf));
 #else
         memcpy(ctx->buffer, buf, 64);
-        sha1_process(ctx, (uint32_t*)(ctx->buffer));
+        sha1_process(ctx, (uint8_t*)(ctx->buffer));
 #endif /* defined(SHA1DC_ALLOW_UNALIGNED_ACCESS) */
         buf +=3D 64;
         len -=3D 64;
@@ -1809,7 +1809,7 @@ int SHA1DCFinal(unsigned char output[20], SHA1_CTX *c=
tx)
     ctx->buffer[61] =3D (unsigned char)(total >> 16);
     ctx->buffer[62] =3D (unsigned char)(total >> 8);
     ctx->buffer[63] =3D (unsigned char)(total);
-    sha1_process(ctx, (uint32_t*)(ctx->buffer));
+    sha1_process(ctx, (uint8_t*)(ctx->buffer));
     output[0] =3D (unsigned char)(ctx->ihv[0] >> 24);
     output[1] =3D (unsigned char)(ctx->ihv[0] >> 16);
     output[2] =3D (unsigned char)(ctx->ihv[0] >> 8);
diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
index a0ff5d1..1d181a1 100644
--- a/sha1dc/sha1.h
+++ b/sha1dc/sha1.h
@@ -18,7 +18,7 @@ extern "C" {

 /* sha-1 compression function that takes an already expanded message,
and additionally store intermediate states */
 /* only stores states ii (the state between step ii-1 and step ii)
when DOSTORESTATEii is defined in ubc_check.h */
-void sha1_compression_states(uint32_t[5], const uint32_t[16],
uint32_t[80], uint32_t[80][5]);
+void sha1_compression_states(uint32_t[5], const uint8_t[64],
uint32_t[80], uint32_t[80][5]);

 /*
 // Function type for sha1_recompression_step_T (uint32_t ihvin[5],
uint32_t ihvout[5], const uint32_t me2[80], const uint32_t state[5]).



With this diff, various tests which seem relevant for SHA-1 pass,
including t0013, and the UBSan-error is gone. The second diff is just
a monkey-patch. I have no reason to believe I will be able to come up
with a proper and complete patch for sha1dc. And I guess such a thing
would not really be Git's patch to carry, either. But at least Git
could consider whether to keep relying on undefined behavior or not.

There's a fair chance I've mangled the whitespace. I'm using gmail's
web interface... Sorry about that.
