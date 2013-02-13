From: Tade <yess@hell.org.pl>
Subject: [PATCH] Documentation: filter-branch env-filter example
Date: Wed, 13 Feb 2013 20:47:43 +0100
Message-ID: <511BEDDF.7010800@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 21:13:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5ii7-0002CJ-GT
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 21:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933938Ab3BMUNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 15:13:14 -0500
Received: from hell.org.pl ([213.135.50.122]:50137 "EHLO hell.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760382Ab3BMUNM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 15:13:12 -0500
X-Greylist: delayed 1528 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2013 15:13:12 EST
Received: from [10.2.0.23] (unknown [193.107.214.17])
	by hell.org.pl (Postfix) with ESMTP id D6FFEF0083
	for <git@vger.kernel.org>; Wed, 13 Feb 2013 20:47:43 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216283>

filter-branch --env-filter example that shows how to change the email address
in all commits by a certain developer.
---
  Documentation/git-filter-branch.txt | 13 +++++++++++++
  1 file changed, 13 insertions(+)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index dfd12c9..2664cec 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -329,6 +329,19 @@ git filter-branch --msg-filter '
  ' HEAD~10..HEAD
  --------------------------------------------------------
  
+You can modify committer/author personal information using `--env-filter`.
+For example, to update some developer's email address use this command:
+
+--------------------------------------------------------
+git filter-branch --env-filter '
+	if [ $GIT_AUTHOR_EMAIL =john@old.example.com  ]
+	then
+		GIT_AUTHOR_EMAIL=john@new.example.com
+	fi
+	export GIT_AUTHOR_EMAIL
+' -- --all
+--------------------------------------------------------
+
  To restrict rewriting to only part of the history, specify a revision
  range in addition to the new branch name.  The new branch name will
  point to the top-most revision that a 'git rev-list' of this range
-- 1.7.11.7
