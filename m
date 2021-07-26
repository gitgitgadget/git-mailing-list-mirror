Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0757DC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 21:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD11660F6C
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 21:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhGZVAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 17:00:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:34733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhGZU77 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 16:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627335617;
        bh=CHnZTmpsMyftfVKSJP2C/BVsoUL3D6d3R3rA9/+HoJM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aD26NTdL4nSHAtoBzwfn0aCGpAgrlAz6JUK+HplYACPIiXDicCJvWeMid4x8lzXuy
         +d1xsWkDzxzhcSc1bdWomrE+ms3xTRlrxjMX1wvtA3D00LWReMGIRFOnPnRoovNTjQ
         ZyYnE5LcRAxXwhBXuxlE7qa4tYufPvYLUkDeOc1k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.102.245] ([213.196.212.22]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1l6DxA297Z-012JoI; Mon, 26
 Jul 2021 23:40:17 +0200
Date:   Mon, 26 Jul 2021 23:40:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 12/34] fsmonitor-fs-listen-macos: stub in backend for
 MacOS
In-Reply-To: <871r7yxkq8.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107262338320.55@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <pull.923.v3.git.1625150864.gitgitgadget@gmail.com> <587580489473a7a2ad665bdf3c482ea5d2c54f61.1625150864.git.gitgitgadget@gmail.com> <87sg0xbq9v.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107161748050.59@tvgsbejvaqbjf.bet> <871r7yxkq8.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1285407259-1627335620=:55"
X-Provags-ID: V03:K1:R5FbsQxKFzvgdSetgdS3EytqC8r3ybmFy/f8vWrBNW145/P8QdV
 HtN7v8trLAGfKn7ACyJhdoxA0qr5/dPflegz1YapfMBIlo3Zd0Wtcap9q4hXLSDWX/mml+9
 oNWM78fwv0DB91BFVjZYQbxr2xJiin+yqYh5+GJ//WB62bxMBN8HIgPCZfzd/xDCGXiiXMJ
 dtm7NdWw9ktVuE3jpJvNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jFemxwySFhM=:VY/QmI67TsaDA5egn/Ddk/
 tEBJ1jqcIYOsFhLm+SZ+l9YGjwzdf331PgXMmtfd+llBkMc1Dy8X+l1CE3vR7L7ESekTaJ1Ir
 6H0dpEiQlMJNK6LOEX8R4lZHJAto9inBzHvLpGxp9aD5IaKyQ2aF+bUGki9djGU0QHs7cP3xR
 J8zRLVpUDOCL37mMhZ9e9hgyGgBH3WODpEX42fPhF/tiinw6XrQ7qA25brR1ppC8oCwkF8qLQ
 NH7XPK2kEJcz5sbREQb2UzGnG18EvPLRFWBoMVmD8oYldDsM/SDzqsOcsvRAp7jUEjBfB9mE9
 3YGKDG2dJYt/7GQLaKGEPP4vNWeM2rdZNW6pTBnCXz8e2D0t5/obhpNoF57peqPwA4WLgoEvD
 vfz3pL4MzU73WFx0L/l9rnIhPlWmecc2L8J5ikQ7FDC+AOhnYOvs9jrjvZqqQ3fOPP/N0Yexl
 Ki1BwOh89C0c+BrzAhIutQfzgF2mL8YmEzvp8pcvTRpMtGSFzYRgk8IKiLmAb3rOPTtVeMHW3
 UQI8wP6W9xL+oEKNBkFcnf3+bhvnCp69Rq4ye5y/cUfa7ws2zrkChLxzNga4VB3udcRanI8eO
 zfRNLF8KiRgZyKBCNaiMSoXA9D7YKkxNd2+Dm545+ty6XhiB7lDK3v0Lsy74YsowFRrFrPNeL
 vsPZPzlhFJxkhu+jqWG6Xirc9YurBRZEXZAvIaJKQ+lmOjUFQNNDgjjAe8pYcvn56zPK9b1H9
 lGCHkZx0JrN2T7czuZLFza8Q0VC33NbnaE6uj5wEU9lJBuFecmYds1/LEV9Zy/5o+ezjbiU+L
 ATNgz7AGfxfW73ey3QTdP1hSu1ngg5NkUZowtgMu34z8F6uI3JJc3XzNtui4QW+yO92lyorU3
 0cJ7vJODtx3HxfmKdzOz2h1PgvsFEDCUaXONZl79FhvLc7gZGAeQ8A49ASxMG4zu/b68l1B60
 AJkr4HhTkqUXVCGCNyVyPJggGx+ZbenrZ5IRtsZZmCKJHE1u4/j5/f2NufdjPpo3iaRorMhyf
 IlzF7WL53Ca6KZvVDWuVXqN5I/Ow2nNt8w4mClBAqENFwlFIn7lkLGUVnJqL8ofh8lfjX85Xx
 6QJRpq+2HGQB4OMsbZn6mGeAPl9SJvvP0s7bbT/qP5K5Cv2BN1LB1Yn5g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1285407259-1627335620=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 16 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Jul 16 2021, Johannes Schindelin wrote:
>
> > So you suggest that we name the new stuff after an `uname` that
> > reflects a name that is no longer relevant? I haven't seen a real
> > Darwin system in quite a long time, have you?
>
> It's not current? On an Mac Mini M1 which got released this year:
>
>     % uname -s
>     Darwin
>
> We then have the same in config.mak.uname, it seemed the most obvious
> and consistent to carry that through to file inclusion.

Sorry. I assumed that you knew that Darwin was the name for an open source
Operating System. See
https://en.wikipedia.org/wiki/Darwin_%28operating_system%29 for more
details.

Ciao,
Johannes

--8323328-1285407259-1627335620=:55--
