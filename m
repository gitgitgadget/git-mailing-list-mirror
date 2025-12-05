Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A41723D7DD
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946959; cv=none; b=QnS7uRxYGE6IXFs/nStpEP7rUYDohurUoZY4OAA+7nhqHFlTqd3II8n5PTIgyddKcu0CLW0nruRkNz7qltG2YJeixaFv2ZKsheTv/eb7mU9zk5/Q3VJk0kabG087emOwXOYRllzF1H1Yqxm3RTWCq0uQ1bnTaAORLlPRLw0a3io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946959; c=relaxed/simple;
	bh=96XjwrIn3XUzTvRB9kGSlc1CeZWI9mmwVRv7HHNyqQY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LwpuTEOkRCENTFrAw5AjgXIqUfM7VIdWfqSki8y89+iTpQFcDAD4pzdZgQs5fimijtUyx+ZG0ygsteBaDWP9siCSBoHDtfH0KSjFJ42qNRuk+Nd7bGVmZbTITFwTCKwGa1+nrQ8+ksd7KxPSQDzci5HZXP0Mq5oTU+ujBSfYKyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZV6PkEp4; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV6PkEp4"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4eda26a04bfso22428901cf.2
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 07:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764946951; x=1765551751; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItOI4uMh0uMFKRfhENseGlftt8X5Mk8TBixVlXyJ1X4=;
        b=ZV6PkEp4D4XjHAtQ5Vcq7VusK9I6SfBm+M79MOfec8DHZDk33F6f1QJoDx9Tiz6P4U
         AeiBNa1UHhh6UmFaNm9MOS1ST1OJyr9xY3OQPehbUZxwbHGeFMZqGZirG8f8OKrszQMm
         8uHrje6vHmHI376P+LJ27rWcISkB5orxyNc8A6IsAGf5eQmAu+1VsGCvBsa15e9t+y2n
         2izKIndkMd5qN0wi5kmxIAMqhmo/n512DNSsTUvI5zjxoJJK+j/EEZfVjAukqbv6o2BK
         23pM56jCINDOfUPQES9zNSdEhQKTASqa2DeImgTTNnyNKFePoR/HV7sr4mr/GZ2vBevK
         muJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764946951; x=1765551751;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ItOI4uMh0uMFKRfhENseGlftt8X5Mk8TBixVlXyJ1X4=;
        b=rx4UwxvmUntIQ5xNNivv0aYUk+35G3SbtrwvX/OKrwhzv937BJAyLxctJrLmeOQrim
         oOycFYVUTVGeypmrivHQteNrvmp2+W119dJduA+iEuiEf5HD9TgC8WGqfKolXAv++1zk
         Jg6JZ39yQVU+sLgqQnO8xQEuVfnnRiid6DO8VPA7jzXnEW9mQoLeHQefGIR+BMqdXQXG
         kTKo1fn2jXj9Sxacfd+YsPmiUEp2tXTUkM0a6yzGiE+yRQ+s2RDjPTvPm6aUEfTgc2cZ
         152psIGJQBPJ+ddc7qWfzBQw2QLIVzxyVQcsJ7jUzYKRkr6MdgEHnYZMYiXrQpmvMWmi
         arUw==
X-Gm-Message-State: AOJu0YwNE19ZZI2xcWUP1cMJ+SF4443VjJYiIW3tTmy1vbA7zH6Q1tMO
	+LYpINaLRq8lB+tUinThf6m57OedgBiADtYTEv//6TbK2O+kisPCp5j+FOTqrA==
X-Gm-Gg: ASbGncswbtQkh8S3alKCfz2w/25cblYjW+q1JsM2p/A6zCYNsxjm8gaWfrZzwzeZ+Bt
	y/s1jMSfKSMwnfYFTvkEFqiWILw5NVJWVfEok6ythtXQZZg8GvJC9An38WklovshRxdB/b0KrKg
	1kxzJHkPtXx94nB1ntS2R8DGRD3BEyfwanq7FJU3rBP+SzW5mG/3mhSaIaCkt7FJE/39GASxnGW
	a9Wda5tKKY/hWKwKb8Ehn4+mvnS7geWNzQLFc9LFkhriCwyRQ23NcUaxCznrP8G0MjhTjelI13W
	P6tGXKur+RQW8Wei2WIKjWAhr0j/fcHXV4aR9cRCosG/K7uDReyvyBp4oGX7TE4nPRz7m2UKBLt
	TNxxX9iT8OByUeGwCIRKQHpxNdLIzgqK04sgBYSG9NvfNYd3pO6qc1yptbo0PK919hFPlK9ylxb
	TUmlmPxosEZiev
X-Google-Smtp-Source: AGHT+IEo/OXl+uAR9ux04SAqLrLPtYFbXt7WaFPDg29/jh3TDev/QGm5p9hA/+9wFpzCUGgSw+ZAxg==
X-Received: by 2002:a05:622a:1454:b0:4ed:43fe:f51e with SMTP id d75a77b69052e-4f0176033bcmr152267561cf.39.1764946950671;
        Fri, 05 Dec 2025 07:02:30 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f027d2a875sm26932501cf.24.2025.12.05.07.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:02:30 -0800 (PST)
Message-Id: <96e279f50ebc26084095e781cf58db233fa05b74.1764946945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Dec 2025 15:02:18 +0000
Subject: [PATCH v2 03/10] mingw: special-case `open(symlink, O_CREAT |
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
work-around to pretend that Windows behaves like Linux.

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

