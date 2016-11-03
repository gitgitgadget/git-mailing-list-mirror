Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A952021E
	for <e@80x24.org>; Thu,  3 Nov 2016 17:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759749AbcKCRvh (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 13:51:37 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34510 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759734AbcKCRvf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 13:51:35 -0400
Received: by mail-pf0-f171.google.com with SMTP id n85so35334559pfi.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zk8sOOZMb4AXlPwlYTUrMhrGDUUW45SZEuXxPpt8Z7M=;
        b=kZUmvp1FaZi0y88HOf8/7inbFWG9LlSDFmF3yyv8w0ZxFBHJU9QCDkOMq9q2zLrzeJ
         1qj7+6GxpXCDIDR4cuSaPMj6yPZLlPqgAtZv7MWhvqrttyr9wz4VOxbL5fqUdzJuHywy
         LkQXL7RMy9U0ZO1pn+TNwBZR1rXSJm7t2K8clV89CgH6pICTn9E2g/of33NJjfCwmGZL
         6Z9cTIpEKC9FK3zKhr7hnYkdDOy+1Lsh936oeohlOn6ltSXnrVGbflekXIw2msJzq7/V
         zz4t54+h0KNu98EDMOtH44EW+aYaEwH/1rqExmTr+X/RMlw01GyTdGDQEIohXhcYGKHM
         lnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zk8sOOZMb4AXlPwlYTUrMhrGDUUW45SZEuXxPpt8Z7M=;
        b=FSCel2BUXerex7MtSf7ha+YiwxbfG55BxMn3WG56tllq1eDCMzFQc+CsRypUY8xwbM
         7nu24sr8uWX7ukCkvn+eVjqJ19bRMqQSkvqZmBzGnf7pUSAUf1VFZ7EutG0TrlJZWW/j
         g4XXw5c11C30nDYczIXb2jG8EXn2WD1WqFL2Z4Fs/x3xvR5fMV0SvveVfWvSsLLvPwTq
         784RY62jjDiv3rR/XPq3PebzCVbVbJk0gsnikkwQ82W8FN2HUIapFOCU2eHNWITKi1Eh
         hJjclBx3YJgv0RS3n1N5pihvNkWOfefZqkQaqsEVbPgLu1+73qtqV/KEhK6P6tHgefjr
         mObA==
X-Gm-Message-State: ABUngvfeVimxVbcmCicHvPWW0FUKTKTaDEcmcjwlAWdl0Ap2a0qLStfmRfuIF242vTDUlorK
X-Received: by 10.99.133.200 with SMTP id u191mr15769504pgd.28.1478195494136;
        Thu, 03 Nov 2016 10:51:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b42d:d807:c3e3:2b82])
        by smtp.gmail.com with ESMTPSA id v4sm14240140pfb.52.2016.11.03.10.51.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Nov 2016 10:51:33 -0700 (PDT)
Date:   Thu, 3 Nov 2016 10:51:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103175131.GB182568@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
 <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
 <20161103172515.GA182568@google.com>
 <CAGZ79kbvs+ryGRjCkHYO=3iNK4tPPhBhYjRMZaH7rP0QMrULhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbvs+ryGRjCkHYO=3iNK4tPPhBhYjRMZaH7rP0QMrULhg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/03, Stefan Beller wrote:
> >>   protocol.X.allow = always | user | never
> >
> > It sounds like there is interest for this sort of behavior, it would
> > definitely require a larger change than what I initially proposed.  One
> > problem I see though is that with this we have support for both a
> > blacklist and a whitelist.  Which wins?
> 
> For the submodule operations we'll use a whitelist, because we want to
> provide security and for the other case we can offer a blacklist as a bandaid.
> 
> My opinion on blacklists is roughly aligned with e.g. :
> https://blog.codinghorror.com/blacklists-dont-work/
> http://blog.deepinstinct.com/2016/02/04/when-blacklists-dont-really-work/
> 
> So IMHO we could drop the "never" and substitute it with a "warn" or
> "ask-user", such that this configuration becomes a white list for both cases:
> 
>      protocol.X.allow = always | user | warn
> 
> > Or do we simply generate a
> > whitelist of allowed protocols which includes all protocols with allow
> > set to 'always' and if it is set to 'never' then it just isn't included
> > in the whitelist?
> 
> So you're suggesting that setting it to "never" doesn't have any effect
> except for cluttering the config file?
> I don't think we should do that; each setting should have an impact.
> So maybe the "never" would be there to disallow protocols of the hardcoded
> white list (e.g. http)

Thats what I meant, if a protocol is listed as 'never' then it just
removes that protocol from the whitelist.  That way we still have the
benefit of using a whitelist vs a blacklist.  Also, if we move in this
direction should we setup a default whitelist of allowed protocols?

> >
> > I don't know if I'm sold on a 'user' state just yet, perhaps that's just
> > because I view a whitelist or blacklist as well black and white and
> > having this user state adds in a gray area.
> 
> Well the "user" state is to differentiate between the
> * "I consciously typed `git clone ...` (and e.g. I know what happens as
>   I know the server admin and they are trustworthy.)
> * a repository contains a possible hostile .gitmodules file such
>   that I am not aware of the network connection.

This is still a gray area to me.  I think that if we have a whitelist of
protocols then it should be a true whitelist and not have some means of
going around it.  It just seems like something that could be exploited.

-- 
Brandon Williams
