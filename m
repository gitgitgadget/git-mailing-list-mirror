From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] dir.c: make dir_add_name() and dir_add_ignored() static
Date: Thu, 02 Oct 2008 19:14:23 +0900
Message-ID: <20081002191423.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 12:16:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlLDz-00070F-UE
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 12:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbYJBKOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 06:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbYJBKOs
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 06:14:48 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41919 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662AbYJBKOs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 06:14:48 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 55580C7B30;
	Thu,  2 Oct 2008 05:14:47 -0500 (CDT)
Received: from 6138.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id TXW4K4S5UMQ5; Thu, 02 Oct 2008 05:14:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=26szGyu6otlRl8VPW11oKu/rO+Ba7ms9CKuBq53pbIhBr3Rblgxe6+4qm8uu/yJPtiJYqin9pjvTIdGXan+9/LRVZmgxg2/7n7JZEFTSwV1C5g8OPGnOjsFtBFk/74ZuwVAQtPUhvfoIXyxd3sGaeudmzmEJhTmxVUeJ7muM7+0=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97305>

These functions are not used by any other file.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 dir.c |    4 ++--
 dir.h |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index acf1001..f79ec61 100644
--- a/dir.c
+++ b/dir.c
@@ -382,7 +382,7 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 	return ent;
 }
 
-struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
+static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
 	if (cache_name_exists(pathname, len, ignore_case))
 		return NULL;
@@ -391,7 +391,7 @@ struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int
 	return dir->entries[dir->nr++] = dir_entry_new(pathname, len);
 }
 
-struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
+static struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
 {
 	if (cache_name_pos(pathname, len) >= 0)
 		return NULL;
diff --git a/dir.h b/dir.h
index 2df15de..c98ad98 100644
--- a/dir.h
+++ b/dir.h
@@ -73,7 +73,6 @@ extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *which);
 extern int file_exists(const char *);
-extern struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len);
 
 extern char *get_relative_cwd(char *buffer, int size, const char *dir);
 extern int is_inside_dir(const char *dir);
-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
