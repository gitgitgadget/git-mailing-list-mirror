Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0F521F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 21:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407561AbfJWVil (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 17:38:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36620 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405894AbfJWVik (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 17:38:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so13739356pfr.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 14:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4pahPvXlkKIJQ2nWR9NzRiCqVF7ntTTc6VVkzJIJzbI=;
        b=gBTQaQ3gj6qr/YMN9kldF49OYR4Sjsyr/a7CoYCjZWQNsKF18Jvq8hmzLL776TFad4
         5sXwc0P4zAhlIbuVpWN+BiPNugRUNm/bkkL67sDdJoVrt6zTucorKNhZ14A71EhJGUUN
         tQqanEjNowgz29FUpx/D0x+LDEG/b7cjWlrCMmooTNkNZN6kcSzzgfwXWhBiDN52mi5M
         xYBGaTb1VGdfxZRLqhkIzVjHOo34nhfx6CpERdtdl8oy3/BsfS3pMBp+VdHIPhUv9IvO
         WrCE3kBVyRFf88ZKPdajaHT3FkKcLvl1RYd3v4akZv0KNODOsNdYfoGXy1333iRUNG/Y
         bKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4pahPvXlkKIJQ2nWR9NzRiCqVF7ntTTc6VVkzJIJzbI=;
        b=MRMjci/P5XlqCOkPMaOtpMHrn0ruQHIjBocVvaj9gTwHkffADbqZpwatAhVED/7Tkl
         Zmtdbq6pUx2FsIw5fKbLsHYFFphn9rJmbRidZ3G16kvvWnSCeJ4utb4E2bFF9z1JMPy8
         9qhlsGzqqNF84UPeO4BTXlysFOh0cEtdPm5Y8AsCnvBm9hsukhEH2YYYnhxW1U5Z9tWc
         KMwjRIjVnmFcEgBM6Hqkth5XX5LxXb4REqG9Zd6sVprSNXmf4JR1kUWDdFCgKFuzbG80
         jO3mVWdXAGMJt1l/DadY72YoUkZG9uEFQoN2EWbVTCMXZap8AvD/xbsm6yhrA9sqQR31
         kwtw==
X-Gm-Message-State: APjAAAW+93junUCRxWwKKesv2yPtmeT1Sqql8ZbHFJfSLtZ5f645JTs9
        7bNZnp+AevC9ytCH7kbGmSxJyg==
X-Google-Smtp-Source: APXvYqyZdamsdzuMSiipIGwn4SgYo4p1Hwl6mV6bPhOwPTI68zhmH6bzrLOqRJ9EMN96xFlHHb+cvQ==
X-Received: by 2002:a17:90a:bd8e:: with SMTP id z14mr2634067pjr.40.1571866719754;
        Wed, 23 Oct 2019 14:38:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id h8sm25946305pfo.64.2019.10.23.14.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 14:38:38 -0700 (PDT)
Date:   Wed, 23 Oct 2019 14:38:34 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] config: move documentation to config.h
Message-ID: <20191023213834.GA124161@google.com>
References: <pull.405.v2.git.1571727906.gitgitgadget@gmail.com>
 <pull.405.v3.git.1571808652.gitgitgadget@gmail.com>
 <d6cbb3197af2c59f0222c7806ab6a6fcdf83869a.1571808652.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6cbb3197af2c59f0222c7806ab6a6fcdf83869a.1571808652.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 05:30:52AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Move the documentation from Documentation/technical/api-config.txt into
> config.h as it's easier for the developers to find the usage information
> beside the code instead of looking for it in another doc file, also
> documentation/technical/api-config.txt is removed because the information
> it has is now redundant and it'll be hard to keep it up to date and
> syncronized with the documentation in config.h
> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

Thanks for the effort, Heba. (I guess you are an expert on git-config
now!)

 - Emily
