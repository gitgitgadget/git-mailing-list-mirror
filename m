Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296210;
	b=Bimr2wRxnHKTCqwQ9MlHlndSJxbMellvCau6vPG73Ff8XcmyEPWtfNGK0ovrms+sfipq
	 4exRT4MQjAiFZA/RKQu0sCJrSJn7sYsRUwzk3V6OtE60W8hF5FF9sPIVtizbQEJVNXLFs
	 QltxMyusXQ/NP+BFt27mlrrs2mJOUF6Fn5USGD8KltBWjZEFU8eWdij1Dyexum0hAVHZJ
	 Yse0tDBxpAjkwnai14eLff6W8C7lMBSjs8I5oKC2AWkUw3CeecGkGiae8vj5i8tkvnZN0
	 2+N0Qt0i5pMTTLHcmBIK4H7McciZIRqtAaPUMyf6M8z9KJFlYmNA+/KsXwChDI04I3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=us6aoP5+3sElOE08stNjG5X7aKxwAboV0BGfhjbiWWE=;
	b=tuvEet6KFhJfBpYuvYsvHiEVPB8833mf8jmluSnzJiQuJDZTQ0IWGenzKde+9t7/p7tg
	 GdfdxwCjzWoHmnIRgndEgA11+LpfknLqSsSDKafcdWVUh1/ZYdZazkwbk09DPIoe45ddM
	 WK2MU/m/1Y8ZkqcLWFnMqH0VpepwL2VRYBkQbW0W/uIdoOltj6i/9/FpEKexw5aFmNO8Y
	 pZEc3iiVRlYHjd4/5wiu9tLkc+mbLQy0rrJfVFZzAxg0gYvNW1vcTp0/PMrmiEnqU4xvq
	 6H7RaQCd0pHI4ezXS5RWDwd3U/WbmT0+4RDmW2ERQ5Nm0n8GkZpswoZ4zdPYRW925Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fmlgaI6B;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEDC60A262A
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDEDC60A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fmlgaI6B
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-48ed0b68895so1087337fac.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296209; x=1794901009; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=us6aoP5+3sElOE08stNjG5X7aKxwAboV0BGfhjbiWWE=;
        b=fmlgaI6BiZTvsgCMZBFIgNqERMinSh4+i9M0cv2t2zMMoX8oxK29t+N62fUYXBPPci
         yhu2Uim5WZQA2HoXbxvo4a2ll90+iMkkBGUSo8bDBTZUWyCYpoUs1XMx0o8HDGYI6mW9
         pbMap38UggvsYIFi+5hllQDONU/bitSS/Ow+sj56vXBgheBMBbJg5/lHhDvpPWOyM2BP
         h0Con3chOUjWER5u6ICzcAeSZMqR7RxEPsd3bmLcMpTbIYHLo/koeasqNZh3Dy1xH5Ac
         +3P+DFSebEDvnWtl6sU49ngNtIrEOOqZWWgEn9m6QHOkl0NxK1uHwgo8Pgw94rJp3fH+
         BQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296209; x=1794901009;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=us6aoP5+3sElOE08stNjG5X7aKxwAboV0BGfhjbiWWE=;
        b=ni7DTWSIYv0rVA071X+/fLxb54NxGtwcRjhB8HAHo/n8YiMNDfOraG0JSaI0Fs5o1q
         l+diRBirL8LwzxWc08LY01X9EF9bZa14lYK9Q3xABqShNicdzJ/HXU76tZfoT4G3gfIK
         nnzK3l6slE4d275T0uKGRuyTCt2e7o6aOmfKQ0lCXl8kNW9RxQlJ0RWeLmmeJdW09qp/
         Rz8YK+W9pMvWSxsbmWNAlSFQ72uROl1RDP4aZQlMX8DkaWhrEUgWSg8zceAWQh8HtFGe
         3acsx6fO/0btrt7O0ITWdeq66jJ+4jsv0WLTtqG+jdZA4cbb516MidNiQvlFZ3POrfNz
         +7Fg==
X-Gm-Message-State: APuU4Z9g+Zdf04PrugxXb20WLUqhV6ViqOAg9iEi+uoviRoy54Yu4RTk
	wfqS3TFj5pqLLT3faNAtAXgfx+Lj68WPx2akFdp9x57DLFUjnBy2b6/UxV2TEw==
X-Gm-Gg: AYBFou1Re3LxqMKbbvvvRsZVCRjd1eKtKOQU4llq9dY3lzel7/ayTS/k5HXwJg2VwD0
	NmsePBi9qJGIVluUiRk6KRi+Vd5pH/N/tIuQhLetIycQyw2Yr3NOBgu3W/NxiD6b4As20NCvPRD
	DgQ8ocjlVylPsMiPXIlKNq3Noo9FOJcAnfxL47Ane6sML4j48nn0s3Fd+Ul6Quck0CwvPMYNRdP
	uumH29i7Bcljzt01lBQQO2AkWk8M4FgaCVBvEZ4/tOkMNf9meE1L2oWNnEu4u8/9ImDR7NtW0Kz
	x7NIUHtX7yaQtCaoSKtlr4aWcsMiP8TWVfCVMczXUxiB5NjDaTuLwxZ0bOKfXy4LLPkP8Aj4LqX
	yO6i9P1b7JPN5joLF83uKOYJ2x49HaZeBoYW4yy8UtdLzxFjw38ZoSuzuxaG7xH/SkVf3AqegDI
	NLX/cGqpcOD5z++xmxcGTAUaQYT6z8b0i9O+89S9myZZbJ962SJ9KIZMCZx3ANNGhEOorU/8/T/
	/k7kutruTXfvRaI9qxGCNoKB2LFyZ1XLxufGD3faEjNZIzzDaORKXa6Vd9naogzApoyPCZ/V0Sl
	wTO7SLMVlu01x3/8yYBy/Cxa1EiSSoAABqw=
X-Received: by 2002:a05:6871:14f:b0:4ad:514d:b19c with SMTP id 586e51a60fabf-4ae225f84d3mr908788fac.11.1794296208701;
        Mon, 09 Nov 2026 23:36:48 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae23031a4dsm974962fac.14.2026.11.09.23.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:36:47 -0800 (PST)
Message-Id: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:30 +0000
Subject: [PATCH v2 00/15] Fix segfaults on settings given without a value
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>

A setting given without a value, as in "git -c foo.bar" or a bare "bar"
under "[foo]", is passed as NULL to the code that reads it. In these places
git does not check for that and segfaults:

 * rebase.missingCommitsCheck in "git rebase -i"
 * core.alternateRefsCommand and core.alternateRefsPrefixes in "git fetch",
   "git receive-pack" and "git rev-list --alternate-refs", in a repository
   with an alternate
 * the color slots of "git add -p", "git add -i" and the other interactive
   patch modes
 * fetch.bundleCreationToken in "git fetch" and "git clone --bundle-uri",
   with a creationToken bundle list
 * grep.patternType in "git grep", "git log" and "git show"
 * remote.*.tagOpt in "git fetch", "git remote" and "git status"
 * color.blame.repeatedLines and color.blame.highlightRecent in "git blame"
 * branch.*.mergeOptions in "git merge" on that branch
 * remotes.* in "git fetch" and "git push" of that remote group
 * safe.bareRepository in any bare repository that git discovers
 * bitmapPseudoMerge.*.pattern when writing a bitmap, as in "git repack
   -adb"
 * scalar.repo in "scalar reconfigure --all"
 * remote.*.url in nearly every command, when an includeIf
   "hasconfig:remote.*.url:..." section exists
 * mode, heuristic, uri and creationToken in a bundle list, in "git clone
   --bundle-uri" and "git fetch"
 * any key at all in "git config list --type=color" and "--type=expiry-date"

Changes since v1:

 * Patch 1 no longer rejects a rebase.missingCommitsCheck without a value.
   It warns and falls back to "ignore", as for a value that git does not
   recognize (Phillip, Junio).

 * Rebased onto master, where iw/connected-deepen-fetch-no-alternate-refs
   now adds tests at the end of t5618, as patch 2 does.

These turned up in a check of every config callback and every caller of
repo_config_get_value(), and in runs of two dozen common commands with each
key that "git help --config" lists set without a value. There may be more in
code that neither method reached.

Most patches reject the missing value with config_error_nonbool(), as
ba176db511 (config: handle NULL value when parsing non-bools, 2023-12-07)
did for other settings. Four accept it without an error: a missing
rebase.missingCommitsCheck warns and falls back to "ignore" like a value
that git does not recognize (patch 1), a missing fetch.bundleCreationToken
counts as 0 (patch 4), a remote URL without a value matches no includeIf
condition (patch 13), and "git config list" leaves the key out (patch 15).
The crash fixed in patch 14 can also come from a server, through a bundle
list it advertises to clients that use bundle URIs. It is still a plain NULL
dereference. Only patch 15 fixes a regression, which came in with 2.54.0.

remote.*.followRemoteHEAD without a value crashes the same commands. This
series leaves it alone, as ch/remote-defer-follow-remote-head-validation in
'seen' already makes it safe, checking the value only where fetch uses it.

The series is now based on 3c60ef1e38 (The 17th batch, 2026-11-08) and
merges cleanly into 'next' and 'seen' too.

Thomas Bachem (15):
  rebase -i: handle NULL value for rebase.missingCommitsCheck
  odb: handle NULL values for core.alternateRefs* config
  add-patch: handle NULL value for color slots
  bundle-uri: handle NULL value for fetch.bundleCreationToken
  grep: handle NULL value for grep.patternType
  remote: handle NULL value for remote.<name>.tagOpt
  blame: handle NULL values for color.blame.* config
  merge: handle NULL value for branch.<name>.mergeOptions
  remote: handle NULL value for remotes.<group>
  setup: handle NULL value for safe.bareRepository
  pseudo-merge: handle NULL value for bitmapPseudoMerge.<name>.pattern
  scalar: handle NULL value for scalar.repo
  config: handle NULL value for remote URLs in hasconfig includes
  bundle-uri: handle NULL values in bundle lists
  config: handle NULL values when listing colors and expiry dates

 add-patch.c                     |  2 +-
 builtin/blame.c                 |  4 ++++
 builtin/config.c                |  4 ++--
 builtin/merge.c                 |  2 ++
 bundle-uri.c                    | 12 +++++++++++-
 config.c                        |  3 ++-
 grep.c                          |  2 ++
 odb.c                           |  4 ++--
 pseudo-merge.c                  |  4 ++++
 rebase-interactive.c            | 10 ++++++++--
 remote.c                        |  7 ++++++-
 scalar.c                        |  5 ++++-
 setup.c                         |  2 ++
 t/t0035-safe-bare-repository.sh |  6 ++++++
 t/t1300-config.sh               | 32 ++++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh   | 12 ++++++++++++
 t/t3701-add-interactive.sh      | 12 ++++++++++++
 t/t5333-pseudo-merge-bitmaps.sh |  5 +++++
 t/t5505-remote.sh               |  5 +++++
 t/t5506-remote-groups.sh        |  5 +++++
 t/t5558-clone-bundle-uri.sh     | 20 ++++++++++++++++++++
 t/t5618-alternate-refs.sh       |  9 +++++++++
 t/t5750-bundle-uri-parse.sh     | 16 ++++++++++++++++
 t/t7600-merge.sh                |  6 ++++++
 t/t7810-grep.sh                 |  5 +++++
 t/t8012-blame-colors.sh         |  7 +++++++
 t/t9210-scalar.sh               |  5 +++++
 27 files changed, 195 insertions(+), 11 deletions(-)


base-commit: 3c60ef1e38ee80337025a1b908327f7879386329
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2297%2Fthomasbachem%2Fconfig-null-value-segfaults-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2297/thomasbachem/config-null-value-segfaults-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2297

Range-diff vs v1:

  1:  a9a3f4b705 !  1:  47224a9893 rebase -i: handle NULL value for rebase.missingCommitsCheck
     @@ Commit message
          segfault as it writes the todo list: get_missing_commit_check_level()
          passes the NULL value to strcasecmp().
      
     -    The setting takes "ignore", "warn" or "error", not a bool. Read it
     -    with repo_config_get_string_tmp(), which rejects a missing value with
     -    config_error_nonbool(), as ba176db511 (config: handle NULL value when
     -    parsing non-bools, 2023-12-07) did for other settings.
     +    The setting takes "ignore", "warn" or "error". An unrecognized value,
     +    perhaps one meant for a newer version of Git, gets a warning and is
     +    treated as "ignore". Treat a missing value the same way.
      
     +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Assisted-by: Claude Fable 5.1
     +    Assisted-by: Claude Opus 5.5
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
      
       ## rebase-interactive.c ##
     @@ rebase-interactive.c: static enum missing_commit_check_level get_missing_commit_
       	const char *value;
       
      -	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value) ||
     -+	if (repo_config_get_string_tmp(the_repository, "rebase.missingcommitscheck", &value) ||
     - 			!strcasecmp("ignore", value))
     +-			!strcasecmp("ignore", value))
     ++	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value))
     ++		return MISSING_COMMIT_CHECK_IGNORE;
     ++	if (!value) {
     ++		warning(_("missing value for option "
     ++			  "rebase.missingCommitsCheck. Ignoring."));
     ++		return MISSING_COMMIT_CHECK_IGNORE;
     ++	}
     ++	if (!strcasecmp("ignore", value))
       		return MISSING_COMMIT_CHECK_IGNORE;
       	if (!strcasecmp("warn", value))
     + 		return MISSING_COMMIT_CHECK_WARN;
      
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
       	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
       '
       
     -+test_expect_success 'rebase -i rejects rebase.missingCommitsCheck without a value' '
     ++test_expect_success 'rebase -i warns about and ignores rebase.missingCommitsCheck without a value' '
      +	rebase_setup_and_clean missing-commit &&
     -+	test_when_finished "test_might_fail git rebase --abort" &&
     -+	test_must_fail git -c rebase.missingCommitsCheck rebase -i --root 2>err &&
     -+	test_grep "missing value for .rebase.missingcommitscheck." err
     ++	(
     ++		set_fake_editor &&
     ++		FAKE_LINES="1 2 3 4" \
     ++			git -c rebase.missingCommitsCheck rebase -i --root 2>actual
     ++	) &&
     ++	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
     ++	test_grep "missing value for option rebase.missingCommitsCheck" actual &&
     ++	test_grep ! "commits may have been dropped" actual
      +'
      +
       test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
  2:  74ab5bfc62 !  2:  9170c4162f odb: handle NULL values for core.alternateRefs* config
     @@ odb.c: static void fill_alternate_refs_command(struct repository *repo,
       		}
      
       ## t/t5618-alternate-refs.sh ##
     -@@ t/t5618-alternate-refs.sh: test_expect_success 'log --source shows .alternate marker' '
     +@@ t/t5618-alternate-refs.sh: test_expect_success 'refs of a shallow alternate are ignored' '
       	test_cmp expect actual
       '
       
  3:  1b5f243294 =  3:  d3fd6290e0 add-patch: handle NULL value for color slots
  4:  4eb7085084 =  4:  a822cbb844 bundle-uri: handle NULL value for fetch.bundleCreationToken
  5:  88df66ab7e =  5:  6c2a671a92 grep: handle NULL value for grep.patternType
  6:  e95249fb51 =  6:  d4b49d1363 remote: handle NULL value for remote.<name>.tagOpt
  7:  260b90a4a2 =  7:  25843b43bf blame: handle NULL values for color.blame.* config
  8:  e10f1fc0ba =  8:  d8681a8560 merge: handle NULL value for branch.<name>.mergeOptions
  9:  0faf4e884f =  9:  51f8eba073 remote: handle NULL value for remotes.<group>
 10:  0991a1b80c = 10:  a5b6436943 setup: handle NULL value for safe.bareRepository
 11:  3f4cbf4494 = 11:  1533ef9cc6 pseudo-merge: handle NULL value for bitmapPseudoMerge.<name>.pattern
 12:  b4bcaf19ec = 12:  6219e9fd7f scalar: handle NULL value for scalar.repo
 13:  5c12b13d90 = 13:  080106d5ea config: handle NULL value for remote URLs in hasconfig includes
 14:  ce4c190ea2 = 14:  fb9e63541b bundle-uri: handle NULL values in bundle lists
 15:  7ac4e3a3d9 = 15:  12f841e5ff config: handle NULL values when listing colors and expiry dates

-- 
gitgitgadget
