From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 18:38:40 -0400
Message-ID: <20070403223840.GN27706@spearce.org>
References: <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com> <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org> <alpine.LFD.0.98.0704031625050.28181@xanadu.home> <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org> <20070403210319.GH27706@spearce.org> <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org> <20070403211709.GJ27706@spearce.org> <Pine.LNX.4.64.0704031425220.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704031427050.6730@woody.linux-foundation.org> <7vd52lum2f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:39:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYreX-0001XI-TB
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 00:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992435AbXDCWi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 18:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992452AbXDCWi7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 18:38:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53505 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992435AbXDCWi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 18:38:58 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYre4-0007E3-O3; Tue, 03 Apr 2007 18:38:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9BBAE20FBAE; Tue,  3 Apr 2007 18:38:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vd52lum2f.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43684>

Junio C Hamano <junkio@cox.net> wrote:
> Ah, that's true.  If you "git clone -l -s A B", create new
> objects in A and pull from B, the transfer would not exclude
> new objects as they are not visible from B's refs.
> 
> In that scenario, the keep-pack behaviour is already worse than
> the unpack-objects behaviour.  The former creates a packfile
> that duplicates objects that are in A while the latter, although
> expensive, ends up doing nothing.
> 
> I wonder if we can have a backdoor to avoid any object transfer
> in such a case to begin with...

Yea, symlink to the corresponding refs directory of the alternate
ODB.  Then the refs will be visible.  ;-)

-- 
Shawn.
