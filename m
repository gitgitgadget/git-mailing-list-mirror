From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 01/31] The tests should not fail if guilt.diffstat is set.
Date: Fri, 16 May 2014 16:45:48 +0200
Message-ID: <1400251578-17221-2-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:47:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJQ3-00067l-2u
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757294AbaEPOr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:47:26 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:33620 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595AbaEPOr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:47:26 -0400
Received: by mail-la0-f49.google.com with SMTP id pv20so2020741lab.36
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JzbjURFy5BMMZ9rm36V2RVmnDkwrxFEWphZOHeZQyEc=;
        b=iWDwvKAzbedSeiPcpzNYFUCjrd9LR4qEWNOStkcJkk02Ig+mJT6bomwxgEhBAjX+0a
         /pTZ7FNeHfimM2PgJFPtEJ4fq0uPV+PXGtIwAv3ea5m37mbU5b/esWjXqFYaIavqoZlL
         P6YEG87U6+xhrnwutLzPnTc9fN64zRypz7Ps9gKRWO6s2bsxuUwiIrUzm7eIrw7GU2/R
         0Ez0iLpeJwrmNTtnCNdfDuZ1mag9BODNHGETYvilo9EIroWuqmpdRQvpLO3nV2njMdJ5
         RF35lqemkA5v0r78AwdHDPbDfyl/2obToC75BC3I+QDQ02ji3gLNNfvScBSWZrmoK6SA
         1Pdw==
X-Gm-Message-State: ALoCoQnPk/dEdRwek4Uw3Ag0dZesvo6JBxz8zdp6lCQ/ZfkKnYjihaXsfagrIJbQ5KVwU8W5cKHY
X-Received: by 10.112.120.207 with SMTP id le15mr6700465lbb.45.1400251644743;
        Fri, 16 May 2014 07:47:24 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.47.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:47:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249310>

Explicitly set guilt.diffstat to its default value.  Without this, the
027 test (and possibly others) fail if guilt.diffstat is set to true
in ~/.gitconfig.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 regression/scaffold | 1 +
 1 file changed, 1 insertion(+)

diff --git a/regression/scaffold b/regression/scaffold
index 546d8c6..5c8b73e 100644
--- a/regression/scaffold
+++ b/regression/scaffold
@@ -87,6 +87,7 @@ function setup_git_repo
 	# Explicitly set config that the tests rely on.
 	git config log.date default
 	git config log.decorate no
+	git config guilt.diffstat false
 }
 
 function setup_guilt_repo
-- 
1.8.3.1
