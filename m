From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 1/6] transport-helper: mismerge fix
Date: Sat,  7 Dec 2013 15:08:07 -0600
Message-ID: <1386450492-22348-2-git-send-email-felipe.contreras@gmail.com>
References: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 22:15:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpPE7-0002rD-5Z
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 22:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856Ab3LGVPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 16:15:48 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:46614 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813Ab3LGVPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 16:15:45 -0500
Received: by mail-oa0-f47.google.com with SMTP id k1so2325486oag.6
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 13:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xUlRT4s8Yw5iZhjD3nxic6tb4TwuvvqY4W4aDBIirZI=;
        b=eGb4mnwJJywVjmwRKwLv8hYgMIVYEoIKs/LdA5B4nqgOnKErfecUpzJoddCKgeEvBG
         ggrvtfqEvrRkYP6kjRor/iQ69BYNPVZmDDxD4apqjp4yVu7qaOZp3lB/YPjk3fDZctCe
         7fl8aK7XTiwVWm3N8vEoTtO7BpczjflSljJArK3MpuxBtuoH5Euiuf+Aw+DYk2KgA6R9
         AW8tIvDP5g82iGOxdtoulU82lzru0kIG0y/1qkl62M0vAM7LsiO7QG8OzFl6JI63rYqY
         DTChPyo2DjoitgrT8We5Z8TBmck3bpnaS1qQLcov0UDPpSve9vMgEep7KsnBW4WPJXaM
         encw==
X-Received: by 10.60.58.134 with SMTP id r6mr7423063oeq.17.1386450945173;
        Sat, 07 Dec 2013 13:15:45 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id qh4sm5970196obc.4.2013.12.07.13.15.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 13:15:44 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1
In-Reply-To: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239020>

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
1.8.5.1+fc1
