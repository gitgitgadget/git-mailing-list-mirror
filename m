Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273941F576
	for <e@80x24.org>; Sun, 21 Jan 2018 12:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbeAUMCO (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 07:02:14 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:35397 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbeAUMCN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 07:02:13 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:50986 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1edEKC-00017p-Ak; Sun, 21 Jan 2018 07:02:12 -0500
Date:   Sun, 21 Jan 2018 07:02:10 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
Subject: Re: [PATCH] worktree: teach "add" to check out existing branches
In-Reply-To: <20180121120208.12760-1-t.gummerer@gmail.com>
Message-ID: <alpine.LFD.2.21.1801210701340.22979@localhost.localdomain>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 21 Jan 2018, Thomas Gummerer wrote:

> Currently 'git worktree add <path>' creates a new branch named after the
> basename of the path by default.  If a branch with that name already
> exists, the command refuses to do anything, unless the '--force' option
> is given.
>
> However we can do a little better than that, and check the branch out if
> it is not checked out anywhere else.  This will help users who just want
> to check an existing branch out into a new worktree, and save a few
> keystrokes.
>
> As the current behaviour is to simply 'die()' when a brach with the name
                                                       ^^^^^
