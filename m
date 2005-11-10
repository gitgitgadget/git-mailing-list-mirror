From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: proper way to make cg-fetch work from originally git-clone'd tree
Date: 10 Nov 2005 05:51:57 -0800
Message-ID: <86mzkc4nlu.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 10 14:55:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaCqp-0005CV-Iy
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 14:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbVKJNwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 08:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbVKJNwE
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 08:52:04 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:61857 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750872AbVKJNwC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 08:52:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 3DE388F575
	for <git@vger.kernel.org>; Thu, 10 Nov 2005 05:51:58 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 01621-04-11 for <git@vger.kernel.org>;
 Thu, 10 Nov 2005 05:51:57 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id D577A8F588; Thu, 10 Nov 2005 05:51:57 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.14.2; tzolkin = 6 Ik; haab = 0 Ceh
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11484>


I tried git-fetch this morning, and it said I didn't have an origin,
which makes sense because I made the tree with git-clone, not cg-clone.

However, when I tried

        cg-branch-add origin rsync://rsync.kernel.org/pub/scm/git/git.git

it complained that I already had an origin!  It seems to work after
that, but what should I have done instead?  Is there a way to make
both cg-fetch and git-fetch to default to the same things?

By the way, my "make only if something changed" works now, because
I've separated cg-fetch and cg-merge.  My merge step looks like:

  cg-merge 2>&1 | grep -v 'already fully merged' && make prefix=/opt/git all install && (cd Documentation && make prefix=/opt/git all install)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
