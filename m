Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B84820248
	for <e@80x24.org>; Sat, 23 Feb 2019 19:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfBWTHr (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 14:07:47 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37020 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBWTHq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 14:07:46 -0500
Received: by mail-io1-f66.google.com with SMTP id v10so4495855iop.4
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 11:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fmTUgjwfMmZoYAUPqtlFEB1hx8MGpkUsuMlxhGYGq1Y=;
        b=cqjsghuWSVS+d8qAXdzYwIA9RQb9XEs1ddovU2YmCnM4qNYWJnM60KqRRtcQvcL+wf
         yCQY69uXYk+pxWO1Qj1ZAgrFQbaFRB6sIL6bDYq+7gMhOhoNC7Z6nC3KecYDPZ58kHpp
         /P5JuJWCt3/BNXos9eIe9SIWzD3br0EimuUFEnhlalH3fy2CpEAvg0PiCLObGRrrLSfz
         VxzxtONckgSaQBnOfinat2LdyebsBP5XK+wVGp4Mk88IvHUbft39dDDj+Vr6X0PClGN+
         4O/01i3qQIzktHacM7iBSlDb2D1NLwf3P6SK4FjPfLUDMMm5MLYnYXJ43SjqfpZT09v6
         a/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmTUgjwfMmZoYAUPqtlFEB1hx8MGpkUsuMlxhGYGq1Y=;
        b=mSFKrHq2kHL5ckxbD56/jKHG9hE2IIBdFJXnNyyLbDZVLtTLM7nxzHBjmT2UvKuknB
         yv0INE9ciyuxqD54LnAoWlhCEPBFlHIh3pqPoytJu7SHcMzUeBXglkB7LR8fq2PJQja9
         itHPtt8mEgZ74He5y6AKY8ghD+lSpXhI3nWJnq2VHhvmiDZsUzaaMW16A71rbLSSIbU1
         d6u8p7SueGUG3F3xnpC91CwTTU5sieq64PSKXenbQ1Sbmm9a3KNiaoa5bYeiUDGZpJSd
         S4eLgdYCz6neAhAL9rgmI7soyGZPRb4f9rWAko+8oeY83sRv3suVhSQ0scqR84me5txi
         2t9A==
X-Gm-Message-State: AHQUAuY8w67ZG7y86Iyg+2Rsnm9Gj0qP5WOD8UG/Ltc2pQaf0VTwO/rI
        CheG6VWhweJkd8WY6yKhLdlG0d/Rzx6S+4MtoEuj0uEF
X-Google-Smtp-Source: AHgI3IafjSNi1gEgL1oesI1gv9YUqQbsBdAwVqtfGUMiZHUXtniAfgyIqHTc15ow3xVhe7o9naNOsjGNd6UuedPzV3c=
X-Received: by 2002:a6b:7941:: with SMTP id j1mr5730125iop.262.1550948865568;
 Sat, 23 Feb 2019 11:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
In-Reply-To: <20190223190309.6728-1-matheus.bernardino@usp.br>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 23 Feb 2019 16:07:34 -0300
Message-ID: <CAHd-oW7iLZq+fE-q2gGmPBPHSqAyz=YyecsdHkcYAoACxGfY1A@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/3] clone: convert explicit dir traversal to dir-iterator
To:     git <git@vger.kernel.org>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 23, 2019 at 4:03 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Add pedantic option to dir_iterator_begin at dir-iterator.c and convert
> explicit recursive directory traversal at copy_or_link_directory
> (builtin/clone.c) to the dir-iterator API.
>
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

Sadly, I forgot the v2 tag, but this is a v2. Should I resent the
series with [PATCH v2 ...] or is it ok?

Matheus Tavares

> --
> 2.20.1
>
