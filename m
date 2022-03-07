Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B908C433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbiCGQoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbiCGQoN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:44:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED815E74D
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646671395;
        bh=3MOUMQBXQB8dd1zQ7GTbl1qvlxCQV+Lc1PBON/620Lo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M9aQhNtLu5ANeNvhcAiDt0xJX0CIthcDE1iBqJjbQkIqz8LhiVBl6XId0tBSoT8px
         G1QdJWOl0amGyNgTYtP1Kn7HScq7E5XR7LPNfj19quW/IC8/cVshqHNTmGvnXVC9lk
         wUQBvW8GSbWK5ZQLVlNH9DOxOeA18sWSwj8CcUzw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1nRGS23v0q-0007RN; Mon, 07
 Mar 2022 17:43:15 +0100
Date:   Mon, 7 Mar 2022 17:43:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] rebase: `preserve` is also a pull option, tell dying
 users
In-Reply-To: <8bd89179-e94b-cc13-6373-1aa9fb539e59@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2203071742240.11118@tvgsbejvaqbjf.bet>
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com> <eb5871db95b12500cc0a6b8b0e3a82ed9e8fcfbd.1645526016.git.gitgitgadget@gmail.com> <220222.868ru27vtt.gmgdl@evledraar.gmail.com> <3e144b59-dce2-ce10-cd9b-eca92eee922c@iee.email>
 <c5197f9d-11eb-5f91-ce33-c196069dc2d8@iee.email> <220223.86mtih6fai.gmgdl@evledraar.gmail.com> <8bd89179-e94b-cc13-6373-1aa9fb539e59@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bOlfkn0a3gXG+zLz9fpBBPuoYTO+iSHTQqmkakuOnUwha6r/5z8
 AiFLQ6G3Z8NrJmkpDOfW6jCHTFD2/V40Aiof6ffZqZeQwhzyQOeBbEdtkSIkFpU76EtsIKF
 Cboixyubm6jr9hs9ZJSqL+i2wCPpBdHw3gK8JXjgCSsDUBfXhuWWXnhkt2oqh729J2tZ/76
 qhtTqIEzvIrh6/1k/duEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L9GXAO7qkws=:P7V/WFpQy5botsukG+e+4w
 iUKHM0MSNZrjUkp8WsRSaLTxNrLC80vZ80Ucx5vvWov+LkaqcMTGq+vrgzelZFGoZVTrUR9+f
 GcvAD5C9a12kycbHMFh+UPj6fpNiiNCJoxKvtaYdnV1JR2Y6TA95SMiRKu2aQubxC4h3sWgfK
 Sy0fUAdBCAvr5YjxdAM8JLuYENzonjtVe+zS3WCZZIkqPQGKbo2LI9csrE+hrisYB7qmIReZu
 JSdos90t7fm5678oYWqBvWNQV0QxfrMid5YLaPVaxxmt2nYOb5vTU9wHdGIW94BJsOheiKI9P
 RSJhdj6UkIfeGdswgqIEMbq/c10tMF9DYng3iPSGBu6RM639df1zvxBo31hBELomAptvOu0Gv
 Jp5yJ7McLi0XhaOVhmoaDACOATs3cnYezFNKY80I7robC3H5t4iH2jh1Y8hIllBKCKjqysPdz
 BXS8yP2zCgXIq/RbnqsyND0RpuPysqsnL46ZVW0JxYI3UwwkYmrlUQyegmDdsaQDurb3ImKcM
 zye7isabL8Q6wnynjCXJPw8uQQ93v5DWmrzayv9KyLbzeYENBkX9dgoBHsN59XbsZqCbyubD6
 mkOIveQMyR9uMA0pEtLpUaFf9G/X567y2zrBOJH7hzablvmD2cUT1mVAPWBwuS2N+epvCiR8l
 Skrj6DzMdae52IkcUSRVGgvScYAWUKG5whrcGaCgobKLPzwC/JKuvbDUKaFPAe1gkTD/qaLCy
 ICavLAaW2Ei2a+NORp1KuOz68qCiUXQXkJHAgWYc4uPt8cDet2xTYeFulmuicRnFz7HgWhmVg
 H3ksJh14TEnaf6DMbtemOwjHgTy76U2fL6p+7oeLcUnAca6CXZ+rNMhbEvqmEM6HCUohfvAs7
 M92l+7EpLQL23GeMgHEGw3JzzVe1cwKHtyiLRI0b/oGfMVSSAEj5Isn/NdKsAV258uxj4vKOk
 twDoX3V9Pbb9LSZ1kwnVYd9malENWK3+eOXXq7xAT7PcJktSXmq9WggqCiJVs4e9ZLNEnXkyd
 C5eGvn66uqVMJ8sqxsd37BrYIY9/Nd8gsd0s7E/9kpa7lJ29UARga4BjBmKIt/lUCucZvd4is
 rJ98uvZkatZ+9E=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Fri, 4 Mar 2022, Philip Oakley wrote:

> I'll have another look at the ways these edge cases could appear, and
> try an improve the commit message explanations where the diff doesn't
> show sufficient context. It'll be at least next week.

Can I punt this patch series back to you? (I sent it upstream on your
behalf because I had assumed that you'd want me to, sorry for
misunderstanding your intentions.)

Ciao,
Dscho
