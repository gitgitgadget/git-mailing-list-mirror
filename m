Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9817A319
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515161; cv=none; b=gBV5sdpA1dL6Av9d3bvP2SYYLqJdhet1pTpr5JGdBSF46Gdmg1+oo0lVwc2fDpwTJxSknA7lRZDY6v6NfnzqQHZdmj15+AFWrSeLYIsfkOPG5ReLwomJ8PEIjHHO3c4m6kQZzfReCfQGTv8h8Cbg2i0RhWUa/6Dh9ctxFI3IBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515161; c=relaxed/simple;
	bh=52dvUXAiAd8DHaaz6P1gFrzHqG19/7P/r+MZsTRg4vg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=abzNTPaYlS9Ebe/eZ0XxKbznLp9uArlOYnZkkGZFEr3kS28OeCtJ0SREUmC5H1h/NS8tGDuG7SmFu0/f9zKTZjrIpwNGAk/pBdZI/24PGcelLjbPiwa0Wl9Mt5HTyUaftbg5i9Ae+wxR9wNdqfr7RSOUBn2WWlN51cZV80De5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3qhi0sE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3qhi0sE"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso456954366b.1
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741515157; x=1742119957; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lVPpikjtez4EH9Eiea8fD/7srVwHldKGcJcUi33FJBg=;
        b=c3qhi0sE4/fK5LqmapZgtJrAGcKqkz5ex47VuenWN9C1KkQqj6H3dgeroPoVt1WqFa
         REP7ctAtce0fdB9ISz1r6JbuxEl6RimKgQh3oixna289UxnDIfImlbjuT+mbLLC9vuGm
         foDqRgzGFvurt9LRKg+gjTq9G99L+H/fS/F7bXB9NwQy0vMc2AbVokK0OocnvjWJiEDO
         q1G08bpGv+dnmz642hPrOfVzstiiaUFpqTigI94EaB/5dAy5j5Cv5ZzYbewQChhgEqQs
         OMo2N+83FIHp89eecXonjcDUWgwqyxdbDe8tPcq0LAOmAn70znzGqzY38LAcwNkMbYI3
         Tkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741515157; x=1742119957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVPpikjtez4EH9Eiea8fD/7srVwHldKGcJcUi33FJBg=;
        b=okdMsybcVvDZ3CMlYN2h80Av/6sJihBZSI3aE6p65ikUB6FYo7mZGh78js51q3z/R6
         6kmlJMVwOj8Njj4ow3WiBOp/DADWBFzqT/vtwIo/Rb6HsfLHiHJ4TYxGkJ7UmryEYmHY
         u5UazyJdnpcxa0OynUYhhWXcKZEqmatf2FvJiihoWsodpdQkVc5nPyIsH20tsOz7FsR/
         CWvNDF8VsRqx/464dLE0wB5ebnIOixRtb4xGVYo+231JqMEAMfV0J3mt7FN7BIceGePo
         pVE7ZwTzyyWaiC/gsf8PEYyKo48w+WtIKF9gxHZD0EI1xPcsAJWAKMQHYnY6pkYns/6V
         FcLQ==
X-Gm-Message-State: AOJu0YyhzdqHePVbE8BR2YeJaizjOYfOJ7CMjPCKLzQsSGsDqO0k+NIx
	wMz+hijLVXrxgJW/UuAmdWGxeLq7i83I072xQfcvkl89EeCrnEY6OW4POg==
X-Gm-Gg: ASbGncuDqVN3ZC5TJUXeURm1yT4XLut8kuavLGHpjV1Dnaxpss/mJJYEgrImxBYif2F
	PFCIeAea/nmereu18XAlPaUIx4CU4X3/WW4trloa1M6qXYPqGNF0n9QSmBStB2zDJFQtTH8G4RQ
	rqqTBinVIbsRRDsjin/wfaHFhqkRZ7REYuH14DxfJwSKK5ftMsuVLhWhvb6kEyVBuenRi458MQL
	yzPEtKrzouKOVQtIo+5IReynul0yUno2pWTzPFAQ9J8a5bz76BL0noWtnR/OvUDvIUaNbYdLVTn
	d6IXNOjJmRvNnHJVMDOOWgmAlEGjsVr1F6CRi6uY0hMz7Q==
X-Google-Smtp-Source: AGHT+IEoKnJnSuzEt3wyqgmE+ZU+grRnLN6rv/1XwVTqsW0kjdo/RkpKW8iyZezaAVsl3a3UkNr8vA==
X-Received: by 2002:a17:907:9956:b0:ac2:758f:9814 with SMTP id a640c23a62f3a-ac2758fab64mr434091166b.23.1741515156635;
        Sun, 09 Mar 2025 03:12:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac29cbf128csm16332466b.115.2025.03.09.03.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 03:12:36 -0700 (PDT)
Message-Id: <pull.1877.git.1741515155475.gitgitgadget@gmail.com>
From: "emilylime via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 09 Mar 2025 10:12:35 +0000
Subject: [PATCH] archive: error instead of triggering a segfault in `git
 archive --remote=""`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: emilylime <emilyyyylime+git@gmail.com>,
    emilylime <emilyyyylime+git@gmail.com>

From: emilylime <emilyyyylime+git@gmail.com>

Signed-off-by: emilylime <emilyyyylime+git@gmail.com>
---
    Error instead of triggering a segfault in git archive --remote=""

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1877%2Femilyyyylime%2Ffix-archive-remote-segfault-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1877/emilyyyylime/fix-archive-remote-segfault-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1877

 builtin/archive.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/archive.c b/builtin/archive.c
index 13ea7308c8b..b6fdbfc7dca 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -97,6 +97,10 @@ int cmd_archive(int argc,
 	argc = parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
 
+	if (remote && !remote[0]) {
+		usage(N_("Option 'remote' may not be left empty"));
+	}
+
 	init_archivers();
 
 	if (output)

base-commit: f93ff170b93a1782659637824b25923245ac9dd1
-- 
gitgitgadget
