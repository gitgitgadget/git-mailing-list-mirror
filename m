From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Fri, 23 Nov 2007 15:59:58 -0500
Message-ID: <20071123205958.GC14735@spearce.org>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <fi5743$32p$1@ger.gmane.org> <Pine.LNX.4.64.0711230050270.27959@racer.site> <f329bf540711221723g2754ce03r4da6d429c45668c@mail.gmail.com> <Pine.LNX.4.64.0711230149430.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: hanwen@xs4all.nl, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 23 22:00:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvfdR-0007S0-5v
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 22:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbXKWVAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 16:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbXKWVAE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 16:00:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58678 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbXKWVAD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 16:00:03 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ivfct-0005H0-Jj; Fri, 23 Nov 2007 15:59:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A9C6B20FBAE; Fri, 23 Nov 2007 15:59:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711230149430.27959@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65928>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 22 Nov 2007, Han-Wen Nienhuys wrote:
> 
> > > Maybe you want to specify if all blobs should be output first, and 
> > > then the commits?  Or files should be used?  But all of these things 
> > > seem to be useless to me.
> > 
> > No, I want the program to wait for me to tell it what 
> > blobs/commits/trees I want. The commit I want to see secondly may depend 
> > on the output I read in the first request blob. Right now, for each data 
> > dependency I have to start a new git process.
> 
> It does not seem like you want a mirror of fast-import, but rather a 
> driver.  You might be happy to hear that you can do that already.  Today.
> However, you probably want to query different programs about certain 
> states of the repository.  This will not change.
> 
> > > > Besides being a nuisance, I actually run git on NFS, and every git 
> > > > process has to go to NFS a couple times to retrieve the same 
> > > > information. This has a noticeable performance impact.

I have been considering creating a "git-gui daemon" process that
links to libgit.a and can be driven bidirectionally through its
stdin/stdout.  Based on git-fast-export, sorta.  But I haven't
even started it...

But the idea is sort of what Han-Wen wants.  Why should I fork
rev-parse to get a ref value?  Or update-ref to change one?

-- 
Shawn.
