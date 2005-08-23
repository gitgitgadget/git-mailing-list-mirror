From: tony.luck@intel.com
Subject: baffled again
Date: Tue, 23 Aug 2005 15:56:27 -0700
Message-ID: <200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 00:58:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7hhA-0006D9-1K
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 00:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVHWW43 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 18:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVHWW43
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 18:56:29 -0400
Received: from fmr24.intel.com ([143.183.121.16]:13233 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932476AbVHWW42 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 18:56:28 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr004.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7NMuSDL024346
	for <git@vger.kernel.org>; Tue, 23 Aug 2005 22:56:28 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j7NMwuAi012515
	for <git@vger.kernel.org>; Tue, 23 Aug 2005 22:58:56 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1) with ESMTP id j7NMuR7I027893
	for <git@vger.kernel.org>; Tue, 23 Aug 2005 15:56:27 -0700
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id j7NMuR1q027892;
	Tue, 23 Aug 2005 15:56:27 -0700
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7684>

So I have another anomaly in my GIT tree.  A patch to
back out a bogus change to arch/ia64/hp/sim/boot/bootloader.c
in my release branch at commit

 62d75f3753647656323b0365faa43fc1a8f7be97

appears to have been lost when I merged the release branch to
the test branch at commit

 0c3e091838f02c537ccab3b6e8180091080f7df2

So now this file still has this:

/* SSC_WAIT_COMPLETION appears to want this large alignment.  gcc < 4
* seems to give it by default, however gcc > 4 is smarter and may
* not.
*/
struct disk_stat {
	int fd;
	unsigned count;
} __attribute__ ((aligned (16)));

in the test branch, when I think the comment and __attribute__
should have been backout out.

-Tony

Tree is at rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git
