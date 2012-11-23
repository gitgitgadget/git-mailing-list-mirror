From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: [PATCH 4/4] git-svn: Note about tags.
Date: Fri, 23 Nov 2012 08:29:38 +0100
Message-ID: <c72bc0d2a4f2681d27247c6f7510c4ada8e83aec.1353691892.git.Sebastian.Leske@sleske.name>
References: <b115a546fa783b4121d118bb8fdb9270443f90fa.1353691892.git.Sebastian.Leske@sleske.name>
Cc: "Eric Wong" <normalperson@yhbt.net>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Nov 25 11:35:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcZZ1-00075K-7l
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 11:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab2KYKff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 05:35:35 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:37788 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab2KYKfe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 05:35:34 -0500
Received: from iota.localnet (p4FD44AFD.dip.t-dialin.net [79.212.74.253])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id B374C1F54621;
	Sun, 25 Nov 2012 11:35:02 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <sebastian.leske@sleske.name>)
	id 1TcZYb-0005v2-NS; Sun, 25 Nov 2012 11:35:25 +0100
In-Reply-To: <b115a546fa783b4121d118bb8fdb9270443f90fa.1353691892.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210351>

Document that 'git svn' will import SVN tags as branches.

Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
---
 Documentation/git-svn.txt |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 92780ef..6212b24 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -938,6 +938,12 @@ the possible corner cases (git doesn't do it, either).  Committing
 renamed and copied files is fully supported if they're similar enough
 for git to detect them.
 
+In SVN, it is possible (though discouraged) to commit changes to a tag
+(because a tag is just a directory copy, thus technically the same as a
+branch). When cloning an SVN repository, 'git svn' cannot know if such a
+commit to a tag will happen in the future. Thus it acts conservatively
+and imports all SVN tags as branches, prefixing the tag name with 'tags/'.
+
 CONFIGURATION
 -------------
 
-- 
1.7.10.4
