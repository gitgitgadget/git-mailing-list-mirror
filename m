Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A976AC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 11:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiHVLIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 07:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiHVLIb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 07:08:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA2F32DA3
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 04:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661166384;
        bh=WoOYoz7SQPU4HxIfQjkek97z+RhBHQnmyv8LqD+0JIU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gFqQYe32oy8gXebvYMwR1jEXPJHzNemj7hHbRLHsNAcGwYy2a7DEwsZmbyvM8kmT9
         rSlDqqYwZvjnXlHdnyWTHLIdvkt6TEwpRPLwF3zEtxFrez/vitzyYymEJQ4X4B4ulj
         9aD2WguImzG0RWfg08iHcZp1OZ4dwQkEN3jWtqMY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.137.196] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3il-1orl9P3NsJ-00TWJf; Mon, 22
 Aug 2022 13:06:24 +0200
Date:   Mon, 22 Aug 2022 13:06:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: pw/rebase-keep-base-fixes, was Re: What's cooking in git.git (Aug
 2022, #07; Fri, 19)
In-Reply-To: <xmqqbksfirfm.fsf@gitster.g>
Message-ID: <s69q8sro-np77-n758-2or9-050qnoo2303s@tzk.qr>
References: <xmqqbksfirfm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6Of0QTr+4xmimWWxIZysaGAol3VpJqXP236dlR8pxpbkgRlpnw6
 rWzWBZ+PMLuQrjlxC0jFRNZj7LZevSE++WcLoN6CVV0o07jUHRG+V4D3C2uPnpCaQhTfnSb
 UXLTq5mwST6a2skCVspohAhIa8RYi+gE6/3fDKMMo8Gu9n0gle2if0DkR3JyK4bUSSlMjaK
 WqUP8RLh+lmIe7muhwbrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wHpdIhGoY4g=:Y+xR4rzKmr9MN9EUquHT2k
 JRxiOHZ/Ia6T2dG5yAah6S+961fWfCKysfeuImbeDsQJxYQg/L2NFaNXOjIDqyEuMG22xJbwt
 eUz0fqoAYWCzBA8MXsWHoIxVcR0PL/NVr5jV3d8TS7kimSLJdd98VURqVNNR/QS7kNodrZ7n8
 AgTybMxN6aMzlvfXWQsKzztx6rRdWr/6wwznzc4BaOJKRcMfiFYVzSImVlwhDmLNYhP/4hfo/
 y5g5TZqcv2ZJoPmgxTcG2yW/pPizmA+mJfb0RKD4I8D9aKpzKLJIlCIlsHvGmqteSN8mQfCfr
 3lCF64+QfSMdofCdx0iN7tiLfpQ2X9+gmMm9tUNAwVWRyzzqnWYoU30aPMnWbFehoKNueGZtp
 xDYsd/JBJCduYNuBCyBwWTZ5O5gmhg2SNjhAkOkTCMvcBjRpayYh6HoNCP2NCSbCdihhPuyKM
 7Yzfle8dhCDo1VK+uNXEg50r3SyJGZO/B6ZV7t8kzOyanHRv8DG1VVDZCkApNmrgPYzE1hs5L
 Y4tlSt/tLthPuI2Y+NC9HTaPNVd8meXbSyXRcbFna9ofXHkyQF6EVtFMnB6l+wUpvAPaE30zv
 R/vzF33SClYAIjAd2UoGLdBoZ67S40s/NO0lAgMwOeSvnJfMu2Uo+AZqS1MswqGH376XvWB2R
 Omtym2b7/Q4UxGJ2eeNKH4ZUZ2TZcerJGQ2VQdhxhxwf+mobakb8NbiK0hcJVB/enqRU5yhYM
 n51KmP9wdZkgiUvVpvsAvf3FMgKqOg3MmTEX6SBK8ZcqIe8h61X4BJ1xvNxtptWqhZX3n01pa
 eAr+b3znaEfQNnLJAe3+i3X3KLkMIVg0Lcg0suOG/B8BsToQ8nBFRQ9xAYIdpev1buE3uWiLA
 Xa/glL8fnLY9vHlNVpwIsd+HfnOqYtxkZmIkIe7OfH1ePfIrZ9fN4Y8sdqdDiQ112ygInYoDt
 xzhfhDf66lCjnX/99M06N8FLZQHEiM69QDXXwu9uGtWHnN9oIY7z5P4TiPeewTkmePg6WsGnw
 tW3KQFLhdnGODgQ2D7j6OT7F01t4DyKsmKrLs4eiBGpZ7owBojXZs7VweggBfwQTTktdiKIS5
 zEH9iggbDf1avmj5NfPUiEc/3LHi5o0aWGAwELw5s0vlxE0BI+Hgygf2Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 19 Aug 2022, Junio C Hamano wrote:

> * pw/rebase-keep-base-fixes (2022-08-18) 5 commits
>  - rebase --keep-base: imply --no-fork-point
>  - rebase --keep-base: imply --reapply-cherry-picks
>  - rebase: factor out merge_base calculation
>  - rebase: store orig_head as a commit
>  - t3416: set $EDITOR in subshell
>
>  "git rebase --keep-base" used to discard the commits that are
>  already cherry-picked to the upstream, even when "keep-base" meant
>  that the base, on top of which the history is being rebuilt, does
>  not yet include these cherry-picked commits.  The --keep-base
>  option now implies --reapply-cherry-picks and --no-fork-point
>  options.
>
>  Needs review.
>  source: <pull.1323.git.1660576283.gitgitgadget@gmail.com>

Please change the verdict "Needs review" (which is stale because there has
been quite some review by you and me alike) to "Expecting new iteration,
source: <c5b01472-7da9-6051-b127-1a8b8ddd2944@gmail.com>" (you can use
that "re-roll" term, if you insist, even if nobody outside the Git mailing
list uses it ;-) ).

Ciao,
Dscho
