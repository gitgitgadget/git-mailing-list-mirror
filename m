Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6238320248
	for <e@80x24.org>; Fri, 15 Mar 2019 19:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCOTSN (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 15:18:13 -0400
Received: from siwi.pair.com ([209.68.5.199]:59655 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfCOTSM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 15:18:12 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0A9CD3F4010;
        Fri, 15 Mar 2019 15:18:12 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:d487:82da:e467:b584] (unknown [IPv6:2001:4898:8010:2:bdbb:82da:e467:b584])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C17D23F4022;
        Fri, 15 Mar 2019 15:18:11 -0400 (EDT)
Subject: Re: [PATCH 0/2] Randomize / timestamp trace2 targets
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <cover.1552519463.git.steadmon@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <366839dd-7470-bda0-d84e-4169842c7852@jeffhostetler.com>
Date:   Fri, 15 Mar 2019 15:18:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <cover.1552519463.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/13/2019 7:33 PM, Josh Steadmon wrote:
> Persistently enabling trace2 output is difficult because it requires
> specifying a full filename. This series teaches tr2_dst_get_trace_fd()
> to randomize filenames when a directory or filename prefix are given as
> targets in the GIT_TR2_* envvars. It also allows expansion of a
> timestamp template string into the current UTC timestamp.


Does the use of envvar cause issues?  Or is it just the fixed absolute
pathname?  When I started this, I was trying to keep the GIT_TRACE
model.

As was briefly discussed in [1] I was thinking of adding a way to
have a personal and/or system setting, but not a git config variable,
that would let you setup tracing without relying on environment
variables.

It's something that I've been wanting to do, it just got buried by
$DAYJOB stuff.  I can try to bump it up if there's interest.

Thanks
Jeff

[1] 
https://public-inbox.org/git/pull.108.v4.git.gitgitgadget@gmail.com/T/#mcce3b088aabc42e9867f8a9e09dd7dea5f9a773a
