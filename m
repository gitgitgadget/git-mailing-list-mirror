Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544EB1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 13:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfAYNTf (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 08:19:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37508 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYNTe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 08:19:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so10275462wrt.4
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 05:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TGikGJEOw36MhcEJS4yip/UA7v0EX3CCKBo2BZGE52A=;
        b=c8LtHr/rysyFR+VzqTVSYvXspD2g4h8xJnKh4xM92HnzD6d0UGqVrHXl7LWOXtQFWy
         Sm/0o3Ux4jvrXsa3tdFgg/BLmEQHFqcdF6t94KQXiS7x2Jq2Lt8MC8O2/nVt5mhfHCbl
         JxABlzw6evAa5hsdLssgWlEt1S2Gq9MaZof+GGoKYH96i2HlzA5cszA9qRK7dgZPeKPc
         mIU//qztiUZW1oOI79kzPkMKI2SGkElbCIFDFpzOwmrr4OdOI4jdgznSsYYjRzCssaOD
         wdsMbMlLgItM81OTb08sCrA2d4urtl5VCoIg2+laJhe3Y/bQAjsJpHyTbPkSFvHlArlS
         xRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TGikGJEOw36MhcEJS4yip/UA7v0EX3CCKBo2BZGE52A=;
        b=AVzzWQJ0//dTf3mXGlk7CpQETEpyAkbyXMlccLV6aKNnDdSeNPc+1cHbTAdpLWlV/o
         MLmGlacGi0PIVKv7YisHT2FCFBIiew3t3DgysolMqrEuEwOvoHMXSbq7fKG0AdVc9jvx
         Bb8/ZVLn2a2qaOOCuEfCXMXlpA7+w8R98lteDv0I1CEsDsAREU1d8hgKW0iOYCDAPqSK
         LLvaQjfr1zCwBfTB4nM0xY19rTe1FEktUZpffmQFaQTn1CRw3exDqSaGw8uiXjQmRCB7
         j/C0dgkB87w5fh2m7ijn6Yf/21ZwS9MD12E2buO1D2hf/DdsFtWV1SixNK5Oc7PEWIPN
         3Dtw==
X-Gm-Message-State: AJcUukfT30yN3rOagLxgrhwRRncTZewtgKloxH4I8GXYZOYkaF0MHBtl
        2aSmC0638BxvSgAJmSmVd94=
X-Google-Smtp-Source: ALg8bN5eV1KTvqp2+vbeluxT+Bxt6rgg+LERnfDRfixteCxhaPfbRadUTObSjl/hdl6fIhDbNCsBFg==
X-Received: by 2002:adf:8001:: with SMTP id 1mr11050991wrk.23.1548422372773;
        Fri, 25 Jan 2019 05:19:32 -0800 (PST)
Received: from szeder.dev (x4db9b7c2.dyn.telefonica.de. [77.185.183.194])
        by smtp.gmail.com with ESMTPSA id q12sm95601146wrx.31.2019.01.25.05.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 05:19:31 -0800 (PST)
Date:   Fri, 25 Jan 2019 14:19:29 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] trace2: Documentation/technical/api-trace2.txt
Message-ID: <20190125131929.GC6702@szeder.dev>
References: <pull.108.git.gitgitgadget@gmail.com>
 <1a90de9dab0dd836e54fee9e08ab9e2284e1027a.1548192131.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a90de9dab0dd836e54fee9e08ab9e2284e1027a.1548192131.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 01:22:12PM -0800, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Created design document for Trace2 feature.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Documentation/technical/api-trace2.txt | 1158 ++++++++++++++++++++++++
>  1 file changed, 1158 insertions(+)
>  create mode 100644 Documentation/technical/api-trace2.txt
> 
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> new file mode 100644
> index 0000000000..501fd770f2
> --- /dev/null
> +++ b/Documentation/technical/api-trace2.txt
> @@ -0,0 +1,1158 @@
> +Trace2 API
> +==========
> +
> +The Trace2 API can be used to print debug, performance, and telemetry
> +information to stderr or a file.  The Trace2 feature is inactive unless
> +explicitly enabled by setting one or more of the `GIT_TR2`, `GIT_TR2_PERF`,
> +or `GIT_TR2_EVENT` environment variables.
> +
> +The Trace2 API is intended to replace the existing (Trace1)
> +printf-style tracing provided by the existing `GIT_TRACE` and
> +`GIT_TRACE_PERFORMANCE` facilities.  During initial implementation,
> +Trace2 and Trace1 may operate in parallel.

Speaking of replacing Trace1, I couldn't find (or managed to overlook)
the Trace2 equivalent of the good old "plain"

  trace_printf("Uh-oh!");

which is my go-to tool when chasing elusive heisenbugs and attempting
to understand racy situations and flaky tests.


> +Git Command Detail Events::
> +
> +	These are concerned with describing the specific Git command
> +	after the command line, config, and environment are inspected.
> ++
> +----------------
> +trace2_cmd_verb(...)

What is a "verb"?

If it means "command", then just call it so.  Please stick to
established Git terminology instead of introducing unnecessary new
terms.

> +trace2_cmd_subverb(...)

What is a "subverb"?

Looking at the strings passed to this function in later patches, I am
only sure in one thing: that it is not, in fact, a verb :)

I think that in general we are better off without the word "verb",
e.g.:

> +	After the basics are established, additional process
> +	information can be sent to Trace2 as it is discovered, such as
> +	the command verb, alias expansion, interesting config

The word 'verb' doesn't add any value to the sentence, but s/ verb//
does make it clearer.

> +When a git process is a (direct or indirect) child of another
> +git process, it inherits Trace2 context information.  This
> +allows the child to print a verb hierarchy.

Without s/verb/command/ this sentence doesn't make much sense to begin
with.

