From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 18/56] merge-recursive: Mark some diff_filespec struct arguments const
Date: Thu, 11 Aug 2011 23:19:51 -0600
Message-ID: <1313126429-17368-19-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBQ-0004nj-63
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942Ab1HLFVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:13 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab1HLFVL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:11 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AN9JqOKJ2elqUPSNWlQBCqNS8ctkSKH8Yo48i+/B4Ys=;
        b=V9tJF2rXZ2nmuz2muyBGMT2uU5I64SVIIZtF/QfLhxzhWgV5p5Vk2G8i1uuooEcUiZ
         Z7QGpeDjSJMmA05ztNTHlaS5y3fq0bR3hpoMq60IGg6In9JqvbqkOyRKkPcfKt5YJFgS
         N8JpRhm/3cL4kpchgm3Yrp2PEyBi8kjzKBSHs=
Received: by 10.42.157.5 with SMTP id b5mr493572icx.442.1313126470802;
        Thu, 11 Aug 2011 22:21:10 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.09
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179178>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3d464d9..317bf23 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -461,9 +461,10 @@ static struct string_list *get_renames(struct merge_options *o,
 	return renames;
 }
 
-static int update_stages_options(const char *path, struct diff_filespec *o,
-			 struct diff_filespec *a, struct diff_filespec *b,
-			 int clear, int options)
+static int update_stages_options(const char *path, const struct diff_filespec *o,
+				 const struct diff_filespec *a,
+				 const struct diff_filespec *b,
+				 int clear, int options)
 {
 	if (clear)
 		if (remove_file_from_cache(path))
@@ -712,9 +713,9 @@ struct merge_file_info {
 
 static int merge_3way(struct merge_options *o,
 		      mmbuffer_t *result_buf,
-		      struct diff_filespec *one,
-		      struct diff_filespec *a,
-		      struct diff_filespec *b,
+		      const struct diff_filespec *one,
+		      const struct diff_filespec *a,
+		      const struct diff_filespec *b,
 		      const char *branch1,
 		      const char *branch2)
 {
@@ -772,9 +773,9 @@ static int merge_3way(struct merge_options *o,
 }
 
 static struct merge_file_info merge_file(struct merge_options *o,
-				         struct diff_filespec *one,
-					 struct diff_filespec *a,
-					 struct diff_filespec *b,
+					 const struct diff_filespec *one,
+					 const struct diff_filespec *a,
+					 const struct diff_filespec *b,
 					 const char *branch1,
 					 const char *branch2)
 {
-- 
1.7.6.100.gac5c1
