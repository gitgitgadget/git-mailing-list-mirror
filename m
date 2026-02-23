Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308141F8AC5
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854830; cv=none; b=H6j6P9CekonoLnkGINdR3u+wS0Hrm4UMWalfpRpzYGU22jY8T0MliKisfloI8PwUSYMsy8lOZ36PJeYdKX7pr53Qao0Jc/35d0EBnfU/z5HFeQE2G2p0Lw2VzTTTMPPsiXpJhXe21wAZARbYSK0VXmh4HxIioZ89geNyzpChyC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854830; c=relaxed/simple;
	bh=0rUZe99SO7f8U7lj+8YBlAskhwPOcIrswYxHYujrPCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOw3+CrDPhJasKsLc/M7qMWW96VNo5iPEqON4wHF+2cQEyQGhhGkN/mtyPqN/8R/vcEXgsM5exLpDykyYn5I+ip/ZBnmMUTVekXMi+LgO86tl+gQaVN7Dmv8whK3STkOHPJUKQZtFvjnuuL48+RLlI00RGHAoRauMKtRrWdMgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD8e7O8I; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD8e7O8I"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c70378ddaafso2606072a12.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 05:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771854828; x=1772459628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MJWC3+7WSIOVGtrdHKZHLKkCklxGZDJteHmC4Z3gIIY=;
        b=LD8e7O8IE0FO6znXr178tTIKpzNsRoqAkK0cIrycFwUCsf1jULx0Hbsj38YUhrTrp9
         wcFwc8+sWKXRACYYb3exwF6YYy+OE+0iZa78LO32tl5dkzYU2eUBfOxnmTb3n2D8sb9L
         0zx4mdgf5NxhhbOgTa//1A4V4x3l1tl/r/7wyZkxEtzW7h70F7pwE+yQ5buubfYPveb7
         WQvB85MTt3lbea0ZrGTxM4iKIPkkwMO3q281jvoqlGToW3XG6OdgQWdszNBXjbnqG8+X
         mJNbeKUvjShHHw27W6dATEg6KAs3Lgen+M7DffjuqCo2wykUPz2QfWrXVuliLRLeIgwF
         37ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854828; x=1772459628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJWC3+7WSIOVGtrdHKZHLKkCklxGZDJteHmC4Z3gIIY=;
        b=bGzvqrqGRdjrL4b4xvuVbjQaDJN/ACc5RdpX+4XPWhoZqu9ZZb4AiOQ4iN2umAe8qB
         hSB/Yg4/VpBxzWOF2tf3seeFX0H4RYrKtfisrJRkrOvFPqNimohI0yepIrXOyHV76k/n
         8qBzzxRIx5pmd6cI74UqAka8LLAl0wPdiU7o+StNJZKp9ytv1XTHMO7XuE/m8QTz6GcR
         +m/sA7jmolgRqAxR8OUVxMs14CFZciM/RZ3p4WbwjUtZwhBN1EvTpWNqZ44fiCnAifhx
         xmOcl9C5TXisftyBI3za7boXcKgC4DXshhkJqfbfpaqwUF1U/vySYEs7zeL6jcy0PyJB
         7rCg==
X-Gm-Message-State: AOJu0Yxm/eAVkb+TJ1d6pn1I7dJIJXAq2/P9UAVrms08jb9bmpUMLH3k
	CdL7iF/0bxkTYmHgutNH+k/XCq0ZYIlByzc9fKNcDKCiJIazGRQTFAwqd6knE6mj
X-Gm-Gg: ATEYQzzkvB2jZf4WakfOjfNxAoTpOfTLsdA6FwprB9moUidAWRSZiXMm57It+KmLo1O
	+wFSeF3R/EyOE1ngoxWg/5y6nZnXFo4uVn+GfbIEQPQqH7lshMLlAbZGe4nlyykveFVN1vOhRk3
	CZYcaPn0s9FzD2II/ZzLaP1FSqBOr/Irik7Hl8oYNWg1swsNWFQpar7pJCelAGpeec3g0T7v2QI
	66yK28nBDkCJDUIE5B4PUQp34/MIKOSW8k3FyIFpCzG3YXmUsJGJKe+1Mnf5QUa2ByEnOlIbAiw
	EOhmb8uRe7j7SvxL+5AJEO905jgKDXsaB86EJXm4Eo0ufKv5QqIU6SRBVxbkVSKDjguE04gc5sw
	YuNXvh2WNMbgPfNmWlM0JFfcjGRn1oHTKDXhUY11LS3IIMjGdsXehaJRB8sVLflnzh4Iq4PFVgW
	OJoGHV9ayDNpCW8krfHGeZT1u4C2LSeJxWCEs52+q7NaNdSs1XxmnLI6yWwhcT4pK4HJtZC5y9I
	lTrBEXb8JlAmco7MmSqJ9MMLIuFcMn8
X-Received: by 2002:a17:902:f706:b0:298:5abe:4b1 with SMTP id d9443c01a7336-2ad7456d11bmr77464655ad.52.1771854828363;
        Mon, 23 Feb 2026 05:53:48 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5dcb4sm77565525ad.27.2026.02.23.05.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:53:47 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH GSoC] repo: Remove unnecessary variable shadow
Date: Mon, 23 Feb 2026 19:22:48 +0530
Message-ID: <20260223135248.127935-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid redeclaring `entry` inside the conditional block, removing
unnecessary variable shadowing and improving code clarity without
changing behavior.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/repo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..5540bd25d2 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -412,7 +412,6 @@ static void stats_table_print_structure(const struct stats_table *table)
 		const char *unit = "";
 
 		if (entry) {
-			struct stats_table_entry *entry = item->util;
 			value = entry->value;
 			if (entry->unit)
 				unit = entry->unit;
-- 
2.53.0

