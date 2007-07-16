From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [WIP PATCH 6/6] notes: add notes-index for a substantial speedup.
Date: Mon, 16 Jul 2007 02:01:17 -0400
Message-ID: <20070716060117.GF32566@spearce.org>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site> <Pine.LNX.4.64.0707160025480.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 08:01:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAJeH-0007Xn-Il
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 08:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbXGPGB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 02:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755738AbXGPGB2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 02:01:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48570 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990AbXGPGB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 02:01:27 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IAJe4-0000Qc-Gk; Mon, 16 Jul 2007 02:01:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A41A220FBAE; Mon, 16 Jul 2007 02:01:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707160025480.14781@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52643>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Actually, this commit adds two methods for a notes index:
> 
> - a sorted list with a fan out to help binary search, and
> - a modified hash table.
> 
> It also adds a test which is used to determine the best algorithm.

I know this is a nice backwards compatible way to organize notes,
and to make them reasonably efficiently found, but I'd almost
rather just see them crammed into the packfile alongside of the
commit it annotates, so that the packfile reader can quickly find
the annotation at the same time it finds the commit.

aka packv4.

Ok, enough dreaming for today.

-- 
Shawn.
