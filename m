Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08001F462
	for <e@80x24.org>; Tue, 21 May 2019 03:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfEUDbx (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 23:31:53 -0400
Received: from thyrsus.com ([71.162.243.5]:41720 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfEUDbx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 23:31:53 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 2C89B470485F; Mon, 20 May 2019 23:31:53 -0400 (EDT)
Date:   Mon, 20 May 2019 23:31:53 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: Separate commit identification from Merkle hashing
Message-ID: <20190521033153.GA2909@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190521013250.3506B470485F@snark.thyrsus.com>
 <20190521015703.GB32230@google.com>
 <20190521023832.GA130381@thyrsus.com>
 <20190521025813.GA175422@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521025813.GA175422@google.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com>:
> > I think it's a weakness, though, that most of it is written as though it
> > assumes only one hash transition will be necessary.  (This is me thinking
> > on long timescales again.)
> 
> Hm, can you point to what part of the doc suggested that?  Best to make
> the text clearer, to avoid confusing the next person.

I will reread it with an editorial eye and try to come up with
concrete suggestions, perhaps a patch. My relative ignorance
should actually be helpful here.

> >                                    The same technique (probably the
> > same code!) could be used to map the otherwise uninterpreted
> > commit-IDs I'm proposing to lookup keys.
> 
> No, since Git relies on commit IDs for integrity checking.  The hash
> function transition described in that document relies on
> round-tripping ability for the duration of the transition.

I do not quite understand this comment yet. But I don't think it
matters that I don't, and I will by the time I write any code.  I
expect the worst case is that the separated IDs require a different
lookup table from the hashes, but will resolve at the same speed.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


