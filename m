Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21F39B6DE
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980563; cv=none; b=uVOknubi7s90pDR7G2nSQ1ZRY4JfgRa8iGIYwt0dYmG7aNoKWDrQLRQk1NHr0+uKTcQvWgNzw7MenaBTjIrIG2bxaiDSYsTh2fJo4S11F9iJArAngMs66P0V5mO120IQAsfE8rPpm4AjE3rvwxArjbiLHvmaYLLw7U8Y/3kZzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980563; c=relaxed/simple;
	bh=xmRj2o1zdJYHskrnh6vYUdHR0BaZEU2uki7Ja0ciyj4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Zk/5wUs8GLK0e6h0O+5kZUsekdtU5mA88uqZnFzcyAvdtHPzagv6XLPyCCqQK3mD4N+TDJ6ov2bFkXIUeagcxkYCmlDYFupQ4e7dUTRIfDnCJHcH1fh2y8apeI9Jb8gq+wf+qDwxOhR5oHUJTpM4aiqxrN4q97r4qTqaHpzXR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoV8eFWb; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoV8eFWb"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88267973e5cso32569926d6.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980560; x=1766585360; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5Msj5vV3i+oKs/g4MUQND19CRj0aLwYGgkEiNIlm74=;
        b=VoV8eFWbRswK32MpM096nO4oe/KHRLckZVncmNt3X0iPY55s4PkAezWXxjAL+BIQrW
         BfQQbB6hIRemjjizg/A7t3rcNjIfDRnI8SVECFL27veXmHuYbiE8VqZqct7iJRQChMT7
         SuWI1urYOF836w4JVJ6DbEguTaSZBXE8u2sVhe5yXtvCNqUuZPtXnykb6+ki4/ULLS8R
         mIrIYg/bW/+g9jvbvktys7iOT5lifNm1B8yMEWcmwo71+XZorVTDBFZRll9VsGjD7ot4
         CwNUxJVF1AqKfIr8KCIlLv/XE0t2wfHi5FsrAkRJaPUksdxaiyHm/8YutvHSSa6mQi9G
         0U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980560; x=1766585360;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5Msj5vV3i+oKs/g4MUQND19CRj0aLwYGgkEiNIlm74=;
        b=gAA/34bR/JdWuSffBHfctaWAgp5qMl9O2An+mLLRIxdxHngyVwjOsravK8Ulq8nmAr
         j3QxhEg0r/6O/y0WmSTII6u6LO+CWiuJrcVWO0XME6ECS1q53k57cmUI501/Spunq6nr
         Svld68OivSq79l4xz7fPnf9rz8Twc15S7nsWWwlHj242lFoPpVqjkHDIxbv0gqfVCQOH
         nJ+amKJ1DtQsa2vIlQgxYkyvge34X5xOwUMczjQ80EFghU1bJ9UJP53Z/Bm/aUN1RM3Y
         KpgznWuIuZbw9EaI5muVns+64uN3Gt3mKXklVGhwxLbU6+0Yzc+uF+jy23tVmSncjdiQ
         DeyA==
X-Gm-Message-State: AOJu0YyorSFQ/m2uqMaHQFV2gYp7Li99wW9CTJfbwewXBe6FNWCJuIQt
	RMTJ+26erwo22ZV3+W4jtk5GHJlmXfi2/asi0yf0SGaCTSY3aTcenjUxPARIInAo
X-Gm-Gg: AY/fxX425TN91M3ZmUtmrwXrhjASQjkf0s4y0b+0w3ybrX7O+7kedhNMwrravR0XhL2
	SN0KjENXnwjd2AkVUFPOJx45etDHBhvXLdFYOy2jxAN/wwYctHc4X6w3Knm+oYHXfc2MV0nTzgO
	wTSxJ6nb2EA7VTq4D9z02Pl2eslTzOQk2X8nxCFyMitgZGPG+t+xpozLBEKRVx0Eix2d0+eGcaM
	lZ87d6dROyQxYsFMpKnBgshdfFVBrPhQo56/dAsne+GibQiljvUsMLiQlHt/x+L6yV7RDxnryi4
	Jkj4BkRulo+C+I6kuOcJG4rZL4/tIQnYJ3DZOVkc3YFFRk++xEPsuNoWDlpTM1/fBMQnMeKok47
	InWHRtydlb6I1QvGRSKknUElQPxzSHLaIpja+eZvhrRsctop+W0fkWylYnbpm9CxC/bTm0vHiyI
	7bQew6kkmIl2Y=
X-Google-Smtp-Source: AGHT+IEvb6Nq8SK5mDZraytoE+TQvdsNJ8RGQW59m6sIPOhwZ4EfcJXRdygYLCWP3ztYboYqo9FKOg==
X-Received: by 2002:a05:6214:451a:b0:88a:57db:8e10 with SMTP id 6a1803df08f44-88a57db914amr22196756d6.63.1765980559653;
        Wed, 17 Dec 2025 06:09:19 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b41850sm93794666d6.11.2025.12.17.06.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:19 -0800 (PST)
Message-Id: <2e73ab42217496739adc5881d900552bce006c05.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:54 +0000
Subject: [PATCH 17/18] mingw: emulate `stat()` a little more faithfully
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

When creating directories via `safe_create_leading_directories()`, we
might encounter an already-existing directory which is not
readable by the current user. To handle that situation, Git's code calls
`stat()` to determine whether we're looking at a directory.

In such a case, `CreateFile()` will fail, though, no matter what, and
consequently `mingw_stat()` will fail, too. But POSIX semantics seem to
still allow `stat()` to go forward.

So let's call `mingw_lstat()` to the rescue if we fail to get a file
handle due to denied permission in `mingw_stat()`, and fill the stat
info that way.

We need to be careful to not allow this to go forward in case that we're
looking at a symbolic link: to resolve the link, we would still have to
create a file handle, and we just found out that we cannot. Therefore,
`stat()` still needs to fail with `EACCES` in that case.

This fixes https://github.com/git-for-windows/git/issues/2531.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3e2110a87a..628a3941d2 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1273,7 +1273,19 @@ int mingw_stat(const char *file_name, struct stat *buf)
 			FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
 			OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
 	if (hnd == INVALID_HANDLE_VALUE) {
-		errno = err_win_to_posix(GetLastError());
+		DWORD err = GetLastError();
+
+		if (err == ERROR_ACCESS_DENIED &&
+		    !mingw_lstat(file_name, buf) &&
+		    !S_ISLNK(buf->st_mode))
+			/*
+			 * POSIX semantics state to still try to fill
+			 * information, even if permission is denied to create
+			 * a file handle.
+			 */
+			return 0;
+
+		errno = err_win_to_posix(err);
 		return -1;
 	}
 	result = get_file_info_by_handle(hnd, buf);
-- 
gitgitgadget

