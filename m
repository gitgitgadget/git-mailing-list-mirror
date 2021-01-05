Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D06C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 05:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D427225AB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 05:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbhAEFqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 00:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAEFqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 00:46:16 -0500
Received: from vps892.directvps.nl (unknown [IPv6:2a02:2308::216:3eff:fede:83d0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2162C061574
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 21:45:35 -0800 (PST)
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 8183444012C; Tue,  5 Jan 2021 06:45:30 +0100 (CET)
Date:   Tue, 5 Jan 2021 06:45:30 +0100
From:   Kevin Daudt <me@ikke.info>
To:     stratus@tuta.io
Cc:     git@vger.kernel.org
Subject: Re: git tag truncates tag list
Message-ID: <X/P8+jZFs6LYoR6A@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>, stratus@tuta.io,
        git@vger.kernel.org
References: <MQFZ9EW--3-2@tuta.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MQFZ9EW--3-2@tuta.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 05, 2021 at 04:39:20AM +0100, stratus@tuta.io wrote:
> Dear git,
> git tag misses out some tags from this repo here, there seem to be too many to show:
> 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
> 
> It cuts the list short, losing either the latest ones with simply 
> git tag
>  or the earliest using either 
> git tag  --sort=-creatordate
>   or 
> git tag --sort=-taggerdate
> 
>  Is there some config option somewhere to show the full list?
> 

That sounds like an issue with the pager. Does `git --no-pager tag` show
all tags?

What do the following things return:

  echo $LESS
  echo $GIT_PAGER
  git config core.pager
  git config pager.tag
  
Kind regards, Kevin
