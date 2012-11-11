From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] remote-hg: fix for files with spaces
Date: Sun, 11 Nov 2012 15:09:59 +0100
Message-ID: <1352642999-7205-3-git-send-email-felipe.contreras@gmail.com>
References: <1352642999-7205-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:11:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYFV-0003TW-G3
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738Ab2KKOKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:10:42 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45205 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab2KKOKl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:10:41 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2063390bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZUYCAlixa/0AIU7ruHfWA4PL06NTGO/3iZk2JKm7hjQ=;
        b=vGm7hSYlsU7Z2a49YXtPbcOOgnyiZpWf3vDyMpinCJzBk9oi8Yv2ffiot/O3xdgojU
         V/NbyG4Ws5GOX5XApXV2RonC7NwJjxGMoRSjtpUB80PH+Q/F9Q9rj9wxgbbzHHDu9EXz
         sUbkqCoL6aQzhXZZ7WAPYfyOg0b+lgwlR5fjMu+bWjlLtJvTLRQpMqLWfDasRWPIYz+F
         NbBPlrFwQAtmiZXyTPbjeRTeEektLK/8hti5Iwfe7OghApw9YMNhbTxkml95vjOHwc4F
         3C8QE7RXu/Y0MyFbWhL67AN9KJtxXrwYRizbwyYQlN4n8n1kws/rXGybbphN0+LymHM9
         pmmw==
Received: by 10.204.128.155 with SMTP id k27mr5873897bks.26.1352643040793;
        Sun, 11 Nov 2012 06:10:40 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id hu14sm1495038bkc.12.2012.11.11.06.10.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:10:40 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642999-7205-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209373>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0edb8ac..1d46838 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -562,7 +562,7 @@ def parse_commit(parser):
 
     for line in parser:
         if parser.check('M'):
-            t, m, mark_ref, path = line.split(' ')
+            t, m, mark_ref, path = line.split(' ', 3)
             mark = int(mark_ref[1:])
             f = { 'mode' : hgmode(m), 'data' : blob_marks[mark] }
         elif parser.check('D'):
-- 
1.8.0
