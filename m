Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F1520248
	for <e@80x24.org>; Sat, 23 Feb 2019 21:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfBWV7K (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 16:59:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41045 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBWV7J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 16:59:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id n2so5957671wrw.8
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 13:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cJN+ZFO7IrwhGCg6uA4S6P62zqpyghndraVBEPGoAZE=;
        b=Yknhee3OZkg3046tOr38lF7SiGbAZxKk9g+LHNhFLCSiVgsQFclu5mxlJY6XAjYPw1
         5Zmi56rG8IuU+LCXMlczPYZp0UHTrLS7tJlRGtopE5BZfte4cdpN75LwpSLaCfcsgIzC
         kCtLICjmrWZAXUJ5Zcv4CswIsExIxcYnMJDw7UBGFdmLwpPzSCwJ3cqpDRci/keYyqxy
         T/P/e0tFvxpd2eB6xJykkbAAtkBLh8vANXLhenmH/tLA2bpuF2kz4YR9/Q0uJMAVQCyY
         Qi2j0KPtp2scw7fI8ijPrUZvj8oERT/2ViDYUpeFC5bHJYBNpboXLFmAvudmVHksrfYD
         FX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJN+ZFO7IrwhGCg6uA4S6P62zqpyghndraVBEPGoAZE=;
        b=r6ZPZvhNXCQnf8VC1MnCPzNkyh7VaJaZmi4RzVuVfnyO1i/cajUp0Us59DkOkH27eR
         Gj6+aqVevAAJgwSuZR4Sz+aZLAoE0zzJI3iupunOsUd7+i3VWSzzYH59HNsJVstZ6fn8
         06dC3WUVzeAFMVBmEiti+G47/9P5e3ietiu998P9MJDhaeTitd/ZqDcalI9SuF97nSM1
         dqWJp6w1IFsFZ0VVgccOK4FqADjbrG1mtNBpKAfoagSkEGYt0N86gG8FD9RhWaYYE9BA
         iaJtnHr9vhuUDBL7lQoxLzUhud9csfB5KDy1hAWobwDDT84MPG50k0KZ3quO6tvUyjYQ
         ipjg==
X-Gm-Message-State: AHQUAuYjfdTQA5Cmdh3jBcf7ahces6TU3DlcDdLP2sQL9PYUjgXuNL1b
        HFUeN3bDfCREt7n5MHiGi+E=
X-Google-Smtp-Source: AHgI3IYD36JMRRqmnGKVAiT2J5go1PiiNzhFHLzwpaEOopi0z3n5MAas+WcW1jNH/umnBryObQzgew==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr7860216wrl.117.1550959148129;
        Sat, 23 Feb 2019 13:59:08 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id m16sm3790136wro.78.2019.02.23.13.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 13:59:07 -0800 (PST)
Date:   Sat, 23 Feb 2019 21:59:06 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSoC][PATCH 0/3] clone: convert explicit dir traversal to
 dir-iterator
Message-ID: <20190223215906.GR6085@hank.intra.tgummerer.com>
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223190309.6728-1-matheus.bernardino@usp.br>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/23, Matheus Tavares wrote:
> Add pedantic option to dir_iterator_begin at dir-iterator.c and convert
> explicit recursive directory traversal at copy_or_link_directory
> (builtin/clone.c) to the dir-iterator API.

Thanks for another iteration of this.

To make life easier for reviewers, please include a link (or the
message-ID) to all previous iteration of the series.  We often use
links to the public-inbox mirror for this,
e.g. https://public-inbox.org/git/20190215154913.18800-1-matheus.bernardino@usp.br/.

This helps reviewers go back quickly to previous iterations of the
series, and refresh their memory on the comments that were left
there.

You can also use the --in-reply-to option in 'git send-email' to chain
the threads, which also makes life easier for reviewers.

An additional way to help reviewers is to include a 'range-diff'
between the previous iteration of the series, and the current
iteration.  See the 'git range-diff' command or the '--range-diff'
option to 'git format-patch' for that.  That helps reviewers to
quickly see what changed between iterations, so that they don't have
to re-review everything, if they can still remember the last round
well enough.

I also added Christian Couder back to the Cc list, as he commented on
the RFC.  It's good to keep people that commented on the series in Cc,
as they have shown some interest in the series, so keeping them in the
Cc list helps highlight those emails for them, and makes it more
likely that the patches get reviewed quickly.

> This is my microproject for GSoC 2019. Idea taken from
> https://git.github.io/SoC-2019-Microprojects/#use-dir-iterator-to-avoid-explicit-recursive-directory-traversal
> 
> Build: https://travis-ci.org/MatheusBernardino/git/builds/497512561
> 
> Matheus Tavares (3):
>   dir-iterator: add pedantic option to dir_iterator_begin
>   clone: extract function from copy_or_link_directory
>   clone: use dir-iterator to avoid explicit dir traversal
> 
>  builtin/clone.c      | 72 ++++++++++++++++++++++++++++----------------
>  dir-iterator.c       | 23 ++++++++++++--
>  dir-iterator.h       | 16 ++++++++--
>  refs/files-backend.c |  2 +-
>  4 files changed, 81 insertions(+), 32 deletions(-)
> 
> -- 
> 2.20.1
> 
