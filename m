From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/10] revision: trivial style fixes
Date: Sat, 28 Sep 2013 16:51:40 -0500
Message-ID: <1380405106-29430-5-git-send-email-felipe.contreras@gmail.com>
References: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 23:57:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2WN-0002Gp-Jb
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244Ab3I1V5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:57:46 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:64020 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140Ab3I1V5p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:57:45 -0400
Received: by mail-ob0-f172.google.com with SMTP id gq1so4180871obb.31
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fbYegkQSa/ELUM6YjKZu3lqZ+avcQCse3lmwTxV6BBY=;
        b=Mi/HkH1qL5OBn7eF3cyoEarvmGJ3j1C3c8mIHyVUjTvDX8dcDijhxEt5lQnEBF0jUj
         A0Jn93PXkw3jOrzPJiTHlSvGYJh2iX5K1R66ISe46ZMve9L8PB9TqlWVMOvQOkBlTnkc
         0Ruc/CKwbwdsQLC7gOjeEt55jCv1bId9MNbTa+8LiWtz7xVMLfF+cbDC+sRZ5fxFzQIt
         xVVjv9DCaeS6mZ3BoR6fuGL1P1/+ziV9ZvKb4pHp56Ua0LpcgTa45nkKudEGBJSRtuv4
         TiXfyxMN9PXgVTw3YNf5grqFXiJJe7hn/dTnmtlMT2LDffid7RU7VCrxrEfPPMNJEV71
         oaEg==
X-Received: by 10.182.81.41 with SMTP id w9mr12398457obx.18.1380405464972;
        Sat, 28 Sep 2013 14:57:44 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm19428069obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:57:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235513>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 revision.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 0173e01..3ebd558 100644
--- a/revision.c
+++ b/revision.c
@@ -2971,7 +2971,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	if (revs->max_count) {
 		c = get_revision_1(revs);
 		if (c) {
-			while (0 < revs->skip_count) {
+			while (revs->skip_count > 0) {
 				revs->skip_count--;
 				c = get_revision_1(revs);
 				if (!c)
@@ -2986,9 +2986,8 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	if (c)
 		c->object.flags |= SHOWN;
 
-	if (!revs->boundary) {
+	if (!revs->boundary)
 		return c;
-	}
 
 	if (!c) {
 		/*
@@ -3034,9 +3033,8 @@ struct commit *get_revision(struct rev_info *revs)
 
 	if (revs->reverse) {
 		reversed = NULL;
-		while ((c = get_revision_internal(revs))) {
+		while ((c = get_revision_internal(revs)))
 			commit_list_insert(c, &reversed);
-		}
 		revs->commits = reversed;
 		revs->reverse = 0;
 		revs->reverse_output_stage = 1;
-- 
1.8.4-fc
