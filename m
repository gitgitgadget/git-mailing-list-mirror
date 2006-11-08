X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Did anyone have trouble learning the idea of local vs. remote branches?
Date: Wed, 8 Nov 2006 01:10:20 -0500
Message-ID: <20061108061020.GF28498@spearce.org>
References: <20061107172450.GA26591@spearce.org> <eiqi3f$ouq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 06:10:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <eiqi3f$ouq$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31123>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghgdt-0006y4-99 for gcvg-git@gmane.org; Wed, 08 Nov
 2006 07:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754345AbWKHGK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 01:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbWKHGK0
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 01:10:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52422 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1754345AbWKHGKZ
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 01:10:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ghgdj-0002f9-Lo; Wed, 08 Nov 2006 01:10:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 B899A20E487; Wed,  8 Nov 2006 01:10:20 -0500 (EST)
To: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Sender: git-owner@vger.kernel.org

Salikh Zakirov <Salikh.Zakirov@Intel.com> wrote:
> I think that the particular issue with the workflow in my organization
> could have been solved by the git-checkout and git-clone hybrid
> 
>     git-checkout ssh://path.to/repo.git#branch [work_dir]
> 
> which would clone repository with just one branch and setup the remotes
> file accordingly (The syntax is completely made up, of course)

Right; that would help us to but developers really want two mainline
branches locally (stable and slightly less stable) as they access
them frequently.

Hence the "git clone --only a,b" syntax that was floating around
on the mailing list the past few days.  Of course no implementation
exists yet...
 
> - there is a "mainline" branch of development, kept as ssh-shared git repository
> - mainline commits require some pre-commit testing, which takes ~1.5 hours,
>   so people tend not to commit to mainline too often. On average, a given
>   person commits to mainline once or twice a week.
> - mainlines commits also require a fellow developer review, that's where
>   topic branches come in handy. Topic branches are also useful for testing,
>   as pre-commit testing should be run on several different platforms, thus
>   on a different machines. Topic branches are kept on the same shared server.

Pretty much the same workflow here; except that instead of a 1.5
hour testing requirement to move code into the mainline we have a
several day manual process where humans redo the changes that were
already made in git in the "real" SCM.

Usually humans screw up redoing those changes and it takes a few more
days to figure out why a topic branch it Git that works correctly
fails to even compile in the mainline.  So we don't push to the
mainline often.

-- 
