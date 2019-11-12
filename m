Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09D3A1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 15:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKLPJm (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 10:09:42 -0500
Received: from mout.gmx.net ([212.227.15.18]:37691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfKLPJm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 10:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573571357;
        bh=I1rqNvSsf0PNqOHJPtse0H09dSIMZdG/ny63R+6/kxM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c+Bygu4xzQVV6CtXiCFrppxmm0UL6yrAYU8Qgmdta6dXIsxhcfX+nwo/zYln5dGEy
         cEL5+7avb3NjZqpPjtRa01n7Qy8sAsfPhZkObWR2onrPfIM++kndq10Zn0ba6/EjYP
         vXY/CEmIQyND8bZoM4AXiPPoeGxFMHIKXdeZMOZg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1hyWQ43qai-00h6ka; Tue, 12
 Nov 2019 16:09:17 +0100
Date:   Tue, 12 Nov 2019 16:09:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] bundle: framework for options before bundle
 file
In-Reply-To: <xmqqzhh2hjnx.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911111918410.46@tvgsbejvaqbjf.bet>
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com> <20191110204126.30553-1-robbat2@gentoo.org> <nycvar.QRO.7.76.6.1911110943240.46@tvgsbejvaqbjf.bet> <xmqqzhh2hjnx.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ENTyGZqPuXh5cV/l234gP0eNYqVEhHdyTvuXYamaziX69ZGiY5s
 ZvncxEzhdInFdgD0tNR1uh+qE/JYrqKinHhcmkpZCEdL8/ASs2O4mjkMfTp6CkHJlqQaUOT
 w6B+96aqR5danfk3dB4SU8qhCy7D22uBFHBSBgXOsVvxG1D4bHUAI0iFrspbqpOovNchkW2
 EqCv2ZURVsIfwtGu3pcJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LUh0OIkUbyY=:VdAgcSU/Pz4+4rC8ZwgSnX
 9jPFLJUVUWI6sVI+FnBWRzv3Pv/DgdSKYT98PKUWKpsI+W3QZEoc4/BjMD8n2PiRJbS7qkbIz
 H1fKXCMEHE/WmlJ7M2oN5/MLvD7lYtqyYrZT/Dc+s1fi3I6rgdrMRZM5NaQFJUvr6ed2JdWYt
 eo4/am97kHN677Q9BirDtPuqADAA1UuXJ7k7LMDRLxPoDEEdo624aCbN6Dww5S8krU5tHtRsX
 u4892rv88sjN0V/gfjssEG08fFzJR2jDwfT5bHvFiHJRxzhjtJECvyE+5yqJWUVj5g/67EvFm
 6yRUZRzTfxJ+U861Xu8ld/EbNRYohW+ynXaFKGEHZZD7axLu7yMOaqarQ1e9qE7hnJ69SVTX7
 WXeuqn1UlcbxZMAWD5ZiiIkWBo0WRLmSvbmbHFaGlB60ei4zpchtnSFHnrXRKgs+59gUzqchv
 G/ElLjFWNO9VV37CX/MCPduqW0XaFvrew7wDykDsL0/R7/7WazNLkiBt2lk3v4T8+aAoazMD8
 evHzCs2p834xrz0ToNhHUMqWgDmcWUTVo/Hy1hWlT2TIKJah2jYKYxGll+gZ3+d50FuUyYcoF
 5MRxmBjBUYXbe55CwHfyc6/8fnv5MbO0XBZSZJNM+92Xi8ugMbGuMUgQiI0x400FBbZlMLdWk
 hKVaphvG7vpbaiZ/E4osI7vfyycf7mblLwCevjOuZTr7YpzHoQQFm/SPgMDtEPBIchzaMZuzk
 WSbDQU5FGKAJvgidH1yOX4tIdSPoHr1lb6v1ywe7LzlF/HjwyC5XdaMkTu2UHaA7mEZ+P708u
 ZdfZ4NV70RwIxpzbYI1yxefv/T9l1SmbAdYOhN50iUPbqcYMt8tEC5P4+VzYB64Y9BJ6YfaIn
 C0tNC+H4mJFryw88YiKE4S1snovN8NtXpl99jBtbc3Vu3owQM6L3tMmQryefa7jYOdDmWirG8
 ICVyx4tRyFfSuCcOoNffDMJ9YgeNDmj4H0FOO33n1tMfLSEoZFiC6i+teHgMWjUHlfuKiQx0y
 2lspJOnmayuUKg5RoEm2RcfERpRMb0BwqzqJj1QrKSJYbMEQnQYGR5iVT9SkEMLb4qh/EYQ/i
 3iSMDBFuBu5mnSlpnF+6dgj+3ZPdVZ6av/Dr49JbvIHLtHVFiNDWjD1sJ+UxM4oWIuKluJf+H
 +9u7IHaOeCBCUR8+hYVYVs8dQHqRTYoOvbj8M3spntveZbALlkJcwVcdvUatEq53ybuTkiLX5
 p5BUsKF3b+i6Axd4BntEaQpN/Pf5+QcAhx+20rA5jttfx2+yGKzE1oBgV4/k=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 11 Nov 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > The mail was sent correctly by GMail, at least it reports that, and th=
e
> > mbox of the cover letter reads like this (maybe anybody else has a clu=
e
> > why vger thinks it okay to just drop the mail without further notice?)=
:
>
> > From: ""Robin H. Johnson" via GitGitGadget" <gitgitgadget@gmail.com>
>
> How does that doubled double quote work?

Wow. I looked through the mbox three times, and I managed to overlook
this, still. Talk about bias.

Thanks,
Dscho
