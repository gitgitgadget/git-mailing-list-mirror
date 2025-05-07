Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE370824
	for <git@vger.kernel.org>; Wed,  7 May 2025 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587252; cv=none; b=HGkIfLVQbUjpeIXlWlyaLqtCpXvgi5cxI4ArxwZIn2rb0Ef9ROoLZ6bjRyYxnb/pSTd9IyL8/k+yxeRuzCj3uf5IlhhDUQeYTT6yEB41tMrP6xvctiZQ2OEPUqUFbaoDsyx3nnL7jvKM6/N3gh63XH0zhVcmewNoO4/K0ynQIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587252; c=relaxed/simple;
	bh=8SN5HKfLqVFMAud3T3fsejND3zjEU5naSoh3JQrEuIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USceTRQe+4RNmAmRNK1qSnmhHtPFRbPHVypNas/lWtRAS1FFSXN6BKtnfQhc/RpbMbBEdaPbU2kunYKoJ2CA9+Sn7aNCGKvmmUqCFmW4Q2KDwRNkkoITAEbg5NDT8wnUkT2sGAqnH4yNzvc6WzZkD605eCYr7A36upCS3fEr1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTBGBEYL; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTBGBEYL"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f6aa4b3a7fso1728661b6e.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 20:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746587249; x=1747192049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2hYqOy5RzvxJRE5mqOnPnMLvEGK4ontQhx94LYEQPOw=;
        b=BTBGBEYLfHGj9hSmBQuiRFOVZliynstmzWc9G1OW0ITA3AwmK0Ye4Ot29PZDCQYxQt
         fIZpsyzolBKFdvHiWdD2+pKFGZOydL+yIAWcrQX/+rAm0WLcMPYesmcev/Q+ycReo0zG
         /JPqigvPqJ4o/06rwgMCSOsjfJ9twXHM+aRp6An8cOvTIWWb3K1SwWphTlpW/5Hk6gvz
         jLeG1MZTXXthEmc0f4jbwGqSYoSS05zWBpWgohCoyQnso0ZXjzfI9mc5I+yJ9q0l/w9q
         je1wQWuIk0Vb422wflvkLQULxYOl5NDWzAin6PV7Wfiz343i8Kd0WueIV/cGDzikfMwW
         GOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746587249; x=1747192049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hYqOy5RzvxJRE5mqOnPnMLvEGK4ontQhx94LYEQPOw=;
        b=GK0iKsvh1/xrK5L9eili84Dz7DtSAw4baTd6fGkaYJLY5XRYYJVUUBzHDk8oZbQxa0
         wT3+XGrCoTpyS+S9hXVjthincUEhdfJJhpl2K3fwo2a8O54//rLu/s7DAHA4JOR+KU6Q
         R5WtqrUTrm0sYIHoCRj6iGme3/24lKVReNiLxHg9lBEBaPhg5W+A2MFsDy7J78H3NVJh
         npF+WS30YZ2ecA8k7q+DQi2L5XHvLG/c7t+iRkZoBOZ0bghwhVbiNfjJUdd+iv6rm89/
         yIY2HoCPDC7IsjoWU5STNwg5lcPxhMBrUkxJnJP8XHfXvHQV2HiXjtLhHIVJvEKI2QGe
         yZwQ==
X-Gm-Message-State: AOJu0YwqcJiyCbQphnu7XujJHcaQ2GMZfm7x7XT/meFsQK8195ea+1MA
	Ifi/vmVIYa6h3c+36DpB8oC5UI8U0aWWa4mPt8BjX+LO3YqxT0Qrza+T6G2o
X-Gm-Gg: ASbGncvJz1HZIAm7BJh+VbwMWOQUlGOaS1DL+SnYhFIDSvDN8PNPc41nIb8EJhf9XxS
	n6/T3LaCPxumQu35BIKUujt2LsIra5UKc4bmsBycO2fYNtuDsRl2zWAFJ2j304wXtZ/qakpXLhI
	KvW4sxBFkdpLGKOoZkAKBPPxEkjRYkZqBC9SA9mwyfRP8XFFwTq91GZINfQi7n7y2XnUINzc+Sd
	ultnFDMhugBnaJWyfFkGmBGLvJ7MY1GwgrFvgqqndIq2ZDEwPZ668IvBMCRGuisiCpbkBEPd27j
	f/iNSKXLCI3nIMmofvBhjtvtOUWU3IcIZUxeqJbaI1lOzKSi
X-Google-Smtp-Source: AGHT+IG/LumAnKiHAyAYRZrRztj0xm6L9VgSSL/wLTSlQwBjf5Si7xio/11o2Fa/xYsaCU4KxivXLw==
X-Received: by 2002:a05:6808:14cf:b0:403:3c87:403e with SMTP id 5614622812f47-4036f067bf6mr1045622b6e.6.1746587249319;
        Tue, 06 May 2025 20:07:29 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73210aaab9asm268260a34.53.2025.05.06.20.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 20:07:29 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [RFC PATCH 0/2] builtin/receive-pack: introduce option to skip connectivity checks
Date: Tue,  6 May 2025 22:02:47 -0500
Message-ID: <20250507030249.4802-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.111.g5b97a56fa0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

At GitLab, we are interested in introducing an optional means to bypass
the connectivity checks performed through git-receive-pack(1). This
series implements a `--skip-connectivity-check` option to facilitate
this. I'm interested in collecting some thoughts before pursuing further
though.

For some background, we have a transaction management system that runs
in our Git RPC service and wraps all repository operations. Operations
that write to a repository are first recorded and staged outside of the
repository. When committing a transaction, the connectivity of newly
written objects is checked by walking the object graph containing only
the new objects from the updated tips and identifying the missing
objects which represent the boundary between the new objects and the
repository. The boundary objects are then checked in the canonical
repository to ensure the new objects will connect as expected. All
repository operations are run in a transaction and conflict checked
before being applied serially to the canonical repository. This ensures
that operations that would break the repository are not applied.

For our specific use case, the conflict checks performed by
git-receive-pack(1) are redundant and thus we would like to introduce an
option that allows connectivity checks to be skipped.

One concern I see could be the `--receive-pack` flag for git-push(1) or
the `remote.<name>.receivepack` option which configures the receive-pack
program that gets executed on the remote side for some protocols. This
could provide a way for users to enable such a flag if the remote
doesn't protect against arbitrary arguments being added. I don't think
git-shell(1) would protect against this, so maybe instead of a flag a
config option could be used or an ENV var?

Thanks for taking a look.

-Justin

Justin Tobler (2):
  t5412: test receive-pack connectivity check
  builtin/receive-pack: add option to skip connectivity check

 builtin/receive-pack.c  | 40 +++++++++++++++++++----------------
 t/meson.build           |  1 +
 t/t5412-receive-pack.sh | 47 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 18 deletions(-)
 create mode 100755 t/t5412-receive-pack.sh


base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
-- 
2.49.0.111.g5b97a56fa0

