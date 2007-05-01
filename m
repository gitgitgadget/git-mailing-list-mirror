From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: svn:externals using git submodules
Date: Tue, 1 May 2007 16:23:56 -0400
Message-ID: <20070501202356.GA25531@pe.Belkin>
References: <200705011121.17172.andyparkins@gmail.com> <200705011936.14345.andyparkins@gmail.com> <20070501191703.GA25287@pe.Belkin> <200705012048.04817.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 22:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiytF-0005tJ-VL
	for gcvg-git@gmane.org; Tue, 01 May 2007 22:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbXEAUX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 16:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbXEAUX6
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 16:23:58 -0400
Received: from eastrmmtao106.cox.net ([68.230.240.48]:57166 "EHLO
	eastrmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965055AbXEAUX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 16:23:58 -0400
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501202356.BGLU12193.eastrmmtao106.cox.net@eastrmimpo02.cox.net>;
          Tue, 1 May 2007 16:23:56 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id twPw1W00R0epFYL0000000; Tue, 01 May 2007 16:23:56 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1HiytA-0006ea-NU; Tue, 01 May 2007 16:23:56 -0400
Content-Disposition: inline
In-Reply-To: <200705012048.04817.andyparkins@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45976>

On Tue, May 01, 2007 at 08:48:01PM +0100, Andy Parkins wrote:
> On Tuesday 2007, May 01, Chris Shoemaker wrote:
> 
> > That's only true when the revision is not specified in the external.
> > The repo you track may not do that, but it's not uncommon to do so.
> 
> It's been a while since I used subversion, and even longer since I used 
> externals - is that a new feature?  

I don't know, but I would guess that it's no newer than externals in
general, as it's not a particularly special case.

> I used subversion since before 
> version 1.0, so I often missed new features when they arrived. 
> 
> > And, as I think you're pointing out, it's the only way to get any
> > sort of reliable information about the relationship between the
> > parent and the external.
> 
> Does subversion automatically update that fixed attachment when you 
> update the submodule?  I would have found that quite useful back then.

No, you have to manage the revision in the svn:external property
manually.

> > I think it would probably be undesirable for git-svn to attempt to
> > convert "floating" externals into well-versioned submodules, since
> > they're not even well-versioned in the svn repo.  However, handling
> > the "locked-down" externals is quite another thing.
> 
> Absolutely.  If the information is available, then git is certainly 
> capable of recording it.  It sounds like subversion has a facility I 
> didn't know exist, so I've been bad mouthing it more than I should.  Oh 
> well :-)
> 

Making git-svn handle svn:externals with specified revisions would be
_quite_ useful.  There's a special-case of this that I use personally:
svn:externals that point to other paths (and other revisions) of the
parent repo.

I'm curious if people think that teaching git-svn to handle this
special case is more or less difficult than handling the general case.

-chris
