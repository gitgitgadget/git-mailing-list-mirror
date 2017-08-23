Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A001C208CD
	for <e@80x24.org>; Wed, 23 Aug 2017 08:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbdHWIG1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 04:06:27 -0400
Received: from ikke.info ([178.21.113.177]:33896 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753386AbdHWIGY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 04:06:24 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id E8270440133; Wed, 23 Aug 2017 10:03:28 +0200 (CEST)
Date:   Wed, 23 Aug 2017 10:03:28 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to force a push to succeed?
Message-ID: <20170823080328.GE3839@alpha.vpn.ikke.info>
References: <CAH8yC8=A0-geqduTNNJw0yb1BREqsB75_bKSp+06Rb5fY6oiuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8=A0-geqduTNNJw0yb1BREqsB75_bKSp+06Rb5fY6oiuQ@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 05:55:25PM -0400, Jeffrey Walton wrote:
> I tested some changes that lead to a dead end. The changes need to be
> removed. The changes were added in 7 commits.
> 
> I went back in time to the point before the changes:
> 
>     $ git reset --hard HEAD~7
>     HEAD is now at 559fc3b Fix benchmark selection code (GH #464)
> 
> When I attempted to push:
> 
>     $ git push
>     Username for 'https://github.com': noloader
>     To https://github.com/noloader/cryptopp.git
>      ! [rejected]        master -> master (non-fast-forward)
> 
> I tried to commit, but Git claims there's nothing to add:
> 
>     $ git commit
>     On branch master
>     Your branch is behind 'origin/master' by 7 commits, and can be
> fast-forwarded.
> 
> Commit seems to be the wrong command as Git appears to be trying to do
> something I don't want.
> 
> How do I force the push to succeed?
> 
> Thanks in advance.

By actually doing a force push:

    git push --force-with-lease origin master

But note that this can interfere with others working on the same
repository, so be carefull when you use a force push.

Additionally, I can recommend using separate branches for things that
might turn up as dead ends (or even for every development). That way,
you can just throw away the branch if you want to discard it.

Hope this helps, Kevin.


