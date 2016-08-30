Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CBBD1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 20:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbcH3UrC (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 16:47:02 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:49853 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbcH3UrC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 16:47:02 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3sP0tq0shkz5tlC;
        Tue, 30 Aug 2016 22:46:59 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7EA76303C;
        Tue, 30 Aug 2016 22:46:58 +0200 (CEST)
Subject: Re: [PATCH 06/22] sequencer: release memory that was allocated when
 reading options
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <e4b48a9a73ff33179556c0137caae85bfb4a48d9.1472457609.git.johannes.schindelin@gmx.de>
 <9797cb9e-115c-bbea-51d2-a5d686aca514@gmail.com>
 <alpine.DEB.2.20.1608301948310.129229@virtualbox>
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e07303b5-028a-6804-7471-356e0b7293d0@kdbg.org>
Date:   Tue, 30 Aug 2016 22:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608301948310.129229@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.08.2016 um 19:52 schrieb Johannes Schindelin:
> Right, but that is exactly what I wanted to avoid, because it is rather
> inelegant to strdup() strings just so that we do not have to record what
> to free() and what not to free().

Please, excuse, but when I have to choose what is more "elegant":

  1. strdup() sometimes so that I can later free() always
  2. use sequencer_entrust()

I would choose 1. at all times.

Particularly in this case: parsing options does not sound like a major 
drain of resources, neither CPU- nor memory-wise.

-- Hannes

