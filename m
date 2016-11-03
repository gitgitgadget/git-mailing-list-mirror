Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB80D2021E
	for <e@80x24.org>; Thu,  3 Nov 2016 17:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758913AbcKCRZS (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 13:25:18 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36606 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755776AbcKCRZS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 13:25:18 -0400
Received: by mail-pf0-f176.google.com with SMTP id 189so35029009pfz.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hpdp/p5vWgA428MjTLWCzfvNZg/l26Tk76zBjTsKtL8=;
        b=HE9WuqSaBW4V1fMCDo0GrRcYR9/YKYUjdnDxLTW8UVjRMsHD6BTkwoBOYYpVziMZqR
         jDW68NKsEnsSV6g7DsloR3MI1jwVBnN36LxDF8QCbsupvUxHRO0bmx9EsyY66Gvfiydb
         RRoXFle7vseYa9qMgl/MPCXocP658BtqcZKmHVpivbnLqFon1h6ANIQk16HLd13CshJg
         A6D4Smy2W7gnaWi8DiUgGwivlYa1sVv3MIpdjajqiZewJekJt+zIE6RSweS5S12PcK3A
         DEj0G9ElQV8lp6LjyqXDhquvGRI0TV41/+3dVZolclahHOeb6hwclJpB72K7L1mdSwfG
         YYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hpdp/p5vWgA428MjTLWCzfvNZg/l26Tk76zBjTsKtL8=;
        b=C6+0QEfHaKgkhV4O+5CEh63GdAnRMrhmRZDBItFf4QdYwosLhIXnlwADHsXKiaXpxT
         cxGEwW33SwFkoLHYuBiqHgBfBDuUKKwxUg50uPhvHwvxXBVMj3GmaPs1KdAV03onSRnl
         wCTnssZxOCVh2ldYup1YUOKCLebJPL4oNVO81wDQEBSA7I21Jp9J4FFWVovhEVVu4dxt
         pqlUORZmauq6GQVL9MbwPOrDvAFwxbWZoYebNh11ztEaUk5OXS6fdR01tQiOuQ1LUBUc
         HXwIUNR/TXZK3woKUrCg6LMh5nR2hPRAIdtD7Jgr5aYkI+FzY2C+egQSrROXTTTgaMww
         99zw==
X-Gm-Message-State: ABUngvf6arABI8PKRokv+qmW4KrW8e/GHBZveUIMiWkKqvrGLxh7UkvwWp+FfTKIy0RYQ5lN
X-Received: by 10.99.1.23 with SMTP id 23mr15445522pgb.37.1478193917028;
        Thu, 03 Nov 2016 10:25:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b42d:d807:c3e3:2b82])
        by smtp.gmail.com with ESMTPSA id fm6sm14156367pab.37.2016.11.03.10.25.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Nov 2016 10:25:16 -0700 (PDT)
Date:   Thu, 3 Nov 2016 10:25:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103172515.GA182568@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
 <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/03, Jeff King wrote:
> On Wed, Nov 02, 2016 at 05:22:25PM -0700, Jonathan Nieder wrote:
> 
> > Another difficulty with setting GIT_ALLOW_PROTOCOL globally is that it
> > requires copy/pasting the default value from upstream and then adding
> > the values I want.  There's no straightforward way to get the current
> > value and add to it, in case I want to benefit from future upstream
> > fixes to the default list.
> 
> I agree that this is a big drawback of the current scheme, and it would
> be nice to be able to say "also allow".
> 
> > That is, would it be possible to use something like
> > 
> > 	[protocol "sso"]
> > 		allow = always
> > 
> > instead of
> > 
> > 	[core]
> > 		allowProtocol = file:git:http:https:....:sso
> > 
> > ?
> 
> One complication is that the whitelist has multiple states:
> 
>   1. if it's not used at all, anything goes
> 
>   2. if it exists and has zero or more entries, only those entries are
>      allowed
> 
> And then submodules are an exception to (1), because it's not anything
> goes. It's "this default safe whitelist".
> 
> So when does protocol.sso.allow kick in? We wouldn't want it to trigger
> case (2) for things like fetch (disabling other non-allowed protocols).
> Nor do I think we'd only want it for the submodule case, as I would
> assume that "protocol.sso.allow = false" should disable it.
> 
> So I think this probably needs to be a separate parallel system where
> each protocol can be white- or black-listed in a context-specific way.
> Like:
> 
>   protocol.X.allow = always | user | never

It sounds like there is interest for this sort of behavior, it would
definitely require a larger change than what I initially proposed.  One
problem I see though is that with this we have support for both a
blacklist and a whitelist.  Which wins?  Or do we simply generate a
whitelist of allowed protocols which includes all protocols with allow
set to 'always' and if it is set to 'never' then it just isn't included
in the whitelist?

I don't know if I'm sold on a 'user' state just yet, perhaps that's just
because I view a whitelist or blacklist as well black and white and
having this user state adds in a gray area.

> > An example approach would be a GIT_ALLOW_PROTOCOL var returned by
> > "git var".
> > 
> > That way git-submodule.sh could do
> > 
> > 	: ${GIT_ALLOW_PROTOCOL=$(git var GIT_ALLOW_PROTOCOL)}
> > 
> > and it would just work.  Other tools could do the same, with a
> > fallback to the current default until new enough git is in widespread
> > use.
> 
> ...some automated way to say "is this protocol supported"? I think it is
> not just "give me ALLOW_PROTOCOL" anymore, though, but "apply your rules
> to this protocol, and tell me if it is supported".

I agree, if we do add different states to a protocol then we couldn't
simply ask for a whitelist/blacklist of protocols anymore since its more
of a graylist :) (if such a thing exits). 

-- 
Brandon Williams
