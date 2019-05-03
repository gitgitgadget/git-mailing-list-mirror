Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 893981F453
	for <e@80x24.org>; Fri,  3 May 2019 09:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfECJJP (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 05:09:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:55659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfECJJO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 05:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556874546;
        bh=HDRV93+G0vQpANlzaPWH98Gb5+q4rKV6XCx5n5Ddc9c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TiYdI34KT9baloU9Fu8OalvCEUFMZLKIm+6pX5vgnTL+ilus4fJzMmkf4KvFwx25a
         vfuRZirjRtcYGPK6OD+90z9147NCFTCSPR2JJJWTyoKAT64Bhch1QrjN75xrHMhZSt
         416Qh0Xbw/g1diHleL0opJGArtJmafKWuYPPZdOk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.123.157] ([95.208.58.119]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1gf0J127WL-01037c; Fri, 03
 May 2019 11:09:06 +0200
Date:   Fri, 3 May 2019 11:09:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Jaros=C5=82aw_Honkis_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jaros=C5=82aw_Honkis?= <yaras6@gmail.com>
Subject: Re: [PATCH 1/1] credential: do not mask the username
In-Reply-To: <20190430222146.GA19492@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905031108260.45@tvgsbejvaqbjf.bet>
References: <pull.138.git.gitgitgadget@gmail.com> <e459e487d3848ae1b7f37676bd9d2a2f9c967430.1556575570.git.gitgitgadget@gmail.com> <20190429234028.GA24069@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1904301753030.45@tvgsbejvaqbjf.bet>
 <20190430222146.GA19492@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PObrcQeJKXvUNAor1ll7CrSZgIAGMrZqTELc9FDRCecDdL+WdIG
 wriMUFMt4lDqs/EGYflYWeDg2/KhqmggPed/THyrrHzgKv9yz887nfajcJxXQITH7Nk523V
 BZja45CB4BXJw+KTDfkaGLYRdgLHjABI1K2oUuW/SKSw/ysXeVgD8JJqazj+gT7FKSIfevH
 UBdr5oszHpeImt99ScKiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XtKuqU2De+w=:CuPNF6JyVeV/kUBdFJWik2
 N8Icui8IEFqbMeyAcWRkfE7IIij2xHXgiD2OQU2qJM8ApgTAxagMS2WMq5/wWKEi5mzq5ftyL
 Avd8evVIBGPZnMLbBUEDQK/bY3GKLgtXEIrauMnOdjrNlWLGRjmWjNNcPa9A2QnE8scRhtOBB
 veUxj6WRE7bPXsvNgxbMZDZQCMAEoNr3WhnPHYa+xoyeeL9KXKbCgZNjM3RMUYnU/HHJtc8EX
 6pHIKCuAA9AsXT+r13c+yFrnO804n9TMDZ7xQdKBdRbnqZ3B68ahNqYyoBNe3tAGowgRm+Zmi
 /aqwjuH3nfiDtGTRC2o8sLCV2ik6U3WXbS3j8RS/eSJ+PvPRqMh0WWuNbYIZGw49NvPU/noDD
 cKanWH8PAl7L/NWRFtH8V05+5ufINLTWlanP/Mqiv4iOzN5le66lSs3LYK8Je0+HJh+sFKhgf
 lmHm7sI0Lp/WB8vLNv7YgFtJw4WHu10iGsh5JS6o0jpuIBvK+o8SXGfKyqSxfHNHA7FXoccR8
 jhwoO/S2MlVOXG3KQAG0TUg0Mavvk0thK67YtjQgodCppb15qW3r7jvTnQgPYKE/sPWbbncwe
 DOgOEDw3E2c8IjEt/cxT1Y8E7eNbHijV7ncWIT/F7VpXQYEV2Rh6jHo6jqmBvTPGnd13BghmY
 2VkiOIznUvRWq2C9oVM2ii5H7dTrmsYyunwjMdQDj4zyi+6BLizf8spU01RgJBnoNoUFFY/zi
 RnkPkNnXjdXbs1I/Byr4v9mgBtrDUqytpNkvmqUG92pHJW6vpmYsvD7H5BMb+t3mAEwTkyome
 iYYAuFGZXczg4SM0eJWtX2JZ66l9+kIneHPr6/ZgCc8otSV06WOED+M6vSc7AyvNGMvkEuB2J
 QvUMG7tV7u8oKL7U+FiXH/vUiuob89nbrBn6m9+MhEMZ8FpNi03YdPXBgBU7JCI/cQJZwq9yT
 Hakw+TbnOnA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 30 Apr 2019, Jeff King wrote:

> On Tue, Apr 30, 2019 at 06:07:15PM -0400, Johannes Schindelin wrote:
>
> > Alternatively, I could simply drop that patch from Git for Windows, as
> > it really only concerns users who override the default, opting out of
> > using Git Credential Manager.
>
> would be the path I would take.

Okay, let's drop it, then.

Thanks,
Dscho
