From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git building is borked
Date: Thu, 8 Mar 2007 09:55:32 -0500
Message-ID: <20070308145532.GA30674@spearce.org>
References: <4BBB354C-B000-4EF7-B3FF-7B2A4D6DE538@cam.ac.uk> <F0177878-0A2B-43B0-9838-E032FB3A0A58@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anton Altaparmakov <aia21@cam.ac.uk>
X-From: git-owner@vger.kernel.org Thu Mar 08 15:55:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPK1v-0001Ux-0l
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 15:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbXCHOzi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 09:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbXCHOzi
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 09:55:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49450 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbXCHOzh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 09:55:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPK1h-0000EZ-GI; Thu, 08 Mar 2007 09:55:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F1E6620FBAE; Thu,  8 Mar 2007 09:55:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <F0177878-0A2B-43B0-9838-E032FB3A0A58@cam.ac.uk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41745>

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> But now I put the git-gui mentions back into the Makefile and tried  
> again it still fails.  Looking at it closer it actually requires me  
> to compile within a checked out git tree, i.e. including the .git  
> directory and all its contents!  That seems even weirder than  
> requiring git to be installed in the first place...

What version of Git specifically are you building with?  How did
you obtain these source files?

Release tarballs of Git contain a git-gui/credits file that makes
CREDITS-GEN avoid invoking the not-yet-existing Git.  Building
git-gui without this file does require not only a working Git
installation, but also the git-gui object database.  Both of these
are readily available on a Git hacker's system, and on any system
that is attempting to create a release tarball.

There are other files included in the release tarballs (version,
git-gui/version) that are also required to get a correct build when
you don't have Git installed, or are missing its object database.
Having these missing does not stop the build process, but it does
make the output of `git version` and `git gui version` relatively
useless.


So you need to be bootstrapping from a released *.tar.{gz,bz2},
which can be found here:

  http://www.kernel.org/pub/software/scm/git/


Sadly, simply downloading the source files from a random gitweb
doesn't work anymore.  Yes, I know, my fault.  ;-)

-- 
Shawn.
