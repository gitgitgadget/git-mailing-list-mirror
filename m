Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE8A20954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbdKVW7S (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:59:18 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:38308 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbdKVW7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:59:17 -0500
Received: by mail-it0-f65.google.com with SMTP id n134so8224518itg.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FvRRt0Jo6qcbMLUvoNbwz+yYFqQLmvN5YctO+wmO+kA=;
        b=BQxOzn4yIl5Ee1rMl7xz2lCRxkATBzQ15a/yMd+2Bscfqc4BP77i09KsUmcDTVf9ko
         1JAOGUptd1EstpllpuleFiYWKPz1bF8eiXFWwcceG1MAF/x3xbnt7Ab0D89YvrK3OdiE
         Y3qOJH9zGCRd79tV4tLNI0pO6MZ2Fx8E/LPsmgYgjMmlUliSMu7Uje4pmIycaVmLhHXI
         D28JwUCMytQA2vQfAKsMr2DWTBj8HAparcKN24hcDmDj5FQlUcSTtrQc1d5HpjQEwIPt
         bC607Xvqj3kjaF5O/aiTds9zZT9/mIo9Ledxgremf9bidSKOtsALJntlRFzykOOa/iYy
         pMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FvRRt0Jo6qcbMLUvoNbwz+yYFqQLmvN5YctO+wmO+kA=;
        b=SiTlI3s2Xovkcd3z/34IZbqtCVHwBibZz4ve4gPlrZZ4KTbhbcaFnB3K6Kl38u0YZk
         BF8v44GLRJxj1UNC9VCKhzYC0p5rAp3JF1fWIwZvTgR5BY7bD0LqxGxIqaDsBWE/zUYE
         AY+wyyQR0KfFnlAdoYPB+Ip4PvkpFNFwUMBKjbhBZnMqPfqCkJyrFRaIfFnltiVBGz41
         5CQRcg10SMqWEc/yn1DxQ/5adyEzpwtmxsOUZqWuvlS7vrwvWPOxGAFc7555cVSkntj6
         BGfU8C4WCz+jcdAXhDTXfrCMjZauYa5fEa9pS33pcYVIj9Cv8baOYEy2CqQG1jRllcRy
         3nyA==
X-Gm-Message-State: AJaThX5EGFbuZ6r1vENBVb2Hgsv02sVStYnE6HMXNyYPfk325khFOMx4
        Kh43PCx0Tx+IQ/cD+wF6PYI=
X-Google-Smtp-Source: AGs4zMadWJuCuON5KG7oouAdZ/jsyMjmD7GbA291hm/yEhdug9FDmAQJKH4sb0z0mZrm8guKCzvIGw==
X-Received: by 10.36.69.4 with SMTP id y4mr406591ita.75.1511391556280;
        Wed, 22 Nov 2017 14:59:16 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i76sm2490807itf.3.2017.11.22.14.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 14:59:15 -0800 (PST)
Date:   Wed, 22 Nov 2017 14:59:13 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 1/3] Documentation/CodingGuidelines: explain why assert
 is bad
Message-ID: <20171122225913.GF11671@aiede.mtv.corp.google.com>
References: <20171122223827.26773-1-sbeller@google.com>
 <20171122223827.26773-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171122223827.26773-2-sbeller@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -386,6 +386,9 @@ For C programs:
>   - Use Git's gettext wrappers to make the user interface
>     translatable. See "Marking strings for translation" in po/README.
>  
> + - Prefer the BUG() macro over asserts, as asserts requires that the
> +   NDEBUG flag is unset on compilation to work.

nit: is there some logical place in the list of C guidelines this
should go at, instead of the last item?  Maybe near the top, since
this is one of those straightforward cases and we're just saying that
this is the startegy for asserting invariants that this project
prefers.

Separately: I am not sure we currently universally prefer BUG_ON()
over assert().  In theory, assert() is fine wherever you don't care
whether the assertion is checked at run-time --- in other words, it is
a fancy form of comment.  BUG_ON() is useful for defensive checks that
you *expect* to never trip but want to rely on afterwards.

In a certain ideal world, the preference would be reversed: you'd want
to use assert() wherever you can and require the compiler to check
that all assert()s are verifiable at compile time.  A check that a
static analyzer can verify is more valuable than a run-time check.
When a compile-time check is not possible, you'd have to fall back to
BUG_ON().

But we don't live in that ideal world.  I'm not aware of any widely
available tools for checking assert()s.  So maybe it makes sense to
forbid assert() in our codebase entirely.

That could be enforced using something like check-non-portable-shell.pl,
except

- run on C files instead of sh files
- run on Git's source code instead of t/

What do you think?

Thanks,
Jonathan
