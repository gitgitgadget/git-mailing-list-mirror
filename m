Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4F971F404
	for <e@80x24.org>; Fri, 20 Apr 2018 23:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeDTXVk (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 19:21:40 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:38665 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeDTXVj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 19:21:39 -0400
Received: by mail-pl0-f49.google.com with SMTP id c7-v6so6024841plr.5
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 16:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0mp1BrVeLqU7mOx/DDaUGeQ5nfDT+XU7TdfedI4mTE8=;
        b=YZUjC6HpMfRCWX0UYl0qc3rxbAZ4H8tHp04QBtWO4dojMKY0feu3xv9tq8I3gLjHz+
         vlS1lErnuZ91gGFGYVTIo6wSb1D/4J8Zyz8C0xu3pUm8RTASMtXqfzc08BzQax62JEEH
         uAeyY/y+PnMOtnUAMF0U+uwjIWm4uI4mctlztEGgal4sOiKBQ55PqTjWUn5ZR+IO6Y+K
         +/hUQmOGuJY/KSf6KZFDP9gJVtYCmDMrnqM22RkFcDSRoyTJujTQv9WZRgJtDANsPbcX
         3WUdLXdxArAa+aQo0NQ13PKwIyO1r02xq2gnIMCUNCYyB6DrmsDwadkHvGmJakBHQNNB
         WihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0mp1BrVeLqU7mOx/DDaUGeQ5nfDT+XU7TdfedI4mTE8=;
        b=dsX37mPecYwvsXHWth/Qq9bDk2ObWi7hfm5iK4w53TXWcPzXsd0z6x7pOICO/cGkiB
         AGiYzkECcaEgoLNvjWtBV/KELOe8K3EUZ/rCOiSSYh1Gif8aZqIjU6fxZKpe/vUyIUIi
         sJX9yVePr2r+++v13wvgeLEMroP7umPKfa2h3XLnNoT/IeGC19zu2lZZFaX+KWR0gxzP
         9aEoHQzBoMPmMRw6UhkNlH80uvJ0zQlPomL15JcAUKUKq7rxAG35TInnYnnAWKZRWUG6
         n40gkgZNFmzZSfKYFEo+85sg5xcvxvkzHg95E7C7cET/fU1PC0/2gGu10UEU2PZfmlQU
         XPRw==
X-Gm-Message-State: ALQs6tByYikdLzYMouqQ5WWr8AI40kOowvF9/AvYzSBuMKga4UCXJu4+
        0Mft9QDZ9lWrqzfGxfPGbSPS8g==
X-Google-Smtp-Source: AIpwx496ldIDaBNilkj0J0vUsNcbBLtI0MSpO4bXXJKcq0Fy8deIK5p78OtOTGgt/rmxMo5X8eeJ/Q==
X-Received: by 2002:a17:902:5602:: with SMTP id h2-v6mr8843305pli.115.1524266498937;
        Fri, 20 Apr 2018 16:21:38 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id k83sm18917835pfg.153.2018.04.20.16.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 16:21:37 -0700 (PDT)
Date:   Fri, 20 Apr 2018 16:21:36 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH v1 3/5] mem-pool: fill out functionality
Message-Id: <20180420162136.144ac5529072f22067abb3b9@google.com>
In-Reply-To: <20180417163400.3875-5-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
        <20180417163400.3875-5-jamill@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Apr 2018 16:34:42 +0000
Jameson Miller <jamill@microsoft.com> wrote:

> @@ -19,8 +19,27 @@ struct mem_pool {
>  
>  	/* The total amount of memory allocated by the pool. */
>  	size_t pool_alloc;
> +
> +	/*
> +	 * Array of pointers to "custom size" memory allocations.
> +	 * This is used for "large" memory allocations.
> +	 * The *_end variables are used to track the range of memory
> +	 * allocated.
> +	 */
> +	void **custom, **custom_end;
> +	int nr, nr_end, alloc, alloc_end;

This seems overly complicated - the struct mem_pool already has a linked
list of pages, so couldn't you create a custom page and insert it behind
the current front page instead whenever you needed a large-size page?

Also, when combining, there could be some wasted space on one of the
pages. I'm not sure if that's worth calling out, though.
