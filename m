Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208D31F954
	for <e@80x24.org>; Thu, 23 Aug 2018 02:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeHWGQZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 02:16:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36186 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeHWGQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 02:16:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17-v6so1824134pgv.3
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 19:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7KHwk/Djb3vKbcIDwP4c1tGAB/dX96QeeoSjDS+NkT8=;
        b=UMJEyiW6cowVm3KONCPj/1DHAdQ9mChQIzOO56bloivBPCngJn0wF8+QAlWS55etEJ
         eCXQQ40CwRC6yzQ/mfkt9rGWmrt08oEkaPZWg7h799Nz+oRTS+APoDaBrSf9LwNwF4rA
         8IDdCsp18MgTX7Ah8e2ICu0HF71TF+gfBeDPdQG9RIt2lt5+bocNZkmrzWKJ1S8qyEBT
         QQ99zfmPypR2nNaXWxpQKFSCeTzERilPv8rN97AVseXnps0CXsliuWf3qyqHIGs1Ed5A
         xi1/PavRQQKNiSNhZQ11EMJ69jNlEwAWJI9Zt+M4qoyHo3X14EvodeP2o0BCeftkV1gp
         zsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7KHwk/Djb3vKbcIDwP4c1tGAB/dX96QeeoSjDS+NkT8=;
        b=Qv3aTX7mussvVSQSWyJ3WglVg/ySypy53uOqfXizf2SYqImblWC3dQVYbunPv9iHv7
         W3Q2l23dL9ktJlMVHVg6x5uFvQuoFPjqJ5P8090zRRgLwQfaNBZR6WHMGlzQkWQFLRdz
         TrzC9TdauOeN0DCC1U1OSfKhHdl7//WxyFTWjH36Zjnj5GyKbd+AxxuwVZ7189O+FP7s
         vXVKb7dUKZTv+BIVQSFC+lbsTvbWV2vpWXoQLaU1eCXXJbq2O5jPU1FtjWUoI1Yr4Y6V
         07t71uZsessXuGL19XHdcdzYKf+VBl5KiQWv21+e0vjKduSFTRUvFjMF+fRCks2DC8UX
         r7TA==
X-Gm-Message-State: AOUpUlFJ8vrvKIobKkRzqFvuhrtmLfySeYZLNA/OjkG+5gpeBVJnTf/K
        ySO7yb2nJDYD30mdsL/JsHTVzUV1
X-Google-Smtp-Source: AA+uWPwv97hf4zPdmZzVOd0lPsTflpe/70SQfFu7rOd5/Lx6jp2hE+GcQANvsKD84XVDxWGFoIgYJw==
X-Received: by 2002:a63:e841:: with SMTP id a1-v6mr27335011pgk.126.1534992539051;
        Wed, 22 Aug 2018 19:48:59 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t19-v6sm4537401pfk.182.2018.08.22.19.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 19:48:58 -0700 (PDT)
Date:   Wed, 22 Aug 2018 19:48:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Teach the builtin rebase about the builtin
 interactive rebase
Message-ID: <20180823024856.GH92374@aiede.svl.corp.google.com>
References: <pull.23.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.23.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

[nice description snipped]
> This patch fixes that.

Please include this information in the commit message.  It's super
helpful to find this kind of information about why a patch does what
it does when encountering a patch later "in the wild" (in git log -S
output).

Thanks,
Jonathan
