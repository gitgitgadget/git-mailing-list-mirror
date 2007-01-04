From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Wed, 3 Jan 2007 22:05:44 -0500
Message-ID: <20070104030544.GF18206@spearce.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <20070104020652.GB18206@spearce.org> <20070104023510.GC18206@spearce.org> <204011cb0701031836w7d33ca8dh5de08984eec9730d@mail.gmail.com> <20070104024523.GD18206@spearce.org> <204011cb0701031853xd226683g85f376c206aacf3e@mail.gmail.com> <20070104025659.GE18206@spearce.org> <204011cb0701031858x231df34as424b7f0c0ae4ab8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 04:06:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2IvZ-000141-TE
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 04:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbXADDFx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 22:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbXADDFx
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 22:05:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32838 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbXADDFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 22:05:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H2IvQ-0003sF-Ly; Wed, 03 Jan 2007 22:05:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4B3FF20FB65; Wed,  3 Jan 2007 22:05:45 -0500 (EST)
To: Chris Lee <chris133@gmail.com>
Content-Disposition: inline
In-Reply-To: <204011cb0701031858x231df34as424b7f0c0ae4ab8b@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35912>

Chris Lee <chris133@gmail.com> wrote:
> Uh... somehow, it lost this part:
> 
> >All that's needed is to get data from SVN in a way that it can be
> >fed into git-fastimport.
> 
> That's what I meant - I assume that someone already has the
> svn-repo-to-gfi piece working? Where's that available from?

No.  That hasn't been written.

In theory someone could take the SVN dump library (its a chunk of
C code which parses SVN dump files) and write a tool which translates
it into git-fastimport.

One could also use the SVN client library to suck data from SVN
and pump it into git-fastimport.

Jon Smirl attempted to create a CVS-->git-fastimport program in
Python by starting with the cvs2svn codebase, but that doesn't
do anything about importing *from* SVN.  Jon was able to import
the entire Mozilla CVS repository (250k commits, about 3 GiB
input) in 2 hours using his hacked up cvs2svn and git-fastimport.
The resulting pack was ~900 MiB.  He recompressed that using
`git repack -a -d --window=50 --depth=1000` (which is insane) in
about an hour.

-- 
Shawn.
