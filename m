Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5B2AEE0
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 01:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620666; cv=none; b=OLEzo0Dgc0Adh6N74JXP3u+MapH4fw18i5BPDCoNIPAZ7rir0R72O/7RRUY6i21dPUtxnOP9StGZpBauqs4Y8qbcgCnGC2SH/Mgb+Kz4ydm5alG/4XZL4gpXK9lj5aZK+ZIMSUw3bTdd1PgVteUDziZlNCHPckHmDS/+4bacYwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620666; c=relaxed/simple;
	bh=/njoAJocNLgc3H/3Tb7AFjxhFzmgcUOJ/HPBMbQUoDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NlJvGKq32kwurtHqpOGxsxrgbiwhR+SG8De7VJkh1wz0SctwDhoMjIpWKyO4AKkpKcejkgiouuylnEgDlJWHUtxLeAFw5Yiq7JMrAmtiJmMBhrfeZYiQjjjGPOsMbg3UVJdP9fZCJ3QjMK2C39qBjEiL4wk6NzO1WujhfxYfb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB9w1aY3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB9w1aY3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22328dca22fso5264915ad.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 17:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740620663; x=1741225463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wwdETlyemZjwhpLvdBVzvMpnzLEwOw4MLcBTRm+zsBU=;
        b=YB9w1aY39yApYGEEWCPLGBY9BBb6xSL5YjxRvsr4T5sgDpWVG1GttXr+9ZXbwTaYxQ
         d7T60UKrl0wNCI/jlL2J+jL83e/A0ri6flALAbSjcycDt79FIySyFEgve+aHAktLiinC
         uwpMdZuRoK9ZDvsbIuP92bsqsQ+DEP2zwL0VhQaU5XgNZnZTZnZuVBcGx9Fd2OGakf1+
         0JYdF+cQC2r3VGPYVI82r2oDLOMLQP9CzAUejVxq+CpNIGtLJerg/ItXpE5SOtoc0aML
         a9qZBf5DK+CNeSiY2CgGLRlz5i2YTBonh7cpNvMFBT4KoQHaDit4gRlKp6ppk/E5/q7V
         +qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740620663; x=1741225463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwdETlyemZjwhpLvdBVzvMpnzLEwOw4MLcBTRm+zsBU=;
        b=VQmZDaRiDL9CAl2hxeuqfAFCvLx7j/YbTGOogZGc7jVWKdP7/iZTGPBakWMjIPsVu2
         ZVd4A1AE7ZARlOV+vd+4qnJwvb4xmGTtDwaSRnl+ESErx65jAhGwra0Wm3soPMTSoV5m
         qpkEIJOn/ANsIkYDuLnDaAOZdo8GlqjgsBjB1dKgGGmzGE0aCHEEKb/j71kGFo5sDaB9
         a0sH4HfsLcPO2Dsj2X/FACovTqInMkqs2xh9hEGbD7GOaBHGJwwU8H2vvsiSqbOP+mKh
         98GMoWcBCl5HKQ506VBg0GHYqweF2ynHsOY4HWiSbWIHe3JmkPH6qleKx++54kQxp7Vb
         S/pA==
X-Gm-Message-State: AOJu0YzFj9QvRfSt44/UvDZW9S/CucYnfkc9YeeGblkC3OyrhcfjJ1ie
	/E9X/k1elWmlRZpZJnerkICSte2T7CjGe458NVwA+ITM74eQQLKtt/tWhA==
X-Gm-Gg: ASbGncuyUa963hknJ4LXotW8aTzf8vCs8LlzrtQFGIjnZbiWO7MNs7t29E3h+4JGhL0
	AJXsk1Cpj8A1U52Aamw3IEMnRlU5WNWscEH7z0WIZ/hhloLBUORiFX3SHeMMJgCTLWr/fIseS+3
	ruHKjBEB/EY3s9RpeRQqVAV0jZX5k7Ch1smgbPLE80Y5uWRxxzEZpOqV36Qu+frb1aAuOOUi6A3
	Yxjbz/q1sXJukHd0TAngulwyTl7/bgVVsuD5GnjO1yHW6umWw5IsZz+7nVpHyswKJGAs5ltOScf
	CqhP8a99iD2W2We6OTKdaKFyuPtSI00+Bc6VQcNY4l9N18OaYUawyEMA0YXLYKMLGA==
X-Google-Smtp-Source: AGHT+IG1UEe92VcalTFuEoToeS0FB9BrIfC4nI4gjV6WbiV4retRSVxZryEO4ynIOOgWue4Iv8MtAA==
X-Received: by 2002:a17:903:94b:b0:215:6489:cfb8 with SMTP id d9443c01a7336-22307b33070mr160645835ad.10.1740620662903;
        Wed, 26 Feb 2025 17:44:22 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:32:8834:3146:eeee:59fe:57ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9723sm3218695ad.56.2025.02.26.17.44.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Feb 2025 17:44:22 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC][PATCH v4] merge-strategies.adoc: detail submodule merge
Date: Wed, 26 Feb 2025 22:44:06 -0300
Message-Id: <20250227014406.20527-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Submodule merges are, in general, similar to other merges based on oid
three-way-merge. When a conflict happens, however, Git has two special
cases (introduced in 68d03e4a6e44) on handling the conflict before
yielding it to the user. From the merge-ort and merge-recursive sources:

- "Case #1: a is contained in b or vice versa": both strategies try to
perform a fast-forward in the submodules if the commit referred by the
conflicted submodule is descendant of another;

- "Case #2: There are one or more merges that contain a and b in the
submodule.  If there is only one, then present it as a suggestion to the
user, but leave it marked unmerged so the user needs to confirm the
resolution."

Add a small paragraph on merge-strategies.adoc describing this behavior.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---

Just removing an extra blank line from v3.

Documentation/merge-strategies.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-strategies.adoc
index 5fc54ec060..c8d81bcda6 100644
--- a/Documentation/merge-strategies.adoc
+++ b/Documentation/merge-strategies.adoc
@@ -22,6 +22,13 @@ ort::
 	was written as a replacement for the previous default
 	algorithm, `recursive`.
 +
+In the case where the path is a submodule, if the submodule commit used on
+one side of the merge is a descendant of the submodule commit used on the
+other side of the merge, Git attempts to fast-forward to the
+descendant. Otherwise, Git will treat this case as a conflict, suggesting
+as a resolution a submodule commit that is descendant of the conflicting
+ones, if one exists.
++
 The 'ort' strategy can take the following options:
 
 ours;;
@@ -96,6 +103,9 @@ recursive::
 	the default strategy for resolving two heads from Git v0.99.9k
 	until v2.33.0.
 +
+For a path that is a submodule, the same caution as 'ort' applies to this
+strategy.
++
 The 'recursive' strategy takes the same options as 'ort'.  However,
 there are three additional options that 'ort' ignores (not documented
 above) that are potentially useful with the 'recursive' strategy:
-- 
2.39.5 (Apple Git-154)

