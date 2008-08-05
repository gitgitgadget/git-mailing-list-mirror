Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 25071 invoked by uid 111); 5 Aug 2008 19:13:46 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 05 Aug 2008 15:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbYHETNg (ORCPT <rfc822;peff@peff.net>);
	Tue, 5 Aug 2008 15:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbYHETNg
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 15:13:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:54347 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbYHETNf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 15:13:35 -0400
Received: by ug-out-1314.google.com with SMTP id h2so114128ugf.16
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 12:13:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=5tAKKg5PeGIZ2+hmddrdK4YBvwTu7fQdh/URp4iCk2Y=;
        b=saIYfPfOu4GbLY6Yov9cpHuimTZcWXw0sJvjqZ2bHOmUZULEgWtM8UIXWPyv0Yl5+Z
         70RM0QDx5A0Dk60GH0vZHNOZRyQN1eP/mcd7Tx0sOkNyzv7xmJYsE8KmMyLM2NLXM5h2
         HmQ/jWfv2OsiRMnj6YJ4ZdS9dKJn8QvLgUsFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bVy6RPKwy9BfKsohss77sI2lAnX5W8ZoNrxtI/K2UuKB+WptraJmh/b3lpznXw4Kb0
         qEps4Pbnecwn/2RNWGQFZTQDTyY9GVqDk/ivcmJ/1gEXfGRKFgvVAHAziyY7K9eHh/MA
         nFLgde1AwglMnv0eZG4nQTP3ixVd/hHmskvAQ=
Received: by 10.67.115.5 with SMTP id s5mr7274225ugm.63.1217963614077;
        Tue, 05 Aug 2008 12:13:34 -0700 (PDT)
Received: from localhost ( [217.234.105.117])
        by mx.google.com with ESMTPS id q40sm2246144ugc.23.2008.08.05.12.13.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Aug 2008 12:13:33 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Subject: [TopGit PATCH 1/2] Fix generated Subject: line in .topmsg
Date:	Tue,  5 Aug 2008 21:13:29 +0200
Message-Id: <1217963610-15195-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.5.5.GIT
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

$1 is unset after parsing all arguments, so use $name instead.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-create.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg-create.sh b/tg-create.sh
index d196e4f..0bf329c 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -107,7 +107,7 @@ author_addr="${author%> *}>"
 	! header="$(git config topgit.to)" || echo "To: $header"
 	! header="$(git config topgit.cc)" || echo "Cc: $header"
 	! header="$(git config topgit.bcc)" || echo "Bcc: $header"
-	echo "Subject: [PATCH] $1"
+	echo "Subject: [PATCH] $name"
 	echo
 	cat <<EOT
 <patch description>
-- 
tg: (24367cc..) t/fix-subject-line-in-.topmsg (depends on: master)
