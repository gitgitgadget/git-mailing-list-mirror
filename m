From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/6] git-p4: view spec improvements
Date: Mon,  2 Jan 2012 18:05:48 -0500
Message-ID: <1325545554-16540-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 00:06:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhqxB-0006FE-Ln
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 00:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab2ABXF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 18:05:59 -0500
Received: from honk.padd.com ([74.3.171.149]:43654 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2ABXF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 18:05:58 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id C75A81C7E;
	Mon,  2 Jan 2012 15:05:57 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 413E0667D7; Mon,  2 Jan 2012 18:05:54 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.409.g3e338
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187843>

Gary found and fixed a few bothersome problems with how
git-p4 parses the View lines in client specifications.
I got the itch to fix other issues, and ended up writing
a battery of test cases and redoing the view spec code
entirely.

Patch summary:

    1.  Add 22 test cases for client view spec handling,
	most of which are expected to fail.  Test review
	welcome.

    2-4.  Fix issues with unsupported wildcards, incorrect
	  sorting, and add support for single-file maps.

    5.  Rewrite view spec code, fixing the rest of the tests.
        This is new python that could use some review.

    6.  Update docs.  This depends on pw/p4-docs-and-tests that
	is in next.

Gary Gibbons (3):
  git-p4: fix test for unsupported P4 Client Views
  git-p4: sort client views by reverse View number
  git-p4: support single file p4 client view maps

Pete Wyckoff (3):
  git-p4: test client view handling
  git-p4: rewrite view handling
  git-p4: view spec documentation

 Documentation/git-p4.txt      |   40 ++++--
 contrib/fast-import/git-p4    |  316 ++++++++++++++++++++++++++++++++---------
 t/t9809-git-p4-client-view.sh |  290 +++++++++++++++++++++++++++++++++++++
 3 files changed, 564 insertions(+), 82 deletions(-)
 create mode 100755 t/t9809-git-p4-client-view.sh

-- 
1.7.8.1.407.gd70cb
