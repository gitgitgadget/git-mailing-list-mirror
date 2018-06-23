Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125871F516
	for <e@80x24.org>; Sat, 23 Jun 2018 12:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeFWM3M (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 08:29:12 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37831 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeFWM3L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 08:29:11 -0400
Received: by mail-io0-f195.google.com with SMTP id s26-v6so8450582ioj.4
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 05:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6I3bARaB+EyHLagE2n8LUgH1dn2en2B0822HszhnRvg=;
        b=IbWyFHh8962uVh0ErTCSx5KjRMQyQJKddXoHeuyoIFD3UpkA43ovjaK9I8g4DNTQ2X
         ZO7NEYGiPSiy7X5awli/jGjZnev6YM4YVdOAlP2a9aPMfeYwxTQq8ijcY5MBxm1euSvM
         zzguALKmJRDTrzrz/GQS1PWdvh9INczmuCKhuDbWkn8ityNAtZaptnvxkp9MHCwoUjzL
         cyPAN3j0pTxQCuUCiXi6DaWtqXrrnCkqAImhDEKw7VlvzWYZR6solvvrhddEcP9E5K3U
         vjF1cTm2aIOFouNputMY7vO/LmEXQ8aRbAk/yLTSLqoUWfYDDACD0v4+jaIA3eaeYWpX
         fBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6I3bARaB+EyHLagE2n8LUgH1dn2en2B0822HszhnRvg=;
        b=X2m9ctG7PU3e8BMVY4663cuyRNlpzSNilaLX8L4gdtOdZTtNwLxBSD2E2pJqaxPOBo
         Ylr1LjcEhOCHKHM5ZGk2PME9+AQHYtKyKq2cJbXrrhXPVz7okJFAOqov9/Qby8TMXCah
         9ZlP6tm+k5Se81OG6Ws3xM5Kfn+CTT6sR30DtPGCYJOZ7leq/G5VVdSM+ZcZN8C5mHKR
         ys18wJtK6QJVC/+0nV8XC0N+Qc8K9h3F98gsNAZ092jlx+WcBYftq/zt/7w7Y1WQpQwR
         e+S9NsnHAQfCwxC0SUIFZRFbDKmuwkTn8qDkIQ8+AsHCbCsOuI8c/cefA04n7t1Lh80o
         0VEw==
X-Gm-Message-State: APt69E0uy5T6N+arklGlejZrBQKr9MQ/QuBVYt+aNAY8tjE2O6hwJ9Lf
        Me/EbDsZZVUG8ZduOSxN5uxVLlYv6HMMYqnhN0mdQQ==
X-Google-Smtp-Source: AAOMgpee3mNd84yWIpia0onEvoD0Dm78S7d/a1d6PbEoGWWNL2EbU8IWpSnHdCyBeDrmnJOuAMdepmdyAFSB0U/5NU8=
X-Received: by 2002:a6b:d00c:: with SMTP id x12-v6mr4428709ioa.5.1529756950170;
 Sat, 23 Jun 2018 05:29:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22d0:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 05:29:09
 -0700 (PDT)
In-Reply-To: <20180623121846.19750-1-chriscool@tuxfamily.org>
References: <20180623121846.19750-1-chriscool@tuxfamily.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 23 Jun 2018 14:29:09 +0200
Message-ID: <CAP8UFD1-opPfm_GT_p7fsNQSW-rN6zrgKSwTXgKZeqDOBOpXzA@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Introducing remote ODBs
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 23, 2018 at 2:18 PM, Christian Couder
<christian.couder@gmail.com> wrote:

> High level overview of this patch series
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>   - Patch 1/9:

Sorry the patches are numbered X/11 but they should be numbered X/9 as
only the first 9 should be in the series and have been sent.
