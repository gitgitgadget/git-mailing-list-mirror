From: Etienne Buira <etienne.buira@gmail.com>
Subject: [PATCH 1/2] fix compilation with --disable-pthreads
Date: Sat, 11 Oct 2014 16:42:07 +0200
Message-ID: <d2df2f619967ea7ba9625868b9c77d79a1190665.1413038338.git.etienne.buira@gmail.com>
Cc: Etienne Buira <etienne.buira@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 11 16:45:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcxvI-0007Hb-Lw
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 16:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbaJKOpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 10:45:10 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:46069 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbaJKOpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 10:45:09 -0400
Received: by mail-wi0-f180.google.com with SMTP id em10so4334320wid.1
        for <git@vger.kernel.org>; Sat, 11 Oct 2014 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=h/BrtH3LQ+ttOwT0wjF4+mZ6J3qWhB/A/FYDQt2kI5U=;
        b=M2FOvuRo4tsXZx0Knhmsm8jKcRhL7pRqdInIrXusnKCal5jeuCE6OSe0X946wGzkjX
         twA1mStmm447iQvyzFAaAL1mdLDNIZwRhTpn5Nm3piq5XkLUwk0ACyugZEWUbLA42/eF
         rKS1P59MIGJTrYbT6IVWJrZbWlkY0O4676HFe1JrGEorpQpAYQpYPkBOI5TBZKBDADoH
         r33ZWnYvhNy+dshIcszTu16X8ynRKCK3yI4Mt3caQj7aC4ZRzvO054P/BDntLlq9zdH1
         WVH0NaH92LGP17wWh63tf7DyICp9LCPZ7yad7OzWx8yn7HISeYlAc0h0EaIIhZ8f8XHJ
         EIpw==
X-Received: by 10.194.59.201 with SMTP id b9mr2258530wjr.103.1413038707411;
        Sat, 11 Oct 2014 07:45:07 -0700 (PDT)
Received: from localhost.localdomain (sbr22-2-88-185-151-243.fbx.proxad.net. [88.185.151.243])
        by mx.google.com with ESMTPSA id wc7sm3440004wjc.8.2014.10.11.07.45.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Oct 2014 07:45:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Etienne Buira <etienne.buira@gmail.com>
---
 builtin/index-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index eebf1a8..0f88f4b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -185,6 +185,9 @@ static void cleanup_thread(void)
 #define deepest_delta_lock()
 #define deepest_delta_unlock()
 
+#define type_cas_lock()
+#define type_cas_unlock()
+
 #endif
 
 
-- 
1.8.5.5
