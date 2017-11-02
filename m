Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3272120281
	for <e@80x24.org>; Thu,  2 Nov 2017 23:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964916AbdKBXlk (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 19:41:40 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:56087 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934431AbdKBXli (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 19:41:38 -0400
Received: by mail-pg0-f47.google.com with SMTP id 15so949180pgc.12
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 16:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wY0c3ItGOTkoi5ZUQfpKLLPIolGASzxGxbz19gT8hnY=;
        b=LoEq3OIu/rSktJfTbSJTNspztsKqCFaZJ1mD+9X9a1oD3GzyNyqGg67HwXcTmlgwnc
         /2Wc3+An5+42QVB9C7a9vRlxlMZZJRSKChd4SWPlCh3ieIdhcIZ95UavVYRZnribYcS1
         +dtwEHC8d5HuN7jDVsdnzVzG/Cl7iHchaQHEJ/OGMoY3a4mURHykHSQ2aMiLoYBk2tqC
         rcybGnU0OXn84KOKlrjfP/G2JyLx4VYiN7v4vjMrD42xa9UgnFvSXjn+yO0ssY0NJ9kg
         rRY5fpfqpOLvTKCHJ8DjdlyXIiA6Bg4rj5dcdNgPAi/+kZPsjqEFNja6bit5zUbrMQgH
         Hrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wY0c3ItGOTkoi5ZUQfpKLLPIolGASzxGxbz19gT8hnY=;
        b=JOxNBg41wKelQoumE2EKC13lXjBZF9v3xBaXrL7OwTgvoD6CFnF2W6hDsi+gW5dR8E
         7at1o5OQwKezGJ89eo6TbIx07S3uGHFYXP7NW/o7JufrkKt9xE1vnN3a8L2oVBj98wZC
         T9rdWZ4xaYMXgqR52/+IrQdWRNwUK8NhV4THbIGV3uhK3eHCwNo5j4lsKU4LIBYJTdCV
         rncRHhvYdwweTA2xGgD34/Ad3pkP2Z2ZrFiieO9asLldZF2iYoGO8/9kXdFgNFAf/urp
         +lucxCf4ksgrdpjV7k7qpyOMVALYPxhtB1pvO4qkRNhYDPQXIhhoe9AuyjIHvnX7WnEn
         L+FQ==
X-Gm-Message-State: AMCzsaVXGkbM6SZwK8E8q6lzGyy45fo46k8gOStske59BSvtPxzoNyql
        YX/HUHLz1TeTJ6+empWlh3C5YQ==
X-Google-Smtp-Source: ABhQp+RqllYUuams2K4zg5E7p1NMiChXq8UiWvtU18FpwG6YgR7YuEwGEhGdz7MIHEzqv0Bbu/L7gw==
X-Received: by 10.101.98.131 with SMTP id f3mr5210406pgv.366.1509666097309;
        Thu, 02 Nov 2017 16:41:37 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:2131:f64d:d486:a16f])
        by smtp.gmail.com with ESMTPSA id g13sm7460324pfm.130.2017.11.02.16.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 16:41:36 -0700 (PDT)
Date:   Thu, 2 Nov 2017 16:41:35 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/14] WIP Partial clone part 3: clone, fetch,
 fetch-pack, upload-pack, and tests
Message-Id: <20171102164135.435c05e07f71dcaf34149c2e@google.com>
In-Reply-To: <20171102203129.59417-1-git@jeffhostetler.com>
References: <20171102203129.59417-1-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  2 Nov 2017 20:31:15 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> This is part 3 of 3 for partial clone.
> It assumes that part 1 [1] and part 2 [2] are in place.
> 
> Part 3 is concerned with the commands: clone, fetch, upload-pack, fetch-pack,
> remote-curl, index-pack, and the pack-protocol.
> 
> Jonathan and I independently started on this task.  This is a first
> pass at merging those efforts.  So there are several places that need
> refactoring and cleanup.  In particular, the test cases should be
> squashed and new tests added.

Thanks. What are your future plans with this patch set? In particular, the
tests don't pass at HEAD^.

I took a quick glance to see if there were any issues that I could
immediately spot, but couldn't find any. I thought of fetch_if_missing,
but it seems that it is indeed used in this patch set (as expected).

I'll look at it more thorougly, and feel free to let me know if there is
anything in particular you would like comments on.
