From: Blu Corater <blu@daga.cl>
Subject: use case
Date: Mon, 21 Aug 2006 14:23:38 -0400
Message-ID: <20060821182338.GA21395@daga.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 21 20:24:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFERB-0005zF-AZ
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 20:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWHUSXk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 14:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWHUSXk
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 14:23:40 -0400
Received: from [201.215.212.46] ([201.215.212.46]:53730 "EHLO daga.cl")
	by vger.kernel.org with ESMTP id S1751187AbWHUSXk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 14:23:40 -0400
Received: from blu by daga.cl with local (Exim 4.62)
	(envelope-from <blu@daga.cl>)
	id 1GFER0-00074l-LL
	for git@vger.kernel.org; Mon, 21 Aug 2006 14:23:38 -0400
To: git <git@vger.kernel.org>
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25810>

Hello all.

I've just recently started to put my projects under git, and I have found
a, maybe unusual, use case in which I am not sure how to procede or even
if git is the right tool. Advice from more seasoned users is welcome.

The picture is like this. I've just have to took over the maintenance of a
piece of software which was not kept under scm. The previous developer
used to just hack on the production systems and make a backup once in a
while. No release policy or anything like that. The software runs on
several machines and controls similar but not identical equipment. The
machines should be swapable, therefore the software running should be
identical in all of them and detect the working environment at runtime.

In top of all, my predecesor was fired a few months before I took control
and, in the meantime, people have been doing random modifications to the
software on the production machines to satisfy new requirements, but not
consolidating them, so the present state is slightly divergent and
incompatible versions of the software on each production machine and the
machines are not swapable any more.

My contingency plan, while I manage to refactor the code and establish
a more sane workflow, was to create a git repository on each production
machine, so I can track and audit changes made by random hackers (I have
been unable to convince all of them to ask me to do it instead), and pull
from all of them to a git repository on my develpment machine to produce a
consolidated version.

I am keeping local branches on my devel repo corresponding to each
production machine and pulling from them every time somebody makes a
modification (after commiting on the production machine of course).

The main problem I am facing now is that I have been unable to make an
octopus merge from all the branches to consolidate them. When I do a
"git-pull . branch1 branch2..." git tells me "Unable to find common commit
with 5f83..." where 5f83... is the sha1 of the head commit of the first
branch on the command line. I am merging every branch with my master
branch one by one now, but it is a very time consumming and error prone
process. I would very much like to octopus merge the branches, with all
the conflicts, and then fix the master branch and release a consolidated
version.

Any hints?

-- 
Blu.
