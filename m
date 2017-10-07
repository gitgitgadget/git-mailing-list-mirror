Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4D42036B
	for <e@80x24.org>; Sat,  7 Oct 2017 19:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbdJGTnr (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 15:43:47 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:43080 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdJGTnr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 15:43:47 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:33690 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e0v0j-0004Kc-Tq; Sat, 07 Oct 2017 15:43:45 -0400
Date:   Sat, 7 Oct 2017 15:43:43 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jeff King <peff@peff.net>
cc:     Todd Zullinger <tmz@pobox.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
In-Reply-To: <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
Message-ID: <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain> <20171007190402.GH3382@zaya.teonanacatl.net> <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain> <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain> <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
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

> On Sat, Oct 07, 2017 at 03:32:24PM -0400, Robert P. J. Day wrote:
>
> > > Nothing, because there is nothing to recurse in the pathspecs you've
> > > given.
> > >
> > > Try:
> > >
> > >   $ git rm drivers
> > >   fatal: not removing 'drivers' recursively without -r
> > >
> > > versus
> > >
> > >   $ git rm -r drivers
> > >   [...removes everything under drivers/...]
> >
> >   that is not what the man page is saying ... it refers to a "leading"
> > directory name, not simply a directory name. if it should say simply
> > "when a directory name is given", then it should be changed to say
> > that.
>
> It's the leading directory of the files that will be removed.
>
> An earlier part of the manpage (under <file>) also says:
>
>   A leading directory name (e.g. dir to remove dir/file1 and dir/file2)
>   can be given to remove all files in the directory, and recursively all
>   sub-directories, but this requires the -r option to be explicitly
>   given.
>
> which perhaps makes it more clear. Later in "-r", we say:
>
>    -r
>            Allow recursive removal when a leading directory name is given.
>
> which I guess is the part you're reading.  I think it would be equally
> correct to say "leading directory" or just "directory" there.
>
> Though really, you could give many such directory names, or even match
> them with a glob. So a more accurate description might be something
> like:
>
>   -r
> 	Recursively remove the contents of any directories that match
> 	`<file>`.
>
> or something.

  it's been a long week, so take this in the spirit in which it is
intended ... i think the "git rm" command and its man page should be
printed out, run through a paper shredder, then set on fire. i can't
remember the last time i saw such a thoroughly badly-designed,
badly-documented and non-intuitive utility.

  i'm going to go watch football now and try to forget this horror.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
