From: Deepak Saxena <dsaxena@plexity.net>
Subject: git-rebase: "Patch is empty.  Was it split wrong?"
Date: Mon, 24 Mar 2008 13:11:13 -0700
Organization: Plexity Networks
Message-ID: <20080324201113.GA15153@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 21:20:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdt9R-0004UJ-To
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 21:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYCXUS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 16:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753180AbYCXUS6
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 16:18:58 -0400
Received: from plexity.net ([206.123.115.38]:43191 "EHLO plexity.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbYCXUS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 16:18:57 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Mar 2008 16:18:56 EDT
Received: from plexity.net (c-71-59-208-117.hsd1.or.comcast.net [71.59.208.117])
	by plexity.net (Postfix) with ESMTP id 9AFB53035F
	for <git@vger.kernel.org>; Mon, 24 Mar 2008 20:10:56 +0000 (UTC)
Received: by plexity.net (Postfix, from userid 1025)
	id A911C5452F6; Mon, 24 Mar 2008 13:11:13 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78093>

I'm getting the above message when doing a git-rebase and wondering
is is due to user error in how I am using rebase or b/c of something
else.

My situation is that a I have a main branch "dev", against which
others have developed some branches and I merge into my local
version of dev. After merging these I want to rebase to remove the
merge itself from the history (I need to linearize the history, 
long story, don't ask why):

$ git-checkout -b f2.6.24_dev f2.6.24/dev
Branch f2.6.24_dev set up to track remote branch refs/remotes/f2.6.24/dev.
Switched to a new branch "f2.6.24_dev"
$ git-merge 27234_v01 27470_v01 27476_v01
Trying simple merge with bdc5878e45152a11c9a434bd4e0a07ddf98434be
Trying simple merge with 2d03ed92eecb9bde8402957d9e801d9055dbcef4
Trying simple merge with af38b4a114b3380cdc7c426b912ede1e4e023b74
Merge made by octopus.
....
 22 files changed, 2407 insertions(+), 150 deletions(-)
 create mode 100644 include/linux/mroute6.h
 create mode 100644 include/linux/pim.h
 create mode 100644 net/ipv6/ip6mr.c
$ git-log --pretty=oneline f2.6.24/dev..
96f76db4b03413f0ec14c6d45f19cbf1398dd7b7 Merge branches '27234_v01', '27470_v01' and '27476_v01' into f2.6.
bdc5878e45152a11c9a434bd4e0a07ddf98434be [IPV6] Add support for IPv6 multicast forwarding
af38b4a114b3380cdc7c426b912ede1e4e023b74 ARM: OMAP: NAND: update platform data
c17782dc688990e1971ae94c99476cbc529a04de ARM: OMAP: NAND: update Kconfig and default defconfig
10fab40c623ae6d71bbda94de61088dab88859e4 ARM: OMAP: NAND: logic for detecting the flash device
4e1c857c6256967da11ecc0f147b87f4d5613e4e ARM: OMAP: NAND: code documentation cleanup
33ae04c1febef4de882c6b65ec6c50d72e3f0d34 ARM: OMAP: NAND: 8/16 bit, large/small page, HWECC/SWECC support
2d03ed92eecb9bde8402957d9e801d9055dbcef4 sched: fix oops in root-domain code during repartitioning
$ git-rebase f2.6.24/dev
First, rewinding head to replay your work on top of it...
HEAD is now at 325943d... Make RT73 config more consistant with other drivers
Patch is empty.  Was it split wrong?

Am I just abusing git-rebase here or is there something wrong with my tree?

Version is 1.5.4.4.

Thanks,
~Deepak


-- 
   _____   __o  Deepak Saxena - Living CarFree and CareFree            (o>
------    -\<,  Towards Carfree Cities 2008 - www.carfreeportland.org  //\
 ----- ( )/ ( ) Linux Plumber's Conference - www.linuxplumbersconf.org V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
