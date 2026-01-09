Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FBF36921E
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989133; cv=none; b=gMhXPaqIbLGRLZoNU2jEfjNSE8vDUYgwR5q4akbqaTUlb9fe94HuUHNWrZw7t/BqmHi8slCA9NMUeI8KpZGvgHEJJamVxRphjWdDWE3DYrDl/wunf+nNbIinLSE5RvTGWj5QSLNaMRl2Al//Fm55W7g2ndxYPwT0286YTAZhUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989133; c=relaxed/simple;
	bh=tX7ITX8oQXE57mXsn2i+WfN2VEqfS8ZHMVT5hfeuQRA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=foToEnprw4sqCJZaocCpEZUl54qgPxNMmEPbGkKo/WCpF2RcEjAeeaFkZ2RVVeaeCDQwC2SIc5llvawXmjEZdVhkhA90+BIPEz3EjEfLPC/uv6KzLu83pm8ApPvTZwibp7jPnD7/PdXGImPhbAUYvk6nCfAiSGjb7/4v7UC37j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiY+rGCl; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiY+rGCl"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b19939070fso2557388eec.0
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989128; x=1768593928; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ6hgu9O9hcPerzCOCCFeDz8q1c+4OqPb0OX3EF7v4Y=;
        b=QiY+rGCloQZyCD+DUtb78QpUwpJJNsZSJFJKvvJY5BGNQdcCHblyuNkyk1yMC8GDHJ
         GbnWbt29VPtqeXId7rt31ZnUlY0Fqya2QTR1THnyGChQByYqk63DKzwWlsML9wOgpYx+
         4hwdwXYIfGAJyJX0utX0U1YOkngcZlZfQAhmoTb8A/0OlRuH8eU2OPiOTeSHZdIdaCkf
         wPkOjwdfUQTEv0seNpQ7kaTdvKtRSxlf3BcuogG0rQeMX8dT1AFeQLbbBq7xhxiUo0aF
         FLBsEESVHOzF18tTOQJlr/8O9DhCLxzzhWkJumoqpRH2WKWHlMhepqNBkAuzFJrg7JLm
         h1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989128; x=1768593928;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZ6hgu9O9hcPerzCOCCFeDz8q1c+4OqPb0OX3EF7v4Y=;
        b=i2BYHQUBVr4cwNXHyBpKSMuJTBLNdJox96exAzr5dhEgeRSWr2dixOmBv4mPqI2aAE
         aTXz6KImJH5eD+Bbp10BxhK/j9kYwNV8jywxuOsdJB9IeFpbkrsBq0xc3DrN85Aqcd7X
         wvT0+tykI5/FJUSWIt1JlKeVXqo5rAH+HuMUnpTK3/OcPr90oSjFYK9GIRZN3qkjoDEj
         2i8hhQZaF27bCWJrMhVwbgi84TSGUDi2IJY7vYx0GawprCFn+mOiMZzdqZ7YvwHfyIo/
         KJ/RfbCA/f1lm7iOkfl6wtnhbH97NXe0iJKzd7OWau1l8a4xGAiqV+Wnp2Tq2EfBzb06
         xs3Q==
X-Gm-Message-State: AOJu0YyfLy2tasB4MAUAzAJO1XOjCR/UIuFz4+UMpMSfwsU5Hkyu2KSp
	m1vlICOtl17HO9gtaKzBvtQpRUEowpHBXJxo8iTmhk9ybgRR15p6XphSMyC1Zw==
X-Gm-Gg: AY/fxX6s+xgAyu6e9QK+4dLZCEyI0EjyV8Uica6qjupTYkRhB0FDPLMfvbZ9mzwkjMp
	3KIf/eeOm651c7nsWjf5NJjRURXbs7Wa911PoS7sEzBKV51ntrUCtuA7sqQvCg+WV3hU5gfYnex
	ZlEBsT0HrhOwEraanu4NtpStr3SZF0lA/m+dhjpgw7q/Ge9eI7vaXxmEgaqpiXVQPUsddhFRBb/
	dZ50wyyTrNQUIlCaNIkZuRB5UNp3WfXpWbq3BQbnyeHRiAvaf0dJExAF//fniB/T/pPTGCX4slG
	Z2dUBY19Mg/4x9EZTZMrisOeiTTCZJBSAIqgQchBmTIoAB+bvpyTV8JTVygqZAx9lgyOdn3f2nX
	3jDNapRF6KG3T1ls0vuDH6ncRQI3tVcF6zGCcZwm+sQjv067uKC8xiux6irrIvUdL/YDPa9493X
	0AXWnjOlokKxJW1Y0=
X-Google-Smtp-Source: AGHT+IHKbXox5+z1dag0gT2p59osyf7RbOYpKy0O9Yn5jyew+S1WjrCnVQvSw6Z90jrAIjMG9oLuRQ==
X-Received: by 2002:a05:7301:3e18:b0:2b0:5079:d3c8 with SMTP id 5a478bee46e88-2b17d200cf6mr10830929eec.4.1767989127876;
        Fri, 09 Jan 2026 12:05:27 -0800 (PST)
Received: from [127.0.0.1] ([172.184.211.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d76aasm10798211eec.33.2026.01.09.12.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:27 -0800 (PST)
Message-Id: <accb6d5f0aef9ab5de6da8e9d08ad59a19ef5157.1767989109.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
	<pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:08 +0000
Subject: [PATCH v2 4/5] strbuf_readlink(): support link targets that exceed
 2*PATH_MAX
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
    Johannes Schindelin <Johannes.Schindelin@gmx.de>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

The `strbuf_readlink()` function refuses to read link targets that
exceed 2*PATH_MAX (even if a sufficient size was specified by the
caller).

The reason that that limit is 2*PATH_MAX instead of PATH_MAX is that
the symlink targets do not need to be normalized. After running
`ln -s a/../a/../a/../a/../b c`, the target of the symlink `c` will not
be normalized to `b` but instead be much longer. As such, symlink
targets' lengths can far exceed PATH_MAX.

They are frequently much longer than 2*PATH_MAX on Windows, which
actually supports paths up to 32,767 characters, but sets PATH_MAX to
260 for backwards compatibility. For full details, see
https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation

Let's just hard-code the limit used by `strbuf_readlink()` to 32,767 and
make it independent of the current platform's PATH_MAX.

Based-on-a-patch-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 44a8f6a554..ec2b7afbe6 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -566,7 +566,7 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
 	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
 }
 
-#define STRBUF_MAXLINK (2*PATH_MAX)
+#define STRBUF_MAXLINK (32767)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 {
-- 
gitgitgadget

