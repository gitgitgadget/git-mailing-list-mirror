From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] Documentation: add instructions to help setup gmail 2FA
Date: Fri, 27 May 2016 16:39:57 -0400
Message-ID: <1464381597-27634-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 22:40:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6OYr-0004GB-FY
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 22:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbcE0UkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 16:40:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34028 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964799AbcE0UkN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 16:40:13 -0400
Received: by mail-it0-f68.google.com with SMTP id k76so640098ita.1
        for <git@vger.kernel.org>; Fri, 27 May 2016 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OThrtWXHII236Jl8CcQQHeEn6TtVeRf/80cKZan4U3w=;
        b=wAz8JWaFjzs6rLMoFN6naFsC+L44hlGDBY+OpT+0vOEW/XsGgqsFD7BDQWHhY8oouB
         QkIsYh0OWAzdJ+k+iQAxgEvOQMPpXMuKttc0+6qzxNDgJFLmJqsbsRfiFSCF6mzGST0B
         xgkjEjtWRPAW/u1Kbb64f2hvbrB8/AXIpG79+zzsdy+4QzzCUrcmZ2+dspyD+pIeHVOQ
         gIxBbp6TKo/pE1nNgOj9QLdcFpS6eLfK8ySZkNkFJOVfP0MAcMa/xm3JQ+R+Ov9eNI99
         zuwXHN6sjW1PRZCyjFdBR3o0dq2Npd59n3JLcRcl+mo+JvMD4yCl9auD/Cbx0QQYlXaH
         UAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OThrtWXHII236Jl8CcQQHeEn6TtVeRf/80cKZan4U3w=;
        b=Z8m9lHQ/Hwtan8n8EAxlLgKgiICks1yZO0B6/iosPoZj2Zgw4uMHj9EhtGTB6/PuDP
         aru247j2t1nYYmf95++S2yixo3PL2DftcDBPFl9LpK2UigRjdMMsjjrKW803cCBwd7Zx
         qwGfxoCwCxRH6AlwSyCr28T/FET2OFb7rPnicwwYP9uEJcoOtE1wEjhiuu1eZFu5WAAC
         gwfXGKFX5l+nT408rwI3E9gChjx3v3vP3cPHsXdtMLU4FLUw7C1410+eIhmiK2bwcEGz
         Yez74qPlXwt+gVSJxeFgnH595z3cCWYb+P9a+BCafsxyk2sZQsji7Rk425ayH363dejl
         uLiA==
X-Gm-Message-State: ALyK8tLxvRFPvLDaNlO9iWiIVSR73JA0DAMqqfZDPEcs5j6o68/pKda3efkbtjOf3EbEfg==
X-Received: by 10.36.120.83 with SMTP id p80mr513814itc.46.1464381612587;
        Fri, 27 May 2016 13:40:12 -0700 (PDT)
Received: from localhost.localdomain (86.sub-70-208-86.myvzw.com. [70.208.86.86])
        by smtp.gmail.com with ESMTPSA id r206sm3178881itc.3.2016.05.27.13.39.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 27 May 2016 13:40:12 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295794>

For those who use two-factor authentication with gmail, git-send-email
will not work unless it is setup with an app-specific password. The
example for setting up git-send-email for use with gmail will now
include information on generating and storing the app-specific password.
---
 Documentation/git-send-email.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 771a7b5..edbba3a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -450,6 +450,19 @@ edit ~/.gitconfig to specify your account settings:
 		smtpUser = yourname@gmail.com
 		smtpServerPort = 587
 
+If you have multifactor authentication setup on your gmail acocunt, you will
+need to generate an app-specific password for use with 'git send-email'. Visit
+https://security.google.com/settings/security/apppasswords to setup an
+app-specific password.  Once setup, you can store it with the credentials
+helper:
+
+	$ git credential fill
+	protocol=smtp
+	host=smtp.gmail.com
+	username=youname@gmail.com
+	password=app-password
+
+
 Once your commits are ready to be sent to the mailing list, run the
 following commands:
 
-- 
2.8.0
