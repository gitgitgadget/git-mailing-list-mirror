Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A741F491
	for <e@80x24.org>; Sat,  2 Jun 2018 08:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbeFBIxL (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 04:53:11 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:51060 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeFBIxI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 04:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LEPN5uxDoMA12KMD6LueEwA3ARlMNY05eaYAbENpJP0=; b=buMQuVfMrCbpwnN3VrrBHacYa
        XxEn+KGgufq762tgqn6nOYeYnuu+H5PgC+xpGjnfvTkt1TYtTaFxV/M+uTkUUzjCQn7s6b1qwgSMq
        SL/UhgbKCBtwbLm4SfoN6hzZmzO+6BiuXRen0OZgIfLJXnvzk+9vlrIVpBeKlVnebLn9Apf7dN+p4
        j7bWhQQEckUEb+mdgwvutJ/ukNz2sMrcgzD+gHSU8lwY7TE6YlGFuo1ols+xWVX2A9a74jptkB/N2
        IxF0zZ+kWsFUG4IS7GjItP9Uf6VWKZ9J/ojE9kBCulFR3oAGQZ8JD4omrilPXNxXz5yzjbxcVMC4D
        rEJyN92xQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:41334 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fP2Ha-00Er36-Bu; Sat, 02 Jun 2018 04:53:07 -0400
Date:   Sat, 2 Jun 2018 04:50:57 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jeff King <peff@peff.net>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how exactly can git config section names contain periods?
In-Reply-To: <20180601210731.GA20974@sigill.intra.peff.net>
Message-ID: <alpine.LFD.2.21.1806020448030.24235@localhost.localdomain>
References: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain> <20180601210731.GA20974@sigill.intra.peff.net>
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

On Fri, 1 Jun 2018, Jeff King wrote:

> On Fri, Jun 01, 2018 at 04:14:12PM -0400, Robert P. J. Day wrote:
>
> >   $ git config --global a.b.c.d.e rday
> >
> > huh ... seemed to work fine, and added this to my ~/.gitconfig:
> >
> >   [a "b.c.d"]
> >           e = rday
> >
> > as i see it, the first component is intgerpreted as the section
> > name, the last component is the variable/key(?) name, and
> > everything in between is treated as subsection(s), which is not at
> > all obvious from that Doc file, or from "man git-config".
>
> Yep, your understanding is correct.

  just to be precise regarding terminology, in my example above, is
"b.c.d" a single subsection, or does it refer to three subsections?
i'm guessing it refers to a single subsection, which is fine with me,
as long as it's very clearly explained that way in the docs.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
