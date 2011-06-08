From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 18/48] merge-recursive: Mark some diff_filespec struct arguments const
Date: Wed,  8 Jun 2011 01:30:48 -0600
Message-ID: <1307518278-23814-19-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDJ-0005pC-9p
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab1FHH3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:35 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49887 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab1FHH3c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:32 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so118724pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=oJ3xLUgeUxSw3zRuCR25hvwPJw8pVzzwi1YzCR8je5I=;
        b=WyVIUUnDe648TWPkNoRjFp/uS8Sy1/+fCTyoYavtUMPoi4tjGu1DnQH6MpB57Q9ZbU
         KZPk43dgp3q9gJV9giaJfLIRzlwNfT9e+Hp/Ac+wfkaOaj30M3yx+CSx2wjiidrslIxd
         7e8tBBRFV3vFxylAlGByu4lkCFJVYkQgLQ82I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RAq9wPH3hXg6SatXj81nky42XXYIJkU2k1QDczbHWQCxOeKNHt3EvsY0/990/4jSHt
         rnrUd2H4gMJmkTqylLu/HDLtMjWU0X9p6btej+iJka69wGr/Hf64JuGYra8QXxq1KkPD
         X1lxq/8n1oHbQLHJN6RR3fj+qpyDkLNfs6qh4=
Received: by 10.68.33.225 with SMTP id u1mr604694pbi.199.1307518171833;
        Wed, 08 Jun 2011 00:29:31 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.29
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175307>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
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
1.7.6.rc0.62.g2d69f
