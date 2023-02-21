Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB342C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 23:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBUXWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 18:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjBUXWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 18:22:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B03273A
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 15:22:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o14so4741484wms.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 15:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BipFu++isenB2VaWRkZX0Zch5epr6qpkB7BBHF+uGYE=;
        b=nUZq8iaPB61lVbIzyemsj0LB0AMW71i7CyuUvebrsCJ84iB45Jt77koeVW+gN+VDnS
         otGVR2jaJCP7pqwtZVW/Wl0m2+FtFmVUFg19EW2B+F45noPVqofHlq428dhdgYX/L3Hg
         ghzsAUs4F3idY+EObc7u//+wxfJfGepwzUMnsNl/Mzhxx1t0eeU9wxubtqmwSr7uivrd
         oF6/MiQz80p9I3LqrpRdMKwrBXRoh8gpD7KitC+mCMpGkCR6tXVlJvdSiQfdBQMlBCay
         R16vaEaBl+cYfaztYDAwmGN3sZ8VjFGR7L87NQO7CxLY1CzWROnrn3aREalOWKQrWhWd
         3zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BipFu++isenB2VaWRkZX0Zch5epr6qpkB7BBHF+uGYE=;
        b=GLzv3V1VkLiaRww9G+Xm1EUZDcjj9PkV6ywh1cI2n2/LH+RvE6OVWfodSEKG9PbkKg
         xcs9PYkLH2byLOn83Cdt91hqwjxjc1pWUPti2kil7UYNKvuV+qUgDWjKnE9I8YUURE/B
         slWcfkRONJLyfuEdfB6p06MlpIgG74aYDCkqyVZYWToyMlxcrhXaRlGNwuvnB+OWgXIB
         0pVynsTNkSTJ5Syg774b9sXwErN71K8luC8sPp8bdcv69fhtljv6dxO0pxvpIXxwUTMx
         yqdf2A6e4J5eOIqeE9EUKApNY0HP1N5CVlVsUEmsbyH4DtL+3asNFF9QQ2ddFNEgiLky
         euxw==
X-Gm-Message-State: AO0yUKV6wPoNB1NQcXBS4qu5D6fZGn15QXIKnQ19W+oOPWWtzyS95Z6s
        qXGv5bq+uUWx846RBrZSthQkaVocP5Cp23sG
X-Google-Smtp-Source: AK7set9Hhjyh2yp7Gb3WSV4C78gZMq8GBwpZXvwYID52ZdRbm/gqlfgvaFsCDVcTLr7/RZ4mdYv8wA==
X-Received: by 2002:a05:600c:3b91:b0:3df:f3df:29b0 with SMTP id n17-20020a05600c3b9100b003dff3df29b0mr4987678wms.14.1677021768043;
        Tue, 21 Feb 2023 15:22:48 -0800 (PST)
Received: from titov.fritz.box ([138.199.18.149])
        by smtp.gmail.com with ESMTPSA id a5-20020a05600c224500b003dc1a525f22sm3200134wmm.25.2023.02.21.15.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 15:22:47 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v1] test-lib: move comment about test_description
Date:   Wed, 22 Feb 2023 00:22:45 +0100
Message-Id: <20230221232245.155960-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a comment describing how each test file should start was added in
commit [1], it was the second comment of t/test-lib.sh.  The comment
describes how variable "test_description" is supposed to be assigned at
the top of each test file.  However, even in [1], the comment was ten
lines away from the usage of the variable by test-lib.sh.  Since then,
the comment has drifted away both from the top of the file and from the
usage of the variable.  The comment just sits in the middle of the
initialization of the test library, surrounded by unrelated code.

Move the comment describing how variable "test_description" is supposed
to be assigned to just above the usage of the variable in test-lib.sh.

An alternative is to just drop this comment, since assignment of
"test_description" and the process of writing tests in general are
described in detail in "t/README".

[1] e1970ce43a ("[PATCH 1/2] Test framework take two.", 2005-05-13)

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/test-lib.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d272cca008..c21934251d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -645,12 +645,6 @@ u200c=$(printf '\342\200\214')
 
 export _x05 _x35 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
 
-# Each test should start with something like this, after copyright notices:
-#
-# test_description='Description of this test...
-# This test checks if command xyzzy does the right thing...
-# '
-# . ./test-lib.sh
 test "x$TERM" != "xdumb" && (
 		test -t 1 &&
 		tput bold >/dev/null 2>&1 &&
@@ -746,6 +740,12 @@ then
 	fi
 fi
 
+# Each test should start with something like this, after copyright notices:
+#
+# test_description='Description of this test...
+# This test checks if command xyzzy does the right thing...
+# '
+# . ./test-lib.sh
 test "${test_description}" != "" ||
 error "Test script did not set test_description."
 
-- 
2.39.2

