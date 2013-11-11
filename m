From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 01/10] transport-helper: fix extra lines
Date: Mon, 11 Nov 2013 16:54:59 -0600
Message-ID: <1384210507-26561-3-git-send-email-felipe.contreras@gmail.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 00:02:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg0Uk-00064Q-4Y
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab3KKXCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:02:08 -0500
Received: from mail-oa0-f51.google.com ([209.85.219.51]:50054 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab3KKXCE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:02:04 -0500
Received: by mail-oa0-f51.google.com with SMTP id i4so2625700oah.10
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pb461rKuy/YoiOVvF0VIzbqdDdtrl4GRew9MJWMfJLc=;
        b=NhQv052X8PkQ/M/dk74w5v2TkCtOnYTZPx80yeBekLqf3PQsP9fIwoCjCal3WkHJ9b
         BmyghOmwlWnkohorsdIwdmpeVdBcydQ505iPte7RmKc7H3w8bNMZqj9fs3ShJBGw8yoU
         6zNutfY36xASn0s4oB7W8cx1TiIqypRJebFipGEWFQzjru/A59pbiHEmwnYwweOq463M
         +S/ai3SWXmOoB4/uNey0NDcpBFF3F52KQxXN4+pr7ZC5ZmJk8P6lAw3D+EOTe5Vi6gMv
         T4N2LrfuM2UI8YVd+cw8JuFdv6kAhbWd8LvkbRQdveBqk/HzzZ6my7m0whGU5FzE5iUT
         BOXQ==
X-Received: by 10.182.72.234 with SMTP id g10mr27635317obv.21.1384210923477;
        Mon, 11 Nov 2013 15:02:03 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm29294460obu.4.2013.11.11.15.02.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 15:02:02 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237665>

Commit 9c51558 (transport-helper: trivial code shuffle) moved these
lines above, but 99d9ec0 (Merge branch 'fc/transport-helper-no-refspec')
had a wrong merge conflict and readded them.

Reported-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 673b7c2..b66c7fd 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -875,9 +875,6 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		if (ref->peer_ref) {
 			if (strcmp(ref->peer_ref->name, ref->name))
 				die("remote-helpers do not support old:new syntax");
-- 
1.8.4.2+fc1
