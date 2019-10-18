Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1972D1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 16:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443059AbfJRQbZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 12:31:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37577 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443036AbfJRQbV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 12:31:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id p14so6943591wro.4
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BYw5MBco0xZwgGGVy3sTSmZ2NcmUS6Ax7zlcosigi5M=;
        b=qzcs3Wo7F171lShkgYnglVHf3v4r6lTIRxw55BkB7PctZIH0988LZlCEUnU4EahNKV
         H3/Ga9QzacIKHm442OOtDs+uzFimTK1ycgxOkoi+sn1laRrQhpfWrBTGuFmYXlp9hsoP
         z4TcCIo9iEyCdQRpQizTm3n2AKaR5SMvYrnBIz9mFFRT8Es+96E+fH1p08e3Pe4wMq24
         vymb6kBUwQzOwUNMZub+vA5aPGlXxG2qxH3lZdI1O1+jH3/1A003yd24xcd2JuECrSiy
         s9vEnKqaGwFKYY7CdNhzty8OKV6H31UKFm55uFloX4lduva3+9zOCanQ+uuG4hhWwg4z
         0vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BYw5MBco0xZwgGGVy3sTSmZ2NcmUS6Ax7zlcosigi5M=;
        b=gDexd1ZlH2PPFYZzs70gidQM1rvty8JLYG2mMzyv7wweCU50UAK0XB70JdP7ssqWPO
         wdgfQxsqFkwuBsVBV4FfMiLxezHFvgLpF4gHheV2KMFjMgvskuhLpzlUbSVm1sKk98OC
         GmUPw90GKY68xH+stA0xel1EUAWPQZtdMLS6rC75jlpiECuhr25IWkP3JuMYOyP8dlPs
         axLTCJr1nbnrpbMjQalIXfwlPcruQU5chahvPsmhDvUrOpgv1Q9S2YiwG49t0Xg2kjSs
         cqt+QgEY5DH3Z4C7m+48Gy0JnGWbcYRtdBfw7mnL897tDiXIHHQf1mdFm7y9QzAPxs79
         +foQ==
X-Gm-Message-State: APjAAAWJU3/jTNzGI9v7SO785UTenNmGfXalTJIER3C/iRrtIMfc5K5z
        No7MY1BaNUNeQQjOaICmWI8=
X-Google-Smtp-Source: APXvYqyfYkjYm+jRHBzbAPROoaUcIg42IucA/tht6Ye86n9HsmFH8/BHvEASGBxUavwxB+rUy1TgIg==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr8474053wru.116.1571416279598;
        Fri, 18 Oct 2019 09:31:19 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id h7sm5964520wrt.17.2019.10.18.09.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 09:31:18 -0700 (PDT)
Date:   Fri, 18 Oct 2019 18:31:16 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 06/17] sparse-checkout: create 'disable' subcommand
Message-ID: <20191018163116.GH29845@szeder.dev>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
 <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <55f95f290ef77fa402f3e73f9c3045177bd70e84.1571147765.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55f95f290ef77fa402f3e73f9c3045177bd70e84.1571147765.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 01:55:53PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index b747b78d34..78a80ce119 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -8,7 +8,7 @@
>  #include "strbuf.h"
>  
>  static char const * const builtin_sparse_checkout_usage[] = {
> -	N_("git sparse-checkout [init|list|set] <options>"),
> +	N_("git sparse-checkout [init|list|set|disable] <options>"),

In the synopsis [] means optional, but I think the subcommands are not
optional; however, the options are:

  git sparse-checkout (init|list|set|disable) [<options>]

Perhaps it would be even better if each subcommand had its own
synopsis line in the short help, see e.g. 'git notes -h' or 'git
remote -h'.

