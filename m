Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180C2147E3
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256325; cv=none; b=RjtgIPi6FuGvc3qvVPmwDKAsnWRuzy9Ozqvo4Ev3/SByowt/fZVCOCCgGGCd5A9VPKiAEiE1dJZYqbkyZszMKOFo+Ud6+4GIIHjgxk2/UDyPJ5HSA4Rm2YH4PFyOhQTJMxwDAqEQd5TNYiD8jahUK99VG6BptrXj5h7UOqaVFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256325; c=relaxed/simple;
	bh=Wd/u1lWvkDnGgGbpfs4j5JJFKtA9z3ssXFDzdMGF9JU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fW+p3Lt1VEn1HbCrtcELZ246AtINp+UyiCcIE29/hYG2Wus889W6tUdgJvMrKrIu331FrgofLRHhIMtrF+z9kg3Unb8ZqsSlJnGkt/kjxR9e35QkfSpGVx8qzR3uHENfzcq5YOhAZldsjzIlm0FRl78GwftvQ1yCVbY6aK24biE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZMjrDfT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZMjrDfT"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so8324912a12.0
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754256322; x=1754861122; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1aa9wrxNUD4KDUgyDs7fO8Y19ltfoDR/mOfAgDsVZg=;
        b=TZMjrDfTVIerTa40HHlCwEIwUsEkQZ4yT+b6WQDu/U9fl1geB7NVhuWjiiEe8EOwyx
         321ToaPirt/cJ8xAbya+0MDL1/StLicxknffgjxxmfNe1MpUINf7iBecPfPoCJP3WF8W
         vZDNFjHsj/WyLMUDhIFLftS5YxoT7j7hQqAJOjQfHQcdl/6UIUAvJLbWd4OqHJ0Pm8Ai
         WiZl/fWMj5LRlRpEoOlFp1lRwo4WQAQvI6hm7lbzJ0PopX3DSW+QLrZAIiIHrURmkJ6X
         PkUmr4AQrT//TwuH3ArlV+gAPN/9salXeg0vHuMXhKL6e7NLPt5/wuyQqAUBwC5rqt53
         /gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754256322; x=1754861122;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1aa9wrxNUD4KDUgyDs7fO8Y19ltfoDR/mOfAgDsVZg=;
        b=v4TXPFHqNwTHFCcs7R6Lcjca3y+Db0yWpio6GyFENA5GZM6++xWIsN0fWvpp8IeybX
         rE2nIoQpU0z31JWRTwC9EB4MR7NO6/kxAZ/d2vrLpBmRjBrUXOni7OMnIpJvh+y5BIdW
         US7aP+prj3E+zL0m2caFprYWCnrVDs/HyE/jRR33QXlDsQngTeJ1Uu7lvTHQrdi+bQfK
         aov+RLODlbs5DPvDcTY85SaWRZlB7KWii8S1aUOAlUzO0A4db63qhsy4QEyW1/t3RANZ
         CLBwK5ixr0EdLidYzRR1u/bqGNF2nueJIBHaA9YP4/PW1hlLQ59Y85sggiXImg40RcAp
         nJTw==
X-Gm-Message-State: AOJu0Yy+AqjHC2nrNqdQKYM3JVjHm4fErubW4rCOGJ60uxEqTPveHLKN
	NL6QZN4A7W+Zi35g2YhnN3achn2+EKyd0IFH5pTZCzYkgkZfkqUtbIDRGhgPCA==
X-Gm-Gg: ASbGnctie6SA2uYNz12W1wufJbZOFYd93YZDsUo13xx9JYP1h03MavfxzRd1jGD/NVd
	k/bOLCOqF/zNZuVF4plcuKVrw4z3/PgBYRjbtKInzaXdhCM6XzxrCelWTvRSszZZfL0erMGCXk6
	vvMMNcIMwhwJYOyD3FYbcZ/Nc9mX6gUQFBqiHJMazcmfsO0IcJIfMFz5nbiE7fT1st/V5bwNWUE
	DA36V1zROfNNzJqbSDPHMmAm7LPVgxT87wHUmjZBSMeUSMJTALmRgQUEbJcYxe1qziIW7o43I9Y
	NVbb5wSMtAyse7CmZENQioeA5+szVCERUbIzTjpzE7I2cUK4J17ZZ87AlbDabpE/i+Afnrxg2X9
	dB33qjEgrTwGEeamsq+ScOiA=
X-Google-Smtp-Source: AGHT+IGjmwrfRLjZpy2afiDPxgRP3By2ZfmdgmKI8QXdQ54NCrB5sm5Jf8sRKSl5RtEIq446fz+07w==
X-Received: by 2002:a05:6402:1e8c:b0:615:dc48:1ea with SMTP id 4fb4d7f45d1cf-615e5deba45mr6492219a12.8.1754256321968;
        Sun, 03 Aug 2025 14:25:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f25739sm5964328a12.21.2025.08.03.14.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 14:25:21 -0700 (PDT)
Message-Id: <768a84c8c6ec063717d4a935b86d8110ba0a00c6.1754256318.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1948.git.1754256318.gitgitgadget@gmail.com>
References: <pull.1948.git.1754256318.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Aug 2025 21:25:17 +0000
Subject: [PATCH 3/4] mingw_rename: support ReFS on Windows 2022
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

ReFS is an alternative filesystem to NTFS. On Windows 2022, it seems not
to support the rename operation using POSIX semantics that Git uses on
Windows as of 391bceae4350 (compat/mingw: support POSIX semantics for
atomic renames, 2024-10-27).

However, Windows 2022 reports `ERROR_NOT_SUPPORTED` in this instance.
This is in contrast to `ERROR_INVALID_PARAMETER` (as previous Windows
versions would report that do not support POSIX semantics in renames at
all).

Let's handle both errors the same: by falling back to the best-effort
option, namely to rename without POSIX semantics.

This fixes https://github.com/git-for-windows/git/issues/5427

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index c331c3ac32a8..d53ce38b7f82 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2277,7 +2277,7 @@ repeat:
 		 * current system doesn't support FileRenameInfoEx. Keep us
 		 * from using it in future calls and retry.
 		 */
-		if (gle == ERROR_INVALID_PARAMETER) {
+		if (gle == ERROR_INVALID_PARAMETER || gle == ERROR_NOT_SUPPORTED) {
 			supports_file_rename_info_ex = 0;
 			goto repeat;
 		}
-- 
gitgitgadget

