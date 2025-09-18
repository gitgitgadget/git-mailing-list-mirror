Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868D34BA25
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174434; cv=none; b=A1hjAR5On6j4iiQK752H/iYwYNC+6coPMMS5+WpeEfNyPpgqcS81TrvnWsP115T/j6Hih1niWjtURAqIEfKcORZ4cP85ELi+timgAvpDKrYtxfPEFWNaaL/h8ROWL9oqwxSbJ1ZSTw+ClCfWKxINLBuO45CLEjRD96QLOf69UDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174434; c=relaxed/simple;
	bh=iK+HCpwNCSIJgogsyt4M8Axti2OQAwdWxxRNzNjBZoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/Cg6F756Q39e7kVjQEOGCOCHLOQKvJBRuNDsbXkeAiY089lFk1E8zbFK8q9lJ9aTckMQQNhyIIHPECFPxgCAJls2XkJ1QAhexmwr0FlH8uJZTwgx84NfGws77fCouZsmeohpvL8WK0n+TY9khB9xxemv5ogc3hBv7ZD+ldnXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFWBXbCJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFWBXbCJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-25669596921so5907505ad.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758174431; x=1758779231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy8yAfcolaFqGWSRM8q0FhRekM36S8/lcLb48R0PT1c=;
        b=bFWBXbCJQPLir2s5UZEh2WhHcmEM1wYYfBuukiuncavjRBbhE8MnLc/HEYauSuXv69
         hgK8g+7giLIGZ2kTw6wJ34/VkSGgDoduCglalZPQT+EKuq8MK9P1FUKX1vvLW8JFzzPM
         4l663eAkMfqAmKRgeA4mB3yCMAH5/17PNVO2HTxj0rV1D8yXMw5zC/zFEinSmP8KgXLf
         Yu6QlqlUhEmhjIuI4zie0U6FUEFFyEqy93bkbHKu2uRzRnt0S98aroeRV4swdfS/+HWm
         9XaRRK439wQWqClhWbnR2K77Vuv/E+iECG4IeXmneecIrLDtIAG4PljOG61UZ/btbj0q
         kuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174431; x=1758779231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy8yAfcolaFqGWSRM8q0FhRekM36S8/lcLb48R0PT1c=;
        b=PolqfBKvXprXHLjyx/b2wPTbKxxSbNl71/9xuYHAE8SLIGSAOX6yGVFw5nmn0eK+yJ
         BmKbDoxieSNvJfDsvSGmI0pJ1yqgCur2sGr8NghzpWQXldg+spheuqvxIeiCVURI6xnA
         GanzKOCtKXcPzwBYFCe8yVn52NubiO68NVm0uYQ8vardm9L4X7tkhS03lIT+Ip0ok3Wz
         I6RBoOEemKxgyOlBxUOAp8THfrUEZI7r0XXltNMe4WpJ1ubuxsd18jnswxexBaVBgWvN
         S6Y4nyrjlU4CAT+UAJnIPZwJr0p2hm6afXMpBqfoS4E91IKg8sWtBJw5NoHu3i5mCkdp
         ejMw==
X-Gm-Message-State: AOJu0YyJEkIvPptrl7Z2JxYvyACdwC+KWoBhE6Dx5mmO2C6TMav0ukEs
	EuIUPovLkrW0crPRLzc5sHNNpBI+TVIFQfLsp8Fn++GiHaE8FQFdA6JqcThOZw==
X-Gm-Gg: ASbGnct9z6+z9680QMiHJCxK2xKWVMlpXNIgSP0pBFHna41W25rUsl6pdLhFFCC2smp
	TFmZBTKcGoyViTNepqwGsAIGb0disY5AbITFkzZLpAfu86DEdoozJZyy5LGPVSqd7A96YHkodS7
	UD8IwOGzRFT06eUVFbBzEXcGy3BjO/7PB3VRLSmukIlcw+m9hAmtDJHyApqEs6DwVNztrETpqzk
	I3B22XYx2e6FcasWBDXxiKA2ts2dGw1UUMtrgkDEQn1tep7GwlWpeoU+QazgInSsOOQ8YoQeFC3
	MQc4EXiIXJndFttZ7A9AgTProU12CHdjSelbYTIEq/lnQFpbWcIeFNdm6w8uDlW8+LtbYzVfT+P
	r+fwBsWSuWtQ5ZsnPEKVQghfs91BNAAL52mVXaw==
X-Google-Smtp-Source: AGHT+IHF2NLOfKxfd6smdaBtMmbQWohJNhCZj8J6Y7carjLl474kwiJ4ezOd8ZAZY0RmyywiwmSrhw==
X-Received: by 2002:a17:903:2345:b0:269:6401:7fdb with SMTP id d9443c01a7336-26964018c43mr57153525ad.17.1758174430942;
        Wed, 17 Sep 2025 22:47:10 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm13621535ad.86.2025.09.17.22.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:47:10 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 0/9] Add refs optimize subcommand
Date: Thu, 18 Sep 2025 11:16:55 +0530
Message-Id: <20250918054704.544254-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906075147.1076656-1-meetsoni3017@gmail.com>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series introduces `git refs optimize` as a modern replacement for
`git pack-refs`, continuing the effort to consolidate commands
under the `git refs` namespace.

Changes in v3:
- Reworked the entire series from scratch to implement the
  architectural feedback provided by Junio in the v2 review.
- Instead of a simple UI alias, this version introduces a generic,
  backend-agnostic `refs_optimize()` API.
- Added implementations for both the 'files' backend (packing) and
  the 'reftable' backend (compaction).


Meet Soni (9):
  refs: add a generic 'optimize' API
  files-backend: implement 'optimize' action
  reftable-backend: implement 'optimize' action
  builtin/pack-refs: convert to use the generic refs_optimize() API
  builtin/pack-refs: factor out core logic into a shared library
  doc: pack-refs: factor out common options
  builtin/refs: add optimize subcommand
  t0601: refactor tests to be shareable
  t: add test for git refs optimize subcommand

 Documentation/git-pack-refs.adoc     |  53 +---
 Documentation/git-refs.adoc          |  10 +
 Documentation/pack-refs-options.adoc |  52 ++++
 Makefile                             |   1 +
 builtin/pack-refs.c                  |  54 +---
 builtin/refs.c                       |  17 ++
 meson.build                          |   1 +
 pack-refs.c                          |  56 ++++
 pack-refs.h                          |  23 ++
 refs.c                               |   7 +
 refs.h                               |   6 +
 refs/files-backend.c                 |  10 +
 refs/refs-internal.h                 |   3 +
 refs/reftable-backend.c              |   7 +
 t/meson.build                        |   3 +-
 t/pack-refs-tests.sh                 | 431 +++++++++++++++++++++++++++
 t/t0601-reffiles-pack-refs.sh        | 430 +-------------------------
 t/t1463-refs-optimize.sh             |  17 ++
 18 files changed, 650 insertions(+), 531 deletions(-)
 create mode 100644 Documentation/pack-refs-options.adoc
 create mode 100644 pack-refs.c
 create mode 100644 pack-refs.h
 create mode 100644 t/pack-refs-tests.sh
 create mode 100755 t/t1463-refs-optimize.sh

Range-diff against v2:
 -:  ---------- >  1:  a837ae6f5d refs: add a generic 'optimize' API
 -:  ---------- >  2:  e0613b14b6 files-backend: implement 'optimize' action
 -:  ---------- >  3:  ae8d2d29d9 reftable-backend: implement 'optimize' action
 -:  ---------- >  4:  a8cba8a355 builtin/pack-refs: convert to use the generic refs_optimize() API
 1:  67a9187b59 !  5:  ec1085ccd8 builtin/pack-refs: factor out core logic into a shared library
    @@ builtin/pack-refs.c
     -	if (!pack_refs_opts.includes->nr)
     -		string_list_append(pack_refs_opts.includes, "refs/tags/*");
     -
    --	ret = refs_pack_refs(get_main_ref_store(repo), &pack_refs_opts);
    --
    +-	ret = refs_optimize(get_main_ref_store(repo), &pack_refs_opts);
    + 
     -	clear_ref_exclusions(&excludes);
     -	string_list_clear(&included_refs, 0);
     -	string_list_clear(&option_excluded_refs, 0);
    @@ pack-refs.c (new)
     +	if (!pack_refs_opts.includes->nr)
     +		string_list_append(pack_refs_opts.includes, "refs/tags/*");
     +
    -+	ret = refs_pack_refs(get_main_ref_store(repo), &pack_refs_opts);
    ++	ret = refs_optimize(get_main_ref_store(repo), &pack_refs_opts);
     +
     +	clear_ref_exclusions(&excludes);
     +	string_list_clear(&included_refs, 0);
 2:  422eaa0c8b !  6:  e1758816bf doc: factor out common option
    @@ Metadata
     Author: Meet Soni <meetsoni3017@gmail.com>
     
      ## Commit message ##
    -    doc: factor out common option
    +    doc: pack-refs: factor out common options
     
         In preparation for adding documentation for `git refs optimize`, factor
         out the common options from the `git-pack-refs` man page into a
         shareable file `pack-refs-options.adoc` and update `git-pack-refs.adoc`
         to use an `include::` macro.
     
    -    This change is a pure refactoring and results in no change to the
    -    final rendered documentation for `pack-refs`.
    +    This change is a pure refactoring and results in no change to the final
    +    rendered documentation for `pack-refs`.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: shejialuo <shejialuo@gmail.com>
    @@ Documentation/git-pack-refs.adoc: unpacked.
     -+
     -When used with `--include`, refs provided to `--include`, minus refs that are
     -provided to `--exclude` will be packed.
    --
     +include::pack-refs-options.adoc[]
      
    + 
      BUGS
    - ----
     
      ## Documentation/pack-refs-options.adoc (new) ##
     @@
 3:  067a2baa97 !  7:  e3a908fe72 builtin/refs: add optimize subcommand
    @@ Commit message
     
         As part of the ongoing effort to consolidate reference handling,
         introduce a new `optimize` subcommand. This command provides the same
    -    functionality and exit-code behavior as `git pack-refs`, serving
    -    as its modern replacement.
    +    functionality and exit-code behavior as `git pack-refs`, serving as its
    +    modern replacement.
     
         Implement `cmd_refs_optimize` by having it call the `pack_refs_core()`
         helper function. This helper was factored out of the original
    -    `cmd_pack_refs` in a preceding commit, allowing both commands to
    -    share the same core logic as independent peers.
    +    `cmd_pack_refs` in a preceding commit, allowing both commands to share
    +    the same core logic as independent peers.
     
         Add documentation for the new command. The man page leverages the shared
         options file, created in a previous commit, by using the AsciiDoc
    @@ Documentation/git-refs.adoc
     @@ Documentation/git-refs.adoc: git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
      		   [--contains[=<object>]] [--no-contains[=<object>]]
      		   [(--exclude=<pattern>)...] [--start-after=<marker>]
    - 		   [ --stdin | <pattern>... ]
    + 		   [ --stdin | (<pattern>...)]
     +git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
      
      DESCRIPTION
    @@ builtin/refs.c: static int cmd_refs_list(int argc, const char **argv, const char
     +		REFS_OPTIMIZE_USAGE,
     +		NULL
     +	};
    ++
     +	return pack_refs_core(argc, argv, prefix, repo, refs_optimize_usage);
     +}
     +
 4:  640ebd9a4f !  8:  4f63632ac2 t0601: refactor tests to be shareable
    @@ Commit message
         variable and then sourcing the test library.
     
         This new structure follows the established pattern used for sharing
    -    tests between `git-for-each-ref` and `git-refs list` and prepares the test suite
    -    for the `refs optimize` tests to be added in a subsequent commit.
    +    tests between `git-for-each-ref` and `git-refs list` and prepares the
    +    test suite for the `refs optimize` tests to be added in a subsequent
    +    commit.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: shejialuo <shejialuo@gmail.com>
 5:  37ca586bb9 =  9:  39eed2831a t: add test for git refs optimize subcommand

base-commit: f814da676ae46aac5be0a98b99373a76dee6cedb
-- 
2.34.1

