Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98501F404
	for <e@80x24.org>; Wed,  7 Feb 2018 00:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932180AbeBGA6Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 19:58:24 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34063 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932142AbeBGA6X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 19:58:23 -0500
Received: by mail-pg0-f49.google.com with SMTP id s73so1843807pgc.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 16:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZGQcPOlvsCVH7nuZRNjBLC6EdF80i4F273Awb/Y8UvM=;
        b=UCc4vqE+l7JxSf3AGMvDA4YwLla8vkt6W3FtqTw8DUUjZ2VqpnIlN67M8q1xtEO+Z+
         L1X6VVLOX+dqgJNJW1XYrQaKmlShz7UCyRjBw8oldv8MpcqxozkZw+ZYWDYIMpAVodXl
         7LuyKDtKUV4NydwTlmbuWv5Qc2VOVOz3yz2PUuv6YlqrEj/UPbLuMqbKM14AVg2ndImA
         KsCywq+GHUH4WJnXpp2DjBkp/wE439DrsI7BEFOVu7jFTdzVaTVD29U1KTalSlbBAy3H
         f0k8yDJtEOyVucaz3O+8A63zyUV75EajRWUuOQxtiimot9xRHj4u3F42XOLt/Rez0yOh
         pK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZGQcPOlvsCVH7nuZRNjBLC6EdF80i4F273Awb/Y8UvM=;
        b=oQMXBlIzJ+0dCL9Ba+c4n/N2YJhQlDJ6AjogSFzxHqj1YXs6YuAH5HhJAYaMcDqwqP
         TtXTXMpG6NHV7JdXjtfGCunfVDw4SnTi+PjWV32U2rFJpDbKppNgs/9FT7qiO5sBnH9D
         nQScj1hRzWxtVcGy36qSIsHfoBOvELMQvQBiCWZPDB1xTq7XUqFiWNqFTgrns/WLOIyf
         L5JpGzwluFwdqWtHpAd3amOahbyJmStNC6kqo17Xx69P0uSnnpRGeF1Q6X/h3rSQ5UOg
         yTl/wjOG3VbDDlXX7xd9zeK7cIGSRWUgok8GixZByivNUZ5K21zPaTG1cL3IHEHDgdCg
         u5Hw==
X-Gm-Message-State: APf1xPAW6e4SxHxo+Azt7peYtH23b+a/Mp1W9QRatGPr5zx4I9aZhxCV
        G1o6eBpx+JrIM8Lag+xJudwHBQ==
X-Google-Smtp-Source: AH8x226w7DKrTWqG2+qFrFbXGVTrbJzriSRek7NhflrMiW/6DQ/fxFTW2drosIMlOuflQdnX5HhZSw==
X-Received: by 10.99.107.200 with SMTP id g191mr3327327pgc.165.1517965102617;
        Tue, 06 Feb 2018 16:58:22 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a84sm397946pfc.116.2018.02.06.16.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Feb 2018 16:58:21 -0800 (PST)
Date:   Tue, 6 Feb 2018 16:58:20 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 00/27] protocol version 2
Message-ID: <20180207005820.GB222904@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
 <56044237-4086-faeb-730e-807858a082a8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56044237-4086-faeb-730e-807858a082a8@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/31, Derrick Stolee wrote:
> Sorry for chiming in with mostly nitpicks so late since sending this
> version. Mostly, I tried to read it to see if I could understand the scope
> of the patch and how this code worked before. It looks very polished, so I
> the nits were the best I could do.
> 
> On 1/25/2018 6:58 PM, Brandon Williams wrote:
> > Changes in v2:
> >   * Added documentation for fetch
> >   * changes #defines for state variables to be enums
> >   * couple code changes to pkt-line functions and documentation
> >   * Added unit tests for the git-serve binary as well as for ls-refs
> 
> I'm a fan of more unit-level testing, and I think that will be more
> important as we go on with these multiple configuration options.
> 
> > Areas for improvement
> >   * Push isn't implemented, right now this is ok because if v2 is requested the
> >     server can just default to v0.  Before this can be merged we may want to
> >     change how the client request a new protocol, and not allow for sending
> >     "version=2" when pushing even though the user has it configured.  Or maybe
> >     its fine to just have an older client who doesn't understand how to push
> >     (and request v2) to die if the server tries to speak v2 at it.
> > 
> >     Fixing this essentially would just require piping through a bit more
> >     information to the function which ultimately runs connect (for both builtins
> >     and remote-curl)
> 
> Definitely save push for a later patch. Getting 'fetch' online did require
> 'ls-refs' at the same time. Future reviews will be easier when adding one
> command at a time.
> 
> > 
> >   * I want to make sure that the docs are well written before this gets merged
> >     so I'm hoping that someone can do a through review on the docs themselves to
> >     make sure they are clear.
> 
> I made a comment in the docs about the architectural changes. While I think
> a discussion on that topic would be valuable, I'm not sure that's the point
> of the document (i.e. documenting what v2 does versus selling the value of
> the patch). I thought the docs were clear for how the commands work.
> 
> >   * Right now there is a capability 'stateless-rpc' which essentially makes sure
> >     that a server command completes after a single round (this is to make sure
> >     http works cleanly).  After talking with some folks it may make more sense
> >     to just have v2 be stateless in nature so that all commands terminate after
> >     a single round trip.  This makes things a bit easier if a server wants to
> >     have ssh just be a proxy for http.
> > 
> >     One potential thing would be to flip this so that by default the protocol is
> >     stateless and if a server/command has a state-full mode that can be
> >     implemented as a capability at a later point.  Thoughts?
> 
> At minimum, all commands should be designed with a "stateless first"
> philosophy since a large number of users communicate via HTTP[S] and any
> decisions that make stateless communication painful should be rejected.

I agree with this and my next version will run with this philosophy in
mind (v2 will be stateless by default).

> 
> >   * Shallow repositories and shallow clones aren't supported yet.  I'm working
> >     on it and it can be either added to v2 by default if people think it needs
> >     to be in there from the start, or we can add it as a capability at a later
> >     point.
> 
> I'm happy to say the following:
> 
> 1. Shallow repositories should not be used for servers, since they cannot
> service all requests.
> 
> 2. Since v2 has easy capability features, I'm happy to leave shallow for
> later. We will want to verify that a shallow clone command reverts to v1.
> 
> 
> I fetched bw/protocol-v2 with tip 13c70148, built, set 'protocol.version=2'
> in the config, and tested fetches against GitHub and VSTS just as a
> compatibility test. Everything worked just fine.
> 
> Is there an easy way to test the existing test suite for clone and fetch
> using protocol v2 to make sure there are no regressions with
> protocol.version=2 in the config?

Yes there already exist interop tests for testing the addition of
requesting a new protocol at //t/interop/i5700-protocol-transition.sh

> 
> Thanks,
> -Stolee

-- 
Brandon Williams
