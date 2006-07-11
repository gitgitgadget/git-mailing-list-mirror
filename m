From: Shawn Pearce <spearce@spearce.org>
Subject: Why doesn't git-rerere automatically commit a resolution?
Date: Tue, 11 Jul 2006 02:16:26 -0400
Message-ID: <20060711061626.GB11822@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 11 08:16:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0BXu-00088l-SW
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 08:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWGKGQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 02:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWGKGQc
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 02:16:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58306 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965163AbWGKGQb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 02:16:31 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G0BXo-00079E-2Y
	for git@vger.kernel.org; Tue, 11 Jul 2006 02:16:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9B2F220E43C; Tue, 11 Jul 2006 02:16:26 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23689>

I'm curious... I have a pair of topic branches which don't merge
together cleanly by recursive (due to conflicting hunks in the
same line segments).  I enabled git-rerere, ran the merge, fixed
up the hunks and committed it.  git-rerere built its cache, as
the next time I pulled the two topic branches together and got
the same conflicts it correctly regenerated the prior resolution
(and printed a message saying as much).

But it git-rerere left the files unmerged in the index and it
doesn't generate a commit for the merge, even though there are no
merge conflicts remaining.  I expected it to update the index (to
merge the stages) and to generate a commit if possible; especially
in this case as I was pulling the exact same two commits together
again with the exact same merge base commit.

So I'm wondering why doesn't it try to finish the merge?  Was there
a really deep rooted reason behind it or was it simply easier/safer
to let the user sort out the working directory state every time?

-- 
Shawn.
