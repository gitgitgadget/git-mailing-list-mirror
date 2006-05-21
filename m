From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn vs. $Id$
Date: Sat, 20 May 2006 18:12:06 -0700
Message-ID: <20060521011204.GA18886@hand.yhbt.net>
References: <446A0CCF.2060903@inoi.fi> <Pine.LNX.4.64.0605161037220.3866@g5.osdl.org> <446A15F8.3040106@inoi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 03:12:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhcUX-0002ln-Sl
	for gcvg-git@gmane.org; Sun, 21 May 2006 03:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWEUBMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 21:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWEUBMJ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 21:12:09 -0400
Received: from hand.yhbt.net ([66.150.188.102]:23511 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932161AbWEUBMH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 21:12:07 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 90AA32DC034; Sat, 20 May 2006 18:12:06 -0700 (PDT)
To: Tommi Virtanen <tv@inoi.fi>
Content-Disposition: inline
In-Reply-To: <446A15F8.3040106@inoi.fi>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20418>

Tommi Virtanen <tv@inoi.fi> wrote:
> Linus Torvalds wrote:
> > Isn't there some flag to svn to avoid keyword expansion, like "-ko" to 
> > CVS?
> > 
> > Any import script definitely should avoid keyword expansion (and that's 
> > true whether you end up wanting to use keywords or not).
> 
> Well, yes, I agree. But, at least git-svn.txt says this:
> 
> BUGS
> ----
> ...
> svn:keywords can't be ignored in Subversion (at least I don't know of
> a way to ignore them).
> 
> I guess one might be able to reach that information through the svn API.
> 
> Or just propget svn:keywords and sed s/\$Id\(:[^$]*\)\$/$Id$/ all files
> with keywords, for all relevant keywords. Eww.

I'm working on a solution to this (using files in .svn/text-base).

keyword expansion behavior seems inconsistent on some SVN repos and I
can't reproduce it on my local repositories, so I think I will have to
weaken some integrity checks[1] in git-svn to work around it...

1 - I don't think these integrity checks were ever tripped in the first
place.

-- 
Eric Wong
