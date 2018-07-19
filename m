Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4865E1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 05:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeGSGWv (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 02:22:51 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:39221 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeGSGWv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 02:22:51 -0400
Received: by mail-io0-f180.google.com with SMTP id o22-v6so5030848ioh.6
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 22:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIKAXz4EWAavR9C2ioTs3ch8HZklRI83W84UC85b/j0=;
        b=ICkeuyU5SwMh94qbOy9Xfp3JTJFpkvjzwjpIwmDsj+Bls29LG7bafP1wEla8dQEMOq
         3veLZ4CusLfHQFaonve6RLr+/sz8Cq2vKUq2GDY1g3Hcp151aLmne9oOO2CP4RXpppbt
         D8PkisezU5JD1W5uaN0+JjyAU6+vzInUXGOIpIPPaSWFmRqKe/OlKVk66EiepoNIfYUH
         D8TQPWeRnv+AZzwePhqJmKaO5bZNfouV4LqfIK4oWFSdcszs7sDr/vMsaFNoYdcnZZxk
         X0XMhkmy/dC2yue6hsAgefXRWyg+Z8EMigTPAX93d+eW0t7VxBhr+9EcUBGKUczJTIA2
         0NVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIKAXz4EWAavR9C2ioTs3ch8HZklRI83W84UC85b/j0=;
        b=icEfHR9ZNcWG+u78SaAD6YwyXJp7F8Hn6+VVW1wIPZ0V8EbYCKktJANftuufbjsLLA
         /KJGYVTU52cCGg+tkUdx+icxXTTa1Ec+aEI7bUGECOilZrirZdTEfZ2nxDEfm4phfZNh
         sVjvfQhtjBB72UT90Tmom4xjMYMkyjXST+Pm/sA63Tkxyl66QoJAuTaYYSuKDWkAoC+U
         5xry0/UHrhatoHdaZvFSHP7aLTTXIUrDqX+gp8Megb1O5uIgGPtgei/FBvdwVRwcmRu8
         SvJbKmxsdtLrnb21+EN4LpR8N2noYzECPs3eTFByuKJbmpVpqAlDGo+3od+jfGMOAbeZ
         hRIA==
X-Gm-Message-State: AOUpUlE0aj9KZ/tYNpz4m87vsxuoHkNLf2NpACDpfvskyj/ne5o9+ufs
        0gIZ+EmXtQL77erJeYlcIx02M3gJzwaotGWl4qA=
X-Google-Smtp-Source: AA+uWPyZ5mK3rcJhDl80/l357pS4FpDBdIjJ0waKD1VaL3r7P/BM5iDFfPtwtnSYynIiKwXXZFpcR8ifntAkvqAt05Y=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr6736645ioe.282.1531978889933;
 Wed, 18 Jul 2018 22:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180718225110.17639-1-newren@gmail.com>
In-Reply-To: <20180718225110.17639-1-newren@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 19 Jul 2018 07:41:03 +0200
Message-ID: <CACsJy8Cc=h3ptDaW=oUGXqRZAvNU8-pUCe1cVFpRd0t8O1a0Gw@mail.gmail.com>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 12:51 AM Elijah Newren <newren@gmail.com> wrote:
>
> I had a user report some poor behavior of 'git gc --aggressive' on a
> certain repo (which I sadly cannot share).  Turns out that on this
> repo, this operation takes about 60% longer and produces a pack
> roughly twice the expected size.

The intention was to make life better for weaker machines but
definitely should not slow down beefier ones, so yes this is
definitely a regression.

Is it possible to share "verify-pack -v <pack file>" output of the
pack produced by 2.17.0 and 2.18.0? The only sensitive info there is
sha-1, which you can replace with just "SHA-1" if you want. I'm more
interested in delta sizes and distribution.
-- 
Duy
