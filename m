Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3375C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 09:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354132AbiBHJYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 04:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354194AbiBHJYN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 04:24:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D638C03FEC9
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 01:24:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y15-20020a17090a474f00b001b88562650aso1232890pjg.0
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 01:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQqXniUSNVUyA5+VA/2Z8IKRZtt9hgRaI2RR0yZtk7I=;
        b=TiyRCMuLsY4H4ISM77EMjD6PMsxCsCCeusRQaX/CjdpzDWz0lVkTHJcOZCXvvvUJ1C
         09uSTw8sufRwaH1Q2fklUGH9RwlfgmAmuYFcGmI/KZ3K860VT+R7aF5Lg+FwI6k4ng+/
         W9b6iQb4TlWkQHhTcSIzdBAQa+/wRmEzxUddRKkHVqTJUc/UoAU+509PNeGsIIy4+DiG
         GZ8+dQsO4MlGwT7qfwlf+2KKGzyM9TB4RFZN+jhKTUNGkcwDrOF3uMHTDbSfyPhp1CiS
         5HWED+1KCvesCKh2Evhax+tuFW1qIwHhHnmIvtOluDPhzvCfwvrekil8iJ/VtB4nyt2w
         vXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQqXniUSNVUyA5+VA/2Z8IKRZtt9hgRaI2RR0yZtk7I=;
        b=rm4XOWvHhdXEvJcfSQtzAXONvdMFxGXYiQXgd32NOKJwb4tVOmnJ1XBsMex0VSZwyU
         HzrUouyEWOxNKPo44auSBegxEs2/+EwtJzW+8+u/co6ZyKFsWlod4onUGVTPLsNculS7
         vJppVu0qzW36iEadr60ojhOlk7GQbo/nOKjuJQMz1v8Ljus0tKbO4vyDauPIS6cAsKhd
         cPQmDfDW0vE491GQZOJhJ4lQrDadmqMVppX+ALZ1Qt5W2hLBD7NrQj1B+RtnEAJ6Ww7/
         lhPQDdNnWmVEcbNEVUKUvQFrHv6ty2jm5GH5v1ZS2uJAatCRhu8YmvI1dQzt17/1qaQu
         26kQ==
X-Gm-Message-State: AOAM532o1PKxl2hPC8sUVAHdemQWyICFUcYjNb0dO+ml2TNVIw/wYMGB
        iAJ09GrgrV32WL5g1YhrivB3DCTdwv2EllpR
X-Google-Smtp-Source: ABdhPJz+cb+qEVzXxQoHAPcvofG0Kl8rHJ4shKwjlnZoPfkiSQpIju8ltdodLgbGo99BwejYSTTPcA==
X-Received: by 2002:a17:903:32cb:: with SMTP id i11mr3668131plr.37.1644312251784;
        Tue, 08 Feb 2022 01:24:11 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id e8sm2074173pja.9.2022.02.08.01.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 01:24:11 -0800 (PST)
From:   Jaydeep P Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
Cc:     Jaydeep Das <jaydeepjd.8914@gmail.com>
Subject: [PATCH] t/t0015-hash.sh: removed unnecessary '\' at line end
Date:   Tue,  8 Feb 2022 14:53:39 +0530
Message-Id: <20220208092339.651761-2-jaydeepjd.8914@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208092339.651761-1-jaydeepjd.8914@gmail.com>
References: <20220208092339.651761-1-jaydeepjd.8914@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jaydeep Das <jaydeepjd.8914@gmail.com>

The `|` at line end already imples that the statement is not over.
So a `\` after that is redundant.

Signed-off-by: Jaydeep P Das <jaydeepjd.8914@gmail.com>
---
 t/t0015-hash.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
index 291e9061f3..086822fc45 100755
--- a/t/t0015-hash.sh
+++ b/t/t0015-hash.sh
@@ -15,7 +15,7 @@ test_expect_success 'test basic SHA-1 hash values' '
 	grep c12252ceda8be8994d5fa0290a47231c1d16aae3 actual &&
 	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha1 >actual &&
 	grep 32d10c7b8cf96570ca04ce37f2a19d84240d3a89 actual &&
-	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
+	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" |
 		test-tool sha1 >actual &&
 	grep 34aa973cd4c4daa4f61eeb2bdbad27316534016f actual &&
 	printf "blob 0\0" | test-tool sha1 >actual &&
@@ -38,10 +38,10 @@ test_expect_success 'test basic SHA-256 hash values' '
 	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha256 >actual &&
 	grep 71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73 actual &&
 	# Try to exercise the chunking code by turning autoflush on.
-	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
+	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" |
 		test-tool sha256 >actual &&
 	grep cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0 actual &&
-	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" | \
+	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" |
 		test-tool sha256 >actual &&
 	grep e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35 actual &&
 	printf "blob 0\0" | test-tool sha256 >actual &&
-- 
2.35.1

