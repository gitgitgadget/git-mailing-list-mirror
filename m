From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Versioning for template directory?
Date: Mon, 22 Aug 2005 17:59:43 +0200
Message-ID: <200508221759.43153.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 22 22:44:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7J9j-0006SI-0p
	for gcvg-git@gmane.org; Mon, 22 Aug 2005 22:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVHVUnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 16:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVHVUnl
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 16:43:41 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:37095 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751136AbVHVUnk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2005 16:43:40 -0400
Received: from mailout1.informatik.tu-muenchen.de (mailout1.informatik.tu-muenchen.de [131.159.0.18])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7MG1EDR016800
	for <git@vger.kernel.org>; Mon, 22 Aug 2005 09:01:15 -0700
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

as more and more hooks are added to git, I would want to have the hook 
scripts, part of the per-repository configuration, itself in version control. 
If you look at CVS, the configuration there is also under version control (in 
CVSROOT). I can do this manually: after git-init-db, go into .git/hooks, do a 
git-init-db again, adding the hooks for version control, and commiting the 
initial version of the hooks.

But I get the feeling that the different hooks should be versioned 
on a file basis, and not on a directory/whole project basis.
Here, I explicitly want to have the RCS/CVS way of versioning.
[Another use case: a wiki site managed via a GIT archive, to be able to change 
the site offline. Here too, I would want to have versioning on a file basis]

Is there a way to "extend" git to allow for this kind of versioning? This 
needs multiple simultaneous checkouts of heads representing independent 
project parts (i.e. single files). There would be a GIT index for every such 
independent project part; the problem being that the checkouts should be done 
into the same directory.

So what is the best way to accomplish this?
I have to use multiple index files (index1, index2, ...), allowing multiple 
independent branches could be checked out independently. Another extension 
would be kind of a "super-head" specifying multiple heads (SHAs) 
which are to be checked out simultaneously (via index1, index2...). It should 
be possible to create signed tags out of such super-heads.

Is this feasable?

Josef
