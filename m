From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] git-cvsexportcommit.perl: git-apply no longer needs --binary
Date: Tue, 16 Oct 2007 21:11:48 -0400
Message-ID: <20071017011148.GL13801@spearce.org>
References: <1192522094-4988-1-git-send-email-mfwitten@mit.edu> <Pine.LNX.4.64.0710161404220.25221@racer.site> <19B03C18-6BBD-4F67-93DC-37B422445C82@mit.edu> <200710162320.14917.robin.rosenberg.lists@dewire.com> <561D7B44-9EDE-447B-A751-BE6E3A3AD9CC@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:12:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhxS8-0005m6-BU
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761618AbXJQBLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761543AbXJQBLy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:11:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49517 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760953AbXJQBLx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:11:53 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhxRj-0001Ts-4L; Tue, 16 Oct 2007 21:11:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A8E6220FBAE; Tue, 16 Oct 2007 21:11:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <561D7B44-9EDE-447B-A751-BE6E3A3AD9CC@mit.edu>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61299>

Michael Witten <mfwitten@MIT.EDU> wrote:
> On 16 Oct 2007, at 5:20:14 PM, Robin Rosenberg wrote:
> 
> >So all this series does is... making it harder to follow the history?
> 
> If you follow the history solely on patches.

`git-blame -w` can probably punch through the indentation change
just fine to find the older history.  But it does make `git log -p`
damn ugly to read at this point in history.  And if you forget the
-w to git-blame, well, then you are really in for some fun for a
few minutes.  Lets not mention pickaxe noticing strings removed+added
in this patch either.

> >Ack for removing the --binary, the rest is just noise
> 
> I think fixing the tabs is more important than removing --binary.
> 
> It's clear the the entropy of tabulation increases over time;
> the tab patch acts as a buffer to reconstruct a clean signal.

Sorry, but I have to say I agree with Robin here.  The tab patch
is large, ugly, and provides relatively little value in comparsion.

The first rule of git development typically is "any change is bad".
Because anything that is already written can be assumed to already
be tested and in use by someone.  Breaking that is bad, as then
they have a bad experience with git.

There needs to be a really good reason behind a change, like the
existing code is already not functioning according to its documented
behavior due to a corner case input.  Such things should be changed.

I'm not going to apply the indentation change patch to my tree.
You can try to resubmit it through Junio after he's back online
and accepting patches.

-- 
Shawn.
