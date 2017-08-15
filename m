Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4627220899
	for <e@80x24.org>; Tue, 15 Aug 2017 00:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbdHOAa1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 20:30:27 -0400
Received: from avasout06.plus.net ([212.159.14.18]:50416 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbdHOAa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 20:30:26 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id xCWP1v00618PUFB01CWQX3; Tue, 15 Aug 2017 01:30:25 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=MWVatcTXBN02smkYpr8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
 <87fc215e-b860-10f5-5c5e-60652502fae8@ramsayjones.plus.com>
 <20170813183026.GC31079@mail.zuhause>
 <627042be-ab86-e9da-8c4e-5aac3278f5c6@ramsayjones.plus.com>
 <xmqqtw1bw1v6.fsf@gitster.mtv.corp.google.com>
 <xmqqfucuw00a.fsf@gitster.mtv.corp.google.com>
 <c49628e0-6a57-34d6-6727-f8111b80cbab@ramsayjones.plus.com>
 <20170814203235.GA4293@tor.lan>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ddcd8831-e520-39eb-7826-de3285d2b991@ramsayjones.plus.com>
Date:   Tue, 15 Aug 2017 01:30:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170814203235.GA4293@tor.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/08/17 21:32, Torsten Bögershausen wrote:
> In general, yes.
> I had a patch that allowed a 32 bit linux to commit a file >4GB.
> There is however a restriction: The file must not yet be known to the
> index. Otherwise the "diff" machinery kicks in, and tries to
> compare the "old" and the "new" versions, which means that -both-
> must fit into "memory" at the same time. Memory means here the available
> address space rather then real memory.
> So there may be room for improvements for 32 bit systems, but that is another
> story, which can be developped independent of the ulong->size_t conversion.

Oh, I absolutely agree.

> Thanks to Martin for working on this.

Indeed! Thanks Martin.

ATB,
Ramsay Jones


