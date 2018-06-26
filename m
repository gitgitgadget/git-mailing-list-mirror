Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A23B1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 16:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeFZQvw (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 12:51:52 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:49538 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752093AbeFZQvv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 12:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3E04ZfBVRvTIkJX/JQ1TbjymB54A2f1N5LQetHaWeUQ=; b=d4cywJK72AmExfLPXsbgNrLiy
        UFz/LeVqh8bxHBCPMLop2041BM849wmwgjx7YuNzthcU1ZORYiV/7eAOoQHipSr79PFeoNXPYEB8U
        Uz7On0rokQ/UNOBHcb5qZ0/PI/9XH8QkCXRCTKmwvcngsPAjdwXQu7uWN4gLrpg3wTFETlH+7sqXE
        bNPaUvHuiAzzwbffXKVXFSgXY6IfVCJTI8BBpUSxF0BkLI2Q6M2lhkYr6jXZK56QPLkLTvxYn/5Ra
        b5fMpN2jC3CGLZayZFd16yrV7iZM5ZjIhbKAQCk+xlrbQlW0CSknG5LW/w7R8YxzIciTujDv/j1Ib
        mn1TOdydg==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:47728 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fXrC0-000ftS-HK; Tue, 26 Jun 2018 12:51:50 -0400
Date:   Tue, 26 Jun 2018 12:51:45 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jeff King <peff@peff.net>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: curious about wording in "man git-config", ENVIRONMENT
In-Reply-To: <20180626124316.GA15419@sigill.intra.peff.net>
Message-ID: <alpine.LFD.2.21.1806261250280.6102@localhost.localdomain>
References: <alpine.LFD.2.21.1806260608270.6007@localhost.localdomain> <20180626124316.GA15419@sigill.intra.peff.net>
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

On Tue, 26 Jun 2018, Jeff King wrote:

> On Tue, Jun 26, 2018 at 06:18:26AM -0400, Robert P. J. Day wrote:
>
> >
> >   ENVIRONMENT
> >     GIT_CONFIG
> >       Take the configuration from the given file instead of
> >       .git/config. Using the "--global" option forces this to
> >       ~/.gitconfig. Using the "--system" option forces this to
> >       $(prefix)/etc/gitconfig.
> >
> >   is the phrase "forces this to" really what you want to use here?
> > maybe i misunderstand what this option does, doesn't it simply mean
> > that it will use a different (specified) file from the default,
> > depending on the context (local, global, system)?
> >
> >   it just seems weird to say that the option "forces" the use of what
> > are clearly the default files. thoughts?
>
> I agree it's weird. I think it's trying to mean "behaves as if it
> was set to", but with the additional notion that the command-line
> argument would take precedence over the environment (which is our
> usual rule). But then we should just say those things explicitly.
>
> Just looking at mentions of GIT_CONFIG in that manpage and knowing
> the history, I think:

  ... snip ...

i'm just going to admit that i don't quite have the background to know
how to submit a patch to tidy things up based on Jeff's analysis, so
I'm going to leave this to someone higher up the food chain.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
