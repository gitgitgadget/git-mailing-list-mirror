From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Packfile can't be mapped
Date: Tue, 29 Aug 2006 01:33:12 -0400
Message-ID: <20060829053312.GB24594@spearce.org>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com> <20060828024720.GD24204@spearce.org> <20060829045239.GB24479@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 29 07:33:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHwEC-0007R2-VL
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 07:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWH2Fd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 01:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWH2Fd3
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 01:33:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:13033 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751099AbWH2Fd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 01:33:28 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GHwE0-0005Fe-8T; Tue, 29 Aug 2006 01:33:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ED1C020FB7F; Tue, 29 Aug 2006 01:33:12 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060829045239.GB24479@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26189>

Shawn Pearce <spearce@spearce.org> wrote:
> This tree delta version came out pretty good.  The pack with tree
> deltas is 874 MiB.  Quite a reduction in size.  fast-import takes
> about 20 minutes to convert its 20 GiB input file into this 874 MiB
> pack.  Producing the 20 GiB input file from the 3 GiB CVS ,v
> files takes about 4 hours with Jon's modified cvs2svn.
> 
> Jon has started a `git-repack -a -f` with aggressive depth and
> window sizes.  He estimated it may need another 2.5 hours to process.
> Hopefully I'll hear more details tomorrow.

I just heard from Jon:
> git-repack -a -f --window=50 --depth=5000
> 100% CPU for 60 minutes
> 1.2GB resident memory
> Final pack size is 451,203,363 bytes.

So with very agressive delta depth and window sizes git-repack took
a while to run but came very close to the best packed size from
previous Mozilla CVS import attempts.  I think we'd still like to
make the final historical pack smaller than that.

-- 
Shawn.
