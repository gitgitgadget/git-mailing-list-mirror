Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722E01F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeBXAT7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:19:59 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:46207 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeBXAT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:19:57 -0500
Received: by mail-pl0-f46.google.com with SMTP id x19so5811318plr.13
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9uKFWVfHoRDps/fGGQHpucZnWvexRPzxE9TeN+hxpT8=;
        b=TXkggeMSa47bq2QmxIK3FNpww+pgR6b5yfM/6l8VGdA7fZge46hONyKIuE7QUtZ0Ws
         6sv4nKY5Xitr/5bXvaxnrXtewMZ/gE1HGGIT27oUfIEOc3EiVEnie2KNAobJVgJwy3gj
         X5Zi30jl8L7d/6VYdXnlAxXQrj70fR6fDqaDIxRxCj5WPeqsdlMF55f9kQFgvVC3Lors
         HAiEgYbZhmPjKZzSqZcXSBAZw3xDHHvmuFb9TKJighKPAqatPW1yN33shSYMZ9sktVHK
         zjVPKHAFtEde55zAbVj8F+dBetsh6Yc5Qi2roWoYfEgSXSBLQIZm9xRTEa6KF7I09zHB
         gzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9uKFWVfHoRDps/fGGQHpucZnWvexRPzxE9TeN+hxpT8=;
        b=UVuYdSlgKHRCHNj0ZCVilxLXhpYaohuMPAcUBxWhIUMYq/5LUDfLWH83p85tSCHcJg
         ik/v7/DvYgCEY6XK21K8So5bAhVhqLOnetC/yW1W5z0YNL3DXiKz6QW08hFJwdi09FT/
         AsWzuudl9aNsmZnaE6YFk0ICjkawTVRzD7o6iWp4zuJjQrNwJgDg7sboScf/jKIVi12K
         MWxvB60vU/x887Kg7QHb8vnF/MuKRtnV6oEDgvhmEufr01knhU+zcPOrPclyaXPrrTvt
         HPNl02IZPz8ZI4i9/odKKC/eupMm3YTCQ6GUHWYH1QEMapoyCUmakB4ii1byStyTkAP7
         1E9A==
X-Gm-Message-State: APf1xPA69mEPEpJVAHosmvsG14DJJDC67EPN0EKn7wqTQTc0x7Ky1bWh
        YObvwAHGgwvg8ocEtc7rXO+nDtbKCr8=
X-Google-Smtp-Source: AH8x227w7xj20g0yzHDzaekomdPSKgU+erhpLyvyY5Zyhko6mlpU0MRpHCl301ZfPQM1MplyGzao0Q==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59-v6mr3278665plp.228.1519431597052;
        Fri, 23 Feb 2018 16:19:57 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p3sm6263190pfh.7.2018.02.23.16.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:19:55 -0800 (PST)
Date:   Fri, 23 Feb 2018 16:19:54 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180224001954.GA153423@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-14-bmwill@google.com>
 <20180222094831.GB12442@sigill.intra.peff.net>
 <20180223004514.GP185096@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223004514.GP185096@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22, Brandon Williams wrote:
> On 02/22, Jeff King wrote:
> > On Tue, Feb 06, 2018 at 05:12:50PM -0800, Brandon Williams wrote:
> > 
> > > +ls-refs takes in the following parameters wrapped in packet-lines:
> > > +
> > > +    symrefs
> > > +	In addition to the object pointed by it, show the underlying ref
> > > +	pointed by it when showing a symbolic ref.
> > > +    peel
> > > +	Show peeled tags.
> > > +    ref-pattern <pattern>
> > > +	When specified, only references matching the one of the provided
> > > +	patterns are displayed.
> > 
> > How do we match those patterns? That's probably an important thing to
> > include in the spec.
> 
> Yeah I thought about it when I first wrote it and was hoping that
> someone who nudge me in the right direction :)
> 
> > 
> > Looking at the code, I see:
> > 
> > > +/*
> > > + * Check if one of the patterns matches the tail part of the ref.
> > > + * If no patterns were provided, all refs match.
> > > + */
> > > +static int ref_match(const struct argv_array *patterns, const char *refname)
> > 
> > This kind of tail matching can't quite implement all of the current
> > behavior. Because we actually do the normal dwim_ref() matching, which
> > includes stuff like "refs/remotes/%s/HEAD".
> > 
> > The other problem with tail-matching is that it's inefficient on the
> > server. Ideally we could get a request for "master" and only look up
> > refs/heads/master, refs/tags/master, etc. And if there are 50,000 refs
> > in refs/pull, we wouldn't have to process those at all. Of course this
> > is no worse than the current code, which not only looks at each ref but
> > actually _sends_ it. But it would be nice if we could fix this.
> > 
> > There's some more discussion in this old thread:
> > 
> >   https://public-inbox.org/git/20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net/
> 
> Thanks for the pointer.  I was told to be wary a while about about
> performance implications on the server but no discussion ensued till now
> about it :)
> 
> We always have the ability to extend the patterns accepted via a feature
> (or capability) to ls-refs, so maybe the best thing to do now would only
> support a few patterns with specific semantics.  Something like if you
> say "master" only match against refs/heads/ and refs/tags/ and if you
> want something else you would need to specify "refs/pull/master"?
> 
> That way we could only support globs at the end "master*" where * can
> match anything (including slashes)

After some in-office discussion it seems like the best thing to do for
this (right now since if we change our mind we can just introduce a
capability which extends the patterns supported) would be to left-anchor
the ref-patterns and only allow for a single wildcard character '*'
which matches zero or more characters (and doesn't care about slashes
'/').  This wildcard character should only be supported at the end of
the ref pattern.  This means that if a client wants 'master' then they
would need to specify 'refs/heads/master' (and the other
ref_rev_parse_rules expansions) as a ref pattern. But they could say
"refs/heads/*" for all refs under refs/heads.

> 
> > 
> > > +{
> > > +	char *pathbuf;
> > > +	int i;
> > > +
> > > +	if (!patterns->argc)
> > > +		return 1; /* no restriction */
> > > +
> > > +	pathbuf = xstrfmt("/%s", refname);
> > > +	for (i = 0; i < patterns->argc; i++) {
> > > +		if (!wildmatch(patterns->argv[i], pathbuf, 0)) {
> > > +			free(pathbuf);
> > > +			return 1;
> > > +		}
> > > +	}
> > > +	free(pathbuf);
> > > +	return 0;
> > > +}
> > 
> > Does the client have to be aware that we're using wildmatch? I think
> > they'd need "refs/heads/**" to actually implement what we usually
> > specify in refspecs as "refs/heads/*". Or does the lack of WM_PATHNAME
> > make this work with just "*"?
> > 
> > Do we anticipate that the client would left-anchor the refspec like
> > "/refs/heads/*" so that in theory the server could avoid looking outside
> > of /refs/heads/?
> 
> Yeah we may want to anchor it by providing the leading '/' instead of
> just "refs/<blah>".
> 
> > 
> > -Peff
> 
> I need to read over the discussion you linked to more but what sort of
> ref patterns do you believe we should support as part of the initial
> release of v2?  It seems like you wanted this at some point in the past
> so I assume you have an idea of what sort of filtering would be
> beneficial.
> 
> -- 
> Brandon Williams

-- 
Brandon Williams
