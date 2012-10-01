From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] gitk: Add workaround for system where Shift-F5 mapped to Shift-XF86_Switch_VT_5
Date: Mon,  1 Oct 2012 11:26:31 -0400
Message-ID: <1349105191-31681-2-git-send-email-andrew.kw.w@gmail.com>
References: <20120930101932.GA15672@goldbirke>
 <1349105191-31681-1-git-send-email-andrew.kw.w@gmail.com>
Cc: szeder@ira.uka.de, paulus@samba.org,
	Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 17:27:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIhtm-0000sm-0Q
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 17:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab2JAP04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 11:26:56 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33650 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab2JAP0x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 11:26:53 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so12379814iea.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rPR/Ogh9fdZwpvp+HkfOPb+30kM3eI+4czBADc02ZP8=;
        b=Z7HwgpLB2cHIoGVzghH2lf2xEiPMFc6NMgJFgqm6dB0yQ1B6pC7vgki/61MnFayq7Y
         iiLxYvpdK4JhUQYm/4uBRcc7EVHPUoOJ8Ew6ZM5F640svPMTOs4ZS9kCbX+Vit5vgvW0
         ElYoX8xUpW5U97y0gY5xkd5wtJ5iLy/j3D5YDEoDCbsBPulst1d6InjDuk1BHve95gJM
         zQXDBZfaUzFuXuRwhZk8P5G6c3Qvz7Y1FCD93Nr5Erud0mtgTjLS7LpXepeGcbNfXFm6
         mhBe2M1ZvXu3ZHSSTmLSCD6jMMbx/MmdL06V7NTsQYv01dZteICPl8deqVBW64ETL/K5
         1FNg==
Received: by 10.43.16.67 with SMTP id px3mr11654940icb.17.1349105212021;
        Mon, 01 Oct 2012 08:26:52 -0700 (PDT)
Received: from nigel.sohovfx.com ([66.207.196.114])
        by mx.google.com with ESMTPS id ch4sm6726712igb.2.2012.10.01.08.26.51
        (version=SSLv3 cipher=OTHER);
        Mon, 01 Oct 2012 08:26:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.382.gb0576a6
In-Reply-To: <1349105191-31681-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206738>

The same workaround was used for Shift-F4 in:
  cea07cf8dc9b3677e0c50433c0d72bce83adbdc7

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 gitk-git/gitk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d93bd99..698b84a 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2496,6 +2496,7 @@ proc makewindow {} {
     bindkey f nextfile
     bind . <F5> updatecommits
     bind . <Shift-F5> reloadcommits
+    catch { bind . <Shift-Key-XF86_Switch_VT_5> reloadcommits }
     bind . <F2> showrefs
     bind . <Shift-F4> {newview 0}
     catch { bind . <Shift-Key-XF86_Switch_VT_4> {newview 0} }
-- 
1.7.12.1.382.gb0576a6
