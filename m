Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711CA48
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437301; cv=none; b=UhIKd9NuQJVML5VZ5WEiN6u8Ij5qvdzx76ohhAkkmus4gqIvmMpXWKpdUpNx9WjkzxTzbvy4krop6JdzBBE09FDY/M44yLpv3uPBSLxrAKjaRYe20/Z1BnVTXumlu1RKy6CjC/SEkoe1IggkNcse1Fms85ONDKN/YHcmFmFgjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437301; c=relaxed/simple;
	bh=VkFt1SpeYce5TFxB8DSqoT68ku1mA7aHsEj/Pn5BFus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmZYNBY9TGEgCpdEcIFp7zKZVc0H7jjr/8ifJcgHnbLMc4EycXJsviOpKNQV0Q2Gh8uj7IgjOhSRCf4TgAnaiiokDMjJZYF4JT7Et7MVHqZMuX1GeU4/iEmNdgqhj0e7bmvX4UiCY2weq1HPd673ioopaJ+HkO6UsSM/qv9D+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7TeqCXj; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7TeqCXj"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ea2ac0c217so1943258a34.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 17:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714437299; x=1715042099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsFK9g3mKNv5629I+YxQgHuleoi4lcIqOybBMwj2nU8=;
        b=W7TeqCXjLNUEfX0Jt34xJfp+4E8G7EDB3C1DAfo0FPuUxkRNvfsCod26C2P6OidR/s
         CBS6l/vX62ShWcWySclCiWJpE5UR7r7GxvsElVYxviCiz16iCQ5DQOelGacK2Mmngz76
         bs822Cz1VJfKnlMkVptseqik5cqlzFovR2PSxvHAsSMcQvX4gexZUZ/u9dwlQPDg6O7c
         sJn8C4xCRp6HBy4WzXeokXoRwSQXHhnbxDIEd07nzKfP/z0QYTxVB5VfLwl0J+nzr2PJ
         qTvWy1wOXMhJY9YDZphPCU1ZNo+GNCzZMUWwAqD0M1ER4swDZUCup4c9L9ADbx895Uur
         tOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714437299; x=1715042099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsFK9g3mKNv5629I+YxQgHuleoi4lcIqOybBMwj2nU8=;
        b=LiDh9PbWR6TeJxpJN0wYv1/bn0PcOrHENS/xYZszSqur9bCXVO0joWMHCGNnBOXIWU
         yxrSsLhD/uUTDbcqn1Vg6BW+rAhi161ErBxwC2j23WSF4+JxHx5dNSaCTmoGIWHzew0G
         DIccYjiWORv/MLDJAu27HzbVQXJGwj7RnAjY03SdXvK//6GphDOHnyrXgm6Rw+i2peKI
         gO1Oxz3chlgWpMDl7bwe9vq6Pxe7NPJNAQSe2TT3VO9Bi0IHF0RlVYJxEd6B4H2yLwzQ
         tbwRrZc9UaHpB2+Ifid5qjJBawUYtHbZ3m4o8QR2HV8mR7GjomcfAws/B5yhRBQCRRZA
         mxYA==
X-Gm-Message-State: AOJu0YwsoM2oHDnHkjTDr4D0OiiuHej5MEA9ZUgpOgF54m/LVnUSPuQj
	q/HX09yq3t1keaYcLEg6lkJLZ6aaLQ2jYZfYRuRykj8Ss2qnGcr+08OsGNVl
X-Google-Smtp-Source: AGHT+IH6EgrFFeSNOt5QRGFG8qhksxo0H8cEiCoPGUB6PbrtGXUzXQ2BarAD90G+iyR/YkwCD9aBRw==
X-Received: by 2002:a9d:4c0f:0:b0:6ee:359b:a018 with SMTP id l15-20020a9d4c0f000000b006ee359ba018mr529341otf.6.1714437299124;
        Mon, 29 Apr 2024 17:34:59 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id bw3-20020a0568300dc300b006ee5b409f23sm188645otb.22.2024.04.29.17.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 17:34:58 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/2] Add GitLab CI to check for whitespace errors
Date: Mon, 29 Apr 2024 19:33:21 -0500
Message-ID: <20240430003323.6210-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

The currently configured GitLab pipelines do not include a CI job to
check for whitespace errors. Instead of generalizing the existing GitHub
action in `.github/workflows/check-whitespace.yml`, this change opts to
create a separate generalized `ci/whitespace-check.sh` script to build
from. The existing action does extra work to create a GitHub specific
summary artifact that is markdown formatted with links to commits and
blobs. If this summary feature is not considered necessary, the GitHub
action could be reworked to use the general whitespace check.

He is a link to a successful execution of the CI job:
https://gitlab.com/gitlab-org/git/-/jobs/6744313860

I also added a small change to by default collapse grouped sections of
CI output to reduce noise.

-Justin

Justin Tobler (2):
  ci: pre-collapse GitLab CI sections
  gitlab-ci: add whitespace error check

 .gitlab-ci.yml         |  9 +++++++++
 ci/check-whitespace.sh | 16 ++++++++++++++++
 ci/lib.sh              |  2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100755 ci/check-whitespace.sh


base-commit: 786a3e4b8d754d2b14b1208b98eeb0a554ef19a8
-- 
2.44.0

