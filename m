From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] cache-tree.c: make cache_tree_find() static
Date: Wed, 16 Jul 2008 19:42:10 +0900
Message-ID: <20080716194210.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 12:43:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ4U1-0002wu-Iq
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 12:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbYGPKme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 06:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755185AbYGPKme
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 06:42:34 -0400
Received: from karen.lavabit.com ([72.249.41.33]:53529 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415AbYGPKmd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 06:42:33 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 4C1C8C8433;
	Wed, 16 Jul 2008 05:42:24 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id QNBKHX9OY1QB; Wed, 16 Jul 2008 05:42:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Pu1ASxBdp/Iiz2gD9/QPz4pUWR0t562uV8hq+QX/isvZTcdm4Bg9VqMgBosj17Wd5EbblS7SterX3Yni7SUFmM4c1uHA21tvWcee2v6xmNTPLDZEIRc18RgJOFSPn/4+azAhfwZn/SoxeE9v0dj99pcsiL1FrOZFkYPwxL/6wQw=;
  h=From:Subject:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88661>

This function is not used by any other file.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 cache-tree.c |    2 +-
 cache-tree.h |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 73cb340..5f8ee87 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -507,7 +507,7 @@ struct cache_tree *cache_tree_read(const char *buffer, unsigned long size)
 	return read_one(&buffer, &size);
 }
 
-struct cache_tree *cache_tree_find(struct cache_tree *it, const char *path)
+static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *path)
 {
 	while (*path) {
 		const char *slash;
diff --git a/cache-tree.h b/cache-tree.h
index 44aad42..cf8b790 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -28,8 +28,6 @@ struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int, int);
 
-struct cache_tree *cache_tree_find(struct cache_tree *, const char *);
-
 #define WRITE_TREE_UNREADABLE_INDEX (-1)
 #define WRITE_TREE_UNMERGED_INDEX (-2)
 #define WRITE_TREE_PREFIX_ERROR (-3)
-- 
1.5.6.3

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
