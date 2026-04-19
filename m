Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB8199D8
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776588527; cv=none; b=VGJ9yFWrDP7uF9FxOOeCumOE3UYMZNIrKB0/NedjAA9/9OGboSGSppjl53PrhM5Z0l4Ll542wiHCalHTaWiUqpb9NNMbG5kvFWr/DssBGB32aBcG/P+IV/Z1cv0FEB/hS0MyTg9Hfuf/JYrvo4EwCOQU58CGXuyUzT/STCvYfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776588527; c=relaxed/simple;
	bh=+/GqXyRuNOJyzATX3lZcPwRVeY5MjSmwl8yDvLcX0M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ak5KHHj5xmIqQTT8nkVx68jmcJoLCjLeH8qz1xQp8M9uvtFAw/tBVOZnDPuMtsfI6ovqSlu8dGuQ7AeW0S1cBELlAfD2f9VkIgTDDTF/zcfdwMyeNvJKoApRt70nPB3iPCB/1LmyZdDPDuWmTgKLJxsBQWph9aTOHHRwkc3KnVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nur6HDof; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nur6HDof"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so1103988a91.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776588525; x=1777193325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZIFwgF/hOa4Qbc/Yq6pghN8HgpHS5r36R/Xg6GvMMw=;
        b=Nur6HDofcH3aFbsEmenE6kxvnQmwZuAy+6c1JvSJENwRJiHgksnxWXgFFQyhv21+vY
         fNo9sUqt7iofZR4FckFODfPDf1d4kRqUnkICbNA+Xivf0g/W7GRJ4nFZCN3Rp5huNcsS
         VSbNO91z0WMjBoBRNoWi0mq/WmmIzBFfw0j6Wlbu2ipobwnXnWcs/mQ3fD8AVIWtxyWt
         BOiOefr34+tDVJVflVMO3uqCthR5qxZ4I6h1Zp/IfNrcGCr23TbOzuhBH8QeKQH7Gxmh
         8mPTtge4Zbe+OFBKjD5ePVgSf1dENkO//OiWyVZAzO41NhKuWxqmIU5MLEB35ycqOlar
         PYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776588525; x=1777193325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZIFwgF/hOa4Qbc/Yq6pghN8HgpHS5r36R/Xg6GvMMw=;
        b=ZcdmFHTy2ePZlg3p2YvpyWG5d0vSd5WYwkeqBZ4lNqv7gDo3YXgBaHYfs1PQU6943C
         GIF3ZKaL679KXjcI7oZxzjf/ZMwsYUDKoXbivn2EGeB+sWK0Kx5sJcKH6PuZpuCizch+
         U5MRsh3G1Ya6V+wZVFZo9d485B2Vt/KvQeIfTbdb5+WO90Gugwpa/3eANz2jbhZZVsUz
         ThYHO+8Eb1W103O/yt18CIL70ukLFUnSfIHueBgDdJdmVbDe7uOw7NCIXd6zVu2F24iv
         mtFTMyzSjC8YYfMjpWd3zg5zWMJYwsxHdjz9RAfYxnqA3Ib2EPwY6aMGESHQvd4tylOb
         twZw==
X-Gm-Message-State: AOJu0YyyxUuZ4Co2Dgc6KTzv9aDcTuVpKlrinOEDpvIHqFqz7lzEtOyt
	6SQBOexRFcXhUIYQfROs5Ax9f70/7XfHP+pfiZ2tW8Bf3Xybe4MUUtNrQ/H50Q==
X-Gm-Gg: AeBDietRwUUYtFszf72ZxrHxa3gDkv8aLR9ljprf8oWehoHejH65HosH80Sh4888F19
	YjxfmJEipo82Vs/vO8n9oWbGCnaMYqvswmHH/Ris9vZUxsxoTa21a+38Vo4fgTxDNp0DzwmECDN
	E0I7Y/NpSBYAoBrZqe4BbFCC0n59mRS9JnRaAVqgE1OeSKP4rm/H6Tg0W7RXlXka1Jxll4FRIep
	E2SZwOWbTqV4nnlFtZd0BRR6XSKUJZQXY53BupjIXNWSA/zSywzPIcm2D2DZXBt+w6n0e28C8yc
	RkR6E90piWnAI5+rRkPqxHxMxgu/jHFx/RbQiVdo0JbhXDSdiu5moo8p6F6kSsmAR+GDPwl3fL+
	ALHlMLFrMCxoq+l5De3p301XUImXtpgwggwtu8obo+B7Y6qHb2fjDLZEl4WuJgJ24VN12++J4Zf
	anywVvX5LSC+qyjLvz4G/uW0qbeJQmX5wIOj4ehE+eSmWr4DMJ+zIWeuuQq9j7eBOuvKz7
X-Received: by 2002:a17:90b:17c2:b0:35f:b288:8e4c with SMTP id 98e67ed59e1d1-361404650f9mr9460193a91.15.1776588525170;
        Sun, 19 Apr 2026 01:48:45 -0700 (PDT)
Received: from localhost ([2409:40e3:40f3:1d3c:b014:b093:7cf2:7c44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1739fsm70473975ad.22.2026.04.19.01.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 01:48:44 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	toon@iotcl.com,
	ps@pks.im,
	karthik.188@gmail.com,
	justin@parity.io,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v1 0/1] rev-list: add --missing=print-only mode
Date: Sun, 19 Apr 2026 14:18:39 +0530
Message-ID: <20260419084840.33986-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

At GitLab, Gitaly uses `rev-list --missing=print` to find missing
objects in partial clones. The current output mixes present and missing
objects together, with missing ones prefixed by '?', so Gitaly has to
post-process the output to extract just the missing OIDs. Having a
dedicated mode that outputs only the missing OIDs directly would
simplify this.

This patch adds --missing=print-only which suppresses all regular
object output and prints only the missing OIDs, one per line, without
the '?' prefix. A `missing_action_prints()` helper consolidates the
repeated three-way checks for MA_PRINT/MA_PRINT_INFO/MA_PRINT_ONLY.

The series is based on top of 9f223ef1c0 (Git 2.54-rc2).

CI: https://gitlab.com/gitlab-org/git/-/pipelines/2463294546

Siddharth Asthana (1):
  rev-list: add --missing=print-only mode

 Documentation/rev-list-options.adoc |  5 +++
 builtin/rev-list.c                  | 49 ++++++++++++++++++++++-------
 t/t6022-rev-list-missing.sh         | 26 +++++++++++++++
 3 files changed, 68 insertions(+), 12 deletions(-)


base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199

Thanks
- Siddharth

