Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402591F453
	for <e@80x24.org>; Thu, 31 Jan 2019 23:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfAaXPe (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 18:15:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40802 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfAaXPd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 18:15:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so4283661wmf.5
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 15:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9R+OXmRUL5fKeJA9DsNB/eKnFLrQrLoTDu+ehSZEmd0=;
        b=WKDHxX8+T7PvCKfJi7dd1af+7C5vA5EgchA/0FuNhRoftp7lRcVShqb+Apb0Jw2Y8L
         uwYblxC2VfQmVRHiOZZmgTmTBQ/8GCom2hfzaK7FnRJ7lLnZdqwQiOf4xLSmEtQE/NGM
         kVFeJWx3LVzC5DH9G63nXu41bt4C/97ACVUCbISbCOUntnpHDRDJbmrI4na71lha8iQ8
         1zuD3xZIBzGK7V4POmJ9f13ecvh8C2UJNhC31cv6RqIW0Mnx4ZYJPscHM38DrzSK3RdH
         xKsojiWaEssj8AJpUX380/EkvN7Zyi+QTEyyOOzDdkE8FMJh0dKC+wWjQQ+gMIpc7cEa
         ORdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9R+OXmRUL5fKeJA9DsNB/eKnFLrQrLoTDu+ehSZEmd0=;
        b=FCfOiFcrhiMxSs3WpyiBC4BSFMxJGNQZeY+T9iZp2DogIMhWvoupgMBgtX/3VuzJ3B
         OP5Hj8zJOYBaiMTT6mVlBPFq70/0+s02uF230eIt4yBhxw3kWwKhWut4XDKsdkxyLmLN
         2K4y5DQMk0l42Kb5AJnJohGR5+y0l4LQ6AId7lUzdrjgJzU0U7u7Sxiz+FfqldwD/rW1
         EOUlX7tOaiQbimCeTZVbC3kQ64HbnRTsze3h1UmFLF6UCsHXjVoJIURTVB0Ys3ks3piO
         QQC8duuXEQ9xwfUVU+0iq1o2WqAZC4tiI+yJxjLPseSPdCIbUlilf2tXNaItLp/cmLmG
         CGXQ==
X-Gm-Message-State: AJcUuke+kg31G3lTu1gOox2qejZyqSxmPeSvksCG3mUwX/VJ8RRsVOWJ
        bqKRxWnMNCUMtXQnpsKvMG8=
X-Google-Smtp-Source: ALg8bN6tENKuTSh2YB6J4yYeCnLtDa6tzMbqz+Z4jcS89Y3xHlq693dV6cxiBXaUyXUR45sNvy7MOQ==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr30622656wmf.111.1548976531963;
        Thu, 31 Jan 2019 15:15:31 -0800 (PST)
Received: from szeder.dev (x4db675b2.dyn.telefonica.de. [77.182.117.178])
        by smtp.gmail.com with ESMTPSA id l19sm437077wme.21.2019.01.31.15.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 15:15:31 -0800 (PST)
Date:   Fri, 1 Feb 2019 00:15:28 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/14] trace2: collect platform-specific process
 information
Message-ID: <20190131231528.GC10587@szeder.dev>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
 <pull.108.v4.git.gitgitgadget@gmail.com>
 <6167aba76ca43707bbba6de9f7c41a9fcb16063c.1548881779.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6167aba76ca43707bbba6de9f7c41a9fcb16063c.1548881779.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 12:56:24PM -0800, Jeff Hostetler via GitGitGadget wrote:
> Add optional platform-specific code to log information about
> the current process.
> 
> On Windows, this includes whether git.exe is running under a
> debugger and information about the ancestors of the process.
> 
> The purpose of this information is to help indicate if the
> process was launched interactively or in the background by
> an IDE, for example.

> diff --git a/trace2.h b/trace2.h
> index a0e99d9c26..cb11a46366 100644
> --- a/trace2.h
> +++ b/trace2.h
> @@ -363,4 +363,18 @@ __attribute__((format (printf, 1, 2)))
>  void trace2_printf(const char *fmt, ...);
>  #endif
>  
> +/*
> + * Optional platform-specific code to dump information about the
> + * current and any parent process(es).  This is intended to allow
> + * post-processors to know who spawned this git instance and anything
> + * else the platform may be able to tell us about the current process.
> + */
> +#if defined(GIT_WINDOWS_NATIVE)
> +void trace2_collect_process_info(void);
> +#else
> +#define trace2_collect_process_info() \
> +	do {                          \
> +	} while (0)
> +#endif

Please consider mentioning in the commit message that on other
platforms this is a noop.  I was scrolling through the whole patch,
skipping over the Windows-specific parts, to see how you did it on
Linux, only to find the above do-nothing loop.  It was anticlimactic :)

Why is it a noop on other platforms?  I suspect that (since your main
focus is supporting Windows devs using Git on Windows) it's along the
lines of "I just didn't want to bother, and left it as future work for
anyone interested", which a perfectly valid reason in my book.
However, if you did look into it, and found some major difficulties or
downright showstoppers, then that might be worth mentioning.
(Portability?  I would expect that it would need a bunch of '#elif
defined(...)')

