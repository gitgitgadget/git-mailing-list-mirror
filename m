From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/7] git-mergetool: remove redundant assignment
Date: Fri, 25 Jan 2013 01:43:49 -0800
Message-ID: <1359107034-14606-3-git-send-email-davvid@gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:49:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyfuw-0001lf-9v
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536Ab3AYJt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:49:28 -0500
Received: from mail-ia0-f181.google.com ([209.85.210.181]:37092 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab3AYJtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:49:25 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jan 2013 04:49:25 EST
Received: by mail-ia0-f181.google.com with SMTP id k25so285927iah.40
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=FZBukt095EFGslYsgNb9xAISAYSgcuuVKYSQFXIRvPc=;
        b=OrlJtjdTIX1715FVAYSQJkPVahrjoSHzPTzidpAQuOfZ/z+b8tJcvgcsUTGPUIYPvJ
         l08nfoa7MplfzN+VqU9wa8jDyCIPUywOVnZ/QMW5FlC8xOcZ281iElrnzGZqTC5kl8N4
         PgFz0RKPe+cYE8BsErHGSAlvep3wGz3Uk+M1Wu4vhjT7co2WRwmsWzGrC1mMc05iYCjK
         LWTMjrWSB3oZd6tZzzMVwe+vs4tPtPtp0d+IDb9LfYXLjDN7CaFiy4PMwaHbuZWK+nRP
         iiMzIKg2pMJvCwLe2oN0BcZAh3HVGpWWTmWT5671ovAGw2dqyPKz4mfJ0fjXQBd9wFoM
         likA==
X-Received: by 10.50.191.164 with SMTP id gz4mr3839465igc.24.1359107047189;
        Fri, 25 Jan 2013 01:44:07 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id gs6sm314611igc.11.2013.01.25.01.44.05
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 01:44:06 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.367.g22b1720.dirty
In-Reply-To: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214533>

From: John Keeping <john@keeping.me.uk>

TOOL_MODE is set at the top of git-mergetool.sh so there is no need to
set it again in show_tool_help.  Removing this lets us re-use
show_tool_help in git-difftool.

Signed-off-by: John Keeping <john@keeping.me.uk>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 89a857f..1748315 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -175,7 +175,6 @@ list_merge_tool_candidates () {
 }
 
 show_tool_help () {
-	TOOL_MODE=merge
 	list_merge_tool_candidates
 	unavailable= available= LF='
 '
-- 
1.8.1.1.367.g22b1720.dirty
