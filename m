From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 1/2] guilt graph: Simplify getfiles.
Date: Fri, 23 Jan 2015 15:21:06 +0100
Message-ID: <1422022867-7908-2-git-send-email-cederp@opera.com>
References: <1422022867-7908-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 15:22:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEf7x-0001ER-7a
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 15:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbbAWOWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 09:22:22 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:61238 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbbAWOWU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 09:22:20 -0500
Received: by mail-wg0-f43.google.com with SMTP id y19so7782781wgg.2
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 06:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48t9fHnRNfEecYI+wrMS8Wn0MtAiqdclDMUGCXBhVDI=;
        b=fXp/LpHiqPzZ6YcZZO2K9Ttdd0pGQ7dJMDFMaHPx3wi+3oBlaUm7dPFbTHJ4fAdjzp
         fmZxeZzsg4TwGc4lw7Ddv1DliEGxImFp/8MyCmt9Ee6mcbC5my2uNSGeOLwxPmkmRHPO
         vuNWf3pfvA5uyoosuam1T9IY/fzelPxdOlw6Kfps4giP5igdOpJ9tkjTyaKhEfuUnuvg
         tIxXkVYVtzbnrWlwbcsn/d2cXdtX7yY+sSg8Qo5MGoy2mDSKvN7amRdmQgr4A918VuF5
         qLh/UmbhLrtjpjdIyf3+Tjn44OHOvj6rZQaWAcKQ2k+eXD7y67v5XrgWA/kyh81mRx/E
         gdgA==
X-Gm-Message-State: ALoCoQmpli6NN7ruqbexs4RBd9IO9XYbzCx7c3v4xILjaZJDr+s+A2gxoTZhcBkzqYN9E4Ijo0NZ
X-Received: by 10.195.13.77 with SMTP id ew13mr14221662wjd.106.1422022939562;
        Fri, 23 Jan 2015 06:22:19 -0800 (PST)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id uq1sm2413134wjc.14.2015.01.23.06.22.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 06:22:18 -0800 (PST)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1422022867-7908-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262930>

git diff-tree by default emits TAB-separated fields.  cut by defaults
processes TAB-separated fields.  Simplify getfiles() by using TAB as
the separator.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-graph | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt-graph b/guilt-graph
index 0857e0d..d90c2f1 100755
--- a/guilt-graph
+++ b/guilt-graph
@@ -36,7 +36,7 @@ fi
 
 getfiles()
 {
-	git diff-tree -r "$1^" "$1" | tr '\t' ' ' | cut -d' ' -f6
+	git diff-tree -r "$1^" "$1" | cut -f2
 }
 
 cache="$GUILT_DIR/$branch/.graphcache.$$"
-- 
2.1.0
