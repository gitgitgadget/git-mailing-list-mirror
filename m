Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2AD420A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 17:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeLHRdA (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 12:33:00 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:55442 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLHRdA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 12:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z0yKTi2y/2gdFIVNcd+Gq6WT6DjzDtXBamhlSFaCsoU=; b=tFjvj6KK/t4tsaZ/uju671wxQ
        wund/xC+RyPu4b9knWVujAbwOI7x+65mUi2Kwuzt0y/bZ5SKBT6jomda8ZVPw/+9T87T0pmI2d210
        qPBr7DoMH5kt9gPuTqCEoFsGpamvPrvHi6LdrF1wCoWWQ0Bu2RJrvYPb08HgwYk8tvZU2o6mRIaHh
        5OY8ffqS3xH2D/4SO5jJn+wszdGRwPXZnS1UhF3CoHmFeNzLPeewc1mC0xKAIjy8Eum+6A229iho/
        gB6c1drQ8E0wjPFMiV3WZdr8hOygMpwJRELDx9R10yK9OmpHEPQNjKNw4Sr3ftnxGCCwTq+a0Vx5N
        AsXIuLQLg==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:51992 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gVgTJ-0003Uw-Tx; Sat, 08 Dec 2018 12:32:58 -0500
Date:   Sat, 8 Dec 2018 12:32:55 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: why doesn't "git reset" mention optional pathspec?
In-Reply-To: <CACsJy8APyyAWM+L=HU1XM4V+qdTWqjto6x=Q06By8DbgtYfpCA@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1812081232240.32380@localhost.localdomain>
References: <alpine.LFD.2.21.1812081103500.29142@localhost.localdomain> <CACsJy8APyyAWM+L=HU1XM4V+qdTWqjto6x=Q06By8DbgtYfpCA@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 8 Dec 2018, Duy Nguyen wrote:

> On Sat, Dec 8, 2018 at 5:08 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >
> >   from "man git-reset":
> >
> > SYNOPSIS
> >   git reset [-q] [<tree-ish>] [--] <paths>...
> >   git reset (--patch | -p) [<tree-ish>] [--] [<paths>...]
> >   git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
> >
> > oddly, the third form says nothing about possible "<paths>", even
> > though i'm pretty sure they're valid in that third case (at least
> > for "--mixed"). thoughts? is that just an oversight in the man
> > page?
>
> --mixed prints a deprecation warning. I don't think it's worth
> making the synopsis more complicated for that. All other modes
> reject pathspec.

  i just tested this, and i don't see a deprecation warning.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
