From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 18:11:26 -0400
Message-ID: <20070403221126.GM27706@spearce.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org> <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com> <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704031322490.6730@woody.linux-foundation.org> <alpine.LFD.0.98.0704031657130.28181@xanadu.home> <Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org> <alpine.LFD.0.98.0704031735470.28181@xanadu.home> <7vodm5un61.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:11:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYrEC-0000B8-DG
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 00:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946010AbXDCWLp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 18:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946011AbXDCWLp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 18:11:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52863 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946010AbXDCWLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 18:11:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYrDj-0005vx-D9; Tue, 03 Apr 2007 18:11:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0E10320FBAE; Tue,  3 Apr 2007 18:11:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vodm5un61.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43680>

Junio C Hamano <junkio@cox.net> wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
> > Make it conditionnal on --stdin then.  This covers all cases where we 
> > really want the secure thing to happen, and the --stdin case already 
> > perform the atomic rename-and-move thing when the pack is fully indexed.
> 
> Repacking objects in a repository uses pack-objects without
> using index-pack, as you suggested Chris.  Is there a sane usage
> of index-pack that does not use --stdin?  I do not think of any.
> 
> If there isn't, the "conditional on --stdin" suggestion means we
> unconditionally do the secure thing for all the sane usage, and
> go unsecure for an insane usage that we do not really care about.
> 
> If so, it seems to me that it would be the simplest not to touch
> the code at all, except that missing free().
> 
> Am I missing something?

Nope. I agree with you completely.

-- 
Shawn.
