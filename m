Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 805FA2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 12:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbdKUMHl (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 07:07:41 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:44808 "EHLO mail.cixit.se"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751609AbdKUMHl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 07:07:41 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
        by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id vALC7VpJ029152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 Nov 2017 13:07:31 +0100
Received: from localhost (peter@localhost)
        by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id vALC7VXd029148;
        Tue, 21 Nov 2017 13:07:31 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Date:   Tue, 21 Nov 2017 13:07:31 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Elijah Newren <newren@gmail.com>
cc:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: cherry-pick very slow on big repository
In-Reply-To: <CABPp-BE-bJnLTf7Y-6_uy=+QA2pi=6EAmGy8S2n7B5Ry8ckHuA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1711211303290.20686@ds9.cixit.se>
References: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se> <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net> <alpine.DEB.2.00.1711101333030.2391@ds9.cixit.se> <7e242038-50e5-2cfc-e810-401af78b8cdc@gmail.com> <alpine.DEB.2.00.1711101436270.2391@ds9.cixit.se>
 <CABPp-BEu_DOg5t0qHnyLYSok+J+onGFPoFBbgp9P-S5JfhcRjw@mail.gmail.com> <alpine.DEB.2.00.1711131221150.22867@ds9.cixit.se> <CABPp-BE-bJnLTf7Y-6_uy=+QA2pi=6EAmGy8S2n7B5Ry8ckHuA@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 21 Nov 2017 13:07:31 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren:

> Sure, take a look at the big-repo-small-cherry-pick branch of
> https://github.com/newren/git

With those changes, the time usage is the same as if I set 
merge.renameLimit=1 for the repository, and the end result is identical:

$ time /usr/local/stow/git-v2.15.0-323-g31fe956618/bin/git cherry-pick 
-x 717eb328940ca2e33f14ed27576e656327854b7b
[redacted 19be3551bc] Redacted
  Author: Redacted <redacted>
  Date: Mon Oct 16 15:58:05 2017 +0200
  1 file changed, 2 insertions(+), 2 deletions(-)

real    0m15,345s
user    0m14,908s
sys     0m0,528s

Thanks!

-- 
\\// Peter - http://www.softwolves.pp.se/
