Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019D61F404
	for <e@80x24.org>; Fri, 23 Feb 2018 21:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeBWVJI (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 16:09:08 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:37769 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeBWVJH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 16:09:07 -0500
Received: by mail-pg0-f42.google.com with SMTP id y26so3815158pgv.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 13:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4xjLGeVRE6YCYD+NnO56MllVLgkidjSvxaFeA0fB9Ts=;
        b=qwu7A4vWekhcJQR1m+D6YA4GToBnKdw9yVmz7dW3UQDpWluniIXzba4Qw8YD0kBVcw
         hY9Qkw2Dcen4Y+ZIpIi2g3DUyx7LR8wBSj739ztIK+rISJnm9b0y8rIS3/L6JHvLjPsO
         /rCNP1popUoBjdH9t3wQgaiHc2SWoO12+/s1fKSZouqxcP5ezb8wCzoCYaQkXCEQesAH
         cd1N8kanFnENQSlLd61KgcAIMWbN4OyI7J/yyrvu1Q5AbVyti5mLVIwaAoWP+XCObKzx
         JQikRnogpLLTFt2AVYm8O+nJzWFrAL09K82QYJ13J04V1gNgulfhHvFrse0uI9eMK/Kz
         Cv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4xjLGeVRE6YCYD+NnO56MllVLgkidjSvxaFeA0fB9Ts=;
        b=B6z01aABvYZzMgj6AbwugSEp5xzPk+OtROLqVYTj/FwSXR++Ky6P3GJxf/L+gFFkx+
         Vmm94GQw6s6/xlSlzcSP9yDiMl+WiO+3s+1jO/tX3rqH4P+nl3m4cxHBz33uYsmnNLot
         Ewdv8dWc3vsnbAEic7RLopZzxAyH7UZgLVLrVdfRA9V97vI4IuKQMvu/QrncXhUMDJ9k
         YhvThey1i9u29OvT0mwx5YnX1XubCPBWbm2r4/zxsgY1kYCwwQUqNVlD9E4lt4zUbUvt
         jMD67eeatQYeqrBJqTxwy7dONrxNbex5iLWEHdHY/ta/CBskLE8vX2XlPPGQ9qaTw1yY
         Pzxw==
X-Gm-Message-State: APf1xPDWefJ7twY4ne/xyCbOvfNw7H6bekoxzfFv6FhTXKjlin+Gs+OS
        LTuZdFyHiNCHzDMGjA98ezgTuA==
X-Google-Smtp-Source: AH8x226Gj8RZuyoTrTisFIJ2nn/ovlDmsryMtEPf/a4TtEOflKCc7og/e14S4OFrmpRaq8lCN/qUNQ==
X-Received: by 10.99.109.70 with SMTP id i67mr2435273pgc.190.1519420146885;
        Fri, 23 Feb 2018 13:09:06 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id u85sm6582400pfi.80.2018.02.23.13.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 13:09:05 -0800 (PST)
Date:   Fri, 23 Feb 2018 13:09:04 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180223210904.GB234838@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-5-bmwill@google.com>
 <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
 <20180222202150.GA23985@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222202150.GA23985@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22, Jeff King wrote:
> On Thu, Feb 22, 2018 at 03:19:40PM -0500, Jeff King wrote:
> 
> > > To be clear, which of the following are you (most) worried about?
> > > 
> > >  1. being invoked with --help and spawning a pager
> > >  2. receiving and acting on options between 'git' and 'upload-pack'
> > >  3. repository discovery
> > >  4. pager config
> > >  5. alias discovery
> > >  6. increased code surface / unknown threats
> > 
> > My immediate concern is (4). But my greater concern is that people who
> > work on git.c should not have to worry about accidentally violating this
> > principle when they add a new feature or config option.
> > 
> > In other words, it seems like an accident waiting to happen. I'd be more
> > amenable to it if there was some compelling reason for it to be a
> > builtin, but I don't see one listed in the commit message. I see only
> > "let's make it easier to share the code", which AFAICT is equally served
> > by just lib-ifying the code and calling it from the standalone
> > upload-pack.c.
> 
> By the way, any decision here would presumably need to be extended to
> git-serve, etc. The current property is that it's safe to fetch from an
> untrusted repository, even over ssh. If we're keeping that for protocol
> v1, we'd want it to apply to protocol v2, as well.
> 
> -Peff

This may be more complicated.  Right now (for backward compatibility)
all fetches for v2 are issued to the upload-pack endpoint. So even
though I've introduced git-serve it doesn't have requests issued to it
and no requests can be issued to it currently (support isn't added to
http-backend or git-daemon).  This just means that the command already
exists to make it easy for testing specific v2 stuff and if we want to
expose it as an endpoint (like when we have a brand new server command
that is completely incompatible with v1) its already there and support
just needs to be plumbed in.

This whole notion of treating upload-pack differently from receive-pack
has bad consequences for v2 though.  The idea for v2 is to be able to
run any number of commands via the same endpoint, so at the end of the
day the endpoint you used is irrelevant.  So you could issue both fetch
and push commands via the same endpoint in v2 whether its git-serve,
receive-pack, or upload-pack.  So really, like Jonathan has said
elsewhere, we need to figure out how to be ok with having receive-pack
and upload-pack builtins, or having neither of them builtins, because it
doesn't make much sense for v2 to straddle that line.  I mean you could
do some complicated advertising of commands based on the endpoint you
hit, but then what does that mean if you're hitting the git-serve
endpoint where you should presumably be able to do any operation.

-- 
Brandon Williams
