Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4901C433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 05:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C7D6024A
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 05:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhCaFnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 01:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhCaFmp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 01:42:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE78C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 22:42:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x21so20796295eds.4
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 22:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OK35k0WHg9KKzs9Dj/bpYAbuYV3zb4mQ8HIhTcuXLk0=;
        b=r5KIl7ewyN6lXL8STS9LMi5F6EvUq4Fgtudj6riprJbkqwh8X4a9G1fF1LLJRoQ+Y2
         hT1zT9CBdnGiHvyKU48tOh6eNUPQFU1I9IYinsLufcAY411vMw2NDPh0C768zeMeH8CH
         SgFWdq/cACbB42jLMmEsMB2h+Cb4vj4kfXWYAzMO9A0Txc6I4o6X+Ab8jQEVCO0hS4Y3
         0gMEHRqV7fJFbJ4g0c9JZAdJUJ2ASmqhf+ss3Ih+2bacwHpG/PvkEfFALSMKERx9tapB
         OO6SzKUV++QxGcWFuhg5Aivt6RDcVr94IYsLhDa2O1XWORXvx4QpIPyVlaUuYkmG2ezb
         QRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OK35k0WHg9KKzs9Dj/bpYAbuYV3zb4mQ8HIhTcuXLk0=;
        b=VwRfRpG6HrMJK8UKv5tb0npMb9TFrsWpaWM8Aj8TrxNIYhaLZAciDgqM31q/6QojGl
         pXa05t86bERSXw8a2dWNn5P9fltmgIJqqbXoxsdL90rfT4SxQ2uAdS0HLHBIFVh7ct7v
         tBUqYfpgaea2xliNEAeJiSJGocBGM/N/m2I2W62ORUOzXy7EggqDBADAob9SbIvn5UWp
         Pmz+v0hVYoDv28spLo1uKiT3BSB9vKlmqQV2GZr5m4Yrc3XNVz/dQtxGn//fkSPQmCak
         CHIODZjkTMA44Bm/pgSa+CaT3CeQa025hBos76uHzNfu59UkgsZqVYvhySiITkG9z9hq
         i3Ww==
X-Gm-Message-State: AOAM532e97jgfT6cOm/i9/cK8zis7y1HvVuneMW2VC99utQPZu9vxfaR
        NnfRMxHBNWaRsb5at95e5Rt4M5ecIZ/CEdVAtLFm3qXehXY=
X-Google-Smtp-Source: ABdhPJz/1mGkG8ReWXXOzZHX6DAN54ZAeRqIHFmvS+yj2LjTHCwwhlGKcrkoGtneYznAH+Eir8ohT++NQzS8bBvY1gA=
X-Received: by 2002:aa7:cf90:: with SMTP id z16mr1544380edx.273.1617169362091;
 Tue, 30 Mar 2021 22:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616015337.git.matheus.bernardino@usp.br>
In-Reply-To: <cover.1616015337.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 31 Mar 2021 07:42:31 +0200
Message-ID: <CAP8UFD1stvx=2hBWyxmu75SXRzX-bHBfGr2jxWKgHdc85cfxRg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Parallel Checkout (part 2)
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 10:12 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> This is the next step in the parallel checkout implementation. An
> overview of the complete series can be seen at [1].
>
> The last patch in this series adds a design doc, so it may help to
> review it first. Also, there is no need to have any familiarity with
> part-1, as this part doesn't have any semantic dependency with that.
>
> This series is based on the merge of 'mt/parallel-checkout-part-1' and
> 'master', so that it can use the "brew cast" fix and the latest security
> fix (both from master), to run the tests. (The merge is textually
> clean, but it needs a small semantic fix: the '#include "entry.h"'
> addition in builtin/stash.c).

I took a look and left a number of comments. Otherwise it looks good overall!

Thanks!
