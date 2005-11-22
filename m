From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH 1/6] Add GIT_REPO_VERSION, and repository_format_version
Date: Tue, 22 Nov 2005 03:28:12 +0300
Message-ID: <11326192923321-git-send-email-matlads@dsmagic.com>
References: <11326192921291-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 01:29:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeM1V-0006BT-8u
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 01:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVKVA2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 19:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVKVA2d
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 19:28:33 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:1796 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S964795AbVKVA2b
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 19:28:31 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id ABD3B527A; Tue, 22 Nov 2005 03:30:08 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.54)
	id 1EeM16-0006Fa-QI; Tue, 22 Nov 2005 03:28:12 +0300
In-Reply-To: <11326192921291-git-send-email-matlads@dsmagic.com>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12508>

This variable will enable git to track the repository version. It's
currently set to 0. (in true C style :)

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

 cache.h       |    4 ++++
 environment.c |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

applies-to: 339319e60db7b3f96f8c711407b135a54da7aa2e
976b8d57a80d79853df9c142ba30d39b414e1b8e
diff --git a/cache.h b/cache.h
index c7c6637..54c283d 100644
--- a/cache.h
+++ b/cache.h
@@ -182,6 +182,10 @@ extern int trust_executable_bit;
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
