X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: filemode=false somewhat broken
Date: Sat, 25 Nov 2006 01:10:34 -0500
Message-ID: <20061125061034.GA4528@spearce.org>
References: <17764.44236.473000.729015@lapjr.intranet.kiel.bmiag.de> <7vodqzp0mh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 06:10:54 +0000 (UTC)
Cc: Juergen Ruehle <j.ruehle@bmiag.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vodqzp0mh.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32255>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnqkQ-0003tb-RR for gcvg-git@gmane.org; Sat, 25 Nov
 2006 07:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757843AbWKYGKn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 01:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757844AbWKYGKn
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 01:10:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:62631 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757843AbWKYGKm
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 01:10:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GnqkH-0000sw-4t; Sat, 25 Nov 2006 01:10:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 D72D320FB09; Sat, 25 Nov 2006 01:10:34 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Juergen Ruehle <j.ruehle@bmiag.de> writes:
> 
> > Commit fd28b34afd9bbd58297a25edced3f504c9a5487a tried to ignore the
> > executable bit if filemode=false, but instead forced all files to be
> > regular with 644 permission bits nuking symlink support.
> 
> Thanks for noticing.  Yes, that change is _seriously_ broken.  I
> should really raise the bar for patch acceptance.

Whoops.

I don't work with symlinks so I never noticed the breakage myself.
Clearly the test cases that I created in fd28b3 should also have
included symlinks, but they did not...  and we see this breakage
occur.

-- 
