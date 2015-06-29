From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH] --count feature for git shortlog
Date: Sun, 28 Jun 2015 18:22:02 -0700
Message-ID: <1435540922-12208-3-git-send-email-lawrencesiebert@gmail.com>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
Cc: Johannes.Schindelin@gmx.de, apelisse@gmail.com, jrnieder@gmail.com,
	Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 03:22:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9NmH-0008TO-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 03:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbbF2BW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 21:22:26 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34818 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbbF2BWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 21:22:20 -0400
Received: by ykdy1 with SMTP id y1so102570316ykd.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 18:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N4wrBHw+nQ17/C1aEOnBeDoEkw/snQOS4BkhdMQXmtU=;
        b=Bq6AD7Zn9yLI+XqZltnRpsctP7ZX79oZfMeeZ5zn4DE1lBab9IK0NYhQcTPkfSAi2b
         IySsruVHf9haD/hrDD5wEUAW++2En7oWscz8XKzraUfQ3kgf0MoXSSbXC36b2XSWBW7Y
         A+PI6CR21Vex0sKJR4sCN0hbv7xVjEhtL8llH10hLxXn7OzDZjm5id8XDH+6DLNgnby0
         0CpPAKdjoGL6b8lw+Y1/jCkDbX9kBmaKMicW9SjY57cqwateTtUCS5cLBiD0Yq9ytmwJ
         fPONQMtDNTqrJvq6GgjnWOgrsnat6G/jcGMZfkoaDw56AQngtIYMIdE38C6OLurJBsnE
         L3cA==
X-Received: by 10.170.53.87 with SMTP id 84mr15875019ykv.68.1435540940120;
        Sun, 28 Jun 2015 18:22:20 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id c3sm35528470ywd.39.2015.06.28.18.22.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 18:22:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272930>

Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
---
 t/t4201-shortlog.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 7600a3e..33ecb4a 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -194,4 +194,9 @@ test_expect_success 'shortlog with revision pseudo options' '
 	git shortlog --exclude=refs/heads/m* --all
 '
 
+test_expect_success 'shortlog --count' '
+	git shortlog --count HEAD > actual &&
+	echo  "4" >expect &&
+	test_cmp expect actual'
+
 test_done
-- 
1.9.1
