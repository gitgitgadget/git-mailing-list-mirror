Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6B31FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755290AbdC1TTP (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:19:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:53119 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753263AbdC1TTO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:19:14 -0400
Received: (qmail 10145 invoked by uid 109); 28 Mar 2017 19:19:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:19:13 +0000
Received: (qmail 19962 invoked by uid 111); 28 Mar 2017 19:19:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:19:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:19:11 -0400
Date:   Tue, 28 Mar 2017 15:19:11 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] should these two topics graduate to 'master' soon?
Message-ID: <20170328191911.22wxjbukv47jflgl@sigill.intra.peff.net>
References: <xmqqshlxckr2.fsf@gitster.mtv.corp.google.com>
 <20170328185149.GS31294@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328185149.GS31294@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 11:51:49AM -0700, Jonathan Nieder wrote:

> > * jc/merge-drop-old-syntax (2015-04-29) 1 commit
> >
> >   This topic stops "git merge <message> HEAD <commit>" syntax that
> >   has been deprecated since October 2007 (and we have issued a
> >   warning message since around v2.5.0 when the ancient syntax was
> >   used).
> >
> > * jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
> >
> >   This is the endgame of the topic to avoid blindly falling back to
> >   ".git" when the setup sequence said we are _not_ in Git repository.
> >   A corner case that happens to work right now may be broken by a call
> >   to die("BUG").
> >
> > I am leaning toward including the former in the upcoming release,
> > whose -rc0 is tentatively scheduled to happen on Apr 20th.  I think
> > the rest of the system is also ready for the latter (back when we
> > merged it to 'next' and started cooking, there were still a few
> > codepaths that triggered its die(), which have been fixed).
> >
> > Opinions?
> 
> Google has been running with both of these for a while.  Any problems
> we ran into were already reported and fixed.  I would be all for
> including them in the next release.

Thanks, I was wondering how much exposure the latter got. It might be a
good idea to merge it to "master" early in the post-2.13 cycle to get a
little more exposure (since the point of it is really to flush out
unusual cases, the more people run it before we make a release the
better). But I'm also OK if it's merged to master this cycle, as long as
it's soon-ish. It's much better to flush out problems in pre-release
master than in a released version.

-Peff
