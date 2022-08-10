Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2B7C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 09:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiHJJdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 05:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiHJJdH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 05:33:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8374B6CF5C
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 02:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660123982;
        bh=k84uzQewGHmmpLGTg+qKbfc9GgbmKu0G9a26yo2hZpA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IZATGSJ09u16C+fDqT86fvxo6YCFTa9Q14kj0+GZCfkmaXAliTvxaEMvDmoaYE3Ic
         l3B90VD4YFsJjmvLEJbT8fuYnOarDYQfpEQjdIbzwwCgVRu5p7PX+y9/SFcFYEjJ48
         r7Kfa0Sem9lsvQWKzlAqVX9R2R9UZsypBgCKoGtY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.204.74] ([89.1.214.151]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1oEW1M2oA6-00BcW8; Wed, 10
 Aug 2022 11:33:02 +0200
Date:   Wed, 10 Aug 2022 11:33:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Overriding creation factor in format-patch, was Re: [PATCH v2 0/3]
 mingw: include the Python parts in the build
In-Reply-To: <xmqqsfmj7t5o.fsf@gitster.g>
Message-ID: <344r92pq-s57p-1239-sp05-955s759r54r7@tzk.qr>
References: <pull.1306.git.1659016906707.gitgitgadget@gmail.com> <pull.1306.v2.git.1659109272.gitgitgadget@gmail.com> <rq6919s9-qspp-rn6o-n704-r0400q10747r@tzk.qr> <xmqqsfmj7t5o.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9Hm+B0zFQRyrPo4fYzQF9ryXH/Gws/B8hijOzyzOPyidAdc2b6Q
 E0LMX2onOapWdl02Gy8dZvr5u5uMKANRKNoci7sRIEbrxSQVRdV/3nfQvsgVUzMRaMvMLab
 vhdTJ30dVgw6i6Zx7wIICeBTLDNB22qip9v34KGpZ3YeZPQG+z6O8/dv+bU5mc5KvvWa14J
 h/b6EVO1sn4y21eupVIfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gqh3NRyZraE=:foN5R9+Mr8WcwjcuZcS5zV
 VCOOicD8UUSqt+syjL9N9EWBCrACGxraa2HajiWe1ZIl7EDi6CNT+O0Hp5tPEUKxTqBwlnDdj
 Ktkr0+xQIi35zqKqqYkf2+lOo6Jp9WX3zlnBHFDRVBbGbFpyXr6sW8jY9rHGhH6+zC3G/ZrCZ
 g2/TxOLNNtBMoK1rK9HyLLqhqn28Fd90ZZ6rpjlJzlP2LdkIGdoniO3XVJNcT/m3AQBXEW0DS
 R6yLDKxjHHhIwi45tCFkmZsFi+QhA+tPAd2Bq6qgdXfYwrcCdqak/CXHz860EajayI1Iw35oL
 tyUwqTVlkW8XG0SCoL/h4zwY4VJwV20zliWvMs9q3OFhmDbwg/XOmxSYAyxuxT6uxn/BA1y1b
 F5t0ytYcLxndLRV1P62QusVemmojK1h5s6t2gy98fSXgaNJLr4RAyfmasKGnPnhZyo+7pvT6Q
 QkogUn8blFiNtBGi+Pus0LNqX4ZmqiqqWI4zuHQkgV/KQm0Ep6ApkQo4rx4EkB0x2DYSoernp
 83JAus1AhQ/fGqB6zo2vDO3MFg25ca+ON8fObfC2HCMgML1R/4swS1pbF2d1zL6fxW8/+uhwe
 MTU0ozb9Mb0yIpujL2Jiwoy05VvsTqrnpg/8GUNDM3/RZTRNVSjnhkyDjMkslGk6DUVuKjK0a
 Rab/X0jT3aDB8gVQs6ovevXPmKDkZY82Z+/cuisebpRGIsaDNUcvAHIg/aTKFu/RcmT/2/zeq
 Y3ikYKuwChvbwunkExlW3YI8HX/NQ7kl3gJSyUFItn53RDMiImFyEG6paN0ft+4XOQgJjoog4
 x8AJ8O2MMXeJQv+jtzCrTNFEYZZTXOAY6Tjq1u8TxnGdW5l7SUPu6q6XRU+Lzq4OILlrvYl8M
 TW2s2sqkrYDJiJgWEYwldTd+LvH3v+XacVHsWNPmVji5PMBjwwQwIFKfa9g/Ug643REQI/qt/
 jUcppgSExGSnFy9hcbDua8hK+93Eu/VmuyG1wlC5kMVaEfDn6IK3WyY8PHc3AMOm9WQ69lzBz
 A6xQXDplqFDZTtpt3EE84LW29aSAKO4HaxVsGdDlzHYFVoNBV274MPAe9dn5ecN0hU3xHbLGx
 3KpTSMD4pWQjoW67U/j6JnB3BqyCIsZFiWAOPgHIf6v0IgI1uLST5vwjg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 29 Jul 2022, Junio C Hamano wrote:

> Perhaps the default used for "format-patch" should become different
> and set a lot higher than the default for "range-diff" proper?

Good idea.

However, this will require careful research about the best value to use.

An idea would be to use the lore archive to extract patch series
iterations that have been sent to the Git mailing list, then use a
variation of https://github.com/dscho/git/tree/range-diff-from-mbox to
compare them using `range-diff` with multiple creation factors to
determine the bounds within which the optimal value lies.

Sadly a bit too involved a project for me to take on right now.

Ciao,
Dscho
