Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410CA25EF87
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322208; cv=none; b=eIUE/BLeXS+bZ3lCFgJsX7Snq7KLVvdaLHCZOvn+DCB3UqRdfNmE/8B9YAu23dRZdWd15AXpLGFlC2LuyzyZ7XiWaQLIHOoFPc/GjQK3MclhNJWpo0055FIIZRLr1o7kTuBCZ9dJ908qGygfiYpv2XE3Y6V2NBfHu3gwxfyyXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322208; c=relaxed/simple;
	bh=gBwSqPg8zCN36B2J3q28r3Y8QYgoutNsUmEuYbVOPjE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=H9Vy0G8Y4Zu6Hkrn9mEEhyq+4xlFw7fikzo3NEPPErWtF+XiAzKt8u/zc3bpTckNjfHHH3j8iOfi3qxSXNpB/ok3fPhQm26QZHo42K2OPQKt5LnEFkYctdgOguarWe7vXjmHjcD5/2MxPzMTrvP56y+cjbKbiCxr5Zh6M6EfzWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV6KCZxw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV6KCZxw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceaf8a1265so12123965ad.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787322205; x=1787927005; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sHWOIz8GMN+ohyhhtUI8PZD5uidtaKaFCLMCj0bNJ8o=;
        b=LV6KCZxwFWdoaKteH/Qw50ZVqCmGC+S+M9NIeYitGZEIZjR5px3UbPgGRWMTtvvl2o
         NmTKHqxQeL8sDhotDDECGqYdTY+95YIy0EgfG/jLVcl+bzEmdgrp5Xp3aV/81htAvnqN
         TgI5PT1fPh3shMgst/jn8sUsLi7k6HURDjtrtk9LMvk+jF1rBFCQiSfrtgW+R0lJvndM
         /oCtosy8Qs9HtkSmPx46qRqHKz4atmFKRwaa3A4CKJfjgb6RzS59cPuUyd+GfucYx6B4
         4zBkdLI7W2r2djNZzDOoPiJib3KhTUr48vafrXI1zmDADqtlBDWfnQcy7i5v8GpCLbDz
         jR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787322205; x=1787927005;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sHWOIz8GMN+ohyhhtUI8PZD5uidtaKaFCLMCj0bNJ8o=;
        b=Z02hwrHdlOIOnVXaPQAT+d2TMp+jQCrR12bLEMM500bPjQZ+wGBSG5hYQpRftM7v5A
         +Cp9o2lSqWkWIOxKGVOu3xV8uc5ZRrxvZPVP1kk3AkDVQxmRuDFd63Z66m4qeNf1jrNt
         dozQUwrkhlQETZWJ4H47UmM1XjUA+bX4h71sVn5cJLJNM8+MEc3AztAWOUr4yoU4CONN
         UHcvJTyfR9VBQj1Qk6Emb89yHgFu0v+WCkzu/WRFF/sBKA0HvMC8v8FQShbrD8nl+9T/
         3M0qCRrH7HCA1IEOaVGC024uDlzFovcMoR0lQON4Ffm+cboQJfr95aig/yqkITFvKZda
         awuw==
X-Gm-Message-State: AFuF++kiCXGMRT00xtXVaOWI4lcotx0xqv05yDLSmhgtuRH6nn0S7X0s
	1J+YWWBo0KZbrtdwogd1badzMRY2mmLMrQXh5TfGYPWdASNa6257nfzurxDFwQ==
X-Gm-Gg: AR+sD11b1mipUuUB2/MCBZJSNWWomKltRZh83h0uzWcoKNO6fUR0nX8HrnDUo0vcymY
	YnP5UqHFTafkhkSXZnzMxoeAoo/fMMoHL6GxKR8NSnWlEgoDzuqAY8uBgU/MJqvC2P4CGxyZPhz
	K99eAmUascMHQb9GyY0f+rt89lfAsx4UdOfTIXgovjm8dvJZgIW7y4icdw7GvlBnPjxM5QiqdUD
	V9GYbq8NfcznbBv7r2l1qiRlPjPthdJTAFQyMjAB8myH1Hp7+Nn13z0k3O+Te/XCMDZS/K/uyeP
	xwU+QuKdBDJ5sAyLcQJEdF3QgwzVRfVdPtieQQA/xPHAsWVdqawmC2OgSFAIP1JmV4Z1WMcEMHa
	cMwrMfFXUC6vmWc5TnPIlmXOtTWUntF5P171tOPy/ImH45CSKSzuBOsL7C0jKy4G1fuluIimhPZ
	xC42c24eT2wWbedRvDswTIKMrETZK9Z4wQ1G2/GsF05+6FbG+jJDvoufMekbF+RA==
X-Received: by 2002:a17:902:d4c5:b0:2d3:104b:1acf with SMTP id d9443c01a7336-2d64afe8b7dmr125949875ad.8.1787322204531;
        Fri, 21 Aug 2026 07:23:24 -0700 (PDT)
Received: from [127.0.0.1] ([128.85.45.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3a19a7sm20081745ad.55.2026.08.21.07.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:23:23 -0700 (PDT)
Message-Id: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
From: "Alexey Samsonov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 21 Aug 2026 14:23:20 +0000
Subject: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
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
Cc: Alexey Samsonov <vonosmas@gmail.com>

utime() function for setting access/modification time for files (and a
corresponding <utime.h> header) have been officially removed from POSIX
starting from POSIX.1-2024. While existing system library implementations
still provide this function for compatibility reasons, its implementation
may be removed in the future, or otherwise degrade over time. Some newer
libc implementations (e.g. LLVM-libc, currently under development) don't
provide utime() function at all.

This PR switches the git codebase to recommended alternative: utimensat()
POSIX function (which supports nanosecond-level precision) from <fcntl.h>,
and, as a possible fallback for older systems compatibility, utimes()
function from <sys/stat.h>. It also provides the corresponding MinGW
wrapper.

The alternative is to unconditionally use utimes() where possible, but given
that utimensat is available in glibc starting from 2007, and on BSD systems
since 2012 or so, it makes sense to use the newer variant by default.

No behavior changes is intended or expected (except for Git explicitly
passing nanosecond-precision timestamps to kernel, where previously only
second-level precision was used).

This change is generated by Gemini Flash from Antigravity, but all the code
has been manually verified by me, and, where applicable, adjusted to match
the existing behavior as closely as possible.

Signed-off-by: Alexey Samsonov vonosmas@gmail.com

Alexey Samsonov (3):
  compat/posix: introduce utimensat(2) wrapper
  treewide: use utimensat(2) instead of legacy utime(3p)
  compat/posix: drop legacy <utime.h> header and shims

 Makefile                            |  6 +++++
 builtin/pack-objects.c              | 12 +++++----
 commit-graph.c                      | 17 +++++--------
 compat/mingw-posix.h                |  4 +--
 compat/mingw.c                      | 36 ++++++++++++++++++++------
 compat/posix.h                      | 22 +++++++++++++++-
 compat/utimensat.c                  | 39 +++++++++++++++++++++++++++++
 compat/vcbuild/include/sys/utime.h  | 34 -------------------------
 compat/vcbuild/include/utime.h      |  1 -
 configure.ac                        |  6 +++++
 contrib/buildsystems/CMakeLists.txt |  8 ++++--
 copy.c                              | 10 +++++---
 meson.build                         |  2 ++
 object-file.c                       | 12 +++++----
 odb/source-loose.c                  | 10 ++++----
 odb/source-packed.c                 | 12 +++++----
 rerere.c                            |  4 +--
 t/helper/test-chmtime.c             | 20 +++++++++------
 t/t4051/includes.c                  |  1 -
 19 files changed, 163 insertions(+), 93 deletions(-)
 create mode 100644 compat/utimensat.c
 delete mode 100644 compat/vcbuild/include/sys/utime.h
 delete mode 100644 compat/vcbuild/include/utime.h


base-commit: dea0ea3582e6980ddbc1173cc8e3e9f9db91cde0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2209%2Fvonosmas%2Fdrop-utime-h-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2209/vonosmas/drop-utime-h-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2209
-- 
gitgitgadget
