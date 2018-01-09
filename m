Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E99E1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 22:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753774AbeAIWe7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 17:34:59 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:43706 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbeAIWe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 17:34:58 -0500
Received: by mail-pg0-f43.google.com with SMTP id f14so6412031pga.10
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 14:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5J10X7UX+21kaqR0whzSuwINvzVz2ixzmKLges3/+b4=;
        b=TxD7h/qlsVgHbN9pxR14zYeb2FcMlTZwT+ykE4n4952zNEc5P2u1GLBe7HBjV5XIle
         lB36ri+YTaYeRoG4iUpJJJigWn7Ky3qZ30jYikDVFiZBVjmPzxVGd++7SF3ycTLYD5rT
         1tUuBaGZW6E3zb5t7i8TojJbV0PrIZTLOyo8IhWRFEuC2BbD3kXTJcMjTq8LzggRVJmD
         LJlBpO1p27J7tDSVPgWJptojTUcrnPfXbpJ15AZ4uLffXAdVWkHbQZk3OsF4HEQqZPmr
         ny3jfVSJVB+Xfx+r9WVt66OvYXi25XwwUQU7k+Cvp7/9kMExjWDbj8GkMHwaN8rhs+xK
         tkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5J10X7UX+21kaqR0whzSuwINvzVz2ixzmKLges3/+b4=;
        b=BdnIy2MMRi6E8gPS9R6judrYedoS2L3Qbd8kcm40C7ctR0qBUWATerpn+jsLe9ZOQq
         J9aN/ofy+89jwhThOaBNdCRK705Ky+feAIRx6zLmjAUMrda4Si4zrLPeXKKgB8bQOIH8
         0JCE7LcSIW9TpBOYZvnjB3GVDLvvlKzNGW5H2wFxhMdAYc3eKU9SK5Y5z/iPGiu8hnzz
         /umGpxioAAMXKLQ9RUI0xM2Ylk5CTQWvG3I2zwhERXLfnZYjMtymm5tf5q1bl0Ni3oC/
         hdTYDfhRr+LaK92kmK1zEzVlcik7b+VVlr4osdVZZBTHBPZKXimYqo6Rgzyyk2A3YDjN
         uQ7A==
X-Gm-Message-State: AKGB3mLO6ydcPQEL2L+k1l0D3hCw04eNEs38pmXlHzvUr76CcrEeZSRD
        D47Dw49+rsWIySXSztUucg6GKA==
X-Google-Smtp-Source: ACJfBovlLOItyxFH9kNw45OWjbQXGpZF2iQFn99LGRqzcDVMr4YZiY6LJlVXMfq0nneqnmpA6BJfcg==
X-Received: by 10.159.211.74 with SMTP id g10mr16760755plp.432.1515537297342;
        Tue, 09 Jan 2018 14:34:57 -0800 (PST)
Received: from google.com ([2620:0:100e:422:5de7:5b51:7854:d1a5])
        by smtp.gmail.com with ESMTPSA id p86sm18595057pfj.176.2018.01.09.14.34.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Jan 2018 14:34:56 -0800 (PST)
Date:   Tue, 9 Jan 2018 14:34:55 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 11/26] serve: introduce git-serve
Message-ID: <20180109223455.GG151395@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-12-bmwill@google.com>
 <20180109122455.5845c4f12ccdd4cada1528f2@google.com>
 <20180109221642.GF151395@google.com>
 <20180109142827.a2fe13a69e5240b6a12729e1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109142827.a2fe13a69e5240b6a12729e1@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09, Jonathan Tan wrote:
> On Tue, 9 Jan 2018 14:16:42 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > All good documentation changes.
> 
> Thanks!
> 
> > > > +	/*
> > > > +	 * Function called when a client requests the capability as a command.
> > > > +	 * The command request will be provided to the function via 'keys', the
> > > > +	 * capabilities requested, and 'args', the command specific parameters.
> > > > +	 *
> > > > +	 * This field should be NULL for capabilities which are not commands.
> > > > +	 */
> > > > +	int (*command)(struct repository *r,
> > > > +		       struct argv_array *keys,
> > > > +		       struct argv_array *args);
> > > 
> > > Looking at the code below, I see that the command is not executed unless
> > > advertise returns true - this means that a command cannot be both
> > > supported and unadvertised. Would this be too restrictive? For example,
> > > this would disallow a gradual across-multiple-servers rollout in which
> > > we allow but not advertise a capability, and then after some time,
> > > advertise the capability.
> > 
> > One way to change this would be to just add another function to the
> > struct which is called to check if the command is allowed, instead of
> > relying on the same function to do that for both advertise and
> > allow...though I don't see a big win for allowing a command but not
> > advertising it.
> 
> My rationale for allowing a command but not advertising it is in the
> paragraph above (that you quoted), but if that is insufficient
> rationale, then I agree that we don't need to do this.

I have no issues with adding that functionality, i don't really feel
that strongly one way or another.  Just seemed like additional work for
not much gain right now, key being right now.  It very well may be worth
it for the use case you specified.  If so I can definitely make the
change.

> 
> > > If we change this, then the value parameter of advertise can be
> > > mandatory instead of optional.
> > 
> > I don't see how this fixes the issue you bring up.
> 
> This is a consequence, not a fix - if we were to do as I suggested, then
> we no longer need to invoke advertise to check whether something is
> advertised except when we are advertising them, in which case "value"
> never needs to be NULL.

Oh I understand what you are trying to explain, yes you're right.

-- 
Brandon Williams
