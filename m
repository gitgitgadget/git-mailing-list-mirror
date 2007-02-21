From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 13:37:54 -0500
Message-ID: <20070221183754.GK25559@spearce.org>
References: <20070221164527.GA8513@ginosko.local> <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org> <20070221183028.GA9088@ginosko.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 19:38:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJwMW-0002bP-5s
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 19:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422785AbXBUSiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 13:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422793AbXBUSiF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 13:38:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46571 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422791AbXBUSiB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 13:38:01 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJwLd-0005bi-SR; Wed, 21 Feb 2007 13:37:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D1F3E20FBAE; Wed, 21 Feb 2007 13:37:54 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070221183028.GA9088@ginosko.local>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40315>

Michael Hendricks <michael@ndrix.org> wrote:
> What's a decent way to make a branch into a new repository?  My first
> inclination is to "cp -a" the existing repository, checkout the branch,
> delete all other branches and repack.  That seems to have worked in my
> quick test, but is there a better way?

Don't "cp -a" the repository, use git-clone.

And actually, if you just want to pull one branch out into its
own repository you can do something like this:

	mkdir ../theonebranch
	cd ../theonebranch
	git init
	git fetch ../oldstuff theonebranch:master

and you have just the content of `theonebranch` from ../oldstuff
stored here, as master.

Optionally if you now want to actually see the files, you would do:

	git checkout

-- 
Shawn.
