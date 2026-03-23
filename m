Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8BD35F169
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253143; cv=none; b=j5YvB8F+hlQ/KprhNfrLoi2M6cBeGtTbpiDiCIG5SdG2H8ErzyaBG1VuZXP+BYXXiPloydbRYXkS5ILrcDI8MH8hgmhEQ073LteWJB1HJ6/db4ezr1iEa64Bu3XeTL/dGxP9nBEzon9gZD30uunt8H6gasHs5iob2JelVhejtFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253143; c=relaxed/simple;
	bh=lMVOp+7YVp2K/lmWNZ31y08Z+ZDFHliKhocnGF7H5hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkjvW+UlgLYGmUNLgW5LabjM8d2b4SZIIT0RcVgj9IqqkDAlgkbZUoY+KYogW7cckIkGUR88REg6uyAurHL2OsYNUs4Mpl1t6ifJFq6K10flUsEZUGAe233l+hbEPCJvKc4DQuz2oIiji9HlO19sxNStdUnOjlnupeyBR2//Ci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUhKdn5w; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUhKdn5w"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b6d9c981so2629596f8f.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253140; x=1774857940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JgKgEVBt9nYSQKOBjtHu70QyoLwm2+y3YAi2gNSokG8=;
        b=IUhKdn5wpYju1WmjZh+em0vfPOh5CNmi58fI0J9UVBtvTG2VsyDrlh7lf8lHg376J9
         9abQhJMOQPxTj0P1Bt4LFFayfaaaQuQK3JPIjCbW/BsiV7+NxuG9zVioiiPi1WTLEsAI
         02dljyVcqyWeJuReBQrmG3cuHW4l6LFkks6s8FQSRi4fGatYW6uvpQAOKHj45lX5biG0
         0T8mO5ZeePkuF0N9Lh9oJgrF2Y9jqUftz523JOzaeoKHbVLaalN4fov+ePxIo1poeSl+
         NOLNloHFq8VHqq0d2rElCoFMoRwo4Uov2QKZo65i/kjqDVCPOVhorO3svkK7QhXocNZ1
         Lyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253140; x=1774857940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgKgEVBt9nYSQKOBjtHu70QyoLwm2+y3YAi2gNSokG8=;
        b=a8hqAf62jPemAZvVTkNKwPATu3nFoXrhKQj+7u6aHUng1Gl7WKynlBu47WCpn9KHMt
         fWngsFcXlj9dQWUoQ22Bl79YdYjYafNnhBl6dGP8rNJ8D/X0+YdYadr17CJJ+tDSTWYD
         zBHpGqShDqFaEBGtoELWieaEsJmTIWiKwAnJ9N5tDFbD9Yfj3/yFxJxNnggNpvd3XKcF
         UZm+ue03V8P8Jy0o4i1I2w2x8dGPQdWEl47NX6YwbZyV8rtPt/r0nqf4QSgzk4Hck7U4
         ZEQZa62DCCLgGQZTaU/ZBo/Eb3sWDt+/AkPKP+ZbJ0CwyV9w5YKr7NxKEuHzdyC7evvU
         Dvfw==
X-Gm-Message-State: AOJu0YxXxjblj10XcYCTXuGNikaF1cHL9u1nIFNllvi/wqv7/hIj31Eg
	Isn+ZSU2zC0vyT3wGieZuBApec0C1BXthlWxMZJESMnnkkCQDR/4Inrj6bP5aA==
X-Gm-Gg: ATEYQzw596+92sozEtPU1q0BmwESQ1WDALW9tMcHkxAyk6oK516loxGRZjEUP0teeQK
	BcjABWDxJ2xAKKJ0bliujY4Ho/3Moic8uwTfTqhIq4/Cqf1S8UiZLv5valGWxKvX/32FjY3TKNb
	zeEid+ElznXLD5go8YK6Fy1+KDklgheVCiM8wThyGdd0aY9siJqdKJl9OekuUkp16CyxuDJOYcp
	Ap3B3YqpM5bZRaWktMqgsXWzfRlTcHzVUQ6+LDqv4AMJ8TAqgyyL59tZZnADF6fzHR9fEMLMmnX
	TqHJu9Bw4IuH46auFw5Yqqo1NDJ70XLHsHJRWfbyVADtckzfrpEGLP+54FvfdAdQyn0CiigaBiT
	tpQBKTBxkO9SA67qwY0dUObEkOlcREqLL4ISM4hxGf6xeN/UKluyTjR/dqRSO4mDfWGjyk7t0B0
	8cN181Q4e99PPJit/6Ddpx5I3LH0hBAE+J7s45o6OkSxrDgFY6ACdeV23HMWIFCh97TsCzp021l
	4bYUvIjvaR2Yfhi8ePXoshmqjSROSdfP+WL94M=
X-Received: by 2002:a05:6000:270b:b0:43b:3eef:acd9 with SMTP id ffacd0b85a97d-43b57732e0bmr17165856f8f.27.1774253139920;
        Mon, 23 Mar 2026 01:05:39 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:39 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 00/16] Auto-configure advertised remotes via URL whitelist
Date: Mon, 23 Mar 2026 09:05:03 +0100
Message-ID: <20260323080520.887550-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the "promisor-remote" protocol capability allows a server
to advertise promisor remotes (and their tokens/filters), but the
client's `promisor.acceptFromServer` mechanism requires these remotes
to already exist in the config.

This is a significant burden for users and administrators who have to
pre-configure remotes.

This patch series improves on this by introducing a new
`promisor.acceptFromServerUrl` config option, which provides an
additive, URL-based security whitelist.

Multiple `promisor.acceptFromServerUrl` config options can be provided
in different config files. Each one should contain a URL glob pattern
which can optionally be prefixed with a remote name in the
"[<name>=]<pattern>" format.

With this new config option:

 - The server can update fields (like tokens) for known remotes,
   provided their URL matches the whitelist, even if
   `acceptFromServer` is set to `None`.

 - Unknown remotes advertised by the server can be automatically
   configured on the client if their URL matches the whitelist.

 - If there is no `<name>` prefix before the glob pattern matched, the
   auto-configured remote is named using the
   "promisor-auto-<sanitized-url>" format. So the same auto-configured
   remote config entry will be reused for the same URL.

 - If a `<name>` prefix is provided, it will be used for the
   auto-configured remote config entry.

 - If the chosen name (auto-generated or prefixed) already exists but
   points to a different URL, overwriting the existing config is
   prevented by appending a numeric suffix (e.g., -1, -2) to the name
   and auto-configuring using that name.

 - The server's originally advertised name is always saved in the
   `remote.<name>.advertisedAs` config variable of the auto-configured
   remote for tracing and debugging.

 - To honor the server's recommendation, promisor_remote_get_direct()
   is updated to try accepted remotes first before falling back to
   other configured promisor remotes. This ensures auto-configured
   remotes are preferred over other remotes especially the
   partial-clone origin.

Security considerations:

 - Advertised URLs are routed through url_normalize() before matching
   against the user's glob patterns to prevent percent-encoding, case
   variation, or path-traversal (../) bypasses.

 - Auto-generated remote names are sanitized (non-alphanumeric
   characters are replaced with '-' and prefixed with
   'promisor-auto-'). This guarantees safe config section names and
   prevents a server from maliciously overwriting standard remotes
   (like origin).

 - The documentation explains in detail how to use secure glob
   patterns in `promisor.acceptFromServerUrl`.

High level description of the patches
=====================================

 - Patch 1/16 ("promisor-remote: try accepted remotes before others in
   get_direct()"):

   Fixes promisor_remote_get_direct() to prioritize accepted
   remotes. This could be a separate fix, but is needed towards the
   end of the series.

 - Patches 2-3/16 ("urlmatch:*"):

   Exposes and adapts helpers in the urlmatch API.

 - Patches 4-11/16 ("promisor-remote:*"):

   Big refactoring of filter_promisor_remote() and
   should_accept_remote(). This keeps `struct promisor_info` instances
   alive longer to anticipate possible state-desync bugs, decouples
   the server's advertised name from the local config name, and
   sanitizes control flow without changing the existing behavior.

 - Patch 12/16 ("t5710:*"):

   Cleans up how "file://" URIs are managed in the test script to
   prepare for URI normalization later in the series and avoid issues
   on Windows.

 - Patches 13-15/16 ("promisor-remote:*"):

   The core feature. Introduces the parsing machinery, adds the
   additive whitelist for known remotes (with url_normalize()
   security), and finally implements the auto-creation and collision
   resolution for unknown remotes.

 - Patch 16/16 ("doc: promisor: improve acceptFromServer entry"):

   Cleans up and modernizes the existing `promisor.acceptFromServer`
   documentation.

CI tests
========

They all pass, see:

https://github.com/chriscool/git/actions/runs/23350745268


Christian Couder (16):
  promisor-remote: try accepted remotes before others in get_direct()
  urlmatch: change 'allow_globs' arg to bool
  urlmatch: add url_is_valid_pattern() helper
  promisor-remote: clarify that a remote is ignored
  promisor-remote: refactor has_control_char()
  promisor-remote: refactor accept_from_server()
  promisor-remote: keep accepted promisor_info structs alive
  promisor-remote: remove the 'accepted' strvec
  promisor-remote: add 'local_name' to 'struct promisor_info'
  promisor-remote: pass config entry to all_fields_match() directly
  promisor-remote: refactor should_accept_remote() control flow
  t5710: use proper file:// URIs for absolute paths
  promisor-remote: introduce promisor.acceptFromServerUrl
  promisor-remote: trust known remotes matching acceptFromServerUrl
  promisor-remote: auto-configure unknown remotes
  doc: promisor: improve acceptFromServer entry

 Documentation/config/promisor.adoc    | 118 +++++-
 Documentation/config/remote.adoc      |   9 +
 Documentation/gitprotocol-v2.adoc     |   9 +-
 promisor-remote.c                     | 532 +++++++++++++++++++++-----
 t/t5710-promisor-remote-capability.sh | 250 ++++++++++--
 urlmatch.c                            |  18 +-
 urlmatch.h                            |  11 +
 7 files changed, 802 insertions(+), 145 deletions(-)

-- 
2.53.0.625.g20f70b52bb

