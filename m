From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] send-email: Much readable error output
Date: Fri, 26 Dec 2014 18:06:39 +0600
Message-ID: <1419595599-19974-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, 0xAX <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 13:07:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4Tfd-0007UT-Vc
	for gcvg-git-2@plane.gmane.org; Fri, 26 Dec 2014 13:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbaLZMHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2014 07:07:00 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:45360 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaLZMG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2014 07:06:59 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so8682451lbv.12
        for <git@vger.kernel.org>; Fri, 26 Dec 2014 04:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=u63BDtdngwf1Hcp8lyk/U3+5G76chBSEVK9IAHxUARc=;
        b=E3A8hfdOPnjNWc6jwSwkXzVSy/xAxFIbZ9ISDPzF0hpuTVVftN4LA6GGxdPwpGOP8+
         M4bHMeezgsX98geMB4Uz8URdW+eIsTnBB9mFAtMmim4VWLgq2yWKRINyNo8M7f3vYPA2
         3crA8AZWeMAdmUSKJBKzpMROlxaWKSYrTHc46nXWY6XVzVF3jYVf1xtv44KG9/sazwWS
         fKSsiW3Rz4/0b+cnolM1xqaCAhd8XJCK33NyxsvMDkw4hUvHhdVl9oQiHc/od9mX5K1q
         KEGJZLr8mQ7Dy/XyuBJ+Gjg5aa49pNP4uF4RNKmgCIzo4aqmDfLmHome8QTeI6HeD487
         uhHQ==
X-Received: by 10.112.64.35 with SMTP id l3mr23783202lbs.82.1419595617876;
        Fri, 26 Dec 2014 04:06:57 -0800 (PST)
Received: from localhost.localdomain ([92.46.67.80])
        by mx.google.com with ESMTPSA id bs3sm914398lbd.37.2014.12.26.04.06.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Dec 2014 04:06:57 -0800 (PST)
X-Mailer: git-send-email 2.2.1.202.g98acd41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261827>

Signed-off-by: 0xAX <kuleshovmail@gmail.com>
---
 git-send-email.perl | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 82c6fea..6a995c4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1274,11 +1274,11 @@ X-Mailer: git-send-email $gitversion
 		}
 
 		if (!$smtp) {
-			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
-			    "VALUES: server=$smtp_server ",
-			    "encryption=$smtp_encryption ",
-			    "hello=$smtp_domain",
-			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
+			die "Unable to initialize SMTP properly. Check config and use --smtp-debug.\n",
+			    "VALUES: server=$smtp_server\n\t",
+			    "encryption=$smtp_encryption\n\t",
+			    "hello=$smtp_domain\n\t",
+			    defined $smtp_server_port ? "port=$smtp_server_port\n" : "\n";
 		}
 
 		smtp_auth_maybe or die $smtp->message;
-- 
2.2.1.202.g98acd41
