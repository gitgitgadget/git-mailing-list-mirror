Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DD771F42D
	for <e@80x24.org>; Wed, 23 May 2018 09:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932112AbeEWJGC (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 05:06:02 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:49452 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932096AbeEWJGB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 05:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/zUqyBmBRD6ILRHn68U3TqFIm/RdQDGe8VgPef9A5Sw=; b=Q8zQBFlTUzEOWQz+EpD1g4HaB
        lDHTvhpofhcYh3C2qN/igD+ethfp13wCid+iV6uZRDa7Wws3pX392CPTCHE7CdzdFMGlUmRc06p4a
        3oIaV1kLvJi5kJF+Y1g0iOKkWWkZ78bjsZx+mdM0S8bS4GToaS881NGMsG6aKGDu6K3PwXmsmuWAX
        5rJcsq/XWAf+nYMnVrYNBWd35wwLfKDjkUW323+j+c3SVU51hDXuxLjhMOHjLURZ5DsdA8NjYPTcz
        BHY7EdZsHnNqMGB8DeVgBRI2h4kHyX/Peu06ffmKsamQ0njpkMWzgj+5uFbihU7FEEPrv8skhzHIC
        ozk/hoiNQ==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:45166 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fLPiY-009NEY-7W; Wed, 23 May 2018 05:05:59 -0400
Date:   Wed, 23 May 2018 05:04:21 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: should config options be treated as case-sensitive?
In-Reply-To: <xmqqd0xmvjcq.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.1805230503500.18721@localhost.localdomain>
References: <alpine.LFD.2.21.1805220353370.989@localhost.localdomain> <87h8mz99d2.fsf@evledraar.gmail.com> <xmqqo9h7w2y2.fsf@gitster-ct.c.googlers.com> <alpine.LFD.2.21.1805230354270.16358@localhost.localdomain> <xmqqd0xmvjcq.fsf@gitster-ct.c.googlers.com>
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

On Wed, 23 May 2018, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> >> If the documention does not make it clear, then we have
> >> documentation bug ...
> >
> >   personally, i would add a short, really emphatic note at the top of
> > "man git-config" pointing this out -- i wouldn't require people to
> > read all the way down to "Syntax" to learn this. an example just like
> > the one you provide above would be perfect, with an extra line
> > pointing out that the documentation uses "camel case" for nothing more
> > than readability.
>
> Unfortunately, that line of thinking leads us to madness, as you are
> exhibiting the typical symptom of "my today's immediate itch is the
> most important one in the world"-itis.  Tomorrow you would start
> saying that we must have a short, really emphatic note at the top
> that says that the second level name can even have spaces, and on
> the day after that, you would instead have a note that says that you
> cannot use an underscore in the name, and continuing that line of
> thought will lead us to fill the top part of the documentation with
> 47 different short and emphatic sentences.  Let's not go there.

  fair enough, point taken.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
