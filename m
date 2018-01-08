Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953E71FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 18:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756020AbeAHSvH (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 13:51:07 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:43898 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755985AbeAHSvG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 13:51:06 -0500
Received: by mail-pg0-f48.google.com with SMTP id f14so3556620pga.10
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 10:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L1rq2SxaUkTlWWNRA8HU1Im2sbR2YS7SwHGjhxdprHI=;
        b=bQ+rWrI/3C8Bgm5Ib1oKV3kTtMiE8/R35s1eed4yy28ptO8tyJohgyS0ZNK80+xh/a
         w1PCl2eeLWPUdFWUz/+lx6ANno9GCQ3fF401OFIY4J5+dQiA3lZXeU17xN5v/VvVMgQB
         J5ypGv6XG3tdHGjsnmfdB0sIfvKTHTALXm1UpEqf58Gwmo1UG4QlKicOdzMiP3dBq0q0
         TbiFNAyvRttYlVZ9HN6feRAiYjIoGow+MLCBIqIp6gH13KO/pS8Fi3DgYa2e9d/H/pNH
         06fvYBg/f2MK6RN2zgjAzv4iy5uvO4jxjgvsWNEKuGZDl66vMdyh4/y+Fp5ti8mVozfG
         XZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L1rq2SxaUkTlWWNRA8HU1Im2sbR2YS7SwHGjhxdprHI=;
        b=BUAekSmPeBaP8ov53cOo9f5+aLcjSkAqDT0TYTq1ZLo3Mi87OG0jyvv1xaLSjFd868
         9x6R5ghXIo/CglSPKvWs+4aRXV1bapnQjjSv3diognKwgTP9ZtPJHNaCZprHrXSBmRu6
         5p+rOcLy3/FulouarKp8D2XikPkJxLrNeq+XmxS7KcSwNn9DwTfaJfr2EjRwsBl4OFYx
         Bny2tgwwoY7+nc7uoU2Lw9nYex96IZQAQTBf+FC6M8qMsRss0R/4eZLzv7QTCSPRbAE0
         gTh+LnlBuUFL2h2TR8HwXI3egka4SWIYFlK0zbCdGdNwrxXb+H1YT2xl7sEsNk1xHwJ5
         xhnw==
X-Gm-Message-State: AKGB3mKCpUNdElYeX8k2JXAyN3WzTVrNhk7uaCXFuqaCnadUgrFfmBH4
        Xyjdw9I2kuMYHf8FZ62KjGSsm1cuHkY=
X-Google-Smtp-Source: ACJfBosN4/HG7XY27W+WZO/+D68vTd4nHWL0fwYaY/VJpaYvbjvdNLtWoEAeq7k9hnC9jWrzUlebuQ==
X-Received: by 10.101.98.207 with SMTP id m15mr10009472pgv.67.1515437465735;
        Mon, 08 Jan 2018 10:51:05 -0800 (PST)
Received: from google.com ([2620:0:100e:422:2054:b9e9:e494:59bb])
        by smtp.gmail.com with ESMTPSA id g2sm27573129pfc.130.2018.01.08.10.51.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jan 2018 10:51:04 -0800 (PST)
Date:   Mon, 8 Jan 2018 10:51:03 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] upload-pack: fix some sparse warnings
Message-ID: <20180108185103.GA156560@google.com>
References: <720013d4-a493-e0b6-7a38-9ebbbaa198ce@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <720013d4-a493-e0b6-7a38-9ebbbaa198ce@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/05, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Brandon,
> 
> If you need to re-roll your 'bw/protocol-v2' branch, could you please
> squash this (or something like it) into the relevant patches. The first
> hunk would go in commit 6ec1105192, "upload-pack: convert to a builtin",
> 2018-01-02), whereas the second hunk would go to commit b3f3749a24,
> "upload-pack: factor out processing lines", 2018-01-02).

Thanks for finding these, I'll make sure I include them in the relevant
commits.

> 
> The sparse warnings were:
> 
>        SP upload-pack.c
>    upload-pack.c:783:43: error: incompatible types for operation (<=)
>    upload-pack.c:783:43:    left side has type int *depth
>    upload-pack.c:783:43:    right side has type int
>    upload-pack.c:783:43: error: incorrect type in conditional
>    upload-pack.c:783:43:    got bad type
>    upload-pack.c:1389:5: warning: symbol 'cmd_upload_pack' was not declared. Should it be static?
> 
> [Note that the line numbers are off-by-one.]
> 
> I note, in passing, that strtol() returns a 'long int' but *depth is
> an 'int' (yes, the original code was like that too ;-) ).
> 
> Should cmd_upload_pack(), along with the #include "builtin.h", be moved
> to builtin/upload-pack.c?

Junio mentioned something similar when I sent out the WIP series, I must
have forgotten to do that before sending this out.  I'll make that
change :)

> 
> Also, I note that packet_read_with_status(), introduced in commit 4570421c3,
> is not called outside of pkt-line.c; does this symbol need to be extern?

I thought it might, but you're right it doesn't look like it needs to.
I'll change that so its not exported.

> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
> 
>  upload-pack.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/upload-pack.c b/upload-pack.c
> index 8002f1f20..6271245e2 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "builtin.h"
>  #include "config.h"
>  #include "refs.h"
>  #include "pkt-line.h"
> @@ -780,7 +781,7 @@ static int process_deepen(const char *line, int *depth)
>  	if (skip_prefix(line, "deepen ", &arg)) {
>  		char *end = NULL;
>  		*depth = strtol(arg, &end, 0);
> -		if (!end || *end || depth <= 0)
> +		if (!end || *end || *depth <= 0)
>  			die("Invalid deepen: %s", line);
>  		return 1;
>  	}
> -- 
> 2.15.0

-- 
Brandon Williams
