Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A7D1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 10:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733264AbfKGKMz (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 05:12:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45507 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfKGKMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 05:12:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id h3so2267043wrx.12
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 02:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HKMu2SAWFmMMrshpdbVzIl06Y9+Vs1JQ460smvVZRKQ=;
        b=vf8un2l1GwVUshPfWLmcJcYYHTmVhJpNlR0vEbjJEtB3dtmyqROAFtUL5jLnnopO25
         iqqT4wufefBg10VLcxRAae90BZ/HXwiUqefjCQFMCj/AWv9so7CVuzmfjZkKR3jovPti
         DYAqX+ctzm3m1rJIABS+ClCf6GwfzSHq+/w158i03BT51tFIIns1ATUPs6K2PSGQynU8
         Swo+0NzfHCWSU4hU/PH9Rxx85Dd2ZcQWsXBwKVuaghX3InK/zfYD3dvLYLhnoaPV+UZB
         +849r+f3WpW5+uEUFGkNfktIECcdWit6Sy5yN0JH3iCWJgBUo8eVdi3FxH6SXqaHeyhI
         Tf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HKMu2SAWFmMMrshpdbVzIl06Y9+Vs1JQ460smvVZRKQ=;
        b=J//zK8NkeO7eF7T3hvLRZIJjXKM4Gd9dfedR6NMHytaWSu3YxGIdgdr1zIQr6EAbon
         9K9Df9MSfL3ll5tFAtJCcssumEmYZfymr9VLxQGo9kLsbNfH7CruBPnrHB6QTiPOVKfh
         SDhUhJLz7zQeHGarJ0IoWicyyNkWs2YXDxgoIe/5D+9pEAgTN29LFA2WdA2/HwDRU1w+
         +oQe//BC2cXzypWWhZGdQZKF2KAOCr21hJ4T+5L3MACeyFf5VsNmYpke04+NQeED08XU
         jnN629/tNRI241Rcj7skfFK8zscrxJKUzD4X0xETaEk6x8XiLiHsguC2xJtxskA//hwk
         ItWA==
X-Gm-Message-State: APjAAAVzSxB+6bpBgWNxAbVK03kyNEw8jAXEW6fLOWxjf8odDA5aNsSz
        Ew0qCxvQXnCRKuyq7aVwIK2CE37w
X-Google-Smtp-Source: APXvYqxYrLK23QjkGz90DBf0QCgrRc2CIteTnz9VHJ5SozXGokFyw3l+NJcxfMIRXcBb43p+8XLKEA==
X-Received: by 2002:adf:eed2:: with SMTP id a18mr2197294wrp.273.1573121572516;
        Thu, 07 Nov 2019 02:12:52 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([13.81.118.113])
        by smtp.gmail.com with ESMTPSA id f143sm2669485wme.40.2019.11.07.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 02:12:51 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] kset.h, tar.h: add missing header guard to prevent multiple inclusion
Date:   Thu,  7 Nov 2019 10:12:43 +0000
Message-Id: <20191107101243.99744-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.24.0.rc0.467.g566ccdd3e4.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing headers to prevent ill-effects from multiple inclusion.

Found by the LGTM source code analyzer.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 kwset.h | 4 ++++
 tar.h   | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/kwset.h b/kwset.h
index df99a92178..f50ecae573 100644
--- a/kwset.h
+++ b/kwset.h
@@ -1,3 +1,6 @@
+#ifndef KWSET_H
+#define KWSET_H
+
 /* This file has been copied from commit e7ac713d^ in the GNU grep git
  * repository. A few small changes have been made to adapt the code to
  * Git.
@@ -59,3 +62,4 @@ size_t kwsexec(kwset_t, char const *, size_t, struct kwsmatch *);
 /* Deallocate the given keyword set and all its associated storage. */
 void kwsfree(kwset_t);
 
+#endif /* KWSET_H */
diff --git a/tar.h b/tar.h
index 3467705e9b..6b258c4d4a 100644
--- a/tar.h
+++ b/tar.h
@@ -1,3 +1,6 @@
+#ifndef TAR_H
+#define TAR_H
+
 #define TYPEFLAG_AUTO		'\0'
 #define TYPEFLAG_REG		'0'
 #define TYPEFLAG_LNK		'2'
@@ -23,3 +26,5 @@ struct ustar_header {
 	char devminor[8];	/* 337 */
 	char prefix[155];	/* 345 */
 };
+
+#endif /* TAR_H */
-- 
2.24.0.rc0.467.g566ccdd3e4.dirty

