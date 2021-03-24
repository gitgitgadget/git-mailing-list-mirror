Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAACFC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 12:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB854619B6
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 12:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhCXMby (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:31:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:44985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhCXMbX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 08:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616589079;
        bh=7RbBHvwfyKtypWRnV+hfCrzPzBRHhS0t7OJ0ThfvMYk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g/PKUKE/pREqagNpVdVg8LgugUL0NwNiW621A/9egB6EF5t0uHAs65L29BiXn8/ov
         nHjKmpaiKuF7Brwg2UysLFLZmnmJPGNGyJu6AzSllbk/cgG1xclVCaZUMMQHlysjqB
         vfb53kSciLmoMtW4VtmkRlfDy5xEok8ELDB8ynJU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.9.78] ([213.196.212.127]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bX1-1lomzk1QhP-010Zhv; Wed, 24
 Mar 2021 13:31:19 +0100
Date:   Wed, 24 Mar 2021 11:43:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: ag/merge-strategies-in-c, was Re: What's cooking in git.git (Mar
 2021, #07; Mon, 22)
In-Reply-To: <xmqq35wm5y6d.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2103241142220.50@tvgsbejvaqbjf.bet>
References: <xmqq35wm5y6d.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3ZyeOeQVfw4OKbk6f58eqlZHh+ennw8n2p5oWSBvqzbdy2yRYZN
 Y3Uler6CC5XvvHTEEAbPqa5TRajFeHCWvZhDXCnIs9xSQxhxJUf65ezm/1T+toP7d812lQ7
 Xy0TxW0cZWQxvZkqZu1DoGEnPvE2XjTXZ+Dyjmw1knB8kOmhHTYwJWcbps+Xj+ILM8L/zdu
 uYuOh55cebknlr20pRJAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m+ReMBUD5ac=:3Fei9OHl01aYw6M8BdNfm5
 nHpjnxrC70Axl9R0xt2ztZ135+dFys2jEA+tzWIqQPUC3DnN09Ffia+nTO7MUwEccV/xHx9/K
 fbTUiIGRghc2PLMU3jNSpKU0cxRPTf8TLAmPiRt4sKSSc6NThQOnwFthd6MVyLDGFcmPoRA4g
 0WDlVGXGQlmjJHNoor2wzxJcINm8hzaOKpitq9OM1lgegkp17xecnqToEak5KcF1tu+738mDK
 SK6w6CNtIX0RMykNWBHBR8UYG9q2nf23/zWmeNET2LGOWL1k4z4LInUnVTMcUPnBZDDQ7+FLe
 Kci5Jt8TA500VDqJr4ZOhB8lpudWNvKkpz1mk7FDkH5nTIOvl2sPkJ5uWmCiz44WvPFgYLVGr
 NVgYAk+DZnWMhVao0rFS3mBwkQmLcIh8W0d1YfbSzX0Fwc2DXMWpR8Pa83qvAWZ86aYPqY5Iz
 YDMHwItwciyj2UIQ5RCmfMPEcTs2VL07SIfVAL2MpBGoT74/RpeAc8VPM2L0mJaYS5m5hW8To
 tH5xjHDm3A3YwxrLJGvXJTqNrCE8RjFt540ClfuvKmjGRRala4y+qrz3G020j6SvRqkXmackS
 IP1RiVjac34m68ao+rZfq4r0f0rTkvmIB+16BIUAHP1cBd9BrcpbzvaKHK/FqRYAM93qdwqBp
 o1CmkcF6ISPWsgDCML2IKlUe/45bWr3lpATybrWZQtgHlDwMQgg+XovMzw71qsvpJ/eC5x9SL
 3MlVLXRp/5Hwz+eEU6sbKeQjMm0wY91Lx/JNS7ldiFzLhkLIlqk+VPZg25pAFRkaSwSIJvXOh
 CtcLwpg1oKAXOb6hRviNiQWR3VPDA9juvl5G2nM2XcJ6fFvqLcdroghfXnRnTmf3sADgSZDQe
 h1gFbbwNfXpkRDLzv2TUZrIF4UuK/pmayEcZ9X4f4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 22 Mar 2021, Junio C Hamano wrote:

> * ag/merge-strategies-in-c (2021-03-17) 15 commits
>  - sequencer: use the "octopus" merge strategy without forking
>  - sequencer: use the "resolve" strategy without forking
>  - merge: use the "octopus" strategy without forking
>  - merge: use the "resolve" strategy without forking
>  - merge-octopus: rewrite in C
>  - merge-recursive: move better_branch_name() to merge.c
>  - merge-resolve: rewrite in C
>  - merge-one-file: rewrite in C
>  - update-index: move add_cacheinfo() to read-cache.c
>  - merge-index: add a new way to invoke `git-merge-one-file'
>  - merge-index: drop the index
>  - merge-index: libify merge_one_path() and merge_all()
>  - t6060: add tests for removed files
>  - t6060: modify multiple files to expose a possible issue with merge-in=
dex
>  - t6407: modernise tests
>
>  The resolve and octopus merge strategy backends have been rewritten
>  in C.
>
>  Ready?

I set aside some time to review this, and based on my suggestions, Alban
seems to be preparing one (final?) iteration. See e.g.
<b9d48a96-7e76-8a83-4ca2-c47fca326123@gmail.com>

Ciao,
Dscho
