From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 4/4] Document git-fetch options
Date: Wed, 14 Sep 2005 16:48:05 +0400
Message-ID: <20050914124805.GG24405@master.mivlgu.local>
References: <20050914124206.GC24405@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 14:50:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFWgM-000349-OA
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 14:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbVINMsI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 08:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVINMsI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 08:48:08 -0400
Received: from mivlgu.ru ([81.18.140.87]:3009 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S965154AbVINMsG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 08:48:06 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id 94004180119; Wed, 14 Sep 2005 16:48:05 +0400 (MSD)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050914124206.GC24405@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8522>

Add documentation for git-fetch options (including the newly added
--recover option).

---

 Documentation/git-fetch.txt        |    6 ++++++
 Documentation/pull-fetch-param.txt |   19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

7685a3d50566e908fb8beb2ddb3088877aa9ae0f
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -26,6 +26,12 @@ OPTIONS
 -------
 include::pull-fetch-param.txt[]
 
+-u, \--update-head-ok::
+	By default 'git-fetch' refuses to update the head which
+	corresponds to the current branch.  This flag disables the
+	check.  Note that fetching into the current branch will not
+	update the index and working directory, so use it with care.
+
 
 Author
 ------
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -80,3 +80,22 @@
           <ref>: when pulling/fetching, and <ref>:<ref> when
           pushing.  That is, do not store it locally if
           fetching, and update the same name if pushing.
+
+-a, \--append::
+	Append ref names and object names of fetched refs to the
+	existing contents of $GIT_DIR/FETCH_HEAD.  Without this
+	option old data in $GIT_DIR/FETCH_HEAD will be overwritten.
+
+-f, \--force::
+	Usually, the command refuses to update a local ref that is
+	not an ancestor of the remote ref used to overwrite it.
+	This flag disables the check.  What this means is that the
+	local repository can lose commits; use it with care.
+
+-r, \--recover::
+	Recover after an interrupted fetch.  When fetching over
+	HTTP(s), this option is passed to 'git-http-fetch', which
+	will then walk through the whole commit tree and fetch all
+	missing objects.  For other protocols this option is
+	ignored, because they don't have problems with recovery
+	after an interrupted fetch.
