From: =?UTF-8?B?VGFkZXVzeiBBbmRyemVqIEthZMWCdWJvd3NraQ==?= 
	<yess@hell.org.pl>
Subject: [PATCH] Documentation: filter-branch env-filter example
Date: Thu, 14 Feb 2013 20:34:11 +0100
Message-ID: <511D3C33.6070902@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 20:34:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U64Zp-00030i-E0
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 20:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934885Ab3BNTeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 14:34:14 -0500
Received: from hell.org.pl ([213.135.50.122]:51166 "EHLO hell.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758644Ab3BNTeN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 14:34:13 -0500
Received: from [10.2.0.23] (unknown [193.107.214.17])
	by hell.org.pl (Postfix) with ESMTP id BC476F0091
	for <git@vger.kernel.org>; Thu, 14 Feb 2013 20:34:11 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216331>

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
+	if [ $GIT_AUTHOR_EMAIL = john@old.example.com ]
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
-- 
1.7.11.7
