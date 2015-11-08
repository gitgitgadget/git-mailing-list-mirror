From: Daniel Knittl-Frank <knittl89@googlemail.com>
Subject: [PATCH] Escape Git's exec path in contrib/rerere-train.sh script
Date: Sun,  8 Nov 2015 12:27:55 +0100
Message-ID: <1446982075-26161-1-git-send-email-knittl89+git@googlemail.com>
Cc: Daniel Knittl-Frank <knittl89+git@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 12:28:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvO9I-0004mU-WB
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 12:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbbKHL2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 06:28:37 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35644 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbbKHL2f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2015 06:28:35 -0500
Received: by wiby19 with SMTP id y19so268763wib.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2015 03:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cELfeKyoaAq55s0iNsmGgAX++vgA5yZbGzt7aJ9I0dI=;
        b=U4+gGQa5it3+1TBumIIMN5U81BMc1sMrj8+SvLdYhxzs3JEZKgYVPaC4ie8ps44Mm9
         JYCH5Bltg8bL6CnaQPGkZo4OJu7uIOlzFFJUXfiSnXFoFez8kMcBorr4wncTRbmPP6HQ
         d/NJU/nSIIPDpLi0q/i6xzqy1mgrXkqD0bf+X/PeiCXZC+N1+c/fDNDCvfziwJ64sLxb
         wm50M4CYncsSs3rT8/RKn9l4maQ+7ruXnBs1rPh0PjwfXFgAIScI1WkosTEVA/Lv4ehu
         xAKvq7jbtRsP03ICq25xYn1QGSzUA2Nt6gr8uiDpB1HR/Ce0yPrW7nRKpmhBOnEq7Oh/
         tvyg==
X-Received: by 10.194.120.169 with SMTP id ld9mr24296102wjb.48.1446982114576;
        Sun, 08 Nov 2015 03:28:34 -0800 (PST)
Received: from localhost.localdomain (cpe90-146-127-42.liwest.at. [90.146.127.42])
        by smtp.gmail.com with ESMTPSA id t2sm8487014wme.0.2015.11.08.03.28.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Nov 2015 03:28:33 -0800 (PST)
X-Google-Original-From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
X-Mailer: git-send-email 2.6.3.490.ge2d6e62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281036>

Whitespace can cause the source command to fail. This is usually not a
problem on Unix systems, but on Windows Git is likely to be installed
under "C:/Program Files/", thus rendering the script broken.

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---
 contrib/rerere-train.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
index 36b6fee..52ad9e4 100755
--- a/contrib/rerere-train.sh
+++ b/contrib/rerere-train.sh
@@ -7,7 +7,7 @@ USAGE="$me rev-list-args"
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
-. $(git --exec-path)/git-sh-setup
+. "$(git --exec-path)/git-sh-setup"
 require_work_tree
 cd_to_toplevel
 
-- 
2.6.0.rc0.134.g48a2a2a
