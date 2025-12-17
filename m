Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C90398B9D
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980551; cv=none; b=nlRNcN5XrdmduD+fVF9RHuuAmQf8inaBewVq9QP/HZAqYjhBNN06kPGxYSk1HlPAfnubc4Oew7zXzguMh7qWSSHy6TwU9X0WEP5HyybHXUKUvMcnWB1HiRXKEdkGGLYLjBGHjBiTOhIWgUzNJjvzIzL60VPs4hu+54XFstZRu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980551; c=relaxed/simple;
	bh=nFJvcG23leMmZ+cCL3YK/BcZqflFNW7K4W1cloRgBnY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JxdGkV81HlocWg5FeQgI4SkRevDZw5qfFdL/snGBfV6g6tkcqJWs+YzIECCu6kpD2Nz9qZEm2dsEPveVxHJbOjfV5FydXRVzAPHLDOJRVxjs11cpAuKDTHjTvSufb7xuHyFKpBvg6XydAygY2qGBpUd1GudTUn877HzAnyFHiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyJQdnm5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyJQdnm5"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b31a665ba5so726413385a.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980548; x=1766585348; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9QpYKMbZcQ0k8WJ9npcfQ1nZHBRdPKJTJIXizycoII=;
        b=XyJQdnm5TAWyxeBmi1nh0TQ9uDRTxmdrMwI6Sbo5TfUQ/e4IDZV/KpoqJPABNObWsI
         gmjATLLZqwyUO1wRh7bwa9zKAl9jdV9bRX/MoXPJOtaGdZGdYQuu1JhV14IalJQcyNEO
         kcG8ntc85KTO2fccx/47gf7FYM+Zs+TWitAHTQGSjmQqhh4PY7tcGtRY46OQY/oArvUa
         CQIygQYg+EqYBg1l4W1pmqpPBICHbN74blmEUKzHNd8OnzxkdHb2y8FdedKXIGGVEFf2
         Haj5aU5ndOBUgGZXQJ9BlyJoVtYG+bdL4tkBh6e+03EtD2anRlvNfpnvXL9cyJifH5tF
         vQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980548; x=1766585348;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9QpYKMbZcQ0k8WJ9npcfQ1nZHBRdPKJTJIXizycoII=;
        b=LftjDA8OtXcsQkZINXbuT2VIOXBPKRwqRWfAlu6XMRW5WaVawRVWVW5Jtsmtup4lmw
         /UK96Tg69zmCjfuFZmBPPV3t7AX0MVLuQoFE4oy8gY8lGlJiiZ5ZqSNOqLSa7kXEwxEO
         VOzJfM278ORQup8m+0c/umdfGAQ2EC8LKGtnfFUBxHQY1vbNr5hGVvrNEhRT/BcvHGCX
         mVjbFpN4EIqDO+CKZ+FJiJ3+bSXGbzBMnmaKsISgduOGp1Lib7SYEty50iq1p7mac3Nz
         UXpp4i3lncMveSK8FhAs/V/nSwGh8GYyxujVt98a4CLTGzdBgIDgPSvAVsbK1pQNh4+c
         73ww==
X-Gm-Message-State: AOJu0YxzoOlhgNFtmndwWwDcmM0nuFyU1mXwDMss/dREDX060jWRH1q7
	l3HiGcWD1Nu2Vc328SOikGn76mFLfXyZAZsBMYx9mao9900lhi9I7CeZ2DAhX8vc
X-Gm-Gg: AY/fxX6PB+my6DF9X8AR4kdTPp/Wi9u4lzic+CbOrySZ65M8MEiOw2XlaHopavZcUa+
	HmXdfwELH0PGhsp2cl4e7tFFzhO6ZXA9SQ2nBv6RJR+TXGc+37Y4TGtij1WftSvkOatahy8qEMK
	l0n5xlCJRB27ErHqR+yEi83j3AfoG4kOrdhAQn7f74ZNWBciiHt5k4CTzt50m6rqAhR5YlQWxqG
	o3jFUf1q3l1a6A656Z1N866UbAqiVVeqtmBlBhavRLQQ8h0lXR7BvAw+0D79kXJTalxPzMQzeWL
	DC8irKXHaYcTJ95F4X92uh6hdvENl+qVM0CSs6FkKe5dshj6i61sh286NTFVeMo/imNkLh5CnP+
	FZMPXIYXzuuYgQiCIyKSM/l3x8p6Z1BGebkzNBjnjgbIOjNhgiEcr+nBNMqp5ZVYoxJr9zNOpxb
	Ux99gk2sN9hEs=
X-Google-Smtp-Source: AGHT+IFfJUbjd16eOQ90QLkOispBmwwG0h3kofx/qZO1wDrmOPLMPqIQnrNPvLEcpBujwJXgaAvHcA==
X-Received: by 2002:a05:620a:17a4:b0:89f:24b:36c7 with SMTP id af79cd13be357-8bb397d9d67mr2612897785a.6.1765980547769;
        Wed, 17 Dec 2025 06:09:07 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be5a606c6fsm313747685a.11.2025.12.17.06.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:07 -0800 (PST)
Message-Id: <b698f4a002a29e1342760fa8cc5d31a3e4a857f6.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:46 +0000
Subject: [PATCH 09/18] mingw: add symlink-specific error codes
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Karsten Blees <blees@dcon.de>

From: Karsten Blees <blees@dcon.de>

The Win32 API calls do not set `errno`; Instead, error codes for failed
operations must be obtained via the `GetLastError()` function. Git would
not know what to do with those error values, though, which is why Git's
Windows compatibility layer translates them to `errno` values.

Let's handle a couple of symlink-related error codes that will become
relevant with the upcoming support for symlinks on Windows.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0fe00a5b70..0e8807196f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -102,6 +102,7 @@ int err_win_to_posix(DWORD winerr)
 	case ERROR_INVALID_PARAMETER: error = EINVAL; break;
 	case ERROR_INVALID_PASSWORD: error = EPERM; break;
 	case ERROR_INVALID_PRIMARY_GROUP: error = EINVAL; break;
+	case ERROR_INVALID_REPARSE_DATA: error = EINVAL; break;
 	case ERROR_INVALID_SIGNAL_NUMBER: error = EINVAL; break;
 	case ERROR_INVALID_TARGET_HANDLE: error = EIO; break;
 	case ERROR_INVALID_WORKSTATION: error = EACCES; break;
@@ -116,6 +117,7 @@ int err_win_to_posix(DWORD winerr)
 	case ERROR_NEGATIVE_SEEK: error = ESPIPE; break;
 	case ERROR_NOACCESS: error = EFAULT; break;
 	case ERROR_NONE_MAPPED: error = EINVAL; break;
+	case ERROR_NOT_A_REPARSE_POINT: error = EINVAL; break;
 	case ERROR_NOT_ENOUGH_MEMORY: error = ENOMEM; break;
 	case ERROR_NOT_READY: error = EAGAIN; break;
 	case ERROR_NOT_SAME_DEVICE: error = EXDEV; break;
@@ -136,6 +138,9 @@ int err_win_to_posix(DWORD winerr)
 	case ERROR_PIPE_NOT_CONNECTED: error = EPIPE; break;
 	case ERROR_PRIVILEGE_NOT_HELD: error = EACCES; break;
 	case ERROR_READ_FAULT: error = EIO; break;
+	case ERROR_REPARSE_ATTRIBUTE_CONFLICT: error = EINVAL; break;
+	case ERROR_REPARSE_TAG_INVALID: error = EINVAL; break;
+	case ERROR_REPARSE_TAG_MISMATCH: error = EINVAL; break;
 	case ERROR_SEEK: error = EIO; break;
 	case ERROR_SEEK_ON_DEVICE: error = ESPIPE; break;
 	case ERROR_SHARING_BUFFER_EXCEEDED: error = ENFILE; break;
-- 
gitgitgadget

