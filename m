From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [[TIG][PATCH v2] 0/3] Refactoring the log view
Date: Tue, 06 Aug 2013 00:58:18 -0400
Message-ID: <1375765101-31461-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: fonseca@diku.dk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 06:58:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6ZLx-0005xw-UY
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 06:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab3HFE61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 00:58:27 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:33612 "EHLO
	mta2.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab3HFE60 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 00:58:26 -0400
Received: from odessa (ool-18bb429a.dyn.optonline.net [24.187.66.154])
 by mta2.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0MR300FMFF5AH830@mta2.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Tue, 06 Aug 2013 00:58:23 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.80)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)	id 1V6ZLi-0008Ec-J0; Tue,
 06 Aug 2013 00:58:22 -0400
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231720>

This is a second iteration. This handles the following:

- remove unneeded comments
- remove unneeded pager_request calls
- rename update_commit_ref to recalculate_commit_context

Now, the only thing missing is the recalculation of commits when the
line number is changed. The trouble there is that using the :<n>
approach doesn't call log_request, so we need to come up with a
smarter way to communicate the line number change, I guess.

Thanks for all the feedback!

Kumar Appaiah (3):
  Add log_select function to find commit from context in log view
  Display correct diff the context in split log view
  Revert "Scroll diff with arrow keys in log view"

 NEWS  |  1 +
 tig.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 7 deletions(-)

-- 
1.8.3.2
