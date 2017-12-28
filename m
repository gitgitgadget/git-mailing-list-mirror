Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1281F406
	for <e@80x24.org>; Thu, 28 Dec 2017 18:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754301AbdL1SOh (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 13:14:37 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:41076 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754585AbdL1SOV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 13:14:21 -0500
Received: by mail-it0-f66.google.com with SMTP id x28so28954302ita.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 10:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zXqPEseqo/a50vnd7iusvjnU/m+h684bLRWUF0Vxvis=;
        b=GxBnYlMf8Bxg1w4TEYSVbu68/NOPqBsjBxOneb6WJzTaca1BpGvmkX1GhrgJDDQ0Ly
         69JbJSNwJQVLhQm6sbJPdtydFD13c62NJ2JWBR9EUFS/ipE5vUmEf/sxOvalqZpk4wgt
         g3Hn3vCzE1rVm8E//a/fp+5GkseYg/ZrhkkhPlw/9vy1WC7M1nLDKO5vw38WbJ9xsql9
         FVCavRLZaJdNv64nHbzr/lDvZ0T8CLnKr0SkFFkuaYrEyHqrummvcRUebcGiubv3nzpk
         mZLEP1tUd6vmCMYksZWUz6e0ri3tnchRKmz2sdOUoNfIzrTrLgHFMln5LqT3OAbQBrMY
         wxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zXqPEseqo/a50vnd7iusvjnU/m+h684bLRWUF0Vxvis=;
        b=ZzEAJZIW8jNuHrvHYJpRZcFrCQrcZa8Fjpg3bUTNB8BUaZIQZ99go1xupagSrMJnmU
         zQH0ehQbDRn6z2drzE+E9SQKSe+OhfGHn/UCGH+zUy2F7fNaO/beavYyHWW49hoWcSPd
         3Jh62kZh43UYXMMtGFKSeBC7Q6qwTyxI7de9o0NP7GZ3FAVz8v1EtScME3NwFKSjWs2l
         3bmeoUDnCOU61AZz1rTWxHKiYOE4EZHPf3k+1EW7opXwjjfeiBwU9MoJbLQximKiKxdq
         D+cB45+fJ7eDFnZX90V1RMAO4gDuGu2IuWIhj0xtI5NmLmjSwUrsfOHhX6CjtrxCoRhi
         MzSQ==
X-Gm-Message-State: AKGB3mJztWfJBBSLMIkJYd2Hi1bb0lk6yYMkHEgw8/0syM2fl1q0wy4z
        ktTymVu41pU3xJhmwSj8NRw=
X-Google-Smtp-Source: ACJfBosr0Vo/9JCF2vze7nBlLYDpsS3IPVp1417/wE0jyiWA8polx4iYDGPmo2UPqtba7NpSUxApHA==
X-Received: by 10.36.4.72 with SMTP id 69mr41227398itb.33.1514484860736;
        Thu, 28 Dec 2017 10:14:20 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 125sm18616099ioo.68.2017.12.28.10.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 10:14:20 -0800 (PST)
Date:   Thu, 28 Dec 2017 10:13:47 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] travis-ci: don't try to create the cache directory
 unnecessarily
Message-ID: <20171228181347.GA92530@aiede.mtv.corp.google.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com>
 <20171227164905.13872-2-szeder.dev@gmail.com>
 <20171227194601.GA181628@aiede.mtv.corp.google.com>
 <CAM0VKjm+TBerXFzrqVmKdoVk=hWpnN2m62a-v-_Yrp8Onidu1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjm+TBerXFzrqVmKdoVk=hWpnN2m62a-v-_Yrp8Onidu1w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:
> On Wed, Dec 27, 2017 at 8:46 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > SZEDER Gábor wrote:

>>> Travis CI creates that directory for us anyway, even when a previous
>>> cache doesn't exist for the current build job.
>>>
>>> In itself it doesn't hurt to try, of course, but the following patch
>>> will access the Travis CI cache much earlier in the build process, and
>>> then creating the cache directory this late might cause confusion.
[...]
>> Is this behavior documented anywhere?
>> https://docs.travis-ci.com/user/caching#Arbitrary-directories doesn't
>> say anything about it.
>
> No, I'm afraid it isn't explicitly mentioned.
> I seem to remember an example implicitly relying on it, though, but
> can't find it anymore, so either misremembered or misunderstood one of
> the examples.
> OK, then I'll move this 'mkdir' to 'ci/lib-travisci.sh', to ensure that
> the cache directory exists in all build jobs.

Thanks.  Sounds good to me.

Another alternative would be to contact Travis CI folks to get the
behavior documented more clearly.  But here an early 'mkdir' doesn't
hurt, so it seems simplest to do it.

Sincerely,
Jonathan
