Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1031FAFC
	for <e@80x24.org>; Tue,  7 Feb 2017 03:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbdBGDL3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 22:11:29 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47726 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbdBGDL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 22:11:28 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 970AA1FAFC;
        Tue,  7 Feb 2017 03:11:27 +0000 (UTC)
Date:   Tue, 7 Feb 2017 03:11:27 +0000
From:   Eric Wong <e@80x24.org>
To:     Paul Wise <pabs3@bonedaddy.net>
Cc:     git@vger.kernel.org
Subject: Re: idea: light-weight pull requests
Message-ID: <20170207031127.GA29468@dcvr>
References: <1486427537.16949.42.camel@bonedaddy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486427537.16949.42.camel@bonedaddy.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Wise <pabs3@bonedaddy.net> wrote:
> Hi all,
> 
> I had an idea that might be interesting to git folks:
> 
> light-weight pull requests:
> 
> Anonymous and ssh/http-identified users should be able to push just
> using git, within the refs/pull/ namespace, to any non-existent branch
> name or to a branch they created when previously identified, without
> forking off a new repository.

I considered something similar to this a few years ago,
but decided it wasn't worth the effort (see below).

> Advantages:
> 
> Removes the need to look up who to send the pull request notification
> to since configuring that is up to the project itself.
> 
> Removes the annoying scenario of having lots of remotes that have been
> removed after the corresponding pull request was closed.
> 
> Moves popular git hosting services from primarily a model of forests of
> forks to one of contributions to well maintained ongoing projects.
> 
> Allows users to use their preferred git clients to issue pull requests
> instead of using web interfaces of popular git hosting services.
> 
> Creates a new standard for contributing to repositories on all git
> repository hosting services.
> 
> Contributions from people without an account on those services are
> possible.
> 
> Contributions from people without any git repository hosting of their
> own are possible.

All of these are great goals which I'd love to see realized, but...

> Contributions from people who don't use or dislike MUAs are possible.

How would discussion and review happen?  People seem to use
either mail, or centralized messaging (and the latter often
involves non-Free systems like GitHub or Slack).

> Disadvantages:
> 
> Pull request spam, could be mitigated with configuration options.

This is a big one.  Maybe CRM114 or another generic/trainable
option can be made usable; but I think there'll always be cases
where hardcoded rules need to be written (for SpamAssassin,
at least) and real-time blacklists need to be checked.

At some point, you might end up having to recreate everything we
have in place to combat email spam.  Or, use blockchain or
something similarly expensive for reputation, which isn't good
for poor folks with slow computers.

Anyways, I ultimately decided it would be better to continue
supporting and improving email (which is at least entrenched in
a few communities, like this one), rather than trying to get
people to adopt something new.
