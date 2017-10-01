Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55DA20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 20:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbdJAUoE (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 16:44:04 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:53345 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbdJAUoE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 16:44:04 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:50562 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dyl5n-0007ij-7S; Sun, 01 Oct 2017 16:44:03 -0400
Date:   Sun, 1 Oct 2017 16:44:01 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-stash" explanation of "--include-untracked" and "--all"
 seems ambiguous
In-Reply-To: <20171001201604.GA30301@hank>
Message-ID: <alpine.LFD.2.21.1710011643070.27165@localhost.localdomain>
References: <alpine.LFD.2.21.1709290650530.1446@localhost.localdomain> <20171001201604.GA30301@hank>
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

On Sun, 1 Oct 2017, Thomas Gummerer wrote:

> On 09/29, Robert P. J. Day wrote:
> >
> >   from the man page:
> >
> > "If the --include-untracked option is used, all untracked files
> > are also stashed and then cleaned up with git clean, leaving the
> > working directory in a very clean state. If the --all option is
> > used instead
> >
> > ^^^^^^^ then the ignored files are stashed and cleaned in addition
> > to the untracked files."
> >
> >   the use of the word "instead" suggests you can use one of those
> > options, or the other, but not both at the same time. but it seems
> > you can combine them, so that paragraph seems a bit misleading,
> > no?
>
> Looking at the code, really only one (the last one that's specified
> on the command line) is respected, so I think the man page is
> correct. This happens silently, where I guess your impression that
> it's possible to combine them comes from.
>
> This is fine when --include-untracked is specified first, as --all
> implies --include-untracked, but I guess the behaviour could be a
> bit surprising if --all is specified first and --include-untracked
> later on the command line.
>
> Changing this could possibly break someone that just adds parameters
> to their 'git stash' invocation, but I'm tempted to say allowing
> both at once is a bug, and change it to make git die when both are
> specified.  Do you have any inserest in submitting a patch that
> fixes this? :)

  sure, might as well jump in with both feet. is there another example
in the code of mutually exclusive options so i can just steal the
error code?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
