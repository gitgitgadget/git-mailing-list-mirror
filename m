Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63B17BB9
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949699; cv=none; b=iQPrG0Qq0Zlp3cPN7qN0T/fMHgKR4h4D3QX9XWdRmtlTKOa4ILU/7FA3zGEaFc8oew7FX57iKJU2mP+3EALJa69/nUMZJxj3retzBpSQL6PaOOFPcfzsaUfdrC55ZG0NOYeAMztb861sind0LJFn+K4zLOKmq2NyfUTrqIuOOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949699; c=relaxed/simple;
	bh=jBinizWQCCoeYv2HFZSDGnb1j4pbhFBRnZpbx3pg/PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2dL6rKQuj3muX87nwJ8Gz1bT8gEvZkV3j1AwJTm84gDIPvP1D1E7hoahugKKtUGc7n+JpvVw5pq3HFl/+3VMbNwviKNK55wkcr2iHlzKr66Xj5XfQhTFSpaXrkaBMWvjiNC9k2eLR4LOhcMrinz4+EFiLpMPcN74/gEzTdSEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMkPIvAv; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMkPIvAv"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-681bc7f50d0so2002501a12.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718949696; x=1719554496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqBRy5XwONuPr2SPndIO+2Gw/tQq/mBfot0XyFy5JLk=;
        b=AMkPIvAvuYMnsd/u+rAxYmh7mOLYTElsmCyWYCMjgd09KKr+oOVDVHvLrg+IS5Xdg9
         8niEpKYa4PQIZs5G7J0vykNstYathdb72WxZiH3SnVkaaxFWbcJOjemVIOajmv+2eI+o
         IIzgW1y/xPm/X3pU2Uk0D3kItn9iS/472a2wV6uq2uIcnMXmkLwmY+lCtlTSpAt3lbw2
         GxneWepEJ77vcgFW5tPTPSf271aY11XayFAzOJNhSls1pIGDozWHy2JdN3HhTLt1/XGP
         MHI2qOdTEPYLTmLGKEGlo0UoWCIWid4zl49veiuNd4Ij+WUfM/fX4b8lEt7A4KT9h0wB
         fa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949696; x=1719554496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqBRy5XwONuPr2SPndIO+2Gw/tQq/mBfot0XyFy5JLk=;
        b=LAOsYhO8nruFO1civ7EI3/VsVKHcQ4ICFPGpZw5DMsQeKsvZXmx0p6MqwbjSNCdQIF
         sir61LBnJ0CmzLMwyc/lyL5BxNTobrY+lBDnL2T972jnCtBC2aZ4x483IHhtzM9SI4WN
         4AXyJa7k21Z4k4i9efLnwkIewdEdXEgaDT3rillP8LVkXq52E18qINNmDsAq14Uv0n/s
         qaQRG59on3zsGVpUncWyqiT+0fr+UOrSve32nvIUg3MIQeXLRI8USs7UJxH2VlJX6h/1
         uuIT3AdXoqFtQiHqZ5QIy/vmZE7lvzqofhtLBSexNzYcIkdmrDMFaNwMcd98lN32yPxB
         diuw==
X-Gm-Message-State: AOJu0YwEjtsIUdBtu9Lr/7DPE0qg3QfnjSc9ump//0EGPTkJ4lnBc4eM
	duiKRemplwk/5vkj1TkBNEprGrGsWy8gKeGAQVyJyScEGWMjDGWOSivAkg==
X-Google-Smtp-Source: AGHT+IFkJ7WViPDu/tkGicQakKS3YnJ+QZRb2IY5jKHxgjQafgGG7SJRIOVSZTFwxuLZynItDWPQjg==
X-Received: by 2002:a17:90a:9a7:b0:2c7:d24b:57f with SMTP id 98e67ed59e1d1-2c7d24b0715mr8110460a91.19.1718949696169;
        Thu, 20 Jun 2024 23:01:36 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.103])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c81fe88e0fsm498661a91.3.2024.06.20.23.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:01:35 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH 0/11] t: port reftable/record_test.c to the unit testing framework
Date: Fri, 21 Jun 2024 11:16:59 +0530
Message-ID: <20240621060018.12795-1-chandrapratap3519@gmail.com>
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
reftable/record_test.c to the unit testing framework and improve upon
the ported test.

The first patch in the series moves the test to the unit testing framework,
and the rest of the patches improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
CI/PR: https://github.com/gitgitgadget/git/pull/1750

Chandra Pratap (11):
t: move reftable/record_test.c to the unit testing framework
t-reftable-record: add reftable_record_cmp() tests for log records
t-reftable-record: add comparison tests for ref records
t-reftable-record: add comparison tests for index records
t-reftable-record: add comparison tests for obj records
t-reftable-record: add reftable_record_is_deletion() test for ref records
t-reftable-record: add reftable_record_is_deletion() test for log records
t-reftable-record: add reftable_record_is_deletion() test for obj records
t-reftable-record: add reftable_record_is_deletion() test for index records
t-reftable-record: add tests for reftable_ref_record_compare_name()
t-reftable-record: add tests for reftable_log_record_compare_key()

Makefile                         |   2 +-
reftable/record_test.c           | 382 -------------------------
t/helper/test-reftable.c         |   1 -
t/unit-tests/t-reftable-record.c | 554 +++++++++++++++++++++++++++++++++++++++++++++
