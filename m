From: Shawn Pearce <spearce@spearce.org>
Subject: Porcelain specific metadata under .git?
Date: Wed, 14 Jun 2006 02:22:40 -0400
Message-ID: <20060614062240.GA13886@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 14 08:23:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqOmN-0002Z2-68
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 08:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWFNGWp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 02:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFNGWp
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 02:22:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39871 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750919AbWFNGWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 02:22:45 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FqOm2-0003tB-79
	for git@vger.kernel.org; Wed, 14 Jun 2006 02:22:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E821A20FB20; Wed, 14 Jun 2006 02:22:40 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21829>

So I'm reaching a point with my Eclipse plugin[*1*] where its
actually doing something with a GIT repository and I want to store a
ref (to a tree, not a commit) under .git/refs/eclipse-workspaces to
help the plugin cache state between workbench restarts.  But there
doesn't really seem to be any policy to what paths under .git are
available for Porcelain and what definately should be off-limits.

I already assume/know that refs/heads and refs/tags are completely
off-limits as they are for user refs only.

I also think the core GIT tools already assume that anything
directly under .git which is strictly a file and which is named
entirely with uppercase letters (aside from "HEAD") is strictly a
temporary/short-lived state type item (e.g. COMMIT_MSG) used by a
Porcelain.

But is saying ".git/refs/eclipse-workspaces" is probably able to
be used for this purpose safe?  :-)


[*1*] The Eclipse plugin is getting close to something that is worth
releasing as an early alpha for other developers.  I think I finally
found the last bug in the pack reading code and am now working on the
basic operations (add/remove/commit/status).  I hope to have all of
that working within a few days, at which point I'll publish/announce
a public GIT repository with the complete source code and an Eclipse
update site for those brave souls who might want to just install it.

-- 
Shawn.
