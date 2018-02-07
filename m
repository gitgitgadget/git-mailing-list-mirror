Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D061F404
	for <e@80x24.org>; Wed,  7 Feb 2018 22:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBGWdD (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 17:33:03 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42898 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbeBGWdC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 17:33:02 -0500
Received: by mail-pf0-f193.google.com with SMTP id b25so952947pfd.9
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 14:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nm8sw11sw0N3CiNU6qpof5SP1OnJuQwSz6+6Apx/bd8=;
        b=O9olJ7ThgFIXIDboBYrqODUJ2cNqwuebafwcSaNEBe/MCOWtnBvWEbN6ZfLeErEoHI
         f2Df0X/uxJALPsjHaLt1M1PyRQ0qVm1OjVk98tg/oUM34sI1Amp//tgFKLX1a46LWbg6
         wKZ24kjYh2vOM4gmOWF2xPifANwjghEmsAG+lDaKoaQ8XfnVtZPcHAHeposaLSD2QkGI
         C7bm1trYEulSe3CNNbaOHkqqgTUMu1nRk5N9jUEKO6ETzK1WvmdrkQQgFb9O5jQSGa40
         /fCiSNGiRaZWdBh/crkPFQ21B97lVV0Myksk4LWlqGBSPO85uym6JbG0eSxfqX+WT5WR
         47rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nm8sw11sw0N3CiNU6qpof5SP1OnJuQwSz6+6Apx/bd8=;
        b=BD+V84YMcj/9frCSmgo4AT3bkfUvVxX2aOW/39O1XdTccd7CCGVnN4fXQCSMQMFHM2
         q6DJ4v8tE0o9RXTR/XSaNuncl0J+8mSsqKufqvUz4NP/xEbhrZCiyGgerdanY9iPuyWX
         AK4zlkDJOBAzgzw/1D3noeJczLAREkySNryjUhTc4UF4gCWHI/PtKCeLY44ZqKzm3izg
         4cGSuBZQf0VrJPoxw0tzkOH55O6FsCb2mg3RZ/rsyNfr0k+VHSVPnhY1HX0sOroLqrOr
         YFqK51vgTZNuBLb3LpqSvgr7EXTUOfDRbjUtYnkHUxqQ84WyAjENE908GxjIQCCJ1A20
         ludQ==
X-Gm-Message-State: APf1xPBaLpNpOLNKo38daemYLqzuzBpV7CU6WMZfTFCtC8jAFqoe0J+p
        dOcCVDrs9D1fefFq7gi+ZPOk3VYy6cg=
X-Google-Smtp-Source: AH8x227+bB1Ii4w830liClm/wNaPDFQN/3WlkMrStRSDZjrWQMj1qDdP7LQoUpmL7lFonKw6M1FyeA==
X-Received: by 10.101.83.76 with SMTP id w12mr5943903pgr.95.1518042782053;
        Wed, 07 Feb 2018 14:33:02 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id t25sm6418208pfk.162.2018.02.07.14.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 14:33:00 -0800 (PST)
Date:   Wed, 7 Feb 2018 14:33:00 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 038/194] pack: allow sha1_loose_object_info to handle
 arbitrary repositories
Message-Id: <20180207143300.ce1c39ca07f6a0d64fe0e7ca@google.com>
In-Reply-To: <20180205235735.216710-18-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
        <20180205235735.216710-1-sbeller@google.com>
        <20180205235735.216710-18-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon,  5 Feb 2018 15:54:59 -0800
Stefan Beller <sbeller@google.com> wrote:

> From: Jonathan Nieder <jrnieder@gmail.com>
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  sha1_file.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Thanks - I can see that this has been a lot of work, and it brings a lot
of benefit. Among other things, this will probably allow me to remove
the "fetch_if_missing" global variable that we need to set and reset in
the partial clone series, replacing it with a setting in either the repo
or the object store (and when fetching a missing object, first cloning
the repo/store and then setting that setting, so that objects are not
recursively fetched).

If we're planning to split the series up for merging in batches (which,
as a reviewer, I'm very much in favor of), I think this is a good
stopping point for the first batch, so I'll stop my review here for now.
After these 38 patches, the net benefit is a better position of the
packed object variables (in struct repository) and permitting the
reading of loose objects in any repository. (Permitting the reading of
any object in any repository, I see, will only come later in patch 74.)
