Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FDD1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 12:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935346AbeFMM3K (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 08:29:10 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:33942 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935244AbeFMM3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 08:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IMKrIM1UlcyBwKIfsQlpkZaorHhi3UtayWFTdIAMxF0=; b=R0Jp6HyUkcwPe/cvFswcFk2pZ
        MgU4CPL4j05b5SorZjhZDJMqryZufB8gaMaRQ5TF+y8flPltLZgPz0QzMxv6srb96//JemOhA6J47
        6ZmXm5VC4pq02sJuzkjKfNMPD1tdeJ2U86M2kc9NfnP7HOSwiVhLDcorz1LmVFS18BICE7h3bkCJ2
        A6cO4cMLsuf+Ch6z0lF84oMGwqQ4n38u7bKUR0iDkOA99y9NDVoC+dC4IobZpZTCKHAVy/x1YQvpE
        VzH+LqfnkKcFnYI1eXkv2mEoVj81gPyvaqHiUEEjXVRoc0sRzJj76Pf0AqZkWXnFjczX9LKwZmpov
        ksZgVRP1A==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:56120 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fT4te-00HJIY-I9; Wed, 13 Jun 2018 08:29:07 -0400
Date:   Wed, 13 Jun 2018 08:26:34 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Stefan Beller <sbeller@google.com>
cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>
Subject: Re: is there a canonical doc about how to deal with whitespace
 issues?
In-Reply-To: <CAGZ79kazegY-udjKfbkfw=ox82cfxhO5E3AEjLKkSt3LMY-DFw@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1806130824110.12332@localhost.localdomain>
References: <alpine.LFD.2.21.1806080914520.20892@localhost.localdomain> <b8801d73-71c4-15c8-4b29-8e4edb3faec9@gmail.com> <CAGZ79kazegY-udjKfbkfw=ox82cfxhO5E3AEjLKkSt3LMY-DFw@mail.gmail.com>
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

On Mon, 11 Jun 2018, Stefan Beller wrote:

> On Fri, Jun 8, 2018 at 10:15 AM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 6/8/2018 9:18 AM, Robert P. J. Day wrote:
> > >    for one of my courses, i wanted to write a section about the
> > > various techniques for dealing with whitespace issues in git, so
> > > i started
>
> What do you mean by white space issues?
> That in itself is a complex topic:

  i know ... it's not even clear that just dealing with EOL
standardization shouldn't be a topic all by itself.

> * There are 3 different modes to ignore white space changes:
>   - trailing whitespaces,
>   - conversion of tab to space and back
>     These two are caught by the default in 'git diff --check'
>   - any white space change
>     This is interesting to ignore in git-blame[1], but sometimes
>     it is actually interesting.
>
> [1] See also
> https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/git-hyper-blame.html
>
>
>
> > > making a list, things like:
> > >
> > >    - running "git diff --check"
> > >    - "git commit --cleanup=" possibilities
> > >    - config options like core.{eol,safecrlf,autocrlf}
>
> This sounds more like line ending or cross platform issues
> than whitespaces (except .eol)

  i just started a quick-and-dirty wiki page as a reference to things
that relate to whitespace:

  http://crashcourse.ca/dokuwiki/doku.php?id=git_whitespace

it's not even *remotely* close to comprehensive, i just wanted to
start making a list. feel free to make other suggestions as i keep
adding to that page.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
