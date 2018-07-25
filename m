Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1FD81F597
	for <e@80x24.org>; Wed, 25 Jul 2018 08:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeGYJlg (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 05:41:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37362 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeGYJlf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 05:41:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so6525516wrd.4
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=whFoILvabAx7YS6LaITZI21x5lWbH1nfvVxJq5jVmVo=;
        b=q4scRCJz0BtTx3HJ4dBvKbWdnj5wPVpzI2sM4LY/U1gvc/cUz6QeB3ooGsqW7i6tix
         MEqrexJlx/sIQ3E0tEWEF9aau+834R4rxm2giCfrMVvAPBTdZW8aTCHbAcntWnq7BD7d
         +wxBkKsgp8x6Q6Nf0HJIy6C0RMkC2pMWKNkXrnvUXK09itNGVtXBkn+CfReAQeqai5cA
         aUlmVHK5FB95jqXrFbfl1ZHBL1Mo5V24v5T3UWSwk0nNASrZo5woQToaayeZfEQ/Scnp
         vqgQjFXd9JTgmXlwRAPK6WMktjv0R7fsrF50aMAekxxNkYzUWjfQwAljbEYuK7HY7YKQ
         4/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=whFoILvabAx7YS6LaITZI21x5lWbH1nfvVxJq5jVmVo=;
        b=NB651pnLC1wvDlM1a+cki8jFuqeO2gpGSivzkIfyVcQnu9lK9drAzJtDnB+GDsLs31
         t7/2IsyAXNfihffygPOJBjt8w+v1NV0JvYUTr+4+8Q387D6w3HOx3IgIgCfkZH9RxikQ
         ReMRCkdO4GPMsjKKhbj9kqf4RLRUhyYG2p12rt172e/ChDi0m2VScCbBwiCuElDAQ0JM
         7Bxf2pk18efKGyRQ7Oi+c1L76BcvpqdIIku7Vmxuap2i0dYnHg8UcFJRV+NG7MBUPeOe
         Y+0auHqu9SHd2CGHSXRgpgSruHoAHdq5adLhBQ9IfyEEwZ5oKPmhqj63HwjBjmOdc+fJ
         xogQ==
X-Gm-Message-State: AOUpUlGnEXMpV+Urn1zqODetgt6N5GBE/SuKFJUAbOsnqZGh9mFlWzEp
        GYjtQIaBB6645LUjpMpuOPgOxXXEkOI=
X-Google-Smtp-Source: AAOMgpefELVy5Vux37yycMCzVm52IewJjyzXN1xyIsphoHgmV8NNZql1qRTPcRGkcsLR4XVabIXd9A==
X-Received: by 2002:a5d:61ca:: with SMTP id q10-v6mr13678829wrv.33.1532507457266;
        Wed, 25 Jul 2018 01:30:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v1-v6sm35836323wrs.34.2018.07.25.01.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 01:30:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] doc hash-function-transition: note the lack of a changelog
Date:   Wed, 25 Jul 2018 08:30:23 +0000
Message-Id: <20180725083024.16131-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180725083024.16131-1-avarab@gmail.com>
References: <20180725083024.16131-1-avarab@gmail.com>
In-Reply-To: <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
References: <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The changelog embedded in the document pre-dates the addition of the
document to git.git (it used to be a Google Doc), so it only goes up
to 752414ae43 ("technical doc: add a design doc for hash function
transition", 2017-09-27).

Since then I made some small edits to it, which would have been worthy
of including in this changelog (but weren't). Instead of amending it
to include these, just note that future changes will be noted in the
log.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/hash-function-transition.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 4ab6cd1012..5ee4754adb 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -814,6 +814,12 @@ Incorporated suggestions from jonathantanmy and sbeller:
 * avoid loose object overhead by packing more aggressively in
   "git gc --auto"
 
+Later history:
+
+ See the history of this file in git.git for the history of subsequent
+ edits. This document history is no longer being maintained as it
+ would now be superfluous to the commit log
+
 [1] http://public-inbox.org/git/CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com/
 [2] http://public-inbox.org/git/CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com/
 [3] http://public-inbox.org/git/20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net/
-- 
2.17.0.290.gded63e768a

