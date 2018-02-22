Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0BAB1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbeBVA4n (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:56:43 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:43440 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeBVA4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:56:42 -0500
Received: by mail-pg0-f46.google.com with SMTP id f6so1361748pgs.10
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pSGu2rrWQh6syKTmQrgpiGqcEklgZDyZ+S5wiuxu7FU=;
        b=IYpZkY1TyY9iB6fSrG4+fr3rGsycs3goszLLXDqlgLcRxLEos/zZMmsMc9jg3BKN9h
         L4oYUiwiKiiNDPS7tfwwDSW+GcN5SfNA+AO4f1h+BRryq+CYwpBZzHP5Nd5Fq7nYfKYc
         mQg7ytFYSH4WfyHgskHsZwu9ZaFArw7j4oPgiowqDK4d/oNP0o7vWFbKn7hvEV22UB72
         Jc/6zeNe/vJ8tq5pfOaXApthfwcdPVkB30RLPLMvxyij8LYIvPSfFZv1ZukesAYYtOgj
         IBzWVGI1SI1n4BGa7rDjXNvqCOlu+dm8hiTOjLkNN5a+lk45ZHAB++GP4jfjPeZiOE4P
         oxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pSGu2rrWQh6syKTmQrgpiGqcEklgZDyZ+S5wiuxu7FU=;
        b=m4lBhMnDXUdpIDLx722cGHPaeKscy7UFX5akGZhSk6ufh3EogEul4K+vLLrY+pTV8Q
         y0gkAEhxc3zq9/2vpxboSzsB654kyykT1EjDJSyu1mlzabY9x+BzhzjSsjFxFFwPD781
         q7DYDTVCB2Ys3DD2a1NzFhn4Ve61CUp69+1Bw2lQe9RMLf+xH3F0fWL8MRKEtG9inF6s
         YJLqhFoj2NFiEmJI7DcPzq0LB1rvGlxL9K3I8zBZNBiZOh+p8PJmiTDVPNOUO+Ilc4LR
         1m0p+BCeGx5pQhwoY4TUIiAirttXcnokAHIcQQ1JFViJsZ5ubWtcfIWP/z3/yCYkx4Sr
         W85A==
X-Gm-Message-State: APf1xPDfTzRFUgaRRpyoNJ184SOvK06aVBPuU4qkCPzLVGNB2Ill1Uxw
        09Lo21iaHClrMlnU4OqDNVMuyVimH1I=
X-Google-Smtp-Source: AH8x224vzufIOvwdG4QQ2QjbfrgVJ4aRqsL/UQU70lOTn3lYcBj8Vx9MoFdkBPgTxW35LxNSeRTBnw==
X-Received: by 10.99.95.201 with SMTP id t192mr4231342pgb.313.1519261002122;
        Wed, 21 Feb 2018 16:56:42 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id g9sm1016804pfh.153.2018.02.21.16.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:56:41 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:56:40 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2018, #03; Wed, 21)
Message-ID: <20180222005640.GI127348@google.com>
References: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Junio C Hamano wrote:
> * bw/c-plus-plus (2018-02-14) 38 commits
>  - fixup! diff: rename 'this' variables
>  - replace: rename 'new' variables
>  - trailer: rename 'template' variables
>  - tempfile: rename 'template' variables
>  - wrapper: rename 'template' variables
>  - environment: rename 'namespace' variables
>  - diff: rename 'template' variables
>  - environment: rename 'template' variables
>  - init-db: rename 'template' variables
>  - unpack-trees: rename 'new' variables
>  - trailer: rename 'new' variables
>  - submodule: rename 'new' variables
>  - split-index: rename 'new' variables
>  - remote: rename 'new' variables
>  - ref-filter: rename 'new' variables
>  - read-cache: rename 'new' variables
>  - line-log: rename 'new' variables
>  - imap-send: rename 'new' variables
>  - http: rename 'new' variables
>  - entry: rename 'new' variables
>  - diffcore-delta: rename 'new' variables
>  - diff: rename 'new' variables
>  - diff-lib: rename 'new' variable
>  - commit: rename 'new' variables
>  - combine-diff: rename 'new' variables
>  - remote: rename 'new' variables
>  - reflog: rename 'new' variables
>  - pack-redundant: rename 'new' variables
>  - help: rename 'new' variables
>  - checkout: rename 'new' variables
>  - apply: rename 'new' variables
>  - apply: rename 'try' variables
>  - diff: rename 'this' variables
>  - rev-parse: rename 'this' variable
>  - pack-objects: rename 'this' variables
>  - blame: rename 'this' variables
>  - object: rename function 'typename' to 'type_name'
>  - object_info: change member name from 'typename' to 'type_name'
> 
>  Avoid using identifiers that clash with C++ keywords.  Even though
>  it is not a goal to compile Git with C++ compilers, changes like
>  this help use of code analysis tools that targets C++ on our
>  codebase.
> 
>  Is the 'fixup!' cleanly squashable to the problematic one, or does
>  this series require another reroll to get it in a good enough shape?

Yeah the fixup patch looks good to me.  I don't think there was anything
else that needed attention so it should be in good shape with the fixup
patch.


-- 
Brandon Williams
