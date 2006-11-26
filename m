X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sat, 25 Nov 2006 22:14:21 -0500
Message-ID: <20061126031421.GC29394@spearce.org>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net> <ekafpm$fs7$1@sea.gmane.org> <7vvel3yuzz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 03:14:47 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vvel3yuzz.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32318>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoATX-00069q-Lq for gcvg-git@gmane.org; Sun, 26 Nov
 2006 04:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967252AbWKZDO1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 22:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967253AbWKZDO1
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 22:14:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:24549 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S967252AbWKZDO0
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 22:14:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GoAT7-0005Df-1P; Sat, 25 Nov 2006 22:14:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 61FB020FB09; Sat, 25 Nov 2006 22:14:22 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > The question is: do we continue to use remotes/ file, or do we
> > save remotes info in the config file: remote.<name>.url,
> > remote.<name>.fetch, remote.<name>.push and branch.<name>.merge
> > (in our case '[remote "origin"]' section)?
> 
> It is not "the question"; it is irrelevant because
> $GIT_DIR/remotes/origin and [remote "origin"] are pretty much
> interchangeable, and will hopefully continue to be.

I'm all for:

 * changing the default made git-clone to be [remote "<origin>"]
 * continuing to support parsing of $GIT_DIR/remotes/*

We moved away from the $GIT_DIR/branches directory to
$GIT_DIR/remotes, yet we still support $GIT_DIR/branches in
remote handling code.  I see no reason why we cannot start to use
remote.<name>.url by default while continuing to support the older
branches and remotes formats.

For one thing the newer remote.<name>.fetch seems to make more sense
to new users than Pull: lines do.  For another it appears to be
supported since v1.4.0, which was released June 10th.  Most users
cloning a repository with >1.4.4.1 will probably only use 1.4.0
or later on that same repository, so there is probably low risk of
breakage due to the remote not being recognized by a pre-1.4.0 Git.

-- 
