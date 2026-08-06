Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B83590AE
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008388; cv=none; b=iwO0EfXnyX/N3s016FwGm1WcfHGPE/rXBCs3F7XMw8aENNcq71c8fWLS9qzxT6hIMK263rKhK2xdXh95QfIyIimczaPtoBig10x6v72NkGJ4/Z1AzYoXUosBORQLPFEfkIQBPYwdcFCs8zKmefnXxgR8ho1LDMrpxwVkBFaw7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008388; c=relaxed/simple;
	bh=BjVlDQG8Hc7d4f5axByovV42PGqfijXYDWjtWYGXxu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=se+A35IBJcbCCO6kjBYk1+sAYzx4f7dvNRb8fUKBun20leLFXFrzLYAMaXqS/r2EXW6DBhyzV0DeI3WMGQUR5vHpw+RB7vrUI/+EYBm83WstJWpcVj9s6bXrLtRFmNZhHIzG3kZzuD8YugYowQ81+cPWKE3FgwKRmbgZ/KclqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=U/zGSk5N; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ATgZMISz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="U/zGSk5N";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ATgZMISz"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=U/zGSk5NHB6kPYEeQ6ifuc7BMiSARQK5J5IFPTYEJifDVRe3yAeo/s1ZFZOYRYQUc+yfpnAG6ij6S7f/I8mWurytqMntnRKoHsVRHJwVLW+QHZU/XVsEDorM8F2ncnsvYuzTOGgu2C92FLa4XplbsdLQvbNPpUNHW/Y30R6srImscFG3BdBK0LFOzE5NbzzycPSNndnduIa5V7h5MWFFNPoeH5qBUKGuALjrU++uSYzbwRymEoCEB5r2yoChWJewJ5nwkTWFsuIxMPlX780DZoPBBB77QSCUKT18dNo08hhViUwqdX8m73+bIedyAQPiI98n8e6fGZEGidU7ZKOAfw==; s=purelymail2; d=malon.dev; v=1; bh=BjVlDQG8Hc7d4f5axByovV42PGqfijXYDWjtWYGXxu8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=ATgZMISz3Atb4BGKkMDyeQgUUsAIRQwvzo5dkZsEZFnj6OXnkVtST0AOVQCdFdSbsoYZfLmhHjND4lAFY+l9daY6xheuDr24qVKTQ4xNYS60AQwoB44nSJ1UO0ZmK04wRH4vQsZkNeyHoqaVwNdbMWqnLBS7F72Pv/iGSk1KD/xYEbfPaQnQVDV9B5mme9d9s1oQNOgzGRXmIjAd4wy0/e0GwKVsWOt4aXlfdcFMD6SJGaKgcgsi6bQEnLDv1y+vzFLBZQhpTND6tvwrMYgGAwQi+V/RpC4AJfwzgUsjkCinFM6fnX/aPFTLbqM7wxLgs7CNAjuvewo37VnXQl4BkQ==; s=purelymail2; d=purelymail.com; v=1; bh=BjVlDQG8Hc7d4f5axByovV42PGqfijXYDWjtWYGXxu8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1822299684;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 06 Aug 2026 09:26:24 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 1/3] environment: simplify repository config getters
Date: Thu,  6 Aug 2026 17:25:55 +0800
Message-ID: <20260806092557.3951208-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806092557.3951208-1-cat@malon.dev>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260806092557.3951208-1-cat@malon.dev>
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

