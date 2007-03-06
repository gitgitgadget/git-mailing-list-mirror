From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 05 Mar 2007 16:32:48 -0800
Message-ID: <7vodn7w6rz.fsf@assigned-by-dhcp.cox.net>
References: <17895.18265.710811.536526@lisa.zopyra.com>
	<Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070302162136.GA9593@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070305072323.GA31169@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.27067.247950.419438@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.30394.172067.743310@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.36569.805689.922989@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
	<17900.39124.763603.695942@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org>
	<17900.42415.750335.329874@lisa.zopyra.com>
	<Pine.LNX.4.63.0703060026340.13683@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.43487.947400.649777@lisa.zopyra.com>
	<Pine.LNX.4.63.0703060042040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<87zm6rqlpn.fsf@graviton.dyn.troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 01:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HONbq-0000hc-Ix
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 01:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813AbXCFAcv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 19:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933546AbXCFAcv
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 19:32:51 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:45315 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932813AbXCFAcu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 19:32:50 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306003250.HGAK2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 19:32:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XCYo1W00x1kojtg0000000; Mon, 05 Mar 2007 19:32:49 -0500
In-Reply-To: <87zm6rqlpn.fsf@graviton.dyn.troilus.org> (Michael Poole's
	message of "Mon, 05 Mar 2007 19:06:44 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41513>

Michael Poole <mdpoole@troilus.org> writes:

> This all sounds a lot like git-clone's "alternate" code.
> ...
> My own work habits are very similar to Bill Lear's, but my projects'
> build times are small enough that it's less pain to rebuild half the
> project than to propagate changes recorded under $GIT_DIR between
> local branches.  I have not found a git workflow that makes me
> entirely happy, but I suspect I just don't know the magic words.

These days I use a few working trees that are connected to my
primary repository (which also has a working tree).  The primary
repository is in /src/git, and other ones look like this:

: gitster git.wk0; ls -l .git/
total 120
drwxrwsr-x  3 junio src  4096 Mar  5 16:22 ./
drwxrwsr-x 15 junio src 16384 Mar  5 16:23 ../
-rw-rw-r--  1 junio src    41 Mar  5 16:22 HEAD
lrwxrwxrwx  1 junio src    27 Mar  3 22:53 config -> /src/git/.git/config
lrwxrwxrwx  1 junio src    26 Mar  3 22:53 hooks -> /src/git/.git/hooks/
-rw-rw-r--  1 junio src 82455 Mar  5 16:22 index
lrwxrwxrwx  1 junio src    25 Mar  3 22:53 info -> /src/git/.git/info/
drwxrwsr-x  3 junio src  4096 Mar  3 22:59 logs/
lrwxrwxrwx  1 junio src    28 Mar  3 22:53 objects -> /src/git/.git/objects/
lrwxrwxrwx  1 junio src    32 Mar  3 22:53 packed-refs -> /src/git/.git/packed-refs
lrwxrwxrwx  1 junio src    25 Mar  3 22:53 refs -> /src/git/.git/refs/
lrwxrwxrwx  1 junio src    28 Mar  3 22:53 remotes -> /src/git/.git/remotes/
lrwxrwxrwx  1 junio src    29 Mar  3 22:53 rr-cache -> /src/git/.git/rr-cache/

It shares everything other than HEAD and the index (the reflog
for branches are also shared by a symlink .git/logs/refs
pointing at the one in the primary repository).

This risks confusion for an uninitiated if you update a ref that
is checked out in another working tree, but modulo that caveat
it works reasonably well.

We might want to add an option to 'git-clone' to create
something like this, but I am somewhat worried about the newbie
confusion factor.  Perhaps...

$ git clone --i-know-what-i-am-doing-give-me-an-alternate-working-tree \
  /src/git /src/git.wk0
