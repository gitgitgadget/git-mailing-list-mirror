From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 02/10] transport-helper: fix extra lines
Date: Sun, 27 Oct 2013 01:05:15 -0600
Message-ID: <1382857521-7005-5-git-send-email-felipe.contreras@gmail.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 08:12:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaKWP-0006pL-Qe
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 08:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab3J0HMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 03:12:17 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:38708 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab3J0HML (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 03:12:11 -0400
Received: by mail-oa0-f48.google.com with SMTP id m17so2428100oag.7
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5O3ZkRxty1n0NqzbtDC7v5EQ5309DmxFGaHEMMDjh98=;
        b=0sX8cYPnbNp7REyUW+PK1ptSOzyo4qcRZg52cihJZKtQG86QyiPlXFlrryesA3BLfT
         b9j4x9BdpXWLE+w0pqCkddruGtZ3+AJdOUxP3ZU4Dmf0W8wTIodmajgJWoYmDhh4CzL/
         1ZtBYi82PWFS0TBxEgSgmkfhQTzlAxdRZayen3UmbAaCTBRbbh0V2JUBQTdw1D3EJA+8
         20qe9Yhpp8MgtrBMPSVxomBA7yWUwTC06a3sxJ93Z9oisdrZ5UhaITbfSjVM/xdKrUs/
         S6LG0vbL22in8y0zXWgfevRRh8HoytXSPJ4k8Ok2jRFE+1MOOEbRPKsMvpH/smgUB2Q8
         XBzA==
X-Received: by 10.60.78.227 with SMTP id e3mr9681957oex.5.1382857930691;
        Sun, 27 Oct 2013 00:12:10 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ee7sm22405038oeb.5.2013.10.27.00.12.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2013 00:12:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236785>

Commit 9c51558 (transport-helper: trivial code shuffle) moved these
lines above, but 99d9ec0 (Merge branch 'fc/transport-helper-no-refspec')
had a wrong merge conflict and readded them.

Reported-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 408d596..707351d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -879,9 +879,6 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		if (ref->peer_ref) {
 			if (strcmp(ref->peer_ref->name, ref->name))
 				die("remote-helpers do not support old:new syntax");
-- 
1.8.4-fc
