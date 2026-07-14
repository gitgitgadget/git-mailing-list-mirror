Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680BD390C9A
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030984; cv=none; b=Rda0uBuX1NgYhRz2Ga5eAAgFuNtB38I4gIb0TZ1IR+O5Qe0nTMcSxpzuiP1b3Pj705mU1Zrp2EoHacK3Viwk51pxT5vqXFWExDoXQZHblGgh174dds7HVIPajl+cWeliHBfeDZ+fwCTZqyEHOLKh8Rda7oP5xHv8sx88YwzT5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030984; c=relaxed/simple;
	bh=A+NX9vC+dxCdXTooK/GCBydfA9M7iOL2yvYU1LG1JN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpBtU0RtxnAz7d+TlnJ4ZE2SH27p1/MC93ceE2E9aqu0ddeq4PvvGEmv5WOPmjhD8YaTLDsTxw0yo8//MEjYsrCj2azfVtRGYsmhyJJiDMmFFtcfzt2xXoMACO4qTYuweJDHI/pPw8EcHPOjkw3EnAb8ISbW3afsg0F18Dyjyu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvKO5sQT; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvKO5sQT"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso4039514f8f.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030982; x=1784635782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wkaBIidNT2pgjbM3Jnh0XgW4IHM8k1Cy3VA6im99Hug=;
        b=VvKO5sQTz+2Mfpe1isbb+WEUqu6Nhni6HZjEVOAD9qWIaqc2iAE2pTlhnx0MkeI3wV
         K3OtKHL6xTerVVllQYWi6/EaLOTz5nsk7xEKro7MiGtIZRS2uOyvd3tHPpIUAAMOtXTx
         BnWCiqV6IBFLBCkAaaVBiJAWBg2qTmTi+SD8ZGqWFoOO8Ny1d61q1N0Y8wxT3swxDrlK
         zbsKkBqcuKgFAXHkqowUyZAzFuRWZ0cWBPPNUOAOj09cNki6VeYIaQY7a47WSg2yGlqd
         QoiutjM0L0s4K1omjFeTp6kss9GrookdVTrkMSYel1vWQGJpNQLvmloET3PrWr3fJQVg
         pu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030982; x=1784635782;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wkaBIidNT2pgjbM3Jnh0XgW4IHM8k1Cy3VA6im99Hug=;
        b=P4T9NnTGoiFdfERAbo7+dgWF9xe4Cakf95loaxpzU15nFydm6TYCwC9m9zG/EigbMb
         POKtGzeFwxXRH5TuGio32pNowvUQrWG1lx7BB3xYh1od/etqKOTxamiAYj8+Ocf6wwlQ
         Piz1x/82XeIioyR1MIvOCtx45K2LSnWWQJgk1/VCp76nx4udKI8ERA0LruXoGC5Qu3vI
         huQXpQX4sRfX4IFIstHBGDQdkWHG5c1l57+lsEEf96DxAeaqawBchmfLkCusrsT36Oyx
         pdLRneqftFGQvc965zsigqVwl9qmZAJ9i6tXahjzeEwssEu74yVIN/Ckpcel5/tevb9l
         blxg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0r3iERn/wWyoSmYYWwhca17CKwe+WQ7whQyY9p0i740N3cUhsRXbbFppAyijOSfZRxCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLahKsY4pAPh+kXLUswbXSC663Bdfw64HgV+uovkAo0+qsaUMD
	GJOS/PABKd0b/ktnEU/72/ZJFsp9EFepMGo/e3C52o0Hpoez8EryB7nL
X-Gm-Gg: AfdE7cnrK+QIMo+fAgR9nHwRNZJny/1AoCVCIuknOUpj/AEB6Hd2v9WhEqxLu+AHk2X
	40sHRqEGqjnTHUocAD5sT8/x6tf5wQuBj8OiN9eagjqHNik/LhzKXKaokrs/tHTRuOZkxoFeG0d
	+p9dsbZa5cQmHoBAYk/2zK1/Tnhp/RUvRQH7dqDqJmJsAHtvtZXAq+r8Pf7Wey/36kcU761FpG3
	dyN9nfKIw0uvVIRYFojb91yV3ROQSU+V2aw4ChvDBZDdBCRj3Q1t5Kv7VFxtZ+BHsIt7ZWdokC1
	/67IMPABg3tqG8m9vtpfP5al+swlXO0CAVeP9JxOsPdH6A0Pwdj1q4SpVnIp0isRkCUjK1QKPUs
	WGMvtmNXYNP6SphPIqRLVfFirxdqQFBG7NfJ1Ru3+9mo1wIjNfT3UJzIfmWBVLKUG4qEl4v1+kC
	tQwgiuCSOyqAaVo4twj5d67hx5HbSsuLKddM46TJOFB7dmO3e96dWrYHmQGtQQ5r6kFWoOEZIZk
	y+yVO2MI1ut4v875o8Lzfx3N96CFDAVOGzqVwbAy0FHZaLhJU0hNqpuOcxNUpQxvI9UwDaM2vRT
	EhWS6WfsZ2GD85Q/IMYut6qGHyd5bsHeTmDwvvpagFfWfDCCq1seXO18JbQhIntY64Of+dBzBRz
	oKYfDZsqg/g==
X-Received: by 2002:a05:6000:1786:b0:475:f0c2:75a6 with SMTP id ffacd0b85a97d-47f2dd08a4emr15323580f8f.55.1784030981417;
        Tue, 14 Jul 2026 05:09:41 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c89e5sm7749939f8f.34.2026.07.14.05.09.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:09:40 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v12 0/7] graph: indent visual roots in graph
Date: Tue, 14 Jul 2026 14:09:31 +0200
Message-ID: <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
References: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260612-ps-pre-commit-indent-39ca72816382
Content-Transfer-Encoding: 8bit

When rendering a graph, if the history contains multiple "visual roots",
actual roots or commits that look like roots (i.e. have their parents
filtered out) can end up being vertically adjacent to unrelated commits,
falsely appearing to be related.

A fix for this issue was already attempted [1] a while ago.

This series adds indentation to the visual root commits, so they cannot be
vertically adjacent anymore making it easier to identify them.

Before indentation:

	* A
	* B1
	* B2
	* C1
	* C2

After indentation:

	  * A
	* B1
	 \
	  * B2
	* C1
	* C2

Indents the visual root commits that have still commits to show after
them, and if they have children it connects them with an edge at a new
row.

If there are multiple visual roots adjacent in history, the indentation
starts with the second one, avoiding redundant indentation of the first
one and cascades after the second.

	* A
	  * B
	    * C
	      * D
	* E
	  * F
	    * G
	      * H
	  * I
	* J1
	* J2

The indentation wraps after cascading columns and when wrapping back to
the initial column if the next commit is a non-visual-root commit, force
the indentation one extra level.

Series explanation:

1. Cleanup to bring a common function from t4215 and t6016 that will be
   used in t4218.

2. Logic extraction of the chose of from where the commit source comes
   from.

3. Add a buffer for lookahead purposes.

4. Principal commit. Implement the logic to get the visual roots
   indented.

5. Make visual root cascading wrap after 4 columns

6. Add --[no-]graph-indent and log.graphIndent options.

GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/29331144667

[1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

V11 DIFF:

- Changed the check that required graph, to not confuse because it is a
  boolean value.

- Typos

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Pablo Sabater (7):
      lib-log-graph: move check_graph function
      revision: add next_commit_to_show()
      graph: add a 2 commit buffer for lookahead
      graph: indent visual root in graph
      graph: wrap cascading commits after 4 columns
      graph: move config reading into graph_read_config()
      graph: add --[no-]graph-indent and log.graphIndent

 Documentation/config/log.adoc              |   4 +
 Documentation/rev-list-options.adoc        |   8 +
 graph.c                                    | 332 +++++++++++++++-
 graph.h                                    |  17 +
 revision.c                                 |  57 ++-
 revision.h                                 |   2 +
 t/lib-log-graph.sh                         |   5 +
 t/meson.build                              |   1 +
 t/t4215-log-skewed-merges.sh               |  33 +-
 t/t4218-log-graph-indentation.sh           | 596 +++++++++++++++++++++++++++++
 t/t6016-rev-list-graph-simplify-history.sh |  25 +-
 11 files changed, 1032 insertions(+), 48 deletions(-)

Range-diff versus v11:

1:  dd0bb0d215 = 1:  d754392142 lib-log-graph: move check_graph function
2:  07e239533d = 2:  c93c2c0771 revision: add next_commit_to_show()
3:  4d71f674a1 = 3:  70fe612ae1 graph: add a 2 commit buffer for lookahead
4:  48ad2562f0 = 4:  e1ac06c4ea graph: indent visual root in graph
5:  45be69d11b = 5:  ce52b41527 graph: wrap cascading commits after 4 columns
6:  8ce53ae21b = 6:  9b7bb2cebc graph: move config reading into graph_read_config()
7:  c1fa81022e ! 7:  13e830725f graph: add --[no-]graph-indent and log.graphIndent
    @@ Documentation/rev-list-options.adoc: This implies the `--topo-order` option by d
     +	When used with `--graph`, indent visual roots (commits with no parents
     +	or whose parents are not shown) to differentiate them from commits that
     +	are vertically adjacent but unrelated. Enabled by default. Use
    -+	`--no-graph-indent` to disable or set `graph.indent` to set a deafault
    -+	preference.
    ++	`--no-graph-indent` to disable or set `log.graphIndent` to set a
    ++	default preference.
     +
      ifdef::git-rev-list[]
      `--count`::
    @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
      	if (revs->graph_max_lanes > 0 && !revs->graph)
      		die(_("the option '%s' requires '%s'"), "--graph-lane-limit", "--graph");

    -+	if (revs->graph_indent_set > 0 && !revs->graph)
    ++	if (revs->graph_indent_set && !revs->graph)
     +		die(_("the option '%s' requires '%s'"), "--[no-]graph-indent", "--graph");
     +
      	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
    @@ t/t4218-log-graph-indentation.sh: test_expect_success 'visual root cascading get
     +	EOF
     +'
     +
    -+# graph.indent true and no --option is the default state.
    ++# log.graphIndent unset and no --option (which activates graph indentation) is
    ++# the default state.
     +
      test_done

---
base-commit: f60db8d575adb79761d363e026fb49bddf330c73
