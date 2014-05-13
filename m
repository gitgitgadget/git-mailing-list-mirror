From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 22/29] The log.decorate setting should not influence patchbomb.
Date: Tue, 13 May 2014 22:30:58 +0200
Message-ID: <1400013065-27919-23-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:37:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJSI-0007x1-UD
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbaEMUhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:37:38 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:42819 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755AbaEMUhb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:37:31 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so706492lbd.26
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BGFtS/v/hn8VdV5YbCEUDzOVeaiEXuWkjmC88TF8FGc=;
        b=iA7glxboEhBa191sDHxHat8RALB2cHfQljURNCm9irX4N6GHHrUXqBikCmsSHz0t5N
         DFVJSAXnlVFOvShOqqlg/epDEBS9n1yMstEfw4XBJqsx06IxQJp1LE57Xy6S8tTmOZ2e
         EhvszANp9iIiXSP5Twn84WAGR0xKQ0KRxNeakwJIs5gPsfuiWuBh0NCCeRt6BH07i+QT
         DrOHAIqRgyQ8OWldUQCY2Vi9aba+yGncNPcozgYq3uZ82I7iC5/J4X7xS5o9i5T3FGsm
         G5TghjyOfJgOnWRMPg5JZu3mzORu9N9/e2/s5e9j2MYGt8X43X3xMmluBLA9CM0jGysn
         5j9A==
X-Gm-Message-State: ALoCoQmtdbzMvYBLBuqRspvCgWtmRZX3a1AFYfhWFz27tb/7Du0MLOQrSZizc6NL+bzw8j8iAWkp
X-Received: by 10.152.2.2 with SMTP id 2mr19432069laq.26.1400013450643;
        Tue, 13 May 2014 13:37:30 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.37.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:37:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248839>

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
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
