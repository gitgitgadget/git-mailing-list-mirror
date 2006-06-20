From: Shawn Pearce <spearce@spearce.org>
Subject: Packing empty subtrees: good/bad/indifferent?
Date: Mon, 19 Jun 2006 20:09:59 -0400
Message-ID: <20060620000958.GA4877@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 20 02:10:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsTon-00012h-1e
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 02:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWFTAKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 20:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWFTAKF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 20:10:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38034 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965006AbWFTAKD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 20:10:03 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FsToV-0005A4-F5
	for git@vger.kernel.org; Mon, 19 Jun 2006 20:09:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 81C5A20FB1F; Mon, 19 Jun 2006 20:09:59 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22150>

So in my Eclipse plugin/Java GIT implementation I'm trying to figure
out what to do if the API caller feeds me a subtree which is empty.

Core GIT won't store an empty subtree simply because the subtree
can't exist in the index without at least one file in the tree.
But my Java implementation doesn't suffer from that limitation and
will happily store an empty subtree (and checkout an empty directory)
if that is what the caller gave it.  :-)

In the plugin's UI level I'm trying relatively hard to refuse putting
an empty directory into the repository as an empty subtree but I'm
now wondering if I should enforce that even lower (like down in
the actual tree writer) just to be on the safe side.

Anyone have two cents they could share on the matter?

-- 
Shawn.
