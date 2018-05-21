Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2821F42D
	for <e@80x24.org>; Mon, 21 May 2018 10:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeEUKcu (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 06:32:50 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:59382 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbeEUKcs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 06:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kKNwEeJa2SDzsT+i7XrWC66yfPUBe/AjowLOX2iAQIs=; b=Y/ervM9C7LIG0+roBlhh0WG5cn
        dGklAfDkqWhWT/CND8eEo0/dxB+SUFjx+oi2FPQOwpNOXbJ/WonxdItNNhegG5u0VFrWmUUzHA/qZ
        tASGWMAuhRW2fvLD4rP0pRMZZaSR6tU1ZQez39DQ1Cv1t98V7c5weI/jS2x+5iFe2YVo3y2e60QtQ
        KdwylW30DU1p8+Lt/1bvxFJBrfsVGLFzNrcj3YIvdiQfoAGx1h7JECqlSoohNgS8Uk2CklGn2DLjH
        DyzFyLudYZyDmCdabkO18TUR7cb5U/3EP6khua5NTpwqhHzJCzhUBoYbHPLUAspYnwBHBCWbXQAIv
        QJHeGbOQ==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:42618 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fKi7Q-00Erok-Oa
        for git@vger.kernel.org; Mon, 21 May 2018 06:32:46 -0400
Date:   Mon, 21 May 2018 06:31:13 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: issues(?) installing git-lfs via fedora "dnf" command
Message-ID: <alpine.LFD.2.21.1805210625410.6679@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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


  first, i realize this is almost entirely a fedora packaging issue
and i'm planning on reporting it there, but i just want to make sure
i'm not doing something stupid.

  knowing nothing about the git-lfs package, i thought i would install
it and just poke around out of sheer curiosity, so on my fully-updated
fedora 28 system, i ran:

  $ sudo dnf install git-lfs

which did in fact install that package, but also generated (abridged
version):

  ... snip ...
  Running transaction
    Preparing        :
    Installing       : git-lfs-2.4.0-1.fc28.x86_64
    Running scriptlet: git-lfs-2.4.0-1.fc28.x86_64
  Error: Failed to call git rev-parse --git-dir --show-toplevel: "fatal:
  not a git repository (or any of the parent directories): .git\n"

  Git LFS initialized.
    Verifying        : git-lfs-2.4.0-1.fc28.x86_64

  Installed:
    git-lfs.x86_64 2.4.0-1.fc28

is one supposed to be *in* a git repository when installing, because i
was in fact at the top level of my linux kernel source repo, so i'm
unclear on what that "Error" is trying to tell me. am i just being
clueless? is this something that i should submit as a fedora packaging
issue?

rday
