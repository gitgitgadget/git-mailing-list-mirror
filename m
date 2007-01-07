From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Simple UI question...
Date: Sun, 7 Jan 2007 06:29:45 -0500
Message-ID: <20070107112944.GF10351@spearce.org>
References: <204011cb0701070302y54837c5bp967e2cddd3fb655d@mail.gmail.com> <20070107111305.GD10351@spearce.org> <204011cb0701070321w18942a3w7fb4f7ecd26fc457@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 12:29:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3WDo-0004Ql-BJ
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbXAGL3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbXAGL3t
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:29:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55443 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932513AbXAGL3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:29:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H3WE1-0008RY-R2; Sun, 07 Jan 2007 06:30:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4FE4120FB65; Sun,  7 Jan 2007 06:29:45 -0500 (EST)
To: Chris Lee <clee@kde.org>
Content-Disposition: inline
In-Reply-To: <204011cb0701070321w18942a3w7fb4f7ecd26fc457@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36161>

Chris Lee <clee@kde.org> wrote:
> Eric's shows the same problem - for some revision IDs, when I do a
> checkout, I only get the files that were changed in that revision.
> 
> >If Eric's version isn't always working then I'd have to suggest
> >that you exmaine the output of `git status` for switching to
> >some temporary branch based on $sha1sum.  Perhaps you have local
> >modifications which are carrying over in your working directory?
> 
> I assume 'removing everything in the working tree' counts as "local
> modifications"? :)

Yes!  That's what's going wrong.  Don't do "rm -rf *".  Let Git take
care of the empty directories for you.  If Git deletes all source
files in that directory (as they don't belong in this version that
you are checking out) it will also delete the now empty directory.

The only time it fails is if you are on Windows and some process
has the directory busy.  :-)

-- 
Shawn.
