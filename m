Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911890;
	b=5rqyVAEY0fd8GLgJaVpuV3jUpY55DaKHxZ6MVSv19Rb20o7tnMRrVab4B2/4mZSlxG8j
	 CvO689FhCoYsH8Fw1M6ywTn8bdxv+vOYYNIYAdlGxZdOnHk1yw2iginieDk7gL0Th+LDz
	 EJ/eDiLNHrW1Y75IsVrdHx7YOp2H/Gz4pFDSViYfsWk6K/J8zQwhimY2B1ISlSOuBJ9ja
	 3sE06jDWJlkCudeclpVWJVs2+FxUyp3nhiDPBo0NG00T9UUNZ8pUr/D5dOj6UjRTyIX9C
	 sq6XqfT1uV1WQOJvPI7rm9Gql553LMj54TbqmvUyBEOpT2iD1Ma4CtE1Rzfgx9TiSrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WgBAFchSM0ukp7/Xjkswu8plhhaucOrtBSThrOjqYFY=;
	b=Sl2UwZPXQu9AlVPWhPYnmSNXsP8T2WxR7il9SFB2XBHOAzV6aLAccnV2H7DrOYDbtsFF
	 6IauEE8qltRSz4gJMh62c7QYCm3oWijaF+TQ0pAIhHGRaVel3zXck4l0WHBU6CuKor7Se
	 WMCVoLylPMChAVpDRCbByW7Cho5gAmIVw81cu5Fo2k4jw31rPhPPcLK7AA1RWpojWPbke
	 JqmVR8AlWa7HuRe6XjkpV1wEndRbc/nEsdF8G4CVsiz13c6Ia/XRFn2y3I/Ant37qCYOD
	 MLvWyhkryjCEXZA0ptSs9he/dhI887nkog7oTTc7chIOV7nt9jaZ2GC22IyXOu5MKjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpS1GDSR;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0831606A895
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 10:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0831606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpS1GDSR
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a42b34e930so378045f8f.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 02:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794911888; x=1795516688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WgBAFchSM0ukp7/Xjkswu8plhhaucOrtBSThrOjqYFY=;
        b=HpS1GDSR9jD50zhUPfRXbMoHEmXo8bWMyqxLJGA5ex/e3QZyDqPoFUv7jyEwZiIgR/
         xMUtWQUGOOZL/ZExDp8HUKLIIeAtIdP7xYGpNzFQaHSpP1JlkFVmh967aorDCRtAS16x
         zBEnaBh42+WGT6hM63xkBo9MBxzWGd8wiXSVkOHcEpM9cnj8LYs0BOD12yJ7uicKe+wi
         gafy0awr5aQaQVqVWyeKfaycAZB6BWrbCTMuE+NGqJCb/gIG+q4xaIhRAaaT0qAG/hMH
         HVo39PnQejxzEOHhDJEPW4fpZhEfcCSNzBRvafyJBKnvsN3xvRDcoVqwh3No3pOV+M+G
         raRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794911888; x=1795516688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WgBAFchSM0ukp7/Xjkswu8plhhaucOrtBSThrOjqYFY=;
        b=VOJ/R23lAZhodTJ/7qr/wW6VNetZlAf9RcBohEbgF2YJpRVtZqhy1u7BUwpHoVhHOh
         ERRu9AR4qCtmdijjW9Esu0+gbfc30ZXucL/9jtyl7oalKEARA4zBHApLqTYs8rYoIILs
         U2o1qPYjpi9rzsCaABB70HojKPzeA1BYZcS9umhjs7H/BA/39mwP4x7z/KMhrRKOk5bG
         /xkRaWBhbq4efuZEll7/UdzhmBqiRB4CeXHcf8fW/uf373/742u4/8MyrS8Ky8gB93zP
         vCIHr9Oh/nLw7sVd7MlekI/EkoGAzD0Jr7N8B4F3bowHi6NhCViRrfkzLXhgqxXjjU4D
         6Cxw==
X-Gm-Message-State: APuU4Z8eM6dqJEkxMh1w8Z3FNHXDhgKx98yk4SBdoax38HQLCyFS8eqW
	d0ZYbMMZrQpl+x3Lar4NsshJtQuTGaKwLVGIYmLQHo12MIokxpWaaITqYE+93Q==
X-Gm-Gg: AZFdTZc6fhlCnKdNiVyxU5IOEVCzo+ll6gd6YUOrrN0+ipKBBTkD+IP2scAmOQfelWn
	NVlku7IMd+DMdlKZBqyr19hdr2RLxgT5i6slUTGMyQPl4g5vhaZhgJxzei8LWObwKWLKcyZC/jN
	p3rR3xgOOnBtMQ4Ff/pM02eKFPVOvQclIJqq5KdJMBjkv+goTEp/8tOUmEURJj+M2QM5gKZkmbZ
	WPgjZb5ZhKgxSi9Pn00qkw3HmmiUNgxZt9KI3lRC0e5Uu5+H0RA/hfifVqJpyUabq5NCzDD5E1g
	LjS+GexvwRujeTFOM64FzYr1B1F5UPua+mpRhzWiNX5Jr38rQcrdTPjCTtGh73Mvssp0v95SDu1
	zDrqBjtASpK/ltk8JNHhINO/x7HaqasDF0T+PZ5KJgJNP0CwxQ/d02MQidKM/evSE6kisn8LTgH
	6ycB4I9N/K4RpKKFLoGUQipnyfB+YPu7HyL+oE+QsfgZIY1AjD3xAaoMmK42F7KzL/oMPpaykRY
	yB6NVtBT3S8G77dPxYNY9SpwE/GqhvjG62WUGyv/dwM8yghe1T4CL4m+IlFO0siGU8QmExiahZa
	NbITK1zXmTrOtdhwRA6ZLxV/THQxeKjLWDqCK8yLgKQ/B7E74N6+srauX7POu89Y
X-Received: by 2002:a05:6000:2010:b0:4a3:1e75:16c9 with SMTP id ffacd0b85a97d-4a31e751912mr5733653f8f.40.1794911888270;
        Tue, 17 Nov 2026 02:38:08 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm44715932f8f.44.2026.11.17.02.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:38:06 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] diffcore-delta: use size_t for the size of the buffer to hash
Date: Tue, 17 Nov 2026 11:37:55 +0100
Message-ID: <3427c3d2c8c689371bcc111f0915853a0f679f5d.1794909894.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794909894.git.gitter.spiros@gmail.com>
References: <cover.1793546752.git.gitter.spiros@gmail.com> <cover.1794909894.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hash_chars() in diffcore-delta.c takes the buffer size as an "unsigned
int". With a file of 4GiB or more, it hashes only a prefix; because the
similarity score is calculated against the full size, similarity is
undervalued, so true renames are missed, which also affects
"git log --follow" and merges.

This was verified using a 16-bit simulation, where
"git diff --cached -M" reported a delete and add instead of a rename
(e.g., "D a" and "A b" instead of "R099 a b").

Make the size variable "size_t".

Triggering this requires processing a file of 4GiB or more, so no test
is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 diffcore-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index 2b7db39983..7f10f79ffe 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -127,7 +127,7 @@ static struct spanhash_top *hash_chars(struct repository *r,
 	unsigned int accum1, accum2, hashval;
 	struct spanhash_top *hash;
 	unsigned char *buf = one->data;
-	unsigned int sz = one->size;
+	size_t sz = one->size;
 	int is_text = !diff_filespec_is_binary(r, one);
 
 	i = INITIAL_HASH_SIZE;
-- 
2.53.0

