From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Mozilla .git tree
Date: Sat, 2 Sep 2006 00:39:31 -0400
Message-ID: <20060902043931.GA25146@spearce.org>
References: <20060829232007.GC22935@spearce.org> <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com> <20060830015122.GE22935@spearce.org> <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com> <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home> <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <7vr6yw58xp.fsf@assigned-by-dhcp.cox.net> <20060902011950.GB24234@spearce.org> <7v8xl23oia.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 12:51:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJT5n-00050A-6X
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 12:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWIBKvD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 06:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWIBKvD
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 06:51:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:16538 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751032AbWIBKvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 06:51:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GJT5T-0004tI-Ni; Sat, 02 Sep 2006 06:50:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A61B420FB82; Sat,  2 Sep 2006 00:39:31 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xl23oia.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26329>

Junio C Hamano <junkio@cox.net> wrote:
> So I am inclined to chuck the previous patch that records the
> next object number in each entry.  We could keep the 64-bit
> offset, which would make an entry to be 28-byte instead of
> 32-byte.

I can agree with that.  :-)

Repacking is infrequent compared to searching for an object.
Asking the repack code to determine object lengths (especially if it
is going to deflate the entry anyway to verify it) isn't that much of
a performance hit.  As you pointed out its already happening today.

Using a 28 byte index entry instead of a 32 byte index entry means
the Mozilla historical pack index will only be 52.4 MiB rather than
the slightly larger 59.9 MiB.  1.9x10^6 objects will do that to you.

-- 
Shawn.
