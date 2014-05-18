From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 02/33] Allow "guilt delete -f" to run from a dir which contains spaces.
Date: Sun, 18 May 2014 23:59:38 +0200
Message-ID: <1400450409-30998-3-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:03:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9B5-0005el-Ny
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbaERWD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:03:26 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:65189 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbaERWDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:03:25 -0400
Received: by mail-lb0-f169.google.com with SMTP id s7so3466450lbd.0
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m0Y5h2W60kBK4mvCeOwPqfjfvu8A89bXEHqkc7CmGXo=;
        b=Old7LvsFuHFA+iOcs8PTeYoxcxCJWlBKXOArdqCjMuxuN+F4oMdJ+HuiK5t4IiLwcn
         Qz6Q9ggGca1aKL9Sd0F3qi3SE9xU/R/ambCGV20eydJW1bISqHuj0XRhKgvNffQoUEvY
         I64CqAnZdR3r12beyL9o+GvGjXUSgkVhWlx+QGup5nFaVLN5SzjN6w9i/JJD4UD0Oiod
         /C0EisGGCUNzLeZ5mmnvQ1VZ9TaD2iq8Paac++hvMLCTO93wmvB4OEANisvOZAIjKsZM
         hntH5wsyTEKtRJ+R1CSoeCJ+cQHtmH4HK32f5YlYkGbanxL7qr5uDSHQnEJVzEKMq+E7
         WJhQ==
X-Gm-Message-State: ALoCoQlrndczsHSLiGe4KPquA1S1J/OLUD9eoB5WJtKMZLcv3zZXhd3OayFTONFrAO+PFbhHIORs
X-Received: by 10.112.130.229 with SMTP id oh5mr3516928lbb.49.1400450604554;
        Sun, 18 May 2014 15:03:24 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.03.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:03:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249517>

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt-delete | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt-delete b/guilt-delete
index 3e394f8..967ac10 100755
--- a/guilt-delete
+++ b/guilt-delete
@@ -49,7 +49,7 @@ series_remove_patch "$patch"
 
 guilt_hook "delete" "$patch"
 
-[ ! -z "$force" ] && rm -f $GUILT_DIR/$branch/$patch
+[ ! -z "$force" ] && rm -f "$GUILT_DIR/$branch/$patch"
 
 exit 0
 
-- 
1.8.3.1
