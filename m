From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] Add known breakage for 'git notes copy'
Date: Mon, 28 Jun 2010 09:01:57 +0200
Message-ID: <41768aafce7a581e8b601e70826ce77381458a23.1277708369.git.bert.wesarg@googlemail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 28 09:02:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OT8MX-0004Bm-F5
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 09:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038Ab0F1HCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 03:02:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58578 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0F1HCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 03:02:31 -0400
Received: by fxm14 with SMTP id 14so391530fxm.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=yId4OYr2KHpDhjV9KjPIvBN3/e0kucenAvSKmBKX3NY=;
        b=sWkRL8OVZn3Pm/sMVAO/unjISR8zJAqCqi84Lb+wvVCaSkuxxeqkqxMqDRWU4Zn5oe
         8j2Yo0IcDq2xK6jWWXi4VQMChGINCgpDDgguZUYjQEJuDSOQ6aozte0+mRtCkmlXcfOM
         4jl0ch2OouugrLH/S88mcI524OFK4T23wIRGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hDcieqpnGEmtn14gGCaW8sHQc6lMMG8VaKOjx3j8/Xy/tABNd1Tg6HAADjrUgToo9E
         duxvgRnBRQ1+4t0ThTBsb1593no+OVdb0h2VUfhLw/sjaisZB/A1Rjkb4cz/83mfOHol
         1LaQwEpUVzfSdxMd61VACXK5mN6ppr4UQu7YY=
Received: by 10.223.17.136 with SMTP id s8mr3409730faa.41.1277708525318;
        Mon, 28 Jun 2010 00:02:05 -0700 (PDT)
Received: from localhost ([92.116.110.254])
        by mx.google.com with ESMTPS id e10sm44671603fak.14.2010.06.28.00.02.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 00:02:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149814>

'git notes copy' dumps core when no arguments are given.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 t/t3301-notes.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 64f32ad..67b0cc2 100755 t/t3301-notes.sh
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1044,4 +1044,9 @@ test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
 	git log -1 > output &&
 	test_cmp expect output
 '
+
+test_expect_failure 'git notes copy segfaults' '
+	git notes copy
+'
+
 test_done
-- 
1.7.1.1067.g5aeb7
