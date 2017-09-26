Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1549B202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 05:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935417AbdIZFPm (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 01:15:42 -0400
Received: from ikke.info ([178.21.113.177]:50396 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934095AbdIZFPl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 01:15:41 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 94B0F4403B1; Tue, 26 Sep 2017 07:15:39 +0200 (CEST)
Date:   Tue, 26 Sep 2017 07:15:39 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Sanggyu Nam <pokeplus@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: '--shallow-since' option is not available for git-pull in Git
 version 2.14.1
Message-ID: <20170926051539.GA22514@alpha.vpn.ikke.info>
References: <F3F7A768-C844-4D77-9403-53AC3F506080@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F3F7A768-C844-4D77-9403-53AC3F506080@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 04:31:10PM +0900, Sanggyu Nam wrote:
> I’ve found that some subcommands such as git-clone, git-fetch, and
> git-pull support an option named ‘--shallow-since’, as of Git version
> 2.11. This option is documented in the man page of each subcommand. In
> Git 2.14.1, I’ve checked that the option is available for git-clone
> and git-fetch so that the history of a shallow repository is updated.
> However, running git-pull with this option shows an error as follows:
> 
> error: unknown option `shallow-since=2017-09-10T00:00:00+00:00'
> 
> usage: git pull [<options>] [<repository> [<refspec>...]]
> ...
> 
> I found that this option is not available in Git 2.14.1 on macOS and
> Ubuntu 16.04.1. It seems the option handling of git-pull does not
> match with what’s described in the man page. Since ‘git pull’ is a
> shorthand for ‘git fetch’ followed by ‘git merge FETCH_HEAD’ in its
> default mode, we can run these two commands in this order as a
> workaround.
> 
> 

This does not only count for --shallow-since, but also --deepen
and --shallow-exclude.
