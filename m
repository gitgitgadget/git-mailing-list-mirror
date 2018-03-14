Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BD491F404
	for <e@80x24.org>; Wed, 14 Mar 2018 17:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeCNRg4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 13:36:56 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:44031 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeCNRgz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 13:36:55 -0400
Received: by mail-pg0-f45.google.com with SMTP id e9so1654957pgs.10
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0OkHvIOtpwyVfF543Yf/8ygbLKZz4iIKzNrB5Yf9D1k=;
        b=mbgmP5SgbJHEZXSFt8KawgU8PBgmecXMxYoG+1W2XbtL3oRnGRQ+TLZobCB2wjJbTH
         JHe1JS42I2EkrDioyGh+121+aTG0tch7NOEpRxFTGqk/KoLl73m5ddURvZ5nof8by+J4
         E4IqnQM+7VSmnqXFhkYWBAEDIArQwSljVL8yrPIPvGU1JNPzqIOAq/tbZX7ZVaamaTTe
         436KXLVyX7sqbY/IV/LWlv0frSsmwrgehkUOqnw0OOLaiBK2TGPhAkU88CMjcbv1LlVn
         5JxAz7rfrVVQ8T/QnK341bpQI4dMAj99jEQRUB+CZleeiRS2vpQEiCQH9XYcEtW03Yh0
         yESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0OkHvIOtpwyVfF543Yf/8ygbLKZz4iIKzNrB5Yf9D1k=;
        b=l+IebsNVGYI8mnRH2sSnd6/sUcBtHZsuq2jYUr9gcY+RigdNKN4W3ewE1gwWTzRvFL
         iRRJXqoQ3xdp29Y6Nujgf2PRo9lhkGj5HjMOMf3zxuorIXdVFGSz1t1+852HZT4R1Nxi
         /zYw1IQMgwlh8BhHZgc1Smrqbr7RPZqTyYhKEawlrK6SyDt/JbUo0TFnyuF2bEdqlHw+
         Q9ZtVKWqDrO+tSdMfuWWY6kCzU3bcsoP/elxAZB0bMsXbUzWfUApbZnFUYrTuI5K8bA7
         S5xwje5jeyAAcXH2fYPLxR73tw3Mlk//ds2dgDbj/1P8/oTsz5i33ji3OWy24x2F5ejw
         UvrA==
X-Gm-Message-State: AElRT7GUCiMQ7eZIqGtY8VJMvpQLSet2rJQZklZwvzp9sDkMkx7CjbcN
        0dUhvzILRs4VomjIv0RP2jzVZ1hqJ0w=
X-Google-Smtp-Source: AG47ELshqYR2QBkkFeNT9KHxsbdEhvpjjRKTj0CN4Cj3rdQO9dkNGVWYUgC6UjfDQVjmwmzMIh7trg==
X-Received: by 10.99.191.78 with SMTP id i14mr4229965pgo.95.1521049014400;
        Wed, 14 Mar 2018 10:36:54 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id y1sm5652853pgs.80.2018.03.14.10.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 10:36:53 -0700 (PDT)
Date:   Wed, 14 Mar 2018 10:36:52 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 27/35] transport-helper: introduce stateless-connect
Message-ID: <20180314173652.GA135110@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-28-bmwill@google.com>
 <20180313093044.69af995505d0508f8a044bff@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313093044.69af995505d0508f8a044bff@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/13, Jonathan Tan wrote:
> On Wed, 28 Feb 2018 15:22:44 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > +'stateless-connect'::
> > +	Experimental; for internal use only.
> > +	Can attempt to connect to a remote server for communication
> > +	using git's wire-protocol version 2.  This establishes a
> > +	stateless, half-duplex connection.
> > ++
> > +Supported commands: 'stateless-connect'.
> > +
> >  'push'::
> >  	Can discover remote refs and push local commits and the
> >  	history leading up to them to new or existing remote refs.
> > @@ -136,6 +144,14 @@ Capabilities for Fetching
> >  +
> >  Supported commands: 'connect'.
> >  
> > +'stateless-connect'::
> > +	Experimental; for internal use only.
> > +	Can attempt to connect to a remote server for communication
> > +	using git's wire-protocol version 2.  This establishes a
> > +	stateless, half-duplex connection.
> > ++
> > +Supported commands: 'stateless-connect'.
> 
> I don't think we should use the term "half-duplex" - from a search, it
> means that both parties can use the wire but not simultaneously, which
> is not strictly true. Might be better to just say "see the documentation
> for the stateless-connect command for more information".
> 
> > +'stateless-connect' <service>::
> > +	Experimental; for internal use only.
> > +	Connects to the given remote service for communication using
> > +	git's wire-protocol version 2.  This establishes a stateless,
> > +	half-duplex connection.  Valid replies to this command are empty
> > +	line (connection established), 'fallback' (no smart transport
> > +	support, fall back to dumb transports) and just exiting with
> > +	error message printed (can't connect, don't bother trying to
> > +	fall back).  After line feed terminating the positive (empty)
> > +	response, the output of the service starts.  Messages (both
> > +	request and response) must be terminated with a single flush
> > +	packet, allowing the remote helper to properly act as a proxy.
> > +	After the connection ends, the remote helper exits.
> > ++
> > +Supported if the helper has the "stateless-connect" capability.
> 
> I'm not sure of the relevance of "allowing the remote helper to properly
> act as a proxy" - this scheme does make it easier to implement proxies,
> not for any party to start acting as one instead. I would write that
> part as:
> 
>     Messages (both request and response) must consist of zero or more
>     PKT-LINEs, terminating in a flush packet. The client must not expect
>     the server to store any state in between request-response pairs.
> 
> (This covers the so-called "half-duplex" part and the "stateless" part.)

Thanks for helping wordsmith this, I'll update the docs based on these
suggestions.

-- 
Brandon Williams
