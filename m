From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 14/23] contrib/subtree: Remove trailing slash from prefix parameter
Date: Sun, 10 Mar 2013 23:41:22 +0000
Message-ID: <1362958891-26941-15-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Herman van Rink <rink@initfour.nl>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Avery Pennarun" <apenwarr@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:45:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpvi-0004mR-Np
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457Ab3CJXo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:44:58 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:37415 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab3CJXo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:44:58 -0400
Received: by mail-we0-f170.google.com with SMTP id z53so3070282wey.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=7YIcr8kaZ9e7CFjjt2smYsH1D2K6lqni87F8ft61VZQ=;
        b=hy7iOYkfQvcLPlX1mGh+RJ8piZvIVNX4nz/dAxgzCWIOHAJKwJyzR0zRuj3yCzDPt8
         zZfwyjNTJ93kR87DehOSwaj9Q8zAPpE0hAJ3iDvdUyzXjHFUdn3KVt6f2e/jZvObUcDN
         RlGaEmRMUv0FhRIQfIl2aibImVGLqgspoONtOtVRW7rOQm2yYP54R4YCREpv5RK9ap3D
         E1OMRdTFdTPq/JbMDcwiStCPBvTJCeAfV6mA0X7JV4O3e3FgaLWyfxGVkTmH5Ai+PStQ
         RTdYh3pJxgC9zmhuBdzuHZ5lwykPsrc2FT4it/o37lAnixYzqfxqVyL2zcQdTy/quCst
         IYIw==
X-Received: by 10.194.57.137 with SMTP id i9mr15655773wjq.18.1362959096903;
        Sun, 10 Mar 2013 16:44:56 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.44.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:44:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQnXi42OFmitdjkwZwlcsEbPOIO8pDV8jQ9aN/qKT+Va3JrgRU6Shlz3KfbB8l1lHr0Qci/L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217834>

From: Herman van Rink <rink@initfour.nl>

Conflicts:
	git-subtree.sh

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index d67fe5a..ae7d1fe 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -103,6 +103,9 @@ while [ $# -gt 0 ]; do
 	esac
 done
 
+# Remove trailing slash
+prefix="${prefix%/}";
+
 command="$1"
 shift
 case "$command" in
-- 
1.8.2.rc1
