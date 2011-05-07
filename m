From: Boris Faure <billiob@gmail.com>
Subject: [PATCH 2/2] commit: do not add a newline after a template
Date: Sat,  7 May 2011 17:53:44 +0200
Message-ID: <1304783624-9919-2-git-send-email-billiob@gmail.com>
References: <1304783624-9919-1-git-send-email-billiob@gmail.com>
Cc: Boris Faure <billiob@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 17:54:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIjpq-0003Mj-8K
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 17:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598Ab1EGPyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 11:54:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53461 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459Ab1EGPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 11:54:07 -0400
Received: by wya21 with SMTP id 21so3019874wya.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=x5i9uly78vlOtmSMZY0rvtRb+izDPWFnwcDsWYrzB0g=;
        b=XD7dPjg2MBB9mn68qe6c29DlDwqo451bd8C6mo8AGMjIBqOO2rCxBygXM89KGfbwLt
         nAbFf+v38GDE9t2Gkro1pblP0mgo6Pk0gjywGcvP3PoGE8R2+sH9aZjY/CvofaKON9JS
         C8jfdILVw6VVmQ3qd8NQInkIWG7/yqqFIidBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=R8emda8E7mJjy9m/nF+Z1I5Q3HXX2vweNqUapyxvgJJUmYLk4HTxkffpLaWZJKw7SV
         wcWS3JOitFHXZNUS+Pup8wsxHXXfvfA+NvwtilY8S4PmF0Ws2nweh8gbuo5/nxXd8TyD
         DicMlanYDaUIg/YW6HiQHy3EOzthqSaKJyhKo=
Received: by 10.216.82.77 with SMTP id n55mr5108617wee.52.1304783646093;
        Sat, 07 May 2011 08:54:06 -0700 (PDT)
Received: from localhost.localdomain (ADijon-259-1-88-55.w90-33.abo.wanadoo.fr [90.33.231.55])
        by mx.google.com with ESMTPS id t5sm2149539wes.9.2011.05.07.08.54.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 May 2011 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1304783624-9919-1-git-send-email-billiob@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173055>

Signed-off-by: Boris Faure <billiob@gmail.com>
---
 builtin/commit.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index f0e880b..2209924 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -754,7 +754,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 					 ? "MERGE_HEAD"
 					 : "CHERRY_PICK_HEAD"));
 
-		fprintf(s->fp, "\n");
+		if (!template_file)
+			fprintf(s->fp, "\n");
 		status_printf(s, GIT_COLOR_NORMAL,
 			_("Please enter the commit message for your changes."));
 		if (cleanup_mode == CLEANUP_ALL)
-- 
1.7.5.1
