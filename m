Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 092631F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 15:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbcJKPlk (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 11:41:40 -0400
Received: from ikke.info ([178.21.113.177]:51672 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753133AbcJKPlj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 11:41:39 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 82C0F4401D4; Tue, 11 Oct 2016 17:41:37 +0200 (CEST)
Date:   Tue, 11 Oct 2016 17:41:37 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Michael Tutty <mtutty@gforgegroup.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Rappazzo <rappazzo@gmail.com>
Subject: Re: Bug? git worktree fails with master on bare repo
Message-ID: <20161011154137.GA20160@ikke.info>
References: <CAOi_75+2SG2WYHBMQhfGj96eKsZ66niJzOevVGM5eJv-qqrVNg@mail.gmail.com>
 <1475999513.7410.8.camel@kaarsemaker.net>
 <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
 <CAOi_75+Zoeeq5FD1HKgG4MjeL9LkBshsSfdrMOTi8m-Mt-OQNQ@mail.gmail.com>
 <CACsJy8DMKWeZ+DuQ0uoY6rdPfusq8D1SfBCkPyn+6X9S589ncg@mail.gmail.com>
 <CAOi_75KR+AEAD540L=GtQ7jH5ngTFdHMq53+FzjzAfsZtTqfwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi_75KR+AEAD540L=GtQ7jH5ngTFdHMq53+FzjzAfsZtTqfwg@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 08:06:47AM -0500, Michael Tutty wrote:
> 
> > If source repo's HEAD is "master", I got the same behavior (worktree add fails)
> 
> So if it's possible for a bare repo to have HEAD pointing at master,
> is there a safe way for me to change this (e.g., as a cleanup step
> before doing my actual merge process)?

You can change where HEAD points to in a bare repositor with `git
symbolic-ref HEAD <branch>`, but note that this changes what branch gets
checked out when cloning a repository. 

Where users would normally check out master by default, after changing
what HEAD points to, it would be that branch (or detached when HEAD
doesn't even point at a branch).
