Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3844220951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbdCNV4K (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:56:10 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36370 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbdCNV4J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:56:09 -0400
Received: by mail-pg0-f68.google.com with SMTP id m5so1799576pgk.3
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EAp2Ct0AqaFPp/Kf2vPZFZMY5bz1fO+UNbaFna3cU+w=;
        b=MyrPllRF4eOfDH5UZxPyn0WdCxP7QlNw/w/97kLtmIYTTVBZ9r83WBxqUcxqbAR0zM
         2bc6FHjEgu9wzAHwCKye1ntqtAUMayT9jaexiMzZsMmiVQ4M1KAqwFZokKeuB5BEOhiW
         hbJ3VtXjb+WMua61aAlpDhPe1woJdrFhW0SY26lQTYNxgKkYZ3nEYjKwY1xrAes5sdYm
         C4BjMa3DGPmG3JeAHar3/Ea+5uHwg4R3ZVIzOCaDWWlTKY+03dzI0BwO3XzoM5PtmktM
         +gU2ryrPIs4cY+yITMG332UT1Tb1YnSrPXCvEJOlLkFaBoh9aiN8oqoPHhhcWsD4tS5W
         4IEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EAp2Ct0AqaFPp/Kf2vPZFZMY5bz1fO+UNbaFna3cU+w=;
        b=tgiSe8mQi7Wy0rGWdrNZOu5voG1bvkO/oBQkV1eOpXXLEkCltsjxuCUMynk/1VRcCb
         NG1SvM872N5InkSvj8D97Aec0noonCU8le0XYApXTFofQ+lB0iVrnnXjJbYaRQmcwPYd
         cj8Nam15uRPFtY+DTikjHHGrJmz3+DA1wPM2ZkCwT8Tzaw87489yQC6Z+cqmTtaZ8ElE
         JMKfdvsU8fMSgl8Km5wQEDNwbsDR5LBCbyZiFWZXJVeKgiEFwcr7FARDpWVAg3dwhKMS
         5koQ7tvDKXnKzg6eEvH4NAhjPK6NXSptRq7mg/rMvu80cRXi3Il9LKUdqEdBHWF24c9n
         rZXQ==
X-Gm-Message-State: AMke39mKQVy7kBZlXaowabXSIV/pFySwric5JFH25w30u3m2Jp5a7gsKuKnFk2LPcm+QgA==
X-Received: by 10.84.236.74 with SMTP id h10mr58808899pln.13.1489528568151;
        Tue, 14 Mar 2017 14:56:08 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:44b6:c180:5bab:cbd2])
        by smtp.gmail.com with ESMTPSA id p77sm40291009pfj.99.2017.03.14.14.56.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:56:07 -0700 (PDT)
Date:   Tue, 14 Mar 2017 14:56:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header
 file
Message-ID: <20170314215605.GL26789@aiede.mtv.corp.google.com>
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
 <20170314184126.GJ26789@aiede.mtv.corp.google.com>
 <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, Mar 14, 2017 at 11:41:26AM -0700, Jonathan Nieder wrote:
>> brian m. carlson wrote:

>>> --- a/cache.h
>>> +++ b/cache.h
>>> @@ -10,8 +10,8 @@
>>>  #include "trace.h"
>>>  #include "string-list.h"
>>>  #include "pack-revindex.h"
>>> +#include "hash.h"
>>>
>>> -#include SHA1_HEADER
>>
>> For what it's worth, the bazel build tool doesn't like this
>> '#include SHA1_HEADER' either.  Your fix looks like a straightforward
>> fix and we never encouraged directly customizing SHA1_HEADER.
>
> Hmm. I don't know how you're using bazel with git, but if it is doing
> something like generating header dependencies, would that mean that it
> potentially picks up the wrong dependency with brian's patch?

I believe it picks up all options as dependencies, which is good
enough for me.

I have a custom BUILD file to build git with bazel.  I like the
reliable dependencies it generates (unless you do heavy contortions,
files aren't available to the build commands unless the dependency is
declared) and fast, parallel build with simple progress output.  But
keeping it up to date with every patch that changes the Makefile is
not something I would wish on the git project.

One of these days I'd like to try making a tool to automatically
generate the BUILD file, like contrib/buildsystems generates a
Visual C project.

Regards,
Jonathan
