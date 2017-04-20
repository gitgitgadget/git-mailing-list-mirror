Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61E1A1FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 16:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033294AbdDTQbT (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 12:31:19 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:20087 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033287AbdDTQbS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 12:31:18 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3w849w3C8Kz5tl9;
        Thu, 20 Apr 2017 18:31:00 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3575C42C6;
        Thu, 20 Apr 2017 18:30:28 +0200 (CEST)
Subject: Re: [PATCH v3 05/12] refs: move submodule slash stripping code to
 get_submodule_ref_store
To:     Duy Nguyen <pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
 <20170419110145.5086-6-pclouds@gmail.com>
 <a74cf309-fb16-2f45-8189-d1d0c655dea4@kdbg.org>
 <CACsJy8A1aR-=QqqZdw+i5Hv2kXptTzYcn5tFsMBDYk6vBwUwZg@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fa37a980-d984-1834-6d2e-cce60486ec33@kdbg.org>
Date:   Thu, 20 Apr 2017 18:30:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8A1aR-=QqqZdw+i5Hv2kXptTzYcn5tFsMBDYk6vBwUwZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.04.2017 um 13:56 schrieb Duy Nguyen:
> On Thu, Apr 20, 2017 at 5:02 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> What is the source of the value of 'submodule'? Is it an index entry? Or did
>> it pass through parse_pathspec? In these cases it is correct to compare
>> against literal '/'. Otherwise, is_dir_sep() is preferred.
>
> I've looked at the callers. Yes it is a path and is_dir_sep() should
> be used. Since this has been like this in the current code, unless
> there's some more changes in this series or you insist, I would hold
> this change back,

I won't insist because we have it the old way since a decade without 
issue reports.

-- Hannes

