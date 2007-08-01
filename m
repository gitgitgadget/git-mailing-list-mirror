From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt v0.27
Date: Wed, 1 Aug 2007 15:36:49 -0400
Message-ID: <20070801193649.GB20928@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org, brandon@ifup.org
To: guilt@josefsipek.net
X-From: git-owner@vger.kernel.org Wed Aug 01 21:37:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGK0B-0002rw-Io
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 21:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759973AbXHATgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 15:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759045AbXHATgy
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 15:36:54 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:34411 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757755AbXHATgx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 15:36:53 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l71JanJc023796;
	Wed, 1 Aug 2007 15:36:49 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l71JanMA023794;
	Wed, 1 Aug 2007 15:36:49 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54471>

Guilt v0.27 is available for download (once it mirrors out on kernel.org).

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


Alright, I'm trying to get back to the 2-week release schedule, so here's
v0.27!

There has been a number of changes in those two weeks, Out of the 20
commits, about half of them are bug fixes of all sorts - mostly preventive
(does anyone actually use whitespace in their branch names?).

The major changes include some performance speedups. Little bit thought
(there's more to come!) went into making guilt-push faster, 0.27 is about 8%
faster than 0.26 on push. The other major thing is the infrastructure (which
turned out to be really simple) for hooks. Currently, only one hook is
supported (guilt-delete) but that'll change sooner or later.

And the last major change under the hood: guilt now checks and expects git
1.5.

Other new features:
	guilt-series -e	to edit the series file by hand
	guilt-header -e to edit a patch's header
	guilt-refresh --diffstat to include a diffstat in the patch file

As always, patches, and other feedback is welcome.

Josef "Jeff" Sipek.

------------
Changes since v0.26:

Dmitry Monakhov (2):
      Fix guilt-import patch naming
      Add series editor support

Eric Lesh (4):
      Handles slashes in branch names
      Makefile: don't install *~ files
      guilt-rebase: Make fast-forward work
      guilt-header: Add -e option for editing

Josef 'Jeff' Sipek (14):
      refresh: Added --diffstat option
      init: Be careful with whitespace in branch names
      guilt: check git version and bail if version is not supported
      guilt: Create infrastructure for guilt hooks
      delete: Added delete-patch hook
      pop: Check if no patches are applied
      guilt: Do not scan entire patch file when not necessary
      guilt: git-apply --index can be used to update the index
      guilt: Remove unnecessary reading of the status file
      push_patch: propagate return code to caller
      rebase: warn the user that rebase is experimental
      Documentation: document series -e option
      header: rewrite option parsing and patch searching
      Guilt v0.27

Michael Halcrow (1):
      import-commit: Retry with a different patch name if necessary
