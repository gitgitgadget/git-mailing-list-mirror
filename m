Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1F368293
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981135; cv=none; b=toU57t2ciJ5KGDaczwus8pLAkc0NBgDPp70P65Bp0Jv/PWUX62YeMm8ZqWIka8ZQr7/lt+4movpHo1hXy4rB2oHfA2yRzqoFuaOubsSkW9aIV3QSeArIprfV+dLxClFCzh5qBM6caSo/RY/telYtYjdY8eudIZ9DkTlsi/Y+3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981135; c=relaxed/simple;
	bh=dIjnLR0Pm8ydUMKDkaN3BtqG2Rzpl8PfETW0XxDe9BA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Org9f7EitsQ69OaMu98VOdU9/ETDaatC8xZ9nMydjCTzrjJb/o/YvlgrGAujhSsZb/1H8Ax2efXxJHU5eKw5M4ADpQkqauakSsGI/wq3oiEKQVF0fi3U0XCG0hfIklbhZ9GXTT3ZHZ/yDy8tphdLEpC+lHaoXXjnl9uh0cS28hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCFu9fSq; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCFu9fSq"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c77fc7c11bso675499a34.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981132; x=1766585932; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFdVNEgOTlqSWg1JAHPExwML0bX7vIQNcJCraNoA6uA=;
        b=RCFu9fSqZe21g1nkkr0Bj4J51CutuA5V72LJ93lH9xzVMdrbv9JzxoQiRtgCwDxKh9
         rGti88dJsaXPEYEgECvUQqRFj4w/kf3X7TFvr+Uw78UP2G8G88rwYPeTFKQI5kl2m3CW
         yji7m6J2r36D2CJeWnCDZ1SoeO501MeTONzIRfATyC6KxCcxTHn2b1WkIj4mI6Q2Lol6
         ITOeLNGpkarAUMy8WVMCgMquaYTPp8/TTEtNGTdxWgdz1Ij9gkrmccYid1zwD51K31TR
         2zYJo9XdBJb+xOmxqQaK5DhJnz4N9LXuZJ+beTRKu1uDp/LYZd79usi7WdoXjW/NwSCy
         Sg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981132; x=1766585932;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jFdVNEgOTlqSWg1JAHPExwML0bX7vIQNcJCraNoA6uA=;
        b=H7cnu8veh1M/6o8acus6NxG/9V8UFZYvp9z7lCWH6u/uwR6pE+gH35HTPlor1fNtIC
         wubBrCJif9ndhSFflHIAke48zgesysKE+bBLZoGh71TOFairZa+OaEvs0AazesmLsd24
         FYSbE9MZI98ZRDPm3IUxF6cv2//uZ6ztCGRXHOyIM3fHSZZO03jQ8SXvRFQVPsEwrOji
         rfUhbUd7xzqxVecm+lJGFQnAVtdTgs8giBlbjahn649DAmHn+5GW2xadyShN0F6yVMuD
         /kAqLZmlAbLu9gw/PMvUsMYkBf9+n4864zQilBE/Pe3DSju/KqE8u6b3qU812RY2DLT+
         mckA==
X-Gm-Message-State: AOJu0YykMDZRGAnPGlblS41fn64QqgqyZIuRyqh10y6A89stXpWTFy8F
	YXG4m3/H/8s+rWkgWLsGLihc5zBR3X5plIvnwbK6/UZvK63ww+8Ds8fp8TVoPVOkqj/InQ==
X-Gm-Gg: AY/fxX7aV2xikafrXekNHhqwdTsAe6ftE+MOz8YszTDYrFUqcvYkTUhGCGRLgPj487T
	vDJEkYvqEfgtXzJJlRUaM23ILbRDgd/FHqbj6X90W7gpPBaj17+wqRK4E4lYogo2T67IPHHUOps
	Gf+8rpjRqjTdxHa4piOKQBPNbnhU4d8ewYmmy2hwHfqtyqflxT1zNQRZH0Y8mmpdpIfV2X1jqfs
	nQiG0YiyNa4dfqru/EStPS8XLzXvy9qj3gfpXDA4GKKR4ZCIeHszO67pK9dWpatdwZCb07sn+Sa
	MLhzwQWLrYxr6FZlLLxEgDkMCK914GNSAN1AEoqpw3aKZZurIFpe6g2dDPyDNqtQB5U1Hwlww30
	hWT1cT/0qoqIXv/pxvsbUK60uphHyvAkrHvQpg4gvgdfPOmA9pcK38cwnnL0t6Fjlp1n8+kdIP6
	VTJNuqaqHBHreBJATa2K1ja/A=
X-Google-Smtp-Source: AGHT+IGYBgv2/geRfjcWCG8lqOj2wXiUFaNaSvRBl0AWDTkAtf0e+bKt9BSQ8UjxaAPcXh478cKD8A==
X-Received: by 2002:a4a:c388:0:b0:65c:fced:b4f6 with SMTP id 006d021491bc7-65cfcedb841mr32058eaf.34.1765981131938;
        Wed, 17 Dec 2025 06:18:51 -0800 (PST)
Received: from [127.0.0.1] ([135.119.38.57])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614e9991asm8575635fac.21.2025.12.17.06.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:18:51 -0800 (PST)
Message-Id: <f42a2f14bce6920200e4ee993b76b37d4a762441.1765981126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
References: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
	<pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:18:39 +0000
Subject: [PATCH v4 03/10] mingw: special-case `open(symlink, O_CREAT |
 O_EXCL)`
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `_wopen()` function would gladly follow a symbolic link to a
non-existent file and create it when given above-mentioned flags.

Git expects the `open()` call to fail, though. So let's add yet another
work-around to pretend that Windows behaves according to POSIX, see:
https://pubs.opengroup.org/onlinepubs/007904875/functions/open.html#:~:text=If%20O_CREAT%20and%20O_EXCL%20are,set%2C%20the%20result%20is%20undefined.

This is required to let t4115.8(--reject removes .rej symlink if it
exists) pass on Windows when enabling the MSYS2 runtime's symbolic link
support.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 736a07a028..9fbf12a3d3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -627,6 +627,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	int fd, create = (oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL);
 	wchar_t wfilename[MAX_PATH];
 	open_fn_t open_fn;
+	WIN32_FILE_ATTRIBUTE_DATA fdata;
 
 	DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NTAPI, RtlGetLastNtStatus, void);
 
@@ -651,6 +652,19 @@ int mingw_open (const char *filename, int oflags, ...)
 	else if (xutftowcs_path(wfilename, filename) < 0)
 		return -1;
 
+	/*
+	 * When `symlink` exists and is a symbolic link pointing to a
+	 * non-existing file, `_wopen(symlink, O_CREAT | O_EXCL)` would
+	 * create that file. Not what we want: Linux would say `EEXIST`
+	 * in that instance, which is therefore what Git expects.
+	 */
+	if (create &&
+	    GetFileAttributesExW(wfilename, GetFileExInfoStandard, &fdata) &&
+	    (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT)) {
+		errno = EEXIST;
+		return -1;
+	}
+
 	fd = open_fn(wfilename, oflags, mode);
 
 	/*
-- 
gitgitgadget

