Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881337DEBE
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206551; cv=none; b=JUH1y+A3q52Hi7hYcnkL78jOELBdR6r5ymeaRrUjLWdhF3TxzrAqwfyCToCz69hDwoBZMFMS3sHilctqccyzJDGOzrotuYCnj8/nmdftZigFYuzkeaPJqXAmpi/GdqLdeHhtZl0NN1vvaXwI/B8KVKR8cSKBhhYJQ2vjML7ukWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206551; c=relaxed/simple;
	bh=WeSl9y5IPtyhKBGHHqGZjEswu/NkI262tz7zFfzGlOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKTPQx5m2pzO0xNdNe4QqpMfk1rY7iMcl4u/b350UXDHGVGY60DJksZnzHfJdC9e1NwffMNUPF89tn3s6mFyya6qUgC59DH/vR2rZFxDUDFBUJpLPsgKWaGX+hLDuPnSd3YMry3Egga76U2NqoVlnQsjGxf7aITDqlWxTdfOPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpJsVFzo; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpJsVFzo"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-861f30636f9so29232057b3.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788206549; x=1788811349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hiMkVhMjz+MTtXuvLHL7iEELdy4m6pgjD9CJRmwPf8I=;
        b=hpJsVFzol5njqyUoEAUxRMvHPArn1Bj2+Bm0pEqRzp9fOLTJj4+3lUznqQz7vP5o1a
         YOipFhOV/w9x9cuzCsiCBNtPCun9g5Jn5U0LFDkZmdfs3NGT6XGkMWe/ANEDC63a88+G
         FwepPHiyzhVSUoE3H9kHBhbsp6+npCEsUkMZvpFJEqvQIzcWnyKCRVMLeujh2Qtw4C+J
         gQKTNfad4yeUYQhhXNNJtvt5q1/mqb1wrhjqUMa0yxq6bPaVnnb1ONC96e/Mgr0fgA6r
         TgHcsY4QxIcoe8NcqGYkQdmxHNocPJCnzGK0771O965vOicWrSdjYH/1HctiNyYw6zki
         7Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788206549; x=1788811349;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hiMkVhMjz+MTtXuvLHL7iEELdy4m6pgjD9CJRmwPf8I=;
        b=iRGoFwRzgJH0FnnZCaWY5ACKJxRML1gFuZ+jJl62WQkrbNmXPpkyaMNKqQlzAn2hlM
         TXkeGO2P0bD+Pc74DboZOFGSkyCnyBEL+ZorVcmAhi/oi9mH5RVKyL9EgTkkgqPeLxwu
         6wEKkcyBpZVo/QAaxMcAde94JWLJV5cSF9G9YXUr02mbmcV1Jvj0R6PUqdP/BEnEaaKV
         dO0RO+TEZlZl/v0bkTrBBSaG0429vdP09SaNMLXqW3Z3l9qKvd4YGHLEBVQ/NAnPg2am
         kS6vKNjQDIRh10LF0Wvsk18Css0YfUiQihLEvfOElhAhbSB9btrNxHlqFpnEt/NTs9d4
         YPQw==
X-Gm-Message-State: AFuF++mp0ATfxZY02wE9YmixX0HDlTSn8dnPly5phtx0CxmWyBf4ESYW
	JPibxy8z7vDeq4NxMHfHT5iR3WcLZkmPxucoW4MmZQGJ8KlLlheJJ5q8mV+FOifK
X-Gm-Gg: AYBFou3Jj1msmo4dSFA7/Fp7ntotfjzw4SixujNiMqN0gIqkvfz1cjLUSg8HvXCky2V
	c6dZx9Fq8vzjuaALuB0JyZ45BtjhEwNFOnHy2KECamhVsBH144mHfgOtBxSMp7J1h+BpVg6BB33
	ZjDcins54kL4qq+W3MVMUZH1bQU5exC5zoSVXkc7LKsabk4FzPHSaKR/GMX8a4bDa0x9EgFl9s3
	yCzcxf8XE+RDRL6iK/omGCyExHea488/ZdF6/DdGN05/picshW+VQmlrCCuD7n0JQJtjEBJ+9f6
	5g83VjqTfi6kla9vWs4pL9tETc7fU6uzegh6eKqzVWyGBBEhfVmwPQSdQapAKhj+gMIY8qxhg6p
	DrPs7eJl0T08cqSbsukVCvPH22EQsOjGz5uafLTcvu25sZXdGwIGeYIy2DfEB3RqGG5Gpz4F/Cx
	9U/0uC7pv//3fJT4V0cIe2owU4re/RzX6FboRm29qu1FK9p6I9OPGh8BJPAMELdzlsDAnD+KdrS
	WXjHIqqx0LCqd+p/RKMnO6DJXUtsw/kzTKkww6STlGuFg4sQLuc4IM1wJWXouYBlY/roRlU4KBt
	dKliJmbGyGAvtdNVceP8/g==
X-Received: by 2002:a05:690c:6912:b0:858:d6fb:2b9f with SMTP id 00721157ae682-85d660db315mr103458337b3.5.1788206521020;
        Mon, 31 Aug 2026 13:02:01 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5ed1e4fcsm60286997b3.18.2026.08.31.13.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 13:02:00 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v6 0/3] Convert USE_NSEC to runtime config
Date: Mon, 31 Aug 2026 16:01:34 -0400
Message-ID: <cover.1788206466.git.ben.knoble@gmail.com>
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
v5: <cover.1788010335.git.ben.knoble@gmail.com>

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

Diff-intervalle contre v5 :
1:  d612de6c2d = 1:  d612de6c2d meson: expose knob for xmlto relative links in manuals
2:  12974e07d0 = 2:  12974e07d0 environment: align repo_config_values_init with struct declaration
3:  01cd487cd2 ! 3:  0a611f6140 core: convert build-time USE_NSEC into runtime core.useNanosec
    @@ builtin/update-index.c: static void xrmdir(const char *path)
      {
      	/*
     -	 * not use if we could usleep(10) if USE_NSEC is defined. The
    -+	 * not use if we could usleep(10) if core.useNanosec is defined. The
    ++	 * not use if we could usleep(10) if core.useNanosec is enabled. The
      	 * field nsec could be there, but the OS could choose to
      	 * ignore it?
      	 */

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
2.55.0.860.g4b6b3295ed.dirty

