From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Joining two development histories together and then splitting them
 back apart.
Date: Thu, 14 Feb 2008 21:41:00 -0800
Organization: Bluelane
Message-ID: <47B525EC.2090508@bluelane.com>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>,
	Piet Delaney <piet.delaney@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 06:58:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPtaD-0005Cs-Ti
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 06:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbYBOF5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 00:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbYBOF5U
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 00:57:20 -0500
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:2658 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751770AbYBOF5T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2008 00:57:19 -0500
X-Greylist: delayed 973 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Feb 2008 00:57:19 EST
Received: from piet2.bluelane.com ([64.94.92.242]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 15 Feb 2008 00:41:05 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-Enigmail-Version: 0.95.6
X-OriginalArrivalTime: 15 Feb 2008 05:41:05.0803 (UTC) FILETIME=[5B9F35B0:01C86F95]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73940>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi:

I thought I'd check on the right procedure for merging two branches and
then forking them off from that merged point. It's been a while since I
set up git, I've been hacking on the kernel for a couple of months and
now want to merge it with our old CVS repository that I imported into git.


First, on a remote machine I pull the repo and then check out a
tracking branch; right? Ex:

~  git clone git.bluelane.com:/home/git/blux

~  git checkout -b engg origin/engg
~  Branch engg set up to track remote branch refs/remotes/origin/engg.
~  Switched to a new branch "engg"


Now I'd like to merge it with another branch, which is kinda
of like the master branch, but it's actually not the master/head.
So in my case I want to merge with origin/rel2_branch from the
master git repo.

So as I recall I set up my .git/config with:

	[diff]
~        	external = "/usr/bin/kompare"
~        	renames = true

	[merge]
~        	tool = "/usr/bin/kdiff3"

Next I do a:

	git-merge origin/rel2_branch

hopefully kcompare will then pop up for the merge resolution.


Now that the two branches are in sync I'd like to split the
two branches and then push that up the the remote repository
and hopeful all new changes to the engg branch will not be
seen if someone pulls out the rel2_branch.

I'm not sure if git will let me do all of this. I recall
some security stuff preventing the code from being easily
push up to the top repository. Also I'm not sure if this
part can be done in the local repo on my workstation.

I suppose it will all start coming back to me as I mess
with it tomarrow.

I thought it would likely be worthwhile to check with the git
mailing list to get a few pointers to hopefully save some time
tomarrow with the merge. I had the trees merged a few months
ago but the repo got a bit weird with my copying my merged
repo to the git repo and getting origins in the branch names
on the main repository.

- -piet





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHtSXrJICwm/rv3hoRAmE5AJ96z755CwbwrUdHIENVUUEQk0xhEgCdE3TO
8jFrAqYbWZsD00nKcZs+XJU=
=Wtbg
-----END PGP SIGNATURE-----
