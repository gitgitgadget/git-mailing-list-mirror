Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1541F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 18:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755053AbcH0Sqb (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 14:46:31 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33948 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754795AbcH0SqN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 14:46:13 -0400
Received: by mail-it0-f65.google.com with SMTP id e63so2930212ith.1
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VtDiIXFkpcRFY6krpT+/6o7pveZKF3Ep4RhaUO1cFuc=;
        b=cFM/GByOjCgSDlwS9R2IOmIJApJ9Xkw6rX3b7WwKFSFOifMUrf+KVtikRfhXRWcy9L
         wDkTsasmp5ypZFt4L2xnFdERkGyijPhnBV81ph4lyhnm4whWO21GDiO8S3w9ndMXNB5R
         2c4hguoTtNLxT+x63qpqTI9ndYFvpqL4jaPkIt1JLob2QeT1w4G94DeenAfeXfFB68OS
         k2IARFVzsVYD4Z3F4LHuM6tpFHv7rZErnZcZQnA4JK6uIF99zQ1/MIxmZYqozE9iQ9eA
         mdGX6Qg2+TLcWfNaR9JujWZ3IbU8oL9BVizOKsnF+w0v06gtxdT9SLdmqUXofq8duftE
         xItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VtDiIXFkpcRFY6krpT+/6o7pveZKF3Ep4RhaUO1cFuc=;
        b=l/5FadLsprzFLlEU3/hdog1HNBwJkXwErpZGdqQa46W9b6uvpDVlID0cb4MlA5FYkb
         xPFpm3+YTDFOxkkXY+WKXRqjsumbYFw36r36b+y8NXDX/+eO9v0i43yr9Pwt2imtr/Lr
         k8FzIcup8oykyl9Yar5ZJgvNFDYtg/1EbGbOHSKHSCJEkQhgQfh/mL0KYYmVw0ohZrRI
         5+F5mRMj3PregiDAbCw9YMhmrd99KTOC66Gg0l2z8hjhlqDyLyJz9DIq8UlIEoUwRqVp
         1oDvVCfTZeAwcegaEf93nvHE+tj7/xS90IkkFw1Za7O2c9EPmLHvOGk+O9cNK8/EN1XM
         yPiw==
X-Gm-Message-State: AE9vXwOutntrJ8tIhCuVKXzKHV5bewwiXEwSflUjf6PFp032nbkIzmWpzF5ezzDxCJW5wA==
X-Received: by 10.107.139.194 with SMTP id n185mr11959060iod.159.1472323572987;
        Sat, 27 Aug 2016 11:46:12 -0700 (PDT)
Received: from christian-Latitude-E6330.starbucks.net (TOROON12-3096782379.sdsl.bell.ca. [184.149.38.43])
        by smtp.gmail.com with ESMTPSA id r123sm2350901ith.1.2016.08.27.11.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:46:12 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 12/14] apply: pass apply state to build_fake_ancestor()
Date:   Sat, 27 Aug 2016 20:45:45 +0200
Message-Id: <20160827184547.4365-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.770.g14ff7d2
In-Reply-To: <20160827184547.4365-1-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify git apply functionality, we will need to read from a
different index file in get_current_sha1(). This index file will be
stored in "struct apply_state", so let's pass the state to
build_fake_ancestor() which will later pass it to get_current_sha1().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 2ec2a8a..276e4af 100644
--- a/apply.c
+++ b/apply.c
@@ -4042,7 +4042,7 @@ static int preimage_sha1_in_gitlink_patch(struct patch *p, unsigned char sha1[20
 }
 
 /* Build an index that contains the just the files needed for a 3way merge */
-static int build_fake_ancestor(struct patch *list, const char *filename)
+static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 {
 	struct patch *patch;
 	struct index_state result = { NULL };
@@ -4089,12 +4089,13 @@ static int build_fake_ancestor(struct patch *list, const char *filename)
 		}
 	}
 
-	hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lock, state->fake_ancestor, LOCK_DIE_ON_ERROR);
 	res = write_locked_index(&result, &lock, COMMIT_LOCK);
 	discard_index(&result);
 
 	if (res)
-		return error("Could not write temporary index to %s", filename);
+		return error("Could not write temporary index to %s",
+			     state->fake_ancestor);
 
 	return 0;
 }
@@ -4709,7 +4710,7 @@ static int apply_patch(struct apply_state *state,
 	}
 
 	if (state->fake_ancestor &&
-	    build_fake_ancestor(list, state->fake_ancestor)) {
+	    build_fake_ancestor(state, list)) {
 		res = -128;
 		goto end;
 	}
-- 
2.9.2.770.g14ff7d2

