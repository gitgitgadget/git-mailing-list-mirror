From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 1/5] add 'prior' link in commit structure
Date: Tue, 25 Apr 2006 16:31:06 +1200
Message-ID: <20060425043106.18382.24344.stgit@localhost.localdomain>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
X-From: git-owner@vger.kernel.org Tue Apr 25 06:32:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYFDX-0000IJ-7u
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 06:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWDYEbw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 00:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWDYEbw
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 00:31:52 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:48874 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751366AbWDYEbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 00:31:52 -0400
Received: from samv by mail1.catalyst.net.nz with local (Exim 4.50)
	id 1FYFDK-0004Dh-EY
	for git@vger.kernel.org; Tue, 25 Apr 2006 16:31:50 +1200
To: git@vger.kernel.org
In-Reply-To: <20060425035421.18382.51677.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19121>

From: Sam Vilain <sam.vilain@catalyst.net.nz>

Add a space in the commit for a prior commit that forms this commit's
historical, not substantial, precedent.

For now this is just recorded as a char* pointer, as it is not an
error condition for the commit not to be present locally.
---

 commit.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/commit.h b/commit.h
index de142af..b00a6b9 100644
--- a/commit.h
+++ b/commit.h
@@ -13,6 +13,7 @@ struct commit {
 	struct object object;
 	unsigned long date;
 	struct commit_list *parents;
+	char *prior;
 	struct tree *tree;
 	char *buffer;
 };
