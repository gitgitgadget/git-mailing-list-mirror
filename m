From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] Automatically detect a bare git repository.
Date: Mon, 1 Jan 2007 16:01:03 -0500
Message-ID: <20070101210103.GB26821@spearce.org>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org> <20061231043019.GC5823@spearce.org> <20061231125205.GB14286@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 22:01:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1UHP-0005F6-PR
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 22:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657AbXAAVBI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 16:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754695AbXAAVBI
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 16:01:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59508 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbXAAVBH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 16:01:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H1UHA-0002v9-Hq; Mon, 01 Jan 2007 16:00:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 327BD20FB65; Mon,  1 Jan 2007 16:01:03 -0500 (EST)
To: Theodore Tso <tytso@mit.edu>
Content-Disposition: inline
In-Reply-To: <20061231125205.GB14286@thunk.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35743>

Theodore Tso <tytso@mit.edu> wrote:
> On Sat, Dec 30, 2006 at 11:30:19PM -0500, Shawn O. Pearce wrote:
> > Many users find it unfriendly that they can create a bare git
> > repository easily with `git clone --bare` but are then unable to
> > run simple commands like `git log` once they cd into that newly
> > created bare repository.  This occurs because we do not check to
> > see if the current working directory is a git repository.
> 
> Thanks for coding this up!   
> 
> If you do this, does this mean that we can also eliminate the global
> variable --bare, since git will be able to figure out we're in a bare
> repository all by itself?

Probably not.  `git --bare foo` is a Poreclain-ish level option
which has been supported for several versions.  Removing it may
cause pain for users to retrain their fingers to just ignore it.

Besides `git --bare` can be used in cases where the bare Git
repository is actually located within another repository's working
directory and the automatic detection is picking up the other
repository's metadata and not the bare repository's metadata.

So I think --bare is still here to stay for a while.  The new
automatic detection just offers slightly less surprise for users.

-- 
Shawn.
