Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4EB20373
	for <e@80x24.org>; Sun,  8 Oct 2017 09:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbdJHJHQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 05:07:16 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:41997 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdJHJHP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 05:07:15 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:36696 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e17YI-0007wP-Fy; Sun, 08 Oct 2017 05:07:14 -0400
Date:   Sun, 8 Oct 2017 05:07:12 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Paul Smith <paul@mad-scientist.net>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
In-Reply-To: <xmqqy3oms22q.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1710080502050.19600@localhost.localdomain>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain> <20171007190402.GH3382@zaya.teonanacatl.net> <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain> <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain> <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net> <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain> <1507412674.8322.4.camel@mad-scientist.net> <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
 <xmqqy3oms22q.fsf@gitster.mtv.corp.google.com>
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

On Sun, 8 Oct 2017, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> > ... so if, in the kernel source
> > tree, i ran:
> >
> >   $ git rm \*.c
> >
> > i would end up removing *all* 25,569 "*.c" files in the kernel source
> > repository.
>
> Yes, as that is exactly what the command line asks Git to do.

  so if i wanted git to remove, say, all files named "Makefile*" from
everywhere in the linux kernel source tree, the (dry run) command
would be:

  $ git rm -n Makefile\*

is that it? let's try that:

  $ git rm -n Makefile\*
  rm 'Makefile'
  $

oops.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


