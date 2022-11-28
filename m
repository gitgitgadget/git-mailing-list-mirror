Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BECEC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 13:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiK1Nvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiK1Nvq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 08:51:46 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8501FA
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669643489; bh=w3Nn+yD6qR9t/FSVvnGBstyq/o6ueZm3tIWTZjVO9jE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ACUI4re/v481U6gJCnIy4IugmtudbQXZuz5mFfG21dMQ7xfrZJlwkiqpZ1IrnfLzh
         I/GENLFsov8kbOE806nplnUmsweitBAvcfD6a0TXlVQCaJvOlHMnsppF1BqkEZ8/cH
         nEd9qHN3ho5lZeNT6529TuO6tlSp4Gs2VmNCySRc1DiJjZDufMLZ87IUrFCyQVAuXE
         U0h2JoFL5F8JLIg/ejoFC2k6t/xDuBbQizySEMsLxz3shpZR0x/CXk+FqnYc4YnpfZ
         5Muma8TNfHB7qyWlgVXNsOBKWLV9mpvvtHRo63hgNDYpf5gV6pwUFGArwL24uu1Vnr
         CxvSaFNyO8wWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MN6Bb-1pGUZY34on-00JCam; Mon, 28
 Nov 2022 14:51:29 +0100
Message-ID: <96a2f70d-c338-a992-a3e4-3e6b82b644ca@web.de>
Date:   Mon, 28 Nov 2022 14:51:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] t5314: check exit code of "rev-parse"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
References: <221128.868rjvmi3l.gmgdl@evledraar.gmail.com>
 <patch-1.1-45b240740eb-20221128T115740Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-1.1-45b240740eb-20221128T115740Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ly2t/5CgfHz446Rfj34yYLYypG5DDg4AD+GWxvRs9aNMlBXw7A4
 qEcaZgBEP8JIa9njsByp8HaFhxfjCjlpnSPPAtDvesCF2JRXyI2LsaG5QHMTs1vE2f1CMdN
 MSJA6xn/UXHhUqiWYgPJOxSUobk/qmhPNnxryf7MG5cVuveBvorLoqnVmUlbOvqWawCMg6P
 ly2HNHK68pXHKoSX2LbIA==
UI-OutboundReport: notjunk:1;M01:P0:dJKB70sC+pc=;pN+BjFEFaFcaTZKjEJGBkih6dS2
 KPIJtWRdrANr+ybTzI4bvH54Ioc2s9htR3sKqTt7r0cHbh6OtJ+HLo4bkn7C21WPV7E0kxRko
 VrS4EyIHzVa3NZ8Fu9vl3xXq2/5wP1GkMQWltGq7SiW46EurnxJOMo1V0YuJvhNWP3WxDrYBr
 ruHcxyDNMMDATGTixX/+GwuXKWt+UDBAaylrds7gd2aAHcjQuDecP379iR/vInRO+Fi29XdfC
 UWNDB1e8/6HismtW4NM6AR07xLfseg2bZAg5Z/1TXy9aAcI0es52PXhR5Brdegmp7cEvvD6dy
 nXynapM45kOjvwEkZ6A6CIgMMLuk6vruaREh9r7RB2SBE3WEWbsva7Tvqi18otTR9MKfP70Xr
 DJu2azA9GoiQ+XMpfwY1gUc5wFb/hGCFLYj+yBFLQekjRTY3HQN45EnUVotoEY41tZMH4y/+Y
 yJLi6P8JSpg4sb1RJ6nIeLm24NG4JBxgKe93uBtP3G+IrMAn+jXlNzXBAKhkc8ThxBX5A/5mh
 2U8VZv+vuqm6JruSSDcdCmF8SbZKXL4N3+QToRxlPWU6usSDy4yVO/LnnfDCWhnIJ4pQZ9q/8
 A8e6ZGaNmkYcq3lo2XeDHOkCeA4DzHmgBKNv+pwsAkWmHcgRqVJ6HkBaH4dAoi5osHe/W3IDs
 bASGaWdlYzFlw9ocZkXGkBrJuTbq0CUkV28a4Z3RbfgTSX6dhMo1ap1rdXZ26IMApoY8aYzv8
 QQ0UkG+ohdeMnFszZSH4TP7i10g4atAyGEePT2NRB8caipSJR1IlMThoKvpaS4/JOu0HYDrNX
 uPHFDRSk2Z4GVXIOhLuXl2/Dfk5AfqO+u8Qh/MTqUvacHA7exArfFIBxWQ7DG7bO1w4HcQlRr
 5g1zvpB70DqAY0zlb2Iy8xdQENOE8vowpX2/2yHv/5jiDhCf589aj88ddy7FxRWreq5x8wmiF
 KjUXlw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.11.2022 um 13:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Amend the test added in [1] to check the exit code of the "rev-parse"
> invocations. An in-flight change[2] introduced a memory leak in these
> invocations, which went undetected unless we were running under
> "GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue".

Checking the return code of rev-parse might be a good idea, but AFAICS
none of the patches in the thread around [2] add a leak to it; they are
only about pack-objects.  So that's not how this patch works.

> Note that the in-flight change made 8 test files fail, but as far as I
> can tell only this one would have had its exit code hidden unless
> under "GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue". The rest would be caught
> without it.
>
> 1. 4cf2143e029 (pack-objects: break delta cycles before delta-search
>    phase, 2016-08-11)
> 2. https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.c=
om/
> 3. faececa53f9 (test-lib: have the "check" mode for SANITIZE=3Dleak
>    consider leak logs, 2022-07-28)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> Aside from rs/multi-filter-args, we should be checking the return code
> of "git" in these cases.
>
>  t/t5314-pack-cycle-detection.sh | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/t/t5314-pack-cycle-detection.sh b/t/t5314-pack-cycle-detect=
ion.sh
> index 73a241743aa..169d8198641 100755
> --- a/t/t5314-pack-cycle-detection.sh
> +++ b/t/t5314-pack-cycle-detection.sh
> @@ -63,13 +63,16 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  # Note that the two variants of "file" must be similar enough to convin=
ce git
>  # to create the delta.
>  make_pack () {
> -	{
> -		printf '%s\n' "-$(git rev-parse $2)"
> -		printf '%s dummy\n' "$(git rev-parse $1:dummy)"
> -		printf '%s file\n' "$(git rev-parse $1:file)"
> -	} |
> -	git pack-objects --stdout |

THIS is how it works: pack-objects with the patch in the
grandparent of [2] and built with SANITIZE=3Dleak fails here, but
the test marches on, ignoring its return value.

> -	git index-pack --stdin --fix-thin
> +	grp1=3D$(git rev-parse "$2") &&
> +	grp2=3D$(git rev-parse "$1:dummy") &&
> +	grp3=3D$(git rev-parse "$1:file") &&

Nit: "grp" expands to "group" in my mind.  Here it stands for "git
rev-parse", hmm.  "commit", "dummy_blob" and "file_blob" might be
better names.

> +	cat >list <<-EOF
> +	-$grp1
> +	$grp2 dummy
> +	$grp3 file
> +	EOF
> +	git pack-objects --stdout <list >pack &&

Here's the new return code check that makes the test detect the
diffopt leak in question.

> +	git index-pack --stdin --fix-thin <pack
>  }
>
>  test_expect_success 'setup' '
