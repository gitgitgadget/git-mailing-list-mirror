Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2E911F954
	for <e@80x24.org>; Tue, 21 Aug 2018 04:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeHUII1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 04:08:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45005 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeHUII1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 04:08:27 -0400
Received: by mail-pl0-f68.google.com with SMTP id ba4-v6so8175600plb.11
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 21:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=taKWoE85GEc4ljmDaYdbInNWiDRP8m5PKoWOXKWT1cg=;
        b=V7TuzbNlrAD+Yy3RdZfouz7v7jxxXXuF3idZ6ePdzcppi17zvx+PFLS0Bt4xu+a+Uf
         ElAvLHWLZFGArBKUNdqFOmhdYUeMSv2L2Cke9xOTCHXkCmVAjxdZBhzaV1KxZZk0lal3
         Axh+FeyiNACQCl7tm/LMWBcEHR5uWX0aKVLEe1bpsiJ5q+j6IVUhOAGEcWzRhHUOH7+9
         GSbswD7QbCqeJPVmZE+HcrqS1Kqc1ZWz4P1oiw8TjnmLtx8aVrbvA0OHHySatrykGk5+
         75DU+5gpaHJxTR8tUYVzsmnYu843sZlhBmkjeJP1T0ybI/YR2t4wfL1Php6Ir3LuptIP
         hBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=taKWoE85GEc4ljmDaYdbInNWiDRP8m5PKoWOXKWT1cg=;
        b=aCpEm755NUbXhdZ+lzQiWtA7sU6ZFCeq/J+w6SAeeQyFS0Mm3kS28qvc44NwcYOyJU
         GEqCHZoa/W6i0OCWvDkOvxB5mzq+F0SrED0HcxF3PMhFkh/aZNKgluFvjc+Gama45LjZ
         1kAeeY5GGebcgR00qzU/tBnjAGQiu+sd1ntCwBvf4fiJtodjPSDfs8EPrJbYoY7/zacl
         w3nxPlU/MhPs9AhWUjGDP3bR41/ytWJgvwtHhLmxaFsvmAfpiN8W7XjGhnrgG9o5Ujjp
         KVOXaQ/DeWzeTyoPzL3ijEVUrglzfqABr/mvih5BgzBMlGM/kjPCeifh0xgNk1qLhW7C
         +KRg==
X-Gm-Message-State: AOUpUlE501ImunCj56cmSQ6pDKAe2z60eXn6fHYmAn+hWmjKheUqUlkn
        FBmfql2eljFQByP8GAT8KYyjM2I9
X-Google-Smtp-Source: AA+uWPyyKYAiAxTCygomZY3LxIxVKNKQgSDl3sydxyPuBYtg9+2TJ+dJDcMx3er3c5C9BQQMNybr+A==
X-Received: by 2002:a17:902:bb98:: with SMTP id m24-v6mr8135576pls.170.1534826996462;
        Mon, 20 Aug 2018 21:49:56 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r22-v6sm17910600pfl.112.2018.08.20.21.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 21:49:55 -0700 (PDT)
Date:   Mon, 20 Aug 2018 21:49:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 02/25] structured-logging: add STRUCTURED_LOGGING=1 to
 Makefile
Message-ID: <20180821044954.GB219616@aiede.svl.corp.google.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
 <20180713165621.52017-3-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713165621.52017-3-git@jeffhostetler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach the Makefile to take STRUCTURED_LOGGING=1 variable to
> compile in/out structured logging feature.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Makefile             |  8 ++++++++
>  structured-logging.c |  9 +++++++++
>  structured-logging.h | 13 +++++++++++++
>  3 files changed, 30 insertions(+)
>  create mode 100644 structured-logging.c
>  create mode 100644 structured-logging.h

This should probably be squashed with a later patch (e.g., patch 3).
When taken alone, it produces

[...]
> --- /dev/null
> +++ b/structured-logging.c
> @@ -0,0 +1,9 @@
> +#if !defined(STRUCTURED_LOGGING)
> +/*
> + * Structured logging is not available.
> + * Stub out all API routines.
> + */
> +
> +#else
> +
> +#endif

which is not idiomatic (for example, it's missing a #include of
git-compat-util.h, etc).

Thanks,
Jonathan
