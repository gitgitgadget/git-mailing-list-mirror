Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FD091F42B
	for <e@80x24.org>; Fri, 14 Sep 2018 20:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeIOCIK (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 22:08:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42113 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbeIOCIK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 22:08:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id g23-v6so4702671plq.9
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 13:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OnNhNzc7eMs3Ce9TeifN+UojzLHIkWlG4FhC2C2KHPs=;
        b=JDcwBmD69Gz/RDEXJej3TC6Qh+3iTImaNSnErN7jgxk+W3mb4F0bbVMKQKgwNyn7DG
         cMvVSorAj/nkXJOMniAP6cIlSCytU8jqIABzmPTArFTjdBdsrFlNvihrGavKQPU3R1jB
         fzHWThMPA95NjL5TSnZO8fh8kfNyB8WkD82RaJMkiBoecQDhIVjUgzoRwJneMFjTLtlz
         POoLTLw9KidWO7gRyF0OUiNFIuOK+3DEN5OM4rujcVYBOOZ6GBkDw7fI1s0QHgPsLJll
         WsrbjiCI+w7anD7kT+iAKiBIAD5Sp3jY80XIbTJi2cM/clw3kiTxYWIPJcso9dNrfrRV
         0fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OnNhNzc7eMs3Ce9TeifN+UojzLHIkWlG4FhC2C2KHPs=;
        b=evKVozEKB2NoYDrDNTaZAxHeYGdhJneO3gL/We6ICfO9XRXTNy1qMCDK3zjgZnGXVd
         pmbkivuNDwlQQKxXyPZO6H8LvKrh489DI4A8w4yiX+eio8McC3lQcE+kS4o5azyPoC/n
         Fn/zU07cffKJQ564zH2dSbL97tnZ8615+U/1M91DNFTjDOZtWSLoknD2Bimve3tSEwzK
         nDQFyBkbQPR+yT+gpCub8bOHqPZT1fn14W2M9Wm6iTqgWoLv8ux/oykfEnl4D013eXaw
         KvNpM9HZi1Vv8xoabUVg2cjFR9m94xefFjDPH3Cvnu7KsK3CBtrC45yc48Y0tUy8X3m2
         wQ9w==
X-Gm-Message-State: APzg51DBpAF68QrSp8/zpSasK11zQqoo8k9avIXvqtaMqFU4lii6FqwE
        5EHr7nSrFNUfhU/rAJD5RE4=
X-Google-Smtp-Source: ANB0VdbA0H/4IetDZoMVIS5z2xQ8MUMvUVbfR+b7B7MARPEXOsDBjHpH5WDHh4xVaXqquWhLlH9MCw==
X-Received: by 2002:a17:902:694a:: with SMTP id k10-v6mr13717527plt.166.1536958321242;
        Fri, 14 Sep 2018 13:52:01 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h4-v6sm11414154pfe.49.2018.09.14.13.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 13:52:00 -0700 (PDT)
Date:   Fri, 14 Sep 2018 13:51:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "peartben@gmail.com" <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 2/5] preload-index: teach GIT_FORCE_PRELOAD_TEST to
 take a boolean
Message-ID: <20180914205158.GC133420@aiede.svl.corp.google.com>
References: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
 <20180914201340.37400-1-benpeart@microsoft.com>
 <20180914201340.37400-3-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914201340.37400-3-benpeart@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart wrote:

> Subject: preload-index: teach GIT_FORCE_PRELOAD_TEST to take a boolean

Reading this subject line alone (e.g. in "git log --oneline" output),
it's not obvious to me what this patch will do.

What behavior change does it make / what will it make newly possible?

Maybe something like:

	preload-index: use git_env_bool() not getenv() for customization

	GIT_FORCE_PRELOAD_TEST is only checked for presence by using getenv().
	Use git_env_bool() instead so that GIT_FORCE_PRELOAD_TEST=false can
	work as expected.

> Teach GIT_FORCE_PRELOAD_TEST to take a boolean to turn on or off this test
> feature instead of simply testing for existance.
>
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---
>  preload-index.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Can you say a little about how this came up?  Was it just noticed
while reading the code, or did it come up in practice?

I wonder if a more useful knob would be a GIT_FORCE_PRELOAD_THREADS
setting, but that's orthogonal to this change.

Thanks and hope that helps,
Jonathan
