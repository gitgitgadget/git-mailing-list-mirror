Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963161F42D
	for <e@80x24.org>; Mon, 28 May 2018 14:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162330AbeE1OMA (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 10:12:00 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:53432 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939365AbeE1OLG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 10:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/UWcg8hV07M4JPCkM6WJUNG6k3fBGZWjNJOGbMFVquQ=; b=fFY8/qcN/A217N43DABgrS4K6
        a0W7PQWRmGuZuQt9E1QasuLak+7jXIhHiDCVct5mAhWgsZNd+3qV5G3upXj5U2jBunsWdc9fBJ9RL
        q4dfiSpXQ8yrUK6vYW6A6Fi8KRN+w/72cgT/cHfA1lPNNmYCgt6FBjyqpYnOtwMOQAK2QlaFhoyKv
        bsIO5O0QfDIHpvvTDmlfAdjo9lUSb85b+yJGgXQu7tFW/QFAILis6g24envyotM5nvzD0UpUkE+xc
        40t4KY5TPKyXdvu1AFF8u7V3bhKN+koaNUvamCD1T5IJF4YPErCqRQIioG4PGo1mmMKsI2xWhS4EW
        Y641UJPsw==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:47364 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fNIrX-002SJ4-Gt; Mon, 28 May 2018 10:11:04 -0400
Date:   Mon, 28 May 2018 10:09:12 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Sitaram Chamarty <sitaramc@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: why does builtin/init-db.c mention
 "/etc/core-git/templates/hooks/update"?
In-Reply-To: <20180528135902.GA362@sita-lt.atc.tcs.com>
Message-ID: <alpine.LFD.2.21.1805281006250.13672@localhost.localdomain>
References: <alpine.LFD.2.21.1805280920100.12022@localhost.localdomain> <20180528135902.GA362@sita-lt.atc.tcs.com>
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

On Mon, 28 May 2018, Sitaram Chamarty wrote:

> On Mon, May 28, 2018 at 09:27:18AM -0400, Robert P. J. Day wrote:
>
> [snipped the rest because I really don't know]
>
> >   more to the point, is that actually what the "update" hook does? i
> > just looked at the shipped sample, "update.sample", and it seems to be
> > related to tags:
> >
> >   #!/bin/sh
> >   #
> >   # An example hook script to block unannotated tags from entering.
>
> no that's just a sample.  An update hook can do pretty much
> anything, and if it exits with 0 status code, the actual update
> succeeds.  If it exists with any non-zero exit code, the update will
> fail.
>
> This is (usually) the basis for a lot of checks that people may
> want, from commit message format to access control at the ref
> (branch/tag) level for write operations.

  i'm not convinced that that reference is "just a sample." the
comment in builtin/init-db.c reads:

  /* Note: if ".git/hooks" file exists in the repository being
   * re-initialized, /etc/core-git/templates/hooks/update would
   * cause "git init" to fail here...

the reference to "/etc/core-git/templates/hooks/update" might lead
some people to believe that that somehow refers to the "update.sample"
hook that comes with a new repo, but that hook is specifically related
to git-receive-pack, and has nothing to do with re-initalizing a repo,
AFAICT.

  i'm just suggesting that that comment in buildin/init-db.c seems
more than a little inaccurate.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
