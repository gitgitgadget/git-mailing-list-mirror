Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166A3C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 16:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B3120702
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 16:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbgAXQIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:08:34 -0500
Received: from a3.inai.de ([88.198.85.195]:54558 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgAXQIe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 11:08:34 -0500
Received: by a3.inai.de (Postfix, from userid 25121)
        id 1C04058762489; Fri, 24 Jan 2020 17:08:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 1B3A060C531EB;
        Fri, 24 Jan 2020 17:08:33 +0100 (CET)
Date:   Fri, 24 Jan 2020 17:08:33 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Derrick Stolee <stolee@gmail.com>
cc:     git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
Subject: Re: Misrendering of git 2.24 log --graph
In-Reply-To: <b64e8fb7-1dd3-439f-6ab1-1b88c52879d1@gmail.com>
Message-ID: <nycvar.YFH.7.76.2001241652250.32144@n3.vanv.qr>
References: <nycvar.YFH.7.76.2001232353220.26179@n3.vanv.qr> <b64e8fb7-1dd3-439f-6ab1-1b88c52879d1@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Friday 2020-01-24 15:05, Derrick Stolee wrote:
>> I have observed git 2.24 outputting a garbage graph element for a 
>> particular history.
>
>I initially thought you were right, as 2.25 did include some new
>rendering, and we've already found and fixed a regression [1] and
>a style issue [2].
>[...]
>Here is something I noticed: this does not reproduce without a
>commit-graph! That's likely because it changes the order of the
>initial refs. Keep that in mind for anyone trying to repro this.

Curiously, I need no --mirror for `git clone`, the default clone
operation is just fine. It has, as far as I can remember back,
always downloaded all origin:refs/heads/* and refs/tags/*.

>However, I see this output with 2.24.1:

>| | | _   
>| | * 79106b731 doc: update 8.7.x news
>
>and this output in 2.25.0 [...]
>
>Is it possible that you are not running the version you think you are?

I rerun my checks as I write this mail. The observations:

 * Built v2.23.0 from source, ran it via `../tmpdir/git/git log --andsoon`,
   shows said underscore.
 * Built v2.24.0 from source, shows underscore
 * Built v2.24.1 from source, shows underscore
 * Used v2.24.1 from distro (/usr/bin/git), renders underscore
 * Built ead10bacc466a409490fb743d7805893976f8f53 (most recent 
   branch join not having v2.25 as an ancestor) from src, 
   shows underscore
 * Built v2.25.0 from source, new rendering
 * Built 631a7dec11, same as v2.25.0
 * Built 631a7dec11^, same as v2.25.0
