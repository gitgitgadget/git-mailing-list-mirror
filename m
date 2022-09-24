Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573D9C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 18:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiIXSIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 14:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiIXSIN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 14:08:13 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3A632BA9
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 11:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664042875; bh=WGDEUwAx2FMufwAVHrF31TInBPZPcC/S+k5cOPUq7bo=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=wCL4yovuwE8CKOqvpbY2BDVgOmZSrJGaO59GuMuu2znNGvdqdcIXUaLj2h0BQE9Ag
         goCkWFCx2LIyHAUwW7Jn11EnfnrNLE2DC16anVkHZJoWrOEhBoaP/nfpWt26WAG4C2
         2/Qd8p90R10TFJcd96qpURB5SeiDEsZpxiUTQKnwKb0aHUe8Ec+e2LTxyFAri0Ov01
         paZj2geZw/5ca9Mh4a4Fd/H1EjkcHmPVn5wI3kZKS4r2kXg0p1+Vq/X+yna6Tg31IX
         5bkIGMdAAU/t5Nd1HD0ebw1xfYBUVD1wwjvbwjCx/A/6rPw0TrNm+bFLpdKfARKzV7
         wVgPT5IpnDTUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.1]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4KNf-1obsS22INt-000Ay9; Sat, 24
 Sep 2022 20:07:55 +0200
Message-ID: <b0e84636-d856-eb52-dec0-07727f297b62@web.de>
Date:   Sat, 24 Sep 2022 20:07:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: git --archive
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     "Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <PH0PR06MB763962EB6321F85803C5CE2D864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
 <xmqqleqbxj4h.fsf@gitster.g>
 <PH0PR06MB7639720FB3A1611F4C96E52C864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
 <Yy0ChPPqZUwVFyAt@tapette.crustytoothpaste.net> <xmqqedw2vysc.fsf@gitster.g>
 <8eb5131e-5ae1-79bd-df0c-bf0b2ec8583f@web.de>
 <PH0PR06MB7639DAA5CA112495E3EB43AB86509@PH0PR06MB7639.namprd06.prod.outlook.com>
 <712ffe78-c3e3-dacf-c3e3-f339385e9bb4@web.de>
In-Reply-To: <712ffe78-c3e3-dacf-c3e3-f339385e9bb4@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v+pQKU/VR3TRZXQ0ZfffXNwiTWa69Tj56KKrvHrn/cdToxZxjj8
 C+fnfqAp9mjT9Gq8l2qTlebJhfhNX1vHMHVXwcwuGRUAmPEsolEaD1Nb9G5F/N7FU8aqXiZ
 fKioTkKqowzro/Ve1VqLOMQYG1G+8pDBIh9tIcgE0/cBcbCcXcIZpfb8352MFlRji4l3kQ5
 zNAr2qYuZLjoGOVl04Cwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2KH+ur8oa7s=:4kcbCWZn0mKjdJCgSlNj5i
 2VMBJU8RVIv3S9He54WAtnHMmt6WZQyjqDW4SGe6CM3f31noSIely5s2WXXw6iDYDENVp4qSt
 dmgJOpdlfLqPKRw+iSpe37zIzs/d8FkZHQZFLNmCb63y/+7XrWspVDBnh52vCWJkflk43v+03
 4EheNlXLxYmuIje+5kK35pjFsHo/v8RZ/oqSyLGC8IkSLbZJ8TVr0zvF0JSx9XeKW68WJlcBa
 SvU2jLL2c+ZOFT4Cl+AY+eWK4/uo/L+ZB6qDBnvXG3j8aGsU14RnNEf2RuB8PDzgMEBCvKqTr
 /xGWVo3ytPRbtWaJsW35rUMfcovcgdt0q17tril9lH/91S01pSb6peo7B25JiVzrcBfF6ut/f
 W7o0zxvQKDVMf0A/z6eU6npBtAkHw+eTd0tFnRvktKM+kEoz//wrLYdEPCerz1vf2kGRPEiCy
 YIjQ6jOws5fYmkkCfkaX6os4SMksS42C8JIJKvETFpZUxvCVAa2yb3AQ3mGa0Py7d0g1bZtYQ
 70sR/N1xpAkai1D0m0ImBMUw942E0CkS/UT0pONtESAqHyDhk8HZVy97KbRH+T+OUUFck1cae
 H/pB67iekCZUg2AU104lhLSH4qOcRKuXSigIWV1uGEziio8Ky0pxZGMRFy6KWoi3oe73/T7c0
 XI2+0AM18IQUEOzTTf2uLe2BuyiK291DBxw4DT7MNUCddzQ5yMMS25RT+XjekcjId2CDQAaF9
 Yjdg5vXa1HM8PfGsHQEwlVp0Ab4vkBTXE3VBAVw4CoM6Ke3vwpIHw4xPTD3EWul7Bf+/elxV2
 Har9ghfdkZ0dnej/thjlyipOTAZm2Bc6N9X6LfAk7YFBYY/SQhcMCfU+QYueNOzZeq+6WGQbE
 RA45B28GoVp1tUQCvrOpIacDqZblzLHi2vIitVrIyKC/K66+QspGif0CqZGivBwZIu+0M6+g9
 k9C+BMuZqYnRbbEAOnWObkqSHmh/2rv3hLoYK4HUR0I43nSsk3higBVdz4UyQH4WZGl4KzlFC
 YDR9lOrduLfKGeYqb8Wk24V7NV3pZFcDX1XDhEtM6R9KYBVPsBTKOxUPOSrSThADHBYiGtNH6
 DhbKoJqNLQ4IEck8Z+gTKD4Bealnzs3saAxCcIP1IUwQzyon61RMEz/eYcmqs3co0aEyqHtC/
 tEKk8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.09.22 um 15:19 schrieb Ren=C3=A9 Scharfe:
> It could be done by relying on the randomness of the object IDs and
> partitioning by a sub-string.  Or perhaps using pseudo-random numbers
> is sufficient:
>
>    git ls-tree -r HEAD |
>    awk '{print $3}' |

No need for awk here, of course; "git ls-tree -r --object-only HEAD"
does the same.  Just saying.

> Here's an idea after all: Using "git ls-tree" without "-r" and handling
> recursing in the prefetch script would allow traversing trees in a
> different order and even in parallel.  Not sure how to limit parallelism
> to a sane degree.

How about something like this?  xargs -P provides a controlled degree of
parallelism.  Sorting by object ID (i.e. hash value) should provide a
fairly random order.  Does this thing work for you?


treeish=3DHEAD
parallelism=3D8

dir=3D$(mktemp -d)
echo "$treeish" >"$dir/trees"

# Traverse all sub-trees in randomized order and collect all blob IDs.
while test -s "$dir/trees"
do
        sort <"$dir/trees" >"$dir/trees.current"
        rm "$dir/trees"
        xargs -P "$parallelism" -L 1 git ls-tree <"$dir/trees.current" |
        awk -v dir=3D"$dir" -v pieces=3D"$parallelism" '
                $2 =3D=3D "tree" {print $3 > (dir "/trees")}
                $2 =3D=3D "blob" {print $3 >> (dir "/blobs" int(rand() * p=
ieces))}
        '
done

# Prefetch all blobs in randomized order.
replstr=3D"%"
command=3D"sort $replstr | git cat-file --batch >/dev/null"
ls "$dir/blobs"* | xargs -P "$parallelism" -I "$replstr" -L 1 sh -c "$comm=
and"

rm "$dir/trees.current" "$dir/blobs"*
rmdir "$dir"
