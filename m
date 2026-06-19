Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D0369D7F
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886077; cv=none; b=FhtQQ0OnBzEnv4shhThhKY/HIU0bhT6/nw8vtB7gQXMCFyhZPtT6nL1fgTYk5QE5E7GV8pTZP29wwTtS29xaW9JGxaLNxxNcucBsUG8BwjjbcSJsG1ge+VDZtWFkEcv8A/REQsgcBWX8Zdm3SEjYJ1JHvYeYsnHv7RQHMS1ViAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886077; c=relaxed/simple;
	bh=NZ8kkpmSdeDFAPEb5W/p2UanVUx7dD9syR42eKT4WLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cu1x8TBQWXxEPWc3zer++gCTgZmdCnqhu1q3SfR0BibupnZ+BGGLGLAF2fANnfV4u/a8t6A5tysysCwxnTxK0QVqo7UYuXDIsYMLbL7Yka5wcGCzGf+e/77ipA1cOeTnGNMt+4xoMKB4rfrs9ns50LMtVhEUxODopIyZqjzTWsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=dhsc9qAx; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ZYjstaXA; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="dhsc9qAx";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ZYjstaXA"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=dhsc9qAx5G6LvTKd8zFN0gLoaim8MWJAyoWJjLAbLZl7K0MXtqqZSHQJEfAdb4kFdrL1FDGp6MVWn4fRzuRFIZYvrpOM7B40tBlEa3rMF9WrB+p+NcTG1u9vMtwL78+7+ak3oyjDqmID3HGhLKMfh7V1mXGsZ7BpJuTgVcH7C6jMWy5j2kXK7tGj10smpYnDbESk6AnZrVGqM1nY2qWCEsSK9DGhtcQkPY16hdbvnhew5mSTALKgh+aju7uxF7P3/suBkZpT+VqCHkYGy9xyo2YQ/HNsSfe57ij5uD8tgFdzPUSu93Pi5K0fXPGlf6DI1HxQWfB3ELxFVzo/4o5k7w==; s=purelymail1; d=malon.dev; v=1; bh=NZ8kkpmSdeDFAPEb5W/p2UanVUx7dD9syR42eKT4WLY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=ZYjstaXA3wMPg12j7VEBPkibMzQ+nzuUAosAwQGcaWx1iAiOvDhM+Ifk1MiM0q1FBYqzobDFjGLTDjX+PpaNynLpWJkEMeswcQ6qrt/LAb2Be08/q6vTQbyohoqfBEnXuHFm3u2AAYw2sN/NN/hatW6HuCAo+i7qId5wgvds7WxCbf2fXbKna0nftAMcPwDhJqf+FJcgU4LI+Ht14w4YDwgknMlYhsbBv3ABYnL1bGhxNaLTL2rU5pMyOpLFQdtNG/spJBFAyA0kZ+bCDCz7MCagdC7CRDk3rckFzojc1Mn0LFDU9xmFAMJ3KR5iFclcMeA1qo5TsBQryQw/X7xuhg==; s=purelymail1; d=purelymail.com; v=1; bh=NZ8kkpmSdeDFAPEb5W/p2UanVUx7dD9syR42eKT4WLY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -489877588;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 19 Jun 2026 16:21:13 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 0/3] environment: migrate 'trust_executable_bit' into 'repo_config_values'
Date: Sat, 20 Jun 2026 00:21:02 +0800
Message-ID: <20260619162105.648495-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612160527.167203-1-cat@malon.dev>
References: <20260612160527.167203-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The 'core.filemode' (stored as 'trust_executable_bit') configuration
act as a core filesystem capability flag.

This series moves it into 'struct repo_config_values' to tie it to
the specific repository instance it was read from. Eager parsing
is maintained because this flag is heavily consulted in hot paths.

Note: 'repo_config_values()' still does not support any struct
repository other than the_repository due to how deeply these flags
are accessed. In other words, this series of patches is laying
the groundwork for the eventual elimination of the_repository.

Previous related work:
[PATCH 2/6] config: add trust_executable_bit to global config [1]
[PATCH] Refactor 'trust_executable_bit' to repository-scoped setting [2]
(This previous attempt was unsuccessful because the target location
selected was 'struct repo_settings', which our analysis indicated
was not the optimal choice. For further details, please see: [3])

Change since V3:

 - In repo_trust_executable_bit(), change repo->gitdir to using
 (repo && repo->initialized).

Thanks!

[1] https://lore.kernel.org/git/837b5360b40f992351f489a0ae05fedf49884c6e.16=
85716420.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/20260301190017.53539-1-dronarajgyawali@gmai=
l.com/
[3] https://lore.kernel.org/git/xmqq1pht6nyx.fsf@gitster.g/

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>

Tian Yuchen (3):
  read-cache: remove redundant extern declarations
  read-cache: move 'ce_mode_from_stat()' to 'read-cache.c'
  environment: move trust_executable_bit into repo_config_values

 apply.c       |  2 +-
 environment.c | 11 +++++++++--
 environment.h |  9 ++++++++-
 read-cache.c  | 21 ++++++++++++++++-----
 read-cache.h  | 23 +++++++++--------------
 5 files changed, 43 insertions(+), 23 deletions(-)

--=20
2.43.0

