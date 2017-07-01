Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4823F20209
	for <e@80x24.org>; Sat,  1 Jul 2017 22:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbdGAWGH (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 18:06:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35520 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdGAWGE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 18:06:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id u23so13884072wma.2
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yJ/SorjjvGYuaQbnLkwEcIux4KIeIPVsNTn4/Ze/UxQ=;
        b=qgGB2Mpq7ugcNb36aQyOI7R6HHKDuVB5kS6z/n4JEeMM70DrZ4Y6mPRX3RexhRYUE6
         Wd1/ChchZuDWAZE+Aj2+rjaOD+VKsrQq/CMJJDtSqZZehFNqjaDNqBGSfjk0zcDyYY7q
         PJ7LGJqItZdn89z38G6adPRnrZIr82qKYXtm2v3Yv7sqvt0uby/Cmgw81WrJL26S5rFS
         feeSVWeILRSVz1CTMdMcKHND1/VYuQ52y9vjEVrBxYVdoJoOQocCb6pHJ7Z7U6mkK9L8
         O+HIhxVe4Ezvoe0ZzPKE7/8+AXxU49Eb/GCumO7L0rna0znUeOf6Tlhgnd2lnj58WD44
         X5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yJ/SorjjvGYuaQbnLkwEcIux4KIeIPVsNTn4/Ze/UxQ=;
        b=cDHWbYm4BwJoUfMB6fkigZ5XDxJe2VTSNuLi6C/TCM8yopalaN/q3w26KlLDjK4boI
         BLEt21k+HtGY6NOwY66V78TmGabUO0i2F5J8ffdO6RqhflMhq0WcPWSxlnZVvXtYeCXF
         KdNBK7RL4uVuIrqqf9sjc9xaEgfbaj2635Wi3HCMzqD1o0w42egTJ4gthlc7A/JhENUc
         wxhFoUeLcVi2NV9WqfZkl62I2gyFRLId7s2TmA7FTF9ByUtMO626Za22cU/U5bdAppNY
         +jtpDRgNlsBlXTGzXj078hSNkDGvc1xp0zgdTbzWtXmN16B5KaLROy0N5pgCHWRQYp0g
         3MJg==
X-Gm-Message-State: AKS2vOyzuz7dBIIEA+/AUD5e/Sxr4nTEZAhDLtmr4Ux6crChmS3i4TAe
        XPWoUC+C5sR+LTD/ch8=
X-Received: by 10.80.176.102 with SMTP id i93mr9807307edd.116.1498946762768;
        Sat, 01 Jul 2017 15:06:02 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e54sm4208643eda.27.2017.07.01.15.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 15:06:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
Date:   Sat,  1 Jul 2017 22:05:46 +0000
Message-Id: <20170701220547.10464-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170701220547.10464-1-avarab@gmail.com>
References: <20170701220547.10464-1-avarab@gmail.com>
In-Reply-To: <20170627121718.12078-1-avarab@gmail.com>
References: <20170627121718.12078-1-avarab@gmail.com>
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
index b94cd5633c..f0cac1f246 100644
--- a/Makefile
+++ b/Makefile
@@ -162,6 +162,12 @@ all::
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
@@ -1448,8 +1454,14 @@ ifdef APPLE_COMMON_CRYPTO
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
index 0000000000..19d97bf5af
--- /dev/null
+++ b/sha1collisiondetection
@@ -0,0 +1 @@
+Subproject commit 19d97bf5af05312267c2e874ee6bcf584d9e9681
-- 
2.13.1.611.g7e3b11ae1

