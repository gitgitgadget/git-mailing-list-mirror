Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A60397D13
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980542; cv=none; b=fz8IzC42r4YTcrrlS51I7w0KT9dKX/i6OGBe7pz5nspEBfGpbWVeSYRMGFtEmqQaosdlLC9yYRj5s1LwDTDUZPAlc2DB4Jh5Asq8GLu4s5t9QSqcC8I4fx1+myq4+elgvM94zuvt+6ab7RugMx3nmpYwHrzoMEpXP2rBViWo3qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980542; c=relaxed/simple;
	bh=zJM6La79vpXeBbnmILXI9+KQSJlHLoALcac2NJ/DZp8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ainG44rgNWDBqYDcWN/FGaXZtpx+EXcUlVym5k/jpVEuKEMapnTkH5gstofHa8Ok/bNUyNMqhH7obSIPsMHpUZOqn30x2zp9TkjNVNycdU8ktUqbn3FDxUfIIR2tJmcb7KYvkqAwK033z2uZDpYzmU3+jU8ND+GkC4PhVsOwAgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJ2IQxjC; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ2IQxjC"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eda057f3c0so54244741cf.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980540; x=1766585340; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7pVJuASxmTvJkSPdd/AuvaPMLzbaOJygXGwAO7S61g=;
        b=JJ2IQxjCDhnsL537pYtbQGsqFelBQin3FZRI0+179YflxQnvHqP2jws3ECZ4keZQnx
         oxknKpTcf1Hz5E5wG+SnIVFZW3qpg1Re27e4HdcBRIYDEyoo3uEzKLcO+aU1yuKj/nC+
         nSA4BvxpWeuFJf+93QzQ9h1xQRMz+GCuIygSwtm4ng5DWLC93MdBz7easxp0/OnjePhb
         Rz1EoPhkpdM13GfRViZW3b3U1Qx6RrnvF4EFC1A4jLdZRzoR2HskpNq//3IiyhZOqHLZ
         4FAdzWhc1Q8+CrwGChb1lwueV2IqgVQ0jCxLP1SOTx/UuDkOYEy7jo3Ss5kBZM9Pp5E0
         PwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980540; x=1766585340;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/7pVJuASxmTvJkSPdd/AuvaPMLzbaOJygXGwAO7S61g=;
        b=Onk6dJARUj+/b5ROfeECmMWMZbcyaRCgm/Bztuojh13vFXJWSA48pRH5IV0fLM9ge2
         5WVYMXqXEV26/IDhbQafWWY2B6J9JybDOTAc77soeSODIZnsn2s+5xW3WAQsHc+LRPgI
         eJWQDhl3isFnyDa7dBB5ZUIPUSfhL8ap/8oG9fUGt3c0srMwApGNqdG6ywynZ/BHDLNP
         cOJIU+1V8v+9NO60v2P7Psood2DQzuhakDV5vmk/DvQMM/+DtvlGFmCipoNZLCLFYC/G
         FX6qa+ZcjvWkyrm4MfbA0fPmZsp0dm1WZpjd4RmZ/zEoGkQXgAbNGCWa4VJL5xZPLX/x
         cv3g==
X-Gm-Message-State: AOJu0YxUX3dWzGReyTxFLX2iGESnYQUhHUOR/+e9UvMqhjnzu2nibfWL
	dt7a2tbZoLwYnyfANitwF9GZZRnLT99T4CQRL87cTAzBfziMjUEMz/CamyoQ9vlp
X-Gm-Gg: AY/fxX5PKDrCx4KIGIOQ/lXQi/xFUFzdPPvM9iI4Nkau8/kugdDO6pyx2y4YEaEunjG
	BHPZtQUVe7RFH9Yt2kFmYKa0DNviWmjQjyZ+qbfRJe5wu8LW+Vpjyoxv56S4IQMA4U7LbZrP/7z
	6bPcZ9GGrrn6RRZcQ5kR/FjvU5A8R1XVhC9ndi2Wg0vIy/rojFDDGyNkGlda81LyHVHURnIbjKd
	ZOJc/Jej4g/BZjrt4VYoomO8XKN5/nA43bp8uUJuzkWJcMTuxfR3LhSFh+EUKL4gKLjzIkKccpm
	TCkuEAX2Q4Rc4sPTY4NIHPvuNzPRjFy7qZXaM8uTuFab+8MgT2/4fiTjBfoZas5TzCsNk7c1vvn
	x0SlBAaK6ot6eKJ/JOpeX6/wHigD86CiNR8pj7RYEVe+wZG1IxJhAvNAGmoyDT0vrYACpoASY/U
	OICSYyn94wJyQ=
X-Google-Smtp-Source: AGHT+IEw4oz05BVphh0UfOFFS3HnkmrYWnALg3UfzPsWgigHfUtyG6VBd6GSbDrgjYUKHDX/mTpIzw==
X-Received: by 2002:a05:622a:4cce:b0:4f3:5652:6743 with SMTP id d75a77b69052e-4f356526749mr21628401cf.39.1765980539515;
        Wed, 17 Dec 2025 06:08:59 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345c5248asm35519441cf.23.2025.12.17.06.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:08:58 -0800 (PST)
Message-Id: <c36848eda76742f7a7c203868a077b790301344f.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:39 +0000
Subject: [PATCH 02/18] mingw: implement `stat()` with symlink support
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

With respect to symlinks, the current `mingw_stat()` implementation is
almost identical to `mingw_lstat()`: except for the file type (`st_mode
& S_IFMT`), it returns information about the link rather than the target.

Implement `mingw_stat()` by opening the file handle requesting minimal
permissions, and then calling `GetFileInformationByHandle()` on it. This
way, all links are resolved by the Windows file system layer.

If symlinks are disabled, use `mingw_lstat()` as before, but fail with
`ELOOP` if a symlink would have to be resolved.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index f5a0fe3325..59afd69686 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1026,9 +1026,26 @@ int mingw_lstat(const char *file_name, struct stat *buf)
 {
 	return do_lstat(0, file_name, buf);
 }
+
 int mingw_stat(const char *file_name, struct stat *buf)
 {
-	return do_lstat(1, file_name, buf);
+	wchar_t wfile_name[MAX_PATH];
+	HANDLE hnd;
+	int result;
+
+	/* open the file and let Windows resolve the links */
+	if (xutftowcs_path(wfile_name, file_name) < 0)
+		return -1;
+	hnd = CreateFileW(wfile_name, 0,
+			FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
+			OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
+	if (hnd == INVALID_HANDLE_VALUE) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+	result = get_file_info_by_handle(hnd, buf);
+	CloseHandle(hnd);
+	return result;
 }
 
 int mingw_fstat(int fd, struct stat *buf)
-- 
gitgitgadget

