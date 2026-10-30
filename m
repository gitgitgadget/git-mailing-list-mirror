Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357558;
	b=2w/7yqtl8ZggYr5D+v2b9eVoT6P18CzsqqwLsr2bQ1tmcLaPpAWJfXUF3/4L/cy0a9FN
	 iCCxsScmcBGctVSExY/KOdhOdpLzJJBplbMYwXLdC8AJxqeaPSOWAZt3QI06fFnJbUoNs
	 fiSfSIIcfSbWN6q996C6N9IZMLYE+NXrspe5CY4GALP/24ZX6QwKW26UHS3zFz/AwPqNT
	 ALlt8dZhnYTS6+wXr2kUqxJnjuocED1LWDeIxfGnrVtxtZprR3TFNH7fHcZ7pZcZKucl+
	 ZPMzIuEJIvFT/EKP0lp8+m41E/JmSiRgvc67NhWPm5cv2M0pv1RJskNin+LeTvU8xTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Xt6cCOC3rO3gnR7L9SZG+h5cZV64AcHWsFDUt/UQVdo=;
	b=ptSilGydxxkhMx1IxGxOKKsSVRmrUt1j9eTs0o3T4WhXN8kYDnwUUjaOvN8Vzd3cWw1f
	 /BfdsBt9Y9x7H4C0YTmDYDcdsc8hDwDx22FPB880SRf5ck1WHuX9Zkm26WrFIaKZmrss4
	 3ToEpIfPJXAmJuf3A579y+oFL+WUJym6KeTdQnrZqLqICEBsQSwjipEvvxQI13by5Dg8l
	 DGdsJA/ABJqPYqaWylM6NGenKWge/aTTbL2f6NraAv2Sw45d6q8HxtPoXa9IrsAcZDg4H
	 MdM/vNsOAG0eltlCYlT3hATZDbmCK6mP+yu24Nso5yQSDllUBuyVmbzsF7EUZ5cTAoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GwgSfWEf;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299A60A2634
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8299A60A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GwgSfWEf
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-85ac281604dso349513a34.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357557; x=1793962357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xt6cCOC3rO3gnR7L9SZG+h5cZV64AcHWsFDUt/UQVdo=;
        b=GwgSfWEfko5oabq5vpBSTDCVYnTmIBLlOuS0VECOTvXmo8o2Ee4obafsHU5WtQm9Lz
         8/PXoSzAL1qZZ0GadJd5lVJWavomEfFr0LTaLbE+I7ivBw7DMODIeACm0uqynRWvLUnf
         +svGWL3aWx21Bd94obyHM9klldZOb/1Zw9SuO3k0/6gqATztXDb05gMPnSL3v2XG0NLw
         Ie0G8zb0RXS2aNRBb2Xfa75WlbiYZpjHG40RfKWIuGFZ4Om+L7xFA4ZrHRS17d2dRUcn
         PgiHVj2LHO2ud+FKraPSlKfdJfKUYdJVNpMJXs1QvKq26cRdeWQSsUfHkpqUX10yJtFV
         ji2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357557; x=1793962357;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xt6cCOC3rO3gnR7L9SZG+h5cZV64AcHWsFDUt/UQVdo=;
        b=neD4p6XPr/FQBKYpDE/7aY5DV4WLcVig2vMRRheulX7S/BrZzf4yajOjvKleGwKZe1
         /Em7FWKDs8XfcIujbcyIqxzmlog61knuKm9dv2rTlbOdWofafslTuCIRqUr2vJgJxtAB
         L3Qr3L/Z0356BIylPqfCaraXSgKhI5hhevDX4wXUjoeogCaPYjj19OfLTSmKNZfVgrKL
         ww55zRjGjzYBBBYjxkofg7gC5xgETiCpPVKvIH0WvqyG21ntYfmyFvSUbs9+Dg6aNs1g
         TG58BsZYb10nlmiH3nJRwsdH7BrLpHcQp9h0wyQMiM7my0vMl6w2xaqcG+DxJbMQrTD6
         nEvw==
X-Gm-Message-State: AFq9FYKjkv/fOPmIGVHOIL1VXTcH8q7rkjVOwzgZpIK5+tnTCS1BzYDp
	wHsmwidwV3xQqnmqLcyCeujSH85KcDmDwUqvgW71H4OYR5K9P/wOmbVX1i04VEkZ3ZE=
X-Gm-Gg: AYBFou0g0uRE1hGJvlbZO1rufYFwOoGL9paiXsV1K0ta2JuhlWjgjQyk2af5gq1bKlN
	QnTjHWjMYM57OS5MG8HwbAYEasIOx9Hmc/9LhyOgmMwvq+qSWT3F1p9Vumxh97TH3uBcg2pRbhV
	YDcmHuvcJPOE8byKE1jrffJaqHndA0EgBpncpS4tH55rExDwBqD74x++7fgYKFNKJQTCEfwWGjs
	5BkMOhh39XeJNe4hZpVKFN0f5ywS81gsHbjgsSUrC9XlGo0YB1frmzVb/wTTichpq8HXY8ckDD5
	DBFyTU/Ne9m7dXazD6ZSHPlL3zsAZ9QW0A4qpjfHwosL+Nc0zMVPAumq49t0B7jTdZORinQhh7S
	ED9wKuBoaXvi/FteHlJlegKsgYDr+WW9vB/wyfa/VRkUnIfIZ+jQ4Ha65sVdeXTX7CKFtKGWlfj
	2ygpsiiWgBUbpovwuh1PJcdAcZCSX3X85A9jP1QuerRtpW2jpHL15U9d/eGAfqfVztN220OmHwO
	U8Mi245thksIMw/rGLoVejyNwPVnqnuPHvMp2+IUcjc6EX0RtWOKIAuN0K5gdL5wSk+wIidtQgR
	YeZqy2CNnQfHLI6vNQH5Q/ZotOXiaw==
X-Received: by 2002:a05:6830:2695:b0:805:2785:fad5 with SMTP id 46e09a7af769-85d36536870mr1146186a34.27.1793357557360;
        Fri, 30 Oct 2026 03:52:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.38.98])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d351e77c8sm1702784a34.2.2026.10.30.03.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:52:31 -0700 (PDT)
Message-Id: <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 10:52:24 +0000
Subject: [PATCH v13 0/6] fetch: avoid fetching every branch of a new remote in a shallow repo
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Avoid fetching every branch of a new remote in a shallow repo.

Changes in v13:

 * Added a new commit so @{push} resolves correctly for a --limited-fetch
   remote, falling back to remote.<name>.fetchRefmap the same way fetch
   already does when remote.<name>.fetch doesn't cover the branch being
   pushed.
 * Added a regression test to fetch: add remote.<name>.fetchRefmap covering
   a remote.<name>.fetch entry with an explicit destination, confirming it's
   stored in both that destination and the refmap's.

Changes in v12:

 * Renamed remote.<name>.refmap to remote.<name>.fetchRefmap throughout
   code, docs, and tests, so it reads unambiguously as fetch-only.
 * Added the missing code path in get_ref_map() so a branch fetched by name
   via remote.<name>.fetch is also stored through remote.<name>.fetchRefmap,
   with a new test (the "cabal" example: fetch = master/next/seen plus a
   refmap storing them all under one namespace).
 * Reworded the fetchRefmap commit message and doc entry to drop a redundant
   sentence, fix a confusing paragraph, and spell out that
   remote.<name>.fetch, when configured, still decides what's fetched while
   the refmap only remaps it.
 * Added a prefetch coverage test to t5586-fetch-refmap.sh.

Changes in v11:

 * remote_find_tracking() now falls back to remote.<name>.refmap when
   remote.<name>.fetch doesn't match. Negative refspecs in fetch still
   exclude refs, and both cases have tests
 * The helpers write straight into a strvec, take the output parameter last
   and the remote as const
 * The followRemoteHEAD lookup is done once, not duplicated in two branches
 * Clearer commit messages and docs: a working example plus a reference to
   49ca2fba39, the goal stated first, an incorrect "used to die" claim
   dropped, and an explanation of why a refmap turns on the inference
 * use_limited_fetch is a bool

Changes in v10:

 * Resolve merge conflict after master integrated
   ch/fetch-followremotehead-lazy-validation.

Changes in v9:

 * Moved the do_fetch() if/else-if/else split out of the preliminary
   helper-extraction commit and into the refmap-inference commit that needs
   it. Preliminary commit is now a simpler refactor.

Changes in v8:

 * Split into a preliminary collect_upstream_from_remote() helper commit
   plus a simplified refmap-inference commit.
 * Fixed a regression that could drop the current branch's @{upstream} when
   remote.<name>.fetch was narrowed.
 * Threaded struct repository * through instead of hardcoding
   the_repository.
 * Minor naming and comment cleanups.

Changes in v7:

 * Fixed fatal: --refmap option is only meaningful with command-line
   refspec(s) firing just from configuring remote.<name>.refmap alone, with
   nothing else to fetch.
 * When both remote.<name>.fetch and remote.<name>.refmap are configured, a
   refspec-less fetch follows .fetch as usual, .refmap only remaps something
   already being fetched by name. Added tests.

Changes in v6:

 * Remove leftover reference to deleted default-branch logic in commit
   message.

Changes in v5:

 * Renumber test file from t5585 to t5586.

Changes in v4:

 * Removed the automatic default-branch fetch. A fresh remote fetches
   nothing until you track a branch explicitly.
 * Fixed fetch report showing "new ref HEAD" instead of "new branch "
 * Reworded remote..refmap docs and commit message.

Changes in v3:

 * Replace the special ":"/"+:" fetch refspec with remote.<name>.refmap,
   reusing git's existing --refmap mechanism instead of inventing new
   refspec syntax.
 * Split the change into 4 commits.

Changes in v2:

 * Replaced the opt-in fetch.shallow config entirely with a new special
   fetch refspec (+:) that git remote add now defaults new remotes to in a
   shallow repository. The new refspec fetches whichever branches any local
   branch tracks at that remote, plus the remote's default branch.

Harald Nordgren (6):
  fetch: add remote.<name>.fetchRefmap
  fetch: extract collect_upstream_from_remote() helper
  fetch: infer branches to fetch from a refmap-only remote
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository
  remote: resolve @{push} through remote.<name>.fetchRefmap

 Documentation/config/remote.adoc |   9 ++
 Documentation/fetch-options.adoc |  10 ++
 Documentation/git-remote.adoc    |  14 ++-
 builtin/fetch.c                  | 100 +++++++++++++++-----
 builtin/remote.c                 |  31 +++++--
 remote.c                         |  62 ++++++++++++-
 remote.h                         |  20 ++++
 t/meson.build                    |   1 +
 t/t1514-rev-parse-push.sh        |  19 ++++
 t/t5505-remote.sh                |  76 ++++++++++++++++
 t/t5510-fetch.sh                 | 151 +++++++++++++++++++++++++++++++
 t/t5586-fetch-refmap.sh          | 133 +++++++++++++++++++++++++++
 12 files changed, 593 insertions(+), 33 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh


base-commit: b9e5cff1803ab24582201ef059516eb16014b9d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v13
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v12:

 1:  a1f5e81fdc ! 1:  07081828d1 fetch: add remote.<name>.fetchRefmap
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +	)
      +'
      +
     ++test_expect_success 'remote.<name>.fetchRefmap stores an explicit-dst remote.<name>.fetch entry in both places' '
     ++	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
     ++	git init -b master fetch-refmap-upstream &&
     ++	test_commit -C fetch-refmap-upstream base &&
     ++	git init downstream &&
     ++	(
     ++		cd downstream &&
     ++		git remote add cabal ../fetch-refmap-upstream &&
     ++		git config --unset-all remote.cabal.fetch &&
     ++		git config --add remote.cabal.fetch \
     ++			"+refs/heads/master:refs/remotes/custom/master" &&
     ++		git config remote.cabal.fetchRefmap "+refs/heads/*:refs/remotes/cabal/*" &&
     ++		git fetch cabal &&
     ++		check_fetched_refs <<-\EOF
     ++		refs/remotes/cabal/HEAD
     ++		refs/remotes/cabal/master
     ++		refs/remotes/custom/master
     ++		EOF
     ++	)
     ++'
     ++
      +test_expect_success 'remote.<name>.fetchRefmap tracks a branch outside remote.<name>.fetch' '
      +	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
      +	git init -b main fetch-refmap-upstream &&
 2:  e8af5bc76b = 2:  3f5808cbf3 fetch: extract collect_upstream_from_remote() helper
 3:  aad6e5f66f = 3:  b02e0a5397 fetch: infer branches to fetch from a refmap-only remote
 4:  97650da870 = 4:  3ee427de87 remote: add "git remote add --limited-fetch"
 5:  a802c9f82f = 5:  2cba4623ee remote: default to --limited-fetch in a shallow repository
 -:  ---------- > 6:  25eec8d967 remote: resolve @{push} through remote.<name>.fetchRefmap

-- 
gitgitgadget
