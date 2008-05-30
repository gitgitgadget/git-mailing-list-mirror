From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-log vs git-rev-list
Date: Fri, 30 May 2008 23:34:43 +0200
Message-ID: <20080530213443.GJ593@machine.or.cz>
References: <20080530165641.GG18781@machine.or.cz> <alpine.LFD.1.10.0805301021310.3141@woody.linux-foundation.org> <20080530194635.GI593@machine.or.cz> <alpine.LFD.1.10.0805301316580.3141@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 30 23:35:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2CG9-0007t0-UX
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 23:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbYE3Veq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 17:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbYE3Veq
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 17:34:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57948 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436AbYE3Vep (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 17:34:45 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 786591E4C030; Fri, 30 May 2008 23:34:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805301316580.3141@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83340>

On Fri, May 30, 2008 at 01:20:13PM -0700, Linus Torvalds wrote:
> On Fri, 30 May 2008, Petr Baudis wrote:
> > Step back a bit: it's git-_REV_-list. Technically, --all --objects is
> > nonsensical operation to do on revision list either.
> 
> Who cares?

You did in case of git log.

> Why are you arguing against *facts*?
> 
> The *fact* is, git rev-list can traverse the whole object chain.
> 
> The *fact* is that git rev-list can do other operations that have nothing 
> to do with logs (bisection, for example).
> 
> The *fact* is that both git rev-list and git log can traverse a set of 
> revisions, but that doesn't make them the same command.

Huh? Of course these are facts, but I don't see what does that have to
do with anything. I'm not arguing this isn't so, I'm arguing it _is_ so
and some of it is _wrong_ from user interface standpoint.

> I totally don't see your arguments. They are pointless. git rev-list and 
> git log already share all the relevant internal machinery for the things 
> where they overlap in capabilities. And the fact that they output 
> different things is because they are different.

My argument is that there should not be two different commands with
similar interface and almost similar feature set when a single interface
would be more than enough - no matter if it is UI or an API, redundant
interfaces mean more clutter for users (or developers) to wade through
and more bitrot for the project. After all, as I said - when I've hit
the rev-list / log inconsitencies, I was not looking for UI but indeed
for an internal helper.


Having said that, I'm fine with Junio's argument that we need to keep
git-rev-list for compatibility reasons as long as the relationship
between git-rev-list and git-log is more clearly documented; I would be
happier if the few remaining options would get implemented for git-log
and git-rev-list got deprecated (which does not mean removing it right
away; git-ssh-push was removed after two years), but I don't care that
much as to flame on, it's too hot over here in Central Europe already.
:-)

I will send some documentation patches soon.


By the way, is git log regarded as porcelain or plumbing? That is, are
there any guarantees about stability of git log output format etc.? Can
I use git log in my script and rely on it to behave forever exactly as
it does now? (Modulo bugfixes.)

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
