Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99BF61F407
	for <e@80x24.org>; Fri, 15 Dec 2017 13:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755612AbdLONKN (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 08:10:13 -0500
Received: from quechua.inka.de ([193.197.184.2]:46030 "EHLO mail.inka.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755389AbdLONKN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 08:10:13 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
        by mail.inka.de with uucp (rmailwrap 0.5) 
        id 1ePpkh-00057V-Si; Fri, 15 Dec 2017 14:10:11 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
        id 93A0D120192; Fri, 15 Dec 2017 14:06:45 +0100 (CET)
Date:   Fri, 15 Dec 2017 14:06:45 +0100
From:   Josef Wolf <jw@raven.inka.de>
To:     git@vger.kernel.org
Subject: Re: Need help migrating workflow from svn to git.
Message-ID: <20171215130645.GD18542@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20171214130933.GA18542@raven.inka.de>
 <5eb3fe18-864d-0b04-223e-d9e5cbf2c81e@gmail.com>
 <b25a828f-3f0a-7c0e-6722-9521238ce7f3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b25a828f-3f0a-7c0e-6722-9521238ce7f3@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 15, 2017 at 02:17:40AM +0100, Igor Djordjevic wrote:
> 
> This said, and without having you to change your habits too much (nor 
> use Git in possibly awkward ways), I`m thinking you may actually 
> benefit of using `git worktree add <temp_copy_path>`[1] to create a 
> temporary working tree ("working copy", as you say), alongside a 
> temporary branch, where you could hack and test as much as you want, 
> unaffected by cron job updating and executing the original working 
> copy/branch (also not stepping on cron job`s toes yourself).

Interesting command. Did not know about it. Will remembre it for other use
cases!

But in this case, it is not of much use. See, I am doing system configuration
with those scripts. Having two working trees would cause the configuration to
be restored every time cron happens to start the scripts.

Doing the modifications right there where cron executes has the benefit that
cron uses the same modifications which I am using. This way, whenever cron
decides to execute, it is exactly the same as if I would do a "make run" on
the command line. Since all the scripts are designed to be idempotent,
everything works pretty much flawlessly.

-- 
Josef Wolf
jw@raven.inka.de
