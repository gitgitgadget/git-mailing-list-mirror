Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8511F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 15:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbdKKP2M (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 10:28:12 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:43489 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdKKP2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 10:28:11 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:50432 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDXha-00045W-F7; Sat, 11 Nov 2017 10:28:10 -0500
Date:   Sat, 11 Nov 2017 10:27:45 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git bisect" takes exactly one bad commit and one or more
 good?
In-Reply-To: <xmqq8tfcevev.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1711111024470.10756@localhost.localdomain>
References: <alpine.LFD.2.21.1711110612290.5087@localhost.localdomain> <CAP8UFD1=idL51XDzE_RKc_7z9NghTd7GHoZ-T61y0rQ8ZYXomw@mail.gmail.com> <xmqq8tfcevev.fsf@gitster.mtv.corp.google.com>
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

On Sat, 11 Nov 2017, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
>
> >> "You use it by first telling it a "bad" commit that is known to
> >> contain the bug, and a "good" commit that is known to be before
> >> the bug was introduced."
> >
> > Yeah, 'and at least a "good" commit' would be better.
>
> Make it "at least one" instead, perhaps?
>
> I somehow thought that you technically could force bisection with 0
> good commit, even though no sane person would do so.  For the
> matter, in practice nobody starts with more than one good commit,
> and for that reason, I doubt that the proposed change to overstress
> the fact that you could give two or more "good" ones when starting
> has that much practical value.  The tradeoff of losing the clarity
> coming from giving only the simplest usage pattern for trying to be
> technically more correct that is proposed by this change does not
> sound too good, but it may be just me (who prefers white lies in the
> end-user docs when it buys us more simplicity and clarity). .

  i realize that one of each commit is the simplest use case, but the
scenario that occurred to me is a bunch of branches being merged and,
suddenly, you have a bug, and you're not sure where it came from so
you identify a number of good commits, one per merged branch, and go
from there.

  also, making it clear you can have more than one good commit is
consistent with the synopses, which use ellipses to represent that
very thing.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
