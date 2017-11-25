Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BBF220954
	for <e@80x24.org>; Sat, 25 Nov 2017 18:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbdKYSvE (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 13:51:04 -0500
Received: from gproxy10-pub.mail.unifiedlayer.com ([69.89.20.226]:40522 "EHLO
        gproxy10-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751156AbdKYSvC (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2017 13:51:02 -0500
X-Greylist: delayed 1490 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Nov 2017 13:51:02 EST
Received: from cmgw2 (unknown [10.0.90.83])
        by gproxy10.mail.unifiedlayer.com (Postfix) with ESMTP id E6437140572
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 11:26:09 -0700 (MST)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmgw2 with 
        id eJS61w00N0QvKlu01JS9iF; Sat, 25 Nov 2017 11:26:09 -0700
X-Authority-Analysis: v=2.2 cv=dZfw5Tfe c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=sC3jslCIGhcA:10 a=-tvoqAE7v2l1TXM1_9cA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kAJuIpw1axKTyqXtxg4xI2XbCikRWrzqezS3qmsr+Qo=; b=eT+LRceCIXBRY8h1JDUCCQitsU
        5Qk+RPYyMsJfTUn+AtF999Xf6P650HOtpOZaFV0OECEOCFhBi+vRVbP5hnHHD8zMoSh8GpbC0OCBt
        rhC/qftzIuoMtff0zbwaYw81w;
Received: from pool-74-104-137-100.bstnma.fios.verizon.net ([74.104.137.100]:38326 helo=homebase)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <paul@mad-scientist.net>)
        id 1eIf9S-002XYx-68
        for git@vger.kernel.org; Sat, 25 Nov 2017 11:26:06 -0700
Message-ID: <1511634365.2847.211.camel@mad-scientist.net>
Subject: Re: [PATCH v4 4/4] worktree: make add <path> dwim
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     git@vger.kernel.org
Date:   Sat, 25 Nov 2017 13:26:05 -0500
In-Reply-To: <20171125175010.GB14993@hank>
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
         <20171122223020.2780-1-t.gummerer@gmail.com>
         <20171122223020.2780-5-t.gummerer@gmail.com>
         <xmqq1skonoaw.fsf@gitster.mtv.corp.google.com>
         <20171125175010.GB14993@hank>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 74.104.137.100
X-Exim-ID: 1eIf9S-002XYx-68
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-74-104-137-100.bstnma.fios.verizon.net (homebase) [74.104.137.100]:38326
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-11-25 at 17:50 +0000, Thomas Gummerer wrote:
> This would be the output in the new version:
> 
>      $ git worktree add ../bla
>      Branch 'bla' set up to track remote branch 'bla' from 'origin'.
>      Preparing ../bla (identifier bla)
>      HEAD is now at 4aade43 bla
> 
> vs. the output without the changed behaviour:
> 
>      $ git worktree add ../bla
>      Preparing ../bla (identifier bla)
>      HEAD is now at 0f215c9 initial import
> 
> Of course that assumes that it's used directly, not in scripts, and
> that users will actually read the output of the command when they
> invoke it.  Maybe these are not safe assumptions to make though, and
> we'd rather not have this on by default then.  As I mentioned
> previously I would prefer having this as default, but I'm happy to
> hide this behaviour behind a flag if we want to be more careful about
> introducing this.  Dunno?

Speaking as a simple user, I find the current behavior of Git worktree
add very frustrating; I am constantly wanting to create worktrees for
other peoples' branches so I can look at the code there without messing
up my workspace, and it's really inconvenient to do that now.

Also, the current special handling of the directory name as a putative
branch name is not helpful for me because many of the branches I need
to examine use "/" as their separator.  I don't begrudge making that
feature more "DWIM" for those that can use it, but hopefully some help
is forthcoming for those who can't.

For example, I need to create a local worktree for the remote rel/1.0
branch... what do I do?

What I want to work is this:

    git worktree add ../1.0 rel/1.0

and have it create a worktree at ../1.0, then do the equivalent of "git
checkout rel/1.0" which includes setting up to track the remote branch.
 But of course this doesn't work at all; I get:

    fatal: invalid reference: rel/1.0

Personally I would think it odd to have to add an extra flag to get
what I would expect would be "normal" behavior (checkout).

But maybe that's just me.
