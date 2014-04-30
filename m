From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/6] completion: bash: cleanup cygwin check
Date: Wed, 30 Apr 2014 06:07:45 -0500
Message-ID: <1398856065-2982-7-git-send-email-felipe.contreras@gmail.com>
References: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 13:18:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfSXH-0003bx-Mg
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 13:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbaD3LSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 07:18:42 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:63005 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290AbaD3LSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 07:18:41 -0400
Received: by mail-yk0-f176.google.com with SMTP id q9so1319668ykb.7
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pFfT/aI5asD5rVZG9oNDxDUG6Y2uT+l2sEgX0VEQHDU=;
        b=Goafa4ur1cK7nD0fdUpf/x9cK+3o8ba3KRYN80K2O5vBBF5HtUqBv3Mklm9Y83pNmJ
         6PccmQoL1EjfOGfbw/LAla7gaGb71vrw/naeHLueiHxo3p0IOc/OcS8V8VUYnjQ6hAA5
         UzpvPjtj/AME30yyWT8w0Cr7XgpTSBCSprAmFChtn53ubOZIigX6apQxDGb17e7iWx8e
         tgPwrRGdi0j91QZQbU/7UspdeEKLs5HgtjvogtgmIldwvdixyuyC1sXQeKEdtgYpdi9q
         tWvaSGzxoCt+6e1cZgrRX6087x6s4Uss1tej/m6PYtyJZdMs91e/zHU1QPxLy4v/VuEU
         1yug==
X-Received: by 10.236.21.241 with SMTP id r77mr4809215yhr.7.1398856719854;
        Wed, 30 Apr 2014 04:18:39 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id l67sm42283762yha.8.2014.04.30.04.18.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 04:18:38 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.11.g71fb719
In-Reply-To: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247704>

Avoid Yoda conditions, use test, and cleaner statement.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f1ce962..34edef9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2600,6 +2600,5 @@ __git_complete gitk __gitk_main
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
-if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
+test "$(uname -o 2>/dev/null)" = "Cygwin" &&
 __git_complete git.exe __git_main
-fi
-- 
1.9.2+fc1.11.g71fb719
