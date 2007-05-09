From: Petr Baudis <pasky@suse.cz>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 9 May 2007 15:41:51 +0200
Message-ID: <20070509134151.GT4489@pasky.or.cz>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com> <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 09 15:42:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlmQq-0000ja-Ip
	for gcvg-git@gmane.org; Wed, 09 May 2007 15:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756451AbXEINly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 09:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbXEINly
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 09:41:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58593 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756451AbXEINlx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 09:41:53 -0400
Received: (qmail 22585 invoked by uid 2001); 9 May 2007 15:41:51 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46714>

On Tue, May 08, 2007 at 06:45:32AM CEST, Linus Torvalds wrote:
> Git used explicit index updates from day 1, even before it did the first 
> merge. It's simply how I've always worked. I tend to have dirty trees, 
> with some random patch in my tree that I do *not* want to commit, because 
> it's just a Makefile update for the next version (to remind me - I've 
> released kernel versions too many times with an old version number, just 
> because I forgot to update the Makefile).
> 
> Or other things like that - I have small test-patches in my tree that I 
> want to build, but that I don't want to commit, and I end up doing big 
> merges and whole patch-application sequences with such a dirty tree 
> (obviously if the patch or merge wants to change that file, I then need to 
> do something about that dirty state, but it happens surprisingly seldom).

Hmm, does this really work so well for you guys? Because thanks to Mr.
Murphy, in my case, when I have some custom Makefile tweak, I always
need to commit some unrelated changes involving Makefile more often than
usual, and so on; so in general case, file-level changes exclusion
doesn't really work so well for me.

So this use of index seems to me really as a workaround for more
fine-grained change control (in a similar way that rename following
would be a workaround for lack of more fine-grained content moves
tracking). I will have to look into git-gui's hunk-level control and
maybe reimplement it in tig.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
