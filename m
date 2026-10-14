Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8B9348465
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958178; cv=none; b=HsQks9JgeRzzZpQIqpfC3SKVqTMqPTtdXdMmfpv8QaSjqNYVkDnWMTGSS+Sw8hoUsAGUJ/D8Zzw6j7JEaVipals6LTRHa3/Bvn8CHFtXL61kuk4Pd3LsQtCyWlPhPl0OGZCdrbqxd07BkG5TELHSJRWE0gAO9eJZpAhuGTDXcMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958178; c=relaxed/simple;
	bh=Y9hVZcMy0IPXRLOl4WPh9YM2wbX17Yyw/J84q9Jw+PI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YkaSQWlXliJG6CG2iHWXx0Oqu5jLXyTzVvwLJQDvNFNPxyRfSA6B6watJLwDyRHbSs2nuBJhnMucnfM/Qc9/sk9rSRUlgcewfxZkGlGK1Wkuevj7g1j7rL/nRuCfcYCe5yniTcX68KcrMOu29DCvDn2sb/ywfITL2/zVgJFIxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBO4Qfzl; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBO4Qfzl"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e76469b93so2037385a.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 23:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791958176; x=1792562976; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ysP6YXCK6K74gHivGs6UZdaXrIacaoQL2gz3Se1c2fE=;
        b=OBO4Qfzlls87hceA09jxsQF3Pcrbz676EXaNdM6l+AcghM89b16Gtj+wtJfFZYy2K4
         KQg2Zh/24iht/UMa0uDQbG9nGuLdsosetMq3ocwCYMLEHkLR1EjuYfrbvmqmYvzrCkzg
         Eke2Ud+KM2WzYgrTvh40EpIA1cMOqlxm5mUEOs1WeSfhGE5ZFV3nhm1gdRpkDCfstkdx
         KJXXsgqQVh7JznZp3O1zmGw1RSUxVvQbCd6J7WisTEbLyRi14VTwREwXar6Pdw49K0KC
         ulZchsG5K7U+VLyPIpMa1igoJ9yGNFnKovkhkxOnibzTKPQsl4shoPtvG63fHZ8HDqyL
         TMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791958176; x=1792562976;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysP6YXCK6K74gHivGs6UZdaXrIacaoQL2gz3Se1c2fE=;
        b=2h8xbBfD8JUe38IeCRlTqfM/+U76RkiKcRcK8+5MT/D7Jx4loh9eDdduakX7kQc2Sf
         IC1yOpL7GuKbP0OqxUctsgsAVe9HXocfQunm6O8imMj1lZKIf9IaKaXOjVqcqHve0Kfw
         50zfme8f4kgbZvsS653dxOPn/MHyQxcLS8HCZoQ1cBNJYJV+S+INmnUGJRhxT4ySGYu9
         fMBLWi2VFRNa9Zna4hJQw0rQ98WrcAATNMdOMRpgC4aTxH2afyLwrSXltU8E14CrfsqJ
         Ym7fwXuiSAMB5w0IygAVpgwFGuGzORvO4ioavrM4bn9Vu1yPn0WGMR9LbR7oXes4MMzq
         xadQ==
X-Gm-Message-State: AFq9FYLRiwLbUnbtUZElrOxxf6kfL1HQHcvBRPCNflKvE3c8FISl6nzK
	qUdCEySWUB1nq8bZUYpp1scTlazNUppiVuh6Qzwo05kboDjitq6Ce6LIyRYj/Q==
X-Gm-Gg: AYBFou1Z5S2q3AoYJl5cqt18VZOBcmhXjuRJXO4BRcjQcIzJXP2tp+iZRf1h3SzRMFH
	Zr78n0+j+4H2aGg06b3I2ItOueErqKpl865+oi8Z3ASNnkNpFy+BV3+jMuGwo9uphy9gFRJrR6x
	6ysem7QOXk4aUUuTxoGjQ2Hfx6bCAJqaORwPT+ieGDfSp17aQPCm0aXMziihzuuJJR0aMTK7IsD
	nR1YbYRpJKyRiFGyJLTiou3LDrUfKabfN0CTx7X9rLCSZgAeoQyevlHECVwGGyRBlELmyze4aPt
	cq1Xoz8PPkB75zDkl4xptZsISMa3cLDerIpj2NDuhpqCKe73iyeg+CVLl6whONjALDpZNcZc74F
	hxy5zkEOiKTgrHm6UeglGRDS1XCaSij6r5s7XANvQa3VSEblhH/o5nhiGNSdK+5/OwAw6KBiI3n
	TwYO/8aoD0TFAOWuBUA6ixo47bumNvpUDB9j8AIlog9mKhVlLP5h/EdpD/xJjzH5rMxUcnv/ZsN
	XtOtgevKSzM
X-Received: by 2002:a05:620a:2949:b0:93e:c12c:4409 with SMTP id af79cd13be357-93ec12c4a64mr2289532085a.69.1791958176168;
        Tue, 13 Oct 2026 23:09:36 -0700 (PDT)
Received: from [127.0.0.1] ([9.234.149.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5027dd4sm421815885a.19.2026.10.13.23.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:09:35 -0700 (PDT)
Message-Id: <b1ed701935027a83574fae753e5cc11d23f0ea4b.1791958171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 06:09:29 +0000
Subject: [PATCH 3/5] wrapper: reject insanely large byte counts when
 reading/writing
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Both the `read_in_full()` as well as the `write_in_full()` function
accumulate the bytes transferred count in a variable of type `ssize_t`,
but accept a `size_t` count parameter. When count exceeds `SSIZE_MAX`,
that total count overflows after processing `SSIZE_MAX` bytes, producing
a negative return value that callers interpret as an error (or worse, a
small positive value after further wrapping).

In practice, git never passes such large counts because file sizes and
buffer allocations are bounded well below SSIZE_MAX on all target
platforms. The POSIX specification for `read()` and `write()` also
limits single operations to `SSIZE_MAX` bytes, and git's
`xread()`/`xwrite()` wrappers further clamp to `MAX_IO_SIZE`. But the
accumulation in the `*_in_full()` wrappers means that even with per-call
clamping, total can exceed `SSIZE_MAX` when count does.

Reject a total count that exceeds the range of `ssize_t` upfront with
`EINVAL` rather than silently producing wrong return values, matching
the POSIX convention for invalid arguments.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h |  4 ++++
 wrapper.c         | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index a0f901ce79..afce8b85b8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -740,6 +740,10 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
  */
 #define DEFAULT_IO_BUFFER_SIZE (128 * 1024)
 
+#ifndef SSIZE_MAX
+# define SSIZE_MAX ((ssize_t)(((size_t)-1) >> 1))
+#endif
+
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>
 # define xalloca(size)      (alloca(size))
diff --git a/wrapper.c b/wrapper.c
index 05a9cd369c..ea9c14f834 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -288,6 +288,11 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
 	char *p = buf;
 	ssize_t total = 0;
 
+	if (count > SSIZE_MAX) {
+		errno = EINVAL;
+		return -1;
+	}
+
 	while (count > 0) {
 		ssize_t loaded = xread(fd, p, count);
 		if (loaded < 0)
@@ -307,6 +312,11 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
 	const char *p = buf;
 	ssize_t total = 0;
 
+	if (count > SSIZE_MAX) {
+		errno = EINVAL;
+		return -1;
+	}
+
 	while (count > 0) {
 		ssize_t written = xwrite(fd, p, count);
 		if (written < 0)
-- 
gitgitgadget

