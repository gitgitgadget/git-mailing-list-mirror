Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DE5C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 13:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhLUNPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLUNPD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 08:15:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F341C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 05:15:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id b73so9066765wmd.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 05:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/8J+5eIgCFluyYm1/xoqtwdv0FwcWLtmyUXWwbakfJA=;
        b=IMftz2ZMO0S+IgEfkqULHbGHS+Bf0jsoY9VlbBKUvcyJNkXr9N/tdBHNukbcu22FY3
         +ehSsoQug6NsLHEfJZZnkmATn5Zn1h/dvlJgNaRpYs2U3o1dBbTo59EDjUvztT+T35wu
         ftXe3rhXEHCcx0ifducEfZ1DJ3jzxFpw7rPZ5m2PD3NkPyBVRreSRqCfxtqtAXmZdHHo
         NK8vwV7RLVdP5vAJMTmEaohAQU0vQi6BvqtpFGsuy1z/gbjZyFL84u0eDg9id6nurV86
         nFCng4HZ5aPnlGMUMSoI7j4pPSa1YrSpq8Lgi59JW0+Caldq63tZ/bcHNqbGOy4bPNWv
         p6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/8J+5eIgCFluyYm1/xoqtwdv0FwcWLtmyUXWwbakfJA=;
        b=mztoPsLL9ZQVExfVjQNXoPXmKoegfgfkMqziif+cjz1pjBjc7losSu5ioRzAreGQgx
         gNOsLS+Hw5c7iPl6adDOTb/C8L0yGNSSTcc2I4ofdJQEurOxxB6TlYdo8liQTGKOuk3u
         GdOZO5TonbymITG6jqleu9ne6dYpDt6HVGHF7UBL6kPHxXn1SB2xgbiGMJ7H4BqcpevT
         Jg1AjPIfgiGIv/ehkwR9UIPlCDJAGoANpirPCvCNPGxRilxIori+xj4NVcCil54poq93
         8IBjfVMBUuJnZCdlLenCJOTCJApmof/nYQtUmih7Z/a75Cph4VxRaIslYaoZVs5qLHlF
         U03Q==
X-Gm-Message-State: AOAM531WJyd0TM/6EKlpAyE9kTahQBnxY2gnQn41pI22pro5sWRpfIH/
        CWsigf7GlBQjvSoQD8AkhlfReCMhBgg=
X-Google-Smtp-Source: ABdhPJwe7G4lUh1rD3uX236T4OMmQgxRkEnvQtvL1Xhz8h/CzDGtA/8WpbKZ0twgIU4FVnRRD/SMEQ==
X-Received: by 2002:a1c:7e41:: with SMTP id z62mr2810140wmc.62.1640092501598;
        Tue, 21 Dec 2021 05:15:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm2622042wmq.27.2021.12.21.05.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 05:15:01 -0800 (PST)
Message-Id: <pull.1167.git.git.1640092500725.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 13:15:00 +0000
Subject: [PATCH] test-ref-store: print hash algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This provides a better error message in case SHA256 was inadvertently switched
on through the environment.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    test-ref-store: print hash algorithm
    
    This provides a better error message in case SHA256 was inadvertently
    switched on through the environment.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1167%2Fhanwen%2Frefstore-print-hash-algo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1167/hanwen/refstore-print-hash-algo-v1
Pull-Request: https://github.com/git/git/pull/1167

 t/helper/test-ref-store.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 24dd4bec08c..3e4ddaee705 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -269,7 +269,7 @@ static int cmd_delete_ref(struct ref_store *refs, const char **argv)
 	struct object_id old_oid;
 
 	if (get_oid_hex(sha1_buf, &old_oid))
-		die("not sha-1");
+		die("cannot parse %s as %s", sha1_buf, the_hash_algo->name);
 
 	return refs_delete_ref(refs, msg, refname, &old_oid, flags);
 }
@@ -284,9 +284,10 @@ static int cmd_update_ref(struct ref_store *refs, const char **argv)
 	struct object_id old_oid;
 	struct object_id new_oid;
 
-	if (get_oid_hex(old_sha1_buf, &old_oid) ||
-	    get_oid_hex(new_sha1_buf, &new_oid))
-		die("not sha-1");
+	if (get_oid_hex(old_sha1_buf, &old_oid))
+		die("cannot parse %s as %s", old_sha1_buf, the_hash_algo->name);
+	if (get_oid_hex(new_sha1_buf, &new_oid))
+		die("cannot parse %s as %s", new_sha1_buf, the_hash_algo->name);
 
 	return refs_update_ref(refs, msg, refname,
 			       &new_oid, &old_oid,

base-commit: 69a9c10c95e28df457e33b3c7400b16caf2e2962
-- 
gitgitgadget
