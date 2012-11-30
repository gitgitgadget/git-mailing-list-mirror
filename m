From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: [PATCH v3 3/4] git-svn: Expand documentation for --follow-parent
Date: Fri, 30 Nov 2012 08:16:30 +0100
Message-ID: <3ebf48f71ec54fcec83f730c1cf6ec86c02d0677.1354693001.git.Sebastian.Leske@sleske.name>
References: <cover.1354693001.git.Sebastian.Leske@sleske.name>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 13:51:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgERi-0000k6-Ni
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 13:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab2LEMvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 07:51:10 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:42954 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab2LEMvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 07:51:09 -0500
Received: from iota.localnet (unknown [46.115.102.110])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id 727CD1602003;
	Wed,  5 Dec 2012 13:50:31 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <sebastian.leske@sleske.name>)
	id 1Tg9Yp-0001AD-1Y; Wed, 05 Dec 2012 08:38:27 +0100
In-Reply-To: <cover.1354693001.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211121>

Describe what the option --follow-parent does, and what happens if it is
set or unset.

Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
---
 Documentation/git-svn.txt |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index d8e5082..021fb0e 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -628,10 +628,19 @@ ADVANCED OPTIONS
 	Default: "svn"
 
 --follow-parent::
+	This option is only relevant if we are tracking branches (using
+	one of the repository layout options --trunk, --tags,
+	--branches, --stdlayout). For each tracked branch, try to find
+	out where its revision was copied from, and set
+	a suitable parent in the first git commit for the branch.
 	This is especially helpful when we're tracking a directory
-	that has been moved around within the repository, or if we
-	started tracking a branch and never tracked the trunk it was
-	descended from. This feature is enabled by default, use
+	that has been moved around within the repository.  If this
+	feature is disabled, the branches created by 'git svn' will all
+	be linear and not share any history, meaning that there will be
+	no information on where branches were branched off or merged.
+	However, following long/convoluted histories can take a long
+	time, so disabling this feature may speed up the cloning
+	process. This feature is enabled by default, use
 	--no-follow-parent to disable it.
 +
 [verse]
-- 
1.7.10.4
