Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011CF20281
	for <e@80x24.org>; Wed, 20 Sep 2017 21:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbdITVXO (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 17:23:14 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:51596 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbdITVXN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 17:23:13 -0400
Received: by mail-pg0-f50.google.com with SMTP id k193so2376407pgc.8
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 14:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jVwtSTg8yRbJq7yzZr54JQKu6WnE1n5cRWsr69nJPl8=;
        b=HTTr3r7pU1LQanboKt+1R+s5OUfqx4kyVw5ByZg6lDdnMiSg5SoQ8XyP8X6CO/qUVf
         TLblGXJI0G6vBWhGIxeOPZIjCJah8iOlTdQ6dgoLuJtL51D3Zt8pt1ytP7Zv8FcEYIHw
         9b4P8CQHIhZtzOG0qQ0Bq0VDU1unMtaG63f5znZKMdr5JdCd1YYFwg6T4rg8IM0LAInc
         rQNxqwKNViqZ7RW6T9zQF6lfnv/ijfmSKlWSdqyQ/NJKYUvr8dk+b0vPRM34o7bfqHek
         +w+vWf1y2eC2BpR9elPS83ROI7hMPftCFTlbm3jRPiUYoGvPObmTJmiwGGgliPH9C6In
         ERAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jVwtSTg8yRbJq7yzZr54JQKu6WnE1n5cRWsr69nJPl8=;
        b=qSVa+Jp2QZta1Sd4EWolU2aZCBsE+kgQJxkgbyXFM1Yxobe5fxclhzaKcijZUW9k6N
         /x6qUkUUjzxpo8ele53jATDcg/q+tp1Lc8OHSZ8ej6wlaauxijJXK/j86NfLYWzJN/S5
         ogGWLDmPhK9U5bCY4x7pxDwPVBHvzOZS5NIys/s8BpK5wYOJ4VMHTO1Tf9gvX5rXuptT
         wqj4zG/QylVO3qKtyRfv1lvHTfPch9xLZrRICjox7RH1aJTOmKiLTopa6wy2URi33fyd
         s+b2epOoYj6ZA5GueUYzuF8KWdkwTJ6MNtjjkycQH/4zKKdju6sxRTZCvBEWnFN9J6f9
         gjhA==
X-Gm-Message-State: AHPjjUg/ZnE3sZfaRLOIo91YRCHWH0GY0v+MsxgII98rwWWL8zC+I3FT
        iV7l0VKII4DSt1+8AO07woo=
X-Google-Smtp-Source: AOwi7QAcXfFkTz/NGpHH8pwg6Gk2uAdKi7CKMFxn/tpFXBRUJuapmoUr+ZKOtnLudjhhp4x3vdAflQ==
X-Received: by 10.84.232.72 with SMTP id f8mr3313956pln.269.1505942592953;
        Wed, 20 Sep 2017 14:23:12 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:da9:ac38:cdcf:de91])
        by smtp.gmail.com with ESMTPSA id k10sm11179203pgq.92.2017.09.20.14.23.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 14:23:12 -0700 (PDT)
Date:   Wed, 20 Sep 2017 14:23:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Ben Peart <Ben.Peart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH] Win32: simplify loading of DLL functions
Message-ID: <20170920212310.GF27425@aiede.mtv.corp.google.com>
References: <f5a3add27206df3e7f39efeac8a3c3b47f2b79f2.1505834586.git.johannes.schindelin@gmx.de>
 <20170919180742.GC75068@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709202235300.219280@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709202235300.219280@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Tue, 19 Sep 2017, Jonathan Nieder wrote:

>> Could this example go near the top of the header instead?  That way,
>> it's easier for people reading the header to see how to use it.
>
> Funny, I am *so* used to examples being at the very end, from tutorials to
> man pages.
>
> If my experience is any indication, I would rather keep this order.

Sorry for the lack of clarity.  I meant "near the top of the header
*file*".

[...]
>> Are any of the Git for Windows users something that could go upstream
>> along with this patch?  That would help illustrate what a good caller
>> looks like, which should help with reviewing future patches that use
>> this code.
>
> I do not currently have the time to do that, that's why I did not
> accompany the patch by any user.
>
> However, having said that, Ben's patch series will make for an *excellent*
> user, fulfilling your wish.

Ok.  I think what you are saying is "go ahead --- anyone is welcome to
grab some patches from git for windows and upstream them", which is a
perfectly reasonable answer.

[...]
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Okay, I'll add that for v2. Will wait a couple of days in case more stuff
> crops up.

FWIW nothing I noticed came to the level of requiring a v2 imho.  If any
of the ideas I mentioned seems good, they can go in patches on top.

The patch is in Junio's jch branch and I wouldn't be surprised if it
hits "next" soon.

Thanks again,
Jonathan
