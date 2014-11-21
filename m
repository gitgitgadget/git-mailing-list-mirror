From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/3] difftool--helper: add explicit exit statement
Date: Thu, 20 Nov 2014 17:20:28 -0800
Message-ID: <1416532829-68662-3-git-send-email-davvid@gmail.com>
References: <1416532829-68662-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 02:20:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrcu9-0006Ek-EQ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 02:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757527AbaKUBUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 20:20:47 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36089 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757360AbaKUBUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 20:20:45 -0500
Received: by mail-pd0-f172.google.com with SMTP id v10so4156526pde.31
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 17:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OpZ1zZGENOFAuwjjTwM7RBMMaaD/BNliBpVOX8Wcbgw=;
        b=ZoRDCCRidOE7Lqb9s6P1qD9W+Y9Gy4NkkZ1/b7vJunvycpsDbP/vJ8uw98+nB8gi3E
         pFcCDxi+4b026RUneeOC07qu8r2HgiagYmXDPBPm7d8O4Hs1QlybcspR1Rrv3LTEMYG+
         xaRVSc/6qGFrdkscAx8zaCTfmiNxWFjTjPMFTUAYFTopFgGZgZVHmX17uZIz4mATNt4B
         M3mBFxdcY63Kx1Lw8WL2WI4xDehzSEnnynvhOXofIjZTsL+UaGjZ1GUYHkkeJ6pnB4Zf
         hlGWvXhw5/rLNU46y/IAY4J5sgNk9/8aNMoYvNYosZTqBtYiScgvJf7D2qQMh2UldO09
         9Ixg==
X-Received: by 10.66.156.168 with SMTP id wf8mr1995412pab.43.1416532845369;
        Thu, 20 Nov 2014 17:20:45 -0800 (PST)
Received: from lustrous.local.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by mx.google.com with ESMTPSA id w5sm3151439pds.25.2014.11.20.17.20.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 17:20:44 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.26.g3e3388f
In-Reply-To: <1416532829-68662-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-difftool--helper returns a zero exit status unless
--trust-exit-code is in effect.  Add an explicit exit statement
to make this clearer.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool--helper.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index d4fb6df..2b11b1d 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -94,3 +94,5 @@ else
 		shift 7
 	done
 fi
+
+exit 0
-- 
2.2.0.rc2.26.g3e3388f
