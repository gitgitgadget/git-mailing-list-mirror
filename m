From: Petr Baudis <pasky@suse.cz>
Subject: Re: FFmpeg considering GIT
Date: Thu, 3 May 2007 03:03:12 +0200
Message-ID: <20070503010312.GF4489@pasky.or.cz>
References: <loom.20070502T111026-882@post.gmane.org> <f1b806$nc7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 03:03:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjPjN-0002Jk-T4
	for gcvg-git@gmane.org; Thu, 03 May 2007 03:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767291AbXECBDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 21:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767295AbXECBDQ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 21:03:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49440 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767291AbXECBDP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 21:03:15 -0400
Received: (qmail 20944 invoked by uid 2001); 3 May 2007 03:03:12 +0200
Content-Disposition: inline
In-Reply-To: <f1b806$nc7$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46055>

On Thu, May 03, 2007 at 01:48:26AM CEST, Jakub Narebski wrote:
> About removing a commit: assume that you have the following history
> The problem exists _only_ if somebody based his/her work on commit
> C or its descendant, i.e. original D, E commits. He/she would have
> to rebase his/her work on top of _changed_ (moved) commits D' and E'.

"_Only_"?

I think it's just totally unsustainable to do this history rewriting in
an "upstream" git repository. You will get horridly confused, then
frustrated and then just move from software development to beekeeping.

Imagine what will happen in gitk --all - you will see many commits
several times in a row because each is part of different subhistory for
a given head. Merging between branches will become totally impossible.
People keeping their clones (or even forking history) will be confused
and horrified. Bits of patches inbetween the original commit and the
revert moment will lose their meaning, the history won't be trustworthy
anymore at all.

In the end, using these practices git will end up useful roughly as a
faster but crippled SVN. So please don't ever just suggests how random
git commands and features with special usage might work without
carefully explaining the implications and why this is _not_ the way to
use git. If ffmpeg insists on having an X feature and it's not feasible
to make it work well with principles git is built on, ffmpeg will be
better off without git and staying with SVN, if anything to not make git
bad name between frustrated ffmpeg users and developers.

PS: Beekeeping _is_ kind of cool, really.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
