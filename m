From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 2/5] git p4: Squash P4EDITOR in test harness
Date: Tue, 24 Apr 2012 09:08:14 +0100
Message-ID: <1335254897-15242-3-git-send-email-luke@diamand.org>
References: <1335254897-15242-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 10:08:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMans-00082N-AL
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 10:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549Ab2DXIId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 04:08:33 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:64987 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab2DXII1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 04:08:27 -0400
Received: by wejx9 with SMTP id x9so230927wej.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 01:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=xYcW0pX7KOIiggenkgakFmDc/uZyg+VwWEI+I/p36fg=;
        b=MmQbTPloM2CWrgBN+ItM/6J52OrymH+543hvvFaFn8r73sij8wTyxh6y9FVITEQ2yZ
         gJbsNEnyV/2WQm/58dzVlDY4mnlM0BHgxyprWpWrdaN0154O2UcjotOEfWxNk2bwxtJy
         cIl1Nx4BPlO5pUp9eqBDSIwSI8VbFU1yFMGUdGR4TPbv1aOXKguw0eRjGkiRdlEooAo3
         0pY2bXFJJo+fuilYPJrMyCjlitEsrNpmcae+eVW/yCvCINbUnsfGtwQAB/l3e/KyRwNM
         sEVWa4nifQhsrG4aj9qs+nuZlQo9byPwsShu7VSu+lORp7xtmAoK94juc1er4nx7gGHk
         aNXA==
Received: by 10.180.79.72 with SMTP id h8mr29035712wix.1.1335254906544;
        Tue, 24 Apr 2012 01:08:26 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fl2sm44448146wib.2.2012.04.24.01.08.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 01:08:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.381.gb484f
In-Reply-To: <1335254897-15242-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQmtS0lrxo5ZhZ2pQ+yYdwEAi9nahSuL9R3DUYM6n/D9qXir5EPsW9yrZkzI/3ShdWS6TEd6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196205>

If P4EDITOR is set in the environment, test behavior could be
unpredictable. Set it explicitly.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/lib-git-p4.sh |    1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index b90986c..121e380 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -24,6 +24,7 @@ P4DPORT=$((10669 + ($testid - $git_p4_test_start)))
 
 export P4PORT=localhost:$P4DPORT
 export P4CLIENT=client
+export P4EDITOR=:
 
 db="$TRASH_DIRECTORY/db"
 cli="$TRASH_DIRECTORY/cli"
-- 
1.7.10.381.gb484f
