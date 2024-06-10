Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F68178C93
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025075; cv=none; b=HPYdi2sEjvnZWOSVZ4uMcqBIUY1C35GuoN5GR5QhdDHl1thSIRkVsLqJ5Qpenz0QtkVN1Hr1NY/HCDABlP26PYkY43upKwqGTeu57mFT4VPCOFykXp4Lox5yO+RRhL3xa32H3vvrgj/ecEJmnpMIsi+yJPW3y/jMXQtIZCn+D3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025075; c=relaxed/simple;
	bh=WTwKs3FGJ9Kc5QE7BbCpffNmV940CYy8GPbnTcPsyug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAqroYnfcH9ByTAGNwquIgxji5w3e6pfq2Fv+LYHj3H4yS6X84nsQyFRisvFUQ8J3OW8pOh6+EacsdNDVuCQTRGVBbc5ZVXml0I5nTTBydkYnzhrMxxEE42tqnZEinSTG5+cVkQwkV9pcvjPWtRIpx7DhCDqNDnujooS4B58ZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6sZjrdn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6sZjrdn"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7024d571d8eso3585096b3a.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718025073; x=1718629873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzaW0f8/UJes3BH+FH+XTOSOjdNeMkz7agKXg4RfsxM=;
        b=b6sZjrdnzMflOGdwzXvGOxN01YP2Jgjj9qZPNm0IECrGKKud4tBTvcGjoMBq3yIwyM
         gG1jk7FNL8f59+MNmAhrRAJZaQxt9ofqWxtRzTjVcmCg3tBQbDHiq+vzxfiRBPyPCnSZ
         b8p0zYV/LBRSLSKty9cpKsqhoUjjVWnVKIkIcYJ5crzsKx1nEcmDtbqVuxU1PLWd9Grd
         vwOGuNUYOw55iN8aLjLcd+EJYYe9uoWYfkpt1/vIhZsa9WnxsTiOxQbvEyhUKvM5MKgr
         S6c12po6NDMwZnqoD1X7LtMZome8c73pp1FWGOe4nCOAw4q+hkQhIpTktgdIeKTvXDHR
         nzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718025073; x=1718629873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzaW0f8/UJes3BH+FH+XTOSOjdNeMkz7agKXg4RfsxM=;
        b=rQZP41Bl2GmHT4QFd4GIzln9xS+8frdCJkzysVLcpJcwg6CCtQfk4vrq2slLexZxZy
         rMx3H5hoJIgmdZ01ZgphLHitwym4nGx+fnYyRixz/Ad2bmMkq0AQrzg55YX9MJPji7pE
         hC2WRMJT8hK0wV+FBXgxzJMicHtGnYhEBeeG8SMxpHh25qgHhqnZoPC5qs68Len47Afl
         mV5RgrZImIjD4h8+NUFXQQk4Pf+HQ3ctAddhhrdtmj92KaHq3TjkiktCaQ5s09ODrriv
         I9k3P3SpZXqepMoDfHJ9qfxb6ot+W0UtCI0Cibe6K4a9yvP277xTq8L+O3iYSkP5+/GY
         RuPQ==
X-Gm-Message-State: AOJu0Yx1WxzztyX7jY7rV6TlLxOOa44/Fer08rUDxJzmX2CtpWx0AUym
	jQq2Gj9C6p2XhGJ34y7SeF0QPZsuTOF31D4aZq4P5Oz6jhvlE0TgrlqMabKP
X-Google-Smtp-Source: AGHT+IHhJfTnRCvOrO7s3H2nAZv01X6CY3h2ZeybFq3LNXcX5YNFvBIy8xyP0OW7qeqfGmAS0QryFg==
X-Received: by 2002:a05:6a20:8406:b0:1af:cfca:e515 with SMTP id adf61e73a8af0-1b2f96a39demr12000422637.12.1718025073156;
        Mon, 10 Jun 2024 06:11:13 -0700 (PDT)
Received: from Ubuntu.. ([106.206.194.184])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70599bcac14sm1378516b3a.1.2024.06.10.06.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 06:11:12 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH 0/4] t: port reftable/tree_test.c to the unit testing framework
Date: Mon, 10 Jun 2024 18:31:27 +0530
Message-ID: <20240610131017.8321-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
testing framework written entirely in C was introduced to the Git project
aimed at simplifying testing and reducing test run times.
Currently, tests for the reftable refs-backend are performed by a custom
testing framework defined by reftable/test_framework.{c, h}. Port
reftable/tree_test.c to the unit testing framework and improve upon
the ported test.

The first patch in the series is preparatory cleanup, the second patch
moves the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
CI/PR: https://github.com/gitgitgadget/git/pull/1740

Chandra Pratap (4):
reftable: remove unnecessary curly braces in
t: move reftable/tree_test.c to the unit testing
t-reftable-tree: split test_tree() into two sub-test
t-reftable-tree: add test for non-existent key

Makefile                       |  2 +-
reftable/tree.c                | 15 +++--------
reftable/tree_test.c           | 60 -----------------------------------
t/helper/test-reftable.c       |  1 -
t/unit-tests/t-reftable-tree.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
5 files changed, 79 insertions(+), 72 deletions(-)
