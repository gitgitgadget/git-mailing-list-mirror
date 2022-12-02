Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F7EC4708E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 16:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiLBQAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 11:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiLBQAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 11:00:11 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5538AAC5
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 08:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669996797; bh=zqY0Sdd6Z4T4SP4j1lA033txyXmfjermUYRXg7b3MVA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iLnuSUekbvP2M2W5OZ+cx3wSVBo90kTBcFwUZ+WHhZlPjcwwuLT+ZPxPeIis1QfZD
         ehxs3MeuQfEss+8uJAGXJcaSZKAutTzy3NZTb4wsd7nklgC+hI4ZfCnLDAPIHHI/He
         SU7v3xKZuX5QQ3NmbGRhxjH39VIvaqH+uPkH6MkxjNQO/uthP7aHCDb3xiPILpCdX1
         fQGZzkgicE23yVf2XnwVZ2E/usjhnGGZKp/rlf96zC2npsia1XGxkvbwRqxi9MCl3E
         9fTly9KkYwD5UIRUmfCYpIqi5HrlMXMOUwl6bBwqtyjF3Bsin26a3AEjRyuL/WGDOC
         Nf2KwN61FCuvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZnl-1oRGOv49hV-00cauD; Fri, 02
 Dec 2022 16:59:57 +0100
Message-ID: <674c54d5-2458-5e11-debb-9f88489be089@web.de>
Date:   Fri, 2 Dec 2022 16:59:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 4/8] t/lib-patch-mode.sh: fix ignored exit codes
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
        <tboegi@web.de>
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
 <patch-v3-4.8-c080899dd5f-20221202T114733Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v3-4.8-c080899dd5f-20221202T114733Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3wG2mV5DML9Ec6A6jNvOma+j0xGC8AsEL1yh6rc9UrgzPDr4UUO
 93z0MlBH1eRhuS+XwVxdA1bv3tAEZ7oMfUJ+7WXPRx/BTEVN2buKiTFArnIzxxBdOsWwAHd
 CvUGUHNVvFTSBAxT2wHBIOJSM8x+c4D8aCeoeycvl7RVVC1dGqWqDvucKFZPcxYBIVvOAqH
 54QEMpcAYNURlGymgJ5YQ==
UI-OutboundReport: notjunk:1;M01:P0:LttiaQdAYhU=;Tb8Ir46tg0vxdQpg22nYhl2xcj9
 Iocp5Ais92BxVnWHiGF8BXVNJ9z6SFQJGwWZMq7eOmwrjYtYM38/oIiS0rky6bEjahw6WHY1B
 XYfttRIOYZJqnuvX9LgUu0Brwgmzifo7F9vlmC4aBtrzTT5D2WeK0jmIkKl/3lE2joz9SHnk4
 XT6zlYvdb4YBNp5pCs15WOHbUiFRMeyKedT0w/OTnAumjQI0mnFJGAlQVvkpbVyL04p7W3oiB
 ize5FAIUbSZSVz3lvjsfKN1dUwG7KITIoWRn6/HaZ+lS2KpoMo1WfRUFSw2GX8RRrfOhNK/gC
 zBLyDr9fsebiChmVk9ABM0VIjGp413GOVd/vTgB1qOUeJPzQkdSCioPiiJCLqjPqX0OcVpplA
 reAtGw3Iv0Ky8/nh1e1bZEcPto57FLIY8uY9t4rAcJ87zrQsLkJJx0NOXz2ovuIqDu1j1hs5V
 rRfPEDhjnyAzSKV1XtAIQycxm1l9FMPLEPtIEJzI3532BU3ZI6vDRkCoE3NMm8NQxw3pzNGb8
 l+U7SCwbciU0udPANXUtm3TcWEEiXp+6+Eng7HgnoTynzfLKOwlNbXeAbPY81Nd4xvRyh+ER7
 KkcmVCtcOKoKPLBCGVGKgyiEqRnA4t6BlmNbJxSzlgNyVHZjyqN0S/UBrXoE05ig0CeFI9Eac
 6U1EV9N5w2wSVTP5/Vrq5/wmNDObYa1IAHi4f4Igu5vym7tcOoLVgIlsybEMiNbSeA0h0Ghjf
 FGqBLh+UOBlWL0acXJlbVPmoLj6o7a2cL3meVth5ezuVDY1kd6B7UHDv2Zpy5U5PSSfrjYJe5
 tRnePzOK5tOeSPhhHPbcu/aFOtC9wYppnQ78T43fyorMa7KaTTg+J+S0SMXlLE7rAZL/8WSTK
 Lxeh7v5FSVcQbtlTrtsFPgNY7+w3SqOJjxfODNLz88vhi1pbbMnjwawQ3VGrR9BCL4z1Vbmhw
 GsgZIqlPmKSO+0d8a8LAWKMiq24=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.12.22 um 12:52 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Fix code added in b319ef70a94 (Add a small patch-mode testing library,
> 2009-08-13) to use &&-chaining and the newly added "test_cmp_cmd".
> This avoids losing both the exit code of a "git" and the "cat"
> processes.
>
> This fixes cases where we'd have e.g. missed memory leaks under
> SANITIZE=3Dleak, this code doesn't leak now as far as I can tell, but I
> discovered it while looking at leaks in related code.
>
> The "cat _head >expect" here is redundant, we could simply give
> "_head" to "test_cmp", but let's be consistent in using the "expect"
> and "actual" names for clarity.

The code at the bottom uses _head directly, which is fine IMHO, but then
this sentence should go.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/lib-patch-mode.sh | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
> index cfd76bf987b..89ca1f78055 100644
> --- a/t/lib-patch-mode.sh
> +++ b/t/lib-patch-mode.sh
> @@ -29,8 +29,12 @@ set_and_save_state () {
>
>  # verify_state <path> <expected-worktree-content> <expected-index-conte=
nt>
>  verify_state () {
> -	test "$(cat "$1")" =3D "$2" &&
> -	test "$(git show :"$1")" =3D "$3"
> +	echo "$2" >expect &&
> +	test_cmp expect "$1" &&
> +
> +	echo "$3" >expect &&
> +	git show :"$1" >actual &&
> +	test_cmp expect actual
>  }
>
>  # verify_saved_state <path>
> @@ -46,5 +50,6 @@ save_head () {
>  }
>
>  verify_saved_head () {
> -	test "$(cat _head)" =3D "$(git rev-parse HEAD)"
> +	git rev-parse HEAD >actual &&
> +	test_cmp _head actual
>  }
