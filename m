From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: [PATCH v3 4/4] git-svn: Note about tags.
Date: Fri, 23 Nov 2012 08:29:38 +0100
Message-ID: <ad8d146e958494bacde498cedc2d17020db65f1e.1354693001.git.Sebastian.Leske@sleske.name>
References: <cover.1354693001.git.Sebastian.Leske@sleske.name>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 13:51:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgERo-0000s8-Vm
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 13:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab2LEMvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 07:51:17 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:42971 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab2LEMvP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 07:51:15 -0500
Received: from iota.localnet (unknown [46.115.102.110])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id C79BE1F5459D;
	Wed,  5 Dec 2012 13:50:38 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <sebastian.leske@sleske.name>)
	id 1Tg9Yp-0001AF-2e; Wed, 05 Dec 2012 08:38:27 +0100
In-Reply-To: <cover.1354693001.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211122>

Document that 'git svn' will import SVN tags as branches.

Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
---
 Documentation/git-svn.txt |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 021fb0e..445b033 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -968,6 +968,12 @@ the possible corner cases (git doesn't do it, either).  Committing
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
