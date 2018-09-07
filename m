Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCAEA1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 18:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeIGXS7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 19:18:59 -0400
Received: from siwi.pair.com ([209.68.5.199]:63215 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeIGXS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 19:18:58 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2305C3F4896;
        Fri,  7 Sep 2018 14:36:46 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DBC5B3F4815;
        Fri,  7 Sep 2018 14:36:45 -0400 (EDT)
Subject: Re: [PATCH 0/2] Fixup for js/mingw-o-append
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gm>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
References: <pull.35.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5103f96f-109a-f070-94a4-82e199f222e3@jeffhostetler.com>
Date:   Fri, 7 Sep 2018 14:36:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <pull.35.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GitGitGadget botched the CCs when I submitted this.
Replying here to add them.

Sorry,
Jeff

https://github.com/gitgitgadget/gitgitgadget/issues/35


On 9/7/2018 2:19 PM, Jeff Hostetler via GitGitGadget wrote:
> The recent change mingw O_APPEND change breaks writing to named pipes on
> Windows. The first commit adds a new test to confirm the breakage and the
> second commit fixes the problem. These could be squashed together or we can
> just keep the fix and omit the test if that would be better.
> 
> d641097589 (js/mingw-o-append) mingw: enable atomic O_APPEND
> 
> The new mingw_open_append() routine successfully opens the client side of
> the named pipe, but the first write() to it fails with EBADF. Adding the
> FILE_WRITE_DATA corrects the problem.
> 
>   Signed-off-by: Jeff Hostetler jeffhost@microsoft.com
> [jeffhost@microsoft.com]
> 
> Cc: j6t@kdbg.orgCc: johannes.schindelin@gmx.deCc: gitster@pobox.comCc:
> peff@peff.net
> 
> Jeff Hostetler (2):
>    t0051: test GIT_TRACE to a windows named pipe
>    mingw: fix mingw_open_append to work with named pipes
> 
>   Makefile                           |  1 +
>   compat/mingw.c                     |  2 +-
>   t/helper/test-tool.c               |  3 ++
>   t/helper/test-tool.h               |  3 ++
>   t/helper/test-windows-named-pipe.c | 72 ++++++++++++++++++++++++++++++
>   t/t0051-windows-named-pipe.sh      | 17 +++++++
>   6 files changed, 97 insertions(+), 1 deletion(-)
>   create mode 100644 t/helper/test-windows-named-pipe.c
>   create mode 100755 t/t0051-windows-named-pipe.sh
> 
> 
> base-commit: d641097589160eb795127d8dbcb14c877c217b60
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-35%2Fjeffhostetler%2Ffixup-mingw-o-append-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-35/jeffhostetler/fixup-mingw-o-append-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/35
> 
