Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575CE2036B
	for <e@80x24.org>; Sat,  7 Oct 2017 19:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbdJGTc2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 15:32:28 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:35992 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdJGTc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 15:32:27 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:33624 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e0upm-0001g8-Ro; Sat, 07 Oct 2017 15:32:26 -0400
Date:   Sat, 7 Oct 2017 15:32:24 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jeff King <peff@peff.net>
cc:     Todd Zullinger <tmz@pobox.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
In-Reply-To: <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
Message-ID: <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain> <20171007190402.GH3382@zaya.teonanacatl.net> <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain> <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
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

On Sat, 7 Oct 2017, Jeff King wrote:

> On Sat, Oct 07, 2017 at 03:12:01PM -0400, Robert P. J. Day wrote:
>
> >   ok, in that case, can you give me an example where "-r" makes a
> > difference, given that the man page refers to "a leading directory
> > name being given"? let's use as an example the linux kernel source,
> > where there are a *ton* of files named "Makefile" under the drivers/
> > directory.
> >
> >   should there be a difference between:
> >
> >   $ git rm drivers/Makefile
> >   $ git rm -r drivers/Makefile
> >
> > clearly, i have a "leading directory name" in both examples above ...
> > what should happen differently?
>
> Nothing, because there is nothing to recurse in the pathspecs you've
> given.
>
> Try:
>
>   $ git rm drivers
>   fatal: not removing 'drivers' recursively without -r
>
> versus
>
>   $ git rm -r drivers
>   [...removes everything under drivers/...]

  that is not what the man page is saying ... it refers to a "leading"
directory name, not simply a directory name. if it should say simply
"when a directory name is given", then it should be changed to say
that.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
