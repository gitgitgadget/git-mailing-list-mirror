Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CB7C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD3E20644
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="QAylDdMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgD0Ql5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:41:57 -0400
Received: from avasout07.plus.net ([84.93.230.235]:38841 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgD0Ql5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 12:41:57 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id T6pOjVyU8sCJiT6pPjylAP; Mon, 27 Apr 2020 17:41:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1588005715; bh=2MilnfaD4eYNkcNQqDktDpI0w5mgRtHBPWxzd4BuPQA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QAylDdMCtS/JWfDeKIVNeUtbGVSWY3LI3YPFIvaSI/FlrOfAIXii2FsS6jd/lAMvx
         7fcUrv3xG8MR5jfVGHLyeu/+t6NzBIfrrlkNdPyuPLaEO2BK4Lx48WYjWF1fVBQUkX
         uLLqHd4pXtmI/OBO3OIEnXGrAeoe/9sq/iY8W6/n4p98Up3/jz+QQ3hg5yJrtmiHsD
         j6ThgJ31YsxixM72navAQP2pBMrcgtPBVPewUMrNLaJplEp/DK2LI/Yo7vCOArRy93
         QZ9d3tkqiQCHRk3KYIishSIBUlHU5n19baCTMY5d2dfpLGeJXOsm2RcMcKKA10oxQt
         8d+zkZlq8/rfg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=BPIoUGYG c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=pGLkceISAAAA:8 a=CrWWM_9JVBLIylfyc4AA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 2/4] compat/regex: move stdlib.h up in inclusion chain
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <cover.1587996765.git.congdanhqx@gmail.com>
 <8d18c53bc813865a652be148afd2292d75e1b635.1587996766.git.congdanhqx@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <1d0fb62f-95e0-3c17-ee27-2a5460590947@ramsayjones.plus.com>
Date:   Mon, 27 Apr 2020 17:41:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8d18c53bc813865a652be148afd2292d75e1b635.1587996766.git.congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOb9R8Wd3r+4SH91Z0MUbBNhc+7uK2emhHIjcmO5AZylndKgPqjcMFT3ck866Ar7V+8H01+hyQxrNiGMdjsJrfQPNpbGjKFyoX1x6mWoksAfRZgyBJMX
 ZC6GQWDlX83/T5A78w46iCbc9p0rM05rTtwCqYSpeIS+UxmBkZaDwASU0WIi/L2lwhI3aNvxnxng/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/04/2020 15:22, Đoàn Trần Công Danh wrote:
> In Linux with musl libc, we have this inclusion chain:
> 
> compat/regex/regex.c:69
> `-> compat/regex/regex_internal.h
>    `-> /usr/include/stdlib.h
>       `-> /usr/include/features.h
>       `-> /usr/include/alloca.h
> 
> In that inclusion chain, `<features.h>` claims it's _BSD_SOURCE
> compatible when it's NOT asked to be either
> {_POSIX,_GNU,_XOPEN,_BSD}_SOURCE, or __STRICT_ANSI__.
> And, `<stdlib.h>` will include `<alloca.h>` to be compatible with
> software written for GNU and BSD. Thus, redefine `alloca` macro,
> which was defined before at compat/regex/regex.c:66.
> 
> Considering this is only compat code, we've taken from other project,
> it's not our business to decide which source should we adhere to.
> 
> Include `<stdlib.h>` early to prevent the redefinition of alloca.
> This also remove a potential warning about alloca not defined on:
> 	#undef alloca
> 
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
> 
> Notes:
>     There is another warning about un-match declaration and definition of
>     re_string_context_at.
>     
>     It's arguably, a bug in sparse itself.
>     Consider that there's a fix for it in their development version already,
>     and, we expect they'll fix the zero-ing pattern in 1/? before enable it again.

Ahem, yes I still haven't found time to find that patch yet.
Sorry about that. :(

>     There're no point to change that pair of declaration/definition.
> 
>     This patch is technically Ramsay's work.
>     Since <alloca.h> is likely unportable, my patch will be likely unusable.
>     I took Ramsay's work and write the commit message instead.
> 
>     I would love to see Ramsay's SoB on reply to this patch.

I think 'Helped-by:' is all that is necessary (you did the hard work,
including testing on musl-libc), but if you prefer:

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

ATB,
Ramsay Jones

> 
>  compat/regex/regex.c          | 1 +
>  compat/regex/regex_internal.h | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/compat/regex/regex.c b/compat/regex/regex.c
> index f3e03a9eab..e6f4a5d177 100644
> --- a/compat/regex/regex.c
> +++ b/compat/regex/regex.c
> @@ -60,6 +60,7 @@
>     #undefs RE_DUP_MAX and sets it to the right value.  */
>  #include <limits.h>
>  #include <stdint.h>
> +#include <stdlib.h>
>  
>  #ifdef GAWK
>  #undef alloca
> diff --git a/compat/regex/regex_internal.h b/compat/regex/regex_internal.h
> index 3ee8aae59d..0bad8b841e 100644
> --- a/compat/regex/regex_internal.h
> +++ b/compat/regex/regex_internal.h
> @@ -23,7 +23,6 @@
>  #include <assert.h>
>  #include <ctype.h>
>  #include <stdio.h>
> -#include <stdlib.h>
>  #include <string.h>
>  
>  #if defined HAVE_LANGINFO_H || defined HAVE_LANGINFO_CODESET || defined _LIBC
> 
