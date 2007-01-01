From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] Automatically detect a bare git repository.
Date: Mon, 1 Jan 2007 15:57:43 -0500
Message-ID: <20070101205743.GA26821@spearce.org>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org> <20061231043019.GC5823@spearce.org> <20061231175407.GC6115@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 21:57:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1UED-0004az-5j
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 21:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932838AbXAAU5u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 15:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932831AbXAAU5u
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 15:57:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59377 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932838AbXAAU5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 15:57:49 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H1UDx-0002mz-A5; Mon, 01 Jan 2007 15:57:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D0DD420FB65; Mon,  1 Jan 2007 15:57:43 -0500 (EST)
To: Martin Waitz <tali@admingilde.org>
Content-Disposition: inline
In-Reply-To: <20061231175407.GC6115@admingilde.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35742>

Martin Waitz <tali@admingilde.org> wrote:
> On Sat, Dec 30, 2006 at 11:30:19PM -0500, Shawn O. Pearce wrote:
> > We test the current working directory only after we have tried
> > searching up the directory tree.  This is to retain backwards
> > compatibility with our previous behavior on the off chance that
> > a user has a 'refs' and 'objects' subdirectories and a 'HEAD'
> > file that looks like a symref, all stored within a repository's
> > associated working directory.
> 
> Hmm, I have my dot files under GIT control so I can't use this mechanism
> to use bare GIT repositories under ~/git/*.git.

Whoops.  I assume you have your .gitignore populated with the other
files/directories in your home directory that shouldn't be under
Git control?
 
> Perhaps we should test the current directory first, but check that it
> ends in .git?

Junio already stated why that may not be a good idea.  My original
version of the patch did check the current directory first, but it
could match a working directory which isn't really a Git repository
but just looks sort of like one.

That wouldn't be backwards compatible, so I moved the current
directory check to just before failure.  That version is the one
that I submitted, and that Junio accepted...

-- 
Shawn.
