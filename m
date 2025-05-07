Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477B23DE
	for <git@vger.kernel.org>; Wed,  7 May 2025 00:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579326; cv=none; b=vFv8KEulxcjSYmFJGRmZUi34cfvlk+qwo3zFr4jX2BxUeaSJsK/SJISa1toJcboiq8GAxZIEhE58aio7k8k4clH044D+KdyG8R/79Y37L6YioF3usYzE3Ul14QhCCYFlG70ErdTcBHAqh1CrzryJtJlfPtyJXPKdB++Bp9KOGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579326; c=relaxed/simple;
	bh=N/Z6NtNfrSBVbUxCBMMNvOUcNauiyZzJHNZzgV7GNG0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=iOu6LBS2YOlKoAFKRB6GFwvoZNpGtXISNq+K8ed8KBL3+1a89ngo7KfARLq/snIEjKK3auxnO5Y/pXA7SMcSJG6QvQE2Rlnt8sBa7EJIBheQOrA8jWyg3wxgamNfbhJsmDE5EbB5yrkfGQ/FWxDM95FYqh1CeF0XrnVP+PvRbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG9xGlyF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG9xGlyF"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso51713345e9.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 17:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746579322; x=1747184122; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CR2EH+lbM75D9ORBOV962hK6sEWF74BjA0d6jrhlgSk=;
        b=UG9xGlyF3RE89ztQ+3jenR/2FfMl80lsJ/cEGH1PfdK5hDDZ8BzZ67AeEERtFFjECW
         mJMGBlDPzh5TbBuciN0NhEGi0kNWrzTjNJUQYvxyA94nssjBKZwJSL1GbmTxPs1WAyzw
         qr6My2V7GaqympPNDBT6maBE/LCkegi/GmJakGn4AAL9WjLKNwJDArYFrs44A7U3Zat9
         UKPP0wMXUu4AHni0d2zTt7j6a+hIQa2X62JIYdq5UHwvj7HLOqywt4sXcufIbROFixut
         eCScBN8AyPAkmX03tcQqa8L+0JULN5dftX9du0/B/nvIZbX4xNs8x+gXbvhBI1FFpk1i
         7oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746579322; x=1747184122;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CR2EH+lbM75D9ORBOV962hK6sEWF74BjA0d6jrhlgSk=;
        b=iMlR7vuiyNTQnuisNGfS8ON8AAJRenpyEKJK7RiqM/o4dRETchV7jPF0SFkFS7qSe6
         +JuJ3LyKZzF5kBeMfmK/h5/YJir2AaNyWG4Wniy1zVy7E1XGun5ycWDUGBQZB5+wyDwF
         FBSFqsL73f4zfTDvj9wsdT15zI1TRJiRxyvYVzoycPV9oYPGpK+GWdT35ah+VJba2prG
         TFq5j+BoC7JY4Qf1ni/IygyAINZ3ScqBhgrsthWhy7NMHreG+S1f2DLdGKt6juhZZ/IQ
         jjiq0Cu6wtU4yrH41jcXGmQh22uUpzzTGA7ZqMvU0wc2LyrwT16mFGbwpU+hn3rW7k4g
         Nssg==
X-Gm-Message-State: AOJu0YywX2/XYt9X3JX0m4QTiPTlAut/BPn/r2grmBRgVx5xuR+YXKb+
	LTih9O7QjipqxNnXlRvtXLRYtKgx1WfQa+G6cjrEXKjsWG9UWGVSs5IHpQ==
X-Gm-Gg: ASbGncsz2/DA2XibuKJ2XfJ05P4UFaxemwvcm/KerBCqUSZXknjTWS++Q8hPaV55kTp
	AVbnRGTwK23MuV1sqfLDUimpE9pzZpBtVqYbWB8zX7fZSgPOSUE6m47Y5dxujMDNz3HdwWE6SkG
	7LnLpcMnUyQISRpeXmds9KQCk9WfvKosG/frcFO0ZEzP+JLdTGSKNRXuip3b1M34N2USDRy5H4A
	o9nwf+5O/KNrQZ5eB4GQm58J3J3pUh6RXO9kT68GosUucNq/XJlWfQYyWNSGpfA6QqixJ/A3G/4
	QDZYrB5oQpGMZwcH9v7Eln0GuJ/3H0TQZyhl2rDw8g==
X-Google-Smtp-Source: AGHT+IEA2f15SgCTb50Ru5fIkgzk0PQPhITdxCiXl9AdnT+iAHR5UdcvW5vO8twHkqWkVHr3eh8nSg==
X-Received: by 2002:a05:6000:2489:b0:39c:1257:cc26 with SMTP id ffacd0b85a97d-3a0b4a7018dmr1024875f8f.57.1746579321943;
        Tue, 06 May 2025 17:55:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3441sm14995211f8f.26.2025.05.06.17.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 17:55:21 -0700 (PDT)
Message-Id: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 00:55:17 +0000
Subject: [PATCH 0/3] Integrate the sparse index with 'git apply' and 'git add -p/-i'
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>

The sparse index helps make some Git commands faster when using
sparse-checkout in cone mode. However, not all code paths are aware that the
index can have non-blob entries, so we are careful about rolling this
feature out gradually. The cost of this rollout is that some commands are
slower with the sparse index as they need to expand a sparse index into a
full index in memory, which requires parsing tree objects to construct the
full path list.

This patch series focuses on the 'git add -p' command, which is slow with
the sparse index for a couple of reasons, handled in the first two patches:

 1. 'git add -p' uses 'git apply' as a subcommand and 'git apply' needs
    integration with the sparse index. Luckily, we just need to add the repo
    setting and appropriate tests to confirm it behaves as expected.
 2. The interactive modes of 'git add' ('-p' and '-i') leave cmd_add()
    before the code that sets the repo setting to allow for a sparse index.
    Patch 2 fixes this and adds appropriate tests to confirm the behavior in
    a sparse-checkout.

A third patch adds a performance test to p2000-sparse-operations.sh to
confirm that we are getting the performance improvement we expect:

                        BASE    PATCH 1        PATCH 2
---------------------------------------------------------
2000.118: (full-v3)     0.80   0.84 +5.0%     0.84  +5.0%
2000.119: (full-v4)     0.76   0.79 +3.9%     0.80  +5.3%
2000.120: (sparse-v3)   2.09   1.39 -33.5%    0.07 -96.7%
2000.121: (sparse-v4)   2.09   1.39 -33.5%    0.07 -96.7%


Thanks, -Stolee

Derrick Stolee (3):
  apply: integrate with the sparse index
  git add: make -p/-i aware of sparse index
  p2000: add performance test for 'git add -p'

 builtin/add.c                            |   7 +-
 builtin/apply.c                          |   7 +-
 t/perf/p2000-sparse-operations.sh        |   1 +
 t/t1092-sparse-checkout-compatibility.sh | 102 +++++++++++++++++++++++
 4 files changed, 113 insertions(+), 4 deletions(-)


base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1914%2Fderrickstolee%2Fapply-sparse-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1914/derrickstolee/apply-sparse-index-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1914
-- 
gitgitgadget
