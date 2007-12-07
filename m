From: Michael Poole <mdpoole@troilus.org>
Subject: After-the-fact submodule detection or creation
Date: Thu, 06 Dec 2007 22:01:04 -0500
Message-ID: <87ir3bp5sf.fsf@graviton.dyn.troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 04:01:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0TT4-00035d-2h
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 04:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbXLGDBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 22:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbXLGDBN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 22:01:13 -0500
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:47277
	"EHLO sanosuke.troilus.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751794AbXLGDBM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Dec 2007 22:01:12 -0500
Received: by sanosuke.troilus.org (Postfix, from userid 1000)
	id 3777D89C05C; Thu,  6 Dec 2007 22:01:04 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67369>

I have a project where most branches have one subdirectory for the
core program and other subdirectories for support scripts, programs
and libraries.  The supporting subdirectories vary from branch to
branch.  However, some branches contain just the core program, with no
subdirectories.  Starting from scratch, I would say the core program
should be a submodule, but historically it was not populated as one.

Is there a way to easily create such a pseudo-submodule branch in git,
or are real submodules strongly preferred for this kind of scenario?

(The added twist: I ran into this while importing a Subversion
repository.  git-svn identified two trees of history in the repository
-- one history containing the core plus support trees, one history
containing just the core program.  Since the trees do have the same
contents, only the commits are duplicated, but that is not quite
ideal.

It seems like using the current submodule code would mean that this
kind of import would need two passes over the foreign repository,
rather than one if the branch could be created after the parent tree
is initially imported.  I can live with that -- it is a rather unusual
case -- but maybe there is a better way.)

Michael Poole
