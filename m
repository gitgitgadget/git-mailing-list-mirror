Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74F3520A29
	for <e@80x24.org>; Wed, 20 Sep 2017 19:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbdITTge (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 15:36:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:45022 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750938AbdITTgc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 15:36:32 -0400
Received: (qmail 9876 invoked by uid 109); 20 Sep 2017 19:36:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 19:36:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15509 invoked by uid 111); 20 Sep 2017 19:37:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 15:37:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 15:36:30 -0400
Date:   Wed, 20 Sep 2017 15:36:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Subject: Re: Behaviour of 'git stash show' when a stash has untracked files
Message-ID: <20170920193630.l7ifret5dpqgxiwm@sigill.intra.peff.net>
References: <1505626069.9625.6.camel@gmail.com>
 <xmqqfubinddb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfubinddb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 02:33:04PM +0900, Junio C Hamano wrote:

> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> > Some time ago, I stashed a few changes along with untracked files. I
> > almost forgot it until recently. Then I wanted to see what I change I
> > had in the stash. So I did a 'git stash show <num>'. It worked fine but
> > didn't say anything about the untracked files in that stash. That made
> > me wonder where the untracked files I added went. I then applied the
> > stash to see that they were still there but weren't listed in show.
> >
> > I understand that they aren't listed because 'git stash show' is
> > typically a "diff between the stashed state and its original parent" as
> > the documentation says but shouldn't there be at least a message that
> > the stash contains untracked files? Those untracked files are "part of
> > the stash" and I see no way to get information about their presence
> > currently.
> >
> > So, should this behaviour be changed?
> 
> Hmm, crickets tell us that nobody is all that interested in this, it
> seems.

Or sometimes people are just really behind in reading the mailing list. ;)

This seemed familiar, and indeed there was some discussion a few months
ago:

  https://public-inbox.org/git/CAOtcWM3mrQEqDnjMipzea7Kp+VueBFsZDL2zcJ=y0wgj9N4Vjw@mail.gmail.com/

I sketched out a possible solution in:

  https://public-inbox.org/git/20170317141417.g2oenl67k74nlqrq@sigill.intra.peff.net/

though I share your concerns over whether people would be annoyed to see
the existing "stash show" output changed.

-Peff
