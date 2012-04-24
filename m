From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv4 2/5] git p4: Squash P4EDITOR in test harness
Date: Tue, 24 Apr 2012 09:33:20 +0100
Message-ID: <1335256403-22162-3-git-send-email-luke@diamand.org>
References: <1335256403-22162-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 10:33:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMbBz-00088z-HJ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 10:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab2DXIdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 04:33:36 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38365 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984Ab2DXIdd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 04:33:33 -0400
Received: by wgbdr13 with SMTP id dr13so426385wgb.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 01:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=Ka1+UZ93Akz6Vhu9pZirGwxBHarsnVNSqxC3/NOCk/g=;
        b=TAlgmN5L4AL7HnYcTmxFJDpSeYQNCu3Dvv554DC41fTePEFp4tnCU18zEFTuAH8ysv
         +xpb9IVmMCu9LPK3jL5iLE3xYiYbpFeEcpg0sYqyo665NBMAmERmrPXipeumSW2X7WAx
         dtDEGBgNpzqLV9pO0wHJzFoMx67b8MkouEM8hGmni3k51Jzb0B9tIHnkVWD3S6f1pSEG
         b6cgjqb1S+jdb6pLwjwbe6iM154jlf+VeBnTirA/yhiyHZz0rtaSDpb0SkDO2FqR1EKL
         Ozw2irgz1fjAEytm58d6ZGbRyljkau0FAtXToSDQ3hfrgNO9f54yhypyeSGCbzZ9JM6/
         AjBQ==
Received: by 10.216.139.67 with SMTP id b45mr1671390wej.0.1335256412644;
        Tue, 24 Apr 2012 01:33:32 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fz9sm28534467wib.3.2012.04.24.01.33.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 01:33:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.8.g12781
In-Reply-To: <1335256403-22162-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQl3Hvuwg9kY/2rDdX3ahLSz/6ZFq4DM1WdjGpA6C0Oz6h1zCp+CVPaLdQ7MwDSzJcqNKDH7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196211>

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
1.7.10.8.g12781
