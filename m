Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF3227A106
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395320; cv=none; b=KZuyap0M/SlLWBJ1Ir9VBjSxT6H5tKpVl6LqcT8+uV+LqSdPMYM8dsGsOnjMXt+bl7qIG6Vq/aR+5oymzeJaIZVqETcRiCHzxrKa+fRbqQnh82ItNB1kJXfCR3ZyoUdyf3m9/9P0RW8XO5XxnK4rU3+uUbpyJ0cO5QujtquFVlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395320; c=relaxed/simple;
	bh=HEsTh06Oevm0fQEB0TrH8Bu5/MVnVNAVegDGsqbPKxU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G2ObC50oG7lUNO2gJxvK+FArQCvmK3n0qrwb4V+I9B/hXKY+Ti7c8YZ4B8HDW++SWfhEELxQk/DjOwEXMniVluscDFvKq0QDfKOnq9SV/b25/w14sfRtEjn5ZJ4vV9NLkf6o/1++Y5ccZKkhmvhGVRD2usarSYn1HqhcigkfZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxGWNATf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxGWNATf"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so3955044f8f.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745395317; x=1746000117; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1RvC/rfAdTN1fwgAWWRQtmfgQigKhXfAPPEtlDcuEo=;
        b=lxGWNATfIGlzBVxGfCmTdcXU6HLuyLvLSlpbmtLTfytXmP+R4xyF/xT39wob7Apmn/
         momtTf8B1yRa/xpkoXuw+LtI7rpcwj99lWboPGmz577E8pqohxSUaFPLNilMj8mUQuEo
         rz0FpfqmIS7IUA1gF/86DfPl4zdqWWAn/s/Gcg8NlLrJf7tM/xBRTcjtSLJze3l/LoUK
         7KOFAH34QJnrRuDqJFy4JK/++cAJixvk8j+TFK2ARtwOIT2Mim/K2wAbh61S5bB6hFE8
         0yKkIsMAXEUDsbETtYFRLPZtLMAYsshuRjpAIUZmkBKh4EWZxDtAYQ+ycK4yvuWubCf4
         9SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745395317; x=1746000117;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1RvC/rfAdTN1fwgAWWRQtmfgQigKhXfAPPEtlDcuEo=;
        b=wwYsmvmdvT6vnkChb4EXgMWfiJ0//1lJvqOviPEfI5jg9TEasmzTfe50CHUZYwAoTU
         dwiD84rBVQFi5phzgSFSxPZSBCeK0lkzfWuugPqkdDyrXBz+0UlTz8IZoAlsFxUhJHWs
         bQHVqUwvZV1vk9yxxk3ABa17MAMQoiO4MszCsl4JbcOjadacJKTXqHJ6X5VGnHnIFEp9
         Tf2H1kpFpVhu7JVJ7n3hbbE7I1xDOYJxLCxVAZGzpd4NOB6/QJ/+ToO1TebzdylKkdf7
         +ccCZmB9o0GeupElwquz5GvtaBjnHBmBPnGcTjFHde0jqkXCmyUbTDAVKOi20ZtdFq1w
         NhBw==
X-Gm-Message-State: AOJu0YwX+i7xwf53cM+L9O5VCD3cDtac/pDIAL++uYjX4EYQpa0+mjRR
	kvTpw+6Sqk0epCh5tdqrfK9p6vYjf3kaSLwkyPNa5mFY8P+Wc81G024Uyw==
X-Gm-Gg: ASbGnctr5uWybfjXibUhMLOOZ6OLbcC2A3S/eB5hTIu6dUUH5sNJuf1g7qNqWQgCIRq
	AjbO2Rnx4dHbHbUa8aDsa9OGW3hUPySvmZKsgcKd8Db7G789FL8dnbtSrq3et3FAHr5nOdhpHIn
	bMmlAb5JnA8mcETDGLA4rd88TDwChiJBkbfeYFsHT0K7/yY5TK+omWPuNAHuOywNyJicwJujMht
	E3iebSRkDzBakUa8PIxjvnhSLYUS2bkyLKe56wpBHgBS4PedDvQlhvfCnpOxrdV6YQWTnyU2R/R
	zLWU/2AMuZdVJxt0F/Bt3yN54ztjC6gsYIA8Un7SEQ==
X-Google-Smtp-Source: AGHT+IFcylxgfM6HjMQtErEa7TsAj0rhSdi3ccUv7oWpP8BOMClH2KwV4n8SktWb7ykEM2i8iBaFFA==
X-Received: by 2002:a05:6000:2408:b0:39a:ca0b:e7c7 with SMTP id ffacd0b85a97d-39efbacdea0mr14284938f8f.36.1745395316828;
        Wed, 23 Apr 2025 01:01:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408d18daaesm20880815e9.1.2025.04.23.01.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:01:56 -0700 (PDT)
Message-Id: <e0e78bd5131a9efa64697cd7c0bd30965d13b41c.1745395308.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
	<pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 08:01:48 +0000
Subject: [PATCH v2 6/6] max_tree_depth: lower it for clangarm64 on Windows
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just as in b64d78ad02ca (max_tree_depth: lower it for MSVC to avoid
stack overflows, 2023-11-01), I encountered the same problem with the
clang builds on Windows/ARM64.

The symptom is an exit code 127 when t6700 tries to verify that `git
archive big` fails.

This exit code is reserved on Unix/Linux to mean "command not found".
Unfortunately in this case, it is the fall-back chosen by
Cygwin's `pinfo::status_exit()` method when encountering
the NSTATUS `STATUS_STACK_OVERFLOW`, see
https://github.com/cygwin/cygwin/blob/cygwin-3.6.1/winsup/cygwin/pinfo.cc#L171

I verified manually that the stack overflow always happens somewhere
around tree depth 1403, therefore 1280 should be a safe bound in these
instances.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 environment.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/environment.c b/environment.c
index 9e4c7781be0..d948bb3c705 100644
--- a/environment.c
+++ b/environment.c
@@ -82,6 +82,16 @@ int max_allowed_tree_depth =
 	 * the stack overflow can occur.
 	 */
 	512;
+#elif defined(GIT_WINDOWS_NATIVE) && defined(__clang__) && defined(__aarch64__)
+	/*
+	 * Similar to Visual C, it seems that on Windows/ARM64 the clang-based
+	 * builds have a smaller stack space available. When running out of
+	 * that stack space, a `STATUS_STACK_OVERFLOW` is produced. When the
+	 * Git command was run from an MSYS2 Bash, this unfortunately results
+	 * in an exit code 127. Let's prevent that by lowering the maximal
+	 * tree depth; This value seems to be low enough.
+	 */
+	1280;
 #else
 	2048;
 #endif
-- 
gitgitgadget
