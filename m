Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7FD71F42D
	for <e@80x24.org>; Thu, 31 May 2018 23:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750739AbeEaXLI (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 19:11:08 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:47032 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEaXLH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 19:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bd0KGCb/lln2pFP8naiMdZ1QUxHtibYJXCXj7osPbGA=; b=i8+ClfQd/EkAkHH6888s/Eqnm
        8y78pcA4eeOELfdYj2oyZfRMgFhnT9yzJbNe4Vu1F1kpxGfxKI5CmD+jRLuh6iu3Iqh8WUfhYuM7Z
        kdyPXjxaN6QkKUSRN9w3Ny5V4TBvrl/+pgih6PhthG9CrAUxIFmCExfQXHRwvc3SgKAwZzAOuJR4z
        BphiAQ0r0zJ35jI7ElV6QKL9wInCZe+Rk9EmOD+mLR7YX1Gk0tYFBrhIYSdz4VwjHep8dFz3xkaLi
        CCrpNhXWsN+tG5vwtmUf3VqtF8ZZUisiogrxCXKW0tusF5hXRnLl6/QjIDfIx+WwlmeeepQhQBtKX
        hwP4Bx9OQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:35548 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fOWik-006MIa-Uj; Thu, 31 May 2018 19:11:05 -0400
Date:   Thu, 31 May 2018 19:09:03 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: is there a reason pre-commit.sample uses "git diff-index"?
In-Reply-To: <f27d8344-4acb-3e87-3bd9-b23b21c4b82a@kdbg.org>
Message-ID: <alpine.LFD.2.21.1805311907280.19720@localhost.localdomain>
References: <alpine.LFD.2.21.1805311235410.15130@localhost.localdomain> <CACsJy8CP=1_bHAzs+mveaJvbOOzr9vny-2xz6kM4cEcCYWmOOw@mail.gmail.com> <alpine.LFD.2.21.1805311323220.17047@localhost.localdomain> <f27d8344-4acb-3e87-3bd9-b23b21c4b82a@kdbg.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 1 Jun 2018, Johannes Sixt wrote:

> Am 31.05.2018 um 19:27 schrieb Robert P. J. Day:
> > On Thu, 31 May 2018, Duy Nguyen wrote:
> >> git diff-index is "plumbing", designed for writing scripts. "git
> >> diff" on the other hand is for users and its behavior may change
> >> even if it breaks backward compatibility.
> >
> >    ah, this was a philosophical underpinning i was unaware of. i
> > see occasional explanations of git porcelain versus plumbing, but
> > i don't recall anyone simply stating that the plumbing is meant to
> > have a long-term stability that is not guaranteed for the
> > porcelain.
>
> So, there you have it. ;) Plumbing commands offer long-term
> stability. That is not just philosophical, but practically relevant.
>
> >    in any event, this does mean that, stability issues aside, "git
> > diff" would apparently have worked just fine for that hook.
>
> It may have worked just fine. You should still not use it.
>
> Didn't you say that you are teaching git and hooks? Then you should
> teach the right thing, and the right thing is to use plumbing for
> scripts.

  sure, i agree, but i don't recall *ever* running across the claim
that the "plumbing" commands had a long-term stability and backward
compatibility that the porcelain commands did not. is that mentioned
anywhere?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
