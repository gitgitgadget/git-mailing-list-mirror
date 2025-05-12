Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8020027511E
	for <git@vger.kernel.org>; Mon, 12 May 2025 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054152; cv=none; b=rMUEdYQgPlDGx+1Bc5LrBbOStehVDijYzYmzKy0EOUYKkNvU1TPTcjLO+nRuFVTYTNbaJxicJ2k05FVpJOLv7JiYSKmWhiQqk70GkR2c3wmVMzgI7eB43VCvpRJG8VQcIZqHGWwIZHGz8+vtjN9lj5IV2qbbldgXZB5INk0/o9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054152; c=relaxed/simple;
	bh=/Ex1XeGcBVIVN+BSQKdYmZ7Anjyo75+M0r9hsp3sGGo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MCJHiRv5EbbtBdewRVq7TNw0eSWifI2xNzR12Jal+N3aOVqmPvrAkKtBMCCD/iVdKYbkJe25PbWvA/gc8LZr2Gh9a1saMafzi19711wekEcE9qH6vJxka7XwItwMxKvucId6GYf0JtmNwurIhEjuA/nyyRnrUC9Y9vQIOw1b/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m33bbfum; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m33bbfum"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so45535405e9.1
        for <git@vger.kernel.org>; Mon, 12 May 2025 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747054147; x=1747658947; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVT3OXSnnx2cMzNxja5B+ThuXocumv8v6ldV+xD81j4=;
        b=m33bbfumFqDM4tQkyqY9lriAZfcy7wUPd3UIC3QcBb4gdnvrmrVa4x17M/eLn7Mdkm
         jFS9aSHLcpkzu60R4qLh0eUHs/KvHdslfQSrRpLvNH2YL+ZIh3DPAXuhJDKYqbIWzVHK
         vHnCNxfw9+y2V7ZNE8OZKDHsLedfIrQun+Cat2pkXtcGQcS2eVX7F8iQOUkB2av0Qj+0
         4tLaqJRKFrXoSnI6rbmTruWMkRO9adOirrdMtFigPxkJWE/eyysw+dVE0D0xC9BD9vr9
         7OL+p6bQg4l8ieC6tW5bMGT9kBrhPkENKPIzTtOV28yLpii2Q5+zrKKG5uBeLP9aETbU
         ikDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747054147; x=1747658947;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVT3OXSnnx2cMzNxja5B+ThuXocumv8v6ldV+xD81j4=;
        b=P9OUYiBfSrclrrItC6/R6Wkcf5bkg8ii1CARlsccJBmaLtYmlYSaOtsY0w+ppMbmAz
         xqUbrRT7Pl4EAsPlZJ4s9xQLQE6EplEV/54l+K9UijpAvbyEeqo2ADqO8tDgzzeOYsVt
         +b0mEe9Ur/8aqzMuezyiqySJdTGw9JOodUIaYLOOVH3kifVsB3noNCJMoovKKVuI7IDb
         r5VJ8Xx0WW1o+khGr/45yFiq23xNgWnXz2OyAdnfr+zuEzBdNWL5PSaVPbkaED9JS85X
         HzJC6Fh8IRzGgqf15MHuaLvo8Pizxjaefy6811ck2fCJx8vmrRyav330OO/W1+dV1ZKZ
         2NRg==
X-Gm-Message-State: AOJu0Yyr4B77s+91tBezQo3J7850pHr1BSUNR4wpuBbs2t3274c1Sa46
	KRlksnL0CKX/HW+vD7REyQX1BrlIDFgKjTESS+7SG81ijtidz6EAXIaIYA==
X-Gm-Gg: ASbGncubyyDdk0NdCJDGmQdmk9TaKxoAIebUrYTSdvbRjEzpoK/p5Ggzn7ijkdnaP6d
	mPTMhQcf3Qbanu/byk56QaVzisngTD9XSXLXSRPz1zhccLkfej9DX++YxFkFZ0ugT8vFfuChnWf
	/2FXpfTmyY/fgj5298kp3aPvG0OsR3hRv4/We9B9gtt+14wAhyT5EVOltNU102oVrVJfZLNccB3
	9FQ26mvFrukE6tbGlxkoQS+loFL46RbyZIEC6kinarQIudMvVR6xBy7EQ735mQm7LPsPOFAtTBS
	yDw6jrgR9XOhvvhj2u60zA8qfc3gPop6+dTazV0+GsFBWEpLUlKP
X-Google-Smtp-Source: AGHT+IFGE6vQR/xhRWEZyTf8OjG19IOkrVdBWdxrfBTXvtNL1IEs4UtXUFdo2FknrMHxJAxuJgzWLQ==
X-Received: by 2002:a05:600c:3d05:b0:440:6a37:be09 with SMTP id 5b1f17b1804b1-442d6dbd4f3mr128008025e9.16.1747054147238;
        Mon, 12 May 2025 05:49:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd32f194sm168985135e9.10.2025.05.12.05.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 05:49:06 -0700 (PDT)
Message-Id: <13ebdd672ff1a76ef684d9260b782c750c65ddba.1747054145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1958.v3.git.git.1747054145.gitgitgadget@gmail.com>
References: <pull.1958.v2.git.git.1746980165245.gitgitgadget@gmail.com>
	<pull.1958.v3.git.git.1747054145.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 12:49:03 +0000
Subject: [PATCH v3 1/2] reftable/writer: fix memory leak when `padded_write()`
 fails
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In reftable/writer.c:padded_write(), if w->writer failed, zeroed
allocated in `reftable_calloc` will leak. w->writer could be
`reftable_write_data` in reftable/stack.c, and could fail due to
some write error. Simply add reftable_free(zeroed) will solve this
problem.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 reftable/writer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index cb16f71be49e..3ceb37428887 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -57,8 +57,10 @@ static int padded_write(struct reftable_writer *w, uint8_t *data, size_t len,
 			return -1;
 
 		n = w->write(w->write_arg, zeroed, w->pending_padding);
-		if (n < 0)
+		if (n < 0) {
+			reftable_free(zeroed);
 			return n;
+		}
 
 		w->pending_padding = 0;
 		reftable_free(zeroed);
-- 
gitgitgadget

