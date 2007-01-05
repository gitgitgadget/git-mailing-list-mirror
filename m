From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 14:39:58 -0500
Message-ID: <20070105193958.GE8753@spearce.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net> <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com> <7v1wmalez6.fsf@assigned-by-dhcp.cox.net> <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com> <7vbqldfg56.fsf@assigned-by-dhcp.cox.net> <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 20:40:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2uvB-0004l2-66
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 20:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbXAETkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 14:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbXAETkF
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 14:40:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53136 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422701AbXAETkE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 14:40:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H2uuR-0006Kq-Jk; Fri, 05 Jan 2007 14:39:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BA32320FB65; Fri,  5 Jan 2007 14:39:58 -0500 (EST)
To: Chris Lee <chris133@gmail.com>
Content-Disposition: inline
In-Reply-To: <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36016>

Chris Lee <chris133@gmail.com> wrote:
> Also, 'git-prune' took about 30 minutes to run to completion. Oddly,
> git-prune didn't remove the older packs - does git-prune ignore packs?
> 'git-repack -a -d' did remove them.

git-prune is expensive.  Very expensive on very large projects,
as it must iterate every object to decide what is needed, before
it can start to remove objects that aren't needed.

Yes, it doesn't deal with removing pack files.  That's what the -d
to git-repack is for.

-- 
Shawn.
