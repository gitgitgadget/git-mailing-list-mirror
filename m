Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E2366DAA
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981133; cv=none; b=N21JYW8DfDxjYqmqkufn2jJxqBmsR9lHep8EWVPLI9nQaKz4cpoVE6UN5JYk4TW7qjvAnSYv37P2QNpkrUD4FTo8f53O05wW1WB33yH9y8S+qXEsRM9SUyjzp9YU5ks5HuVSSf2MZoLwcqPcj3tscCwyroPKZ17uqwO3gw21F3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981133; c=relaxed/simple;
	bh=ZbvltTBk2RxO6u673XwmN6IKn95QiVwaX+EYx22ScSM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QgmKlQM6G2kfyRbUP8lhiJVLsKbWnpMXHzlHC8ddc0PWe2SVzBxDGhNo6xHQoMZ5cQjV+KmubOLj1uHGrTasa6Q3+sAfK/ksr+RxCLDNal+hSTLwehnuZkJUHWXIRdVIhOqu//wm6IRJ+W6CC1PWd5fulyF4tuCK8/RRZlTUijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpUdfIi3; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpUdfIi3"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6da42fbd4so2955425a34.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981131; x=1766585931; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpPCJ8F0XSC6L7Xc9j8KJxmdrZQSXhsGQKMK39ulf3M=;
        b=QpUdfIi3b3bKrSmSeQ8a1D9OL06q5MuEihT0W7Zzrc54t3jbfTNmUkTxQYy73CAGV9
         v0P7IF788VpwACNGGU+/DNOd6EuxLyP7RbLp8/f1gMc4DnkrPi/Fo6laXMGO+u26+x3s
         1qpvGTv+P5bfpphBslx+ESixE/s/A+BagbHapNacQR5io3peYN5b5xSKsJv8KsM6UEWB
         snq8wiXASOEe3VnjyHMIhqikUkkFT/DM1wDM6RXNV/UzYX1xd3LczdBSkxryJmIXNcYj
         /Ay/EGC2w6yOknjAP5g2QVo6174HpK2IJ95q8sWjPKv9G5cNEmPFnf0OM+24yjt8yJHb
         5mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981131; x=1766585931;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpPCJ8F0XSC6L7Xc9j8KJxmdrZQSXhsGQKMK39ulf3M=;
        b=Gx1VEz5uR61MG1ytmTDVvrp5e5gQENLseKfOd/XcjAfa2lML7zMT9MN1Fr49UKWJb6
         TD/SgQ3YpRaa53scp7VlMF/NhuY2mu8I5mn2Ig+R8ie/q/55jAXRZusEF8N9uzzeYcAC
         TB7UXprqJAXn2Y6SnxzK3cuBsuoAuSJoDEqGe5LMsd1EVPJxgR6Hso7IpmIJIRaImIvS
         Na+xrx6tblmgr5IhVA0kLCC976fuI+53fI97IWeHUXetYrR0XGW2uje0H+eSpdhqKgSW
         H7Frstftyl9kX/pvgHM2zBMM08IrXjKK1V6/TaRtaynAwQTIbGExo04vmpAPzDqmn1uA
         Kj0A==
X-Gm-Message-State: AOJu0YyYNQGGNKbB0KdUy95e/7VHp9gc7LxmcMgYLjiOvycGmYtpcVUD
	UIEpQLCyyDtGMIFGsXg+cSwl3la2UkMkp5B70dUSqhFba+rCrRQSsSoqSRW9XRE04R0aLg==
X-Gm-Gg: AY/fxX7l3iAsg4wrNM3CiI2Em7rcJ4bQBJMUG8GbaXbk2C4wj4g7Ml2vutukEWC3x4b
	aAqjBDTEyhmuAJV2B4vwDek1A09UHaUC/lJHzv+qThSIGoBP8Ol5uGhNmhL17K9hBh2idKTss2S
	1S9+cb7zdTPwad8leTxogPEzqAud0T5es/5dQbMrvrryc9qrU2oYcljxQKADjrht+agV/c/hW4P
	2o7C2Y9Yv47I41WehSW8mGdm9Xpl5gsEslnoabZsePNJdn0UYoqzsKtU5YvGvMwWtpPOVzm1rZ3
	5ntZ4Pn/3yD+wlC68MzkTSX7JbaKqC/BL/AbEe2R9ZTJsi2nvBVlI456wkDEi4cQEQKvg+INFZU
	qSUcTQDSjfQPBkhnNu8Zs64QIgxiyE+DTBHd5EuUkW3/ogp13dlNOc0T9YEc21U9/6h+rl1eApw
	Hxi4hEpg+gEu+6
X-Google-Smtp-Source: AGHT+IEunPTuXUwXGPFK4MExZmB10HrMXb3PJ8GSbMKFr1NiBlB0dYjxIEfRmLIaUnpktBLBqCABPQ==
X-Received: by 2002:a05:6830:43a1:b0:7c9:5b32:b0cc with SMTP id 46e09a7af769-7cae8374e4cmr10979124a34.19.1765981130615;
        Wed, 17 Dec 2025 06:18:50 -0800 (PST)
Received: from [127.0.0.1] ([135.119.38.57])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb325df5sm13294264a34.24.2025.12.17.06.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:18:50 -0800 (PST)
Message-Id: <b97afa9a5c28aa89fd94f210a0dec5de891eb221.1765981126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
References: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
	<pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:18:38 +0000
Subject: [PATCH v4 02/10] apply: symbolic links lack a "trustable executable
 bit"
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

When 0482c32c334b (apply: ignore working tree filemode when
!core.filemode, 2023-12-26) fixed `git apply` to stop warning about
executable files, it inadvertently changed the code flow also for
symbolic links and directories.

Let's narrow the scope of the special `!trust_executable_git` code path
to apply only to regular files.

This is needed to let t4115.5(symlink escape when creating new files)
pass on Windows when symbolic link support is enabled in the MSYS2
runtime.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index a2ceb3fb40..de5750354a 100644
--- a/apply.c
+++ b/apply.c
@@ -3779,7 +3779,7 @@ static int check_preimage(struct apply_state *state,
 		if (*ce && !(*ce)->ce_mode)
 			BUG("ce_mode == 0 for path '%s'", old_name);
 
-		if (trust_executable_bit)
+		if (trust_executable_bit || !S_ISREG(st->st_mode))
 			st_mode = ce_mode_from_stat(*ce, st->st_mode);
 		else if (*ce)
 			st_mode = (*ce)->ce_mode;
-- 
gitgitgadget

