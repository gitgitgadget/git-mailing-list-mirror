Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D7E1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 18:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJMC2q (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 22:28:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36388 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJMC2p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 22:28:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so6334360plt.3
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6TSlcT/jm3ydLd7GU8tDeh8ZVq+aL2A0oYQlLItlMho=;
        b=A7l4d1PXISIyUBc3MhtFSgZkTvB86WSIOz1LDrtK0AFhi9OKfPOwk0yrcrxqvYQKkY
         2D4rGXYKsYrkhryptBHHImZEx18wTTQvJWOdqFdAa7HO1YkGpFhr51MzjDHQfrcdBNUY
         VQSpbwjnhkiOyakOymErPeZtMnaR2DgC5IIZRaf3tdhLo1hba5zjFgYFM7tfuy1VMktG
         4w8u9Hh7O4/Cs4Yv6G7H64ciG8CPWKMvTEBR/0c0uso5/DfeZ2Ew3jItbEpC9gtzI1VA
         7dO+6ktO6T4QEg7w5Nkl7r9T86+x++sXljRRsqIymkEiVg94R4gVXn+5PEPSs+ETS2Od
         JsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6TSlcT/jm3ydLd7GU8tDeh8ZVq+aL2A0oYQlLItlMho=;
        b=eX7iTgfHNlZHIDZWmu3v+gC0D8/JNyt9g+KXkhzyEpvrL0kXacMpAenu6rTbI1SHGt
         rq+/ZImWQvuvxvOREEsMqoBBE5vIFiHqtUSLQy9y5LK5dsWjjnYAR2dyL7PQidQ9KVG+
         U6EzfeV5Xhju9XYiU002gxFPWNo1dXPKmke6oUgoMGwE11Or2aoayaXF1wz8emi7ZgD3
         9glbXsGppgoli+BI9vd+siNggnTt4vyuBG/qPUEKcJNdfjg22KkqtAZEZj5/XOAdwH80
         llwsSVWiEGtlYGg2jmkz8BLdRSzcv7qgsCj5DeBKbJ4X3Fn9i3nf6ffWoeM7qfP9WyB+
         gYIg==
X-Gm-Message-State: ABuFfohG2To5sJis3kwrfTbE+eBoKm3IfuNjfMCLL+h8/9AhDrcvh6sf
        YDdsCOYta1RCf+dUR/5OUbM=
X-Google-Smtp-Source: ACcGV61+/DXFsRYnpZYqbb3HBYj6hMqJWYkCt2DxPz4YuOC5j3yiXrHg+lI4t0W4O49fx13gNm4u6A==
X-Received: by 2002:a17:902:4001:: with SMTP id b1-v6mr7087261pld.89.1539370492461;
        Fri, 12 Oct 2018 11:54:52 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2656373pgd.86.2018.10.12.11.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 11:54:51 -0700 (PDT)
Date:   Fri, 12 Oct 2018 11:54:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] config.mak.dev: add -Wformat
Message-ID: <20181012185450.GB52080@aiede.svl.corp.google.com>
References: <20181012184037.15076-1-t.gummerer@gmail.com>
 <20181012184549.GC4917@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012184549.GC4917@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, Oct 12, 2018 at 07:40:37PM +0100, Thomas Gummerer wrote:

>> 801fa63a90 ("config.mak.dev: add -Wformat-security", 2018-09-08) added
>> the -Wformat-security to the flags set in config.mak.dev.  In the gcc
>> man page this is documented as:
>>
>>          If -Wformat is specified, also warn about uses of format
>>          functions that represent possible security problems.  [...]
>>
>> That commit did however not add the -Wformat flag, and -Wformat is not
>> specified anywhere else by default, so the added -Wformat-security had
>> no effect.  Newer versions of gcc (gcc 8.2.1 in this particular case)
>> warn about this and thus compilation fails with this option set.
[...]
> -Wformat is part of -Wall, which we already turn on by default (even for
> non-developer builds).
>
> So I don't think we need to do anything more, though I'm puzzled that
> you saw a failure. Do you set CFLAGS explicitly in your config.mak to
> something that doesn't include -Wall?

Thomas, do you use autoconf to generate config.mak.autogen?  I'm
wondering if that produces a CFLAGS that doesn't include -Wall.

> I'm not opposed to making config.mak.dev a bit more redundant to handle
> this case, but we'd probably want to include all of -Wall, since it
> contains many other warnings we'd want to make sure are enabled.

Do you mean putting -Wall instead of -Wformat?

Should we add -Wextra too?  From a quick test, it seems to build okay.

Thanks,
Jonathan
