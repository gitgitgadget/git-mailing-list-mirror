From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 05/10] remote-hg: fix new branch creation
Date: Mon, 13 May 2013 18:11:55 -0500
Message-ID: <1368486720-2716-6-git-send-email-felipe.contreras@gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 01:14:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1xF-0007WF-91
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab3EMXOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:14:30 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:46642 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533Ab3EMXO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:14:27 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so5367213oag.9
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=T7P01XGYmFOw6WaRR/hHd6FmdJBDl2phqJG0UWtbgZk=;
        b=Wrum9qcFxvIaWaCvjkOftgJhc8lW3+OFj1QegSCIB9mkZYZXemW4p+NxRlXBOuHbWM
         3kH5NbXz5BpLUmoIIzJfOpP02ZcABDg3Yf9JNmsytsQjVC/KblU8qFUojIyHUQXHRHii
         PmBRIqUKbAi/XlGIBmNYTXLsGU2gzs4gpfwTKFt4BT0NFQu6tYKIJVmtU9H1VKKkVM1i
         +6apqeIBbSkZTgdz/rxZrGoKCAZKtT9nub3fvGLINr11UfypjiU5cGPClBGr1ovjiyo1
         p5uuThZ/NevmFKdmQsgyvwybJMOxe1fO8Trw0hWPT/3Q9cfGVd5gLvmKV4VgZkEnjHBY
         MwZA==
X-Received: by 10.60.116.99 with SMTP id jv3mr14433538oeb.7.1368486866741;
        Mon, 13 May 2013 16:14:26 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ku7sm18774453obc.6.2013.05.13.16.14.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 16:14:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224223>

When force_push is disabled, we need to turn the argument to True.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 4a5c72f..3cf9b4c 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -856,7 +856,7 @@ def do_export(parser):
             continue
 
     if peer:
-        parser.repo.push(peer, force=force_push)
+        parser.repo.push(peer, force=force_push, newbranch=True)
 
     # handle bookmarks
     for bmark, node in p_bmarks:
-- 
1.8.3.rc1.579.g184e698
