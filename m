From: Neil Horman <nhorman@tuxdriver.com>
Subject: odd behavior with git-rebase
Date: Fri, 23 Mar 2012 14:52:05 -0400
Message-ID: <20120323185205.GA11916@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 19:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB9b0-0006XX-5h
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 19:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155Ab2CWSwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 14:52:13 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:41144 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab2CWSwM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 14:52:12 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SB9aq-0005Ld-3N
	for git@vger.kernel.org; Fri, 23 Mar 2012 14:52:09 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193792>

Hey all-
	I hit a strange problem with git rebase and I can't quite decide if its
a design point of the rebase command, or if its happening in error.  When doing
upstream backports of various kernel components I occasionally run accross
commits that, for whatever reason, I don't want/need or can't backport.  When
that happens, I insert an empty commit in my history noting the upstream commit
hash and the reasoning behind why I skipped it (I use git commit -c <hash>
--allow-empty).  If I later rebase this branch, I note that all my empty commits
fail indicating the commit cannot be applied.  I can of course do another git
commit --allow-empty -c <hash>; git rebase --continue, and everything is fine,
but I'd rather it just take the empty commit in the rebase if possible.

I know that git cherry-pick allows for picking of empty commits, and it appears
the rebase script uses cherry-picking significantly, so I'm not sure why this
isn't working, or if its explicitly prevented from working for some reason.

anyone have any insight?

Thanks & Regards
Neil
