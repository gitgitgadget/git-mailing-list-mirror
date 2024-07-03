Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F918412E
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026735; cv=none; b=Zky/+TkQJMJRpt2SZw1ztNbMfPSeSVlqbFYZyU5cPNImlglYek3zNN8HgqwHT3LGYGjpcmx8cdjQTrk4fGwiQb9IiICc41aFNg31hogi70Egfz5QwaS8r8Ykub35583PdE+wRDbp5tCEGbAwXglyAll81M3/Slh1KkW/Nn2JNko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026735; c=relaxed/simple;
	bh=jxOe524H50N/zz8vtNiZWuvJV/tc2FXrLRiHkWBNDF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIPmX2QjA+HXpsB0S4sn/sjraZZsr/xAkRCBjWvVl2POc+hUDncfd+ZcCqC58j0InVJEoP2HkeXzz17D0HFqljT3BLdf9jnkRy33AHiKQZixSRb74fexPYq1PGKwI7eE6MBolrfPtQKKLX/of22P7j1hWG0h82X2OXAP89AKo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK/gh3E0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK/gh3E0"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso3459108a12.3
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026733; x=1720631533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rOmo2uzavXsg/4jln3HiFm5IiogYXwkvvQHBx6XCNdk=;
        b=mK/gh3E0TdABStYFWA1nFJt6VIkojA2dEKx1apTjQhioi8197dufboO/++geL9W9Fz
         wjVyreTJdhRqddo8MBsxAGSyKW2bqHsrSNaHjmNb/hT3QCUQO4g8eZs/q6h2+Rdt1YPP
         le9jq3ajnKR8J5ClHke/ED8bwDKrdz690tNDIxHHEHiV1bmrKNDLZ1lGQOL2bKCIzV8Q
         lTlArrHvVE+jSLI6vjb9trmIjErBZUEt2GxMK2jHxoXUoTSuwZBNmpqvCGlXD395KCYo
         uDY0TZ/xIh8bUClhoFeJAvMwoUTcCkyZHYrZL14n2JNxd76EIZRwnn/Mliq6AYGBk6OL
         tNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026733; x=1720631533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOmo2uzavXsg/4jln3HiFm5IiogYXwkvvQHBx6XCNdk=;
        b=CVv/bjqtwxdjtpAY1zBCf4oXt8N3IjMv0G8cZCpGOjLZnGe/14sMgL3ewN0iIx6F/P
         6uVX7Ppb/gp6umeh6SnhtHLC7eqY7Io/Mgi4v8JfuKdNo9uPR6p7/75yHJPDYeN7VM3/
         lEVePcK+T62hhJE29lzNwLEDjxQiYfSd4w8qx5vqGHvO3IOktdmzvQzRYijAXrIxSxLf
         a/AbEFdsDWl0MEbznNmzVWGZIWjPUl1g11cenqaNnNwvP55bXdyJoM6bBibY6iTfL4fW
         GnOvQ4ovjpd1vYySrbQpyTLWv7Ke2E/Tnn/6DLdpwsvnpIVOSJb9Q1kPU5El89523wj/
         mq1g==
X-Gm-Message-State: AOJu0YyOyIYsfACVCUIF7SvWZ5sSkGC99Fsm/2lTGkvlJSZ1YMami3Pc
	QVJcVf5EhUond6mlGyZ7b27uGq2AuFaakqIFGcFe70ykitpCos2UIWV/4A==
X-Google-Smtp-Source: AGHT+IHcQFsQmrWY7i1oOgj5ao/hZN8kF+d3hFpZ8pQNAZxbhyFPn7Mey0WCEiyhMQks0Rlk8SCSJw==
X-Received: by 2002:a05:6a20:daa7:b0:1bd:1972:3720 with SMTP id adf61e73a8af0-1bef6206623mr11448620637.42.1720026732394;
        Wed, 03 Jul 2024 10:12:12 -0700 (PDT)
Received: from Ubuntu.. ([223.176.57.184])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70803ecf966sm10678860b3a.124.2024.07.03.10.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:12:11 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [GSoC][PATCH 0/5] t: port reftable/merged_test.c to the unit testing framework
Date: Wed,  3 Jul 2024 22:31:40 +0530
Message-ID: <20240703171131.3929-1-chandrapratap3519@gmail.com>
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
reftable/merged_test.c to the unit testing framework and improve upon
the ported test.

The first patch in the series moves the test to the unit testing framework,
and the rest of the patches improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
CI/PR: https://github.com/gitgitgadget/git/pull/1755

Chandra Pratap (5):
[PATCH 1/5] t: move reftable/merged_test.c to the unit testing framework
[PATCH 2/5] t: harmonize t-reftable-merged.c with coding guidelines
[PATCH 3/5] t-reftable-merged: add test for reftable_merged_table_max_update_index()
[PATCH 4/5] t-reftable-merged: use reftable_ref_record_equal to compare ref records
[PATCH 5/5] t-reftable-merged: add test for REFTABLE_FORMAT_ERROR

Makefile                                                   |   2 +-
t/helper/test-reftable.c                                   |   1 -
reftable/merged_test.c => t/unit-tests/t-reftable-merged.c | 170 +++++++++++++++----------------
3 files changed, 86 insertions(+), 87 deletions(-)
