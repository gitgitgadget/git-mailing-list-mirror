From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] remote-hg: trivial cleanups
Date: Sun, 11 Nov 2012 15:09:58 +0100
Message-ID: <1352642999-7205-2-git-send-email-felipe.contreras@gmail.com>
References: <1352642999-7205-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:10:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYFN-0003PY-PM
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642Ab2KKOKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:10:32 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45205 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab2KKOKb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:10:31 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2063390bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=de+nLIGPIWoqlsBqdpdJ85UUiKO0NQ1tnsFXKDyz40M=;
        b=0HGUBNHeBe1evlZLKBF8uF8CGA/Gn0WDOl2icJalRDf1v0RxDrzaeFXao86omFVREz
         sNIZ7lemPJXzwQAUzZseBdIFFYbRwWVrgItQ4Brq4HTFngrT/1A+Ip3WdFinTTGktTzx
         L2alJyt2+rA01akQU18ja1DJkujtVZ/Jwuy4HIeoRyC09kBmfgNdF+P01Wr3X4WhX29p
         wxu+4joUK6wjwteI3dJYLEJQeLOdE3Uwq8LW6rsH/UYjoC7igl8rs2r1xCuWA+iiIrud
         QkGg0umJYGTWmYcXGMsi2FRDUs/fezitNaP9KGGq1uqNoMhsajaZcK2UArckqQIAiOB+
         PQag==
Received: by 10.204.8.17 with SMTP id f17mr323977bkf.110.1352643031157;
        Sun, 11 Nov 2012 06:10:31 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id hu14sm1494942bkc.12.2012.11.11.06.10.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:10:30 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642999-7205-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209371>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 7929eec..0edb8ac 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -523,7 +523,6 @@ def parse_blob(parser):
     data = parser.get_data()
     blob_marks[mark] = data
     parser.next()
-    return
 
 def get_merge_files(repo, p1, p2, files):
     for e in repo[p1].files():
@@ -639,10 +638,11 @@ def parse_commit(parser):
     rev = repo[node].rev()
 
     parsed_refs[ref] = node
-
     marks.new_mark(rev, commit_mark)
 
 def parse_reset(parser):
+    global parsed_refs
+
     ref = parser[1]
     parser.next()
     # ugh
-- 
1.8.0
