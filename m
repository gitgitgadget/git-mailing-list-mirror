Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E98E201A4
	for <e@80x24.org>; Tue, 16 May 2017 10:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbdEPKij (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 06:38:39 -0400
Received: from ikke.info ([178.21.113.177]:40356 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752776AbdEPKii (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 06:38:38 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id C1E8F4400AE; Tue, 16 May 2017 12:38:36 +0200 (CEST)
Date:   Tue, 16 May 2017 12:38:36 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Thomas Schweikle <tschweikle@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Cant clone/pull/fetch because of "Unable to create temporary
 file '$HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_'
Message-ID: <20170516103836.GB2169@alpha.vpn.ikke.info>
References: <cf9ce8e9-a358-4fdf-aa7c-a8ab76b6429a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf9ce8e9-a358-4fdf-aa7c-a8ab76b6429a@gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 12:28:58AM +0200, Thomas Schweikle wrote:
> $ git clone
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> linux-stable
> Cloning into 'linux-stable'...
> remote: Counting objects: 5932092, done.
> remote: Compressing objects: 100% (154131/154131), done.
> fatal: Unable to create temporary file
> '$HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX': Permission
> denied
> fatal: index-pack failed
> 
> Since no file/directory created by git I cant tell why git isn't
> able to create
> "$HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX".
> 
> If I try to create this file and directory I can create it:
> $ mkdir -p $HOME/Dev/linux-stable/.git/objects/pack
> $ touch $HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX
> $ ll $HOME/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX
> -rw-rw-r-x+ 1 tps tps 0 May 15 00:18
> /home/tps/Dev/linux-stable/.git/objects/pack/tmp_pack_XXXXXX
> $
> 
> $ git --version
> git version 2.11.0
> 
> -- 
> Thomas

Note the '+' at the end of the permission list. This means an acl has
been applied to this directory.

What does getfacl
'$HOME/Dev/linux-stable/.git/objects/pack/' return?
