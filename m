From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH 2/3] Add GIT_REPO_VERSION, and repository_format_version
Date: Wed, 23 Nov 2005 19:36:38 -0800
Message-ID: <7vhda2zph5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 24 04:37:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef7ud-0004d2-PS
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 04:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbVKXDgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 22:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbVKXDgl
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 22:36:41 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:63465 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932623AbVKXDgk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 22:36:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124033516.FIKJ20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 22:35:16 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12672>

From: Martin Atukunda <matlads@dsmagic.com>
Date: 1132619292 +0300

This variable will enable git to track the repository version. It's
currently set to 0. (in true C style :)

Signed-off-by: Martin Atukunda <matlads@dsmagic.com>
Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * This is verbatim as I received from Martin.

 cache.h       |    4 ++++
 environment.c |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

applies-to: 787c201a1691219d30c1a3fd849dc5ee9b35e2ce
abb173e753857d7360ae7ff1869be8d96e353ba7
diff --git a/cache.h b/cache.h
index 3104c59..7cde341 100644
--- a/cache.h
+++ b/cache.h
@@ -183,6 +183,10 @@ extern int trust_executable_bit;
 extern int only_use_symrefs;
 extern int diff_rename_limit_default;
 
+#define GIT_REPO_VERSION 0
+extern int repository_format_version;
+extern int check_repo_format(void);
+
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
 #define OWNER_CHANGED	0x0004
diff --git a/environment.c b/environment.c
index b5026f1..3f19473 100644
--- a/environment.c
+++ b/environment.c
@@ -13,6 +13,7 @@ char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int trust_executable_bit = 1;
 int only_use_symrefs = 0;
+int repository_format_version = 0;
 
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
 	*git_graft_file;
---
0.99.9.GIT
