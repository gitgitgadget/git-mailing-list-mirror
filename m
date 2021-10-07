Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D958BC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BB6610C7
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbhJGUCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:02:06 -0400
Received: from mout.web.de ([212.227.15.3]:55843 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241535AbhJGUCE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633636805;
        bh=Nygl2AOxX8Fq49/qNchkRMXEh/ig4nvwM9gxhDyK01k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Do346v70t7CvqwX6MuERUilI4n8z1fSFitd8X0JZ6Qw0QLoI9ePqwHeewSX0t2K1W
         P8Op+LXsXnjyNkkxLpa70dXtip9IBCW5Yz7jlPthCnD+M9bGTA5qTihlODE7zmsNJz
         Ad1diR2akyx64BrHqog/NVshLG7cEhr89MNxFOvI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MkVwo-1nCuGR2aD8-00ltP0; Thu, 07 Oct 2021 22:00:05 +0200
Subject: Re: [PATCH 3/9] test-mergesort: add test subcommand
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <522fba5e-1048-3377-45c1-7107b55dc6e1@web.de> <xmqq7dew7aqd.fsf@gitster.g>
 <87o887q0s9.fsf@evledraar.gmail.com>
 <850aa059-61d9-0eba-5809-e0c27a19dfb4@web.de> <xmqqee9210a1.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a3eeb255-56e3-eb22-ebf7-e9f04c95fa44@web.de>
Date:   Thu, 7 Oct 2021 22:00:04 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqee9210a1.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A7QlMVeRAY3jCsTxSw2j9YJ0y2Tssc+OwS3DGqgG5Mgbwz4wtXv
 rW9+Ufi+egNEDzqDN9L15ycSCY4O+A/e3/i1sD8rS4p/uh/r9PBxOUH3W89hMsKTrmTvyDT
 Dl1zY9CZ1ZbTjecBMpecSk3Yf7f/hEASj/XZg859LJfWTfYzogcNFUGPjjc+ZJRExnpWlPa
 ni25upeRs2Q9Yx9zzJ5tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sIT5wIO2HWQ=:CrTwh2Ek0Qs4yeoK3BxmNO
 dnUxN0xpJW5B5cviH2zgtlEiIcfcW0kdPKpTi8gCzZpDACT4a3iKK2ynTQzIYX2aiLdJ3Wvmi
 QJjdnl0H+SrFnWArnwVmpP/zo+tuyCfGHHbQYflxymvV8ZqCntcGkePtIPGRe5DxjhbzzS3tA
 RuF9PitKWZJDQ7m1567Ga1RAlwefo2iZqdso4logyAWVS5u+2IkGDfruxdROFg7gW8ncYfPUq
 mwV4gA1tbcrVhAXodXq7SmDfLn8RVOS1AZJiwUJaR+UPhmgo40hwqHC4VkHILcpIzpgYLzIfB
 PxF23BVuBBFkwCmdpZ/EFjKlyus3731viTJo05p8tzJmwrp+izzIkX1/OonWLkaVHLTqN5jtW
 LJ4kpxOhNlvJ9IQK661po7D3EV1gZ5EEzn/3y6MHO1DjfiN8WAIHpDA5fHzLN7YgH+0gG1leZ
 tBUHRmm6Ggp+joRiJPAhQNxUT9zkV0D5Kfgq93ef/M0a3v2XSsYQ+UOGog6BUQKuEQStuyJaY
 KhqifkcRxTvKABVLbKvmPoCVvRjb6d0Bv9pOzTlpzlznJfyBq3JPXItq76Ii9v/PpRtm/M8+v
 ShQi0af2uo7TztCUaIz9X9kWe/PzwSzVqAitdIhwbO9gid1ed0SF+LHJ8KAn65Bu1Hmd0D/ZI
 k+/PNZc+5z3h3ux/iiRbMvniwXICiktqGKKS1FpwS/aPPHFxYmx9m94ZsMyGMvtd4pEKhJ0wM
 p9HBbJ6zwUXPAS5vluZn2/aNMbVZR/PSF4itf1KkdSWAZueXVEFQ7ZQ9hvJf4+Cyg0c8KRr1W
 Sdr96Qg39kJyGdZj+VUelS0Y7TyDgVQKIUNUZQzTRWY8NJsybgDrdBxMXP1apavHST1qlP4dF
 aCiJUeabwagouegNhanYzwiDJ9qgIyMIobY5TLqb3B/AYDmO+bmfQQijPSuFKgJAHfs/zhTnc
 ucQ299VhrlRdMZNyUnyLqCS0Po1/W8BV/Nz/VbzdYpvdGRQs4oTE360gJQ15oL1piQakigu0T
 fDGB6IteU+byoLGVOnnZMbGUcmInRoNGyY5gUfNix7Wa+HbZqze1xOaKH7z+gBGiAw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.10.21 um 19:33 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Repeatable tests are not essential (the original paper didn't mention
>> seeding), but shouldn't be much trouble to implement and would simplify
>> comparisons across versions, systems and among testers.
>>
>> The only downside I can think of is that it may perhaps also simplify
>> over-fitting, i.e. I might find micro-tweaks that only work for our
>> specific rand() sequence and then misinterpret them as general
>> improvements..
>
> Yup, I think you summarized the pros-and-cons nicely.

Seeing that the series is in next already, here's a bonus patch for
that.

=2D-- >8 ---
Subject: [PATCH 10/9] test-mergesort: use repeatable random numbers

Use MINSTD to generate pseudo-random numbers consistently instead of
using rand(3), whose output can vary from system to system, and reset
its seed before filling in the test values.  This gives repeatable
results across versions and systems, which simplifies sharing and
comparing of results between developers.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-mergesort.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 43ec74e2d3..8d128ae437 100644
=2D-- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -2,6 +2,12 @@
 #include "cache.h"
 #include "mergesort.h"

+static unsigned int minstd_rand(unsigned int *state)
+{
+	*state =3D (uint64_t)*state * 48271 % 2147483647;
+	return *state;
+}
+
 struct line {
 	char *text;
 	struct line *next;
@@ -60,8 +66,9 @@ static void dist_sawtooth(int *arr, int n, int m)
 static void dist_rand(int *arr, int n, int m)
 {
 	int i;
+	unsigned int seed =3D 1;
 	for (i =3D 0; i < n; i++)
-		arr[i] =3D rand() % m;
+		arr[i] =3D minstd_rand(&seed) % m;
 }

 static void dist_stagger(int *arr, int n, int m)
@@ -81,8 +88,9 @@ static void dist_plateau(int *arr, int n, int m)
 static void dist_shuffle(int *arr, int n, int m)
 {
 	int i, j, k;
+	unsigned int seed =3D 1;
 	for (i =3D j =3D 0, k =3D 1; i < n; i++)
-		arr[i] =3D (rand() % m) ? (j +=3D 2) : (k +=3D 2);
+		arr[i] =3D minstd_rand(&seed) % m ? (j +=3D 2) : (k +=3D 2);
 }

 #define DIST(name) { #name, dist_##name }
=2D-
2.33.0

