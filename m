From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 2/2] format-patch: ignore diff.submodule setting
Date: Fri, 26 Dec 2014 17:11:46 -0600
Message-ID: <1419635506-5045-3-git-send-email-dougk.ff7@gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Cc: Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 00:12:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4e3C-0004Hq-BS
	for gcvg-git-2@plane.gmane.org; Sat, 27 Dec 2014 00:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbaLZXL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2014 18:11:58 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:38890 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbaLZXL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2014 18:11:56 -0500
Received: by mail-ob0-f171.google.com with SMTP id uz6so35590840obc.2
        for <git@vger.kernel.org>; Fri, 26 Dec 2014 15:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c4VUp9IZDY22B54QcRPHz9EGXWolA0tbGes4c/7ZYI8=;
        b=n+HJQIkVgp+bjhLV7E8n0wB/g5e75fwxOSodJctK9hcjoV9emTDedmFb7q0xuEyFUD
         h5Vt8cFsbOVhIZj7n2FpJ0PhXanOqEIbdvUVVMXBcrby7aPWX5UONXH+VNbMM24AYqKL
         +Ds2GklmdByJU6ZGLqML47NX8fpLI+mg0RC5XLPAMneF+RggPXWHCY4Qw1iR0lN8bAgs
         gw+41jt3newSGI2nIzp/w1E2ReLe1sKkSe6Wb36fjZRahbypR9FIdJornSOqzrgOlpmv
         nUeHZ7nkNRxyB8yPvf1T+rAngeloY2Kh34aWaCjUfRfFZSWhpQMOON6ZI+Lrlz1ZisAs
         G/Qg==
X-Received: by 10.182.68.104 with SMTP id v8mr25754280obt.17.1419635514897;
        Fri, 26 Dec 2014 15:11:54 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by mx.google.com with ESMTPSA id w81sm15074486oiw.10.2014.12.26.15.11.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Dec 2014 15:11:53 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261832>

diff.submodule when set to log produces output which git-am cannot
handle. Ignore this setting when generating patch output.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 734aab3..cb14db4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -705,7 +705,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff") ||
-	    !strcmp(var, "color.ui")) {
+	    !strcmp(var, "color.ui") || !strcmp(var, "diff.submodule")) {
 		return 0;
 	}
 	if (!strcmp(var, "format.numbered")) {
-- 
2.0.5
