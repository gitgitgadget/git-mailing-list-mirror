From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 22/28] The log.decorate setting should not influence patchbomb.
Date: Fri, 21 Mar 2014 08:32:00 +0100
Message-ID: <1395387126-13681-23-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:33:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtxc-0002XC-FC
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759926AbaCUHdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:38 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36989 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbaCUHde (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:34 -0400
Received: by mail-lb0-f170.google.com with SMTP id s7so1403828lbd.1
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sXrSLpjh4oMsSjJxkf/Jfequqz+v2InoSc+TOAaagDw=;
        b=PzbD3PMRycYHAZ6g75YzYwaXdZ3gH1d6QEt2doNeFv70cRYf19pdOxj0xjVnHmnwAg
         Nrlvx64+FqqEEO/CMW0GdmI6gWVqpCJYHD1zfl0zi9rT7tIqkHeSj3tJqF8HcUapBkZj
         hRYGZ3y+hESIx2PpwRMhgKpb9hlHXcgQN4YkBugef+IPFxHBQ2C/Rmy65JC/zgMPyLXW
         W6RqJOw9sMgfPsDgaRkm0idRBNBSkrmDcj0x5ookiHt3ZOzxTkssSKxOF7CHNO9/BlZr
         n+wBkZV9pSPWzqXUher7VRq1UdaLmmF0Kc+5hdwTeUphFWf7NGV7T0hntXixLUlintSC
         RPsw==
X-Gm-Message-State: ALoCoQmaEx30wJE5JjEvOXQ/bYGDW0aKjWW0nen3fViaXMzSG2r30tw7z97/VVO9bbQ6KVWsdbgP
X-Received: by 10.112.47.3 with SMTP id z3mr9101507lbm.34.1395387213210;
        Fri, 21 Mar 2014 00:33:33 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244654>

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-patchbomb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt-patchbomb b/guilt-patchbomb
index 1231418..164b10c 100755
--- a/guilt-patchbomb
+++ b/guilt-patchbomb
@@ -47,7 +47,7 @@ if [ $? -ne 0 ]; then
 fi
 
 # display the list of commits to be sent as patches
-git log --pretty=oneline "$r" | cut -c 1-8,41- | $pager
+git log --no-decorate --pretty=oneline "$r" | cut -c 1-8,41- | $pager
 
 _disp "Are these what you want to send? [Y/n] "
 read n
-- 
1.8.3.1
