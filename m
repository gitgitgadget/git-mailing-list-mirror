From: Andreas Krey <a.krey@gmx.de>
Subject: Re: stash refuses to pop
Date: Sat, 14 Apr 2012 06:27:13 +0200
Message-ID: <20120414042713.GA13889@inner.h.iocl.org>
References: <4F847350.3000409@ubuntu.com> <7vpqbfpim2.fsf@alter.siamese.dyndns.org> <4F84827B.80104@ubuntu.com> <CAH5451=0KvUPB77hKyjFVXRwPfEZ8+45b20SimBPmuF-gq_A3w@mail.gmail.com> <4F84F39B.6070907@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 07:01:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIv6h-0003fF-4h
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 07:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab2DNFAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 01:00:54 -0400
Received: from continuum.iocl.org ([217.140.74.2]:44624 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab2DNFAS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 01:00:18 -0400
X-Greylist: delayed 1977 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Apr 2012 01:00:17 EDT
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id q3E4RDO14455;
	Sat, 14 Apr 2012 06:27:13 +0200
Content-Disposition: inline
In-Reply-To: <4F84F39B.6070907@ubuntu.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195469>

On Tue, 10 Apr 2012 22:59:39 +0000, Phillip Susi wrote:
...
> Yes, there are a number of ways you can get to the situation where you can not pop the stash.  How to resolve this is unclear from the results of the failed pop.  I finally ended up resolving it by committing the remaining changes, then popping the stash ( which performed the merge successfully ), and finally doing a git reset HEAD~1 to remove the temporary commit, but preserve the merged results.  This seemed like a good deal of unnecessary trouble.

(Late to the game.) Actually, this is exactly what I would have proposed
to do. Git is a bit shy on performing a merge into a locally modified
file. I assumed so far that is because there is no way of aborting
such a merge (resetting to the state of local modifications before the
attempt). With the temporary commit you have a way of retrying the pop
merge if you lost your way in it.

And I think that is a good idea; I never liked the way in which a cvs/svn
update merged into locally modified files without a way to undo, and
thus forcing you to clean up the potential mess manually. (Ok, they leave
the old files lying arond, but that doesn't help rewinding the state.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
