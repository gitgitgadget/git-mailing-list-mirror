Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FF6C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 15:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF46611CA
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 15:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhFVPr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 11:47:56 -0400
Received: from siwi.pair.com ([209.68.5.199]:51470 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231876AbhFVPrx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 11:47:53 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 90B713F40E6;
        Tue, 22 Jun 2021 11:45:32 -0400 (EDT)
Received: from msranlcmt20.fareast.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5B4423F40D9;
        Tue, 22 Jun 2021 11:45:32 -0400 (EDT)
Subject: Re: [PATCH v2 00/28] Builtin FSMonitor Feature
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <xmqqmtsh9bhl.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6d302977-5360-b257-c9c0-9744311c6fae@jeffhostetler.com>
Date:   Tue, 22 Jun 2021 11:45:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqmtsh9bhl.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/26/21 10:06 PM, Junio C Hamano wrote:
> These new global symbols are introduced by the series, but never
> used outside the file they are added to:
> 
> fsmonitor-ipc.o        - fsmonitor_ipc__get_path
> fsmonitor-ipc.o        - fsmonitor_ipc__get_state
> fsmonitor-ipc.o        - fsmonitor_ipc__send_command
> 
> Perhaps make them file-scope static?

I intended these to be part of the API for talking to a builtin
FSMonitor.  They are called from builtin/fsmonitor--daemon.c
and t/helper/test-fsmonitor-client.c

Jeff
