Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2BE2BE648
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995986; cv=none; b=rV5sk4k6L/TAg2uKd70CSp44UPO5VLjxAnyqoawA4FRN0X9f/5YQKyRDTTJhC4K2JA2lPd0IC+NJ+Vr+0ZxOVZzUVrDYmNTowhQYRXKLLLMLoPGv8Ym/R5U9quSr6xFWMptT4JaELaeN8hgOCIuSn3uld5xu1JZ4zTgOcTXDEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995986; c=relaxed/simple;
	bh=yZAW5wxmxvnBU+IPS3tTNEA3OydtIIY5uY617oQiPs8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=W0BDd0HC5GvCTQoIzH6q2YmHMUD+6XgW/aWAL3tAcaE/xMRGrclDUrgon/upnO3qGfVr7C17FBonJMVFgRTna+87iq4IQkSxZrRm59WfbKvxjv1OcdhxMbyrC7JnkL/1c79cgt7eV+Ci9hW94nhG68Wycc2qIBtNilAbREfgFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFck9Ips; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFck9Ips"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b57bffc0248so576715a12.0
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 00:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759995983; x=1760600783; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9egseDC6WgRrSq12IQIoM8T+Ns/AVVtDlL7crCez2a8=;
        b=DFck9IpsuE16UtGSOaGKG3NHUZUrb6WvK6W2weQ7n4Y7ZQ4J2gb1bICywCzXjKW9ht
         qE78FLZ2P19a1DZ62hxTuGxmuxAB0esMYivmhPwQXD4/5zCACFtY5QoLCfj6B4PlvO6J
         yZ6vspqKFK04/2GlHx62OVgpJiweaEyfuWYPJF8Gh0iPFGOrU7DS4m7javqQQQwIr7Ab
         60i1aYB2DCTyWF6NceNHT9KKKPy/Cyl4MGaUV3EJpWP4LebZpsIgank1DDSoslaibShv
         ULh+jLUmQvo8LVOd+fQiIcSjXHkS28ijQUQFp/2poJA8Z5v918m3R/OW41+NPmcERXuR
         zaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759995983; x=1760600783;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9egseDC6WgRrSq12IQIoM8T+Ns/AVVtDlL7crCez2a8=;
        b=dJBZEPBWqAtq0NKeNzWKB2t0VX2BdHjJ0v8ucNNHi4sgQ+NWx40VMnm0liYYxcxjYs
         pgP/KPDH8dY9UUOTIp6Zem8TNzNt/2H9zmvpfg1ACvtDm7G5h8jNT/EMKz63p1UWB+rB
         yB1ulrgLSCtvIItoC40B0lYJm6YdBFu12S0zsGZ24RiRmnQR7M8VJjFv7rEt4rreeU7M
         74mYWM2mSem+uslEN/jaldqce2l/Vk3P98fdqgGO7mm3pagyEYioCaRRT/mhuOyYbrbx
         dV3FmDYJrJvq8vA+5sdsXyOlTPuSmjcxBlxUDC/sVJVutoKrWfanyf1ZwhlMJfzUgQWB
         izIA==
X-Gm-Message-State: AOJu0Yy0XPOWKBYyfA0g/yJzN3Ez9aptNEnWiNjuiLg2dHt7XxG2uY2e
	ogOoncKOnUCGt0T7/5WCKgvyfHM2NVP1XF4pTeLnpMJcd5SGhMdcR9yyEVsiKQ==
X-Gm-Gg: ASbGncvOFNXd/qjjy0HAcdNWcnC1JkP3djlFFLmxthXdEJf2XsPguvLJ4MGjM6Wp9yZ
	FmE6YPVwsPrmuqmhLYYkw21j89yaK8qTlV4kwvhS3NRtcKjKOFjefSG94yJt5mV69cir6cfN7XH
	RZ8PBgEEOFJ3jurzAoUOtFb2TxQ4/KYX8UN7S+JE1c7cOAQOn/APR7JBfxrhKojHwr6OcUkrZMY
	zf0PXwoFlr5iAXitlhLqv2lOziW0vZ9DGAI5fEDXBrE7hTbvkx8BZdOsVwo5DZzE3Uxj4gJCjm3
	acI05tYw9dLx/By0FlbpB2b/jYxtj51MEWOsM/xf+VdVcBKwi8Xi/2HAHC0gsSmDUHM9/yPJuqT
	S4B0MD0t+HRkghO2DjDWPOpUkZ1U3F7AkXQpknMSGM0cCs07md5uJoeajV+j49A==
X-Google-Smtp-Source: AGHT+IHWv+o2bHYMkkPUe5RR59QtFS8eKB50zE1IsByMNPRZ7fIp4aRmLtMH8Q3NTd88aVuC9aejCQ==
X-Received: by 2002:a17:903:1a2e:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-28ec9c281aemr136716105ad.11.1759995983393;
        Thu, 09 Oct 2025 00:46:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f93ea2sm19343885ad.126.2025.10.09.00.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:46:22 -0700 (PDT)
Message-Id: <pull.1984.git.1759995982220.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Oct 2025 07:46:22 +0000
Subject: [PATCH] refs: forbid clang to complain about unreachable code
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

When `NO_SYMLINK_HEAD` is defined, `create_ref_symlink()` is hard-coded
as `(-1)`, and as a consequence the condition `!create_ref_symlink()`
always evaluates to false, rendering any code guarded by that condition
unreachable.

Therefore, clang is _technically_ correct when it complains about
unreachable code. It does completely miss the fact that this is okay
because on _other_ platforms, where `NO_SYMLINK_HEAD` is not defined,
the code isn't unreachable at all.

Let's use the same trick as in 82e79c63642c (git-compat-util: add
NOT_CONSTANT macro and use it in atfork_prepare(), 2025-03-17) to
appease clang while at the same time keeping the `-Wunreachable` flag
to potentially find _actually_ unreachable code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    refs: forbid clang to complain about unreachable code
    
    Just upstreamin'

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1984%2Fdscho%2Frefs-clang-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1984/dscho/refs-clang-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1984

 refs/files-backend.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 088b52c740..814decf323 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3186,7 +3186,13 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		 * next update. If not, we try and create a regular symref.
 		 */
 		if (update->new_target && refs->prefer_symlink_refs)
-			if (!create_ref_symlink(lock, update->new_target))
+			/*
+			 * By using the `NOT_CONSTANT()` trick, we can avoid
+			 * errors by `clang`'s `-Wunreachable` logic that would
+			 * report that the `continue` statement is not reachable
+			 * when `NO_SYMLINK_HEAD` is `#define`d.
+			 */
+			if (NOT_CONSTANT(!create_ref_symlink(lock, update->new_target)))
 				continue;
 
 		if (update->flags & REF_NEEDS_COMMIT) {

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
gitgitgadget
