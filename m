From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt v0.26
Date: Tue, 17 Jul 2007 11:28:59 -0400
Message-ID: <20070717152859.GA12247@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org, brandon@ifup.org
To: guilt@josefsipek.net
X-From: git-owner@vger.kernel.org Tue Jul 17 17:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAozQ-0002dT-H2
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 17:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648AbXGQP3F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 11:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753021AbXGQP3E
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 11:29:04 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:38610 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbXGQP3C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 11:29:02 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6HFSxlu013956;
	Tue, 17 Jul 2007 11:28:59 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6HFSxjW013954;
	Tue, 17 Jul 2007 11:28:59 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52763>

Guilt v0.26 is available for download (once it mirrors out on kernel.org).

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


Although there was a v0.26-rc1 release, I never announced it so the
following summary includes all the changes since v0.25. Unfortunately, it
took two months to get this release out. I promise to get back to the 2-3
week release cycle.

The major change since v0.25 (contributed by Pierre Habouzit) is that Guilt
no longer depends on bash. Other than that, there have been a number of bug
fixes, as well several new commands and options:

	branch		Branch the repository & patch series
	diff		Output a diff against the top-most applied patch
	fold -k		Keep patch file
	graph		Generate dot(1) patch dependecy graph
	new -f		Force new patch creation
	refresh --git	Detect renames & copies
	series -g	Start gitk on the applied patches

Additionally, Guilt now knows how to:

	Grab Cc: lines from the patch descriptions for patchbomb
	Strip 'Subject: ' from the first line of patch description

All in all, quite a number of changes, so it is possible that I forgot to
mention something. For more details, check the change list below, or the git
repository near you :)

As always, patches, and other feedback is welcome.

Josef "Jeff" Sipek.

------------
Changes since v0.25:

Josef 'Jeff' Sipek (20):
      graph: generate a dot(1) dependency graph of patches
      graph: Remove graph cache after command terminates
      new: Added new option, -f to force new patch creation
      refresh: Added --git option to generate more git friendly diff
      new: current working dir should not be displayed
      export: Create subdirectories before copying the patch files
      series: Added -g option to start gitk
      refresh: Reintroduce the --git option that got accidentally dropped
      guilt: added -V/--version option to display only the version number
      fold: Added -k option to keep patch file
      Guilt v0.26-rc1
      guilt: Strip "^Subject: " from first line of patch message
      Docs/Requirements: sh is now required instead of bash
      branch: new command to create a new branch with duplicated patches directory
      Docs: A begining of a Features file
      graph: Fixed graph generation
      patchbomb: Grab additional Cc info from '^Cc:' lines in patch desc
      patchbomb: Remove leftover debug code
      diff: Create a diff against the top-most applied patch
      Guilt v0.26

Pierre Habouzit (8):
      Add a guilt-export(1) command to export a guilt series to quilt.
      guilt(1): Obvious bashisms fixed.
      guilt(1): simplifications...
      guilt(1): reimplement push_patch, using a subshell to avoid locals.
      Remove bashisms - easy commands
      guilt-status(1): Remove bashisms.
      Remove last bashisms from remaining commands.
      Regression test suite needs bash, that's OK.

Theodore Ts'o (1):
      Fix guilt to work correctly even if the refs are packed
