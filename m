From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 01/29] The tests should not fail if guilt.diffstat is set.
Date: Tue, 13 May 2014 22:30:37 +0200
Message-ID: <1400013065-27919-2-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:32:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJMw-0007Lf-Iq
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbaEMUcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:32:06 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34861 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbaEMUcF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:32:05 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so710666lbi.29
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JzbjURFy5BMMZ9rm36V2RVmnDkwrxFEWphZOHeZQyEc=;
        b=euHfDSrzbWgTe6TOjxQz6p7zqhHBgUfe6bGclBKxrSEm7jGecEJ87BKG7z8mrlrwfS
         7HVyWB+SMy6BIHmlU9h6IHei2jRhXNF5DI+X5A1bzJU4VkHl+pUMqAJ26gks+lGkyHUL
         YeYgbnzt1FAF45rQJrzgdX868cA33yfHR7gpGGeOz0+lWTSfBts7RCE+EI77NYz5bbuW
         kWOhj6ADyfZsCacLgzLGGulg0XOnwQjLjNB/baKoBGV0G712vZ2/q2djJGH29sExDHQS
         EUnkdPv7vQHB+lLXPC7xwVxQ+wDcGbQMBxIp83yqxdZQQZcZVWzfUzA/D5g9mg9eAzJV
         KxLQ==
X-Gm-Message-State: ALoCoQkxanUuJHa4pEPFCsHH8IBcfBHqWaWgRUqwXy7uEHMgSj46gM70UxqFj3hx9vYrkxxEWOgS
X-Received: by 10.152.28.166 with SMTP id c6mr3096962lah.51.1400013122971;
        Tue, 13 May 2014 13:32:02 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.32.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:32:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248816>

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
