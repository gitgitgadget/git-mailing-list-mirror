Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFEB33CEB2
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606073; cv=none; b=JjNCXOf6D9cYgvjM2HzyUeOH/gcVDVW2ViqxvP5hOHpopSgzplEHx/WOUiBPrDJT2nC+YR4J/F6DKus6aui7bydjrbpFWpRA76jZg9xYORPRHcDO/bytITqv/0PPdQyqmiyKVOJM6d4xInxkVEZZTiYQuzXPKx2GeYcipqD0zUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606073; c=relaxed/simple;
	bh=oyjHiB35F6wOAwuUTT2nIBMa+EPj6p9QBM+GYhrIwuc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dZJXIr/dbtLoMwcfrzg038jvwdFcoVHdiCyHhH/PSgXD/huk3R4JjL5ZnqLKMyng+zhIkb9q83RpXFXoL93iW+XPIff7mpEjaOolTPU1KFHOu8mZGvFeryv/+7dC03rFmrjj+hGbE0h7Z7cyET2qj9310j7f+A+PrJjvECJNnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1YIb3NV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1YIb3NV"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b00e4a1so35743155e9.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 05:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755606069; x=1756210869; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/fqjEZDsam5R/zmTttUQ8TtGPpanmPOLlftejm2S3o=;
        b=m1YIb3NVLgpD09BMK+TgQYwiaK7C66iAyQ7DzSGUqoSRUOKYrzn0HA5PjLZJMPAAeU
         T9q4Dg5Xgoq10shY9wSgGPiaTaxcOEfOiEZfYqcKHAb30xW+NnG/G5BCg8c7+K1XPuFJ
         +0I7t3I53qqPA6yj/gR1UDgv1OhsjqoWHUY2B6L+nbNpCkQcU5inP4TuvnlyIcQ74iqH
         XrdcCPOVSduHjMP1VspLiczw89q9P49CpKxODNDqZtpG6VwitIixjPfYb8mGiT/y2dr9
         W4lpi9g8EUQWt3YNNy7sWIP+F4NocJ6JKpYxRu4gNfd7emGwg9bgbDW2ahnAhFirzX0p
         veXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606069; x=1756210869;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/fqjEZDsam5R/zmTttUQ8TtGPpanmPOLlftejm2S3o=;
        b=fcHOAyQdDYDc/VVY9epDUqSTCy/R2Ka1WEeHQa4H1L7qKorcgi+qXTVxh32OJUryqF
         N8N9JTN6ZLHIEBSsA77tk05b/c5UeYrKo1s6iunIMo7RM+HkuoXkMf0NRWl7lEoNInwA
         Zw5tuHUX3Yhhy6ixu+a9cppnj42GIje8WMXRYGQQIlPOhBGGEHozdvgaRQnmvx2icp87
         eWF6XmMQWBEzhELwFwwGntRrQN7FhJd/Aj4OINfYw001+mW11YR6joXfcAj+tWUc+547
         Vxf0GRqdT0lzFWRjGNwib+ekv2rTQvH887t3DQT1Ol1suw77xaFvdpOjd4nR26xyet8U
         jc1Q==
X-Gm-Message-State: AOJu0Yw7/EYPHqkp/d2Yxq4q47fIS9xVK9eS9w4jLpqfhG98DUHrrKH9
	izZN04pX1EAnWBKpBHH/uHgzTA0JwrftQerRu22Q5fXHPC5Ksf97OwZBcnIoFw==
X-Gm-Gg: ASbGncuDPxGve1PFVC6gKkIvcfvtd3ZD/iyBLAZN++gmksXO3iqoapu4E8fL+2OCKdu
	tBKJFK/e4VewEhruYNj7bzMs59NFRsKlZEd4ModEHKc6xPWbxq95aRSPbGI5x6onL0yaSW9fi5q
	G/SBspc2vYFfPX8osN0jdh1F8O09aUGCBqDw3cuTfvt/JsWFzz7t4iqmnuoJYai/fcVRLz2PqY1
	TXfu1tHLYMoL9nENOQ07yf8A/KfUbY36bN7IpfBvdRt4ywQcVEfWrR8HpDo/+jVdE1ZOF0dLZeD
	zOlW3NtTk5ktWDtmmt9O8XmkcNaXKAOXhzn0b9MKxPwTY7xbnAgLbJbbBXzzoKpqONf4Y+Et+uh
	AlLIPB76NQq/oXOTG17ovxDR1nZVPxLQmo9E=
X-Google-Smtp-Source: AGHT+IFj8H/daIj8BavSYo5XPNtpJuzI+/CDJoNLdik0VkpB7ulEqVlKOTunyWnNHuGnzO6bd8CBPA==
X-Received: by 2002:a05:6000:290d:b0:3b9:16e9:2cc2 with SMTP id ffacd0b85a97d-3c0e2c8974amr1952971f8f.14.1755606068681;
        Tue, 19 Aug 2025 05:21:08 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.216.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1a97sm3501954f8f.31.2025.08.19.05.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:21:08 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/5] refs/reftable: add fsck checks
Date: Tue, 19 Aug 2025 14:20:59 +0200
Message-Id: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACtspGgC/x2NQQrCQAxFr1KyNtBOp9R6FemiZqINSkYmoyild
 ze4fHzefxsYF2GDU7NB4beYZHXoDg3QuuiNUZIzhDYM7dhFDOGIha91uTx801pyehEjZTWxykp
 fpJXpbtiPU+I09TTECP73dE0+/9Z53vcf16oK63sAAAA=
X-Change-ID: 20250714-228-reftable-introduce-consistency-checks-379ded93c544
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2266; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=oyjHiB35F6wOAwuUTT2nIBMa+EPj6p9QBM+GYhrIwuc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGikbDMBPL+AFTOzK0zNtoidOnHVtx+FRVITW
 GUBofpusX7OGokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJopGwzAAoJED7VnySO
 Rox/JVQL/15KAsjHwpKaFgp4B/SWXQtqzmeq6wt7nRweb25t4r+gA4ARzYcPEP0zXp4sD5X0Q41
 0kptKzBu0CigN77x6YIEf/H8ndmJFZG2Ia2RjRWoFXb5J7euFIUsJNcdrKQ//tPor1dV9yJ+0wQ
 0EDHRJhMTk2eMhDsC509tes2kNoToLAfBWVwYVJdLazH5J/tu1CGv7/MD8b9fTB/3ud3FlPDlom
 6c3JQ2AOVfXaw01baIoDXuEMoyCp4eIea3ukT3UBnwKV2M/A6ddzxh7Oweeznh7S//L+awNHZnY
 V8ygyDTfXS7NpVmy15pPNW5GZkTNPhjii49u6nLBekoXLt/VXb4FjkaggQ017UVf4J4IkBJkRaf
 Lluc17Pf0eClnvcVxtaKLBLP9/YUPdohpIAON6kSelzx/NcqGl6CUAW0u4gKz2Ri3qT4b+hQKAS
 c6NsFcBQ7lWUz59zVPVpXgdMl3oQoT6ikFeYY8ECcnxwTiYtZ5sq1I9DzsjmiFpLjxidQSwEe83
 U8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This series adds the required infrastructure and also some fsck checks
for the reftable backend.

Since the reftable backend is treated as a library within the Git
codebase, we don't want to spillover our internal fsck implementation
into the library. At the same time, the fsck checks need to access
internal structures of the reftable library which aren't exposed outside
the library.

So we solve this by adding a 'reftable/fsck.[ch]' which implements and
exposes a checker for the reftable library and returns specific errors
as defined by the library. We then add glue code within
'refs/reftable-backend.c' to map these errors to errors which Git's fsck
implementation would understand. This allows us to separate concerns.

This series then adds some checks on the stack ('reftable/tables.list')
level of reftable, namely:
1. The table name is as per the spec
2. The number of tables are consistent
3. The tables.list has a newline at the end of file
4. The table names follow correct index sequences

I also plan to send in follow up series's which will implement further
checks and go into deeper layers (tables, block, references).

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc |  15 +++-
 Makefile                       |   1 +
 fsck.h                         | 154 +++++++++++++++++++++--------------------
 meson.build                    |   1 +
 refs/reftable-backend.c        |  70 +++++++++++++++++--
 reftable/fsck.c                | 132 +++++++++++++++++++++++++++++++++++
 reftable/reftable-fsck.h       |  44 ++++++++++++
 t/meson.build                  |   3 +-
 t/t0614-reftable-fsck.sh       | 138 ++++++++++++++++++++++++++++++++++++
 9 files changed, 473 insertions(+), 85 deletions(-)

Karthik Nayak (5):
      fsck: order 'fsck_msg_type' alphabetically
      refs/reftable: add fsck check for checking the table name
      refs/reftable: add fsck check for number of tables
      refs/reftable: add fsck check for trailing newline
      refs/reftable: add fsck check for incorrect update index



base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250714-228-reftable-introduce-consistency-checks-379ded93c544

Thanks
- Karthik

