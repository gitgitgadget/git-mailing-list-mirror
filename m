Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9DC1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755965AbeASSWK (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 13:22:10 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34773 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755899AbeASSWI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 13:22:08 -0500
Received: by mail-qt0-f182.google.com with SMTP id 33so6026518qtv.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 10:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5pdqgNnqlPliysvIWKxp+Q+ITLoDyYzl5rlwFwoYF/4=;
        b=uqr/V2SC0GpqoKilKMgNWbHLqIGGFQGBkTPMDaX7my6Gtebv2rTq8HQJ3O0KaW4++s
         lb2sObuei0l8iFh9JnlN/FFL+jxDVRoQh/17P3N/GPDEi6/6hQkI7hgCxcNgnB6N7wIx
         mphn6fvdfPjl9vn3KkZA9HyhijxGuCXxEvru5/Nl8uuP+FVNQJwytwlaPxzsL84kqclM
         nma6axqu5QO7WbtD+opEtbJz7KXtPCCdJPmc5g/KDbjDuvopuba/VN4BlBS25udybzmo
         OY9o+ytDNuxvVsXDGNiwv7GIggbIJ6gSU5U30cal61Ep2WsG24hmOyaJ0V7yyvIX9pSo
         I6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5pdqgNnqlPliysvIWKxp+Q+ITLoDyYzl5rlwFwoYF/4=;
        b=uO2KISgosA8BR+SxyHypwJiXEXRx4LkTkcfLKwuDUHwzFdhVfCkevcoJwgGW6Okszi
         MkXDMMuNE0JIm/f/KCUQUp9Pqk0MpR9dft0IS4x/DXWhJFBbmQEOPYhxWhauwwrLSL2r
         qyxDQgAZV60aJCQV3jlmQcZs/i9P5oGDAWZCXD7m1pctAFxWiFgJAhfMy4jrcnnrwW+H
         VQx8BcUwErEFazb+xiszNfgpsk8tQfUxqqJsK9iuVP3EGGatVwl7cu81DlxV6d5SmL1w
         Kw1pbIzLMjjOsuEv5lTJD3eR5QaSXcMZ1S5S4pqoWaMV6R6kBM1jIz7b0ZOfOAk59BbX
         Jbsg==
X-Gm-Message-State: AKwxytejmngke82Petbj0mMI3XuP5HhGvyFbY+QYrxsBdKrn0l5WcYw7
        gcCcKWl/D4qaJgZ02HWjQe2jIr6M
X-Google-Smtp-Source: ACJfBosTh4wRfd/ivIEjldU83uuCCaK2LDyqpyijogdXYhIQglCgt+AU+j4D6W2ItM9d5I+bPWsi+g==
X-Received: by 10.200.18.202 with SMTP id b10mr47277743qtj.152.1516386127887;
        Fri, 19 Jan 2018 10:22:07 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id n20sm5744908qtb.28.2018.01.19.10.22.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 Jan 2018 10:22:06 -0800 (PST)
Date:   Fri, 19 Jan 2018 13:22:04 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     "Stephen M. McQuay" <stephen@mcquay.me>
Cc:     git@vger.kernel.org
Subject: Re: Segmentation fault on clone
Message-ID: <20180119182204.GO1427@zaya.teonanacatl.net>
References: <20180119180855.GA98561@smm.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180119180855.GA98561@smm.local>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stephen,

Stephen M. McQuay wrote:
> I submitted a bug against the brew project when git
> version 2.16.0 started segfaulting:
> 
> https://github.com/Homebrew/homebrew-core/issues/23045#issuecomment-358891009

This seems likely to be the same segfault as:

https://public-inbox.org/git/CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com/

There's a patch in that thread.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The man who is a pessimist before forty-eight knows too much; the man
who is an optimist after forty-eight knows too little.
    -- Mark Twain

