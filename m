From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: bisect gives strange answer
Date: Thu, 04 Aug 2005 03:23:28 -0400
Message-ID: <E1E0a4e-0000vu-69@approximate.corpus.cam.ac.uk>
References: <7v8xzi42bm.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 09:24:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0a4w-0006uj-O1
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 09:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVHDHXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 03:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVHDHXl
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 03:23:41 -0400
Received: from smtpauth03.mail.atl.earthlink.net ([209.86.89.63]:14219 "EHLO
	smtpauth03.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261942AbVHDHXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 03:23:40 -0400
Received: from [24.41.6.91] (helo=approximate.corpus.cam.ac.uk)
	by smtpauth03.mail.atl.earthlink.net with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1E0a4q-0004Gm-C9; Thu, 04 Aug 2005 03:23:40 -0400
Received: from sanjoy by approximate.corpus.cam.ac.uk with local (Exim 4.52)
	id 1E0a4e-0000vu-69; Thu, 04 Aug 2005 03:23:28 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Your message of "Wed, 03 Aug 2005 23:57:01 PDT."
             <7v8xzi42bm.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 21.4.1
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478819d4bc37d9c2ebfbb06e1ecb428e26b73a2d4bdd6ab9174350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Could you try this please?

Thanks, it now finishes with the diff that I expected:

3d3c2ae1101c1f2dff7e2f9d514769779dbd2737 is first bad commit
diff-tree 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737 (from a18bcb7450840f07a772a45229de4811d930f461)
Author: Greg KH <gregkh@suse.de>
Date:   Wed Jul 6 09:09:38 2005 -0700

    [PATCH] PCI: fix !CONFIG_HOTPLUG pci build problem
    
    Here's a patch to fix the build issue when CONFIG_HOTPLUG is not enabled
    in 2.6.13-rc2.
    
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 93e93c4d8e88d6e05e815261f96ab38376c92809 b9cbda6dd88aeca51031d36e00f396e7091fd54c M	drivers


The full run is included below.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal


+ git bisect reset
+ git bisect start
+ git bisect good 17af691cd19765b782d891fc50c1568d0f1276b3
+ git bisect bad c101f3136cc98a003d0d16be6fab7d0d950581a6
Bisecting: 42 revisions left to test after this
+ cat .git/HEAD
b2f571026594884e7a2a3f8bc6ad5c92e0703330
+ git bisect good
Bisecting: 30 revisions left to test after this
+ cat .git/HEAD
450008b5a62bb09445ae05c4d01d510386c9435d
+ git bisect good
Bisecting: 15 revisions left to test after this
+ cat .git/HEAD
a9df3597fec5472d0840fbfdc2a3fac5268f7d08
+ git bisect bad
Bisecting: 8 revisions left to test after this
+ cat .git/HEAD
28e8c3ad9464de54a632f00ab3df88fa5f4652d1
+ git bisect bad
Bisecting: 4 revisions left to test after this
+ cat .git/HEAD
c774e93e2152d0be2612739418689e6e6400f4eb
+ git bisect bad
Bisecting: 2 revisions left to test after this
+ cat .git/HEAD
b4634484815e1879512a23e4f59eef648135c30a
+ git bisect bad
3d3c2ae1101c1f2dff7e2f9d514769779dbd2737 is first bad commit
diff-tree 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737 (from a18bcb7450840f07a772a45229de4811d930f461)
Author: Greg KH <gregkh@suse.de>
Date:   Wed Jul 6 09:09:38 2005 -0700

    [PATCH] PCI: fix !CONFIG_HOTPLUG pci build problem
    
    Here's a patch to fix the build issue when CONFIG_HOTPLUG is not enabled
    in 2.6.13-rc2.
    
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 93e93c4d8e88d6e05e815261f96ab38376c92809 b9cbda6dd88aeca51031d36e00f396e7091fd54c M	drivers
