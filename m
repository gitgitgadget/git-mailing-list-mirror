Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029801F453
	for <e@80x24.org>; Mon, 22 Oct 2018 10:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeJVSna (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 14:43:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34927 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeJVSn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 14:43:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id e2-v6so948975edn.2
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D2SW5yCtKLYIEynKjQz03vn+JuBZWffZoQI57m/Tbn4=;
        b=KQnyN5zrUwSsaZoEHYCfzBVcv9b0RgtIRJzAnWO1wO+6yn+zB5aP2rFz2jgc8lG05I
         e+y4SOdCga5i/uMjPbilkFPdsXVdhgg7lJTMzSz29jyE1yDn7IWjPQVRdAwXXWvuQwjl
         K4pR4lyCvectQnP4+te6dJ3c8c5OXXo9gdBWg6HkG4RlHehhYJyX+dU8f/7ljNCbI2LY
         KtIaNOzwFnUU3yxefNQg38YRU1rOMDJw+OX37D4+mA+/GGYgKv+cROnWeH4hClBFW2S6
         xex69IZxJPaCKtbQ6use94JEXSNp5urCV0sVNphE9E2k67aKdaaVy2WKnO9cXLFyAHzv
         iOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D2SW5yCtKLYIEynKjQz03vn+JuBZWffZoQI57m/Tbn4=;
        b=BOjfGqkADOACin68j68cMp0qa95W2KxRlW+N6BvhqJFwHM3ikVGfs8HQMyFwhcPZRv
         Q5fIp/c66ndE5YUtevez4MZnFlWpWFR09vGG9ozrCMc2aj1cYccy+eY+6LA5fDub+pr3
         cF5hzbEPrzRoQDNVom9rCQgEV943fdcrQg0BBHDJvHvRiOWD1lKZ6PT48qYva89gLK5G
         fA6mytWzaLnrdHIsNmNNIzGzom9d4Jw/nQnBRYYIRZ3nfLgJ4kbp2hoPwDglgaz+D6L9
         y1tRsIRMbdAUNqeEDNT19ackaLLBZgyE0CPuYh2QCGPwBgfD++UlhBTm8jaWG7H9Dtt/
         w/Fw==
X-Gm-Message-State: ABuFfoiI87gHqnMmgmpLowF3ibTyXSxfV5H1ARHjpm7aUu2Op99+4Vig
        Z94MoXhpWN2Ngcsy0h7tbJg=
X-Google-Smtp-Source: ACcGV63XVQaaeRF62TPJy0pFN0K4KOwcff/+YJpTmiarilhxTSXOoy2kaMkbThS+Hvb4zX1y/yXifA==
X-Received: by 2002:a50:b8c2:: with SMTP id l60-v6mr12066468ede.267.1540203932065;
        Mon, 22 Oct 2018 03:25:32 -0700 (PDT)
Received: from szeder.dev (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id v18-v6sm1203610eds.21.2018.10.22.03.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 03:25:31 -0700 (PDT)
Date:   Mon, 22 Oct 2018 12:25:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v3 2/8] Add a place for (not) sharing stuff between
 worktrees
Message-ID: <20181022102529.GF30222@szeder.dev>
References: <20180929191029.13994-1-pclouds@gmail.com>
 <20181021080859.3203-1-pclouds@gmail.com>
 <20181021080859.3203-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181021080859.3203-3-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 21, 2018 at 10:08:53AM +0200, Nguyễn Thái Ngọc Duy wrote:
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index e2ee9fc21b..a50fbf8094 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -204,6 +204,22 @@ working trees, it can be used to identify worktrees. For example if
>  you only have two working trees, at "/abc/def/ghi" and "/abc/def/ggg",
>  then "ghi" or "def/ghi" is enough to point to the former working tree.
>  
> +REFS
> +----
> +In multiple working trees, some refs may be shared between all working
> +trees, some refs are local. One example is HEAD is different for all
> +working trees. This section is about the sharing rules.
> +
> +In general, all pseudo refs are per working tree and all refs starting
> +with "refs/" are shared. Pseudo refs are ones like HEAD which are
> +directly under GIT_DIR instead of inside GIT_DIR/refs. There are one
> +exception to this: refs inside refs/bisect and refs/worktree is not
> +shared.
> +
> +To access refs, it's best not to look inside GIT_DIR directly. Instead
> +use commands such as linkgit:git-revparse[1] or linkgit:git-update-ref[1]

s/revparse/rev-parse/

> +which will handle refs correctly.
> +
