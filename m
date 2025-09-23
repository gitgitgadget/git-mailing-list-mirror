Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF671184
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596228; cv=none; b=ZhqpMIVzRuuHp1Dg5plpZbOpDwZp9Q+b5i07Z7xA8iWOu1C+8DqlhZvOD3KBvhFvx+UPoxAZtbncGVYYVAi9G+oOKJFj2gwCmUzDJhCLH80x+xGOs7tQOHmRtWTITGDPKLfsopPc2AwFvAIOPUqIpyQLS40gYInAHoe0aH/bXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596228; c=relaxed/simple;
	bh=E+y3hZuJ2MD+pXXFUxmV97Ck2AL6GdY/x8GQbycDVqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4/+4VXTNuTdxyaaLwG0hvz47xB5etqguq4gXtSg9yuPsHFWw/vbPfwSo2S8IMd9cMW83jUKe3HnDShJ62mVpX0KDmskajzhCWVVwCD9JlV/qWi59cXT6M7pUIEdzGBMdT95mcC1Kx3J9bjMQmJCW0Tn6Sd/060itC0FrPgGwzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6RUDChL; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6RUDChL"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7859d18aa33so929649a34.0
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758596225; x=1759201025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=htAKuG0v0rBfQuUl4tKndHi9yPqmBjaze6xgWZD4bBQ=;
        b=j6RUDChLJNyX4ufLG7t9u5NzTeXKAv/SmRn0BH5tUiTKrI86ss6mU5CPQBzUJd1Pa3
         6eKFOSoCYJGZwo4VWSH246D2Bl7XBW1sMwj3HXY8iTvvg/V6ZHUu5L/qWnv528WvGfph
         bWFeqGOQQv5vdPHr3wskik/hB1Bg/ORkuX9jBqcwj86hpxA3NVgtdm30ga9uhleQse1n
         /8PO0sDbgniZy9xkuYuQe4Qutkob83gYffmtl8L3WPWpRZwkATIBu4Ms2Ghlabl1lbXt
         qBDS4uBL02lmLCDp0t3BGcv7ZWKp6c4AShDSew9ttPE8Gm7ZxMuCscpQZTL2dXwtBS0W
         WGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758596225; x=1759201025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htAKuG0v0rBfQuUl4tKndHi9yPqmBjaze6xgWZD4bBQ=;
        b=ePFOcsZ5ti4o2Gi9/gODoq6PaaZl2dH3u7aFDY1Bx3P9dHGwW4HdjXtGQSiTEViNmd
         jE5nwhZyJIaAheLsNCUIqTvDxSCOi5w3Yl6D04vwpHxmn2ZRgtYvyvFOSrmNSJomwOSw
         ZgojhkhUwmjT6VaycD0eIDq96Q1OprKOox2+4XbkRyT2srXoLkM8TL6hErgkVcjm1U4n
         UgL4HO4v7n9nKPckaKIaBM2yKwHERnSy+ir/+M4i5IPXg+KKYcz3RTVYUknk3WejhSTG
         L1USqwQIfP7/LM3LNAfUxUZ8u4VoqePY9BlNLTKQbR30q/CZjg0a/Pahl2ixxYf2+f9V
         U6aA==
X-Gm-Message-State: AOJu0Yz+urbTwuawd+5nFlDnGroKhlOiAxvr57yeq7DKftYDRxV7ZW8k
	GgJvNd7FbfDuUfNDTQhrdtXOP72ViTdKDXjso2qlWbPNZkoaORvZ59txked5TQ==
X-Gm-Gg: ASbGncuXbY/9cpF//ozNy8eg7IRddBvhZD6paveMewnKU4C0aoN0K3BiHWuoPjIkQZI
	H6dGPR1HciAQpErwm4M8N3A/A0prp1JhOuaTFbwIBsvnjOf5eyYDrjkll2LT9jOpWG3dI1HgqjJ
	bvjEuDu01p8YmTXSe2ePbLuDl3hQs3N11/xPrCro3m1xwbaiup6joH5XyqmzBrMfCXCsDN3mxyv
	tcU9zwnSFxcGwktN5P9IL3QDKbDsFxSH1EKAbSVG5UgiK+exyl2zr0qW7VWMYYC0sJIzNOxpznB
	5J4WxIeIW6t9rFiLrt5hykPX2zexRntoqGwx6786f9OACgwhlKLlv5LZW2Z+an41NgSMzC+2TOn
	+/nx77pJ+BmfzrKwNFx6qGjIvXuiCCZk=
X-Google-Smtp-Source: AGHT+IFM4d5A3hJk0gFL9fl/GQX9j+n1mm1+dYSxQUYcXWgj+DslYfKllbuT1Q6rpsW2Y7M9vI/iYw==
X-Received: by 2002:a05:6830:290b:b0:761:919b:fe19 with SMTP id 46e09a7af769-79157d565e0mr505044a34.29.1758596225545;
        Mon, 22 Sep 2025 19:57:05 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692936963esm6431664a34.23.2025.09.22.19.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 19:57:04 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/4] builtin/repo: introduce stats subcommand
Date: Mon, 22 Sep 2025 21:56:56 -0500
Message-ID: <20250923025700.3046260-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

The shape of a repository's history can have huge impacts on the
performance and health of the repository itself. Currently, Git lacks a
means to surface key stats/information regarding the shape of a
repository via a single command. Acquiring this information requires
users to be fairly knowledgeable about the structure of a Git repository
and how to identify the relevant data points. To fill this gap,
supplemental tools such as git-sizer(1) have been developed.

To allow users to more readily identify potential issues for a
repository, introduce the "stats" subcommand in git-repo(1) to output
stats for the repository that may be of interest to users. The goal of
this subcommand is to eventually provide similar functionality to
git-sizer(1), but in Git natively.

In this initial version, the "stats" subcommand only surfaces counts of
the various reference and object types in a repository. In a follow-up
series, I would like to introduce additional data points that are
present in git-sizer(1) such as largest objects, combined object sizes
by type, and other general repository shape information.

Some other general features that would be nice to introduce eventually:

- A "level of concern" meter for reported stats. This could indicate to
  users which stats may be worth looking into further.
- Links to OIDs of interesting objects that correspond to certain stats.
- Options to limit which references to use when evaluating the
  repository.
- A progress meter to provide better user feedback while the repository
  is being evaluated.

Thanks,
-Justin

Justin Tobler (4):
  builtin/repo: introduce stats subcommand
  builtin/repo: add object counts in stats output
  builtin/repo: add keyvalue format for stats
  builtin/repo: add nul format for stats

 Documentation/git-repo.adoc |  22 +++
 builtin/repo.c              | 287 ++++++++++++++++++++++++++++++++++++
 t/meson.build               |   1 +
 t/t1901-repo-stats.sh       | 157 ++++++++++++++++++++
 4 files changed, 467 insertions(+)
 create mode 100755 t/t1901-repo-stats.sh


base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
-- 
2.51.0.193.g4975ec3473b

