From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 01/33] The tests should not fail if guilt.diffstat is set.
Date: Sun, 18 May 2014 23:59:37 +0200
Message-ID: <1400450409-30998-2-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:03:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9Aa-0004ML-Tp
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbaERWCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:02:50 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:55942 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbaERWCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:02:49 -0400
Received: by mail-lb0-f178.google.com with SMTP id w7so3457405lbi.9
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JzbjURFy5BMMZ9rm36V2RVmnDkwrxFEWphZOHeZQyEc=;
        b=E8ZVyep13PzzyEjOgyxedu1fPpHDZxXBFFwkKirOcD4YM2l7BfljYpW4HuaxbC7Obu
         ZEPPi38MJ5YGCqjDXa3H4dOv9Rq2/WJjs62Vd06HW0gbWeOaR3VTxpZbVf35u3J2Scyz
         Oq4HrWi4bsdaiwJggQrLs2gPzOHW49qEePzAkuyT7IFOHx88vZZOASRpPAbCr/yUVsYZ
         HZV8XGU99rs6uWnVtdTxWPkx1qwE4UZA6N6NP1spDSQ0AF73BQ0WD4vh0FcjuvlEA5bI
         XWtWmZtE3kyXpT6AoE9Za2Vi/6FqKxY1c1e4vLRNBoOIg4OzRoMm/EOlGuSOe3PXtNdC
         JIJA==
X-Gm-Message-State: ALoCoQki/lMsa/VcPiq+tpwucvKi3bkwvnvSfZ+8TtJ+5k1U4at0iVrbnMy8LSJ+tris9mtG6bfK
X-Received: by 10.112.41.101 with SMTP id e5mr12447348lbl.46.1400450567683;
        Sun, 18 May 2014 15:02:47 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.02.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:02:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249516>

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
