Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7ABC209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 15:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbdFFPMw (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 11:12:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34318 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdFFPMv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 11:12:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id 70so10848108wme.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dM8nxvdkmxI1u7TY/5jA2F/XJ2TWDafebL3elzBydZ4=;
        b=J7Ff9FUMHsfyNdEQKc73o6mzMN8Qhxad8ynjQ3GFGJomK8BjKAtuJN6cVP1qGBravC
         kCoVZJRzdC536X5Lquiw0+zPFY2MZu0gL4Fi2X1vc+jdEw6w2cJ/Hn2v/1pUFOuNWqq8
         srL0n0K8q6q+ZmyR/SAYNtZ9onaw2S55vWrrd0s5B3iPwfpMcw83Z4IeAgu5fsNtZPjZ
         /dJcNnCSbwjGjJTqnMiydCwiR6x7DWj+/uEwk8n3uzo1RCh+cj+8LBWZUFbxHq8qv+zv
         XArmfYfhT0IdNmA9hw95NzYdcWMk6I7kyHSqGt1x8WMx8hO9OPUaGEYuLyONnmNUdYf5
         hn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dM8nxvdkmxI1u7TY/5jA2F/XJ2TWDafebL3elzBydZ4=;
        b=dtby+wLD0jBqjVjcUXwdXb+O11Miu33yCs5P8AULYkYYlJ1mkSKMBpnoxfkOYoQL10
         rsNkJY21YwuXT7X4Q+ifTSXDwlbYABthFzQchjiaZIJEXS4Ao8BtYQohBHOfTJq2By1i
         n/hAqWdba62TW9D02xBumX7WSYe8Qrt/JFzoxdqEeqiF034StbP+XiqNhNr6n9+2zdkv
         2nlbZw7ydfBcHP2wHiR46F6dC9VEHPx/oJxzYZRQqhotvzJA/G0YLMr/AdzekCmJLrrH
         C8CUJURJ8JndVaxad0xspGynMNGJDiCbzL/FMZ3jIMOup0hlFrwvQiKLBYOETa/9L2v4
         4UXQ==
X-Gm-Message-State: AODbwcBlChNUiKQ7kTJRmXHx5G7ilrfJxWGlyWt4rU9wn2U8efs2KJaZ
        8kZbv8Uy0SOcHRd3TRc=
X-Received: by 10.80.183.146 with SMTP id h18mr21503298ede.39.1496761969670;
        Tue, 06 Jun 2017 08:12:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d37sm2250632edb.54.2017.06.06.08.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 08:12:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Michael Kebe <michael.kebe@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] sha1dc: update from upstream
Date:   Tue,  6 Jun 2017 15:12:29 +0000
Message-Id: <20170606151231.25172-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd
In-Reply-To: <20170606151231.25172-1-avarab@gmail.com>
References: <20170606124323.GD25777@dinwoodie.org>
 <20170606151231.25172-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update sha1dc from the latest version by the upstream
maintainer[1].

See commit a0103914c2 ("sha1dc: update from upstream", 2017-05-20) for
the latest update. That update was done sans some whitespace changes
by upstream, which is why the diff here isn't the same as the upstream
cc46554..e139984.

It also brings in a change[2] upstream made which should hopefully
address the breakage in 2.13.1 on Cygwin, see [3]. Cygwin defines both
_BIG_ENDIAN and _LITTLE_ENDIAN.

Adam Dinwoodie reports on the mailing list that that upstream commit
fixes the issue on Cygwin[4].

1. https://github.com/cr-marcstevens/sha1collisiondetection/commit/e1399840b501a68ac6c8d7ed9a5cb1455480200e
2. https://github.com/cr-marcstevens/sha1collisiondetection/commit/a24eef58c0684078405f8c7a89f9b78271432005
3. <20170606100355.GC25777@dinwoodie.org> (https://public-inbox.org/git/20170606100355.GC25777@dinwoodie.org/)
4. <20170606124323.GD25777@dinwoodie.org> (https://public-inbox.org/git/20170606124323.GD25777@dinwoodie.org/)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1dc/sha1.c | 30 ++++++++++++++++++++++++------
 sha1dc/sha1.h |  6 +++---
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 3dff80ac72..facea1bb56 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -35,15 +35,33 @@
 #ifdef SHA1DC_BIGENDIAN
 #undef SHA1DC_BIGENDIAN
 #endif
-#if (!defined SHA1DC_FORCE_LITTLEENDIAN) && \
-    ((defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
-    (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) || \
-    defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
-    defined(_MIPSEB) || defined(__MIPSEB) || defined(__MIPSEB__) || defined(SHA1DC_FORCE_BIGENDIAN))
 
+#if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
+
+#if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
+     (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
+     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) )
 #define SHA1DC_BIGENDIAN
+#endif
+
+#else
+
+#if (defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN) || defined(__BIG_ENDIAN__) || \
+     defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
+     defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
+     defined(__sparc))
+#define SHA1DC_BIGENDIAN
+#endif
 
-#endif /*ENDIANNESS SELECTION*/
+#endif
+
+#if (defined(SHA1DC_FORCE_LITTLEENDIAN) && defined(SHA1DC_BIGENDIAN))
+#undef SHA1DC_BIGENDIAN
+#endif
+#if (defined(SHA1DC_FORCE_BIGENDIAN) && !defined(SHA1DC_BIGENDIAN))
+#define SHA1DC_BIGENDIAN
+#endif
+/*ENDIANNESS SELECTION*/
 
 #if (defined SHA1DC_FORCE_UNALIGNED_ACCESS || \
      defined(__amd64__) || defined(__amd64) || defined(__x86_64__) || defined(__x86_64) || \
diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
index a0ff5d1305..1e4e94be54 100644
--- a/sha1dc/sha1.h
+++ b/sha1dc/sha1.h
@@ -61,9 +61,9 @@ void SHA1DCInit(SHA1_CTX*);
     Function to enable safe SHA-1 hashing:
     Collision attacks are thwarted by hashing a detected near-collision block 3 times.
     Think of it as extending SHA-1 from 80-steps to 240-steps for such blocks:
-	The best collision attacks against SHA-1 have complexity about 2^60,
-	thus for 240-steps an immediate lower-bound for the best cryptanalytic attacks would be 2^180.
-	An attacker would be better off using a generic birthday search of complexity 2^80.
+        The best collision attacks against SHA-1 have complexity about 2^60,
+        thus for 240-steps an immediate lower-bound for the best cryptanalytic attacks would be 2^180.
+        An attacker would be better off using a generic birthday search of complexity 2^80.
 
    Enabling safe SHA-1 hashing will result in the correct SHA-1 hash for messages where no collision attack was detected,
    but it will result in a different SHA-1 hash for messages where a collision attack was detected.
-- 
2.13.0.506.g27d5fe0cd

