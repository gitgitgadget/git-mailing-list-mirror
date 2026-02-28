Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19717C77
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772286519; cv=none; b=NSU6I53DIMCQg+NAtpx6SqTRtwXiHTaYrP7xF4uPJ+dBz6pBnSMonwkZ32QXIqL3WtfU7WkmgPPm3YhWYD4qFZW6fLfFWSpXsyWTfTw6SGHr8mJAItpkLdX4C2x+VyjLz9hhznbDL1yu6iW4IHF8DJaItKqPcbr0kcJuIMLnSDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772286519; c=relaxed/simple;
	bh=hQxziG7vmUW6ufRbbzdoD5Qt1sqKluvEEKS7IEbYoU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lzd8UliNRrfYJQgITThtltAyeLcsuVx3cMZgPldOX7+Odgze93i5jpWrRG1AVipcmG2K98Exj0Fnwni/NRe254Vc0sYtam9C/7+dSKGgcjU//g0X5KpKIiltfBcHQqhjaOpy+z60tugJGFZE42PQTsM7vifcV7mkzP/CDyQgUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkgAXCPk; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkgAXCPk"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c6e734ba92bso1425851a12.3
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 05:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772286518; x=1772891318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jI0eaS0bDhTN94PPF5Omhn5N/bdHkIi9EcoX10SWJZ4=;
        b=DkgAXCPktCp2SukHSAj3v7KdHue695iUXU4Fo6CUhehhPu+RgJmmNiCwdl8TO+XGVV
         UXCoA6g5y0uVvbAj3ZV2BOlhkfUl/cBJi+mAfKIUw56iyY3XW6M9oz+v9e2Yc8A7gzoV
         AoSaAneHrjrQcILlkqs362AquiQwCchUuer4lX7rCaPUukSepwcgf0w3PumD9kwArWP5
         1De6cq/474fGGnDxHMxZZen1IwD6uF8aIf3P/pdOUtXMpweAObA41kquxCUyTZRiv/rk
         pAUsZ5ul5cah20YN1HurcD2wsOduZiLCN4nOWOg33Vi/UghzzIgYve2nYiLNeTY+6cvq
         KDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772286518; x=1772891318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jI0eaS0bDhTN94PPF5Omhn5N/bdHkIi9EcoX10SWJZ4=;
        b=s0A/HzpKXsfV7RENYYK2uNBKS49gOBKprXus5OiXw+dyHah6Ros9oW2uS7EtJwNcYl
         ym4zSWcz76Dmu2t0f7XL5KGJMVol4WdSe+D5VoNq0rbuLgCgu8SQbvH+sezQB87QwSIX
         Caxoe2OMwIjK88wc6pfL/6AkjmFi7DQVrksKukPYmgeRRB9BmJtrOkomdD++PXHFHb0Q
         a2djcUT3I8BJTKjZublWsxz+DhpjRtWIV9d19durL53h44fjL7FdKgtg6tHz+4OjYAel
         pJrvp2cfTcBFyfD0FCCItB/SNToS7nSr/b3BWqnP7SjFQTGKQQu0fuqq/JgA8sLuevSl
         cYAw==
X-Gm-Message-State: AOJu0YzfCmcnp5jQ7yJF0EAnq7hM3jV43NGWTT3WoqOdb/rnil3XnTtS
	EuxFXOxgUERJ/n8Uje9MBaAzwAf46F90Fmypz/ZcerYV0zX7Qw7n3PkAynPkEA==
X-Gm-Gg: ATEYQzzo7XbYSnUNLguM8hZDMt6fpwwPMSWth12Gm8bjaQVBTCBGf2bbBLiKd+czzzJ
	9z0K5aNDo4SjGIyyh5uOxUJDZdYVEzxFbFiynQ3ajbzmGXmkce+xiVt42G516MVK1km/81WWNsq
	Y6jt1zuiWY3alOT5zluJkP8YzYyniZeka7+g+K/TEWy5ArTGay2R+fiDlb+h89bEyJhriBFS6dU
	GZozXN4O1zERZwN/vy8u6V3wi8rPidRU/lLdBouhbygb4FkHzWrEyFNALbuCOGIifAdBzhINMSW
	mJ5GNAnwTkoH61Tr3xaHsR64FwB6to1xJHKAQPOWzJ5W5HHqvqLKYB14RgUB7KDPoJkEQRtj/9o
	cKwh88Itwa+pyZsypnzdZHcP7ehEqlVpGJnwKJyLjt+s8UNdmFS+v6JA6hsYi01ACFMWkkZwxPM
	LOIBpVurEw2Xwxd/y2ZIqHBfyyJ6h7p7AuSGQTuTOewo/6yw==
X-Received: by 2002:a05:6a20:d60f:b0:38e:9938:9a80 with SMTP id adf61e73a8af0-395c3ae73f8mr5824048637.47.1772286517869;
        Sat, 28 Feb 2026 05:48:37 -0800 (PST)
Received: from dorna-OEM.. ([103.152.144.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f91esm11502449a91.4.2026.02.28.05.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 05:48:37 -0800 (PST)
From: drona <dronarajgyawali@gmail.com>
To: git@vger.kernel.org
Cc: Dorna Raj Gyawali <dronarajgyawali@gmail.com>
Subject: [PATCH v2] v2: revert per-repo move + add clarifying comment
Date: Sat, 28 Feb 2026 19:33:13 +0545
Message-ID: <20260228134815.20769-1-dronarajgyawali@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dorna Raj Gyawali <dronarajgyawali@gmail.com>

Following Junio's feedback: this flag is a user/process preference,
not repository-specific. Reverted the repo_settings changes.

Added a small comment for future contributors.

Signed-off-by: Dorna Raj Gyawali <dronarajgyawali@gmail.com>
---
 environment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index 0026eb2274..09c34d1776 100644
--- a/environment.c
+++ b/environment.c
@@ -49,7 +49,7 @@ int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
 int is_bare_repository_cfg = -1; /* unspecified */
-int warn_on_object_refname_ambiguity = 1;
+int warn_on_object_refname_ambiguity = 1; /* process-wide user preference */
 char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
-- 
2.43.0

