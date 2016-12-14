Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9F51FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 18:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754302AbcLNSBA (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 13:01:00 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36305 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbcLNSA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 13:00:59 -0500
Received: by mail-pg0-f50.google.com with SMTP id f188so10338272pgc.3
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 10:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GQGLqiLT9a674Oy5AfiPxgjQsg3uASKgIoZ06Ax3Kbg=;
        b=izyyd+L/mVG/9lU08oqKmgcP+Mxq4YXKLareAUl5raIj37bqSsCrpwOIB20xJxC235
         wQVKLZkaXQQD7imaNCPytgvuDhZXyAx1SlctKvHDfWHbaObCoinuapQ7wQIr9ThYQgSh
         F65qI75ch2TBeW+4urgOlSjI6BDKOR4olR0HarTmVcRBQWj5624JixRIN1U/Kdb0A2lc
         Hn4WK6xITecBU+3lfrHAg1A6TueEvXS4ty4KbWMfqJH//7QKO9tgIZKK/UcZlNW6aOj/
         3+owzjr8zZz0ZWfibj66J68jNnwSEpvxA/DKPfUvZhcajiHy3ciWly8sNm9XVYj4IjQA
         Rptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GQGLqiLT9a674Oy5AfiPxgjQsg3uASKgIoZ06Ax3Kbg=;
        b=gNNyM7N6JTpTwzR1MKOSKPrde2gVkFvLTNrQ8HvAT6dxj49YmwunYpvCmfOdeZNgyn
         UdipoybCtQnzP4UyqRxZSdU4ep5KTPrLw7g9GdqevSKoXnltj4MCoNfSU+FPqyPjirov
         noa35OuSXFOOMXR3sLnL0Qi/ssm/AQXs5yL3WK1Lj1icKZhmpzpGsP5O+E0EZxPK8Ou6
         qGdR7sRisMpAOK5iC2BSwQkSLuEcIqHnn0dwshpHJwxJrXgOypG7yrT6sukkzdJs2KSM
         vtgjpAmFFIzhhq3e7+pyczr4qhDDe90Gd04NT4hthXU7t9VPgteDurovSSeJbKjhyqBv
         Lazw==
X-Gm-Message-State: AKaTC01haemxiF5YD/LZYl3c1OUUEZnUdY67hpz4HqTGdLNNod2rDrz/0Na/cFjA9mv/GAw1
X-Received: by 10.98.217.67 with SMTP id s64mr108174937pfg.66.1481738458767;
        Wed, 14 Dec 2016 10:00:58 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a0bd:b7d6:4331:46ad])
        by smtp.gmail.com with ESMTPSA id c8sm88967055pfe.15.2016.12.14.10.00.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 10:00:57 -0800 (PST)
Date:   Wed, 14 Dec 2016 10:00:56 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v9 4/5] http: create function to get curl allowed
 protocols
Message-ID: <20161214180056.GB20063@google.com>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481679637-133137-5-git-send-email-bmwill@google.com>
 <20161214160330.iqvwxshsgk4n2gm7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214160330.iqvwxshsgk4n2gm7@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14, Jeff King wrote:
> On Tue, Dec 13, 2016 at 05:40:36PM -0800, Brandon Williams wrote:
> 
> > Move the creation of an allowed protocols whitelist to a helper
> > function.
> 
> This is "what" but not "why". You can figure it out if you see the next
> patch, but it's often nice to make a brief mention, like:
> 
>   This will be useful when we need to compute the set of allowed
>   protocols differently for normal and redirect cases.

Commit message writing is hard (at least for me :).  I'll update the
message to indicate the why.

-- 
Brandon Williams
