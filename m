Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ABC14A639
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169869; cv=none; b=JsAP3iKwS2NGIWUHtrrPCLiSr2t76kRID1bq6FKVCjISLtWW0qb6BkZVoSVwymyxDNYf5HyfayzPeJe8KRrsMKhiy+SVYM2owpfOyAhXvyXgCwlkmVXkqR7L2Mxf0HJepUfIwJ2fUDt4Hiak64cHuxOVHEaCPBiJp+23GOaIPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169869; c=relaxed/simple;
	bh=0d5DW3+kaj/htek16ZQD1UxWLxcFEACjhzhWs+8rmP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nxasnB8O8H5rhzNEqRE1Ge/q33Js1fdyWA7m5S7UNDiqqXtyZy6q9nG4C+D7YdGDe1M3bQLglpb2jjFyYYS+8ZYZOE+ID+iUCF64KKA2+7caId2YzDO1/LlMdfsUwVCd1G8+Ai4clFadcLJIfekUOGPBlBWgQDsxN7mxLxdzUH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPcCzZ3X; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPcCzZ3X"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747c2cc3419so4006276b3a.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753169867; x=1753774667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3/n+FrVq+OhY70vC5sxD3Sh1bunt+rdN6kgbUiPbIo=;
        b=WPcCzZ3XsuAx6OJxUQzg2Wuy148Af9v/BxI8KhJE4ujdS9r/+4yFpe+yD7sIkB/foT
         7+h7eLWqdslClQfTGtbN7xfgkdpL6ntmIMFusRMzV8EkJzcodbS88/nLdsP4xWX/4CTr
         RYVkXxl/eeobgWi5zYxOVNHP32/ViitwA6TV/P50J4XCgpZ7tdBdVNt/sybiUXCJBouD
         OobTRa9M/5+hm51uF66W5SXrxJ1NwQVcn+o9cyD1sr7Pi+1I0tSrIgNZAA96B0oJwy+1
         IW9qKTsOXtBxFHKkmM5jVeWzCMZYaDYzvLbDEwTEQuqdphOdttYj/Mvk9EHGJBaAMQ6O
         AW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169867; x=1753774667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3/n+FrVq+OhY70vC5sxD3Sh1bunt+rdN6kgbUiPbIo=;
        b=la0IfmQ35rhpzkBmeIMNTLK4tg1p182FZZ7XvDeHblFHqmgyWzKe+QVOEGzWOBMicZ
         w7kaJ7Tub1i2nM1C3lvMhgi6EglifZ/YZla9XUVXYLvfUrXD87MRp+RRa+tDK3Y8PWCB
         CvHslkA7XU1wMGkzuRPV+sOc/uImW+IfOvFEwk7HL/kaGQM+xIAVP98u/1dGJAT5GTQN
         oC8ObJq0bYAtOENhMWqHF5T/gnMlSpZRjQCOSshhI7zg0s6ZEnUS015RbF03B7vozJcg
         OibbJWdm6CcHxpPdIXevGj74veX+L7Dydy6xrykx0NAC6b7k9CSXv4X4CHmSRRJiNzGy
         6PsA==
X-Gm-Message-State: AOJu0YxCxhfuS8gQcsXJPfcX8m+9SMm1uXYZmiWX5HpwnTECP+SwsZsT
	7ziYP/x8cZ6w3DquqTJcKVUrBN7W0qCQhF1VYqXPAYmsR9+QwOLu5ZOkABgf732J
X-Gm-Gg: ASbGncu8V9AKx2blXFbcyvNId+sXMeIl/N++8BeKfXIZiZafUpoIoI7d2MC1IpzSLpg
	PVu0xgqyZX1BlE1LZ4cecY+Qh3tTBajEg6BJDhB60bOSdwrLN3uX4Lag2bVZs/jy4Vzzm9+hqCP
	GakEbNTEAHH28NlLCHcGi4pZ4Pdw0Em8MehSWybPkZ4sU1trURwqWtD+c0G288yMB5WzIRjWG/L
	8fAu4YnEF6Np4wpNO4TvVa5lqTB9cO7nu8H6VqUSWvMyeIgnnuKiHSSqBzfwWeM9tE1sl4JGn3G
	C0BeEboYNkOiLmI19/Y1y0i32lPTqJgJG6pylsVNQbrlZb05GvIZsnaR9qZbLG1veh2hfWADQrU
	4JnRkzGq0s8I3UYYr82pjJyQVdu5IljeHPw==
X-Google-Smtp-Source: AGHT+IHbS2688VnUicMHyhnck0XtHmVEMJUUnALaFQ79YAVYH0QutDiHzzbDcGiYzsCzX7cX7r6Kiw==
X-Received: by 2002:a05:6a21:6e46:b0:233:d150:77b0 with SMTP id adf61e73a8af0-2391ca3065bmr22880650637.28.1753169866543;
        Tue, 22 Jul 2025 00:37:46 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feabe7bsm6393713a12.32.2025.07.22.00.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:37:46 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH 0/4] Fix resource leaks in various helpers and builtin commands
Date: Tue, 22 Jul 2025 07:36:30 +0000
Message-Id: <20250722073634.1080217-1-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes several cases where file descriptors were not
properly closed on error paths. The changes affect helper programs and
a builtin command, and ensure that system resources are correctly
released before returning from the function.

Each fix is minimal and follows the existing style of the surrounding
code. These changes help improve the robustness of the code by avoiding
potential file descriptor leaks.

Hoyoung Lee (4):
  t/helper/test-truncate: close file descriptor after truncation
  builtin/archive: close file descriptor on dup2() failure
  t/helper/test-delta: close fd if fstat() fails after open()
  t/helper/test-delta: close fd if fstat() fails after second open()

 builtin/archive.c        | 1 +
 t/helper/test-delta.c    | 3 +++
 t/helper/test-truncate.c | 3 +++
 3 files changed, 7 insertions(+)

-- 
2.34.1

