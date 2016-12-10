Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0F5203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 11:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbcLJLQp (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 06:16:45 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:40041 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbcLJLQo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 06:16:44 -0500
X-Greylist: delayed 142002 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Dec 2016 06:16:44 EST
Received: from ylum.localnet (unknown [IPv6:2a01:e34:edf7:4710:1366:30a:a1d9:15f1])
        (Authenticated sender: domi.dumont)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 5A5E613F8AA;
        Sat, 10 Dec 2016 12:16:39 +0100 (CET)
From:   Dominique Dumont <dod@debian.org>
To:     Duy Nguyen <pclouds@gmail.com>
Reply-To: dod@debian.org
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: read git config from parent directory
Date:   Sat, 10 Dec 2016 12:16:38 +0100
Message-ID: <4777019.UsV5sng9HM@ylum>
User-Agent: KMail/5.2.3 (Linux/4.8.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <CACsJy8AgbGXvMC0XWSPuBHEveJfJFEYUgghDC1Yc7Eka1Dyd8Q@mail.gmail.com>
References: <3881793.6JIRvg1BPW@ylum> <CACsJy8AgbGXvMC0XWSPuBHEveJfJFEYUgghDC1Yc7Eka1Dyd8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, 9 December 2016 19:38:05 CET Duy Nguyen wrote:
> >> Sounds like the same problem I have (and the reason I came up with
> >> conditional include [1]). Would that work for you (check out the
> >> example part in that patch)?
> > 
> > If I understand correcly, I would need to set up config include in each
> > git
> > repository. This is as much work as setting up user.email in the same
> > place.
> 
> Well, no. You set this up in ~/.gitconfig. If you need to add some
> settings in /abc/def/.gitconfig and expect repositories in this path
> to reach it via the parent chain, then you could write something like
> 
> [include "gitdir:/abc/def/"]
> file = your-config-file
> 
> in ~/.gitconfig and achieve the same effect, because all repos will
> read ~/.gitconfig, and if it finds out the repo's location is inside
> /abc/def, your-config-file will be loaded. It could contain email
> settings or whatever.
> 
> So, instead of spreading .gitconfig files around and relying on
> parent-chain to reach them, you write a few filter rules in
> ~/.gitconfig to tell all the repos what to load.

oh... yes, that would solve my problem and have no impact on other user who 
don't need this feature. 

I do hope that the improvement you proposed will be merged.

Thanks for the explanation.

All the best

-- 
 https://github.com/dod38fr/   -o- http://search.cpan.org/~ddumont/
http://ddumont.wordpress.com/  -o-   irc: dod at irc.debian.org
