From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 2/3] git p4: fix bug when verbose enabled with tag export
Date: Fri, 11 May 2012 07:25:17 +0100
Message-ID: <1336717518-4214-3-git-send-email-luke@diamand.org>
References: <1336717518-4214-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 08:25:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSjIL-0004Zl-2l
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 08:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757987Ab2EKGZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 02:25:27 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33782 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab2EKGZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 02:25:25 -0400
Received: by wgbdr13 with SMTP id dr13so2162306wgb.1
        for <git@vger.kernel.org>; Thu, 10 May 2012 23:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=SJNoqQPbVTv/d2xl7zoTA4YBUiuo03pshNo3wWE94TM=;
        b=HOpCg/hJOPlcKziQGHr71SFMdeOnYWtusUQmHuK79E4KEaKZVByMPHlab0SkhlWsGZ
         ZJtMKRPmMQ76aEJstf3YyhkW2ivniTOfJ7A2xxRIA+THutOzwLwZBfXLA3uEN8VXEpwK
         2fbyEMbroMvVXO4RM/jSA+WcEAVwD46uTSyFDfF3ScGAScnjL5mcgSbcXJLxs76Vzi1D
         i2ufMq5Lq9viejVtY41wkCvAXuc/3ebTYYOyp+P1dmPd+ev7e+Z7Q6oXb93YBohjrL2W
         bkhFdqODNQ1LKnw/eQY2UGUZLrRdAjuxWYZ8wRWwQg3S9xmf1aGk5wsPvaQjws00yfIO
         FRig==
Received: by 10.180.107.104 with SMTP id hb8mr4450210wib.8.1336717524620;
        Thu, 10 May 2012 23:25:24 -0700 (PDT)
Received: from halilbut.local.diamand.org (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id h8sm13801629wix.4.2012.05.10.23.25.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 23:25:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.221.g3bf1d
In-Reply-To: <1336717518-4214-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQkH6KpFIuJ/iEHCaS1NqRBSE5ejkbRCApUkjJNHrPpYQTiASbmclbiXF9fgxyZ33W/euuky
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197660>

Wrong variable name used when verbose enabled, causes failure.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 565cfbc..8f0169a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1302,7 +1302,7 @@ class P4Submit(Command, P4UserMap):
 
             if not m.match(name):
                 if verbose:
-                    print "tag %s does not match regexp %s" % (name, validTagRegexp)
+                    print "tag %s does not match regexp %s" % (name, validLabelRegexp)
                 continue
 
             # Get the p4 commit this corresponds to
-- 
1.7.10.282.g2120.dirty
