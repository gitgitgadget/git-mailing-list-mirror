From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Problem with git-svn
Date: Thu, 20 Dec 2007 10:30:08 -0800
Message-ID: <20071220183007.GA26767@untitled>
References: <4764FE2C.1010103@obry.net> <20071219082751.GA17787@muzzle> <47690031.7090409@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal.obry@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 19:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5QAI-0002to-I0
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 19:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbXLTSaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 13:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbXLTSaL
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 13:30:11 -0500
Received: from hand.yhbt.net ([66.150.188.102]:41884 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbXLTSaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 13:30:10 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BEFBF7DC122;
	Thu, 20 Dec 2007 10:30:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <47690031.7090409@obry.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69012>

Pascal Obry <pascal.obry@gmail.com> wrote:
> Hi Eric,
> 
> > Can you show me the output of `svn log -v -r9458 svn+ssh://myserver/'?
> 
> $ svn log -v -r9458  svn+ssh://myserver/
> ------------------------------------------------------------------------
> r9458 | (no author) | 1998-04-22 19:07:08 +0200 (Wed, 22 Apr 1998) | 1 line
> Changed paths:
>    A /importfromcvs
>    A /importfromcvs/branches
>    A /importfromcvs/tags
>    A /importfromcvs/trunk
> 
> New repository initialized by cvs2svn.
> ------------------------------------------------------------------------
> 
> > So did svn+ssh://importfromcvs/trunk/file.el at r9458?  If so, git-svn
> > is behaving as expected.  If not, can you tell me where "file.el" was at
> > r9458?
> 
> file.el was not imported at r9458 but at r9459, just after the creation
> of the /importfromcvs directories above.
> 
> ------------------------------------------------------------------------
> r9459 | author | 1998-04-22 19:07:08 +0200 (Wed, 22 Apr 1998) | 2 lines
> Changed paths:
>    A /importfromcvs/trunk/file.el
> 
> Initial revision
> 
> ------------------------------------------------------------------------

Ah, oops, I was off-by-one with the revision number.  But git-svn does
look to be doing the right thing here, because it followed history into
/importfromcvs/trunk/ and file.el was part of it.

-- 
Eric Wong
