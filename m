From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 1/7] merge hook tests: fix missing '&&' in test
Date: Mon, 10 Mar 2014 19:49:31 +0100
Message-ID: <1394477377-10994-2-git-send-email-benoit.pierre@gmail.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 19:50:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5HB-0005To-N2
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 19:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbaCJStt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 14:49:49 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:55491 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbaCJStr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 14:49:47 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so9193692wes.15
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=5Dsy/LsiceENhtZRXZNs0XMJFNYr0R1QtsIEqbok/NM=;
        b=0eXjzjTgWivNav7PS0BcNIbveFKY6m8JBPQJJl4kPuBd4VzsrdJ4zV1/vk/SX2L5XE
         2ztLB+jkaWaAh1y3j0752+ddfjH9m94asr10wHc02IRYUR+wJ4H/q+EQYCyKTKhkPZQK
         jjRUv1ggR8HMcPEc9nEjndTVSf6U5r6IV5HaDqwek19XQvJ+gHtsF9b94+EPzOkuK7Ml
         Ph3XCisO0en6rrFU30P2e1l+tJqL+n9mo3F46CWXNUL8ZSZE/rolXfjpA+MrYFKZxW8w
         0dNiOZXvdH8adFEizahdzl4QFwHCYeQTIXSZIEjMUT2v40EYKbqHup4CNGsfrq5KtRGz
         WtQQ==
X-Received: by 10.194.91.232 with SMTP id ch8mr32914868wjb.13.1394477386824;
        Mon, 10 Mar 2014 11:49:46 -0700 (PDT)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id q15sm54373463wjw.18.2014.03.10.11.49.45
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2014 11:49:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.7.gca5104e.dirty
In-Reply-To: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243786>

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
