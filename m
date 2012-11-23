From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/6] git p4 error handling
Date: Fri, 23 Nov 2012 17:35:33 -0500
Message-ID: <1353710139-16207-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 23:36:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc1qq-00050P-GB
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 23:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab2KWWfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 17:35:43 -0500
Received: from honk.padd.com ([74.3.171.149]:35225 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756322Ab2KWWfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 17:35:42 -0500
Received: from arf.padd.com (unknown [50.55.150.96])
	by honk.padd.com (Postfix) with ESMTPSA id 47EBDE9A;
	Fri, 23 Nov 2012 14:35:42 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D927A27578; Fri, 23 Nov 2012 17:35:39 -0500 (EST)
X-Mailer: git-send-email 1.8.0.360.gc68af86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210274>

These are assorted minor fixes.  They should be safe for 1.8.1,
and are not urgent enough for maint.

Four of them deal with handling errors from p4d better.  The first two
of these have been seen on the list already.  The third showed up in my
own testing.  The fourth adds a test to make sure that existing error
handling continues to work.

  git p4: catch p4 describe errors
  git p4: handle servers without move support
  git p4: catch p4 errors when streaming file contents
  git p4 test: display unresolvable host error

These two are small cleanups found by pylint, one of which is an
obvious (but rare) bug.

  git p4: fix labelDetails typo in exception
  git p4: remove unneeded cmd initialization

 git-p4.py                | 97 ++++++++++++++++++++++++++++++++++++++----------
 t/t9800-git-p4-basic.sh  | 25 ++++++++++++-
 t/t9814-git-p4-rename.sh | 35 +++++++++++++++++
 3 files changed, 137 insertions(+), 20 deletions(-)

-- 
1.8.0.276.gd9397fc
