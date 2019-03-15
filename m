Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324AA20248
	for <e@80x24.org>; Fri, 15 Mar 2019 14:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfCOObt (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 10:31:49 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:35198 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfCOObt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 10:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fjK5sTi5cPUD0VFy5dSftASVZXHTVkOsUOxztr2k6Js=; b=jdCrdnHzbtbbQQrin6J/PzX9y
        D9+trG7MG3HpN+9CDhVD6f+WB9hjRseE2fU5T2zbQNhXpgGPSqKX7KQ6QF8VPrUR0rxKZSj+8szAH
        s7jspBZqRu+rRi4Cx63gz43nLek1k0Aambw1XtM9QYj9eVxCPda15fE0Bhmk0aITQlBy92PW+mKSN
        VAzNt/UwKFFkG188lX0MQvoIu4Gq/Iz4FU2KGnWs3aO5tgqUPofEr9TjctybcsT2jlqruiMz23Ub3
        WlIlkwKOK5DyGaTBDG+JUb6J61kTbST502ivRunJrT4G7e5NsRDnd02yIdIXul1Nz7molbuCy/dRT
        n+s149kHg==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:36854 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h4nsA-0073n4-5W; Fri, 15 Mar 2019 10:31:47 -0400
Date:   Fri, 15 Mar 2019 10:31:45 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "git clone --shallow-exclude ...", fatal: the remote end hung
 up unexpectedly
In-Reply-To: <CACsJy8CspqxDhOZFF7ac_63TQXvsHjTBicEPtZaUSOmaQnzs4A@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1903151027580.29322@localhost.localdomain>
References: <alpine.LFD.2.21.1903150809070.26709@localhost.localdomain> <CACsJy8DVRJ4DG6PEkFuzytOQJ7RX6GMaHd4BRQTR9N7Y9V6fqQ@mail.gmail.com> <alpine.LFD.2.21.1903150917360.27423@localhost.localdomain>
 <CACsJy8CspqxDhOZFF7ac_63TQXvsHjTBicEPtZaUSOmaQnzs4A@mail.gmail.com>
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

On Fri, 15 Mar 2019, Duy Nguyen wrote:

> On Fri, Mar 15, 2019 at 8:19 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >   this is the first time i've played with this feature, so i'm
> > still working my way through the man page, trying to figure out
> > the various valid combinations for shallow cloning.
> >
> >   i notice that the SYNOPSIS for "man git-clone" does not contain
> > all of the supported options (eg., --shallow-exclude is missing,
> > among others). is that deliberate?
>
> No. It's either laziness or giving up on adding every option in the
> SYNOPSIS. Improvements are welcome. I can see now that
> --single-branch is mentioned in --depth (the original option to make
> a shallow clone) but not on the newer ones. My bad.

  it's fairly obvious that, when you have a git command with a
bazillion options, it's pointless to try to include everything in the
SYNOPSIS part of the man page -- best to just go with something like:

  SYNOPSIS
       git log [<options>] [<revision range>] [[--] <path>...]


what should (IMHO) be avoided are *incomplete* synopses, as those are
exactly the ones that can mislead the reader into thinking that's the
full set of options. "man git-clone" might be at the point of just
reducing the synopsis.

  also, i think "man git-clone" could really use a set of examples for
shallow cloning. i'd offer to write it but i'm still figuring it out.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
