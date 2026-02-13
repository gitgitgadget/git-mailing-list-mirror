Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8C33C50B
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026939; cv=none; b=JLzMtIFI8OVBjjASomHlIlLMOTD8xyzgNk5/PInc4PaqY8kMogj14N/Z1iQPdlVDNWY2fHd33gwQK+A3UJwCAOU9m1j9qZ+eG1n7ir1sp0BEiQKpeBIWSL+YSR0TdieLhl1QDclwS6Ol+EjDZctS3tHSyBUi2V8ePstgp0HTMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026939; c=relaxed/simple;
	bh=r4Fm1mEAHNFzyj+90ap7fx6LvlskApXwTjlaOsr6M28=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cF7RvCK+vz1Qxbg78l/KQq+ALxxjWUI28D3DqP97WVBgQZIhWW9qSoKIL5LkrzF5+Knj0YyV3Rg5+4cIb8DYXlgemGZrx0220fFK+Jscq+WdOykkIsZFljmRz3kzRSAZ3+pw/8D5C+ZkAOX66GYfpxmsa3l/wKsSvNdAOtRusak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEQ1gDcJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEQ1gDcJ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50334dd44d2so17289291cf.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026937; x=1771631737; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3BhxttOJ3GFRSLMQC2443CSpp3Swv/8P/KnuCZZmMY=;
        b=fEQ1gDcJp3OikpIlZltH2F+ds9K3n0FIvHbpvTAnRwHw7pd1dnMosiHN06n2c8CfID
         D4dsr0pDuy8LStmIJfMEHSxJnHyaPQjZmQlZRP2TL61uNX5IHqJfWRrd2SkHpSoAiaJb
         9ZbcZ8WpIjq5o9dhRYtAR4oEaki4NMrodqnkjYneybkKCa6YrdKYj1hJB/gE8W/PtZfD
         cMh3Hy1RsGoMVp0xm2xguR0YbsbEM/SLfwVgqE3JDfvVcGUPdIP89maQeI8EzXMbbYIL
         LDnJG2yF2FR5IosRrvx2WPcRMf5YWVEPf5KB6d6XkVAuK2DGllMfQpRYuqBJDdc7KLYz
         4CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026937; x=1771631737;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a3BhxttOJ3GFRSLMQC2443CSpp3Swv/8P/KnuCZZmMY=;
        b=Zn9HyDOIpNrf70q5cEN3bWm9C2NOM/OuJjnBzFgDMdfFy8Ne+3hiRzAgOesEKqeNf4
         fu3o2shQ8tNoB3i3R1knyHikZ36v9toGdhek+PZ1zeYBohIrhq6Ev4aO7xuqkFamxIZ4
         ENaeyxVnUy1C2OUD1JDxa6RCcJqgjkR5ggd7nplkO6n5/ER3DnVUD4lJKvXualoHUcCE
         IepNzIbW6MxvKETQrR8BBRMqZrSOgSYp1wUJNqZ0eM+YtSb+qenmJDTEVYSlJCFPNFWQ
         f9BNw39egJjspqy8P/ki2XXAjVlrj45ZyHtiplgJy+2KdVcHZlaocqUc6q40wnsEZwBi
         KiVg==
X-Gm-Message-State: AOJu0YyHTpJKGifwrJ6HFbLF24E+b0iMHMNTr1xxs37RqWQ2hXjjVGXA
	InBDjc/bbM8z/A+rF+VuZrnAjJDP+ZzDWtsxiq4sVU3WVv8W7pmuFGLLqxfHL+rI
X-Gm-Gg: AZuq6aJX3i/9CGNu/sLWJE8MjhG+HhgIrheTBiRSZsmv8oYSkcx7DB9rnWUytkrflP2
	nRhYUmnLdecwn1N9CWcCRMhgMNMjTO98gsHA6cC21JH/Qpf5npuJr55eK/5Px4u2NreMvMNn3kp
	+zZn9ZY2ecVPkx63ZcbR/68k6NXzCVOpCBbyNG8BHAvZ8LRlYS6tJr2suf8nj9tq+b3/Pxur/K2
	SdmFcJRzsErD1OWFkvZSEf8v8xitpTmjRDzTP0LuAv+wuFYVEjK5QYrBa/FYDgdIHDwnKynVPs7
	kwsq4ElxU6V+LY0OQ5sh3o1P34TERyey3svKqCitThOCARBctyEth7KMGLmwr7JOKI7kSm5w7Fh
	CspVsiQdl8J1NKhRwO23nslcV5uO9AqMzUDOyNpz+6T1TX2AFzW5pU/3cMsOW/PCh2RNR3ye2BX
	COuhBt3k5CroM6i+IAmdoxegp0
X-Received: by 2002:ac8:7f45:0:b0:501:47d5:76b6 with SMTP id d75a77b69052e-506b3fadca0mr18929721cf.31.1771026937058;
        Fri, 13 Feb 2026 15:55:37 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cd899b1sm78654236d6.32.2026.02.13.15.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:35 -0800 (PST)
Message-Id: <fafafc5465979dc62b7c8253a6d2053bc0aa171a.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:13 +0000
Subject: [PATCH v2 08/13] parse: add git_parse_maybe_pathname()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The git_config_pathname() method parses a config value as a path, but
always die()s on an error. Move this logic into a gentler parsing
algorithm that will return an error value instead of ending the process.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 config.c | 14 +-------------
 parse.c  | 24 ++++++++++++++++++++++++
 parse.h  |  2 ++
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/config.c b/config.c
index 7f6d53b473..83257b7a97 100644
--- a/config.c
+++ b/config.c
@@ -1278,24 +1278,12 @@ int git_config_string(char **dest, const char *var, const char *value)
 
 int git_config_pathname(char **dest, const char *var, const char *value)
 {
-	bool is_optional;
-	char *path;
-
 	if (!value)
 		return config_error_nonbool(var);
 
-	is_optional = skip_prefix(value, ":(optional)", &value);
-	path = interpolate_path(value, 0);
-	if (!path)
+	if (git_parse_maybe_pathname(value, dest) < 0)
 		die(_("failed to expand user dir in: '%s'"), value);
 
-	if (is_optional && is_missing_file(path)) {
-		free(path);
-		*dest = NULL;
-		return 0;
-	}
-
-	*dest = path;
 	return 0;
 }
 
diff --git a/parse.c b/parse.c
index 48313571aa..3f37f0b93a 100644
--- a/parse.c
+++ b/parse.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "parse.h"
+#include "path.h"
 
 static uintmax_t get_unit_factor(const char *end)
 {
@@ -209,3 +210,26 @@ unsigned long git_env_ulong(const char *k, unsigned long val)
 		die(_("failed to parse %s"), k);
 	return val;
 }
+
+int git_parse_maybe_pathname(const char *value, char **dest)
+{
+	bool is_optional;
+	char *path;
+
+	if (!value)
+		return -1;
+
+	is_optional = skip_prefix(value, ":(optional)", &value);
+	path = interpolate_path(value, 0);
+	if (!path)
+		return -1;
+
+	if (is_optional && is_missing_file(path)) {
+		free(path);
+		*dest = NULL;
+		return 0;
+	}
+
+	*dest = path;
+	return 0;
+}
diff --git a/parse.h b/parse.h
index ea32de9a91..4f97c3727a 100644
--- a/parse.h
+++ b/parse.h
@@ -19,4 +19,6 @@ int git_parse_maybe_bool_text(const char *value);
 int git_env_bool(const char *, int);
 unsigned long git_env_ulong(const char *, unsigned long);
 
+int git_parse_maybe_pathname(const char *value, char **dest);
+
 #endif /* PARSE_H */
-- 
gitgitgadget

