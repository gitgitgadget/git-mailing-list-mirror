Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9D120F07B
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540027; cv=none; b=QB/4rnX1GBjZxPL/ds8RRwygJKeWSX+1gF7ADKIPi+G8Ef+1vEJ4yU+WtqzsXYIb39EUqMI1opR3s/bqrCYDYjPDUhz2ucldmH4bO1SY1qHiKld464b7PhSw6pIPYuBt0FPvtT0E4g3mNP6lUKJTr02huwU8D7cYvY1UpxAXUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540027; c=relaxed/simple;
	bh=UhALo1uShP256ykYjbNOOtiOV8FUFo7BIxMayC5lpJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTm9fI5aZZFLu7HX3QK/6cNPDihbyirZznjXn5BLETkvrSbY287esakZqCLu78YqOzs42RHcUCylV3ZBjpQXZY25LIxbXiecmkOtPdzMcpItprTkmf3vNdSn71SDAVV+AwpboUIT31WEcqLbRxpHBotz1qNeseGJVZLwdPdwpz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT02YWyO; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT02YWyO"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c1419f73eso107770a34.1
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743540024; x=1744144824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5RxoiCja7C1E2q1Xs43rfR8Au1RxouN7rWx8mWzId0=;
        b=KT02YWyObhtAsW8Dw78gYp4xBkhbLZtOOvRSrQpbES4zA86OYmK8c5GO5E7P2Hsp1s
         T1UTtZUsi1NqpWWflPajbkkOgI7AQ0NqvN3nUgNyljtUwOj1Wj8ax4DGqrMsW8ne1G/6
         RQNqTV8027qUCD2FlmpTTEPoFKzb5vBkLO5YxmGR+TII65i1DyDyRyj9WxfnXP+UXHXE
         9MrDAveIA6zz5jIJHkBlgdFdGfT2831mQqrfIG6+eqoIXPM91DMnRMiVLELPyEJ8WRxV
         xePbD4qPyYVUumSsm6DyEsnMZTQRnOE2xVuoqiiB+oygFiKVppQXfG3LUgLXYVBcPsut
         +yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540024; x=1744144824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5RxoiCja7C1E2q1Xs43rfR8Au1RxouN7rWx8mWzId0=;
        b=Xqz+iCO5dhCADBlWTdRmrO8/ifiCZ5n+1NZJwVwYSBtP/sZqeX9KFiBPY9y2uc9uqE
         SWDWMiZWW1pdU6eyY8f0WEWb/RmtujYwTEvoxEdNCM+CfV0NF5/WYPWm+Wbr3e/d+eRP
         uw5EpqByhehiWYJrGwAobS2E7lc5ljA/knD5gN1dJHxBkXsheynYFGwVQHt3Ssk0N65t
         v5tX5HUstsVBFyymygN2oYVY8ByM78d3tAEFltcwkNMCWvRTG+ScKL9GPKqoTz/UzYgw
         UJrPoWDnp9UoD8+i74VUQFm8JJtqw+XT8JxIX9J1VZ6veEv3f6UscC4zk/M+9BB6OtnG
         x2gQ==
X-Gm-Message-State: AOJu0YxNmosmokLabSesNPEJWPycBzVyu/1AafI4KLzhuWzs5QSs8Zk+
	Qpy5HdLa34N6K0A72002Dna7ap62Tjma+7z8Z5gpaCdxpCO6ZuUxMAW2ag==
X-Gm-Gg: ASbGncuwSOmTBGMuHA6MX/SZwt16BaoLUtHfHOOH+dLpA6EM6wvQVCsHMlvym3O0UFA
	N+onZ9nFm4nOXMD83UlJsokD8KenxK8VEgNpeZ489kZvh6C3YFIjxdDYcKBBms69fCTI9dpt9Xu
	CPS+WJ5IxT279ckK/UyX/zSH/FULZwIIABAhUCzn/tMKggFGmVlyuG50ceqS6bn2cXj+i/o4W2B
	jIZs1qKWxewy2JABitZxATvb2k3m4elPltZC89/Udrex91y0PbR6r0tOaP4/glPKFFE+zhOEOT+
	l2RpTDLuOlnc5pB65f8hoPhXF9zro0wq45Od0cRtvIfltDhNcX/O
X-Google-Smtp-Source: AGHT+IFPWtat7W1Re6FLpEFQNuhMvrQZ4MWC5mohWtC4PMgfomh2TMpCOyxT937Wpe0UTcPQh1ZF6Q==
X-Received: by 2002:a05:6808:1203:b0:3f9:6df8:1d37 with SMTP id 5614622812f47-40032774118mr855855b6e.10.1743540024158;
        Tue, 01 Apr 2025 13:40:24 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff051aa10bsm2100953b6e.23.2025.04.01.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:40:23 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/2] help: include unsafe SHA-1 build info in version
Date: Tue,  1 Apr 2025 15:36:30 -0500
Message-ID: <20250401203630.285451-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401203630.285451-1-jltobler@gmail.com>
References: <20250328170121.157563-1-jltobler@gmail.com>
 <20250401203630.285451-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 06c92dafb8 (Makefile: allow specifying a SHA-1 for non-cryptographic
uses, 2024-09-26), support for unsafe SHA-1 is added. Add the unsafe
SHA-1 build info to `git version --build-info` and update corresponding
documentation.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-version.adoc | 3 +++
 hash.h                         | 3 +++
 help.c                         | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/git-version.adoc b/Documentation/git-version.adoc
index f06758a7cf..753794988c 100644
--- a/Documentation/git-version.adoc
+++ b/Documentation/git-version.adoc
@@ -25,6 +25,9 @@ OPTIONS
 +
 Note that the SHA1 options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK` do not
 have collision detection.
++
+If built to use a faster SHA-1 implementation for non-cryptographic purposes,
+that implementation is denoted as "non-crypto-SHA-1".
 
 GIT
 ---
diff --git a/hash.h b/hash.h
index 51cd0ec7b6..72334d3506 100644
--- a/hash.h
+++ b/hash.h
@@ -20,12 +20,14 @@
 #endif
 
 #if defined(SHA1_APPLE_UNSAFE)
+#  define SHA1_UNSAFE_BACKEND "SHA1_APPLE_UNSAFE"
 #  include <CommonCrypto/CommonDigest.h>
 #  define platform_SHA_CTX_unsafe CC_SHA1_CTX
 #  define platform_SHA1_Init_unsafe CC_SHA1_Init
 #  define platform_SHA1_Update_unsafe CC_SHA1_Update
 #  define platform_SHA1_Final_unsafe CC_SHA1_Final
 #elif defined(SHA1_OPENSSL_UNSAFE)
+#  define SHA1_UNSAFE_BACKEND "SHA1_OPENSSL_UNSAFE"
 #  include <openssl/sha.h>
 #  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
 #    define SHA1_NEEDS_CLONE_HELPER_UNSAFE
@@ -42,6 +44,7 @@
 #    define platform_SHA1_Final_unsafe SHA1_Final
 #  endif
 #elif defined(SHA1_BLK_UNSAFE)
+#  define SHA1_UNSAFE_BACKEND "SHA1_BLK_UNSAFE"
 #  include "block-sha1/sha1.h"
 #  define platform_SHA_CTX_unsafe blk_SHA_CTX
 #  define platform_SHA1_Init_unsafe blk_SHA1_Init
diff --git a/help.c b/help.c
index 3aebfb3681..1238a962b0 100644
--- a/help.c
+++ b/help.c
@@ -772,6 +772,11 @@ char *help_unknown_cmd(const char *cmd)
 static void get_sha_impl(struct strbuf *buf)
 {
 	strbuf_addf(buf, "SHA-1: %s\n", SHA1_BACKEND);
+
+#if defined(SHA1_UNSAFE_BACKEND)
+	strbuf_addf(buf, "non-crypto-SHA-1: %s\n", SHA1_UNSAFE_BACKEND);
+#endif
+
 	strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
 }
 
-- 
2.49.0

