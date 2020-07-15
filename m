Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759C0C433E7
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 20:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 472352065D
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 20:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TZAnlsB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGOUvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:51:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:60593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgGOUu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 16:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594846253;
        bh=gDqZHsrXeKaa6EEk1zrL7M9gS7Om/WZPwIdAYOU5ci0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TZAnlsB1Cc8HQ+HCmMi1jH0Dhhb0H3zzK+cbowdh5mi7qToldOEnGbd8uFYHSK4hX
         bzJ6hsUK4d/A4Y5QHgBsoUT16qhJC60oZaX63kLoZFwjD380lhheEnRSEHVIj46TRx
         CPY0hC5oh79qLMbHw7ZTQWgd7REGgWaCE+T+YQzc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.94.224] ([213.196.212.204]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTAFb-1kHyL53kz9-00Uess; Wed, 15
 Jul 2020 22:50:52 +0200
Date:   Wed, 15 Jul 2020 22:50:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: es/config-hooks, was Re: What's cooking in git.git (Jul 2020, #02;
 Thu, 9)
In-Reply-To: <xmqqa708wen2.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2007152247210.52@tvgsbejvaqbjf.bet>
References: <xmqqa708wen2.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iZai+qvkUKTu6lluER9UsXHu6AwI5rpHUGj58cvcDN/7tP2JQnT
 /omrbYZNhYqEqqrNuIWhA6iAbKwxETMCUYVOWglpAHM5Jnlgqmk278mRLUvuLnjeuVoenP3
 fyQJweueNNYJgNtWohYnBcBic1SmdBwthsLMJQ01XuLT4qXqur1l3xpomNXvdWzx1pDI8Dq
 YtgLEfsIWZlsUtvKkBS6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8tO7jeG2Zjs=:eT9Y3pqbzT7Tg/QI0NGGfa
 ykFyNSo2RXHVWr8hcQkKDTwizaxYSI8VrvQfSTC/qIrw46+r47a4QROPiYnEv46tKMR3TfciA
 mGuEDwRHIY+MZ9AGIFwiriWDjK/QgZuGO0tIV1o+FyscMYc3edk0hS91WHWpP9GAl7Wm4UsYP
 winXGiB67j4UiJDE7XgONwDV1kNPN3LQdGBoOHUcSsK9f83u63HKEm3g7sIDddnZ1INU+vuu2
 +2Tggk8rRfz/27jnrjWk4msAlC/MFlsMyyltZLD1WBEXWPlFw+hg28tlVWjosZWVOHIMSGirz
 ZaSOANtMocplBBC+JS9Os2Gj6AlUs/jYf/q/THQ+/3gRBluk1CP1/z5dS5soIXiepkiv774FU
 EHaitefbanJT2leTuc6o0vbqBkBEUXW0+PtdlzOdbs7QLcv5NiKAezFCTN9/x0m/pNx+qouAG
 EiOSl/qPZS07X4/o6yP4HNTtyQBMW48RaT7EOJhQ5gqN2uzqi3SGbxY8Nd4CF6wZlSsE06oG0
 vT/n5D2oP9ZGlpcHPUio2rfWryFRUuObe6kmxAwEVEkK4WETd6FU2UADALlfM+n/snEIxN8jP
 +aTjwOGuW4kYfFWscK8Ocd6iopZjsRJCPvuL3d/0jqICUwDI3gh5zvIjJ/BNF/wZ0qWTBo0My
 U1xaEK3f0UoT0iQ0abcyqmmxRBCLHn8zPp45fbJJPo7buoIm3g+TyK41UzHfwSI31dKq5NuQv
 QfEUQC+IOEKSF+OiT27rUEHU8y3qcqZF4wHBXwpuCDhVePjbGkEPB2fMGd8arZl4e963pP5/i
 MfKpOdi1vDvMX4GZu882cFA6WGgvjt0BiL4aznpsdaINobdQIdQfFfUvoDg0oOr8ha+VAkdC0
 qXMolpwL3xLCajCyDhk1xD851ZOV2rsamXvrWSk2tyvoTX0fnNw0EEUMmBzmFe+Vv1gF5piw8
 yni5luTfFWrS6wTYZKmGMQ210OFkYyVheIAsB1gPic/CrwcSk77bbQXVJCDoPLFdJ67HKR9eu
 9lL56HKiX+8Fzn1nUyj44PD5GNDvpPRTJL9OkgzyBLTOfcuVawdn7958Bv9epVkW5RCXH3Zqf
 Xj39RwcHFlMUMSX4fBdfgyb6+N2CA8aN24bNSyUGFBbTvDxcjZfKfQsJoycqLEvBPcQwbPndA
 yI85la0eUGXnhiu3L/e+PMk93ky47xwOoITSIVj9arH9gjHajVxvrz4Xczw7N0xAtP3gskORS
 /1k+BK6/51jWPzOhUbuwZGJxS6woLPaYe9C9AHA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Emily,

On Thu, 9 Jul 2020, Junio C Hamano wrote:

> * es/config-hooks (2020-05-21) 4 commits
>  - hook: add --porcelain to list command
>  - hook: add list command
>  - hook: scaffolding for git-hook subcommand
>  - doc: propose hooks managed by the config
>
>  The "hooks defined in config" topic.
>
>  What's the status of this one?  Abandoned?

This patch series is unfortunately still breaking on Windows, at least in
the version carried in `seen`. It _still_ needs the patch I provided in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2005250055180.56@tvgsbejvaqb=
jf.bet/
and the patch (which I accidentally reversed) that I provided in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2005250053080.56@tvgsbejvaqb=
jf.bet/

Ciao,
Dscho
