From: Eric Wong <normalperson@yhbt.net>
Subject: Re: BUG: git-svn does not escape literal backslashes in author names.
Date: Sat, 17 Nov 2007 12:43:48 -0800
Message-ID: <20071117204348.GA16333@muzzle>
References: <1213a9470711120628l4ccab632n17635295ec897a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adrian Wilkins <adrian.wilkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 21:44:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItUWN-0000x4-DM
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 21:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXKQUnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 15:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbXKQUnu
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 15:43:50 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33643 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbXKQUnu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 15:43:50 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 035387DC0FE;
	Sat, 17 Nov 2007 12:43:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1213a9470711120628l4ccab632n17635295ec897a2@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65303>

Adrian Wilkins <adrian.wilkins@gmail.com> wrote:
> Recently converted a large (11,000+ revisions) repository.
> 
> We authenticate against the NT domain controller, so all our revision
> authors are of the form "domain\user". (You can switch off mod_sspi
> reporting the domain part, but I didn't know about this at the time,
> so it continues for historical reasons.)
> 
> git-svn treats the literal backslashes in the author names as escapes.
> This leads to authors like
> 
> domainkevin
> domain\
> ichard
> 
> I know, I should have read the manual and used my "authors" file. Bah.
> 
> I'm sure that part of the revision hash in git includes the author
> name... so I guess I'm looking at another multi-day conversion. :-(

git-filter-branch should be able to take care of it.  If you find
an invocation that's useful to others, it'd be great to post it
on the list as well :)

> Can I suggest that you make the authors file compulsory by default as well?

Not going to happen.  I personally _hate_ having to track down author
information and make an authors file, and I suspect many others feel the
same.  I've never used this feature in git-svn on any real repository.

-- 
Eric Wong
