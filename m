From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Some ideas for StGIT
Date: Sat, 4 Aug 2007 01:51:11 -0400
Message-ID: <20070804055110.GP20052@spearce.org>
References: <1186163410.26110.55.camel@dv> <200708031914.04344.andyparkins@gmail.com> <1186206085.28481.33.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 07:51:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHCXy-0000YA-Ut
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 07:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199AbXHDFvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 01:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbXHDFvP
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 01:51:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43166 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbXHDFvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 01:51:15 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHCXf-0007gJ-4S; Sat, 04 Aug 2007 01:51:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 15ECA20FBAE; Sat,  4 Aug 2007 01:51:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1186206085.28481.33.camel@dv>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54795>

Pavel Roskin <proski@gnu.org> wrote:
> 
> On Fri, 2007-08-03 at 19:14 +0100, Andy Parkins wrote:
> > On Friday 2007, August 03, Pavel Roskin wrote:
> > 
> > > I don't suggest that StGIT gives up on the git-based storage, but this
> > > mode of operation could be implemented in two ways.
> > 
> > git's shiny new git rebase -i has removed, for me, those times when I needed 
> > stgit.  Perhaps those who've move from git to quilt would try again when 
> > 1.5.3 is out with the magic that is "rebase -i".

I agree with Andy.  Aside from the performance issues that I
am currently having with a 55 patch series, "rebase -i" (and its
predecessor script from Dscho) have been a major part of my toolkit,
to the point that I really don't need something like StGIT on
my system.

(Regarding the performance, cherry-picking 55 patches is
slow, especially when many of them would apply trivially with
git-diff|git-apply --index.  Be nice to improve that in 1.5.4.)
 
> I don't understand how one option can replace StGIT.  I assume you were
> trying to avoid StGIT already, and "git-rebase -i" was just the last
> missing piece.

Oh, I'm sure there's features in StGIT that are useful that aren't
available via "rebase -i".  But to be honest, "rebase -i" is good
enough.  It just ain't fast enough.  Editing a patch that is 50
back in the series *sucks*.
 
> It would be great if you could tell me how your approach would deal with
> the issue of editable patches I mentioned already.  In case I was
> unclear, here's the quote from one of the developers:
> 
> [quote]
> Sometimes, I just make patches in quilt, then I do "quilt 
> refresh", "quilt pop -a", "cd patches" and modify the patches 
> and series file manually, e.g. by moving one patch from one file 
> into the other. The "cd ..", "quilt push -a" and off I am. That 
> the "database" of quilt is in a known format and I can hack on 
> it with an editor is a plus for me :-)
> [end of quote]

Uh, the "database" of "rebase -i" is just a chain of commits in a
git repository.  These are a well known format and can be easily
edited with "rebase -i".  This is a real plus for me as the series
can be edited directly in my favorite vi clone, then applied to my
working directory.  ;-)

-- 
Shawn.
