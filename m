Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B74818E04F
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134831; cv=none; b=R6Z37NyjGCy4NfqGutFPnofpd/W0Mnp0jZqXhiFFld5Y7BX5EJhqbdaPBUc3ddUWK28iVQRKQSzzSkmpGF+fmfr/HGyVTBABLVi0W/BaEO8LovhaUVN28iib8ZkuUFwsDaQbulq5sQbVIZMArYbaQ0RJ2lazh0UIrGHxrmF1Y+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134831; c=relaxed/simple;
	bh=rIluZqf9Rd12LtQvP5Gre5ZQqkcov3LsNeqdpA/FiTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Babi6+Olzv+0hJvQk6kkrlrQoLTo+79pqtcyvRVBRqFnB53bMJxs4lcIIFtxIjYOCsTqXlB1A790gUD8GIuBLU/7/IJ89OPvLHvCpDpsuDi2V5VcL5KVRBp+3/i8qgCvandTm3rDsKZhDjnnISJUu5hDxXpQBfn9aL9iesAHD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLOuyT1k; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLOuyT1k"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4281faefea9so8397205e9.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723134828; x=1723739628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CYyEnuiSTKcIEFlaRNpaacWq/g7Y2UbXNUqdCppz0uY=;
        b=MLOuyT1knPFpHThUuPoEEIoPBhKydnvuorY/CsUk4FLDcXptp7roi2a+E7FtQRitxV
         5DsPSSkPN21SbNLzMp8DNgCwTCsyvYdaOVWpdZTI4PaaMRumiycNHxoG06IQhnEqQBQ/
         whiggs2KbYtGv4br8DY1dK/h73lwXOWhHRmQk4y6QW62mIU2y+czG7kyGdxaxw5ZSvAR
         cSZWPtEuBOfGBt2O0nQyl513fUGXmJVwANxQxr/7I3hu6WUxNr5Wbn8rsJ31GDyXFvat
         OKKzYzhSvfWV8mHIs9g0XOw3bpqL2OmDMbxRax+oox4uw7UccKcszDWT3jgDiZLjDOBb
         duoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134828; x=1723739628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYyEnuiSTKcIEFlaRNpaacWq/g7Y2UbXNUqdCppz0uY=;
        b=Gds+DtpO6M6TDV5a8y/U2J/q2V2lJCLwt1g2kkb0qMilVLZ6HO5h8dGepxIV3OtnvE
         h6AaMIGK6AEgCvU0jKYnnx2rGM5oLh176nrB5s34Ap/8vqCZTyMUbMvU1IJffpdmO2Ey
         GJN0NC8jTgxwLt1RsWNyGQeu2kMv9XwJPzmdPH2iicko0nug0fGO5zEHOo7j1DDaB5Jw
         ulXMUs4AFrb01+HKg3H6vY2/ffB7Oo6JwNl+1zDFAPLpmAbiQFVAVoR7VAhzX/yZN5Ju
         xbjlXCPFhAQlO2L3mGra9uuzMRtlbuTkzRq5arVaviKQxAe0tcdyIUB+1YGWuQc4Vh5j
         ZzuQ==
X-Gm-Message-State: AOJu0YzmFNj7m20Z+3jjduhpD1UYcw+pKYdCP4av1fY/yPsIW5S/OF+9
	Okpw0fHirSnvr+EPsBBofKgeVr3QhI/fzKnXt+4plGo9ZYwMI5QP64Zx4iVKtX0=
X-Google-Smtp-Source: AGHT+IHueMrsfrvB4ajKaJkL5Yr6zNOSYo99Ex5zrxgqQ9lmgSPVwxlH6QkhjfMD1eRiZiX+4kTWXQ==
X-Received: by 2002:a05:6000:48:b0:368:2f3d:ae6f with SMTP id ffacd0b85a97d-36d273cad7amr1560109f8f.2.1723134828179;
        Thu, 08 Aug 2024 09:33:48 -0700 (PDT)
Received: from abdobngad.. ([154.182.250.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27229689sm2415765f8f.95.2024.08.08.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 09:33:47 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v6 0/8] [Newcomer] t7004: modernize the style
Date: Thu,  8 Aug 2024 19:31:59 +0300
Message-ID: <20240808163302.17521-1-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove whitespace after the redirect operators.

- Move number of expect files prepared outside of
  test_expect_success to be inside the tests that use it.

- Split some lines that have two commands into two lines
  one command each.

- Turn some "<<\EOF" into "<<-\EOF" and indent their body.

- Avoid using pipes in the output from "test-tool ref-store"
  and write the output to a file.

- Change test_expect_success that are seperated from its name
  to be on the same line.

- Avoid separating test Description and test body with backslash

- Use single quotes instead of double quotes for test description and
  body.

- Use write_script which takes care of emitting the `#!/bin/sh` line
  and the `chmod +x`.

There are still tests that could lose exit status to pipe. This needs
to be modernized too, I will fix them in another patch series.

AbdAlRahman Gad (8):
  t7004: remove space after redirect operators
  t7004: one command per line
  t7004: do not prepare things outside test_expect_success
  t7004: use indented here-doc
  t7004: description on the same line as test_expect_success
  t7004: begin the test body on the same line as test_expect_success
  t7004: use single quotes instead of double quotes
  t7004: make use of write_script

 t/t7004-tag.sh | 1144 +++++++++++++++++++++++-------------------------
 1 file changed, 549 insertions(+), 595 deletions(-)


base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
-- 
2.43.0

