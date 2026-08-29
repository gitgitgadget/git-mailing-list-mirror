Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C004413D53C
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788010712; cv=none; b=MduP/887NIAgT/ZL5KpjlNJNn+16QH7IN2SWFmKTx4jK1Dc8Xe8JjQgzcS1bAanX0WKFyhyAyWYK9sM7bow9Gq38R9BXn94Dm29H9NA08QoEsfOQPiV7NxnBxUj7NdFF92wuDcgbEdI8P/2fMznkVlJGXEBwz02HxeT9plac1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788010712; c=relaxed/simple;
	bh=dZVoZoG+T2IUdU5QOu/1TQmh7xcD5yzV4A7a6Ur0etA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paMudDPgZMR1Z72iavL1P01sIvnCSntWlEqAIaUGZmvg0uOGMYDg1eykPjPUmV+tvBEnE4yWZzCyvR2q4M0CsFZjj/6NJwlQA8RihLXmzo5/JeHoe1sgZ7LVdjEJoGlUu1lqs9LslUjFMVzmfzsFqWxNLZ3x23RMzn+kNOHhbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gASyynp5; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gASyynp5"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-836c4474028so24852567b3.0
        for <git@vger.kernel.org>; Sat, 29 Aug 2026 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788010709; x=1788615509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HycNXNoKTuVfkAIajlLWwKQE0YItA4fYZhHCB6iiRuA=;
        b=gASyynp5phkZ3xrwJzhQjGfhNYXsgZhlFRN7ZA0BBYGKhRjgZ9v1OCbUbyQgKuS1Jg
         yqllOBYkKVgc4RwMY4g+MD1J+Bc42DhEeTs4gaYRaCIIaBZSMCjvl0vU38qKUyIya1kq
         rETrbMpfNOx7OGkW8xucOVjQAS4ewagWLULFRz+g4fzgB4KgoM3wfauO9SylFumCUxio
         urJAyan3UT3D4fTbWeI/EZcPdlTwJFnDDxhOTEytZ+EL81oNRQYl1PNfYJMiUgCaRcWq
         e9wWRSBwYHc0u2MNR+NkGPuVrZX1rTHftzZOSqWO8wiiWdVJFhWjZGK5SzLNlzpGmcVJ
         oSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788010709; x=1788615509;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HycNXNoKTuVfkAIajlLWwKQE0YItA4fYZhHCB6iiRuA=;
        b=JXMhnn/Xjzw+oLYmk6rE3MQE2NY90GGcNtaXO2eVpS8syZT+6SQUTBVL9XHtG2GDJj
         Zo/yVluSVhxdx3CTM5+EO5e8mGkWwE76RIf50Sjuvzv728XXmkA/9gxRBhjJPZ0EZAdB
         TBFDhlfh+xuMjw8Q/T4uEuTsk6W7+AWT3sj+r2r4Hcf5xljcu9nWd84wAjmj4mX15vB3
         x2+saBurbz6uNrB4Xr8WEx5E2dvGFrno0UwZ1EXC+9wT8Y4HaOus0GXlf79cyb6/8hs6
         lIJnNI6PPBYGR+vblMHUFQ1/Pr5K9Xj9MPbCkXK45iwLPN+HgB+ijQCcT3++55JGe/Lm
         w+dQ==
X-Gm-Message-State: AFuF++nCxVq/oIgwYED0zdSmOfSDvveX+0jmStevQdiyfNceOi49KuKU
	JRtrE0bGS7E+c8FS6L4b18pDLec7eGC/tiSWe2oe+1s+qLTx5aiM475gt7ZYN7kg
X-Gm-Gg: AYBFou3h9Dr/n5q1/MxIE3V398uGscImoZEU0K2CU3iPgBR2fihHXb4otb98V2IO4hS
	2+TunoKB1WjJ9GCXlHApL9Qln1Uf4v7Z9EgT5VNQKrEaha8M1kOIPjqognd5qdRkHd5zTIiFckq
	98oFPlEakKV6kVuepcVY50kqvjX1+0CVZVqcC+5mK10wHNaONnl/gde4KO52v06SL/jhEQC8CGe
	uda9724BuCDCLurE0FlDOeTbdXlx1spykQfS3SdFqGb3pdUBMbOWrKH9qGp/cwXslsaNW0g4Y1V
	sNFT+p9/bVPFYlYl8yDA7Jj7uuwEz+6gTSgSaM4uOvqLn5/Zhf32FWoHuQ+Os9oCcPG6R3Jp2P3
	nosPaGl22Ia6wMJgwLzf5q5QQ+nwHhPCKakqlJE0Emjr23i9zLa7lrV9tMJZNPyV822iub+oOUj
	glciw7eAxlZo82q6MHZMl5JQQHyqutpcvs5SeQek1LAVqiaQJZook5m7pRsZ83SKyuKJ1qDpbhb
	XNvuBe7NR5JmUfj51m9VEIec12YBo9TugWMEUyfWHJrGTiQEm6AtFpZxo0Ja1iX1ji3bjnUUxlJ
	+Qb9pDs4TmgO5WYUcyJMAg==
X-Received: by 2002:a05:690c:c759:b0:820:1251:d2c2 with SMTP id 00721157ae682-85d6f3e09c6mr44981177b3.28.1788010709475;
        Sat, 29 Aug 2026 06:38:29 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e66abaf31sm21364557b3.35.2026.08.29.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 06:38:28 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v5 0/3] Convert USE_NSEC to runtime config
Date: Sat, 29 Aug 2026 09:38:17 -0400
Message-ID: <cover.1788010335.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed.dirty
In-Reply-To: <cover.1787231825.git.ben.knoble@gmail.com>
References: <cover.1787231825.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Topic name: dk/use-nsec-runtime (applied)

Topic summary: Expose USE_NSEC as a runtime configuration, since
build-time is too early for distributing Git [1]. As a result, common
index-related options, like git-diff, are less likely to hit "racy git"
problems on supported filesystems.

[1]: https://git.github.io/rev_news/2026/07/31/edition-137/

Built on master (2c78326f81 (The 11th batch, 2026-08-05)).

Changes in v5:

- improve message flow in patch 2

    Junio: my apologies. I missed that the "What's cooking" changed from "Needs
    review" (#10) to "expecting a small (hopefully final) reroll" (#11, #12),
    since I was expecting to see Patrick's review. This just tweaks the commit
    message as you suggested.

Changes in v4:

- fix message typo
- change #ifdef strategy: only ignore the config variable.
  Otherwise, use the use_nanosec member unconditionally. Also clarify
  that config might be ignore depending on build options in the docs.
- mention potential platform unsafety directly in config doc in
  addition to the link to Racy Git

Changes in v3:

- #ifdef out use_nanosec when NO_NSEC is requested

As I have heard no comments about the "Todo" lines below, which perhaps
could more clearly be marked "RFC"/"RFH", I've added this line to call
them out ;) and renamed them "Comments welcome"

Changes in v2:

- move Best-viewed-with trailer into message body as descriptive
  text.
- read core.useNanosec through struct repo instead of parsing
  config strings. The test suite passes locally this way, though that
  skipped 151 tests.
    - CI run: https://github.com/benknoble/git/actions/runs/31701945211

Original cover letter:

Hi all, this series follows up on the previous racy Git/USE_NSEC
conversations.

- The first patch is a mostly-unrelated documentation fix for Meson, but
  it came out of something I spotted while reviewing the outputs of the
  final (main) patch.
- The second patch is a preliminary no-op reorganization of
  repo_config_values_init.
- The third patch is the meat, converting USE_NSEC into core.useNanosec.

There is a small textual and semantic conflict with
'ty/repo-config-cleanups' in 'seen', since that branch removes the
comments in 'struct repo_config_values' which this series adds to. (The
semantic conflict is that, if we drop those comments, we should probably
not add them to repo_config_values_init like I do in patch 2.)

Comments welcome: I haven't touched any tests; I saw a bunch of hits for
"git grep racy t" but wasn't sure how to fit this particular change in,
especially since it won't be equally valid on all systems? Advice
welcome.

Comments welcome: I wonder if "useNanosec" paints us into too much of a
corner; that is (slightly more abstractly), we are using *extended
precision* in the index. Maybe the name and documentation should reflect
that, so we aren't too committed to "nanoseconds"?
    - Some platforms could offer extended precision that is not as
      precise as nanoseconds
    - Some could offer precision _beyond_ nanoseconds

idk.

v1: <cover.1786103607.git.ben.knoble@gmail.com>
v2: <cover.1786710807.git.ben.knoble@gmail.com>
v3: <cover.1787065125.git.ben.knoble@gmail.com>
v4: <cover.1787231825.git.ben.knoble@gmail.com>

[1/3] meson: expose knob for xmlto relative links in manuals
[2/3] environment: align repo_config_values_init with struct declaration
[3/3] core: convert build-time USE_NSEC into runtime core.useNanosec

 Documentation/config/core.adoc        |  7 +++++++
 Documentation/meson.build             |  7 ++++++-
 Documentation/technical/racy-git.adoc | 11 ++++++-----
 Makefile                              | 12 +-----------
 builtin/update-index.c                |  2 +-
 compat/posix.h                        |  1 -
 configure.ac                          |  6 ------
 environment.c                         | 27 ++++++++++++++++++++-------
 environment.h                         |  1 +
 meson_options.txt                     |  2 ++
 read-cache.c                          | 15 ++++++---------
 statinfo.c                            | 14 +++++++-------
 12 files changed, 57 insertions(+), 48 deletions(-)

Diff-intervalle contre v4 :
1:  d612de6c2d = 1:  d612de6c2d meson: expose knob for xmlto relative links in manuals
2:  5693baa992 ! 2:  12974e07d0 environment: align repo_config_values_init with struct declaration
    @@ Commit message
         environment: align repo_config_values_init with struct declaration
     
         The order of assignments in repo_config_values_init is chaotic and hard
    -    to follow, especially when comparing with the struct definition to
    -    ensure all members are initialized. As new members will be added in the
    -    future, make it easier to validate changes by aligning the two.
    +    to follow, especially with the definition of 'struct repo_config_values'
    +    to ensure all members are initialized. As new members will be added in
    +    the future, make it easier to validate changes by aligning the two.
     
         Refactor assignment order with no behavioral changes.
     
3:  0aa0e9fc17 = 3:  01cd487cd2 core: convert build-time USE_NSEC into runtime core.useNanosec

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
2.55.0.860.g4b6b3295ed.dirty

