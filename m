Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12851F404
	for <e@80x24.org>; Mon, 10 Sep 2018 17:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeIJWJ3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 18:09:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41694 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 18:09:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so10798470pgv.8
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 10:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QfjtUDNb/1+Vv07Iu625752onQSttsQwf7ZMUP8uPKk=;
        b=gffwbz4EEfbJZw/BzM0V8sUr/IVUS/z/ZDBPpBjIfcqgE7RbI2bBKRWHgT9RlY0OvD
         4jpE6RE+C5DdU3kHXgpjZtBG6XyC4QEY288XtCUD4SF53YpTw/p4zwHGR/nlmXkgnpMr
         wNjY6JLhrRl1Cyc2tgLuV3rTbeB5t0BJltU2HRcvmFuvRUsxwzQ5cwvsYa8nfQU8v4jj
         XhJ3MZzehXZv1noJE4Cv2yTgvIHktwE7xhERexnZsk5VD/iDtgf+ZsFTNA2iMNa5f8yA
         t/LW4QXgejWFFkB+u0+bFVFor09FXZW1pN9xrtnOw7wtncEcKQQp64aPlfnoNmsR6Lvt
         zBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QfjtUDNb/1+Vv07Iu625752onQSttsQwf7ZMUP8uPKk=;
        b=VqZhwl+0sglbpdWaXL7zGSPmj62RcFgsNuqh4J0/fXVRqJdH1LWPOUacZeec8tWL50
         OoFbcbkSPT/3161JovpRxf1ibNwyRpWkqhuB1YGaXqROGrEsotY6miP9l5u9NStuCTt0
         eFG3hM5Pe6/B0+gjkYpuc0cE6/0A1EaQ4TaIeD9ONyK7ksUJlPt0j1Uzv4EWKIZx5zb+
         5mYSkOo9dGZtt1JizU4VAf2ywZ2lwLFFoka+xE+O6hz/z389rnRzp8D8pqCybfpIhiOp
         wgoKQkzlDW8/K+WBg9St0iRz5IxaXjOI/ZymIW7A/+bYy9P380lvlp2ubXMQjeZ/EI3o
         VkNA==
X-Gm-Message-State: APzg51DMxSly+qH8VT0/NBJ5WXDPSxXZSc9fXTrgQ0F6EVKC1giA8fUs
        cYkKujB6PEJThxtNPxxQBmpOQRYF
X-Google-Smtp-Source: ANB0VdYu4QFZ8u9jNX7FrJKHGyehV9skdVrRPXZzCKDvS7cWJV7qe1WO8zx+mLBtyy9SrFU7hdazCg==
X-Received: by 2002:a62:3545:: with SMTP id c66-v6mr24675196pfa.63.1536599665122;
        Mon, 10 Sep 2018 10:14:25 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id w16-v6sm29365351pfi.101.2018.09.10.10.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 10:14:24 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:14:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stas Bekman <stas@stason.org>,
        git@vger.kernel.org
Subject: Re: git silently ignores include directive with single quotes
Message-ID: <20180910171422.GA26356@aiede.svl.corp.google.com>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <20180908212256.GB31560@sigill.intra.peff.net>
 <xmqqr2i1thbs.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2i1thbs.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:

>> So I think it's been covered elsewhere that single quotes aren't a thing
>> in git's config format. I will say that this was actually a minor
>> surprise to me, after a decade of working with the format. ;)
>>
>> I don't know if it's worth changing now or not It would be
>> backwards-incompatible, but I wonder if we could do it in a sane way.
>> E.g., with a rule like:
>>
>>   - if the first non-whitespace character of the value is a
>>     single-quote, assume the value is quoted and apply normal shell
>>     rules (i.e., no backslash escapes until the ending single-quote)
>>
>>   - otherwise, single-quotes are not special at all
>
> At least the rule would not force those with ' in the middle of
> their family names to surround the user.name with extra double
> quotes, and it would probably be a good and safe practical solution.
> Being safe "by magic" tend to become hard to explain, but in this
> case the magic part is probably still simple enough.

Given that today,

	git config foo.bar "'baz'"

produces

	[foo]
		bar = 'baz'

I don't think this would be safe to do.  Since the underlying problem
is that the latter syntax is confusing, I wonder if we can do the
following:

 1. Treat single-quote as worth quoting in config.c::write_pair (line
    2516).  This would already help with the original issue, since the
    config would say

	[foo]
		bar = \'baz\'

    allowing a quick diagnosis.

 2. (optional) Warn if a value is surrounded in single-quotes,
    encouraging using backslash to disambiguate.

 3. (optional) Error out if a value is surrounded in single-quotes,
    encouraging using double-quote or backslash, depending on the
    user's intention.

 4. (optional) Start treating wrapping single-quotes specially
    somehow.

I think step 1 is a good idea, but I'm not convinced about any of the
later steps.

I also agree with the comments upthread about wanting a way to do a
'[include] path' that errors out if the file doesn't exist, and maybe
even starting a transition to repurpose standard [include] path to do
that.

Thanks,
Jonathan
