From: Erez Zadok <ezk@cs.sunysb.edu>
Subject: why git-reset needed after "cp -a" of a git repo?
Date: Wed, 22 Aug 2007 14:57:05 -0400
Message-ID: <200708221857.l7MIv5tD011053@agora.fsl.cs.sunysb.edu>
Cc: Erez Zadok <ezk@cs.sunysb.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 20:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INvOI-0004bW-23
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 20:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbXHVS5O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 14:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbXHVS5O
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 14:57:14 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:46123 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbXHVS5N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 14:57:13 -0400
Received: from agora.fsl.cs.sunysb.edu (agora.fsl.cs.sunysb.edu [130.245.126.12])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l7MIv6e4030621;
	Wed, 22 Aug 2007 14:57:06 -0400
Received: from agora.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by agora.fsl.cs.sunysb.edu (8.13.1/8.13.1) with ESMTP id l7MIv5jt011056;
	Wed, 22 Aug 2007 14:57:05 -0400
Received: (from ezk@localhost)
	by agora.fsl.cs.sunysb.edu (8.13.1/8.12.8/Submit) id l7MIv5tD011053;
	Wed, 22 Aug 2007 14:57:05 -0400
X-MailKey: Erez_Zadok
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56405>

Apologies if this had been discussed before: I wasn't able to find this in
the ML archives.

Sometimes I copy a whole git archive using cp -a, for experimental reasons,
or otherwise; sometimes I rsync several git repos between remote and local
computers to make access faster (it's often faster to rsync two git repos
than to re-clone or deal with merge conflicts).

However, I noticed that after I copy a git repo (using v1.5.2.2), the index
entries are all out of sync, and I need to run git-reset.  Why?  What's in
the index file that changes after a cp -a or rsync that git depends on?  Is
it atime's and if so, aren't they copied by cp -a or rsync?  If it depends
on atime's, what happens if I mount my filesystem with noatime?  Or does
git's index depends on inode numbers which change after a cp -a?  (BTW, I
tried a variety of rsync options and none helped.)  I also briefly looked at
the source code and wasn't able to find the answer.

So, is there a way to efficiently copy a git repo on a local or remote host
w/o having to rerun git-reset afterwards?

Thanks,
Erez.
