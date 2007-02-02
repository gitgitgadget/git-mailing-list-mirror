From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Teach 'git remote' how to cleanup stale tracking branches.
Date: Fri, 2 Feb 2007 01:13:59 -0500
Message-ID: <20070202061359.GB20719@spearce.org>
References: <58b74d176fd10417a58d42d9437c631d03f4c4f6.1170392736.git.spearce@spearce.org> <20070202050608.GB20505@spearce.org> <7v4pq5ks9i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 02 07:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCrgd-0007r0-Tq
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 07:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423127AbXBBGOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 01:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423129AbXBBGOF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 01:14:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37990 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423127AbXBBGOE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 01:14:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCrgP-0004TF-IE; Fri, 02 Feb 2007 01:14:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2CD9320FBAE; Fri,  2 Feb 2007 01:14:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v4pq5ks9i.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38460>

Junio C Hamano <junkio@cox.net> wrote:
> If you are disconnected, would it fail gracefully without
> removing stuff?  From a cursory look it should, but just making
> sure.

Indeed, it crashes out:
 
	$ ./git-remote prune cs-src
	ssh: host.that.exists: No address associated with nodename
	fatal: The remote end hung up unexpectedly
	ls-remote --heads cs:sw/src/git: command returned error: 1
	[git (sp/remote)]$ ls .git/refs/remotes/cs-src/
	.       ..      master

and the refs are still safe.

-- 
Shawn.
