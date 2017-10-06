Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661CE20372
	for <e@80x24.org>; Fri,  6 Oct 2017 21:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbdJFV7a (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 17:59:30 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35396 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdJFV73 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 17:59:29 -0400
Received: by mail-pf0-f194.google.com with SMTP id i23so17740063pfi.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U3co7hSqrGHY3Lrjumnk8hajraD3kysX3pV8Vd7qSPM=;
        b=TMEKm+DmONt5qh32KgKgbXElaxG0FVfol/eDJ9nG6eyp+htHDRtvUjKJkLoDF1f7W/
         R35XM1IWq6ixJL+0jM9bTij/jVOcbkMx4yAHqeGqFt+iR4V6R7F6zupf/DbtEY1W4X3a
         dzs1lhQ3jN3AvOcS21jN/1fzwfXbNqBluhHo+ZCxOfxiCP6HXvMdq7Zudk57oJnw3Du0
         5EFSD2yNMwDYh9SndEOjRi06XhyMjJiGLgMbm/JXm+SYQlvOV+7t87XeW/MRtTSQOwZ9
         +k5oobwAV02QWccnYRM74sxPsc9wWfA1z2ENYVbHKueUesZzz9LdUmTcZn6r60rHQR/V
         s+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U3co7hSqrGHY3Lrjumnk8hajraD3kysX3pV8Vd7qSPM=;
        b=nFhQq4+iEPRZb7U9ctWytz862UXqIWRzscCY88ZRzOp0MqdwT8O0gCBrLPqBxdtfr3
         kL9b0HMsMdyvsOmUb50mLxQbru9KInggwDpB81eNBuVPnT6Mq3CHDaIdmHYJxnw7vG2D
         kTKeNhbUngQ4lRykzSGOpo6lyIY32DPmAR9GJPMiAA7Am42UJQVosaWNIMHYzmkhROfr
         jupe/OZW2B10L4nBFb3EWr5t+UTzFGnS5DvDzJLwQXLWyn0TqdO9+gwolWQvfbm8M/H2
         0Ax0u0lfBVKU8Ilo0LxsRt4TDtb8KxjTmpSIGKssOrNBeIQ2C8FMc57bI/lEbwMLoXBK
         GCfg==
X-Gm-Message-State: AMCzsaUZlD4tx644CukCWcjBe9YsfwKzuLaFhJF5USPRgfKNeq404Atv
        K/ySnSE2zJLijEFPLAHrzwM=
X-Google-Smtp-Source: AOwi7QAlKiklgHDPF6cKEcdfB2Y1NDk+WpFVAFgAjw4CxCjYC4s1wzOhrdizmWKn1ECEX70UD+GZOg==
X-Received: by 10.99.111.194 with SMTP id k185mr3215665pgc.424.1507327168949;
        Fri, 06 Oct 2017 14:59:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:78c3:3d0d:a9b5:4320])
        by smtp.gmail.com with ESMTPSA id p77sm5579822pfa.92.2017.10.06.14.59.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 14:59:27 -0700 (PDT)
Date:   Fri, 6 Oct 2017 14:59:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] tests: use shell negation instead of test_must_fail
 for test_cmp
Message-ID: <20171006215926.GY19555@aiede.mtv.corp.google.com>
References: <20171006190006.19623-1-sbeller@google.com>
 <20171006192252.3a27enzim5yurhe5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006192252.3a27enzim5yurhe5@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Fri, Oct 06, 2017 at 12:00:05PM -0700, Stefan Beller wrote:

>> The `test_must_fail` should only be used to indicate a git command is
>> failing. `test_cmp` is not a git command, such that it doesn't need the
>> special treatment of `test_must_fail` (which e.g. includes checking for
>> segfault)
>
> Hmph. "test_must_fail test_cmp" is a weird thing for somebody to write.
> And your patch is obviously an improvement, but I have to wonder if some
> of these make any sense.

Just for the record: I agree with all the above, and my Reviewed-by
still stands.

Thanks for looking closer.  I wonder if there's a systematic way to
avoid this kind of weak test that can bitrot and still pass too easily
--- e.g. should we have a test_must_differ command with an explanation
of why it should usually be avoided?  Would a lint check that bans
this kind of construct completely be going too far?

Jonathan
