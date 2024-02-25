Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EFE8C07
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708886099; cv=none; b=FN/HsGON5Eftkcx0icBRWw+zYGGFqjYbpt80QyR5nXjPg+r1yTYjPYqbIqtWCo6202T4QVqAtZJUW3ujrxCx7NwNK2gM6D3s5WQMzBeVxFZJng+XKl9Bu+nwWwi5/luTZK8JclZS6b6+homikuGozQgzwJsehDhbtVJNxxO/6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708886099; c=relaxed/simple;
	bh=mjtgOZfWogTFIxkqdKJtrBfnNa2HlIMA6u+hKXquZ8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cjADxbQblZIzwzsQSTxxLb9eyWZuYzvuURgqVlp5iLSSnz34gEiWUFedUL9Ev6RtwjZgpefPYEB/0P9OIOvYAh9Dn9tVR7z9SOgmirWcYXq7xjwfELJ19H92Yvu8E+T+PpTXFUoaSb0YUqllylE1Hdkgnl/TeeIW5QwPyDNNXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jplHXkfg; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jplHXkfg"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512bd533be0so2768034e87.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 10:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708886096; x=1709490896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+nmm6wDWs+GsvNtP1FlKCGW7kc32xpBiKnMAp9Yz6So=;
        b=jplHXkfgT5dVlbI8iyGaLmAAdhlnHsq5KR/yoK7yaD7ixQTodqSlbnATrDB/0gZHcU
         iWXeZuFACYIUgyqHpSC6ByWqy8IgXF6B2hfWyQgqTnHI+D53wXSDupNqhzDpGgPBJ3Lw
         7hAAl+oawo225K44CWGGSoUAwtBl5ivhaSPQxTPUpvkdVRiLLu3wj79UHNicDycVpgiN
         +/RLslh0N2+bJQ2mOsxFGLW799KP2G4lfQ7Bxcn/TOcukZspyIEP0CeRT1sbLHCJhk5r
         icpZbc/+E0Px1vlS6bcjE6XcHz4H918EaDNuBZmtKoO8omxvWC9ao5JyHkCEo5UzaqRm
         yBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708886096; x=1709490896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nmm6wDWs+GsvNtP1FlKCGW7kc32xpBiKnMAp9Yz6So=;
        b=w0WRvGyyiBGUq/lu/pNVkqW8UAjMwYtrqESic01gXc444thBoT1qWoYmIVE0JGflgX
         tf4x+Uni9f62PJ7nL2Z6b2PUMI4drWCNt34WPmZWrmk/Dj+Ls6AJdfuOLKTWFaUHRa4P
         B0lwiJZOuQBzcLHj9zjfkCrgiTTT3M1S/59ajvkBXaGeyTRv7cBr9ODxm05dP4TToGiG
         qVmim1sWZcJFq7cwbSq5AozYRugeKVqbneOujQDJ+yiXhYKBcPig0PO6ZtgPUh9GGtRS
         Aqv6c1te0uLR+zZEJ4nvywJXCkvl4F7aSvoHvXxdZz05GSTkL3JalV6bG8ajhjuspSaD
         mXJg==
X-Gm-Message-State: AOJu0Yxny23WWh0Gu7mdS/SFCxqO+++sXKdPRIwte4td55/0kghtwElX
	jFpBd1E/t3Ox2EjttoxPFm1Zdi66Bqhwh+MhSNq+t7Ts+2mvYREZKklCwb7B
X-Google-Smtp-Source: AGHT+IGHpMM/1hD4MpxVaEQlBtRNs0GnMAR7+ouaVLAETl6fUgMaovQAH/KzQSnAfyTDsPQ7A00MKg==
X-Received: by 2002:a05:6512:3a8f:b0:512:fb30:aade with SMTP id q15-20020a0565123a8f00b00512fb30aademr1325377lfu.3.1708886095923;
        Sun, 25 Feb 2024 10:34:55 -0800 (PST)
Received: from localhost (94-21-146-251.pool.digikabel.hu. [94.21.146.251])
        by smtp.gmail.com with ESMTPSA id x8-20020a170906710800b00a4138c3f065sm1680835ejj.56.2024.02.25.10.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 10:34:55 -0800 (PST)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] upload-pack: don't send null character in abort message to the client
Date: Sun, 25 Feb 2024 19:34:52 +0100
Message-ID: <20240225183452.1939334-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.44.0.rc1.366.g26e5fbbdb0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since 583b7ea31b (upload-pack/fetch-pack: support side-band
communication, 2006-06-21) the abort message sent by upload-pack in
case of possible repository corruption ends with a null character.
This can be seen in several test cases in 't5530-upload-pack-error.sh'
where 'grep <pattern> output.err' often reports "Binary file
output.err matches" because of that null character.

The reason for this is that the abort message is defined as a string
literal, and we pass its size to the send function as
sizeof(abort_msg), which also counts the terminating null character.

Use strlen() instead to avoid sending that terminating null character.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 upload-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 2537affa90..6e0d441ef5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -463,7 +463,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 
  fail:
 	free(output_state);
-	send_client_data(3, abort_msg, sizeof(abort_msg),
+	send_client_data(3, abort_msg, strlen(abort_msg),
 			 pack_data->use_sideband);
 	die("git upload-pack: %s", abort_msg);
 }
-- 
2.44.0.rc1.366.g26e5fbbdb0

