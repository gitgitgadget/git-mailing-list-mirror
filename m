Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE43C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 20:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121CD2064B
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 20:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JodIMNQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390647AbgFWU21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:28:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:41163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390866AbgFWU2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 16:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592944091;
        bh=DC6qn9oDwZLtNIP/4/pl2l3+IuXUdocIgl6iBfEvhv8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JodIMNQAt0aQ6YKZTxsL0QQWeMmBVoj4NyDshz28c6laoBaua1yqfTauBHU31zpIA
         txodEa5lVTsYJ1eS5hd1+dT+XGhSLNdIGFRRE3EDVm1cRh4io+qLBnbPjVEm4XbTBP
         EPWgCX3tFAtF0MIma1F5xQcpU0RU35N+oQF/veQY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1jmTfo25jr-008eEk; Tue, 23
 Jun 2020 22:28:11 +0200
Date:   Tue, 23 Jun 2020 22:28:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default
 branch
In-Reply-To: <20200616142423.GA667151@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2006232214030.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <875zbrcpgh.fsf@evledraar.gmail.com> <20200616140932.GK666057@coredump.intra.peff.net> <20200616142423.GA667151@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-113551980-1592944093=:54"
X-Provags-ID: V03:K1:EhntgevODg1u8zL57oNhYz640tTVWVTQj1Ze0Sk3VKKPrroYyBU
 WA1tTq1FyktzKZ6tnBXCsYUsJpKz7/GmDAfNLrvzh4Mh138fghElJu37qGZL6jdopSGCRIE
 0hEgZocxcpV6/T/9QS8ha1CiGO8Czl+xy3zB1Ec9kFoE5PebY3o94EhY/PWGxeaucDmQq39
 WpXkDPQCS2cK0Nk9vKxmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N+mHhemDV7s=:miYYZ7b2qCLAQXH6Zg84I6
 03SyYIoKQJ225iwk6lEuoiyaMKbELIHI6QRcqbOY4x3/8TPRaNeonW5rhQQ/FMwB8vOqz0n7l
 COeNgV9+n7I9ueVB0kC+R6i5i7UW4zV0+UzLLibwvfo8+/zZlQjBHOOwz2YPKRGqqYMoTER/o
 iJcO6z7VvGUBDaGbkthTnG9ON0x8Pyfd5ykUc63h10HN+lqog7uRIogpxu1b7BlMNxhrWv5il
 AfCtdZyWqhK1uxnFnHs4sre7MMnbh4N54xszGY7KQ8jJWchUPcnl9RGo/pZt4H/L83xukDTQ/
 oDO6AUoDJ6VH5aHNOuZstdn+TO2cJ0CIay3EytdITXVGU4plzaBPgfb+S0DyOnY34iUEmH/wy
 g+uwsh9m+/lLIYtAnt4IkfOZ/ga4yZmCFq5e8V+XoqIjeBrbO/Hu/AUc99iZ1VDgGXdMjrjcU
 O+vEFSPT5npTj/d5fTKPJvai0/OK30y/bSThF48a3AcZ9R2q6k4gJZX62QxkqfelLl+/0lvZ6
 1GnoQ1Ejx+/+d19BYTgAEeWTVN+rqFv7MqvHPX/7cLq9F5upbu8EEYyjTqQFXTYsZ5wp4Q/e5
 Bv7TUHLvZHcdn21CTnEchoM25RVhoB/qz1x3z+u18ZZ+Ushuv0yLVaxI6PevdnQWMTMMRmzFc
 phfk+0Xczk7QIv4BgnhBdT1ru5npKdv0NXT2RYgQawyFwfcjgGJpjNsVtu2OZHMKwFiip3D3l
 KDWKp5qiU6/6lra/zPscOYQbx8/Yv8O7nPCHkkHbIz/SvpeAOg7ZeJVPykFaAh+kZT7J/qfuK
 KikY2bdp0aSh4euhaSAOSlAFYrQVk4L3iROOTGJLb2NJopynxfY5s3FpJpyWycMP8bL4Zr/aS
 iQWVMyE9qrvPE2Jo7V9S3NNzdhIH9PoZtp2EBUrjW4XETonkS96evFaH239xuz+MqLlcpSU2A
 5pITn3Me4vZnF2x30p/PPwB7zV99Kqmw/C63lzTRLuT6JNvC7vPVJ8n3mFq8D3vNbLdJDPxNj
 oKnRLltvoe3K4ag1nNqQkOZnUb+4tleCGpOfiwZx7qC26fM21JhBp7B3n86Ldpny/zyYQvtcQ
 q8xgyDThEqrizjLAzSrNvBpGOI0iLM2NGHbtZyAFuZD5wWe42sOMqfX0rRZ0rlbWqVFKAkAsU
 k2AT6JlLtJh0LxI5WogGUzXM9ffSa71LZmPofFJXvrkX/fEwyuuMAbd/y+XKjUWaDmSeb+1K5
 bYQgHyV6GNMj00AKRKTa6rNI1Cj/L9mUp8KPdZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-113551980-1592944093=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff & =C3=86var,

On Tue, 16 Jun 2020, Jeff King wrote:

> On Tue, Jun 16, 2020 at 10:09:32AM -0400, Jeff King wrote:
>
> > I think with that, we could ditch core.mainBranch entirely, with no
> > notion at all of "this branch is special in this repo". We use HEAD
> > where appropriate, and otherwise avoid any specialness.
>
> One obvious exception is that third-party tools may want to know the
> "special" branch for some reason. But I'm inclined to say that they
> should (in this order):
>
>   - consider whether they really need a special branch at all, or if the
>     mechanism can be made more generic
>
>   - consider whether HEAD is the best value for a special branch (e.g.,
>     GitHub pull requests default to targeting HEAD)

Indeed, this is applicable in many circumstances. For example, instead of
https://github.com/git/git/blob/master/README.md it is just as easy (and
more robust) to write https://github.com/git/git/blob/HEAD/README.md.

The same goes for `git ls-remote origin HEAD` and as a consequence, `git
fetch origin HEAD`: it fetches the default branch of the remote
repository.

And with that, I could imagine that this is not actually necessary:

>   - rely on per-tool config for what's special (because it really may
>     vary between tools, and that's more flexible anyway)
>
> But I'm open to hearing about cases where some tool really wants to know
> "what did the user consider the special branch at the time of creation".

I cannot think of any use cases, apart from essentially creating a new
repository, where a tool or a user would want to know of such a
preference.

Ciao,
Dscho

--8323328-113551980-1592944093=:54--
