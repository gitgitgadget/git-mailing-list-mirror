From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 30/36] rebase: cherry-pick: set correct action-name
Date: Sun,  9 Jun 2013 14:24:44 -0500
Message-ID: <1370805890-3453-31-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllI2-00048m-6n
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496Ab3FIT2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:28:16 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:58367 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab3FIT2K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:28:10 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so9149309obb.0
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kVI/2mYulwTc1TSDyBnMhRHN60ecYgY8kZ4vOol3IW8=;
        b=DHrHLkOG8IdJ4tqh4oPmZ0F92cI3cseJ7ENX1NOJVbTTCuYC1guk/7iKqyWDUfpIbo
         qQnG/KlVh5/aJmMaYBH0oNpMrNuKC65xrBWzs3oDYzJEnavWUNXyrooGJhyDwwD67DYW
         YftRhra839iRIQkou073AXAdzeX+gwCXIDc6hYOxGV3jUKO/rvsTg24LX7CCpOyZ1gs0
         yL5CncdsBrMnoO1CZHFW2XUyT0ai7AYGMy0pBIBhh5rSO8+nOeBCHML9ezOUWkn/L7dY
         G1MYzwXjM32jVbG6JrHKyw1vZyNZI+hW7D7QnXdF/R7DpN4zSYK08cVyJxpEG0SjmExl
         pcVw==
X-Received: by 10.60.38.230 with SMTP id j6mr3227209oek.110.1370806090349;
        Sun, 09 Jun 2013 12:28:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt9sm16058662obc.0.2013.06.09.12.28.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:28:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227139>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index 241cda7..d36b0dc 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -45,7 +45,7 @@ else
 fi
 test -n "$GIT_QUIET" && extra="$extra -q"
 test -z "$force_rebase" && extra="$extra --ff"
-git cherry-pick --no-merges --right-only --topo-order --do-walk $extra "$revisions"
+git cherry-pick --no-merges --right-only --topo-order --do-walk --action-name rebase $extra "$revisions"
 ret=$?
 
 if test 0 != $ret
-- 
1.8.3.698.g079b096
