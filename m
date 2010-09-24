From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 06/16] t4202 (log): Replace '<git-command> || :' with test_might_fail
Date: Fri, 24 Sep 2010 16:22:46 -0600
Message-ID: <1285366976-22216-7-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGel-0000n6-PL
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758262Ab0IXWVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:30 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47646 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0IXWV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:29 -0400
Received: by gwj17 with SMTP id 17so1126701gwj.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=raIG0hjEehe6SP7nltJRB6C8jz3e+gdZwlY9olZA3nU=;
        b=LeB3IBBMu4i4v0BDWVz7Ng1OdJ0ODSsngLqo+k4BwF65qRHJj6sg2rhzBqcZVrtdlp
         uLcaLs+lODi4tFu3sDiIGPR5YQZ3fxQiYs7mxiXogS6yGt9/Z4KImiUyjbOCRuLJ75j5
         xLhUEss8Jyc1A0CbWO4AhPAar4Zk+q98BXM7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oGYiCLkDjn3WAjw0IDbab8FRuIT14N/ARLtOM4a5EpfkI7bLCq11c/L+7sgIeyFUDX
         0OAqKqUaYHHq70yJo2xNC47Ktt0pLbbNLDnqm7aG1uVJByPAeZfuTl8TfyClArVpmf8s
         m/lYKA3b07IMEjW81bW4rMNAxOx5EMF63qHVs=
Received: by 10.220.124.28 with SMTP id s28mr1361886vcr.278.1285366888478;
        Fri, 24 Sep 2010 15:21:28 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.26
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157076>


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
