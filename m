Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PLING_QUERY,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D03C120248
	for <e@80x24.org>; Tue, 12 Mar 2019 18:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfCLSU0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 14:20:26 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:52984 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfCLSU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 14:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yaENxj3COb7/kgEjh8LuJR4PZaQPyNG4sBrlnTLF2cE=; b=V/OEL4ijFmWluQroP26wQXKbL
        xLeVkmkmz0l0Kp34qd84hSKSlaAjmXHLmURCjhsLk553v7YovZ4lkOys6zG3h4kGGrC8/vg6XI+i5
        jEe+8WqKrEOM2zhDkDwvjChXHk29cKg1Kk3ku0/KcL1rkMxYgod3xdu3XSix9ez9XJXEinMUiqsRC
        SSnBE3vbbMqk4Wc5zFk12/FGiQPRTS9OrV5x+Ah726SHAGborKSQL4fpWH6xuwr9CCLdt2M3f6FhS
        94LEipR6Pxb3m07J+BemXSXTY6BbamRHSVErP9LwD5OUvmjzoLtKolTmjZxRcb+mjZ47OX8ihK1pR
        a7ejPNnig==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:58086 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h3m0m-00BdXL-6T; Tue, 12 Mar 2019 14:20:25 -0400
Date:   Tue, 12 Mar 2019 14:20:22 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Kevin Daudt <me@ikke.info>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: why does "git revert" commit even if i try to bail with ":q!"?
In-Reply-To: <20190312181428.GA6993@alpha>
Message-ID: <alpine.LFD.2.21.1903121419070.18042@localhost.localdomain>
References: <alpine.LFD.2.21.1903121317020.16391@localhost.localdomain> <20190312181428.GA6993@alpha>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=0.1
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

On Tue, 12 Mar 2019, Kevin Daudt wrote:

... snip ...

> The only reason why `:q!` works just for comitting is because there
> is no default message, so the final message ends up empty.
>
> When you do things like git revert or git commit --amend, there is
> already a commit message, which you are then editing. When you quit
> without saving, the existing message remains and git uses that.
>
> vim has a command to let it exit with an error return code: `:cq`.
> This makes git something went wrong with editing the message,
> causing git to abort the commit.

  ah, i'm starting to get it. predictably, i think this needs to be
mentioned in a man page. :-) thanks muchly for clearing that up.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
