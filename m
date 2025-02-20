Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9A1EBA0B
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040209; cv=none; b=TUbeXRCwVIqLK2uWynXcs8GPVVvlNiZ8rYQ59rP/t7rZ5lEKgd0C6HyA8XLpV7MauP3L/2PsqzLIzO7KdHyFN51TLfoWSRck8K1b6rcCM61omxu2ASpFjG2XqKpAkwwN6q/NfXIqRr9Ou6GlWM3sefBBRLBdhsOopRA7aX1P6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040209; c=relaxed/simple;
	bh=U83QZ1IWpOzlRbcxzsu3sCVkB8JIK88wPXiFVZSPIAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HW1K5mbGBZu/cV6rX5pWU7JEqddGmNfMXv1fRJ7xTUApq4pFCniCgHA/zbwNoHrbBE0SrLmEKuOLzkR/uUh7lhERXn+7KJ85CY7BnJQOY6kFQqUGxSpZ3pv77WY54ssjr100FN3hxvXtkzxGMgToM3xQCKFNMSk+lLTi7JahChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGfpjo0p; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGfpjo0p"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so915966a12.0
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 00:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740040206; x=1740645006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dVqwLK+6o1wbcW5h9bKR5newSVeZUNYxBszIpIOpI3g=;
        b=MGfpjo0pPRCczQXmKOzit+MGWLkkOZwLCUrRLNRqbhDE3aCy3y/PzFWi8h7tubLPEB
         MGMreAqjni0dAS+6eV60Y11tNeYO9RGg5kiySA9i7rKZYRvcb/x6AdTcIEVYNtV1ZFx3
         GuiNGi/HgkO6obqtrjvdKu3cpQW27lMQxuwNhMMwVLzD5hzwfvgNPuLn1Z25mcVlw1t5
         tsITADPxPGwqGPyyAxuxFNY1K94OOorbubsn0Uul9KNy1w36HsoUJJu1K8z9GIsRGnQb
         BHFihX1pwRQHT/GeRqYGDU/OojGmkdIC/R2rBw0/cTNoJvavBMh9Cd0Q98nl2+SsZQpg
         nZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040206; x=1740645006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVqwLK+6o1wbcW5h9bKR5newSVeZUNYxBszIpIOpI3g=;
        b=mSK8C7Gi9EsR7SknLkMnlMNYYDs25991FwELa+vmzx2puKuPxLKJKFW27YoTq3xnwW
         rkuvR+aCxJNehZeW842/2SKsh1cqhJrHS4kNkTpehZRFUAn4tMvfKcNZVvbYItQ0wiRp
         4FJbI5Da+j7iq3lfXZX/5BEeDP9NSMeqCLvkJ6Zm4Hh6BF5/p5puWlfl64hU/oRq2w/F
         xZsGZey686HHreoKYlNQ+0ez1yYMAFlaPi195lOprLdyTtz56H+P1vkK6VLQayEhdt8u
         0bYV30KVUKEd5Y57somZxR6wyMg6r4GKBwgrjePbcAfC04HsNdrTu+YZ/nzVtOzgKOR7
         64oA==
X-Gm-Message-State: AOJu0YxbAlPe08ZPxKWyFOqhadzOGvGOUWqhk0nS6j5Gy+OA/C+Im07l
	6pJWPesY4zthuXpWya9dplAIjG4DCiPiYfiymr5yUrtcBSMVbATOv+ddOrsSVPHW7A==
X-Gm-Gg: ASbGncszpgk4+7M5ANhP8+bdgHNo3Y3VS9H4DYDtQ/uEvjBL2CWwcxet0XFo6MdaOkU
	2bU5KgzJYgjAMoY0wyXSdjm/5EF2l5rfJvjbsnntIhaH7TdTR5xCsP5+pq60d/sZsEOP2gLoY7+
	S/ngLndbYzEfCeJTHX7ucXMUvLU1q8J1lOFZ57KmLkyoPWKOvlofMWAlCneM+XlbaTF7cHxTmQx
	BoMxdV/cYk5Rsn0rqmmEMlaOxVpwSoIiOxiiA+aL+kuel9cI7sO5PlSqh46Z4WchGKyTutcVm95
	BRv6dd5jtI3LAmLkFIgNNzXFFVM=
X-Google-Smtp-Source: AGHT+IHxDpf1e1Ck7107UnkWqAOi3gh250oJ5mxU80X1f0grH02O/ZgMZMJHH2I7e9TDZ/+F7gE5JA==
X-Received: by 2002:a17:907:7247:b0:ab6:32d2:16d4 with SMTP id a640c23a62f3a-abb70e3e7acmr2128855466b.56.1740040205484;
        Thu, 20 Feb 2025 00:30:05 -0800 (PST)
Received: from localhost.localdomain ([154.118.9.41])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abbdf53d765sm230533966b.39.2025.02.20.00.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:30:04 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 0/5] t/unit-tests: convert unit-tests to use clar
Date: Thu, 20 Feb 2025 09:29:54 +0100
Message-ID: <20250220082959.10854-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series transitions a couple more of our existing unit
test files to the Clar testing framework. This change is part of our
ongoing effort to standardize our testing framework to enhance
maintainability.

Thanks
Seyi

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>

Seyi Kuforiji (5):
  t/unit-tests: implement oid helper functions in unit-tests.{c,h}
  t/unit-tests: convert oid-array test to use clar test framework
  t/unit-tests: convert oidmap test to use clar test framework
  t/unit-tests: convert oidtree test to use clar test framework
  t/unit-tests: remove lib-oid.{c,h,o}

 Makefile                                      |   7 +-
 t/meson.build                                 |   7 +-
 t/unit-tests/lib-oid.c                        |  52 ------
 t/unit-tests/lib-oid.h                        |  25 ---
 t/unit-tests/{t-oid-array.c => u-oid-array.c} | 123 +++++++-------
 t/unit-tests/{t-oidmap.c => u-oidmap.c}       | 153 ++++++------------
 t/unit-tests/{t-oidtree.c => u-oidtree.c}     |  78 ++++-----
 t/unit-tests/unit-test.c                      |  42 +++++
 t/unit-tests/unit-test.h                      |  19 +++
 9 files changed, 212 insertions(+), 294 deletions(-)
 delete mode 100644 t/unit-tests/lib-oid.c
 delete mode 100644 t/unit-tests/lib-oid.h
 rename t/unit-tests/{t-oid-array.c => u-oid-array.c} (35%)
 rename t/unit-tests/{t-oidmap.c => u-oidmap.c} (32%)
 rename t/unit-tests/{t-oidtree.c => u-oidtree.c} (44%)

-- 
2.47.0.86.g15030f9556

