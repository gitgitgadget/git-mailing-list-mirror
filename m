Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A991F462
	for <e@80x24.org>; Tue, 11 Jun 2019 10:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405015AbfFKKMk (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 06:12:40 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53452 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404501AbfFKKMk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 06:12:40 -0400
Received: by mail-wm1-f54.google.com with SMTP id x15so2280227wmj.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fCbRPfsQMjbOZXAyrzIvqlXoxWyz+xfTAdCjomByOVc=;
        b=OMiHYsxyM64vxiRtaSC/Q6tCSUPoQxP9oFb8TVM+wOklgQA4sCOFYSA8g3vmso74TE
         J2IFYqcu2ZOus+DKn/AKivZkAe8o6zzrc1/rCrnfi/fxfJ3gCYstBfOUwyzcM/QsEJ7h
         Mc0xFpc66lR1FNNSZaxMGuSQpZ9p2bLTWOzpofiGsuOQ8Lq3AI+nbdff6GWV24KmNBrR
         VwmGrTN3i6YQQQmRn7Sh3CXxhfPEZBoik8vTvIidvFWtk5xNYYijdf/G5KOciOLZMCxk
         WZ3HRP3SQDwhiLz7ggrIwOvQLVkPdvvO9AO9mj/66b/wFMGiVmSocBslcekHhnx8ngcb
         Adkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fCbRPfsQMjbOZXAyrzIvqlXoxWyz+xfTAdCjomByOVc=;
        b=tDEFhC3YEd6VDQl60pgdttmknT7MIFJxZAzkgUjCoys3goV+IqGvtEw03cGtLR+BIs
         R2b7pJ8pNGq2t53mp5o+9Dw7iSh2iuYCm6kfUL8wVmek+7erYUFmPOmwLIzfqtfmDkxd
         kL8c3JU1+QL1d7pSlDJZyv0V6w+huMMIemDrIkJK11AFaYbOXH2iZuVta2Eyu9PutGXk
         V0wLywNX5RT6MLdqtpMTxkDQzGuPJ+bQvMhEb0bqAipSmTkOP3EbS7t0LUD5je3eHxbW
         KM0UVynG9Dw+6AUmZ6Znlkkb3QAWToP6JETlNDUEXZI/gUfKXNvsuseldEYQcA2t+lbJ
         mFnQ==
X-Gm-Message-State: APjAAAUSJgEh2IZSEMFiKUiYGwXk1LJAOA6Vu1J7csWvEjftdlzXw4iX
        arIMXwLrYzGfztxTP/LM8xo=
X-Google-Smtp-Source: APXvYqxj85Ow6tSShqZHV9ofSxnN8znvhvCjjqR00INx8z7WAcHKZBA8oH9VbLSMgmADc4s09JR9uQ==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr18176383wmf.31.1560247958125;
        Tue, 11 Jun 2019 03:12:38 -0700 (PDT)
Received: from szeder.dev (x4d0cbedf.dyn.telefonica.de. [77.12.190.223])
        by smtp.gmail.com with ESMTPSA id z6sm14449434wrw.2.2019.06.11.03.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 03:12:37 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:12:34 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 0/3] Test oidmap
Message-ID: <20190611101234.GD4012@szeder.dev>
References: <20190611082325.28878-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611082325.28878-1-chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 11, 2019 at 10:23:22AM +0200, Christian Couder wrote:
> I decided against hardcoding values as I think it might help
> transitionning from SHA1 to SHA256.

Ok, that makes sense.

