Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE92D5C7A
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563106; cv=none; b=TOLLf2hJ57RyHXgElfr79lObg9BbeZO27XEwIO+/nS8+f466FRdty6kuASTY72ym02LSohWkWVFvwKM3yheLM+O4DQsmNHX73ULrkibglYjTptvPqpIXHRm7YvC0sK1sTaIY/BlGRAvZgmiiOe7xVMR593TODxxFT8OW5LNqdbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563106; c=relaxed/simple;
	bh=xR1wYbSTaFhwbUBO/RZBwTT+yXVuDpaj5b2EpfSS4No=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Rbfe+ZJyL6AU4bG8N9tqCHxS79bc2XSLfMQE28Icv4gPrOBEmFBcv7kHQl3bVGk8AHuftSp4wwI8ktjUlETbQ1KVyFVgr0XQRDe16xi6g/LXOzXbI+bPTHpSDB/fI17gNrtqpfjJecLrBBfrzDo//jhG+fCRdpAwtL1/hWA9Sho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+20DNXR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+20DNXR"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b67684e2904so4322970a12.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563104; x=1761167904; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOhl2ExQ664nhS2pTPO3ZL3GXm+kcmmOau0240WQy2Y=;
        b=k+20DNXRk8ggVVBHjb2wI+tDk1fkLlU3xn61laOMkk6wLrZIRJ0ceMHahbt1naEiAc
         bP/mrkTJdGTTTS43dZfWQRkWOVQONXLHe9VkMAboaNkN6xwE5WDAgQ+BorS6O6iicLzB
         ZnD/KP3SPN5Xmod2c230qGsbPzzFATLT25AI9wnQsmNaTzQhpE3r7Qq7hfD0DGHIjC+J
         gQzww/fVzCf09esYap/SR0vPPJVegV3MlcqqZpVsrzGkDrEVucVe7b+blxJOmANiG/FR
         KIj1B6tca/NFwD9g36NU/BrrF+zvnBS6eenvYS1kuOpOrGllV+WNPzVdlAvBceW9FUSb
         73WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563104; x=1761167904;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOhl2ExQ664nhS2pTPO3ZL3GXm+kcmmOau0240WQy2Y=;
        b=v5AArdxmZiiCC00N6w7ppmbJDwR3nbasZXcmASPg4PlvPEL9cT9nJjEz+8hHvGSe1r
         KFGpyvb9PGJ7vAv6Uuaob9ncApKuq35uXOtjOOT37oaL9T3eTYrxYXWg7CusaTCp2fr5
         4BJDE3cEBpN9nFhzVzU/i7CAyyZgduyUsZqHrpkOvndvqWixI6xX0AG8RTBmxpXu9WUR
         LmIBSxblCoyaqBMnhdp1qXL3RP1f5lupNv7NH9i0W3PULTtd8BxTui24FhKKV/l/1Xvw
         EIvHlz8fXQsHUWDuGRdLAHrwLUbYGttOn1RMj+kt/llZmqZw/+eOpSRe4jGkDJ4e7Cjz
         g5qg==
X-Gm-Message-State: AOJu0YwrHWaOUuvDx1amwuV6R2el12fvQq35hmTVRwItlSSvKtTcy2qG
	4NO8N4Y9C+G+gGNSspDOImY+bXdsKgQ0e8mZMVHT0LGH2Ga92VOoBgJS15mrkw==
X-Gm-Gg: ASbGncs0UzaBisjtaMMvBU8ehGzbnmKnc9nIGxjn6/g3bEOkaXGmJMOQfdehUq7ECH3
	ohTKCacU1kVnoCsMLuHhOK9FP4R2TvPAzhPZ7UUQHDQlslOm93SfOT/8HB1hKAJu0ELPYnWo1+L
	uexIGWwwDfd8PK+veLOsNi4V8EOgOOSYXc7U/CQkylhQK38K9/3Kywhi4jCDL1ggfevhvwuWmrV
	Vpxa5+JZiaTQuU2OgikMiPUVAUPVr1U2Wpr6Fqt0G4+tl3x0/up4cQJ9UdEHDdZ9YAvh0iiOhg2
	4iQfJwHGFYn1jjW4l+rTjIIRb0mbLzBzHz9eLskWx1d/Zvb2Vqz2EPj9t28CBqAHhkGcZ6oySqu
	47FWA5NH7H7HzFcuH2PVhI4FB/N/dxjK7aTlSSjKImt39Brpc98XW
X-Google-Smtp-Source: AGHT+IE8XMSjf0DweHb+3+TXrALNXqqzaAzhRImi5MxmzTenudblSqTJIIWeF24KzAuJz4Ou+aIrhw==
X-Received: by 2002:a17:903:2f10:b0:275:27ab:f6c8 with SMTP id d9443c01a7336-29027379486mr360285635ad.20.1760563104156;
        Wed, 15 Oct 2025 14:18:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099397d3dsm6156295ad.52.2025.10.15.14.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:18:23 -0700 (PDT)
Message-Id: <1fa9a7d7d1c309f2f651da351ba7bc0b36272d91.1760563101.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 21:18:13 +0000
Subject: [PATCH 1/9] xdiff: use ssize_t for dstart/dend, make them last in
 xdfile_t
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

ssize_t is appropriate for dstart and dend because they both describe
positive or negative offsets relative to a pointer.

A future patch will move these fields to a different struct. Moving
them to the end of xdfile_t now, means the field order of xdfile_t will
be disturbed less.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xtypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index f145abba3e..3514bb1684 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -47,10 +47,10 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	xrecord_t *recs;
 	long nrec;
-	long dstart, dend;
 	bool *changed;
 	long *rindex;
 	long nreff;
+	ssize_t dstart, dend;
 } xdfile_t;
 
 typedef struct s_xdfenv {
-- 
gitgitgadget

