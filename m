From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Fri, 23 Nov 2007 15:56:52 -0500
Message-ID: <20071123205652.GA14735@spearce.org>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <fcaeb9bf0711230431x1b0432f6uc9472b2f67514463@mail.gmail.com> <Pine.LNX.4.64.0711231428350.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 23 21:57:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvfaU-0006Wu-E6
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 21:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbXKWU46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 15:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbXKWU46
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 15:56:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58546 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbXKWU45 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 15:56:57 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IvfZu-0005AG-1r; Fri, 23 Nov 2007 15:56:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EE82720FBAE; Fri, 23 Nov 2007 15:56:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711231428350.27959@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65925>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 23 Nov 2007, Nguyen Thai Ngoc Duy wrote:
> > I have a suggestion though. git-fast-export and git-fast-import should 
> > support bundle.
> 
> I think this is not what fast-export and fast-import are about.  They use 
> an easy to generate, and easy to edit, format.
> 
> Bundles are optimised transport mechanisms for sneaker net.  They are not 
> to be meant to be easy to edit, but as small as possible.

Actually I wonder, what about bundles that are formatted as a
git-fast-import data stream?  Then you can have a human readable
bundle format that can be (reasonably) easily turned back into a
packfile and loaded into the local ODB.

Only we'd probably want to express blobs as diffs if we can, to
save disk space, which means we'd need to have git-apply organized
in a way that we can call it from within fast-import.  :-)

But I agree with Dscho's basic comment; fast-import should not
be reading a bundle.  It doesn't want to.  That's what git-bundle
is for.

-- 
Shawn.
