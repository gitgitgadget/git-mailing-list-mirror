Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C22C433FE
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 13:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbiCXNbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348288AbiCXNbp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 09:31:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0064F66625
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 06:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648128601;
        bh=lDM3mGZSPSbba2og5gDs2Qztlysr/+UOnlxzKvqv+0E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LFdJUfAj027lRAuWWgIJ6B3+A5PzJO5SjE2A5QYGOAuOQn0AY69eSPv2TguY77lge
         0TTumPxBLOxAMjq549Q3pA0g622TmenpNBz2wGSwnkQmERalFVKA7r9ri89I4hBXpz
         xDPQ9hA+2CQ9ya9QDGzQqT96x/fxG1OjfJv3zawQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([213.196.212.0]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1nr06g2W1H-00qkQW; Thu, 24
 Mar 2022 14:30:01 +0100
Date:   Thu, 24 Mar 2022 14:29:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] a couple of read_key_without_echo() fixes
In-Reply-To: <xmqqy211t512.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2203241427550.388@tvgsbejvaqbjf.bet>
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com> <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com> <xmqqv8x5s1w3.fsf@gitster.g> <8d44b509-ff19-0629-30f5-ae785c73c3aa@gmail.com> <CAPUEspg1cJC_UwjJFx-jnzWsascY++S3UgM1UCLRcnK_Mv2wOg@mail.gmail.com>
 <xmqqy211t512.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XB6ZTDqOY6w4b/XorOfLcKUti7meRoRn/IZKYITAI5T5XMpVv7M
 BH8JtoiJ9fmtUNh5nRPT8WnBUejIAMoxyAtNAjZVJKRoWgXwGr4i22NLtOeJwQIDp9JlCQr
 XfJVU478V07cIi8sOoolYLjI7OTA8vikWgTQAbyQFFxEBWRqs5K/7dP9IjKtbbR8KdvLrom
 8kQFVnGMRMR16ZK6yo6KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W7EemLwZTVA=:9sjdVu79HtLBjlDyZddwVi
 VlJWi4rlN2VDkwWGwUzR9KRmKNNW34afgYyqEWNidERq/f+xuvE6BbO4/wGTSJ6AccEV9CQwY
 s+WnjiUykRufU04KBUM0NIS5uJdSEjbqAt+SXQnZcqAg2Pxd9EU8QEvN92DNdGHdQlk7X99Hq
 6bo9R230/olmN9WHwAD+d5Tty/mNPmjaeCvHk/5U8YE350E/FCwDvw8EP84jBArAMKTqRL1WN
 Jeeq5Q+KVsZPbPXo/BLiHtuxXmDD5EWihsCH+ZspZro1//Hd3Mht6SgdzXmXYBP1hxAByzX8d
 aCL8IyCG5wSCAG9wMMGifk59xHp3aXZcpo7f/KZoq3lBtQ0PdccjUZ644jQX4bFxY62DNcOhY
 /IwNNN2DaKhF7y/T2wVrRDuhGzXg4bFKoxVG5ujLfXPj2m0FZ9NhkKRMzvWk5nWDT0WEr3Qh0
 9D5Zb0BhHeku++j1ZEIvcwYY46V73v9aY6aB3en3eup5GYPpkw3/hVYcQ3GPmvxq8/V2rj2pa
 p+p+mteeV2xHIHB45mER1z2cm/PByFvCK3lNgp97uPL7UE56R3gF5vIEiOWAQ7OozCvzFag8/
 ndZ1uo8FRlbMq08Bv6AFRUVK6eIXUKBbiyTWo/sx8MfamqNH7cEi42XGjhnbicN57h7SgIFt6
 +H7XS+28V/ZP+6RPk3JufCkrjigMhN4m/sYoWq7BiFy8lz1KFWHngBoIwoI7D8APEKoXK0zFQ
 zH+KN2UDr8uXjw9GaHecyTdPhIiKa0bmtFIEk1m4O2TVsNR4BgwN/BVIkE3aLjorAKSCWeIak
 Ls/BC2PCHZg5U23ubP0P9l/7rzd4lpQJolvfZpyCn5L95bWQ/NHmQjNGSYDxYzRgND+oqoXCD
 VTc10bF8UGJS1UI14U/PF3i2M2QlB4GLnaQ9jIYz81hbZyHBkGUKkqR8Beczl0ITMXI28Z5tV
 fFmoa9moRIgEaIzhOeEqq44ZvbZiX1BoP6ura8y9K2cri9KRajVQG1zsTp6Dm6mDCBVN+qwsa
 sAcHIyVIe6wOI4M3QvGUrMifSayS4Aoy4+rlLKVBLCdw6HzavYVW1hAMqx/NpxhyutZDDfchj
 is1pb4bh+rgFIE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 23 Mar 2022, Junio C Hamano wrote:

> Carlo Arenas <carenas@gmail.com> writes:
>
> > On Thu, Feb 24, 2022 at 6:30 AM Phillip Wood <phillip.wood123@gmail.co=
m> wrote:
> >> That sounds good. I've got a couple more patches based on top of thes=
e
> >> which hopefully fix the remaining problems (notably the macos poll()
> >> bug). I'll polish and post them next week. Once those are in I hope
> >> we'll be able to enable the builtin "add -p" by default.
> >
> > As this topic just hit master noticed (I apologize for not doing it
> > sooner) the macOS problem (tested in 10.15.7) was gone (suspect fixed
> > with 1/4) and therefore enabling the builtin by default as proposed
> > originally by dscho could proceed without the additional series.
>
> As long as it is a belated success report, nobody would mind.  A
> belated failure report would be a cause of sorrow and grief, but
> even then, it is better to have it late than never.
>
> Thanks for testing.

FWIW I tried to reproduce the reported issues, but since I do not have any
hardware running macOS anymore, I only had the avenue to debug via `tmate`
on one of GitHub Actions' macOS agents, but the problem did not reproduce
for me via SSH.

I am grateful for the great work put in by Carlo and Phillip to fix these
issues.

Thanks,
Dscho
