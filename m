From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: how to speed up "git log"?
Date: Sun, 11 Feb 2007 18:00:35 -0500
Message-ID: <20070211230035.GD31488@spearce.org>
References: <200702111252.28393.bruno@clisp.org> <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruno Haible <bruno@clisp.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:00:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGNga-0002Sb-Jj
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbXBKXAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932917AbXBKXAk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:00:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51967 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914AbXBKXAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:00:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGNgJ-0003So-6J; Sun, 11 Feb 2007 18:00:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2588F20FBAE; Sun, 11 Feb 2007 18:00:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39322>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 1) Why so much user CPU time?
> 
> See above.

Some of the ideas Nico and I have kicked around for a pack v4 (post
1.5.0, obviously) would speed up revision traversal by bypassing
some of the costly decompression overheads.
 
> > 2) Why so much system CPU time, but only on MacOS X?
> 
> Probably the mmap() problem. Does it go away when you use git 1.5.0-rc4?

What does 1.5.0-rc4 do here that didn't happen before?  Are you
referring to the mmap sliding window?  Because NO_MMAP might be
faster on MacOS X then using mmap (thanks to its slower mmap)... but
I can't say I have performance tested it either way.

-- 
Shawn.
