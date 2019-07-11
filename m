Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88DA1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 11:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfGKL4s (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 07:56:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:52409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbfGKL4r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 07:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562846199;
        bh=OZSDXFbHvW/uo1mDrrCn89U8UBBLoqitYITItF7nYj4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=K8Jt5e9Zh8ZjiaqRB7nPORsEqlv9ju//pVZbbCPXs1qkzWIqhYxDZmVIdSR7D1WNY
         YdKwE72IHYEZSXw+0uA/TvhrYZRMmKtBpYgpNtqqIMzvyfFyGAjcAtNNmBGW8AvEZd
         smU6p6NM/2YyAiOHcwOyKQZAY8eaNl58dxh02rro=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY6Cb-1hzd5G1uVZ-00YSIx; Thu, 11
 Jul 2019 13:56:39 +0200
Date:   Thu, 11 Jul 2019 13:56:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares <matheus.bernardino@usp.br>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com
Subject: Re: [GSoC][PATCH v8 00/10] clone: dir-iterator refactoring with
 tests
In-Reply-To: <cover.1562801254.git.matheus.bernardino@usp.br>
Message-ID: <nycvar.QRO.7.76.6.1907111355360.47@tvgsbejvaqbjf.bet>
References: <cover.1560898723.git.matheus.bernardino@usp.br> <cover.1562801254.git.matheus.bernardino@usp.br>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mSloDGcNa70adIvenNERj08oly1d5nj/z06wLXdbEDgr9Nqj1bw
 REPCm0vgodjOgTat762toEriB7cgSAVKamIY+puyikCQmnnglIOCHwkCWv36nuMhVXAo5+K
 3B/9cWyG4ncOOOkwMAHqi5M/lu1N/tGfr832vo/yB56p6e4KoMeGA8GyGtndvYc4VxUhLw1
 o9qWQPEbOUi/2OVntsNlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9pAsaxFOU+U=:kkoQg196BK4VlcN+Uzo7a4
 MnKz6kTZSEdPosFpZBB1kgo6lVSv6ONAsUjsqXDX8PbiFOG5qceROah4b15HgWYhnA9m0CcLq
 QJwd0j/ZG1IORP7CS7DXYWYtldQN1EALkkQO4/seM7LIoqS68lAbITL+vj3OWFKQadPvMWUVX
 Fu9QEKswbZg25lokaBcRPslsRoNoS0tYHY+89IDiBBXDMnTQindOR+UsJnOyadRPFPuwK6Cfr
 XAEdYHHWVw4OL4xbQ5G7kBXcxejbicehHYVhxCBsdMzd95OOyg5o3s4X5DM4g+4TaFnsr1RFP
 Om8G+aeaoJ41BD/sLBqZ19cBeRekHuRHOUglOezsrXacducWnIznND51aq2wEbuamiDSM7c4j
 TerQfpL+sbLn4PhRNmNR2bQqEHvBOEGZdnrOiDxc/2YS/8+xFEt5Jb1bVCqWSZ+qCt8TBWuX/
 YR3s79apf63Et5FX1UQMxQBcZ2v9+TXa3QJAMXCjUpf92xawQ6YWdAil8jjU3VHxKifhDPSEn
 z3hz1AyjbFvu8tqUxiHlzwt5Q3kWSjBoXaI5prj+l7aH8CdY9EOEQwitf5ahHFtNdDB9DptoB
 uN3eQP2F23ltDBjazFKV7e1I4hPPAvxqy+dfESoA3fakVnElsDz3s9zqqOUG1e7vYkmp83KmL
 lj5tmyf9teSd490+95UapB7XYMaWDPUOMH4Osr3x4ZUOup/81yEKFMTxTHY6HsjZnYp6qpYVJ
 htYJBM13XMeNoI+PNQhq+E6pYld65gcl1MNvv/1GltPl/fTDvX3WXUK1jvmuIAVmOTfhNftZJ
 7g8wxQpYu1a7aSK9PJoRAhsdYCUSTewWBJ7hlV+tOc1F63+mZiJZ3UnADlFvWnk21BTeSm79g
 2VI8ZMtAd2sQ8/qmHxBOX5ez3AWJG7lvI0qJHqsaRTeGhNWeSVRLS6JfB9XLGnumPgbAFEM9l
 DzSOQM66kz/H1xUWb1+wNOurYxcNyrHyZynmh7hWaN8nOLINDkaoIs/KGChiOoTuHO1nKW71z
 cbXKu7vdagfNFdNZCW7gayGGmEf0xVSLXHzqS7IP0ieCgUbnfnKgWb2Bf/+aQD59UWaQIfqoz
 OCCgQ+zubFD4itB8HRxNWADSnqdF499nIoY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Wed, 10 Jul 2019, Matheus Tavares wrote:

> - a replacement of explicit recursive dir iteration at
>   copy_or_link_directory for the dir-iterator API;

As far as I can see, it was not replaced, but just dropped. Which is
good, as it will most likely address the CI failures.

Thanks,
Dscho
