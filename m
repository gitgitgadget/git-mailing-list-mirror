From: Jim Meyering <jim@meyering.net>
Subject: synchronizing incremental git changes to cvs
Date: Sun, 21 May 2006 00:13:25 +0200
Message-ID: <87mzdcjqey.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 21 00:13:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhZhX-00014X-P5
	for gcvg-git@gmane.org; Sun, 21 May 2006 00:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWETWN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 18:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWETWN2
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 18:13:28 -0400
Received: from mx.meyering.net ([82.230.74.64]:15529 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S932394AbWETWN1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 18:13:27 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id CF90634919; Sun, 21 May 2006 00:13:25 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20398>

Hello,

Can anyone point me at code to mirror a git repository to cvs?
I'd like to develop using git, and have a commit hook mirror the
day-to-day changes (tags/commits) made in the git repo to a
cvs repository.  The idea is that the only way changes get into
the cvs repo is via the git commit hook.

I've experimented with git-cvsexportcommit, and found a few bugs (it
couldn't handle simple things, like adding a file in a new directory --
fixed that, along with a few other minor problems), adding an empty file
in git still gets a patch application error on the cvs side, but I can
live with that for now.  More seriously, making a change on a git branch
mistakenly tries to apply the delta on the cvs trunk.  None of this is
particularly hard to fix -- or even critical, as long as you don't care
about branches.  I'm just hoping someone has already produced something
more robust.  From the looks of darcs/tailor, it doesn't handle the use
of git as a source.

Why am I interested?  I want to switch the development of GNU coreutils
from cvs to git.  I would also like to continue making the repository
available via cvs, for the sake of continuity.  At worst, I can always
cut the CVS cord, but that's a last resort.

Jim
