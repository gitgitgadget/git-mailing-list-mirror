From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 1/7] merge hook tests: fix missing '&&' in test
Date: Sat, 15 Mar 2014 22:42:24 +0100
Message-ID: <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 22:42:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOwLs-0001hA-1i
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 22:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563AbaCOVmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 17:42:40 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:57538 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbaCOVmj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 17:42:39 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so3386539wgg.30
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=5Dsy/LsiceENhtZRXZNs0XMJFNYr0R1QtsIEqbok/NM=;
        b=IFrB1gNJLvhHUYab5rZmm05GxmS7XLsBMaFqObMG/LBb6aQaLWa2N7Apmd/mn1H+7z
         L6MzGBA10gKgCD7cg9vw0fM9KlpQt9irc2ltC1YHh3bYYz8eT9hrQVrUC75mR5Pd9EGS
         l9yWBCUAK0zgjNYMeBPlEc9tu3BZS7oA2BSuovl905Kpm0/SZlx0N7Lw3hcqBrdSxGTO
         IBkwDsr1ueTWOd5rRqMZn7+drg9QBP1LRQ3KGxQMC68sPx7bDbW8I3lLK+cejoYA7M/G
         gajkOVSEAff+LJUAlkPj33GdnCmhp6eWYRXTKJhaHbSzIamHgo33JgI7+C5g5d5nAfFH
         5Pnw==
X-Received: by 10.180.20.176 with SMTP id o16mr3516027wie.7.1394919758670;
        Sat, 15 Mar 2014 14:42:38 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id f1sm16974185wik.1.2014.03.15.14.42.36
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Mar 2014 14:42:38 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244169>

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 t/t7505-prepare-commit-msg-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 3573751..1c95652 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -174,7 +174,7 @@ test_expect_success 'with failing hook (merge)' '
 	git add file &&
 	rm -f "$HOOK" &&
 	git commit -m other &&
-	write_script "$HOOK" <<-EOF
+	write_script "$HOOK" <<-EOF &&
 	exit 1
 	EOF
 	git checkout - &&
-- 
1.9.0
