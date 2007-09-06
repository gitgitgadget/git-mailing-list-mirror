From: Erez Zadok <ezk@cs.sunysb.edu>
Subject: very slow cherry-pick'ing (old-2.6-bkcvs tree)
Date: Thu, 6 Sep 2007 19:51:49 -0400
Message-ID: <200709062351.l86NpnAK004807@agora.fsl.cs.sunysb.edu>
Cc: ezk@cs.sunysb.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 01:52:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITR8j-0008PG-Sf
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 01:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbXIFXv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 19:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbXIFXv4
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 19:51:56 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:35610 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbXIFXvz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 19:51:55 -0400
Received: from agora.fsl.cs.sunysb.edu (agora.fsl.cs.sunysb.edu [130.245.126.12])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l86Npm5L023168;
	Thu, 6 Sep 2007 19:51:48 -0400
Received: from agora.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by agora.fsl.cs.sunysb.edu (8.13.8/8.13.8) with ESMTP id l86Npn1s004810;
	Thu, 6 Sep 2007 19:51:49 -0400
Received: (from ezk@localhost)
	by agora.fsl.cs.sunysb.edu (8.13.8/8.12.8/Submit) id l86NpnAK004807;
	Thu, 6 Sep 2007 19:51:49 -0400
X-MailKey: Erez_Zadok
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57950>

Our group maintains Unionfs on the latest -rc kernel, but we also maintain
several backports going all the way to 2.6.9.  Once we complete the
development and testing of a feature/fix in -latest, we cherry-pick those
commits to older backports, and test those.  When I cherry-pick from -latest
to my 2.6.{22,21,20,19,18} repositories, it works reasonably fast.  But when
I cherry-pick to my 2.6.9 tree, it runs about 20 times slower!  Why?  Is
there anything I can do to inspect what's going on and perhaps speed up the
cherry-picking process?

Some info:

My 2.6.{18,19,20,21,22} trees were cloned from

   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.<N>.y.git

My 2.6.9 tree, however, was cloned from

   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/old-2.6-bkcvs.git

after which, I truncated the tree (git-reset) to Linus commit which read
"Linux 2.6.9-final".

BTW, I first git-clone --bare to my git server, and then I clone from it to
my test machine.

BTW2, I do git-repack and prune-packed every week.

Thanks,
Erez.
