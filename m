Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD921D5151
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772318676; cv=none; b=AA4PNzP/iP7VkP8jdYbxxpHCSDcdE1niTeXy2vYqfDVr1dZdMcBKseZctUwuPvJbmgZn2EhiXto90inTVaB1CKC8EQ5ner+1xSz4ix3/E5nqKt40N7uZBqVy4O1O1QSNG84TfQ+qPLqfCHbzgPs7sEpol8IXat60uEXZDEXjXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772318676; c=relaxed/simple;
	bh=bkBmWYq08dAWVpotFXwhYYjr1JbFlM/1cgU7abpFUD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pOIkpDjqRTJlBE8Rp/ag5FeFx9iRuKrpT/RAmQOv2VRp2H/0omELB6FnlPlLOwITDvGNRcICXOGquyHbvwQ4CYfr15YKTkX/mTmpK16dKL806RxASp77k3s9MPMPKilVfVXmW+BKRtV/3m+LslwEo73huRFnjTqYhdqhyTWZep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXVg0hlx; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXVg0hlx"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5688b9e4e80so3472439e0c.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 14:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772318674; x=1772923474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CsR8WI1WESrOUVmASO13b1wb22h3fY5cfAheR90W96U=;
        b=EXVg0hlxa+N6ppAZWS2ZtMMmi5G5z7wTrHE+FRb42fwU+hXHySHAaSdi2v7O6fuEOM
         IcmpNvhvbbXGyBJ68KzExVAbEzEcV/sSayB/YMBgJaj2erfpShuFlhVLZk+3HlbZQT90
         GPgtpWnRXjHLpwC5P6qkURe1o5iwmIP5t3qt4rZbPN2wKymaHWF3VlioocVfamuFJqgF
         ua4UkzJdop55UAifPsrt067TSKkPPT1p7a8SIztFt/Zo4j6IBVVE2bgI1uCFVnfvYgn+
         C5Q9135qtw4Mw/FJXgxlLF6P3l2YoVs57o4Q22K/RDf+8+dGnIT/MnMvZN73FJy0DFxB
         Xe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772318674; x=1772923474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsR8WI1WESrOUVmASO13b1wb22h3fY5cfAheR90W96U=;
        b=IVp9L1FX/rAKRKURcwqfLhxUNQHjIbHXfZRISNi2369b4W3P3LvZW3CoPzMN4dtIrC
         qOauXh8jakLZYmnzl7ba8gKSWG/Zu0m4dYJib95SQUodjS/AEge+F+ihDLiEa4lM2bBY
         Wq+G27yWsvGfKLjOgcllNeyl7FemguzIOLgSkwpX+eos3TSQodKJLD1FHg5joZU87QOl
         u3bnT/gtJv5K0/5eMFIC3Q8pLQpP6BGLf3qrfSHtfFHviDvFHlQhVZ0Zj0qQJWRctCf9
         tWlNaHzm/ctiYWolE4iSzrHm9Epq2GjgJX6aY0QsVLka3l3yyc13Vx7iSGNpiWi4ldiP
         AHfQ==
X-Gm-Message-State: AOJu0Yznh+5RBQhmFYCBtXQJLSPh+B+CqayaTAIsP0GkZtpPrMQfuXc7
	sV4MUuPCeebHT4PGUuNy+NQXf5Zqp7cSsplSned6CMuVw4pKWFKT8RwvuDPEsEWd
X-Gm-Gg: ATEYQzywMBcHIlbJNXZHStwtJf+cd+iy52fuoSs06P5KIB0UYfIu1VZ65XKdrSa+2bO
	Z4SOIvvUsye3i3OGzIWclJ9lfSVbLfxH3kjLBAxSDIIWskSTXwVHLFx0pIe/AeAerO8B3FdAe9v
	xf6d487TnZjOlIUg/jbJi7sftuujgmMwY9ygtKiWhrG1hvxLnIBGaB/s8DZVeJ2hKblwoL1NKLo
	IH6/z3dg+sSMBTv+vxMbN4ULlYewXbKJjCP5pkPB+JbqkkQvPWvwiXbXy6rw9HS0CSMOo49WFr7
	SnG7T2o2ZKvCV+cyl1hi3ws7CL5d9KXQsVpEEiITEKA7dKXFH3QqPAloYG+zxW/RMmf6xJ1+XUw
	rDeg/SpefBXl4WsvH5bNfjImgkzELpKC7kPRqBrk6fQOrUdQ6brLtji++uOJYcZFk8BB4+IpDQe
	5q5f//E2BwF1OpB3hPJQRaK06Yc5noMrJtvrvviN64s51JUxUwgf2JtnGWbgW3OVYRq0GfNOUJn
	LW/KQ==
X-Received: by 2002:a05:6122:a16:b0:566:2a19:9ff9 with SMTP id 71dfb90a1353d-56a90a265dbmr5451928e0c.9.1772318674008;
        Sat, 28 Feb 2026 14:44:34 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91659421sm11739094e0c.0.2026.02.28.14.44.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 14:44:33 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	jayatheerthkulkarni2005@gmail.com,
	valusoutrik@gmail.com,
	pushkarkumarsingh1970@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 0/4] repo: add support for path-related fields
Date: Sat, 28 Feb 2026 19:05:54 -0300
Message-ID: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This patch series adds support for path-related fields in repo-info, based on
what we already have in git-rev-parse:

1. The two first patches moves the path formatting used by git-rev-parse to
   path.c. This will allow us to reuse this code in git-repo-info
2. The second patch add a new flag --path-format to git-repo-info, similar to
   the flag of git-rev-parse with the same name
3. Add the new field `path.toplevel` as a proof of concept.

This arises from the fact that I didn't know what should be the default behavior
of git-repo-info when dealing with paths. Some ideas were:

1. Add --path-format, just like we have in git-rev-parse
2. Use what rev-parse uses by default
3. Add keys for both relative and absolute formats

In this case, I'm using 1, but I'm not sure if it's the best option. One
downside that I see here is that git-repo-info won't be able to return
a relative and an absolute path for different keys in the same call.

Since there are many people interested in contributing to git-repo-info, I'll
leave the remaining path-related fields to them :-)

I'm CC'ing here:

- brian, who was the original author of the `print_path` [1]
- Ayush, Tian, Jayatheerth, Soutrik and Pushkar, since they expressed interested
  in contributing to git-repo-info in GSoC. (I hope that I didn't forget anyone)

This patch is based on top of master 2cc7191751 (The 8th batch, 2026-02-27) with
lo/repo-leftover-bits merged.

[1] fac60b8925 (rev-parse: add option for absolute or relative path formatting, 2020-12-13)

Lucas Seiki Oshiro (4):
  rev-parse: prepend `path_` to path-related enums
  path: add new function strbuf_add_path
  repo: add the --format-path flag
  repo: add the field path.toplevel

 Documentation/git-repo.adoc |  8 ++-
 builtin/repo.c              | 67 +++++++++++++++++++------
 builtin/rev-parse.c         | 98 +++++++------------------------------
 path.c                      | 51 +++++++++++++++++++
 path.h                      | 23 +++++++++
 t/t1900-repo-info.sh        | 69 ++++++++++++++++++++++++++
 6 files changed, 221 insertions(+), 95 deletions(-)

-- 
2.50.1 (Apple Git-155)

