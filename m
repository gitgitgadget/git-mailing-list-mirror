Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52FD44239F
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093190; cv=none; b=mBF2nWAuAV+qIXGW+P9TNem+vrSFJu9SQv3ij7F3c19bf8vkvf+8SZSSTuzMhbmNmnxzQcQg7btN2otaFV6x+yklPhHf0gCJtSHflWbYg3e8vjcfGN+cZ2bVfRrMiYfO9JrOBmr536q7vdbV8Rf7xcyzkw4kqUfUF/Z26o/HXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093190; c=relaxed/simple;
	bh=OcJ2S6dEqUne4J6o/LiefG4l2UJoGJyeAT0tFeMCsJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlKQ03r2HM/RR4C9Qp0vwP8UAc+1+xSgATXfxwRDEVaiS4qd7bfJAjibV1iuLzLOwVREgYIi+589aRpuqmFsmhrRfH7WRQ/fmlGADv+tJrb24LE6wiMpPW/gqdCc1xUCuNwXR6gD9z78tplXIv0wEwzm47+ra4QN/GpgZJQtMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=lOanqb9X; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=S18T9zMx; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="lOanqb9X";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="S18T9zMx"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=lOanqb9X649LC3fyWK4TA9yOTiQU11GA4u9heFqGopjmVtVnJONbONGjY7k54qWGXVpDBOCa2h2Ewzfbs4LeVCMBbmw4LX6m6WJK9ckqlAWuajLRQI28yNhfslu8cYmqjKDk2edeTye+MjeKewOZcG+MuwWOnPdimc8LeJF/xsKXcM9tXT3cUheWWI5ZJGFkVU9mpoay2SxKMIbELf64tR+8EGlfXnAkdmZFrTIhMLQQYfl1fFIoBZ2rcQj1j7xt7z5K6u0A3dFMwtF3LUN+4HUrn8vNmAkoTaqun9dW+ix0ZwneRAvoTuGdUUqqihiMdPzGAaJvNytUm/6dV3naNA==; s=purelymail2; d=malon.dev; v=1; bh=OcJ2S6dEqUne4J6o/LiefG4l2UJoGJyeAT0tFeMCsJY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=S18T9zMxkqS8XL+39RR3QLfAKmpnt+XOGPPv5DN8w7yJ9pHGzaSP604auAlYMOJXBqs8UB+98pMbzXFeLdFsmK9TwUD5rkEe66h10GXmLn18U4oU57qCiuA/qfEA9tK6/cGBUo63DtMSQF6qf1JxhySkbz8yYYYuG+8kbD25TTLhz3LZVmEEnX7XWdkgnc3a+RNCFMib60sgmPecU97HmME1Y/BXVG6s83La6ejLyqSPGSzHkH2UFXxSmE/PmAL5Dd+D808X/YlN03JoC910dahKTrdzLMutBoQ4sXi+9W4k0SRx5A1hmYZPqGrQ9HHqi8iAxFMtAnoDilS/Wy5VaA==; s=purelymail2; d=purelymail.com; v=1; bh=OcJ2S6dEqUne4J6o/LiefG4l2UJoGJyeAT0tFeMCsJY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1925904636;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 07 Aug 2026 08:59:47 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 1/3] environment: drop redundant NULL checks in config getters
Date: Fri,  7 Aug 2026 16:59:30 +0800
Message-ID: <20260807085932.3958759-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807085932.3958759-1-cat@malon.dev>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260807085932.3958759-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

These repository config getters require a valid repository pointer.
While an uninitialized repository is a valid state and is handled by
returning default values, passing NULL is a programming error.

Drop the NULL checks so that invalid callers are not silently accepted.

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

