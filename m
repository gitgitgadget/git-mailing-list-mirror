Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1B533065C
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775291423; cv=pass; b=uLut+sFNZydWeaXaGgS/AdDAGpUW6aSMFDOzbOhGYaeybK9dBuZO9uQ5aeuxjHtxZo4ZwS7mHYqozkJ1DRywz8+dZPahrO7KfuxQ94nXxNQ65yNFjL4Wx/FMM3K0lJuLhLJZ4yJbil5VWFIAjmwHel5TaEVJOJxxZmpWLb3TBv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775291423; c=relaxed/simple;
	bh=L7R/PRnwqixxG0cGK30k8R/fkCZAtBjYveA6cPkYKOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTywpEIUxosWFDQzE7wPbMoVc1U6Grt22fHhLMRCSuQ0mAkRz5gPpZ65uuFie4H465maEjN4jkYSGmWXthnq3nzmPI5x8yUWPPXWHqXiCAyd6SOganNccXEynIB8KNLFXZoxMfucbK1jEyoMvLmUteoMXSDHoBMd1ssbiZveUIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=aBaPzvCW; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="aBaPzvCW"
ARC-Seal: i=1; a=rsa-sha256; t=1775291398; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iQvoluXXEj/Iiz8XdTl098+Mh3x4M/s4DSxf4qE+jqUoNnC+c8+xleNI4yfKNTMsKtRwIG/8F7h0Oo582T8eOSjg8//ReHLCnX5JC29OJTjxu/cRuqMbq4P7fxr/eXbTzDfbJq62hqqDgJngWBHATdhanwonbDK+7KF+Gp+H6aA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775291398; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h0JeFa35vvn2UsLYYCXz8gbypkCG66TEYFFi8W6Vsjo=; 
	b=aGyQsteLylNkzjzgppO0yri7gTToIqr+YXYOZKtKFy0Kpeq/mR1l2MqqA12sr8okUGZBtWIhU7zaXB1fEHB+g48bycPESLlSEd52ixr3eqHmCe0+AsqqmGoiDOEhR3Sm8uv+qrunkzDI0GrGyJzWKx10Eqc1BFobFBLHmF1BhIY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775291398;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h0JeFa35vvn2UsLYYCXz8gbypkCG66TEYFFi8W6Vsjo=;
	b=aBaPzvCWP0fDJokDmcDZa8V5VwXANM2nWPCZSSuJs3+76c4NjUSpMojiVbdg8oto
	P7IsAykDeHTIdd+bpU8OQ1ozxrfnrA6tdL3KDp8RSIndcKaXxR40z2nHGaIwCSIchWf
	zdRb0mpvGBE3PlSR6FXMFWCM5OM66BiepTVp5AWI=
Received: by mx.zohomail.com with SMTPS id 1775291395061246.11479948319095;
	Sat, 4 Apr 2026 01:29:55 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v6 00/12] Run hooks in parallel
Date: Sat,  4 Apr 2026 11:29:22 +0300
Message-ID: <20260404082934.173788-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

This series enables running hook commands in parallel and is now
based on the master branch because all prerequisites have landed.

v6 is just a minor refresh which includes a meson build fix provided
by Patrick and fixes a trivial conflict with the master branch for
that specific patch.

Branch is pushed to GitHub: [1]
Successful CI run: [2]

1: https://github.com/10ne1/git/tree/dev/aratiu/parallel-hooks-v6
2: https://github.com/10ne1/git/actions/runs/23974475271

Changes in v6:
* Included the meson.build patch fix supplied by Patrick and added
him as co-author on patch 10 (Patrick)
* Fixed a trivial code conflict on the master branch due to build
scripts having moved into tools/ for the above patch (Adrian)

Range-diff v5 -> v6:
 1:  f5624a2a1f =  1:  b79b6d4d92 repository: fix repo_init() memleak due to missing _clear()
 2:  8ae5eec9c9 =  2:  04d70c5fe6 config: add a repo_config_get_uint() helper
 3:  f9278a22ea =  3:  9d52e73211 hook: parse the hook.jobs config
 4:  7cbe7d2f7c =  4:  fa52e229e6 hook: allow parallel hook execution
 5:  fd39771388 =  5:  255e87fe42 hook: allow pre-push parallel execution
 6:  54c08cb72b =  6:  eb60a9effe hook: mark non-parallelizable hooks
 7:  5957cd9c72 =  7:  44eaa1b5eb hook: add -j/--jobs option to git hook run
 8:  a58f05e9d5 =  8:  dcd7f91d96 hook: add per-event jobs config
 9:  4fb39ad98d =  9:  7b1513b648 hook: warn when hook.<friendly-name>.jobs is set
10:  d3c6e8f3e2 ! 10:  1a808c35c3 hook: move is_known_hook() to hook.c for wider use
    @@ Commit message
     
         Make it return bool and the iterator `h` for clarity (iterate hooks).
     
    +    Both meson.build and the Makefile are updated to reflect that the
    +    header is now used by libgit, not the builtin sources.
    +
         The next commit will use this to reject hook friendly-names that
         collide with known event names.
     
    +    Co-authored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Makefile ##
    @@ hook.h: void hook_free(void *p, const char *str);
      /**
       * Returns the path to the hook file, or NULL if the hook is missing
       * or disabled. Note that this points to static storage that will be
    +
    + ## meson.build ##
    +@@ meson.build: libgit_sources += custom_target(
    +   env: script_environment,
    + )
    + 
    ++libgit_sources += custom_target(
    ++  input: 'Documentation/githooks.adoc',
    ++  output: 'hook-list.h',
    ++  command: [
    ++    shell,
    ++    meson.current_source_dir() + '/tools/generate-hooklist.sh',
    ++    meson.current_source_dir(),
    ++    '@OUTPUT@',
    ++  ],
    ++  env: script_environment,
    ++)
    ++
    + builtin_sources = [
    +   'builtin/add.c',
    +   'builtin/am.c',
    +@@ meson.build: builtin_sources += custom_target(
    +   env: script_environment,
    + )
    + 
    +-builtin_sources += custom_target(
    +-  input: 'Documentation/githooks.adoc',
    +-  output: 'hook-list.h',
    +-  command: [
    +-    shell,
    +-    meson.current_source_dir() + '/tools/generate-hooklist.sh',
    +-    meson.current_source_dir(),
    +-    '@OUTPUT@',
    +-  ],
    +-  env: script_environment,
    +-)
    +-
    + # This contains the variables for GIT-BUILD-OPTIONS, which we use to propagate
    + # build options to our tests.
    + build_options_config = configuration_data()
11:  312acd15b4 = 11:  a5d37a0ea1 hook: add hook.<event>.enabled switch
12:  f54844d13e = 12:  136cd50cea hook: allow hook.jobs=-1 to use all available CPU cores

Adrian Ratiu (9):
  repository: fix repo_init() memleak due to missing _clear()
  config: add a repo_config_get_uint() helper
  hook: parse the hook.jobs config
  hook: allow pre-push parallel execution
  hook: add per-event jobs config
  hook: warn when hook.<friendly-name>.jobs is set
  hook: move is_known_hook() to hook.c for wider use
  hook: add hook.<event>.enabled switch
  hook: allow hook.jobs=-1 to use all available CPU cores

Emily Shaffer (3):
  hook: allow parallel hook execution
  hook: mark non-parallelizable hooks
  hook: add -j/--jobs option to git hook run

 Documentation/config/hook.adoc |  76 +++++
 Documentation/git-hook.adoc    |  23 +-
 Makefile                       |   2 +-
 builtin/am.c                   |   8 +-
 builtin/checkout.c             |  19 +-
 builtin/clone.c                |   6 +-
 builtin/hook.c                 |  46 ++-
 builtin/receive-pack.c         |   3 +-
 builtin/worktree.c             |   2 +-
 commit.c                       |   2 +-
 config.c                       |  28 ++
 config.h                       |  13 +
 hook.c                         | 286 ++++++++++++++++-
 hook.h                         |  38 ++-
 meson.build                    |  24 +-
 parse.c                        |   9 +
 parse.h                        |   1 +
 repository.c                   |   3 +
 repository.h                   |  10 +
 t/t1800-hook.sh                | 546 ++++++++++++++++++++++++++++++++-
 transport.c                    |   6 +-
 21 files changed, 1081 insertions(+), 70 deletions(-)

-- 
2.52.0.732.gb351b5166d.dirty

