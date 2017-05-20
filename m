Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4082A201CF
	for <e@80x24.org>; Sat, 20 May 2017 11:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbdETLyx (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 07:54:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36325 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdETLyv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 07:54:51 -0400
Received: by mail-wr0-f195.google.com with SMTP id v42so4955531wrc.3
        for <git@vger.kernel.org>; Sat, 20 May 2017 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KZdVlnyXS3utmEuR7v3o2Ri6VgW/CnaNBJ/yeiSajHo=;
        b=VzHOTsnA3jlcl6EUUZSKMnAGoaembQotCJwUIhJKtF1DwCPleYhBhfBy2oXutvLNa5
         4IJs3DUBEZGyvPOdXSfSAjaZ7JaEWQsFF1AdfTXYfI/91sRlfoaGyNZB44/Y+CQC2WVK
         w2xwXexpz/3+aoHg9jnXEBMaRJ6w1LA4v4n02fsLPrXgWhVxku8rs29iJhe07OFTmDec
         Z3lxUbTvxp4+bInWojb3EZ1xuxKo7RBowpdEQ9NE/s6ZI2zPWoG6OduIMRhVAGRba2Pd
         Yg/ZVaWI6C0mGZ+qPy4hLLlJFtt1Z9t1M6QxLa/RflvGK9ob8fy9qkVu76Ru4k9/6gRo
         jgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KZdVlnyXS3utmEuR7v3o2Ri6VgW/CnaNBJ/yeiSajHo=;
        b=T98N3kAOQiG4un7j6+ZM6rDsLqrUJuiiW4RQL+DOXztZ3OY63RxIlOcQsHedK90GPX
         ojfWJcMFz/hIvv55fl+Wz4+gJDfOtVh5blCz9iC6urU3KUJ19RMy4KwOYnjjfbpIWF8w
         Dv1yQVCfE3k/KL2xjcCwA3upTyttYhA3iTalYa5LK+AW1vlzzvUojcbAMFCo1C/uHgSj
         7xH9NFPoc9k9XHnk0/AyW8GmZZps1oqewhTToQ8TuKBi08kaRzuoimiLMB6O4PTHiIX3
         B/kimceqWh3wRj2I+ieidIYEHKRP41r6qqD4+K2nw7Ylc+mp8dPlUwroYmSqhbk8d0Ba
         0/qQ==
X-Gm-Message-State: AODbwcAUPrcTu7jChxZNO3g3AD4i/6867D4sFr0uzT9KlbNFgbCmPkbY
        mO/kt9+Jrn0IjA==
X-Received: by 10.223.162.158 with SMTP id s30mr7085449wra.34.1495281290546;
        Sat, 20 May 2017 04:54:50 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id n99sm5887280wrb.62.2017.05.20.04.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 04:54:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] sha1dc: optionally use sha1collisiondetection as a submodule
Date:   Sat, 20 May 2017 11:54:29 +0000
Message-Id: <20170520115429.12289-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520115429.12289-1-avarab@gmail.com>
References: <20170520115429.12289-1-avarab@gmail.com>
In-Reply-To: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
References: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an option to use the sha1collisiondetection library from the
submodule in sha1collisiondetection/ instead of in the copy in the
sha1dc/ directory.

This allows us to try out the submodule in sha1collisiondetection
without breaking the build for anyone who's not expecting them as we
work out any kinks.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitmodules            |  4 ++++
 Makefile               | 12 ++++++++++++
 hash.h                 |  4 ++++
 sha1collisiondetection |  1 +
 4 files changed, 21 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 sha1collisiondetection

diff --git a/.gitmodules b/.gitmodules
new file mode 100644
index 0000000000..cbeebdab7a
--- /dev/null
+++ b/.gitmodules
@@ -0,0 +1,4 @@
+[submodule "sha1collisiondetection"]
+	path = sha1collisiondetection
+	url = https://github.com/cr-marcstevens/sha1collisiondetection.git
+	branch = master
diff --git a/Makefile b/Makefile
index ffa6da71b7..6baad1669e 100644
--- a/Makefile
+++ b/Makefile
@@ -144,6 +144,12 @@ all::
 # algorithm. This is slower, but may detect attempted collision attacks.
 # Takes priority over other *_SHA1 knobs.
 #
+# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
+# sha1collisiondetection shipped as a submodule instead of the
+# non-submodule copy in sha1dc/. This is an experimental option used
+# by the git project to migrate to using sha1collisiondetection as a
+# submodule.
+#
 # Define OPENSSL_SHA1 environment variable when running make to link
 # with the SHA1 routine from openssl library.
 #
@@ -1412,8 +1418,14 @@ ifdef APPLE_COMMON_CRYPTO
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
 	DC_SHA1 := YesPlease
+ifdef DC_SHA1_SUBMODULE
+	LIB_OBJS += sha1collisiondetection/lib/sha1.o
+	LIB_OBJS += sha1collisiondetection/lib/ubc_check.o
+	BASIC_CFLAGS += -DDC_SHA1_SUBMODULE
+else
 	LIB_OBJS += sha1dc/sha1.o
 	LIB_OBJS += sha1dc/ubc_check.o
+endif
 	BASIC_CFLAGS += \
 		-DSHA1_DC \
 		-DSHA1DC_NO_STANDARD_INCLUDES \
diff --git a/hash.h b/hash.h
index a11fc9233f..bef3e630a0 100644
--- a/hash.h
+++ b/hash.h
@@ -8,7 +8,11 @@
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
 #elif defined(SHA1_DC)
+#ifdef DC_SHA1_SUBMODULE
+#include "sha1collisiondetection/lib/sha1.h"
+#else
 #include "sha1dc/sha1.h"
+#endif
 #else /* SHA1_BLK */
 #include "block-sha1/sha1.h"
 #endif
diff --git a/sha1collisiondetection b/sha1collisiondetection
new file mode 160000
index 0000000000..cc465543b3
--- /dev/null
+++ b/sha1collisiondetection
@@ -0,0 +1 @@
+Subproject commit cc465543b310e5f59a1d534381690052e8509b22
-- 
2.13.0.303.g4ebf302169

