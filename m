Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96EE1208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbdHOTZv (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:25:51 -0400
Received: from ikke.info ([178.21.113.177]:54048 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbdHOTZu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:25:50 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 81FC8440119; Tue, 15 Aug 2017 21:25:43 +0200 (CEST)
Date:   Tue, 15 Aug 2017 21:25:43 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Kim Birkelund <kim@birkelund.me>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git clean -fdx deletes tracked files
Message-ID: <20170815192543.GB3839@alpha.vpn.ikke.info>
References: <CAOCG=_p--J5PKGrQTdquMvcBNQs67MNaN3vM8Tbwn2nZNwVR+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCG=_p--J5PKGrQTdquMvcBNQs67MNaN3vM8Tbwn2nZNwVR+Q@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 08:45:20PM +0200, Kim Birkelund wrote:
> Hi
> 
> I hope this is gonna sound as weird to you as it does to me.
> 
> The link below is a zip of a small git repository that I can reproduce
> the bug in on 2 machines.
> 
> Repo: https://www.dropbox.com/s/fz4d0i5ko7s7ktr/test.zip?dl=0
> 
> It contains 2 folders: helpers and b, each of which is an empty npm
> module. b\package.json refers to the helpers module.
> 
> The following reproduces the bug:
> 
> 1) in terminal cd to the b folder
> 2) run npm install
> 3) run git reset HEAD --hard
> 4) run git clean -fdx
> 
> At this point both files in the helpers folder has been deleted and
> running git status confirms this.
> 
> Tool version:
> 
> git --version => git version 2.10.2.windows.1
> node -v => v6.11.2
> npm -v => 5.3.0
> 
> 
> I have no idea what is going. Very much hope you can explain :-)

I cannot reproduce it on linux.

git clean -fdx output:

  Removing node_modules/
  Removing package-lock.json

These are all untracked, and nothing in the helpers dir is being
removed.

