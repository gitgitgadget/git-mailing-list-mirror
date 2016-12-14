Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A9C20451
	for <e@80x24.org>; Wed, 14 Dec 2016 01:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbcLNBeX (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 20:34:23 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33787 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbcLNBeW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 20:34:22 -0500
Received: by mail-pg0-f44.google.com with SMTP id 3so1966763pgd.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 17:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m9yr9HQ6lr6A26tlqqkHGOXA6ozvc7iqUlCgw4Mod0U=;
        b=CbBANGXSoKJJGfWkfa2iGMo6rnIAFJ9UDx4TQh9wcOS8OrIDu/M19i3qEOTghmPx7k
         NS3Hj5/3jERC4VA3BMWdO1uES/Rjn0MTq+VX09FjyXqiL3kdrqLgGQGd+h/xI2J5VMJ4
         RRyOP95c2Os8HT2Va+7G/zz1fPAS9yMENrghMMCK4KQr2us6n5bMXxO1ApprLfY4yVYI
         NQc5rBk+dNlvMd7wwX3p5u0/41LxWAp3rmOTis/iO+Ns9F3Rrm6W3/4dHz+Y1WRxfZKP
         uImfjnYWf0DdYZaBMdTEWpFEU6fNSr86r4uxixu3g+Z+UZ9lArXA2o6MCAL/Di7qUjyl
         N44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m9yr9HQ6lr6A26tlqqkHGOXA6ozvc7iqUlCgw4Mod0U=;
        b=gwhBEPHyh8mX7USGUyrDkQMbHxK26zDDdS5qtPRFvqYu49O9EXJricG37Gd9lJUJVJ
         C1t18tTkX9d42jDCu65D8IJleW436uIM9LT4JFmNfJca4wU8OnghD007qO0E562bvOwT
         v/UhOKmfujPNuaZhs6kCFCxGVmZdIWSMB2aecJ/1xg4xvvhJU6E3kC8pmMo1X2/QkQw7
         hsoBsQGJFh6th/DfI5eXaqbfYaifl/h2LsNTR6MZrLAtsHDMP4f0Jj3DCC7wFE+e4MBt
         r8Nssoup+0Nvw2XCGTAhfwlXkxB83w1yKLmJjV/YDuuxGaYZauPyM5EMVM/HMeRaU2XG
         0jTQ==
X-Gm-Message-State: AKaTC01KjIKaBvfsKq6YicwVqS/hq6udOyuiir47TJu2lMCuperYqFAyzin+FOPsHxUkbhG9
X-Received: by 10.99.55.79 with SMTP id g15mr181914004pgn.65.1481679261267;
        Tue, 13 Dec 2016 17:34:21 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:e076:1f78:6a8d:c0a])
        by smtp.gmail.com with ESMTPSA id x4sm83075291pgc.14.2016.12.13.17.34.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 17:34:20 -0800 (PST)
Date:   Tue, 13 Dec 2016 17:34:19 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2016, #03; Tue, 13)
Message-ID: <20161214013419.GA83860@google.com>
References: <xmqqd1gvz4x3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1gvz4x3.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13, Junio C Hamano wrote:
> * bw/realpath-wo-chdir (2016-12-12) 4 commits
>  - real_path: have callers use real_pathdup and strbuf_realpath
>  - real_path: create real_pathdup
>  - real_path: convert real_path_internal to strbuf_realpath
>  - real_path: resolve symlinks by hand
> 
>  The implementation of "real_path()" was to go there with chdir(2)
>  and call getcwd(3), but this obviously wouldn't be usable in a
>  threaded environment.  Rewrite it to manually resolve relative
>  paths including symbolic links in path components.
> 
>  What's the donness of the topic?  Is this ready for 'next'?

Unless others have any additional comments I think it should be
ready for next.

> * bw/transport-protocol-policy (2016-12-05) 5 commits
>  - transport: add from_user parameter to is_transport_allowed
>  - http: create function to get curl allowed protocols
>  - http: always warn if libcurl version is too old
>  - transport: add protocol policy config option
>  - lib-proto-disable: variable name fix
> 
>  Finer-grained control of what protocols are allowed for transports
>  during clone/fetch/push have been enabled via a new configuration
>  mechanism.
> 
>  What's the doneness of this topic?  Did we agree that it should be
>  rebased on top of Peff's http-walker-limit-redirect series?

Yes I believe we agreed it should be rebased on Peff's series.  I can do
that and send out another version.

-- 
Brandon Williams
