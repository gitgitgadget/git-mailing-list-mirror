Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37EC1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 08:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeH3Mew (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 08:34:52 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39065 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeH3Mew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 08:34:52 -0400
Received: by mail-qk0-f196.google.com with SMTP id b19-v6so5203353qkc.6
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 01:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgyQmSnJk2BABZXBwD8DaKA1g7pLfp8puFubCPgsaBs=;
        b=H7JckhOaCtaGP0/fDF1qpaNKSYaXbR9fqjoj2EnY2L/EG8mvZH2oP0RIb19RTUZ2W3
         YrqamzlqSPP7+D+VyutM+w+uCPPzao7OXsgj1SITo8TICWkbbK6ImPQoGou/EuKihC6J
         1VAzOsJrHCU4qyxZKM6Zuiy4isr5eKIn71Lfr3NuyOVF8wXqRFC/2w83WeVUIfBHpKh2
         LJJJo/dxocKnv5uGwZlAWv3W4iBw+6M8nUWpZ3r9OgtSEsDRdM8XzPDMYIgmlFp275Za
         5VyTxFvGorGJTpyKipibBYIxymA/u26MlUuWexDLQI1iVOdqSbMEOCJhDfkUdUhscO7u
         750g==
X-Gm-Message-State: APzg51BXecZoX7EXfr2ZwkMVWyzjjJ51xyt+EMo3xW0TDKCCm6Ay/PEx
        jPQHtQTcNReD4GG2wC4lP+Bb8FkNflR783eyO5mgjQ==
X-Google-Smtp-Source: ANB0VdYdqeYou4JDG4Exoqb5YzyctJfbDnF9xtlNIJ7f+adxDDqrV09ZLKFf4YhMiCMkRpUg+m2bgQC/4WNRBI39YVE=
X-Received: by 2002:a37:9306:: with SMTP id v6-v6mr10020311qkd.36.1535618030604;
 Thu, 30 Aug 2018 01:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180828212026.21989-9-sunshine@sunshineco.com> <20180830074033.GE11944@sigill.intra.peff.net>
In-Reply-To: <20180830074033.GE11944@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Aug 2018 04:33:38 -0400
Message-ID: <CAPig+cSXx39jAJ_hsMtAsxCUVgBO64=RPaa+yF5JjZAK1CXZLQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] worktree: teach 'remove' to override lock when
 --force given twice
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 3:40 AM Jeff King <peff@peff.net> wrote:
> On Tue, Aug 28, 2018 at 05:20:25PM -0400, Eric Sunshine wrote:
> > -                      N_("force removing even if the worktree is dirty"),
> > +                      N_("force removal even if worktree is dirty or locked"),
>
> I wonder if somebody might assume from this that a single "-f" would
> override a lock. Perhaps not the end of the world, and the manpage does
> make it clear. And also I don't really know how to be more specific here
> without an overly long line.

Precisely, on all counts. Plus, if they try a single --force and it
fails, the hint printed when it fails says explicitly to use --force
twice, so the "solution" is easily discoverable.

> I'm guessing all those thoughts went through your head before ending up
> here, too. :)

You guess correctly and you came to the same conclusion as I did.
These -h summary lines are just to short for any real discussion.
