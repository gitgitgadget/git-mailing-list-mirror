From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: how to update a submodule?
Date: Fri, 31 Dec 2010 22:24:38 +0000
Message-ID: <20101231222438.GA28199@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 31 23:24:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYnOu-0007L1-No
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 23:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302Ab0LaWYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 17:24:40 -0500
Received: from laurel.swan.ac.uk ([137.44.1.237]:35291 "EHLO laurel.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754196Ab0LaWYk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 17:24:40 -0500
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by laurel.swan.ac.uk with esmtp (Exim 4.72)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1PYnOo-0003Da-UH; Fri, 31 Dec 2010 22:24:39 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id D5E9F1C192B;
	Fri, 31 Dec 2010 22:24:38 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id C4BAE741EC; Fri, 31 Dec 2010 22:24:38 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164398>

Hello,

it would be very helpful if somebody could tell me the
supposed workflow how to update a submodule (I'm using version
1.7.3.2; the man-page doesn't say much about it).

I have on the same machine two versions of repository A,
say A1, A2, and both contain repository B as submodule, but are otherwise
unrelated.

In A1 we have B up-to-date, but not in A2 (and with up-to-date I mean
the master branch in the same state as in A1).

git submodule update

is of no help, since A1, A2 have no relation to each other, and "update"
assumes some relation; the man-page doesn't speak of options for update,
and since "git submodule update" runs through all submodules, it's hard
to see how that could work.

So I have to go into B in A2, and do some pull (I suppose), but that
doesn't work so easily; the man-page seems to speak of B in A2 is a "normal repository"
but that doesn't seem to be the case in the sense that by default 
we are on "no branch". So it seems one can't do anything there, since 
you can't merge "no branch" into some other branch. The branch "no branch"
is up-to-date after a pull, but this can't be communicated to the other
branches (so seems to be misleading, or a waste of time).

So apparently I have to checkout master in A2:B, and then pull from
master in A1:B ?

Would be good if somebody could shed light on this.

In general I find that "pull" is much under-documented in git.
What I would like to do in A2 is just to say "pull everything from A1",
which seems a logical thing to do, and which should include all corresponding
branches and all corresponding submodules, but such a "pull all" doesn't
seem to exist?

Thanks for your help in any case!

Oliver

P.S. What would be really needed for the Git documentation is to speak
about the fundamental ideas, about the "mental images".

The submodule documentation starts with a blurb-sentence which I would
regard as misleading.
Then comes a paragraph about what it is not.
Then comes some hints regarding the implementation.
Then the final paragraph seems to indicate that above I could just
use "git pull A2" for A1, and would get B in A2 from B in A1, but only not checked out?
This doesn't seem to be the case, since apparently then "git submodule update"
tries to fetch from some foreign repository (not just checking out what was fetched before)?

Adding here examples for a complete workflow (perhaps with various stages, but without
complications(!)), from initialisation to updates from other repositories would be
very helpful.

As you can see, I don't know what to expect, and so I don't know what are errors in
the usage, and what is supposed to be. No mental image about "submodule" is offered,
and I don't know what is its intention. A great thing would be using the computer-science
concept of an abstract data type, so to explain what the interface and its semantics is,
not what is the implementation.
