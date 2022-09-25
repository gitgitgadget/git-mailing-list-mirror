Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5A4C04A95
	for <git@archiver.kernel.org>; Sun, 25 Sep 2022 08:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIYISF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Sep 2022 04:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIYISD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2022 04:18:03 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3B1357D0
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 01:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664093864; bh=NRrFOFosvHx1mK8+kE4YnCpGrRURm21PBAiv+kC6hoQ=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=UWwE2FXnTF9znx9S0fSYC2xW3TmLj55yfqm56Q9RP7DId1Avzch6TYVWXzxTSB94p
         5lG482a7KNlOOrYgS28yKf/K+RVLzxkG66u72CmQE2kADsp6gZTf5Lb4OlHoRSLukh
         8Bwb62qgT6ZBB5oJ00XQCqQs8fHTN2+fZmfNA8fuVUZJHEyoiOBPqdW9QbFs76dP3o
         x5ZiSx1CPBxQQbu3INbCzsJFcfYOOaDrovhiOiq5IiVp/b09M+v5Ct4vbuOouWffqx
         qbXIRbe43mPEc1cvWG54BUUp31P+ycdA+qX1Zkkn5VV/SvPyGronlqgeux/boNlwtX
         Qv/HdbnGKK7vA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7xaR-1pH2ux2lsp-014mhS; Sun, 25
 Sep 2022 10:17:44 +0200
Message-ID: <164df3bc-a7e1-70b5-e2b3-3f6c68494f0a@web.de>
Date:   Sun, 25 Sep 2022 10:17:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: git --archive
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
 <b0e84636-d856-eb52-dec0-07727f297b62@web.de>
Content-Language: en-US
In-Reply-To: <b0e84636-d856-eb52-dec0-07727f297b62@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WT69z8LfccbI59xr5dkK/MU0SHt3IVy0i4wnqb9lK6pTAth8P1V
 BBe51aJKWGz0YQYHK5o18piLFeesW+EXjBWOvmJWdwaXSPNJYMmAeexykCao83K7S9RGSsg
 6JLUAxJbyIx2pl19IJpjUN9+MYPyDhwXdVHXL7rKpZdIbdqlGhE/mhuNVAFjBz/5qrQWo0j
 +tsYsBqVQjFxnnP5ZqEFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xB835VK0QSA=:xYWh+w9kz/dP4vZktnqKcP
 JNxetW5IroQbIO5InY1MHQJZ1pVx+PRG6Fh3oS1WxVrrNuD/58CCIfbS3gv3KErpk2aQ8YGi8
 C7g3BUxY87SuaG5uDIBBA/fV0MrmXLqQOWMEGSoUjQMhgP+Osvp154kKOXKXACXjfo+dGkEuV
 cT1yum9Nsgc1NCg9ayLjztZ3xnbZAiYHV6ysWXlXxZaQ8U8dQ4s0Wq3XajdvgGuu1P9d+a7rX
 yj6x+mNVP8lqqIuUM0kD7MITMcxid4W2XcYUgF75U8mPRYCrh2dSvofuLxaF0sD0bmdCpTAAt
 tfngf1c8XvF3nM2p/AHGaVyKtnJHi5v8JIpCUofX6MdTRW/2julS5VPneYWMS4rcJEFdJyKN4
 Z+ruuUmw5kJtaoq16hbHAdlgBTkGCUci5XLADRIxvWHFRjSyQ6WIX3mDU2O/7Xp/OCKXQr8YV
 epywqj7ldIDOdb+/huzMa08jcXzNJxZkkduprNYR8R6YfJ7AMd9vTuMfOh4lHPRm+NdW2KVdF
 aGfFnCDXHScXvCpX73pZmdhW9OXmbLfkOnGkOvDI5kYyk3pIBT6pq1aMbikMEeb5/UpQNaIhu
 /8yQAjPPt3LlwBk/QdP1HDMtQp8l10M8TvtAYvJuHPUlpIN9LRsWv68mGHIOEhTs3odwXHQKW
 bybOznnuBZtb1L1OzxuwS5NexM+43gKHfi+mZwlCLpg1SGnIYZ4rtrUsHEdFr4osvQBtuL78m
 1K1LhIgUaqYE+eSCloGQGf6OzFMP+0Dng2iZq5CuM9LPMBmtYEoqLloNXk+7t2fC1nuJzRCUY
 qSnqzZpXZv1CNNe8GIaUVQAc6mR/EGpBEqSNFD656CsgOZh1rMsSTsqn7uO29PVWx29ty08rz
 k84/iFhotARr6/mymq2g510ky9dcEKKqjjNQCYpNDLYJhdyje2QBIf/uGlYEDMQeR78UtpqIn
 A463F3U+Hsvd14fUE86Dr7vIkH7bopGwNFyEL9jBuvKmFYgb8I05ElcFmYxXe1k5eu6urji56
 1MBVrqAorkOg6adH7WZw5itpgT1DJoZNX0QkZILqtZ6IOL3YNPUFz+J/pSBpUhx/3T6+pYk20
 HUwZD2NB+2BZZ2GAxQC8s6O0WOKkt12tvmOYoD6gwfRpN27R6zdEzacUYZ0NcmgabHyiPjJ3Y
 zyb8E=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.09.22 um 20:07 schrieb Ren=C3=A9 Scharfe:
> Am 24.09.22 um 15:19 schrieb Ren=C3=A9 Scharfe:
>> It could be done by relying on the randomness of the object IDs and
>> partitioning by a sub-string.  Or perhaps using pseudo-random numbers
>> is sufficient:
>>
>>    git ls-tree -r HEAD |
>>    awk '{print $3}' |
>
> No need for awk here, of course; "git ls-tree -r --object-only HEAD"
> does the same.  Just saying.
>
>> Here's an idea after all: Using "git ls-tree" without "-r" and handling
>> recursing in the prefetch script would allow traversing trees in a
>> different order and even in parallel.  Not sure how to limit parallelis=
m
>> to a sane degree.
>
> How about something like this?  xargs -P provides a controlled degree of
> parallelism.  Sorting by object ID (i.e. hash value) should provide a
> fairly random order.  Does this thing work for you?
>
>
> treeish=3DHEAD
> parallelism=3D8
>
> dir=3D$(mktemp -d)
> echo "$treeish" >"$dir/trees"
>
> # Traverse all sub-trees in randomized order and collect all blob IDs.
> while test -s "$dir/trees"
> do
>         sort <"$dir/trees" >"$dir/trees.current"
>         rm "$dir/trees"
>         xargs -P "$parallelism" -L 1 git ls-tree <"$dir/trees.current" |
>         awk -v dir=3D"$dir" -v pieces=3D"$parallelism" '
>                 $2 =3D=3D "tree" {print $3 > (dir "/trees")}
>                 $2 =3D=3D "blob" {print $3 >> (dir "/blobs" int(rand() *=
 pieces))}

This will exhaust the file descriptor limit (ulimit -n) for really high
degrees of parallelism.  Here's a version that scales beyond that.  It
takes ca. five seconds on my machine against Git's own repository on an
SSD, so its process overhead should still be bearable for your purpose.


treeish=3DHEAD
parallelism=3D1000

dir=3D$(mktemp -d)
echo "$treeish" >"$dir/trees"

while test -s "$dir/trees"
do
        sort <"$dir/trees" >"$dir/trees.current"
        rm "$dir/trees"
        xargs -P "$parallelism" -L 1 git ls-tree <"$dir/trees.current" |
        awk -v dir=3D"$dir" -v pieces=3D"$parallelism" '
                $2 =3D=3D "tree" {print $3 > (dir "/trees")}
                $2 =3D=3D "blob" {print int(rand()*pieces)+1, $3 >> (dir "=
/blobs")}
        '
done

replstr=3D"%"
command=3D"awk '\$1 =3D=3D \"%\" {print \$2}' | sort | git cat-file --batc=
h >/dev/null"
seq "$parallelism" | xargs -P "$parallelism" -I "$replstr" -L 1 sh -c "$co=
mmand"

rm "$dir/trees.current" "$dir/blobs"
rmdir "$dir"
