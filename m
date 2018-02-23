Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CCE1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 21:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeBWVqC (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 16:46:02 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:37384 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeBWVqB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 16:46:01 -0500
Received: by mail-pl0-f47.google.com with SMTP id ay8so5621517plb.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 13:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X2QpULKDV5sax5sSMNfX7VE9CZmKRCHbrrSbgYMxITU=;
        b=BCJ+tnZ1ar+rsBAUwU7vHYHWefwSQcyeixJ3Nl3wyhH8FUymWBIntVpAqaN3vlSWce
         pPdqsWz1aZxRHZHq41wkHAKZyKzYohn3yadZ+JgLqmM82Pw96x842VJZk8RgC8g9Vs5S
         FHkDFHXkvktGq15toU/sRuYQXeuWTNAOwITrrRBD5UUkYJ8AX975A/y/jEWqtbZQzFKm
         QO+El9bZqVPNr22LZycWxA7GZgGkd8qnXwE3MwAN8BNuQ9VhMxZnuvSSo2OxCdrq6HbG
         jf+QwKD+9MbEWPxccIEoqPouBoJv+eCJEaK3BFshhPZnobhCFV3aP7ri0VsF/DY7giBp
         L8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X2QpULKDV5sax5sSMNfX7VE9CZmKRCHbrrSbgYMxITU=;
        b=VI8Y+ds3FabOj8Mp62buddn/fBDNWwh9/NmypMTCCzWi8+Y4qhULtqnJl6z5PHxQAN
         ZrMz68nOOcEUjwZ6Ku43COpTD6ZtUQcKtQPZt5hA1phzwt0D4fcnMsIHaAF3YykPEI3v
         c+MO+ptrC1Pha+YHdJH2GrvI66UALHW735216HfLTjAIvkQE/ZfXv8t365kfN9/D1C6u
         7t+2SY2L76jLeFa5Qt0PaQc0yMPIHL/0NG9uZisHRVKXe5JI8fHw8Q+EYsQtUm3N55w8
         GcLzjf2J3bVye4Pzar/9N/89wyVMosORy409szH/RK6BktMj7u9fAbIGpikNiFqREh95
         ivZA==
X-Gm-Message-State: APf1xPDhT+HPkLjRlB7Dwd4IN5ZudkQmoI3JWGyeVuIvjceaztEc1zc1
        RqWfqsbHK7FSGwsHjVQ3D+4mpw==
X-Google-Smtp-Source: AH8x22575kkzns3KzabgYzt1OzmPBP9O6GB9unsomEgbE9XWx8YAFY/o3G2gA23GNbd+fWxsshcegQ==
X-Received: by 2002:a17:902:ab88:: with SMTP id f8-v6mr2991361plr.325.1519422360241;
        Fri, 23 Feb 2018 13:46:00 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q76sm7173335pfj.149.2018.02.23.13.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 13:45:59 -0800 (PST)
Date:   Fri, 23 Feb 2018 13:45:57 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 12/35] serve: introduce git-serve
Message-ID: <20180223214557.GF234838@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-13-bmwill@google.com>
 <20180222093327.GA12442@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222093327.GA12442@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22, Jeff King wrote:
> On Tue, Feb 06, 2018 at 05:12:49PM -0800, Brandon Williams wrote:
> 
> > +In protocol v2 communication is command oriented.  When first contacting a
> > +server a list of capabilities will advertised.  Some of these capabilities
> > +will be commands which a client can request be executed.  Once a command
> > +has completed, a client can reuse the connection and request that other
> > +commands be executed.
> 
> If I understand this correctly, we'll potentially have a lot more
> round-trips between the client and server (one per "command"). And for
> git-over-http, each one will be its own HTTP request?
> 
> We've traditionally tried to minimize HTTP requests, but I guess it's
> not too bad if we can keep the connection open in most cases. Then we
> just suffer some extra framing bytes, but we don't have to re-establish
> the TCP connection each time.
> 
> I do wonder if the extra round trips will be noticeable in high-latency
> conditions. E.g., if I'm 200ms away, converting the current
> ref-advertisement spew to "capabilities, then the client asks for refs,
> then we spew the refs" is going to cost an extra 200ms, even if the
> fetch just ends up being a noop. I'm not sure how bad that is in the
> grand scheme of things (after all, the TCP handshake involves some
> round-trips, too).

I think this is the price of extending the protocol in a backward
compatible way.  If we don't want to be backwards compatible (allowing
for graceful fallback to v1) then we could design this differently.
Even so we're not completely out of luck just yet.

Back when I introduced the GIT_PROTOCOL side-channel I was able to
demonstrate that arbitrary data could be sent to the server and it would
only respect the stuff it knows about.  This means that we can do a
follow up to v2 at some point to introduce an optimization where we can
stuff a request into GIT_PROTOCOL and short-circuit the first round-trip
if the server supports it.

> 
> > + Capability Advertisement
> > +--------------------------
> > +
> > +A server which decides to communicate (based on a request from a client)
> > +using protocol version 2, notifies the client by sending a version string
> > +in its initial response followed by an advertisement of its capabilities.
> > +Each capability is a key with an optional value.  Clients must ignore all
> > +unknown keys.  Semantics of unknown values are left to the definition of
> > +each key.  Some capabilities will describe commands which can be requested
> > +to be executed by the client.
> > +
> > +    capability-advertisement = protocol-version
> > +			       capability-list
> > +			       flush-pkt
> > +
> > +    protocol-version = PKT-LINE("version 2" LF)
> > +    capability-list = *capability
> > +    capability = PKT-LINE(key[=value] LF)
> > +
> > +    key = 1*CHAR
> > +    value = 1*CHAR
> > +    CHAR = 1*(ALPHA / DIGIT / "-" / "_")
> > +
> > +A client then responds to select the command it wants with any particular
> > +capabilities or arguments.  There is then an optional section where the
> > +client can provide any command specific parameters or queries.
> > +
> > +    command-request = command
> > +		      capability-list
> > +		      (command-args)
> > +		      flush-pkt
> > +    command = PKT-LINE("command=" key LF)
> > +    command-args = delim-pkt
> > +		   *arg
> > +    arg = 1*CHAR
> 
> For a single stateful TCP connection like git:// or git-over-ssh, the
> client would get the capabilities once and then issue a series of
> commands. For git-over-http, how does it work?
> 
> The client speaks first in HTTP, so we'd first make a request to get
> just the capabilities from the server? And then proceed from there with
> a series of requests, assuming that the capabilities for each server we
> subsequently contact are the same? That's probably reasonable (and
> certainly the existing http protocol makes that capabilities
> assumption).
> 
> I don't see any documentation on how this all works with http. But

I can add in a bit for the initial request when using http, but the rest
of it should function the same.

> reading patch 34, it looks like we just do the usual
> service=git-upload-pack request (with the magic request for v2), and
> then the server would send us capabilities. Which follows my line of
> thinking in the paragraph above.

Yes this is exactly how it should work.  First we make an info/refs
request and if the server speaks v2 then instead of a refs request we
should get back a capability listing.  Then subsequent requests are made
assuming the capabilities are the same like we've done with the
existing protocol.

The great thing about this is that from the POV of the git-client, it
doesn't care if its speaking using the git://, ssh://, file://, or
http:// transport; it's all the same protocol.  In my next re-roll I'll
even drop the "# service" bit from the http server response and then the
responses will truly be identical in all cases.

-- 
Brandon Williams
