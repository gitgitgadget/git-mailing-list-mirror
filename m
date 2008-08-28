From: Paolo Ciarrocchi <paolo.ciarrocchi@vodafone.com>
Subject: Subject: [PATCH] Update to the git tutorial
Date: Thu, 28 Aug 2008 14:23:52 +0200
Message-ID: <48B698D8.6080300@vodafone.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 28 14:44:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYgrr-0004qM-UK
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 14:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbYH1Mnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 08:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbYH1Mnm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 08:43:42 -0400
Received: from mailout-1.omnitel.it ([194.20.77.121]:35754 "EHLO
	fmis437.omnitel.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752927AbYH1Mnl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 08:43:41 -0400
X-Greylist: delayed 1171 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Aug 2008 08:43:41 EDT
Received: from omini95.omnitel.it (omini95.omnitel.it [10.21.18.147])
	by fmis437.omnitel.it (Switch-3.3.0/Switch-3.3.0) with ESMTP id m7SCO0ef013377
	for <git@vger.kernel.org>; Thu, 28 Aug 2008 14:24:02 +0200 (MEST)
Received: from OIVMEXO02.omnitel.it ([10.32.40.39]) by ominc75.omnitel.it 
	with Microsoft SMTPSVC(5.0.2195.6713); Thu, 28 Aug 2008 14:23:59 +0200
Received: from [10.34.3.159] ([10.34.3.159]) by OIVMEXO02.omnitel.it with 
	Microsoft SMTPSVC(6.0.3790.1830); Thu, 28 Aug 2008 14:23:58 +0200
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-OriginalArrivalTime: 28 Aug 2008 12:23:58.0777 (UTC) 
	FILETIME=[F2639290:01C90908]
X-imss-version: 2.051
X-imss-result: Passed
X-imss-scanInfo: M:B L:N SM:3
X-imss-tmaseResult: TT:1 TS:1.8771 TC:1F TRN:26 TV:5.5.1027(16122.003)
X-imss-scores: Clean:19.95453 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:6 C:4 M:4 S:4 R:4 (2.0000 2.0000)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94043>

From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

Update to gitutorial as discussedin the git mailing list:

http://marc.info/?t=121969390900002&r=1&w=2

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 Documentation/gittutorial.txt |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 48d1454..384972c 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -321,10 +321,37 @@ pulling, like this:
 
 ------------------------------------------------
 alice$ git fetch /home/bob/myrepo master
-alice$ git log -p ..FETCH_HEAD
+alice$ git log -p HEAD..FETCH_HEAD
 ------------------------------------------------
 
 This operation is safe even if Alice has uncommitted local changes.
+The range notation HEAD..FETCH_HEAD" means "show everything that is reachable
+from the FETCH_HEAD but exclude anything that is reachable from HEAD.
+Alice already knows everything that leads to her current state (HEAD),
+and reviewing what Bob has in his state (FETCH_HEAD) that she has not
+seen with this command
+
+If Alice wants to visualize what Bob did since their histories forked
+she can issue the following command:
+
+------------------------------------------------
+$ gitk HEAD..FETCH_HEAD
+------------------------------------------------
+
+This uses the same two-dot range notation we saw earlier with 'git log'.
+
+Alice may want to view what both of them did since they forked.
+She can use three-dot form instead of the two-dot form:
+
+------------------------------------------------
+$ gitk HEAD...FETCH_HEAD
+------------------------------------------------
+
+This means "show everything that is reachable from either one, but
+exclude anything that is reachable from both of them".
+
+Please note that these range notation can be used with both gitk
+and "git log".
 
 After inspecting what Bob did, if there is nothing urgent, Alice may
 decide to continue working without pulling from Bob.  If Bob's history
-- 
1.5.6.1.1071.g76fb
