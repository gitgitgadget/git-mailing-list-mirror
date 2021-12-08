Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E10C433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 11:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhLHLmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 06:42:12 -0500
Received: from mout.gmx.net ([212.227.17.20]:56709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232769AbhLHLly (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 06:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638963501;
        bh=gpvK633cLomBqzLWHgsJiIf2SZQitKmZ2SsJ6+fCxD0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lRQpwZ0M2YBRZLyoHciZbC5DTy2JoeyTCOT7+sPo6vHb9b0MGDc57jIJPg54P9Tc2
         LO/+PKnzpAENdxRgvpMr6dgnHiHr/+XOoiA/kWbYyHWZRYgUXMPmc24yYeoyr5l73y
         sKakZBOn63f0ojaV92zCiETt4cwcjMiXb0Z69/Hs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([89.1.212.223]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbkp-1nBBuY0xUh-00P39m; Wed, 08
 Dec 2021 12:38:21 +0100
Date:   Wed, 8 Dec 2021 12:38:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] name-rev: prefer shorter names over following
 merges
In-Reply-To: <pull.1119.v2.git.git.1638596152340.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112081237310.90@tvgsbejvaqbjf.bet>
References: <pull.1119.git.git.1636762454792.gitgitgadget@gmail.com> <pull.1119.v2.git.git.1638596152340.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xlmw3YH0BMqeo1hPXR3I1Vicya7vQrRUhDS8egYCUn8LvkRNrpy
 vwE+Pi/GRDpFmK8BEniWgcduIAkqb3Htc1ELrh8D8O8aQAHnL7j8x+PyIltt+3/K9Yltmva
 0wJsFNA5X8qhbBuqzFNITBJ1BR9Ge+BPrac+zVtloQs09PSYK+8rs39lZCvrVrAgnrQyXbn
 iiTPpXAAOTOxjH3YhUfTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+TL7XkHCgM8=:9+fAKnVc86hFgqrOW05EuU
 ++5qWpCY6FrotQ3SPZB+v3yjW/r0mIJAbkl2wIkf2wMMd4TeW1Y9kLxWi+13hRtuK6dOMt1cV
 9fhjpobAuO+rGwvZSaQ8WRO51lXs1iruJfULeXZXmGL5pHaSPXqOKmTgXP054XF7Wc/4Ig0k7
 8XfLedCh6XZktoVLp0Zp6d9udpvw4XTuzlvOHwWd1pAuqSvh7nUe9QpG2B4wZsop96N1zXLgk
 WiaNaYs5T+04Q/s5eGIdDSZHbxvNgL/nbOIHKf+k0JiWxwnYA2E8Ur2b3yfA7TzsjBmvxMTb8
 +fDssVFiAj2296tQFnRODABufUINN0akv1F9xlCaKHffnJ8Gw/KF5OGzGe7BvnRJ3wMTvhJUU
 cwh7pkRwt9pWDgtaTqysiW37avJp5HFaHezjx4oLin00LK1nq1GY0LKOOqYjYdBUcgrp4jvI1
 JP76VOR6Kjwi0tlhGfJF7qMD4xVEsAbOYvFngsCN0tL+akdI9iGWHYUkZ0v8Z+KlXDXOedWsR
 fDbOZIU6s8NhH/Bd8/eyUTNs8cjwF3O1jTUIModQpynSLT3U5m2TVt27zIsr7BksGbNMeHZWL
 sXHpVntBLbG5ycgqxZMKxsCzHAEnSSRid/25zJSOmD6DFRb06VgxSMNqPY1gCXgrXOn6MrQAU
 ZbQioxPpCa8Id9vQU2Aq/9WEgOzvxgSxzNjbWYX9rE7RWwhfwZttXmgzXr8NkshMwrrRvG8Cp
 ekA6A11Ug9btPsWqsueOOJAbJY+LZ5sKqVtncy/qPJwKMs8CSuRSFnH7PxSybJ6ONw/5EOvOZ
 f5GxqQhSdL2DciWnyn1CP6M66E2Ret96JWX5+jLhinu7569za3DO//K/VU6ovaadfUeUSjiQS
 un/dsBxcRyZ86kLHLHSyLa8Pf929Kk0+IySZtTTrQjfCJINNNdlRx5dKCqeFfJog+orV462K9
 hjPkf+OT0JSz2UOJbfRG24C0wsPtY1F19TkWvX+I62ddT9/XSwUbd7bHbS+iYBXlKMIGxkSVB
 wE7bgl6to0HXKc+mCC9G9qikwiMQjJF952MDDD4szDp+Podw1COO50BtYI9oCqjIAtJ3UUL/y
 szEKizjCBlcliw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 4 Dec 2021, Elijah Newren via GitGitGadget wrote:

> Range-diff vs v1:
>
>  1:  50812ed6fdf ! 1:  5d068486f9f name-rev: prefer shorter names over f=
ollowing merges
>      @@ Commit message
>           the printed name over fewer total parent traversals performed =
to get the
>           answer.
>
>      +    =3D=3D Side-note on tie-breakers =3D=3D
>      +
>      +    When there are the same number of segments for two different n=
ames, we
>      +    actually use the name of an ancestor commit as a tie-breaker a=
s well.
>      +    For example, for the commit cbdca289fb in the git.git reposito=
ry, we
>      +    prefer the name v2.33.0-rc0~112^2~1 over v2.33.0-rc0~57^2~5.  =
This is
>      +    because:
>      +
>      +      * cbdca289fb is the parent of 25e65b6dd5, which implies the =
name for
>      +        cbdca289fb should be the first parent of the preferred nam=
e for
>      +        25e65b6dd5
>      +      * 25e65b6dd5 could be named either v2.33.0-rc0~112^2 or
>      +        v2.33.0-rc0~57^2~4, but the former is preferred over the l=
atter due
>      +        to fewer segments
>      +      * combine the two previous facts, and the name we get for cb=
dca289fb
>      +        is "v2.33.0-rc0~112^2~1" rather than "v2.33.0-rc0~57^2~5".
>      +
>      +    Technically, we get this for free out of the implementation si=
nce we
>      +    only keep track of one name for each commit as we walk history=
 (and
>      +    re-add parents to the queue if we find a better name for those=
 parents),
>      +    but the first bullet point above ensures users get results tha=
t feel
>      +    more consistent.
>      +
>      +    =3D=3D Alternative Ideas and Meanings Discussed =3D=3D
>      +
>      +    One suggestion that came up during review was that shortest
>      +    string-length might be easiest for users to consume.  However,=
 such a
>      +    scheme would be rather computationally expensive (we'd have to=
 track all
>      +    names for each commit as we traversed the graph) and would add=
itionally
>      +    come with the possibly perplexing result that on a linear segm=
ent of
>      +    history we could rapidly swap back and forth on names:
>      +       MYTAG~3^2     would     be preferred over   MYTAG~9998
>      +       MYTAG~3^2~1   would NOT be preferred over   MYTAG~9999
>      +       MYTAG~3^2~2   might     be preferred over   MYTAG~10000
>      +
>      +    Another item that came up was possible auxiliary semantic mean=
ings for
>      +    name-rev results either before or after this patch.  The basic=
 answer
>      +    was that the previous implementation had no known useful auxil=
iary
>      +    semantics, but that for many repositories (most in my experien=
ce), the
>      +    new scheme does.  In particular, the new name-rev output can o=
ften be
>      +    used to answer the question, "How or when did this commit get =
merged?"
>      +    Since that usefulness depends on how merges happen within the =
repository
>      +    and thus isn't universally applicable, details are omitted her=
e but you
>      +    can see them at [1].
>      +
>      +    [1] https://lore.kernel.org/git/CABPp-BEeUM+3NLKDVdak90_UUeNgh=
YCx=3DDgir6=3D8ixvYmvyq3Q@mail.gmail.com/
>      +
>      +    Finally, it was noted that the algorithm could be improved by =
just
>      +    explicitly tracking the number of segments and using both it a=
nd
>      +    distance in the comparison, instead of giving a magic number t=
hat tries
>      +    to blend the two (and which therefore might give suboptimal re=
sults in
>      +    repositories with really huge numbers of commits that periodic=
ally merge
>      +    older code).  However, "[this patch] seems to give us a much b=
etter
>      +    results than the current code, so let's take it and leave furt=
her
>      +    futzing outside the scope."
>      +
>           Signed-off-by: Elijah Newren <newren@gmail.com>

Very nice addition!

And obviously, I am still in favor of moving this patch along in the
direction of `main`.

Thank you,
Dscho
