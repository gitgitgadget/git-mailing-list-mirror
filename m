From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 23/31] The log.decorate setting should not influence guilt rebase.
Date: Fri, 16 May 2014 16:46:10 +0200
Message-ID: <1400251578-17221-24-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:55:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJXw-0000wo-3i
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbaEPOzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:55:35 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:47803 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390AbaEPOze (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:55:34 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so2057854lab.17
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bGZ216pKC3s1i9gVKKxXD7BufyF0e3hfa2Xe1vxkqTA=;
        b=j699BoJVBH1rtNw2o2Ub/QFIasZjUov9n21mdp6whw0NaoZqBP4QtcEyXCkOogqlhk
         Y9IeEnWfJmMicxmyiLTg+zx/HcVlOox8tC46HiXDSIMqCS54vRD/4UxbaM14jX9fcWOO
         49II1Fnf7q1T8tK2RBK6YmOc1a8rky394Y54y+7a0cwWNrjiRmG0d0rt2RTMPp9VEkh/
         t8s05bChD5UtvXCemEeWpvzw/hQycvC+fCS+KfJwHMQDbAXLR7m84yzE0uydg0yWES0v
         X+kjjDWb2AO2cLxZ2iy31K1flOf+5Aqlfg9dXGISd2pOFnPuJP0e3dv89xc+meXpvAI0
         UAFQ==
X-Gm-Message-State: ALoCoQl2RXdlOgS4qV+kzENU5Nxf14JABXIkS4va4isBcvQQX/2yUHdpP4AIjd1Vw3xGTJmHLx+i
X-Received: by 10.152.28.134 with SMTP id b6mr192340lah.87.1400252132988;
        Fri, 16 May 2014 07:55:32 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.55.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:55:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249332>

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt-rebase | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt-rebase b/guilt-rebase
index fd28e48..a1714a0 100755
--- a/guilt-rebase
+++ b/guilt-rebase
@@ -66,7 +66,7 @@ pop_all_patches
 git merge --no-commit $upstream > /dev/null 2> /dev/null
 
 disp ""
-log=`git log -1 --pretty=oneline`
+log=`git log -1 --no-decorate --pretty=oneline`
 disp "HEAD is now at `echo $log | cut -c 1-7`... `echo "$log" | cut -c 41-`"
 
 #
-- 
1.8.3.1
