From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Subject: [ANNOUNCE] Guilt v0.30
Date: Thu, 10 Apr 2008 20:01:43 -0400
Message-ID: <20080411000143.GC3838@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: guilt@josefsipek.net
X-From: git-owner@vger.kernel.org Fri Apr 11 02:02:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk6is-0004qY-Rn
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 02:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191AbYDKABp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 20:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962AbYDKABo
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 20:01:44 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:40146 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbYDKABo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 20:01:44 -0400
Received: from josefsipek.net (baal.fsl.cs.sunysb.edu [130.245.126.78])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id m3B01fBn000472;
	Thu, 10 Apr 2008 20:01:41 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 39DA81C00DD8; Thu, 10 Apr 2008 20:01:43 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79259>

Guilt v0.30 is available for download (once it mirrors out on kernel.org).

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


As promissed, this version includes some interesting changes.  The major one
being the status file now has a new format.  The motivation for this was the
fact that the series file effectively duplicated functionality that git
itself offered by setting arbitrary refs (e.g., refs/patches/$branch/$patch).
Migration between the two formats should be rather painless.  If you have no
applied patches, no extra work is required.  If you happen to have some
patches already applied, any guilt command will tell you to run:
guilt-repair --status.

Other than the status file change, there have been a number of improvements
all over the place.  A couple of bash-isms were removed, patchbomb no longer
includes "1/1" in the subject when there's only one patch, guilt-repair is
more powerful, and can be used to fix up a number of conditions (e.g.,
autotags left behind, status file format upgrade, etc.), autotagging no
longer ignores global guilt.autotag config value.

As always, patches, and other feedback is welcome.

Josef "Jeff" Sipek.

------------
Changes since v0.29:

Adam Golebiowski (1):
      Add support for DESTDIR in guilt/Makefile.

Josef 'Jeff' Sipek (35):
      guilt: Use 'git update-ref' instead of echo
      Patch names cannot contain whitespace
      guilt: setup/teardown refs/patches/$branch/$patch on push/pop
      Remove old status format
      repair: remove patch refs
      regression: test guilt-repair
      commit: new command to permanently commit patches
      regression: guilt-commit test
      regression: fix up test 028 expected output
      Update my email address
      repair: allow status file upgrade
      guilt: check status file for being old format
      guilt: replace "echo && return 1" with die
      repair: added --autotag repair mode
      guilt: wrap `git-update-ref -d` to make ref removal cleaner
      regression: simple makefile
      fork: fix regression caused by status format change
      guilt: try to be more portable
      Replace all display related `echo` calls with a custom function
      regression: simplify command logging
      regression: try to be more portable
      guilt: ref_rename_patch takes patch names, not ref names
      regression: test for guilt-fork
      regression: 011 should test guilt-commit as well
      init: honor a global/system guilt.autotag config option
      regression: test the new init options
      autotagging: fix a tiny quirk, and document autotagging properly
      import-commit: replace be careful about * and ? in filenames
      graph: display patch names instead of hashes
      patchbomb: do not include "1/1" in the subject if there's only 1 patch
      files: use the diff-index for top-most patch
      regression: test guilt-files reading the index for the top-most applied patch
      regression: test guilt-files -v
      regression: test that supplied test numbers are valid
      Guilt v0.30
