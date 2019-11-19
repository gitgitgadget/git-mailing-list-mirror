Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBECC1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 17:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfKSRgt (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 12:36:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52691 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfKSRgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 12:36:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id l1so4120488wme.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b0xkUmyg+muxsZyUOVSoRORSaYEuZKHKivNXuO6b4oY=;
        b=mtGofvXQ2yf6XN0WIOJZJ0sLH7E4U6aMzNIdBp0gLK+wHmuZidRKzZ3h1s/7qkhPLY
         UjNmub+K3RfZ6pvLs/H+AWP5d3bxicRlbFjDjA0vBBga3hgTTtOmcBsRAZOvmHRX/K2w
         YhUuqwqpaoTKbWy1SsSPYsF4Menilkxxfbh5dVlqPBAm0bzVTcm7VdpsVQfygepoOa0e
         eZB4t9JbBcsND161YKH/3WPNonYm7jiRQNMFz6TLAmPERbPyS5YdS6UqH/BsrWioRU54
         SMcesem5mTZQm6K2aKYl+jwnFG1exFERINGVDqSSIAZKCwCVnrRN01oqPrzlGO2Trjqy
         bgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b0xkUmyg+muxsZyUOVSoRORSaYEuZKHKivNXuO6b4oY=;
        b=jhL/0h1zDJp1YI+RRLwRCN+173MW03X4i/Haq2O1kpY4m/CVi1S/Y0xEOfZL3U0+MA
         3N8J3NZJFea5fptfKc5ioJYb4mDbD9E3+hET/j3dmnULO8x1U5Ydqxue1H9elwljtcPG
         9ILI/rcpjG+7uh+MYirSexuB97SBuml4fd2JMix1fNgYlJtr8IKVrsIZN81jWLYb+rpz
         ynxoXcD5b4qtTmKSI6GZcTPz6WQ0sI1otlS2YY3QoBvRGI3CJxpSDFJfbvneHsQFs6cJ
         GADMagURYX4mU6K8AJYXihIcAk9avdhkjptlO/FMtD9Dq28cpYWk57rtzeBTH+LQ6E2X
         Rp5w==
X-Gm-Message-State: APjAAAVGawuMN48hXNgRZEm+6leaahFj8MupB6AdpxFmsFg3yyPZsy4K
        A4lkMrWvOamM6Oyn/eVCpTc=
X-Google-Smtp-Source: APXvYqxleEC8Ko+fyJdAPP1QYTaoetuLfUjmgAyj/mhlpgnALld/Ngtvn319PKye6nSeYgIjzEQYQw==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr7437172wmk.98.1574185007059;
        Tue, 19 Nov 2019 09:36:47 -0800 (PST)
Received: from szeder.dev (x4d0c2755.dyn.telefonica.de. [77.12.39.85])
        by smtp.gmail.com with ESMTPSA id 16sm3906597wmf.0.2019.11.19.09.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 09:36:46 -0800 (PST)
Date:   Tue, 19 Nov 2019 18:36:43 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 08/17] sparse-checkout: add 'cone' mode
Message-ID: <20191119173643.GJ23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <121d878882609907cc8d13f9d76f2414b15618be.1571666187.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <121d878882609907cc8d13f9d76f2414b15618be.1571666187.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 01:56:17PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index f794d4797a..3931e4f2ad 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -92,6 +92,56 @@ using negative patterns. For example, to remove the file `unwanted`:
>  ----------------
>  
>  
> +## CONE PATTERN SET
> +
> +The full pattern set allows for arbitrary pattern matches and complicated
> +inclusion/exclusion rules. These can result in O(N*M) pattern matches when
> +updating the index, where N is the number of patterns and M is the number
> +of paths in the index. To combat this performance issue, a more restricted
> +pattern set is allowed when `core.spareCheckoutCone` is enabled.
> +
> +The accepted patterns in the cone pattern set are:
> +
> +1. *Recursive:* All paths inside a directory are included.
> +
> +2. *Parent:* All files immediately inside a directory are included.
> +
> +In addition to the above two patterns, we also expect that all files in the
> +root directory are included. If a recursive pattern is added, then all
> +leading directories are added as parent patterns.
> +
> +By default, when running `git sparse-checkout init`, the root directory is
> +added as a parent pattern. At this point, the sparse-checkout file contains
> +the following patterns:
> +
> +```
> +/*
> +!/*/
> +```
> +
> +This says "include everything in root, but nothing two levels below root."
> +If we then add the folder `A/B/C` as a recursive pattern, the folders `A` and
> +`A/B` are added as parent patterns. The resulting sparse-checkout file is
> +now
> +
> +```
> +/*
> +!/*/
> +/A/
> +!/A/*/
> +/A/B/
> +!/A/B/*/
> +/A/B/C/
> +```

This is a man page, not markdown.  Those ## and ``` don't look as
expected in the generated documentation.

