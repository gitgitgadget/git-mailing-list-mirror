From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 24/47] remote-hg: trivial cleanups
Date: Mon, 13 May 2013 23:36:47 -0500
Message-ID: <1368506230-19614-25-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72D-0004WY-Cz
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612Ab3ENEj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:59 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59607 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481Ab3ENEj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:58 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so102128oag.19
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=kgfEXxucNo7EORKl8CslmOWyi/SpGQjwxnIz+jKkU3s=;
        b=Xb8iULqyXjrsQYeNJNmhgEqvpg4C397sdksuc7aozNFIwEc7tUFaoRcABtcHsNMjU/
         NCQiHJq39H3357Bu8Th1uA7cmOOGyR1Gqula/JTDsxMvjeO1hLBbp7xrRhtT6TdTSfUW
         6zNv2hhqDvCpYbgTMqou5BVHWHQWvSRHDRU8e6CB7m9qikdajFnoMCm51jxrYxtcFMyv
         Ie9l7yaTmmB74bIUd3U8dOwyPJqfroKQQTAbMqNAwexXFAZGGNrgPJLbbOh4/ilBE1oR
         gvwIRhRM3vON0FymHqsiVkLRAO5pkuek8MzGn2Hsaw/KVIPzwS/IanUEw+gFZQrKM6TF
         zzVw==
X-Received: by 10.60.144.99 with SMTP id sl3mr15580005oeb.0.1368506397718;
        Mon, 13 May 2013 21:39:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt1sm816663oeb.5.2013.05.13.21.39.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224254>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index bc6e8fa..49af8d5 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -74,11 +74,11 @@ def hgmode(mode):
     m = { '100755': 'x', '120000': 'l' }
     return m.get(mode, '')
 
-def hghex(node):
-    return hg.node.hex(node)
+def hghex(n):
+    return node.hex(n)
 
-def hgbin(node):
-    return hg.node.bin(node)
+def hgbin(n):
+    return node.bin(n)
 
 def hgref(ref):
     return ref.replace('___', ' ')
@@ -737,12 +737,12 @@ def parse_commit(parser):
     if from_mark:
         p1 = mark_to_rev(from_mark)
     else:
-        p1 = '\0' * 20
+        p1 = '0' * 40
 
     if merge_mark:
         p2 = mark_to_rev(merge_mark)
     else:
-        p2 = '\0' * 20
+        p2 = '0' * 40
 
     #
     # If files changed from any of the parents, hg wants to know, but in git if
@@ -829,7 +829,7 @@ def write_tag(repo, tag, node, msg, author):
         return context.memfilectx(f, content, False, False, None)
 
     p1 = tip.hex()
-    p2 = '\0' * 20
+    p2 = '0' * 40
     if not author:
         author = (None, 0, 0)
     user, date, tz = author
-- 
1.8.3.rc1.579.g184e698
