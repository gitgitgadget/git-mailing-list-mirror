Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3C9202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 12:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933690AbdKGMUi (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 07:20:38 -0500
Received: from mout.gmx.net ([212.227.17.21]:61053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756776AbdKGMUh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 07:20:37 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtVLE-1fCdPn2wGi-010uDL; Tue, 07
 Nov 2017 13:20:32 +0100
Date:   Tue, 7 Nov 2017 13:20:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: bp/read-index-from-skip-verification, was Re: What's cooking in
 git.git (Nov 2017, #02; Mon, 6)
In-Reply-To: <xmqqfu9rizwc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711071319430.6482@virtualbox>
References: <xmqqfu9rizwc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gjBY9jDyYjBF2cdHhTBfve7yMHefqGl3BQB8deKVjVzqBa2WCTd
 pMQGXBJZaUtbBmJ+xeKjn5Fw2gunmVR7AyHTUJqGoqtYrjQyCAgtpSSG7rEvohruObk9ZXw
 hRN4gPS4NlGyRtTw6j8tPVusbHIwVT0LS2LuCaXvrBCo6i0oBXjdugJCYWXpef/DPTbHHFM
 eCks6PPXOxdrxtb+NqhrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YixuIlSBS8s=:Q0uyXdFOT/rCIkgo9HxpVm
 HcwcTNpzOMT7ULdpKAR9WPKv2z3RO1hakoATYEJpqOjCqwkhibt4gf+m2p5dxbDJhm481/im2
 s6NebjdhGjV+5m8TZ3YPFgBmyBuhuHLGXX8tr7j0jgdzDVYLbvifLTCfGqmYjeyCXe7QmLS/m
 xMY0Bzl2M2tdvQ3B96vUGw4FJ/CfM9ko4RxP4B4d1reXE0JDGogmaVT0JMK3fgVdtkYU1ma26
 g+sbQMT4VAsTf+z6h56rJrgRV3tcwbrCzW+v+632RX8qo1eMN1dI0OBQ+kiC4R71e8AH6yRYP
 VqpnPMGIH4NYANyI+cPAFbwnEBSagQNRO6Slv7Jayd2vwI/Cn8T0zkki4B6KQnLYj+uzHeqEC
 fPhr8npXYtjXTrB05FZDk9xH8lLJ6KD1H4u9sJiNIrb+couA/g/nxew7msWAxl5+vLxHK3/98
 3VJ+z1I7EX1jw2y0qCOV/P5HefAi0yYU1fA9FVzJxfDcqQMK/CswmRGEVQCpLUANsd9EwoXr4
 zRgMN3V1k2BEKFQwwTDoWVLVV1L2vHVEofggPR37CPHN1YtKes9ElXakqEMzvV5zljKz0GjR/
 bh9ADF5Zn887pZ2lzjuBAr8yJZQ/uYLsdsODk8MAhapEYzyx09WH/Wji7pbiIeII/g7Puh9tO
 +YoAUs4d70OHNCG4VSejIx/c4Pf8RkpJwzOkPSG+/hWtgqxTFl/Lx3Pkd18uyIxxAX19+DSws
 uvNvDwjc329pFw7z/aDaHnJpu3yCk0fREr+UcArJz6n2FWloJEzg3XfdOhJst8OZXtiwREWDQ
 kO8M2KmHH2rAFi7hZSf1AAjMrSdsSkAHfeW3IMNSRQuWtCOR/4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 6 Nov 2017, Junio C Hamano wrote:

> * bp/read-index-from-skip-verification (2017-11-01) 1 commit
>  - read_index_from(): speed index loading by skiping verification of the entry order
> 
>  Drop (perhaps overly cautious) sanity check before using the index
>  read from the filesystem at runtime.
> 
>  Will merge to 'next'.

Maybe s/skiping/skipping/ before merging it into `next`?

Ciao,
Dscho
