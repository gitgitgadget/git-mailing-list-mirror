Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA66C4743D
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5616100B
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 07:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhFKHXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 03:23:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:57837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhFKHX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 03:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623396089;
        bh=E/JimwxUCmi9H3Q9nxopbjwRngFrHE3XCcX2oQZUmdY=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=DVKou8XXUzYfS4zCPpMpG3auYe0fhcS3Wsb7ZVE+RkKY700iljd1vRiyMHJe11cDp
         9OBZC5Ao0wasEPA7Vsf8cb5yrMFy/95d5TFN3g1a5qT6Oo7zV7SrPLEhwsPMY2yzR/
         Zz5jSrhTLRxItExopilLMS1HXtUqCnNJDJFWThg4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.162.243.56] ([217.162.243.56]) by web-mail.gmx.net
 (3c-app-gmx-bap17.server.lan [172.19.172.87]) (via HTTP); Fri, 11 Jun 2021
 09:21:29 +0200
MIME-Version: 1.0
Message-ID: <trinity-ccbae402-c6b8-4280-abe0-7fecf75af9f3-1623396089396@3c-app-gmx-bap17>
From:   Axel Obermeier <axel.obermeier@gmx.com>
To:     git@vger.kernel.org
Subject: Optionally include submodules in git archive - status?
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Jun 2021 09:21:29 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:3g5YpW9Bdl9zoz8dFj4GpCQZfj4ahQhBl7O15KYRqt9yDGn44qCZ9Zy124WnVB/OVjQsT
 k/UEKZU0t0Yj9d6ZuMUjAh+nB45kj2pEE6hyJpDHbKXiZU6wv8KPff9IT5wLejaCKVy5JbRDRDjv
 APZ42dEXHtqSJ5a6hjnLvteThcESqDfpyoCy/tRnkVlVEmKsVBLVAnxDlGNlUHckKfpaDHciymBe
 ifm7h64qQZ39xIR/wm9hInWQ9GnOThvSkgNZiRwmvRNTI+7mdfHER3fvMHVptleTPcJa5g4jAZSz
 V4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:RJZUzcjMANQ=:eBPhGp7JKWCwMObJTuxwIa
 qEEHtIndLpc+nvLkw24+crCjMVu2nUIiJcajj1eMQmOJq41/BQYAJdfHkJXtAiZpiUSer2fGP
 9t5qcJfoKe2E3YQIF3q8q7c8zuurg11a4vL+6uoB9N/A+A+zhQez3iYwHlJXy2VyjRYXHoO+n
 zMFuJtxUXzfVHIVfJGELG0KrDmGXnOUucO+f/+TjaxtaEsJjKH/8jOi6HCUhca55Jl0MG8Ee0
 RACJ21KEvYnXDQlttW9UkYscjDIv+dOXTH6QH8njfbofPzE8ibUQJLaiKZKcqqGa9Xen++Ugm
 Lx5pDI9Yr2oAHuU8ZxQ9g2lEvBzL0D6gIwZzNfVyc4Lf8HFpjUGzMUXtdMa+ZZAipgcLwqXrZ
 NndLRur9D4H9rAaQvUHvyBZqGpbfpKy+uOGvOzn+rriAwFbI1hHMbJtMvVI6mo4YZntTY5/Fw
 8raz2wR90/tbqZJkXz2RTJTy9fn1NWHErnG4xL8u6hgJ6OhWXCUohOQQiVmhV0WUtTn73J8xx
 XttsOuFJOgTvT2ulY3KjU3Z8Y0FPqjF25D7yNqUx8r1rbFZvCXMNaxL/wOPGIB/ChVqi9JCD7
 IwpmZbpb4DqcF42e065cvm/LzIUvlJQq5ehzSjmsynIoI12dM3apTRCxOVQClt65BFygrkeko
 B0O6jf9vzKaOQMnqW7InJP4bVVTb2qzCYulcP2VRpX3KBhMJLPY52qtTOGy2IoP4apOgAN9JZ
 KPIx5onGTtogxSPZdoNu5Pz3atfreSgp0ijssj2JuW8x7ddvZFpjSHJA++A/D9/KSJfkyPI+d
 Cy7ruvYly4xoTkT9l5w087B8xlQgGRvID3wSCZa6sroMpz8+84=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git developers & community,

I'm trying to find out the status of including submodules in git archive
- I'm sure this has come up before, because it creates lots of pain,
especially in packaging [0].

Github in particular punts on including submodules in the automatically
generated tarballs (which are therefore often broken, i.e. not including
all necessary parts to build), and this is in part because the underlying
git archive command does not provide that option.

I could not find a bug tracker for git (though I noted with interest
from [1] that the git-scm website has one...), and could not easily find
something on the ML [2].

It's creating enough friction for me that I feel tempted to implement it
(e.g. with a switch to recurse one or all levels of submodules), even
though I don't know the git codebase at all. In any case, before rushing
ahead, I wanted to check first what the status of this topic is.

Best regards
H.

[0] https://github.com/dear-github/dear-github/issues/214
[1] https://git-scm.com/community
[2] https://public-inbox.org/git/?q=3Dsubmodule+%22git+archive%22
