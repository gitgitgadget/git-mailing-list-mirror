From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 02/31] Allow "guilt delete -f" to run from a dir which contains spaces.
Date: Fri, 16 May 2014 16:45:49 +0200
Message-ID: <1400251578-17221-3-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:47:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJQ8-0006Dn-AJ
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757312AbaEPOrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:47:31 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:41097 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595AbaEPOra (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:47:30 -0400
Received: by mail-la0-f50.google.com with SMTP id b8so2057221lan.9
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m0Y5h2W60kBK4mvCeOwPqfjfvu8A89bXEHqkc7CmGXo=;
        b=cKqzN5A8ZoATR6BQu5eei76EqwuvcPlUEueylfT1ivmr/AhOlvufAJQ5dyBmQ1RjM7
         lKwJBt0TsGNa+tlplbeu2yCLbrjMQ5duL1cobEpwcBm1S2Lv+pOSjRong32gvt6aqeGY
         QD/2a/zzW1+9QLdy0HHRxUgKAsEHjc0MuKI44nhjUJCvHY67Ug2XnArUkVo9n+iEgDjN
         A1inRz3VYT7YpatPLyoTFVlv6vRT/Gl12uK5hKibWhDVVwOsEv9tZuFz8/CGrZqmSkVT
         +/C98iqqK+nrD4LcdVkHGAk3KrujnKvhczSuCXwQo3JBHbBOT343Tj2ItWQ+XEksaMO8
         RThQ==
X-Gm-Message-State: ALoCoQmf6vp6fuGC+4QwwADpgQOVcnpzLSfp3qHESUKrURN9nzZGrS0ZQsIjS7TmfNduEYPybitw
X-Received: by 10.152.121.72 with SMTP id li8mr2398304lab.45.1400251649288;
        Fri, 16 May 2014 07:47:29 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.47.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:47:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249309>

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
