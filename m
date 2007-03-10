From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Subject: [GUILT][RFC] Autotagging
Date: Fri,  9 Mar 2007 23:46:21 -0500
Message-ID: <11735019831915-git-send-email-jsipek@cs.sunysb.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 05:46:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPtTS-00007n-T5
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 05:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767815AbXCJEqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 23:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767816AbXCJEqZ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 23:46:25 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54225 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767815AbXCJEqY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 23:46:24 -0500
Received: from thor.fsl.cs.sunysb.edu (thor.fsl.cs.sunysb.edu [130.245.126.40])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l2A4kL83028987
	for <git@vger.kernel.org>; Fri, 9 Mar 2007 23:46:21 -0500
Received: from jsipek by thor.fsl.cs.sunysb.edu with local (Exim 4.63)
	(envelope-from <jsipek@dhcp42.fsl.cs.sunysb.edu>)
	id 1HPtTL-0007Vx-2b
	for git@vger.kernel.org; Fri, 09 Mar 2007 23:46:23 -0500
X-Mailer: git-send-email 1.5.0.3.268.g3dda
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41844>

Greetings all!

Recently, it has been brought to my attention that it would be nice to be
able to refer to the top/bottom/base of the patch stack in Guilt by a name
instead of fishing around the log for the hash. I quickly coded up the
following solution (which I call "autotagging"), which creates unannotated
tags for the top (topmost applied patch), bottom (first applied patch), and
base (parent of bottom) in with this naming scheme:

	${branch}_top
	${branch}_bottom
	${branch}_base

The branch name is necessary as each branch has its own series of patches,
and potentially different history to begin with.

Of course, I included an option to disable this feature (see patch 2) - just
set guilt.autotag=0 in your git config.

Before I merge this into Guilt master, I was hoping for some feedback. Just
in case I completely missed something obvious, or perhaps there is a better
way to name the branches :)

Thanks,

Josef "Jeff" Sipek.
