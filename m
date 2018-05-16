Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 647D11F42D
	for <e@80x24.org>; Wed, 16 May 2018 09:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeEPJn0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 05:43:26 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:47752 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbeEPJnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 05:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+9gNoM5B2S1G2tRKP4Akx2Hz4qiPf78kkKvwGlptQ1s=; b=XwyyjQENxgnqHGW23uS45CSq9
        N1/vwi5LL392yuQZXuS5kU997jW1tmcv5VFg2dVCdtzKvqQFSGTR2AszusywhEw0mDSz2YRhx1R98
        +WEgdSKWanfW+GFpE3SfgG2Irp0qscpNY2Ak8VoIqr7MKSq5Kki3ZL0jgqEh5b834+qH/sFCnyWEm
        o/HQaGuhBzqFcnC7Fjwz0DtJRM9byNh2liLppiu4wsyVhQKqkn73fBndqLRvlLd25QXwtFcfTbWV0
        78y8jSfdUq/Q9DXZ/NEkY1Q46paNMSKfvPbs45X61DI2sYshjCVzK4y6a1l445qHK0Ie89PgZzzIe
        /y3j1FEEg==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:45840 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fIsxu-000xhg-VE; Wed, 16 May 2018 05:43:24 -0400
Date:   Wed, 16 May 2018 05:42:02 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
In-Reply-To: <87po1waqyc.fsf@evledraar.gmail.com>
Message-ID: <alpine.LFD.2.21.1805160540100.7243@localhost.localdomain>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com> <87po1waqyc.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1101079944-1526463723=:7243"
X-OutGoing-Spam-Status: No, score=-1.0
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1101079944-1526463723=:7243
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 16 May 2018, Ævar Arnfjörð Bjarmason wrote:

>
> On Wed, May 16 2018, Lars Schneider wrote:
>
> > I am looking into different options to cache Git repositories on build
> > machines. The two most promising ways seem to be git-worktree [1] and
> > git-alternates [2].
> >
> > I wonder if you see an advantage of one over the other?
> >
> > My impression is that git-worktree supersedes git-alternates. Would
> > that be a fair statement? If yes, would it makes sense to deprecate
> > alternates for simplification?
> >
> > [1] https://git-scm.com/docs/git-worktree
> > [2] https://git-scm.com/docs/gitrepository-layout#gitrepository-layout-objectsinfoalternates
>
> It's not correct that worktrees supersede alternates, or the other
> way around, they're orthagonal features.
>
> git-worktree allows you to create a new working directory connected
> to the same local object store.
>
> Alternates allow you to declare in any given local object store,
> that your set of objects isn't complete, and you can find the rest
> at some other location, those object stores may or may not have more
> than one worktree connected to them.

  just to be clear here, there should be nothing about how alternates
are set up for a repository that should affect the normal behaviour of
working trees for that repository, correct? i never thought there was,
i just thought i'd make absolutely sure.

rday
--8323328-1101079944-1526463723=:7243--
