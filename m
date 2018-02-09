Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9980B1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeBITgb (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:36:31 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:37255 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeBITgb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:36:31 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:47046 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ekETG-0006BG-Ig
        for git@vger.kernel.org; Fri, 09 Feb 2018 14:36:30 -0500
Date:   Fri, 9 Feb 2018 14:36:28 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: totally confused as to what "git bisect skip" is supposed to do
Message-ID: <alpine.LFD.2.21.1802091431360.10982@localhost.localdomain>
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


  all right, i'm sure i'm just being an idiot, but i always thought i
knew what "git bisect skip" did and, now that i'm trying to put
together a simple example, i'm utterly confused so here's a stripped
down example.

  with linus kernel source code, start bisecting [v4.13,v4.14]:

$ git bisect start v4.14 v4.13
Bisecting: 7300 revisions left to test after this (roughly 13 steps)
[15d8ffc96464f6571ecf22043c45fad659f11bdd] Merge tag 'mmc-v4.14' of
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
$

  now, based on how linux kernel release candidates work, i want to
skip a sizable chunk of those revisions:

$ git bisect skip v4.14-rc1..v4.14-rc2
Bisecting: 7300 revisions left to test after this (roughly 13 steps)
[15d8ffc96464f6571ecf22043c45fad659f11bdd] Merge tag 'mmc-v4.14' of
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
$

  i'm confused ... why, after skipping a good chunk in the interval
[v4.13,v4.14], do i still have exactly 7300 revisions to bisect? what
am i so hopelessly misunderstanding here?

rday
