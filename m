From: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
Subject: Re: Document clone of clone loosing branches?
Date: Sat, 14 Jun 2008 23:36:45 +0200 (CEST)
Message-ID: <20080614.233645.71097102.hanzl@noel.feld.cvut.cz>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
	<4853D967.5080903@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: lewiemann@gmail.com, jnareb@gmail.com, peff@peff.net
X-From: git-owner@vger.kernel.org Sat Jun 14 23:43:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7dWV-00053v-QK
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 23:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbYFNVmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 17:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754884AbYFNVmD
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 17:42:03 -0400
Received: from magi4.feld.cvut.cz ([147.32.198.214]:57838 "EHLO mepi"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754878AbYFNVmA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 17:42:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mepi (Postfix) with ESMTP id BD2C2FD806;
	Sat, 14 Jun 2008 23:36:45 +0200 (CEST)
In-Reply-To: <4853D967.5080903@gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85044>

Lea Wiemann wrote:
> I got bitten by that, too.  Perhaps the intro paragraph of git-clone.txt 
> (man git-clone) could mention that remote branches are not cloned or so. 
>   (I don't know git-clone well enough to be able to phrase it 
> accurately, but perhaps someone else wants to send a documentation patch...)

This is exactly what I would like to happen. (If nobody seems
interested, I might propose my own bad very first patch few days or
weeks later...)

Jeff King wrote:
> The new repository has remote tracking branches of the _regular_
> branches that are in the original repository. So the statement is
> correct; git-clone creates remote-tracking branches, and it makes one
> such branch for each branch in the cloned repository.
> 
> Unless you are complaining that it makes one for each non-remote branch
> in the cloned repository. But I think it is the general pattern to refer
> to things in refs/heads/ as simply unadorned "branch". If you want to
> say "all refs, including remote-tracking branches", you would typically
> say "refs" (which would also include tags).

I am not sure that the term 'branch' can be reasonably expected to
mean 'regular branch' unless specified otherwise. For example, 'man
git' says:

       git-branch(1)
          List, create, or delete branches.

It can also list remote-tracking branches, cannot it? Or:

       git-show-branch(1)
          Show branches and their commits.

Can also show remote-tracking branches, cannot it?

Even if 'branch' were very well known to mean 'regular branch', I
would still argue that 'man clone' is a very good place to define
these vocabulary conventions.

So I still think that 'man clone' is wrong as it stands now. It is not
true that all 'branches' are cloned. It would be better to say quite
explicitly that regular branches are cloned and remote tracking
branches are not.


Jakub Narebski wrote:
> The idea is for git-clone to clone (by default) _your_ work, not sb
> else work.  Think about two repositories, fetching from each other:
> you don't want for branches to proliferate like mad, remote of remote,
> then remote of remote of remote, and ad infinitum.
> 
> Besides there is I think implicit assumption that public repositories
> one might want to clone are _bare_ repositories, 1:1 or mirror
> refspecs, which simply do not contain remote tracking branches.


Yes. It would be no shame if an explanation like this made it to 'man
clone'?

After all, how many other commands do distinguish regular branches and
remote tracking branches? Even if there are any other (I do not know),
git-clone is likely the most prominent of them and 'man git-clone' is
quite good place to document this. Unless it is explained in 'man git'
itself (I think it is not now).

(Thought I am quite happy with UNIX tradition of very exact and very
condensed man pages, up to the point of being a hard puzzle, and I
agree that man pages are no tutorial, in this case I would be happy to
see 'regular branches' and 'remote tracking branches' clearly
distinguished in 'man git-clone' itself, without an implicit reference
to 'usual' meaning of words among geeks.)

Regards,

Vaclav Hanzl

P.S. Sorry for screwing up mail threads by this synthetic answer but I
thought it is not worth 3 messages (?)
