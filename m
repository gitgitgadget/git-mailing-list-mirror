Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27081D5162
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181527; cv=none; b=I9AqC6JgSx3G/UVIuOBMoSrnAQeXGq2PkIHlKd5MyOWEVSdmA5vf5ibWCHuGP91o01/Q8vrXzQAcMBk8LigMnbMgKQomSCUG9FQClsc9IuKKcqwXw2MqWQTcZ6kv4Jg0JaZRApHuIFLvXAuzJ0+pj9stTtwADKecZwm5OAMZUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181527; c=relaxed/simple;
	bh=T3dz2iiCplTFmUq2ruYc1xI7tUpAnkyfTkFgeA2tKHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/rDBULt21h5/SRjrimZjQkGwxONuKt8msNQbLqCw+S3XQK0oy5YAXXZGxQRZUltPV3cmv+aycMB+f4QvNM6MIEx7QI/IVlDsXfFiNBHfF//3FLJ5cpoqAuvvi8hdkVdY1FtZvqsI8wTSVJcRH+QUnSlOG2Rjz5Osz0lND95frU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4/0PVvc; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4/0PVvc"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3feaedb531dso472754b6e.3
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743181524; x=1743786324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XihaqxHMQyV6GlZsVf3yXEg0B+quohTjwIEyISykt9o=;
        b=T4/0PVvcur22d6e1YvrZZkWMJmYF4haBmmQ48i8jRI0dF/DhtoLo1+/V5MYTf1Gw2U
         PPQAVVNn0z+ww4tO/QliIdnvIcIVQ8/qmyfkPHqGClAhJPWyOKArrRKyBz8SZo3CDCLd
         Cla8sa/tvgOwDLUpO0e/riv24vqTFuCFKy+sPSBLT2Mf7xnYhK1mxwec6pW++T/GbYH5
         Uy6ImMbkhA4TS6yHC39GBm2qzsXaEGhotqjxCFI1k4aQTZsz0SW0UgUiTVWaNlu8ivti
         8xKLXEBwF0ulS48CN3z0ISRvnH8a3hhg7ZYb1FxtAf999VviXhgCeOmPSp5wK+AEmKBv
         nSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181524; x=1743786324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XihaqxHMQyV6GlZsVf3yXEg0B+quohTjwIEyISykt9o=;
        b=jwoABrZTVtKjVMDem8PRDGD6QNB51EmEbw5l+DXPUAdwEe+321ZJxy+RfSt7dLX/Iz
         OqT3vjzELqEwfKjplnNBC+vsmOKRvrKIdRTHnBZrLmd/ZGZVyFw/YEq7P9KQOXlh76ye
         MQ9nwVERvdwCxupYZ60WnXRexe5vy07VxmJhOdIMwIIZGjEKb0g8wSKcEreERxFkeYoO
         BuQxhp2zSj/oIP03I0wVn0nFbEt0qGZY0XgDBR0JWKGEVLUFkmzqtqKM5UU9h0IGxAAt
         3kiENXQQv1dDJtQCkIoMcZv2y3iB+eBLwPtF344ejuPVdJ82AYFfgGWgIzIOwg5bsUli
         L7yQ==
X-Gm-Message-State: AOJu0Yz4RDkLXyxR7nEGXg1LFNgK0G1LVg1jUo1g7uskKQmw2fQDQxox
	XwbetmTcwlirZGQ3UY2nLO4XXxAokKOhA0jgjgSp5aFhQd5pcTc5gY8guQ==
X-Gm-Gg: ASbGncsY4kFSEne4+CAdKWKqmbyqGEN1QoS+mGNgOdSUY5uDY9QVD+C6h3X3pZ8eh6O
	Yi5b4Q7KjVaAZ+EF+ZYSiz6rdH9i+cxqboySYpfyXTb9+BQouh44N799qLGg1DHLi12ExxUWljC
	pOVuL5jmtPkOl1jHGYgBBLO5Sb78p1XtI8nIEqTlUOjAQy93lxiWFyObiDYT8UhHKjCikOfBtW1
	QCTx0bt09NEzP1xdCbcxC9WPsxDe8YZL8yn09pTNl3y1Yqnw7NoaCUjPghQw7m8QVXHSnW036PP
	J8xrtWZ1PeZKTcp5Bw3q7xM7QsimQSsUn8mXwm+FLl8Pv1VGZiIK
X-Google-Smtp-Source: AGHT+IFFSMlVhtXVyfgGFflrbZocptY/aw/nDGcNSSt4amDeEWipavtVdA/qEhEPJ9U/7GYSRPBHrA==
X-Received: by 2002:a05:6808:1816:b0:3f8:debb:7683 with SMTP id 5614622812f47-3ff0f540100mr21761b6e.23.1743181524323;
        Fri, 28 Mar 2025 10:05:24 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff05166b27sm402136b6e.3.2025.03.28.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:05:23 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/2] help: include SHA implementation in version info
Date: Fri, 28 Mar 2025 12:01:20 -0500
Message-ID: <20250328170121.157563-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328170121.157563-1-jltobler@gmail.com>
References: <20250328170121.157563-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the `--build-options` flag is used with git-version(1), additional
information about the built version of Git is printed. During build
time, different SHA implementations may be configured, but this
information is not included in the version info.

Add the SHA implementations Git is built with to the version info.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 help.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/help.c b/help.c
index c54bd9918a..32b5d4e6f5 100644
--- a/help.c
+++ b/help.c
@@ -768,6 +768,33 @@ char *help_unknown_cmd(const char *cmd)
 	exit(1);
 }
 
+static void get_sha_impl(struct strbuf *buf)
+{
+#if defined(SHA1_OPENSSL)
+	strbuf_addstr(buf, "SHA-1: OpenSSL\n");
+#elif defined(SHA1_BLK)
+	strbuf_addstr(buf, "SHA-1: blk\n");
+#elif defined(SHA1_APPLE)
+	strbuf_addstr(buf, "SHA-1: Apple CommonCrypto\n");
+#elif defined(DC_SHA1_EXTERNAL)
+	strbuf_addstr(buf, "SHA-1: Collision Detection (External)\n");
+#elif defined(DC_SHA1_SUBMODULE)
+	strbuf_addstr(buf, "SHA-1: Collision Detection (Submodule)\n");
+#elif defined(SHA1_DC)
+	strbuf_addstr(buf, "SHA-1: Collision Detection\n");
+#endif
+
+#if defined(SHA256_OPENSSL)
+	strbuf_addstr(buf, "SHA-256: OpenSSL\n");
+#elif defined(SHA256_NETTLE)
+	strbuf_addstr(buf, "SHA-256: Nettle\n");
+#elif defined(SHA256_GCRYPT)
+	strbuf_addstr(buf, "SHA-256: gcrypt\n");
+#elif defined(SHA256_BLK)
+	strbuf_addstr(buf, "SHA-256: blk\n");
+#endif
+}
+
 void get_version_info(struct strbuf *buf, int show_build_options)
 {
 	/*
@@ -803,6 +830,7 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 #elif defined ZLIB_VERSION
 		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
 #endif
+		get_sha_impl(buf);
 	}
 }
 
-- 
2.49.0

