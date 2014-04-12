From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v9 1/6] transport-helper: mismerge fix
Date: Sat, 12 Apr 2014 15:12:50 -0500
Message-ID: <1397333575-11614-2-git-send-email-felipe.contreras@gmail.com>
References: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:23:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4Sm-0007Oi-BU
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653AbaDLUXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:23:11 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:65068 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbaDLUXD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:23:03 -0400
Received: by mail-ob0-f171.google.com with SMTP id uy5so603701obc.30
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PiqM2zy6Z3UIiymo8/FUGokD7iGoYtqrPGg29gEPMx4=;
        b=KFOJF2/r9keSvQaLGnO/9HbEK/5RQtZF0lYATkXRDk61qgvCSM9+0x0KweW+WQ5+OY
         RJXqR7aZbPqOViJ5hF8wie3Z/oUJuW6qvku/LWxvBMsp5YyyXFySM4Mohgv7n9KbBboz
         Q/SVuv9pjzkVmAktpkPzN4wO3Rff/fTJ8Jagq4j6xzdsKfSKJsmeBfKtfEJ1G/XU3Uek
         eG+DXefjr+0nmOrXxmTN9SJGlXPi9dkseM5sAw4/h3bWNG62QZZza8LeoxTZj0ZIae/K
         B8QzZvYnZcyQHbGvcRkwNBoK4IBVXqApQ949lSIHYsqeSbsvua/xivAh1AsIZ8cRXL0X
         u3NQ==
X-Received: by 10.182.125.161 with SMTP id mr1mr3555955obb.47.1397334182215;
        Sat, 12 Apr 2014 13:23:02 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e8sm48940994oed.7.2014.04.12.13.22.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:23:01 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246180>

Commit 9c51558 (transport-helper: trivial code shuffle) moved these
lines above, but 99d9ec0 (Merge branch 'fc/transport-helper-no-refspec')
had a wrong merge conflict and readded them.

Reported-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index ad72fbd..ea34d0c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -881,9 +881,6 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		if (ref->peer_ref) {
 			if (strcmp(ref->peer_ref->name, ref->name))
 				die("remote-helpers do not support old:new syntax");
-- 
1.9.1+fc3.9.gc73078e
