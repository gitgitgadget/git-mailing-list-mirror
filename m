From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 22/31] The log.decorate setting should not influence patchbomb.
Date: Fri, 16 May 2014 16:46:09 +0200
Message-ID: <1400251578-17221-23-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:55:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJXj-0000Kn-MQ
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbaEPOzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:55:20 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:60842 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbaEPOzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:55:16 -0400
Received: by mail-la0-f47.google.com with SMTP id pn19so2052128lab.34
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BGFtS/v/hn8VdV5YbCEUDzOVeaiEXuWkjmC88TF8FGc=;
        b=K8X/9iiUEjIDn7yy1MBqcgKISnMSPmCKn0BPu01haL9oFBqqDO8AaZUcobIlAKm4Dg
         UIGMMd7d+OnBmGVlWGXZDmhXZIAvxQi1cK7yKDe9zLSftgcAU1sds8RSrA25kZQAFt0f
         PcoPyO1+0NVZaPw1s9yDI/KNhoY75AMEplOEspjm2E0iXyp+C5BBZKoi7QzdbSP2Mm0K
         va2va0zIBeHmpq/r74xSN46gDTvwljjIkPe3hZXoVFREVavE17fwMYJ53gw3ZtZCJBGb
         cyZKYDzx/nTALOOplUZJZYRkdhJv/zw9W4DU3+H8GnWUOL6qOw5UXls4fw9qUygcg1bY
         lptw==
X-Gm-Message-State: ALoCoQkhkbwelNRJB/anI+/SjoKO1LigWRiZnS2hPQaXZvLkEPPlKCle58AUPezs0oavxaNXmt73
X-Received: by 10.152.170.193 with SMTP id ao1mr12551953lac.27.1400252115564;
        Fri, 16 May 2014 07:55:15 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.55.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:55:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249331>

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
