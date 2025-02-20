Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E431FBC9E
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064339; cv=none; b=quNNAaqLk4lBkj0R09FPraOLSYt3yoUvBikFdVSKGGR6PtSDGUQt3/V7YiL1zTz1uS7IeWjYrzm0ORK2k673b9obWeLhzzbj0uiNLlNN+3xQF42j4j60aUsCISXwDN2LIVyIFCdTKdbJ+G3VaRc987sMwhqBwfu5QbmdwzvCE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064339; c=relaxed/simple;
	bh=0GFosttBzpfLnNgQngtfWUB0agjTkKsH5Ml3q1eNzTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UYXoaQkdPbDA1ULwgWtaycYEfSeckq6SjbEBIByFJ0iMUwC45gSuduOLW83jHIa7dHA+sS7xa6tYCEsRjAZXfXt3ioQ5po1VWU8YH9SDXX+mjNPICfOTlOobKwmB64Ngqh94UkeN9ncb2mVXkbwRuChhK59XWBarSob0ViR2cxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcIyHGIj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcIyHGIj"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-221050f3f00so22549615ad.2
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 07:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740064335; x=1740669135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPvBLt4uJIAiqp38SOCqAja/KlsY6c1HKm3uzjDJ4Ec=;
        b=jcIyHGIjNPzf2xAXLnXKysDN50wfCo+s1EIBwfKFIf99fOPZL1HYgz+KgjGqk1On/U
         MAc8z5qOsC/J3lxAVOx+bo1E0hlbbDv19dZ3/iQJCQGONbCxhrey2LL1zxpbl78uKQWO
         cQeE5vh1Pyf6ZuRNYO7+Vt5lS/5c8l0YAAqBPauAnWqLWuz+13DIOsvP02aCg1zCxMvt
         3ZYqsRPBQAxACUk+IqvBLxEw6pMwGHFJtFQllFa6ytoG8MjEg8VChw0oJND5dDHpjmpa
         kmP16rBP6YoHwLdstO46+RGUsaKKOtDETJnktFz5MocwmBXUc8PTfzje4WZJe1EXmm1e
         yLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064335; x=1740669135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPvBLt4uJIAiqp38SOCqAja/KlsY6c1HKm3uzjDJ4Ec=;
        b=Wxytn9b9utehoax1Nsuc7bhtCFsphXMv1QKjPzPoZ/HXNbRaIGZxAN7nrZafhZFFvf
         pdzTVDtND0s0jYL9ZAr+zeWLt/dyj2zN/Lo4cCw6JKztj65JDRIUDwixKbrqMbIbS3T+
         hWIBb7/J0oKyyR6eWcZWKQJxyJZ+uZeXlXTppwqJwVxWuJKwrR+7gJQ3w/8NM+XvU2Q6
         VnUjfAKBDqIpRMgxdyLyQ7atVw1EgVI4S+EW/GcbUIJERnRhdv2jVbm2UmIpzBW/Vtzr
         zHDY0k2mq2z3Q6/67uOzxgDv1h8rh+OZDIJrpuaL8d2FGPDP658RBuortM//+PeNGn/a
         4aPg==
X-Gm-Message-State: AOJu0YyfVBLpaCkv4d7L43PBwplEt41ILqoEqrq0i2Tdw4/JYWU5eubF
	nkzjiTbG003A9ZHq8GZwlnMd1y3kqGNB2BvXccZAG+zhxlmWl0C5JRBysMsg
X-Gm-Gg: ASbGnct6FMqdDp6kN0GWjj5V/3LC1JyCLxCt4CIpFDivjn1NuLuYwvztBvLUAcqZLSO
	q2vfhYpW0EX/RK47WQUZCaBkvbJgi+PeyETM06wUxgIJaWEzrtuPR0NG7Ax9ztfQ8tICQfrQ6cT
	v8WzCt9JXT6YXg6tl+otmoqblES3bVxEb/hTYC2Rm5k90GZWwtq+iHKbLRbl7OanZfqZCSseOgB
	mdep/vrpfTK6AgqXMv6+Brm+IcO0RWyuuv5s1rHTJ8wr/wQOKi9bpHE4YdWckybiqKOcVykiQ3H
	nnbVwnPviMw+8eTUpgt7p0y/aL+g8oXDcEKbKExZiPcBxQ==
X-Google-Smtp-Source: AGHT+IHD2GOiDlPWX3gPBMrVhTMjmREtN83i6OhgYyuZ9pwKO3a8HZdmUrELSILa0TnkNb7o8TJ/ZQ==
X-Received: by 2002:a17:902:d4c1:b0:220:eade:d773 with SMTP id d9443c01a7336-221040409f2mr428272085ad.24.1740064335107;
        Thu, 20 Feb 2025 07:12:15 -0800 (PST)
Received: from localhost.localdomain ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d453sm120839735ad.115.2025.02.20.07.12.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Feb 2025 07:12:14 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC][PATCH v2] merge-strategies.adoc: detail submodule merge
Date: Thu, 20 Feb 2025 12:12:07 -0300
Message-Id: <20250220151207.3248-1-lucasseikioshiro@gmail.com>
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

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---

This v2 changes the documentation text to a clearer explanation (as
suggested in the v1 review), and changes its location to
merge-strategies.adoc instead of git-merge.adoc.

This content is duplicated as this works for both `ort` and `recursive`
strategies.

 Documentation/merge-strategies.adoc | 15 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-strategies.adoc
index 5fc54ec060..a7fca249e2 100644
--- a/Documentation/merge-strategies.adoc
+++ b/Documentation/merge-strategies.adoc
@@ -21,6 +21,13 @@ ort::
 	("Ostensibly Recursive's Twin") and came from the fact that it
 	was written as a replacement for the previous default
 	algorithm, `recursive`.
+
+        In the case where the path is a submodule, if the submodule commit
+        used on one side of the merge is a descendant of the submodule
+        commit used on the other side of the merge, Git attempts to
+        fast-forward to the descendant. Otherwise, Git will treat this case
+        as a conflict, suggesting as a resolution a submodule commit that
+        is descendant of the conflicting ones, if one exists.
 +
 The 'ort' strategy can take the following options:
 
@@ -95,6 +102,13 @@ recursive::
 	renames.  It does not make use of detected copies.  This was
 	the default strategy for resolving two heads from Git v0.99.9k
 	until v2.33.0.
+
+        In the case where the path is a submodule, if the submodule commit
+        used on one side of the merge is a descendant of the submodule
+        commit used on the other side of the merge, Git attempts to
+        fast-forward to the descendant. Otherwise, Git will treat this case
+        as a conflict, suggesting as a resolution a submodule commit that
+        is descendant of the conflicting ones, if one exists.
 +
 The 'recursive' strategy takes the same options as 'ort'.  However,
 there are three additional options that 'ort' ignores (not documented
-- 
2.39.5 (Apple Git-154)

