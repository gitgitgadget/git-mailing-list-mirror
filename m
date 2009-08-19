From: Theodore Tso <tytso@mit.edu>
Subject: Re: question concerning branches
Date: Wed, 19 Aug 2009 16:39:17 -0400
Message-ID: <20090819203917.GH27206@mit.edu>
References: <m33a7noc3u.fsf@localhost.localdomain> <4a8c51f5@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ingo Brueckl <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 22:39:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdrwS-0002Wx-VQ
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 22:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbZHSUjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 16:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbZHSUjY
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 16:39:24 -0400
Received: from thunk.org ([69.25.196.29]:58655 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbZHSUjX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 16:39:23 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MdrwH-00018Q-Pp; Wed, 19 Aug 2009 16:39:22 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MdrwD-0004FO-75; Wed, 19 Aug 2009 16:39:17 -0400
Content-Disposition: inline
In-Reply-To: <4a8c51f5@wupperonline.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126581>

On Wed, Aug 19, 2009 at 09:45:00PM +0200, Ingo Brueckl wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > You finish old work (or stash it away), _then_ you begin new work.
> 
> Ok, this helps me a little bit to understand.
> 
> The branches aren't designed to split my work, but rather something to
> collect the different parts of my work.
> 
> But as software development often is something where you are coding on
> several issues at the same time which can't be committed immediately, it
> sounds that 'stash' is the developer's best friend.

Context switching has overhead; so it's usually better to try to
complete one task before switching to another.  Granted, sometimes it
can't be done, but it's something you should really try to do.

Also, commits are easier to review if they are kept small; if you
localize changes into separate commits, it's often easier to detet
problems when doing "git bisect", for example.  So if you are often
needing to switch while leaving something that isn't ready to be
committed, you might want to ask yourself if you are putting too many
changes into a single ocmmit.

Personally, in the cases where I can't finish a commit before I need
to switch away to another branch, my preference is to not use "git
stash", but instead to create a topic branch, and then check in a
partially completed change on the topic branch, which I can later
ammend using "git commit --amend" (or if I have multiple commits on
the topic branch, "git rebase --interactive").  This is because I can
use the commit description to leave myself some notes about what still
needs to be done before the commit can be finalized.

						- Ted
