From: Miles Bader <miles.bader@necel.com>
Subject: git add -i fails to heed user's exclude settings
Date: Thu, 08 Nov 2007 16:56:46 +0900
Message-ID: <buowsstmapt.fsf@dhapc248.dev.necel.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 08:57:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2GJ-0003bS-RM
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 08:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbXKHH46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 02:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbXKHH46
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 02:56:58 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:43853 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbXKHH45 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 02:56:57 -0500
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id lA87ul4r010574;
	Thu, 8 Nov 2007 16:56:47 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay31.aps.necel.com with ESMTP; Thu, 8 Nov 2007 16:56:47 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay31.aps.necel.com with ESMTP; Thu, 8 Nov 2007 16:56:47 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id D88C7545; Thu,  8 Nov 2007 16:56:46 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63949>

Inside git add -i, option 4 "add untracked", it doesn't seem to consider
the user's personal ignore patterns, which is _really_ annoying.

E.g., I have:

   $ git config core.excludesfile
   /home/miles/.gitignore

   $ cat /home/miles/.gitignore
   [+,#]*
   *~

   $ git status
   # On branch master
   nothing to commit (working directory clean)

   $ git add -i
              staged     unstaged path

   *** Commands ***
     1: status       2: update       3: revert       4: add untracked
     5: patch        6: diff         7: quit         8: help
   What now> 4
     1: ,l
     2: ,l.~1~
     3: AUTHORS.~1~
     4: Makefile.am.~1~
     5: config.h.in~
     6: configure.ac.~1~
     ...tons of other random backup files etc...

This makes it very hard to find files that actually need to be added!

Thanks,

-Miles

-- 
o The existentialist, not having a pillow, goes everywhere with the book by
  Sullivan, _I am going to spit on your graves_.
