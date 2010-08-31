From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] maint-reflog-beyond-horizon: fix broken test_must_fail calls
Date: Wed,  1 Sep 2010 00:49:19 +1000
Message-ID: <1283266160-11665-2-git-send-email-jon.seymour@gmail.com>
References: <1283266160-11665-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 16:49:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqS99-0007VP-C1
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 16:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509Ab0HaOtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 10:49:06 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43669 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757431Ab0HaOtE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 10:49:04 -0400
Received: by pwi3 with SMTP id 3so384996pwi.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=u2lRMk8t3QCW/2Ct9/iWIb5hqx95CE1QYNVnVIK6iKU=;
        b=bo+pSDPpzYNWDrS3+gN+3jOsBfb2KXlaxAU53gTvkiUEJZNR+yG2/ZKGSF3HC52kkm
         HoCEnNddeOAwwdn0m6Uazdz6s9dj+kGlJlBTaGtIa4GLyd/Gf5Bg361n9ooMR4IyWsQR
         RuW43fqDuo2m6MN2+5qGBh+YK8eqhqNHta2Mg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Nt72wcPadJIE9cRaxPommVg2E0+WY2vuZdsKE7t/MWwq1kGztbPymy2r1fG4Sltw7/
         uRc7DXmwFeEVn0LIUuoZ72zL6JzSZQHLxRrysu7eqH6m3Elqqfn8x6sSMH/i/L0RB15A
         mZSVbvJ4h7ngFREwV2Qtb1g+lC8Vyo8p6kC/I=
Received: by 10.114.173.5 with SMTP id v5mr7054454wae.79.1283266143566;
        Tue, 31 Aug 2010 07:49:03 -0700 (PDT)
Received: from localhost.localdomain (124-169-135-9.dyn.iinet.net.au [124.169.135.9])
        by mx.google.com with ESMTPS id d39sm16562703wam.16.2010.08.31.07.49.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 07:49:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.82.g9d57.dirty
In-Reply-To: <1283266160-11665-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154903>

Some tests in maint-reflog-beyond-horizon are calling test_must_fail
in such a way that the arguments to test_must_fail do, indeed, fail
but not in the manner expected by the test.

This patch removes the unnecessary and unhelpful double quotes.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t1503-rev-parse-verify.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 61092f7..100f857 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -111,8 +111,8 @@ test_expect_success 'master@{n} for various n' '
 	git rev-parse --verify master@{0} &&
 	git rev-parse --verify master@{1} &&
 	git rev-parse --verify master@{$Nm1} &&
-	test_must_fail "git rev-parse --verify master@{$N}" &&
-	test_must_fail "git rev-parse --verify master@{$Np1}"
+	test_must_fail git rev-parse --verify master@{$N} &&
+	test_must_fail git rev-parse --verify master@{$Np1}
 '
 
 test_done
-- 
1.7.2.80.g22196.dirty
