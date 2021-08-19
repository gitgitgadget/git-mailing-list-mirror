Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB487C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3CBA610A1
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhHSUtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:49:41 -0400
Received: from siwi.pair.com ([209.68.5.199]:62470 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235439AbhHSUtk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:49:40 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D9BA53F4813;
        Thu, 19 Aug 2021 16:49:03 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1004:b0e7:ffbb:8db9:e870:8eb1:87c7])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 959A63F4808;
        Thu, 19 Aug 2021 16:49:03 -0400 (EDT)
Subject: Re: [PATCH] fixup! fsmonitor-fs-listen-macos: implement FSEvent
 listener on MacOS
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     jeffhost@microsoft.com
References: <20210819183652.7750-1-carenas@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d2a962d3-f874-87e2-33dc-e0625ded5549@jeffhostetler.com>
Date:   Thu, 19 Aug 2021 16:48:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210819183652.7750-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/19/21 2:36 PM, Carlo Marcelo Arenas Belón wrote:
> clang defines __GNUC__ for compatibility with gcc (indeed it misrepresents
> itself as gcc 4.2.1), so instead use the __clang__ specific macro to
> distinguish between them.
> 
> tested with Apple clang 12.0.5, clang 14 and gcc 11.2.0
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   compat/fsmonitor/fsmonitor-fs-listen-macos.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/compat/fsmonitor/fsmonitor-fs-listen-macos.c b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
> index 02f89de216..c55ec35b5d 100644
> --- a/compat/fsmonitor/fsmonitor-fs-listen-macos.c
> +++ b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
> @@ -1,4 +1,4 @@
> -#if defined(__GNUC__)
> +#ifndef __clang__
>   /*
>    * It is possible to #include CoreFoundation/CoreFoundation.h when compiling
>    * with clang, but not with GCC as of time of writing.
> 

thanks!
Jeff
