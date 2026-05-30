Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCD42FDC53
	for <git@vger.kernel.org>; Sat, 30 May 2026 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157161; cv=none; b=K4O7ZWhbfXBsgQKpmDM5HCIAow6GDpRb0oDNVbHKEE++QdHLaFK/3ZEhYW37KDU/D3nFwNDVamVlFIW4izw7gF7cLu2271MvCJ5sFkOnePD+BXl1UG/SuOf+CoIL0mssEAoqDkty5rDvtalHmN2KuKD8h4s9+p8U6bn4CNoBvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157161; c=relaxed/simple;
	bh=QdJOGJ2YLYqZgl+8ZOXyeQdK7H2mM+rAc89PMq7iYUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TwrgrjFFFl0lLzCOr3nZW2hptod7ZWZyVl7jWnrAKOtKE0FBujRiig4Ube98MVJUG7s+h+nfVc7FtsIAmNS7JUCUXIjBvcsAR4/ZUMx7UJ9qd6K0+1QT0eM7Ir19Wz/XnWKseMjb+7NEhIMp+p8A4TpQqjx95vODtBVzzUWelSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=KBNiZnLI; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=NgqLcuNW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="KBNiZnLI";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="NgqLcuNW"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=KBNiZnLIHel/13AfjvIraer/b+56ZrOhkIy6d5kI5pYyyWhRuoMFKjRJQYlesxeBcRNCGye6/bFVaYaCAdoboBFtNBv0WrmsWsSPHltBWKE10NR6wEKHKF/DCv2Zx1cH3pxf6DnwUOud9v/7er21G3fJzEAVUCZ7ubFbfO1/W8I8k1K8G2uCDgICQ7D5xRx2mgUTup2Tw0TNL0QpHyijzf2WuJggJ2OVu3OU8oSHSyMRJuqj3mLsot8qFl4SdybnbOMfylS4aJwieVmuz+cd13Jtt3PgxEE3cjmwy9/mkHxtr0X16A+a7CLs82xdg48YZR7z8VQdBj6wHoG/o3BX2A==; s=purelymail1; d=malon.dev; v=1; bh=QdJOGJ2YLYqZgl+8ZOXyeQdK7H2mM+rAc89PMq7iYUs=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=NgqLcuNWi+xsrFqULklqFr+BJ4S+HmsN0S5PCgDDfoe4IHNK4OMutZ/MqjzyPzxCFO3lvTzTnquEVs53dgkbDWngqPwiuC8W3MeqchpHSLokzj0eq/G551CIvultHfeQSw4niSz1vrZonnnWQqKw8IUa/pUEd/nbJLMKKD7Gj4V9SaH2ScIC3f/SGaUCnpuoc2+NUtaaLK+riMto4u2EhCqFm7mZvmVk8tw1t8MUswlHMXz5Ik1Uu7H0SQs4JZ+lp7D4iqrxWn7n7c5TOd840FL56/A3XdUbOF4Xfo17ByJP7Q8K4jo119lHVzRrSgxd/v95foy7X53Z2rkTrCgaDg==; s=purelymail1; d=purelymail.com; v=1; bh=QdJOGJ2YLYqZgl+8ZOXyeQdK7H2mM+rAc89PMq7iYUs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1173446767;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 30 May 2026 16:05:27 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 0/4] environment.c: migrate 'trust_executable_bit' into 'repo_config_values'
Date: Sun, 31 May 2026 00:05:15 +0800
Message-ID: <20260530160520.77859-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The 'core.filemode' configuration, which is stored as a global
variable 'trust_executable_bit', is a core filesystem capability flag.

Move it into 'repo_config_values' to tie it to the specific
repository instance it was read from. Eager parsing is maintained
because this flag is heavily consulted in hot paths.

To avoid falling back to 'the_repository', refactor the signatures
of helper functions:

 - ce_mode_from_stat()
 - st_mode_from_ce()
 - fake_lstat()
 - check_removed()

These functions now accept a 'struct index_state *istate', ensuring
the correct context is seamlessly passed down to the lowest levels.

Note: 'repo_config_values()' still does not support any 'struct
repository' other than 'the_repository'. In other words, this series
of patches is laying the groundwork for the eventual elimination of
'the_repository'.

Previous related work:

 - [PATCH 2/6] config: add trust_executable_bit to global config

 - [PATCH] Refactor 'trust_executable_bit' to repository-scoped setting=20
 (This series of patches was unsuccessful because the target location selec=
ted
 was 'struct repo_settings', which our analysis indicated was not the
 optimal choice. For further details, please see: [1])

[1] https://lore.kernel.org/git/837b5360b40f992351f489a0ae05fedf49884c6e.16=
85716420.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/20260301190017.53539-1-dronarajgyawali@gmai=
l.com/
[3] https://lore.kernel.org/git/xmqq1pht6nyx.fsf@gitster.g/

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>

Tian Yuchen (4):
  read-cache: remove redundant extern declarations
  read-cache: move 'ce_mode_from_stat()' to 'read-cache.c'
  environment: move 'trust_executable_bit' into repo_config_values
  read-cache: pass 'istate' to stat/mode helper functions

 apply.c                |  6 ++++--
 builtin/update-index.c |  2 +-
 diff-lib.c             | 20 +++++++++---------
 environment.c          |  4 ++--
 environment.h          |  2 +-
 read-cache-ll.h        |  2 +-
 read-cache.c           | 47 ++++++++++++++++++++++++++++++++----------
 read-cache.h           | 17 +++------------
 8 files changed, 58 insertions(+), 42 deletions(-)

--=20
2.43.0

