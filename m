From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 05/16] t4202 (log): Replace '<git-command> || :' with test_might_fail
Date: Sat, 25 Sep 2010 13:06:56 -0600
Message-ID: <1285441627-28233-6-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:06:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza4r-0005Xq-18
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab0IYTFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:05:38 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41285 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0IYTFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:36 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so931665pvg.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=raIG0hjEehe6SP7nltJRB6C8jz3e+gdZwlY9olZA3nU=;
        b=Tb1X5UxiWYJB/5MUzzDaD2w05qx7DeTlQQU62zmDcWBo42BGsIxPmEkvHHhC8Wghs5
         rAiv1M6HYGCM+nt9uVXzkgriBCzQFCp2D2CO6PXkdDcaWRq4LhGh/At1X1a5SaWqqESg
         UwPyCCsRHyQ8iD36zYEZVKybTzeEsB2rzF3gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l9bSmKVQVM6XNKZBenMQ2X5+V7p8JpGyVsFL8pOjAA9Py8gQ+7Rqq4oPkaIhDC10vp
         kkd62twJhU3fZ1Y8W26WXPGmbZrsLFctZ85wWvIdFDxtrhuWvS1tqJwBDnmwDAE2cy5f
         kDHA2ixIxrZsp6K7PQ6+zmAF1qENAzu+FSqMo=
Received: by 10.114.88.17 with SMTP id l17mr5653364wab.145.1285441536446;
        Sat, 25 Sep 2010 12:05:36 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.34
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157185>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4202-log.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2e51356..1172e45 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -393,7 +393,7 @@ test_expect_success 'log --graph with merge' '
 '
 
 test_expect_success 'log.decorate configuration' '
-	git config --unset-all log.decorate || :
+	test_might_fail git config --unset-all log.decorate &&
 
 	git log --oneline >expect.none &&
 	git log --oneline --decorate >expect.short &&
-- 
1.7.3.95.g14291
