From: Petr Baudis <pasky@suse.cz>
Subject: Re: Wishlist for branch management
Date: Mon, 1 Feb 2010 10:19:07 +0100
Message-ID: <20100201091907.GJ9553@machine.or.cz>
References: <4B662BEF.7040503@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 10:19:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbsRD-0007sU-Cj
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 10:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab0BAJTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 04:19:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:57967 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414Ab0BAJTN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 04:19:13 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 18BAA86202A; Mon,  1 Feb 2010 10:19:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B662BEF.7040503@zytor.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138596>

On Sun, Jan 31, 2010 at 05:18:39PM -0800, H. Peter Anvin wrote:
> A wishlist for better handling of branches:
> 
> git clone --branches
> 
> ... git clone, with the additional step of setting up local branches for
> each one of the remote branches.

Yes please! ;-) However, there should be a corresponding command to do
this with a remote within existing repository. Perhaps something like

	git remote populate

(stealing some syntax from topgit ;-).

> git branch --current
> 
> ... list the current branch name, for use in scripts.  Equivalent to:
> 	"git branch | grep '^\*' | cut -c3-"

I'm used to git symbolic-ref HEAD. I like the fact that human-friendly
and scripting interfaces are mostly separated to different commands.
This also has saner behaviour when HEAD is not on a branch. (Which is
also a reason why operation like this should be done only when there's
a damn good reason to need to know the branch name.)

> git push --current
> 
> ... push the current branch, and only the current branch...

Yes. Even in the HEAD form, it would be nice to have something that does
not require me to write out 'origin' or whatever my remote default is.
Perhaps `git push - HEAD`. There's certain disparity, we have an alias
for the current branch (HEAD) but not for the current remote.

P.S.: I know. It's all just bikeshedding without patches...

-- 
				Petr "Pasky" Baudis
If you can't see the value in jet powered ants you should turn in
your nerd card. -- Dunbal (464142)
