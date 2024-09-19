Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7A200AF
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770886; cv=none; b=qBNX/B09SRu2+77Go3W5UENw99NcmwIoGtT3YnEw4QdNtZaBaHxvgsEwLYWKw0zbgJzlLB3IV0uGMFuBkmF+SE2ODgtdyfvlTOuTeUsBMlivZ43pTfjuz2GgtSs9Prtz7qZj4nCFebAux86SoWhOH9Ao6qiQ4VqQ3A66aE+JIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770886; c=relaxed/simple;
	bh=4EuCvTRN0JTedqby3NhsArs472T8J5UL70JK50meD6I=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=gBFkSizF7HOkv2GJcqeW0Ook/RLpk8zey5M1snmPCCbYe29N2QGBla2OrW3X23nvTdZuKkmrAUhdSOn3ZEc1dCHWDjNQgLI7/PtIUJlhpA7keRtWoDOjTuxm/hVKkYtRgBKloD6x5+X4haDiW65pyj0YuA7KfhXa+IFcKMrI6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJuU8hT6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJuU8hT6"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so420118166b.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770882; x=1727375682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jYNYTbyok0RyBPGvmo7hyGUzPjjaA05FhYstWZ8nNco=;
        b=QJuU8hT6cf+W3dN8P3/6EafrJfxsPSbQNufsrntnce+E7X0JkEPWSHnLdBX4yR3dVQ
         kW+qzgQSO7iklT4r2vYaAmp9MinSvE+77uFnR9LoCKKy1EZmMIB24SQENNkwoRr5Fsi6
         AiFX9eFMCT5JybS/KZm7PBkxP5EPALGzlxozYWbZqavnFkFlj4Oi4SeLrgo6JLr+yt5Y
         Qpfzkh3oyn7vuBSPdB/q+AuUzZE1ZC5CXjC5SzJvVLjq6o68tqSQLwrs+qcT8FjVu0DF
         M8QEX2HpeVcJK6L8NTLswK+d0bYML2khyCvZind9YG2Jx7MjluDV2gBD6fB3igPFrbbg
         A5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770882; x=1727375682;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYNYTbyok0RyBPGvmo7hyGUzPjjaA05FhYstWZ8nNco=;
        b=XExn1mfTyMclNOGDwE6P9dgGk6yBY+5KrXstscYUbB7WkF7V3dUpx/w+xbbXNSYRrM
         M2licRsw66poBzdJHUflYLRxiMXZIMGyPLMix/o+pq0XAUFvgZYzREMHB6fvYfV0yxkg
         JClcr1Wzvrrg8qX8iEdE4Ww8hd6wue+BLRiS6+cPQMbF+42NvQAcoN1HqE0O+8ozCtJ4
         1ZPRbAw3ftIklwsYIGeFS2GQhYczq29u7S5d/byfQ/2BzU06IprqLtN7T24/Xmwski20
         s6aNfm2ed9sqg5c9Bka1hDKdPfngPi8Q7SIul4mb60VaR7qlsGPvz/d+Zdw0tDvuSW1D
         QgnQ==
X-Gm-Message-State: AOJu0YxCAq+ASB5/WaYVDe5t5OK/XMwLXQW7EF4g/MA2uGb6vuEq177P
	4qrITxB7Y8eSGlQb9lJR1s+Z9ykCjQDvEemIIUNi6RMCU8xMIgNV6sL1gw==
X-Google-Smtp-Source: AGHT+IFqi88I6BlUNKU82rRMJAFT+YMOfb1rqp8U5j4JWV/BbcHS7ovI+qPu8AIkQMt7UEerXBComQ==
X-Received: by 2002:a17:906:dc92:b0:a8a:7884:c491 with SMTP id a640c23a62f3a-a90c1cba762mr437744166b.17.1726770882170;
        Thu, 19 Sep 2024 11:34:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e1b95sm750459866b.168.2024.09.19.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:41 -0700 (PDT)
Message-Id: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:20 +0000
Subject: [PATCH 00/20] Fix typos
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
Cc: Andrew Kreimer <algonell@gmail.com>

Fix typos in documentation, comments, etc.

Andrew Kreimer (20):
  config.mak.dev: fix a typo
  diffcore-rename: fix typos
  fsmonitor-settings: fix a typo
  git-instaweb: fix a typo
  git-p4: fix typos
  gpg-interface: fix a typo
  http: fix a typo
  merge-ll: fix a typo
  merge-ort: fix typos
  object-file: fix a typo
  pretty: fix a typo
  read-cache-ll: fix a typo
  rebase: fix a typo
  ref-filter: fix a typo
  refs: fix typos
  revision: fix a typo
  run-command: fix a typo
  setup: fix a typo
  sideband: fix a typo
  upload-pack: fix a typo

 config.mak.dev       | 2 +-
 diffcore-rename.c    | 4 ++--
 fsmonitor-settings.c | 2 +-
 git-instaweb.sh      | 2 +-
 git-p4.py            | 4 ++--
 gpg-interface.c      | 2 +-
 http.c               | 2 +-
 merge-ll.c           | 2 +-
 merge-ort.c          | 4 ++--
 object-file.c        | 2 +-
 pretty.c             | 2 +-
 read-cache-ll.h      | 2 +-
 rebase.c             | 2 +-
 ref-filter.c         | 2 +-
 refs.h               | 6 +++---
 revision.h           | 2 +-
 run-command.h        | 2 +-
 setup.c              | 2 +-
 sideband.c           | 2 +-
 upload-pack.c        | 2 +-
 20 files changed, 25 insertions(+), 25 deletions(-)


base-commit: 3fb745257b30a643ee78c9a7c52ab107c82e4745
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1794%2Falgonell%2Ffix-typos-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1794/algonell/fix-typos-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1794
-- 
gitgitgadget
