From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/6] sha1_name: remove unnecessary braces
Date: Tue, 30 Apr 2013 16:49:10 -0500
Message-ID: <1367358554-4257-3-git-send-email-felipe.contreras@gmail.com>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, "Duy Nguyen\"" <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 23:50:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIRg-0003Lr-OT
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 23:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933832Ab3D3Vuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 17:50:39 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:45013 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933760Ab3D3Vui (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 17:50:38 -0400
Received: by mail-yh0-f41.google.com with SMTP id i57so174588yha.28
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Ucz21TSRIlXqWLs9gC4XtmS3nfaSn26OilP1ON0Zfek=;
        b=WC96sE2G7JYLMdUJOnkVJuy1Rvk7dZGih6b5l+zQOVUEG0EcsE+CnqaQc6Uz+UUiRc
         uaZ2yM5HD8kuYsaKXOhiIZzC2daraSykij/AUBexU1j0XolUwknigrwN78iXRJLK3F0W
         k9t+7GwM2spaS11uNajEzWp0s+yQnK7VMkSGt2iIOqxjNRxLjxEuRpyCz/6KVvYcR72/
         VTlx20WWGMm8tSSafhu+bFvDJMrU+49S5VoFot/+O+XnP+0Mqik9yVFOVecu4pWx3b4N
         s9NK9slcW2eHQfZh4cJM74FgxAhuUnR4fSB0Tre/UW5V8TODvuwK+vHAhLp8NGwQJhG+
         p/7w==
X-Received: by 10.236.119.148 with SMTP id n20mr129210yhh.126.1367358638092;
        Tue, 30 Apr 2013 14:50:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i67sm290453yhq.25.2013.04.30.14.50.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 14:50:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.395.gfe9a10d
In-Reply-To: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223015>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 01e49a9..6530ddd 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -465,12 +465,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		int ret;
 		/* try the @{-N} syntax for n-th checkout */
 		ret = interpret_branch_name(str, &buf);
-		if (ret > 0) {
+		if (ret > 0)
 			/* substitute this branch name and restart */
 			return get_sha1_1(buf.buf, buf.len, sha1, 0);
-		} else if (ret == 0) {
+		else if (ret == 0)
 			return -1;
-		}
 		/* allow "@{...}" to mean the current branch reflog */
 		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
 	} else if (reflog_len)
-- 
1.8.3.rc0.395.gfe9a10d
