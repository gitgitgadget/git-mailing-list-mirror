From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/2] tree-walk: drop unused parameter from match_dir_prefix
Date: Thu,  8 Sep 2011 21:02:45 -0500
Message-ID: <1315533766-25901-1-git-send-email-dpmcgee@gmail.com>
References: <7v62le1vlx.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 04:02:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1qQh-0005VA-Im
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 04:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511Ab1IICCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 22:02:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48606 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932437Ab1IICCu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 22:02:50 -0400
Received: by gyg10 with SMTP id 10so895826gyg.19
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 19:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bB65YVCrve46NXvBbMnx5+UhUmgN9ACWZVXXlNoLaA8=;
        b=GioR6+m7RuxOOnYq20+O0XftFyp/XYbsUBsqsEq24tk2huA0yByQ8S3Fl0w0XXrjc3
         /fncyxZdw4i9IZZhXVFCk2m6bMOJri9eKZBxrk88ZXb6a+tzfcjjJze3Lf+T/jMdWD8g
         4GHbwMgJh8ONZukm9rJ31PLbtxhCP0IIA4HMk=
Received: by 10.236.119.164 with SMTP id n24mr8749656yhh.115.1315533769518;
        Thu, 08 Sep 2011 19:02:49 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id o21sm5500791yhi.8.2011.09.08.19.02.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Sep 2011 19:02:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <7v62le1vlx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181020>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 tree-walk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 33f749e..dbcd94a 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -522,7 +522,7 @@ static int match_entry(const struct name_entry *entry, int pathlen,
 	return 0;
 }
 
-static int match_dir_prefix(const char *base, int baselen,
+static int match_dir_prefix(const char *base,
 			    const char *match, int matchlen)
 {
 	if (strncmp(base, match, matchlen))
@@ -579,7 +579,7 @@ int tree_entry_interesting(const struct name_entry *entry,
 
 		if (baselen >= matchlen) {
 			/* If it doesn't match, move along... */
-			if (!match_dir_prefix(base_str, baselen, match, matchlen))
+			if (!match_dir_prefix(base_str, match, matchlen))
 				goto match_wildcards;
 
 			if (!ps->recursive || ps->max_depth == -1)
-- 
1.7.6.1
