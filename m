X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 07:05:18 -0500
Message-ID: <20061214120518.GL1747@spearce.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <200612141136.59041.andyparkins@gmail.com> <20061214114546.GI1747@spearce.org> <8764ce6654.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 12:05:28 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <8764ce6654.wl%cworth@cworth.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34327>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GupL4-0001VH-Eb for gcvg-git@gmane.org; Thu, 14 Dec
 2006 13:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932681AbWLNMFX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 07:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbWLNMFX
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 07:05:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37449 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932681AbWLNMFW (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 07:05:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GupKu-0001Le-PO; Thu, 14 Dec 2006 07:05:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 EB11F20FB65; Thu, 14 Dec 2006 07:05:18 -0500 (EST)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> wrote:
> This when-you-first-learn-you-want-them-it's-too-late-to-get-them
> aspect of ref logs is really annoying. It sets up an unkind trap for
> users.

Yes.  Which is why its in my ~/.gitconfig.  :-(
 
> I know several people have suggested they be enabled by
> default. What's the status of that suggestion?  Rejected? Just
> awaiting a patch?

Its been suggested and discussed.

But the problem raised is that there are many types of repositories,
and not all should always have reflogs enabled, and its hard to
tell which one should and which shouldn't by default, and its even
worse to force it into a user's ~/.gitconfig as then repositories
which should not have reflogs are getting them anyway.

 * Normal working repository (wants reflogs);
 * Bare private (backup) repository (wants reflogs);
 * Bare shared repository (probably doesn't want reflogs);
 * Import generated repository (probably doesn't want reflogs);

...

Find a way to make git-init-db know the difference magically and
you'll probably see a patch emerge quickly afterwards.  But right
now I don't think anyone really has a great solution to the problem.

I know Junio wrote something on this not too long ago (and it was a
good writeup too) but I can never find threads in gmane's archives,
so I'm just going to leave that to someone else...

-- 
