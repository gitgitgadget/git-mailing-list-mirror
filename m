Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87CE820357
	for <e@80x24.org>; Sun, 16 Jul 2017 08:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbdGPIIB (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 04:08:01 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:32172 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbdGPIIA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 04:08:00 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3x9JvL5rglz5tlC;
        Sun, 16 Jul 2017 10:07:58 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E73CB253;
        Sun, 16 Jul 2017 10:07:57 +0200 (CEST)
Subject: Re: reftable: new ref storage format
To:     Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net>
 <CAJo=hJts=wY4vBaLsOtoH8+LBFK_drBhHMxPvKoQcqtpOfJOog@mail.gmail.com>
 <20170714200830.iks5drqu72cypkny@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4dbe06d0-9a65-7bf5-eb82-6371d9ad7e9b@kdbg.org>
Date:   Sun, 16 Jul 2017 10:07:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170714200830.iks5drqu72cypkny@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.07.2017 um 22:08 schrieb Jeff King:
> The implementation on this doesn't seem overly complex. My main concerns
> are what we're asking from the filesystem in terms of atomicity, and
> what possible races there are.

One of the failure modes is that on Windows a file cannot be deleted 
while it is open in any process. It can happen that a compacting updater 
wants to remove a reftable file that is still open in a reader.

-- Hannes
