From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/4] t/push-default: remove redundant test_config lines
Date: Sun,  9 Jun 2013 22:43:17 +0530
Message-ID: <1370798000-2358-2-git-send-email-artagnon@gmail.com>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:15:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljDK-0001pk-6a
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab3FIRP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:15:27 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39289 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab3FIRPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:15:25 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so489587pdi.27
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=t5NSilP4v4smSq9LWVLfc/aRgbE5y9/nRTKXZH0nW5M=;
        b=ku77UN2vQZbYaCZZiQ2GbVOGBESePNFTsEjXuju6ChB1MzxpQPELLEkreq2Y0fr/dS
         BQ/BtoOjyLllz9QiiBhZpZghKsMyKQI2TET+P3aZ/FHu1sGARC4vW9/0jtKyiarX2AeI
         wI1QmMHY5REnRKtBXP+UpObgt57xwnGyM78U6wt1PGe/Vfk5k3wKFleLDsJOkmYxR+1q
         80EN+5tLGSEBkhHl/X8QUNPza3qfd86CRX73lchKoP9gFMoSe7tjHjo8z6VzfGaAwawD
         QSvTBiSSKOMIT6Ui3TAFXIQJQHDLvKHijBlG3yBkrHFikuahfy2PUbqUBbFk9FiVmM9p
         vhBA==
X-Received: by 10.66.150.226 with SMTP id ul2mr10900078pab.17.1370798124940;
        Sun, 09 Jun 2013 10:15:24 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id rn7sm7235373pbc.12.2013.06.09.10.15.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:15:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227029>

The line

  test_config push.default upstream

appears unnecessarily in two tests, as the final test_push_failure sets
push.default before pushing anyway.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5528-push-default.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 4736da8..69ce6bf 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -48,7 +48,6 @@ test_expect_success '"upstream" pushes to configured upstream' '
 test_expect_success '"upstream" does not push on unconfigured remote' '
 	git checkout master &&
 	test_unconfig branch.master.remote &&
-	test_config push.default upstream &&
 	test_commit three &&
 	test_push_failure upstream
 '
@@ -57,7 +56,6 @@ test_expect_success '"upstream" does not push on unconfigured branch' '
 	git checkout master &&
 	test_config branch.master.remote parent1 &&
 	test_unconfig branch.master.merge &&
-	test_config push.default upstream
 	test_commit four &&
 	test_push_failure upstream
 '
-- 
1.8.3.247.g485169c
