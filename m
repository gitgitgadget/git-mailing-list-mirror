X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not so large)?
Date: Wed, 15 Nov 2006 17:16:16 -0500
Message-ID: <20061115221616.GD24861@spearce.org>
References: <455B90AD.3060707@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 22:16:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <455B90AD.3060707@freescale.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31514>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkT3P-0004qC-F3 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 23:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161727AbWKOWQU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 17:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161977AbWKOWQU
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 17:16:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:63148 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161727AbWKOWQT
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 17:16:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GkT3A-0007wz-VG; Wed, 15 Nov 2006 17:16:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 3166A20FB0B; Wed, 15 Nov 2006 17:16:16 -0500 (EST)
To: Timur Tabi <timur@freescale.com>
Sender: git-owner@vger.kernel.org

Timur Tabi <timur@freescale.com> wrote:
> After doing a "make mrproper" in my Linux git tree, the result is still 
> 1.1GB of files.  Compare that with just the tarball, which is just 
> one-forth the size.
> 
> Is there a way to "trim away" old commits from the repository, so that it 
> just doesn't take up that much space?  I don't care about any commits made 
> in 2005. As long as I can still do "git pull" from the source repo to 
>  update mine, that's good enough.

No.  However...

Have you tried "git repack -a -d" to repack the loose objects into
a pack file?  Doing this every so often should reduce your disk
space consumed by a HUGE amount.

-- 
