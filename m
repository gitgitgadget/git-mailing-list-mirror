From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Odd problem in repository
Date: Tue, 24 Apr 2007 13:30:48 -0400
Message-ID: <20070424173048.GA5942@spearce.org>
References: <462E3D32.60804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:30:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgOqu-0002FF-IA
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 19:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbXDXRax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 13:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422808AbXDXRax
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 13:30:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57701 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422800AbXDXRaw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 13:30:52 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgOqU-00030e-WB; Tue, 24 Apr 2007 13:30:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C0D4A20FBAE; Tue, 24 Apr 2007 13:30:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <462E3D32.60804@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45475>

Clark Williams <clark.williams@gmail.com> wrote:
> One of my collaborators cloned the repository the other day and found
> that it didn't have any branches in it. I cloned a temp copy of it and
> found that the files that normally would be in refs/heads to identify
> the branches had somehow been moved to the directory
> refs/remotes/origin. In my local repository (which was cloned
> immediately after the CVS import), if I list what's in refs/heads, I get
> this:
> 
> $ ls -F refs/heads
> master  mock  mock-0-6-branch  mock-0.7  origin
> 
> on the whacky cloned copy, I get this:
> $ ls -F refs/heads
> master
> 
> and if I look in refs/remotes/origin:
> $ ls -F refs/remotes/origin
> HEAD  master  mock  mock-0-6-branch  mock-0.7  origin

This is a change in Git versions.  Pre Git-1.5.0 we used to put all
of the branches from the remote system into refs/heads, but now in
1.5.0 and later we put them in refs/remotes/origin.

Nothing screwed up on the central repository, its just the
new layout.  refs/heads is reserved for *this* local repository,
while refs/remotes/$name is reserved for the heads of $name remote
repository.

-- 
Shawn.
