Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D511F790
	for <e@80x24.org>; Tue,  2 May 2017 20:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbdEBUvl (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 16:51:41 -0400
Received: from ikke.info ([178.21.113.177]:45500 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751239AbdEBUvk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 16:51:40 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id D3ECC4400B1; Tue,  2 May 2017 22:51:38 +0200 (CEST)
Date:   Tue, 2 May 2017 22:51:38 +0200
From:   Kevin Daudt <me@ikke.info>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
Message-ID: <20170502205138.GB17703@alpha.vpn.ikke.info>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1705021406510.3480@virtualbox>
 <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
 <alpine.DEB.2.20.1705021756530.3480@virtualbox>
 <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 02, 2017 at 08:52:21PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>  * Due to the bizarro existing semantics of the configure script noted
> upthread if you have a git build script that does --with-libpcre & you
> have libpcre1 installed, it'll link to it, but now since
> --with-libpcre defaults to libpcre2 it'll silently skip linking to it
> if you don't have it installed.
> 

Case in point: The Archlinux git-git aur package[0] (community maintained,
latest git version) does run ./configure without --with-libpcre, but
 requests it from make with USE_LIBPCRE=1.

I noticed when trying git grep -P which then failed.

[0]: https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=git-git
