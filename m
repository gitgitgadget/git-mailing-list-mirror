Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7D3B1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 12:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbdAZMSJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 07:18:09 -0500
Received: from mout.gmx.net ([212.227.15.15]:54668 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751815AbdAZMSI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 07:18:08 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVui8-1czECN0eK0-00X6mK; Thu, 26
 Jan 2017 13:17:59 +0100
Date:   Thu, 26 Jan 2017 13:17:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Wong <e@80x24.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Retire the `relink` command
In-Reply-To: <20170125232051.GA25810@whir>
Message-ID: <alpine.DEB.2.20.1701261317250.3469@virtualbox>
References: <10319c47ff3f7222c3a601827ebd9398861d509d.1485363528.git.johannes.schindelin@gmx.de> <20170125232051.GA25810@whir>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sUVUYhblf9yQTrkbMxsdzP7g3SQXrKj83RE+8BOP4Wd0HIIbyVa
 1ONvSCLyOcekWJAyBQJclhS08bu9u014sdYaVk9E/sJqbydsJo7QWpQ3o3XZ50IHpcKS/7O
 XJA3V0+NzXVdEp5Uxxc60wpoBipHpaEcA4SOFdsHdWMKoS2mT0pQ//JCBZNP1M/3HDaRc5d
 wr9k57/D/6EwDl+d/Fdng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wtdAUuhmS30=:Nq5hA9mla97ryJMTe4TEGZ
 WsvVbx5TaUpErNZ9sbcrGQizN7LrUUR+ZeGg7WLjTL2Q0zRP0BKZyDfhLrKpv512l2B+PI1EX
 HH2d/g8FRy+NyE4DGcgNnv3i87nUh2ZdHEcBu7LrwmRvIahkGGbJ1vYmHrhYsjKYF2XDL67W9
 DB8tE4ofm0GDYrafKLO7x08vnmWFM1FHM1gD5ZgOMXzQ24Mtx0RylhRAvmSfhMJ6VjlxDbK/e
 CAL0vlQFXFYTRCty1Du9uwn5sF+6GcGKcMUwpwSG092CuV/5JYnAfCN8UJth6MAbNyL5G9N87
 YDv1xX6XhVcM3EDxGNQopTOVI+DffoDoboj/MNlxAaVLh54OSsr0gm87ptmrxkRiMvNhoYehv
 lWIJdzA7hSdtFByTNDPx8ALhBaJp7MFEZ/9RgQUk4/8ax4rZ0xhTV8YQas6Gd3e5RcIXg8Kkq
 c6Fgi5ggSMC7chfl+YbYEQGWvl+kycG2msgEMEjEAv1sHKB3CSURXrazFCh1hIZjGUR/mfWMk
 XcjpxLTjGRzlxTuPCZnWptsHe7bjEGCUhJ8YZLb8KxETZBCZRhKk3XDKNAM98HPXOf60wkZJP
 TXmTLOCpcofQn36RtwJu59C4XEDQXL7gU9hSdlHQd6Jhbdf00Op5PgcTvpldE2Hy9IVQ+GHDO
 N7FW4j6AxzR7fsrWkV5RoPrrBHaSaaYfbhpCmpRVh9E0+Q0p148YydMjJUB4atOnavL4iHaer
 kQrVOhfDk2JlL/F60XMt3iaZ4Q7G4iAvqWIZeEqUShmppT5tTFSzOQbXkqletaAipbbb93s+N
 BqxB1lw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 25 Jan 2017, Eric Wong wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> > Back in the olden days, when all objects were loose and rubber boots
> > were made out of wood, it made sense to try to share (immutable)
> > objects between repositories.
> > 
> > Ever since the arrival of pack files, it is but an anachronism.
> > 
> > Let's move the script to the contrib/examples/ directory and no longer
> > offer it.
> 
> On the other hand, we have no idea if there are still people
> using it for whatever reason...
> 
> I suggest we have a deprecation period where:

I would be fine with a deprecation phase, but that decision is solely on
Junio's shoulders.

Ciao,
Johannes
