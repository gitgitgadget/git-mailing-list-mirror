From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: how to have real (existing) submodules?
Date: Wed, 8 Dec 2010 20:58:46 +0000
Message-ID: <20101208205846.GW29789@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 22:29:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQRa3-0002aQ-O7
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 22:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741Ab0LHV3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 16:29:38 -0500
Received: from laurel.swan.ac.uk ([137.44.1.237]:44289 "EHLO laurel.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab0LHV3i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 16:29:38 -0500
X-Greylist: delayed 1850 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2010 16:29:38 EST
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by laurel.swan.ac.uk with esmtp (Exim 4.70)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1PQR67-0004qS-An; Wed, 08 Dec 2010 20:58:47 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 0D0F31BE10C;
	Wed,  8 Dec 2010 20:58:47 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id F3449741ED; Wed,  8 Dec 2010 20:58:46 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163222>

Hi,

I have the following organisational problem:

Due to access restrictions, privacy, communication problems etc.
I need to have independent git repositories for various projects
(for example working on a scientific paper --- tossing the repos
as tarballs around is really great, and it works also for those
who do not want to use git). There repositories exist all at various
locations, often just local repositories, without internet access
(though some are on Github).

This creates obviously the problem of carrying them around (especially
given that certain places don't have Internet connection, and data
needs to be transferred via memory sticks).

I thought that "git submodule" would solve the problem, but now
I realised that these submodules are not "real", but they only contain
a bit of meta-data (this should really be said directly in the documentation).

So my hope, that I can have one super-repo, where I say, e.g., "git submodule foreach pull",
get the full super-repo, copy it on a memory stick, and then by pulling from
that copy I get everything into another super-repo, from which I distribute the
sub-repos, seems not so easily realisable with git?

A major restriction of git seems that the url's of each sub-repo need to
be unique, since they are in the global file .gitmodules? This seems strange
to me: If every submodule had its repo-specific pull-information, then still
by foreach-git-pull, where each pull has location-specific information, I
could achieve something. 

Hm, is the way how this is supposed to work really to first do "git submodule init",
to get a false path to the sub-repo into config, and then to change that path?
Then I have that nonsensic information about the url in .gitmodules?
And I can't just push the whole thing to Github (as I would have hoped)?
There is also the old problem that config is not under version control.
So "submodule" would be just about substituting scripts which run through
a bunch of repos and call, e.g., git pull in each (but with a certain commit in mind)?

Anyway, if that's how it is, please just tell me.
(And perhaps the use-case is somehow convincing to a developer, and
somebody might think about adding "full" submodules.)

Thanks in any case!

Oliver
