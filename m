Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A93203F2
	for <e@80x24.org>; Tue, 24 Oct 2017 23:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbdJXXEa (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 19:04:30 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:52999 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdJXXE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 19:04:29 -0400
Received: by mail-it0-f51.google.com with SMTP id j140so12020243itj.1
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PLBymXbv2hfMWYHkq6qJQtlFUjyWBiyHOdtSWRkpY5A=;
        b=ikCdotCyVITI47KoWk2Iu2PZ85KL3y215jMcO2dvA6tMCQE6EIPlz/klpLciKCwBII
         146uDeV7anjsZEUJaUr5fPSCV7ZjRapdO0jUaVKMsPaUNF8ESLx8ddjKuUJt/s8ITimR
         r42fWRyW6zH6QCh618/Flt+7p2sieklziwEaXO6yPQdDnjpcsrSLSlc6hgpHNOP1DzAR
         3e2pI0XpTcKsU97CFC1YQCjIdSgfKv/t7xtJ9gbY81zOlnByiCzIa7JrGVWXHuFPlhy2
         XpqvmXyZ+dwwU9sPKTT6j5ca5yKvCLHsaz3N2UKFw3StCtef8aWKyF4+j+JFf2y/IUhc
         W1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PLBymXbv2hfMWYHkq6qJQtlFUjyWBiyHOdtSWRkpY5A=;
        b=AJcXWaSIr3UyJDGIMgeJvPG0S5OnA6HqiroJ1RsfCXvblWw8aHxQfONI9zt/dHTJKK
         bdgPRcXCbjnHV5ZYVEzuHFrVOe52xwe8V4BSIdm8H/bypVb1Q/8iTwAhv4aSCldxQjHM
         fxg7jxRaY3+sEFUVFIgpGGrwqHtRAlrYf/w2SoQgVsgl0NdKhLJTGrD6fshqktTkqDfd
         qvWLVIqH66EM2BOKvtpffbqv6BueHvv9KZyXo4r/rQu2W1/NX3Up0yDZCBW4JO/ijj6y
         ftK7EBbIDvPX5STN/orpgOBnJMfgE7WMwJLnTF/rQxmh2Uo5SYVPUD6Pphy8soxYPacY
         Wkuw==
X-Gm-Message-State: AMCzsaUlAlLmCXfklpEFR79OuHdkVOjY3lqmHoHM6enJRiXUr8p3zyIE
        hhaayUCoItfI9HxrPF5JiSs=
X-Google-Smtp-Source: ABhQp+Se0WqissZzxaHyHxOWLZpuo5ysIMp3nwPG35XRgvOF+WQcpoOKU2OuQ154f3fHYNfAoS9LnA==
X-Received: by 10.36.197.130 with SMTP id f124mr204567itg.99.1508886269004;
        Tue, 24 Oct 2017 16:04:29 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l5sm619123ioe.13.2017.10.24.16.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Oct 2017 16:04:28 -0700 (PDT)
Date:   Tue, 24 Oct 2017 16:04:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] xdiff: use stronger hash function internally
Message-ID: <20171024230413.sm2pzlf4qhd2rirk@aiede.mtv.corp.google.com>
References: <20171024185917.20515-1-sbeller@google.com>
 <20171024185917.20515-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171024185917.20515-4-sbeller@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -24,7 +24,8 @@
>  #include <assert.h>
>  #include "xinclude.h"
>  
> -
> +#include "cache.h"
> +#include "hashmap.h"

#includes like "git-compat-util.h" and "cache.h" can only be used as
the *first* #include.

Otherwise the feature test macros they set do not take effect, causing
lots of unpleasant platform-specific breakage.

Thanks,
Jonathan
