Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B639FCA7
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674988; cv=none; b=IMcb8VLe47i7qKeHl5cYb4JLK/BdFLDbMg4IsqSpvl7lS+VPNKiKBYv1M9lgh5w+v9j957f8YSnz0yShc8Zn7qy7gGxXNs51UorVcyvfnNxdJqdzSdZRQyhrJG10v0t4I8zVosJspDhxLP7oQa8P9Sn1THZKNGtYgMxR3K+PrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674988; c=relaxed/simple;
	bh=mL5TnD81oc2ynUuq9NZo7vWYouFomR0R0byVDe+owZ0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VlpxnB/rb8H4kpOQLPbI8km96zHusaNlacGafkIgka5qtaGtZ2ceYVJlneyVn4Bvv6SUg44ajSj0j+vErF7YXIX/hun78OAV3Q5OTwlD3KJMwu/spWes+ai8FXKASCvowsLgt6868VF1Qvw5VkGu+VQedQxlTNnG3ts752I/dBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rl8eziwJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl8eziwJ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cd8347d9fdso658440085a.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674985; x=1774279785; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0262pV53ggb2Ias5gPKt2Qz3brJSoadsb0fR6sL313c=;
        b=Rl8eziwJM5vQB4aWZZBMOv6a4ngiXkVZcitqO3bQ+fkh4vhzRmWLvMR2BJJLJdGkpT
         FRQ7cyVjl8cNgIWNYMTOXhelTu7BetEUSLwJrlpJbnceL1js+7kyc+paQyKkbon9j5Vd
         7tvCnsc5qdX5pTFtVZB36259HnNOERMl4mlobPHAnGUUpqWHvTnZWP9c5mBDcqHoMGZF
         5UDgm8a8+VhdZLcIpwySHv24iCWu9DaPORPXNQ8vCUurwrmL63sBLDxAWRIwqu4fhl+4
         DKXbXDy+PFhihv5KekxWy4EDj7T1AfsVKU17hfD19yPQ3j1vwRzg0aB7MIUkDWUH4J/t
         89Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674985; x=1774279785;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0262pV53ggb2Ias5gPKt2Qz3brJSoadsb0fR6sL313c=;
        b=SPIJcd982PDxz7vjba02N5hgFWJ7Jg0/AtiPwaBAeZV9Jv2EooFRTkhW0m0W2JPpcd
         G25XcRXdSi1YQyv2OZNO9dejB+18ANRBncOEC9DdBYGNRZQO9MQI2viqGCH+GnD7TlWV
         /09YyV/8isY7sHkWSW6/BD2EHiJEMlbs9q6CutZomlCr75ofPc2NXf/ZylzkLErRYQ3F
         D+Wmzvyrz77oC66mB2eaboliQrnAWBi2EVe8ThBu9DavVoSQR0UQM4lOQJfme10jSYH4
         v0mpRo1yMjJ2SbKV4PvURFOKWZmAybj25Jno+ESFOaixjGhbAj7vQjJrYkDZ75yCAF8c
         pnzg==
X-Gm-Message-State: AOJu0Ywo5nEWCXkP7D9Jm+IUpWjvJmD2kVqbeb1ALS+SR42LtWU+TXZT
	s8KiDvR1u1Ce0oxXE+lXjVtrSepaqzptAXC40I5YKp6U22DLsBMGWlUY8uJC5w==
X-Gm-Gg: ATEYQzzlpC4EYphw7YgU9UA1I2vcGqG3Dpc4jZ94Ios62Vv+LYJUpvllZCQFu0GjiCD
	V+av+XBdqWcLtz+OV6K2kbRe+sa7GtKPZIM7iU5mc06b62KV+RfTBSAgcaYJDaGOVrpNA/wQ0qb
	4HitmDcCqfBtkftD0YlU1zosLExXy4evYfmCEwKYfhp/v3T+xYZ7hk1YSIJSr2UCJ/QgsSXvkQJ
	QHMRS2ptfOoXyaGFM5QBl+FdGoZwrZgYratd5/xIIsXUghqC4XocYkuYWzs4t2Gpt4v6T4NpE84
	ai6Nkvo0dVDVTPcon6iO39aAqLV688wla8uKdfgTS62yFssAwizJV5MdBOJtQ0FjWYkCKdqRW49
	k59W5uKl4sNLlOzbc+vKzcrBecMWTUKV6it+mgFD7W+umwEdhUMDOx8sRkLXWSMyUD2rizzUKKZ
	zJfDPNoqIiWemsCbXSroOK/1B0
X-Received: by 2002:a05:620a:4493:b0:8b1:ed55:e4f0 with SMTP id af79cd13be357-8cdb5b5b043mr1682210685a.39.1773674985372;
        Mon, 16 Mar 2026 08:29:45 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.99.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda214be7dsm1230734385a.42.2026.03.16.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:29:44 -0700 (PDT)
Message-Id: <pull.2068.git.1773674983.gitgitgadget@gmail.com>
From: "Aaron Paterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Mar 2026 15:29:41 +0000
Subject: [PATCH 0/2] odb: add odb_source_files_try() for heterogeneous source iteration
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Aaron Paterson <apaterson@pm.me>

The odb_source vtable introduced in this release allows multiple backend
implementations via the odb_source_type enum. However, 22 callsites iterate
the source chain and downcast every source to odb_source_files to access
files-specific internals (pack store, loose cache, MIDX). This prevents
adding any non-files source to the chain without hitting a BUG() assertion.

This two-patch series adds odb_source_files_try() as a companion to the
existing downcast function. It returns NULL for non-files sources instead of
aborting. The 22 source-chain iteration sites are then converted to use this
new helper, skipping non-files sources gracefully.

The existing odb_source_files_downcast() is unchanged and continues to BUG()
on type mismatch, protecting call sites that should only ever receive a
files source (primary source access, vtable callbacks).

This follows the pattern established by the refs subsystem, where
eliminating backend downcasts was a prerequisite for adding the reftable
backend.

Patch 1/2: Add odb_source_files_try() helper (14 lines, 1 file)

Patch 2/2: Convert 22 iteration sites across 11 files + unit test

Known limitation: repo_approximate_object_count() and has_object_pack() will
not account for objects in non-files sources. These are display/optimization
functions. A follow-up series can add vtable callbacks to address this.

Aaron Paterson (2):
  odb: add odb_source_files_try() for heterogeneous source iteration
  odb: use odb_source_files_try() in source-chain iterations

 Makefile                    |  1 +
 builtin/cat-file.c          |  9 ++++++---
 builtin/fast-import.c       |  8 ++++++--
 builtin/grep.c              |  4 +++-
 builtin/pack-objects.c      | 15 +++++++++++----
 commit-graph.c              |  4 +++-
 loose.c                     | 12 +++++++++---
 midx.c                      |  8 ++++++--
 object-file.c               | 20 ++++++++++++++------
 object-name.c               |  8 +++++---
 odb/source-files.h          | 14 ++++++++++++++
 packfile.c                  | 23 +++++++++++++++++------
 packfile.h                  | 14 ++++++++++----
 t/meson.build               |  1 +
 t/unit-tests/u-odb-source.c | 25 +++++++++++++++++++++++++
 15 files changed, 131 insertions(+), 35 deletions(-)
 create mode 100644 t/unit-tests/u-odb-source.c


base-commit: dc6ecd5354dca88d51b6d6562777fc8fc10d77e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2068%2FMayCXC%2Fps%2Fodb-source-type-guards-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2068/MayCXC/ps/odb-source-type-guards-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2068
-- 
gitgitgadget
