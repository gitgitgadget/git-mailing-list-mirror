Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BAAA20281
	for <e@80x24.org>; Mon,  6 Nov 2017 05:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751105AbdKFFdb (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 00:33:31 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:34696 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbdKFFdb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 00:33:31 -0500
Received: from [199.203.152.178] (port=52772 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eBa2L-0008DN-PT; Mon, 06 Nov 2017 00:33:30 -0500
Date:   Mon, 6 Nov 2017 07:33:17 +0200 (EET)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: what is the function of .git/branches/?
In-Reply-To: <xmqqo9ogji9z.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1711060731070.13351@localhost.localdomain>
References: <alpine.LFD.2.21.1711051122160.3602@localhost.localdomain> <xmqqo9ogji9z.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 6 Nov 2017, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> >   currently proofing "pro git" book, and an example of a new repo
> > doesn't show a .git/branches/ directory, but initializing a new
> > repo with current version of 2.13.6 *does* show an initially empty
> > directory by that name. however, AFAICT, branches are still
> > tracked under .git/refs/heads/, so what's with that branches/
> > directory?

> There are three ways to specify what branches of which remote
> repository your fetch and/or push interacts with, and having
> .git/branches/foo file is one of these three ways (the other two are
> to have .git/remotes/foo file, and to have [remote "foo"] section in
> the .git/config).

> If your workflow involves having to interact with tons of remotes
> (imagine being a maintainer who regularly pulls from dozens of
> sub-maintainer's repositories, each of which places the material to
> be upstreamed on a single branch) and that set changes from time to
> time, using .git/branches/* is a lot more efficient than having to
> keep track of the same information in other two formats, so even
> though it was the invented the earliest and is the least flexible
> format among the three, it still has its uses.

  ah, useful to know, thanks. as i mentioned, i'm clawing my way
through the current version of the "pro git" book and submitting all
sorts of updates, and this is the sort of thing i'm keeping track of
to see if i can sneak it in somewhere.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
