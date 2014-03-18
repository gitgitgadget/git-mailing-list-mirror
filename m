From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 1/7] merge hook tests: fix missing '&&' in test
Date: Tue, 18 Mar 2014 11:00:50 +0100
Message-ID: <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
References: <xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 11:01:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPqpo-0003bw-1Q
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 11:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbaCRKBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 06:01:19 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:57899 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbaCRKBT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 06:01:19 -0400
Received: by mail-wg0-f52.google.com with SMTP id k14so5598624wgh.11
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=5Dsy/LsiceENhtZRXZNs0XMJFNYr0R1QtsIEqbok/NM=;
        b=ZZ8CzAEPGkNdpSbMyt4q4eggVVE5PxAv61kzwQs7rha06hmqHxiRhwkVV+QP5f6Dex
         cVWFSQQLfcQdZry5OcQFQa99VNpIbT4OjJEZMwP80lCoABIgPdBcHs2nj6LtBpYSyFXO
         kJQDcKuul8NX2wSgTJiXvkg31hhY0FIZtbYFH7Zqpk/YcGnf1bf2mEYIUing/IVfa7k+
         t1uKtdJUnjlDerBbfLAMpr1xXI4QSoAAa4UcX22xHsGDIxuPA/Vg2CiXWfCGRwoNVczm
         1bQo3I2LIhUnjSsE0Z3Itj9lYoeD2Rf6y4j/DGGIvFO/RKJW27UjTpkT/rmRJ5LZaywN
         InJA==
X-Received: by 10.180.72.136 with SMTP id d8mr13914387wiv.44.1395136878133;
        Tue, 18 Mar 2014 03:01:18 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id dk9sm45847880wjb.4.2014.03.18.03.01.16
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Mar 2014 03:01:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244341>

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
