From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 13/19] Remove active_cache, active_nr, and active_alloc from public view
Date: Thu, 21 Apr 2005 11:37:49 -0700
Message-ID: <200504211837.j3LIbnE5027702@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:35:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgVA-0008Di-Gs
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVDUSie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVDUSie
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:38:34 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:55688 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261678AbVDUShv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:37:51 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIblLN028080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:37:47 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIbniR027704
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:37:49 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIbnE5027702
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:37:49 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree 9198385d73b718a2fd016362a9d93ccce1e7423c
parent cc414a188c0e8fefa7bea4f969cc7adfe4265d6f
author Brad Roberts <braddr@puremagic.com> 1114083132 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114083132 -0700

[PATCH] Remove active_cache, active_nr, and active_alloc from public view

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 cache.h      |    2 --
 read-cache.c |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

Index: cache.h
===================================================================
--- cc414a188c0e8fefa7bea4f969cc7adfe4265d6f:1/cache.h  (mode:100644 sha1:74d816c34245e0dde41643188f38cf99ca75e75f)
+++ ff3667537379d5b0680e8c4f9a14d82dc9835430:1/cache.h  (mode:100644 sha1:b29bb0ca5e7be15c0b423101f5cf381ee68f139e)
@@ -78,8 +78,6 @@
 #define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)
 
 const char *sha1_file_directory;
-struct cache_entry **active_cache;
-unsigned int active_nr, active_alloc;
 
 #define DB_ENVIRONMENT "SHA1_FILE_DIRECTORY"
 #define DEFAULT_DB_ENVIRONMENT ".git/objects"
Index: read-cache.c
===================================================================
--- cc414a188c0e8fefa7bea4f969cc7adfe4265d6f:1/read-cache.c  (mode:100644 sha1:286f7136bc164f3a2317bb492138d9221efb4025)
+++ ff3667537379d5b0680e8c4f9a14d82dc9835430:1/read-cache.c  (mode:100644 sha1:0e972a80fa19eb77fd547fb579354af784be3ac4)
@@ -6,8 +6,8 @@
 #include <stdarg.h>
 #include "cache.h"
 
-struct cache_entry **active_cache = NULL;
-unsigned int active_nr = 0, active_alloc = 0;
+static struct cache_entry **active_cache = NULL;
+static unsigned int active_nr = 0, active_alloc = 0;
 
 int cache_match_stat(struct cache_entry *ce, struct stat *st)
 {

