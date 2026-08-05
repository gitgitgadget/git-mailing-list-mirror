Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67DB4457AB
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930857; cv=none; b=V7B81OJCIzCtxenVqzsf3HQRdjXllRrmjT4WS8ShIaJaKbE8a6T3UEcFT47ed9ivRqi1Zl3i3saWCzhp2muEgiUwCZFMetuRnBw4nEuF2rJAUrGTx9F0wywHEkrMCLUJOExAJlU5m2NV2szBZQXSYrWzStH9cyEMGhZ6R2Huqwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930857; c=relaxed/simple;
	bh=BjVlDQG8Hc7d4f5axByovV42PGqfijXYDWjtWYGXxu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okwqC9KuMmo9pEd+wNAmaatMw457/dX6l5Lme7NMUwvzMYU7v0/PRDEsyJFPoFTb1AACb0442XgroPr/eOiw19Ney1D4B/DuZGkRr9o0OBtBVujYmGiqsQ0el+8Sn+PmQlLVbsirAOdg/YALEbdl+35zra8EB6fSDTPeDBVt3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=QpJoJomc; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=kgTm7Cgk; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="QpJoJomc";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="kgTm7Cgk"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=QpJoJomceRnXNP7wHSkYYV+pcr5eb5Tj3ECBhoZPTE1tBCiqzXdoElp2FnZKkXbCZ8py0pfT1ea0urau5iLZsa/s/SnHpzkFVy0qJK8sMhFgGNOY5tsIr33FIm6NMBU4/NLpa8dwMghzQy7NIiOInPEwAoEkp0IUXtKDFayFd5jfI8CFY+wbA2FgkPwKkfTE8VneFXes5fvCcygQ2cJnpE91MFJJr3zCpfXHp0AtD6pW/mvxwt7g1CjVMmGQIFx6vxXmgSxlTV7/+KWvWd9D5kDifDluOFP2AklxwPPZW0ebkKsLZQ1AJyUjPSxzvGhx/zZAOvpF66X/lQDWHHU++A==; s=purelymail1; d=malon.dev; v=1; bh=BjVlDQG8Hc7d4f5axByovV42PGqfijXYDWjtWYGXxu8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=kgTm7CgkxhI5i0gg7xyiGU4h4GbqBkywMfYsMknpvxyzL93c1wSrd/YD4TFhbHMLx8yYsY8hVQ/KUrmLSamymaGSj+PejRDQbvpnU3Sz2PySOfnPxz653jmJFdmeP9BgTXtHoW3eRtQ30lJnnAU5lzkIgV+kOswF8j2AE+dML8wbCMdA3O+s2S4P13qHJZrvlxmGZ6r4eB9uWXmQjKoo1kmu+NdbHXqRXz1IrvzlPhuPCmngPWJwTsN5sMNwBFW/aSoKfD7jGyTdhHf3HTZjrRiIXuYFrqsuEDvQX9fkAC6YGGGpv3xG8J/rPCe0OSPrhC9vcw21OaUvmZEfL1BlgQ==; s=purelymail1; d=purelymail.com; v=1; bh=BjVlDQG8Hc7d4f5axByovV42PGqfijXYDWjtWYGXxu8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1777023232;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 05 Aug 2026 11:54:08 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH 1/3] environment: simplify repository config getters
Date: Wed,  5 Aug 2026 19:53:39 +0800
Message-ID: <20260805115342.3939931-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805115342.3939931-1-cat@malon.dev>
References: <20260805115342.3939931-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Drop unnecessary parentheses and NULL checks in repository config
getters.

These getters are only used with non-NULL repositories, so the
extra checks do not match their current callers.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/environment.c b/environment.c
index 76ee65e62b..f5628b6758 100644
--- a/environment.c
+++ b/environment.c
@@ -119,23 +119,23 @@ int is_bare_repository(struct repository *repo)
=20
 int repo_protect_ntfs(struct repository *repo)
 {
-=09return (repo && repo->initialized) ?
-=09=09repo_config_values(repo)->protect_ntfs :
-=09=09PROTECT_NTFS_DEFAULT;
+=09return repo->initialized
+=09=09? repo_config_values(repo)->protect_ntfs
+=09=09: PROTECT_NTFS_DEFAULT;
 }
=20
 int repo_protect_hfs(struct repository *repo)
 {
-=09return (repo && repo->initialized) ?
-=09=09repo_config_values(repo)->protect_hfs :
-=09=09PROTECT_HFS_DEFAULT;
+=09return repo->initialized
+=09=09? repo_config_values(repo)->protect_hfs
+=09=09: PROTECT_HFS_DEFAULT;
 }
=20
 int repo_ignore_case(struct repository *repo)
 {
-=09return (repo && repo->initialized) ?
-=09=09repo_config_values(repo)->ignore_case :
-=09=090;
+=09return repo->initialized
+=09=09? repo_config_values(repo)->ignore_case
+=09=09: 0;
 }
=20
 int repo_trust_executable_bit(struct repository *repo)
--=20
2.43.0

