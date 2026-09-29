Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF65172CC
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684443; cv=none; b=P2dfWdfj0cAtP3QKXrpT4KMRy9VeslIXYk/NxEhe65K7NOEiw2EgjbYzIPaerfeF/6W6oZA6klsQsAWriu+GGPHnd+BsChlBAvokSdFYs9H2uzIdXWQNCur2u81E8qX/DOV2cD+nmFy2GjYeGwi5no2CDQfl4zpeCbrHeoZoIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684443; c=relaxed/simple;
	bh=nmnT+BxbiKicnTMIzE0Yj8KI0BLjqIhI30o2ODkPOv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMZRD/aFGleFtZTwyQVXP0vrAn7Eo0Fr/UpqrOBnDMhvM4Szxa1SAIcMtw9uBDJ0vy4HGkt+5Pqg5kNzW4utp/9cwzLKTfl5VJ5+udU4fkmxuuSK0MCpEqaV6IdI7mh1UCZB3T/uD2zPuJzOu2CBPR18BHw89nlveVehwpxO2nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYsLzULi; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYsLzULi"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672ce86b21aso4373181d50.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790684441; x=1791289241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66djkRtAq3SzNbU24/rC1d9K636KQEvK0LfSphyMTO0=;
        b=BYsLzULicNrIcLkNrDUOulZOg5oDpZmnFCHVYJM/K6GJFflX2sbqfdGzFVzsxzpWBL
         6omoBovjOKJ3GSmZUg6jx4iSloh5TURcwEZzmxOYtLbrjis8lfknNcBTGeYuUxFwJNbi
         k5h7F0ciD5jyR3v3OyXgIyHFwYyB2dcM2KBa2yABvWG4sFjlp0b6w9Q1ksBherdOTpff
         DOPuypxBf1C9tPWJpeOY/gyc8ToqTLmtU457eknsK50orP59UanVQzXr5Q06UZUMlOkv
         YtUFSV7MyISmmP2AYrYYFGK2spt4qcImMYEC2uheyx6VBxpkELeq2aPoxlRYoLmXKsYc
         z86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684441; x=1791289241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=66djkRtAq3SzNbU24/rC1d9K636KQEvK0LfSphyMTO0=;
        b=hvl1dRfu9uKHt8B7ngN5XDEc0ERGFw3pauMp42o2puasVZXRAOZKAaz8k1ZYA5/ZJv
         aS2DS6ioqFqYEt0VUN+kNPXa3NWKrjEXYrMtJbXK3DTyFKAmaa2Y6rZj1fPR9tMtETao
         7T8PCSUE6qEEzs2pgfuRwXyXhmDbp8J1YblBJqxYzsYX7q7+HGThK6nNQP3A9hYJyYTK
         h3UDubGFLamVqzK/fMF7FN0KYRgz9nB8hE/iM5dHH0iMFk0+vF9hJ5HcGabi49eMxVm/
         ztxVB/SyZXNrYEyBG6JlEL2laTPtA4D8kNyXke1Mty3zzsbcim+GIsjKItiHwc6KJoRV
         jcbg==
X-Gm-Message-State: AFq9FYLJ82mQIrCybind0uQTn+kfRxmMdqB0bQTsgiqx4W/fvwsUr/Z4
	GBq1U6Tg8MnVvNMIJl6aO5Xu2ChxxxwhrOIE5aYwG/7ZwIDwvVhUHhAJt+gRK+uq
X-Gm-Gg: AYBFou1MpBAEcgOoZln46Y4X7/yhxD2FJYO5KG0N/MBLlpt3bIXO0zcFmT+T6y+HU8Z
	qKTXtB5VNa7esxlXep8X5wW4sFPqTvPk/oU8wIFiTgq9+8y6TdZc0yxwsNyPYPqnFp95P8oho78
	QlFp/K87X9nFqB8BetJ9ZYKDPmI/Umz6KCia+bXhjrVuWp59yxDM+VE61JZgBDNQeoyfuG0pTIi
	hMOldfqELNDL6q0hSRfadEB/ruNM83GbusVTWDKhCsYJXZg8+AFG2L5s69AMk7hy8vKRMxySoZp
	U5DqtA0mLN9VBXaq/lPaJTO4CbveA6BkoZED6irR//X3Cz1P9JUAnlA1MYvOEJPauntpfFvR32V
	F/nopXSHJmNtBfu6NKANF2ClEQJTHd7/JBid1cSRCuyz577CoX5wYP5eKTXnygwXSFbJI4/Vckq
	mc2Qa5TmJYm5nCdmF2chr67KhK270FD6VMBTuTR1i2gWZ35WXdH8JcK0ZgRraZJHTNHPLyWtM5Y
	hDrrMDaRqLtkobYssG0cPD9KcPX0p05igtD18AO0YgqqvfebZ22MTqSVOTC/ET1C+a0NVdCyup3
	9Rpw42pBzQ3fG0jf5Q4RTg==
X-Received: by 2002:a05:690e:bc9:b0:672:99e0:ebf3 with SMTP id 956f58d0204a3-6741146ab9cmr3627983d50.139.1790684440655;
        Tue, 29 Sep 2026 05:20:40 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-674e5a7a556sm4499112d50.19.2026.09.29.05.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:20:39 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	John Cai <johncai86@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 1/5] builtin/stash: remove unused header
Date: Tue, 29 Sep 2026 08:18:27 -0400
Message-ID: <6a165c4df456b6bd5e5ab46664b023a45e670926.1790684309.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790684309.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790684309.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang complains that oid-array.h is unused. Certainly none of the
oid_array* functions, types, etc., are used, and the
transitively-included hash.h declarations are used but covered by a
pre-existing direct #include of hash.h.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 builtin/stash.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b..dfea2d2c4c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -31,7 +31,6 @@
 #include "reflog.h"
 #include "reflog-walk.h"
 #include "add-interactive.h"
-#include "oid-array.h"
 #include "commit.h"
 
 #define INCLUDE_ALL_FILES 2
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

