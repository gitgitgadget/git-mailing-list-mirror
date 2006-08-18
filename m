From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-apply: document remaining options in the man page
Date: Fri, 18 Aug 2006 02:43:48 -0700
Message-ID: <7virkqbcq3.fsf@assigned-by-dhcp.cox.net>
References: <20060818084545.GB4717@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 11:44:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE0tV-0000Ps-6D
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 11:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWHRJn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 05:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWHRJn5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 05:43:57 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:25299 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751330AbWHRJn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 05:43:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060818094355.UCWT12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Aug 2006 05:43:55 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060818084545.GB4717@diku.dk> (Jonas Fonseca's message of "Fri,
	18 Aug 2006 10:45:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25639>

Jonas Fonseca <fonseca@diku.dk> writes:

> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> ---
>
> [ On top of next if that matters. ]

I'd appreciate if you can hold this off for a while; I'll be
updating git-apply a bit further, to add --verbose ("patching
foo...", "rejected hunk #4", etc.) and perhaps --clobber (apply
to working tree files that have local modifications), together
with --reject (apply hunks that could, while leaving
unapplicable ones out).  I've been reluctant to spray .rej files
all over the tree and was planning to spit all into a single
stream (stdout), which is what is on "pu" now, but I changed my
mind and decided to mimic what other people do (that format is
more useful to work with because other tools like wiggle expect
.rej files next to the target files).

> I'm not sure if I got the --exclude note right, which says that running
> apply from a subdirectory automatically excludes files outside the
> subdirectory.

I was thinking about dropping the exclude altogether, actually.

Also I've never thought about the possibility of anybody running
git-apply from a subdirectory.  git diffs by design always come
with full paths from the project toplevel, so I simply had a
preconception that everybody understood that applying would also
be always from the toplevel.

Don't get me wrong -- I do not mean to say that running apply
from a subdirectory is wrong.  I just haven't thought about
doing so, and need to think the implications through.

> Lastly, `log -S<option>` is so great when doing these man pages updates
> and you, like me, don't know the code very well, since you can "just"
> paraphrase the commit message that will sometimes also describe the
> scenario where the option is applicable. :)

Praise pickaxe, and say no to annotate ;-).
