From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: 2 things about branches
Date: Mon, 19 Feb 2007 13:37:03 -0500
Message-ID: <20070219183703.GB29930@fieldses.org>
References: <1171908840.10817.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 19:37:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJDNt-0001mE-6U
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 19:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbXBSShE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 13:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbXBSShE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 13:37:04 -0500
Received: from mail.fieldses.org ([66.93.2.214]:48547 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451AbXBSShD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 13:37:03 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HJDNn-0008Ax-AH; Mon, 19 Feb 2007 13:37:03 -0500
Content-Disposition: inline
In-Reply-To: <1171908840.10817.21.camel@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40136>

On Mon, Feb 19, 2007 at 07:13:59PM +0100, Raimund Bauer wrote:
> I think it's a good idea to not list remote branches in 'git branch'
> output per default, but imho we should make an exception for the branch
> the user is currently on.
> Currently when I do 'git checkout origin/next' the checkout works fine
> and I get the warning about the remote branch, but an informational
> query 'git branch' right after that says
> 
> * (no branch)
>   master
> 
> 'git branch -r' also doesn't mark me as being on origin/next.

That's because you're not really "on" origin/next.  Your currently
checked-out state happens to be the same as the state that origin/next
points at, but that's not quite the same thing.  The main difference
being that if you commit something, origin/next won't be moved forward
to point at the new commit.

> Maybe we could query the remote-branches for a matching ref this case?

If that's what you want you could use e.g.

	git describe --all

--b.
