From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] commit.c: make read_graft_file() static
Date: Thu, 02 Oct 2008 19:14:30 +0900
Message-ID: <20081002191430.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 12:16:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlLEc-0007Bl-1K
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 12:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYJBKO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 06:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbYJBKO5
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 06:14:57 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41928 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038AbYJBKO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 06:14:56 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 6D488C7B30;
	Thu,  2 Oct 2008 05:14:55 -0500 (CDT)
Received: from 6138.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id ZL30HQFGT7QS; Thu, 02 Oct 2008 05:14:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=0mkjF8KQD/XsYUArVBkjuAJ24r92mlK1nvCrhs03tmOJZLEoHj2PbmDVvyjg9+v4zAWLQTd98hLtiTziNY+fCODByV4/Bh0dMLm4db3bhbr/Xed22nIS/NfJcxqaR9wpKefMHaJLGhUL+h06N84RWEREv/aCOZEnSTfZ2LEGgVY=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97307>

This function is not called by any other file.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 commit.c |    2 +-
 commit.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index dc0c5bf..c99db16 100644
--- a/commit.c
+++ b/commit.c
@@ -160,7 +160,7 @@ struct commit_graft *read_graft_line(char *buf, int len)
 	return graft;
 }
 
-int read_graft_file(const char *graft_file)
+static int read_graft_file(const char *graft_file)
 {
 	FILE *fp = fopen(graft_file, "r");
 	char buf[1024];
diff --git a/commit.h b/commit.h
index de15f4d..4c05864 100644
--- a/commit.h
+++ b/commit.h
@@ -118,7 +118,6 @@ struct commit_graft {
 
 struct commit_graft *read_graft_line(char *buf, int len);
 int register_commit_graft(struct commit_graft *, int);
-int read_graft_file(const char *graft_file);
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
