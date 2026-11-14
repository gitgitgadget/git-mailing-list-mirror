Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681501;
	b=zPanBp06+bQITkKahdE0/WixYOt475SuoYdSFNKhPEyA/REKs9xdf+JtZJr4kWwMejmG
	 ebpq1jz/4Bu1RDmHzU2dpQUscg3fu1u2xIYxmd4aABSxv8dZixSX0q4mwT+lzvILkUB7V
	 JHl5CfElQrBmkUWvUUd+6+UYDI75Y/SqMuNjot6BG9seyJWA7h7LRIrtnZJwWHn6zVoRj
	 1NZr4ok2ZGfiywYHSrqJqCbqhb2LbvajPjpOWv7YwbOAOUpE/Tcyp7fAkwt/Rm6eCikFh
	 Cbh6UBTWWl3oUczkiIk6YM7LJa1XjmRbxWbzllRKa/DreDd4m13zPk44cABS/sazuKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=/rFO966gQD1JaAJ3Xubmn78GQGOGxVvJUl5n7dmUbFA=;
	b=K95jwDqg7jSb9g6cTYcYuqQcC0h89bILoPYya2wqEk/JOIJN3VtwtbzkpgDij0Kqvpxs
	 q9k9CZVcVwPg2bNLoASS/Zrx1aquVqby/PIVmb+Y9pGtwIMBvPicN11c7OTWClSCRNDsC
	 rakDJcU16wCqSRAWB6ss6FBt2PVA6KQOG61LCxZqt5siJVRyPnusjQLc73LkivkvqUfFS
	 qsqNqwfml076W9iYLFfNL8U3o18tpB9c/kjv6EgDJyfnwhe7chAVWKkNeW1v9B+sk+0ZI
	 nwfZhCj/hKoPCjKlgVDWrRXWQULE0aT/QLN5CW2rNqzG7+HeKXXuiOwuqZ9YPa3Le7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zlMkD4ol;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8560606A330
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 18:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8560606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zlMkD4ol
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so830792a12.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 10:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794681500; x=1795286300; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/rFO966gQD1JaAJ3Xubmn78GQGOGxVvJUl5n7dmUbFA=;
        b=zlMkD4olqiYO/vKAXutWc/VjBvFnDbRrqXiJmXsQmrQgz2BHtAvGW6KhGoM86cpeJc
         kb62zbREObzxLgbD2bcoAaeBPEduecTa96SmA6v/W2DVIqnsX/3X+XOqsW5BUpSrBhzp
         UQstTX8KTwEiNgQYAXFpRLY0q3RNm98+LTMiCb/8FJBa4CM5XohM8ehlrfUvHHl9p0pq
         XQPi8rZsMb3t97xTk+ynQGOWSq8ZbMjq9lfhYJAKpE4uXkkuyha4phRpYO3/6RjNrLv2
         64SFBMyvfYv8+vyB73yC0lrPPiLdPHfOKHN2Q2bPxo8/d2ly20/m8WK3POTY32XQkBh4
         7dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794681500; x=1795286300;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rFO966gQD1JaAJ3Xubmn78GQGOGxVvJUl5n7dmUbFA=;
        b=xoYR7ZxD5VWzA7iT2JpdQW8IdmOMW1BKEVti3xB4X7b4PEj++3cGomT5f7eYqPar3e
         aZPTUJ5qd66Q6RLIrPT6SxdrwJisLGgz+SxiuFv/LVCTTMYziPLq78uPnpgfHra6uq5j
         vAscRQRawT0OXHKnxnhjrwjPL9WEKRGRvEhxadBTH27eMT0/P9UXoGwIX8pjXmE0ZM0W
         EwwESUyqQev12qPfFTmxi8yTASmMckImCOd1ubNbuB08raS7DwM39pQ4bh9Yunw9gsi5
         EL9RtVd9pN3X6ckVtCK+lrBouAlh5g9DgZnfot6f3X1PFrVMHx8TRZoJ6wtRgNU9DUOi
         6VUQ==
X-Gm-Message-State: APuU4Z8krSFfEfTpBg8YVRi4+m2O5kpUpBPGfWfTStqT43u+Dqb7Pwh7
	HZQzHkL1x7opD3digkLBWcUdlLP8jBWYkZYe/PNfK5NS2x44VcK1mU7SodVOyXXG
X-Gm-Gg: AYBFou0LJHHPK1LYLQ5D35ZTDwCEVmtAVGU51/E0tAP3gKfHArYn+l3x0RcV16yKtCB
	OB/LoxRmzv9cZNcI6zlKx66yxlSiKUmCLRO4Qn0N4cUCWnl/I3cte1WgvYDUZRuw6BpkCwmiBRz
	uIN9uPnw4f6JsqP0L26gIPAcGWa4mc49r0LHrMRu1RVlTMPRr1wBw6JNT6iLiBL6yx8GIbhw/lN
	3aBdgzK3hlpOI4aikMX2I5q1xFszse7deRZEcRY9ZaePUuZjQcWKUJy2qbYj4TaZ/+VIzSq4PEh
	UV1IM81fxSYW7mfZqE3NZCstDWe5rPvKNZIzgbG220Ix2axQZ3K1/NOaTRhLfZaYhbvY5f+m4Yy
	/E2qyj2icz0yhffifQY9wXO/v4N2FElA68FEWzvoFCGSOhzErOqWW6VVaNDb/hyfWdcWJL8bMjM
	xI2PqQol5xnpr2XAnl66Tsd2JBkKyQRplVz05bh1LwpoarGXSlw4anoNytuOEZ0aapQNUavJyZb
	IFTyXitILw1ZVFag6MAxo0qe6qW4z908ZxOgw5BZm+HkIAQT9oF7BoPukrmc9o2yOcqzVe7w473
	aBIhhkt3gtzYRhKXGNXERfscB8ZB2BdKhaOPdMbxkwm13n/97VrYELMjpZ/HhvAT70/zETWlePR
	VF12v7441RZo9SauJ/MbBt7IdHJnn5g==
X-Received: by 2002:a17:90b:4c0e:b0:3ac:8741:e2e8 with SMTP id 98e67ed59e1d1-3b1b07ef0bemr6804257a91.8.1794681499865;
        Sat, 14 Nov 2026 10:38:19 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-139.us-west-2.compute.amazonaws.com. [3.42.157.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce556dsm14850474a91.6.2026.11.14.10.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:38:18 -0800 (PST)
Message-Id: <pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 14 Nov 2026 18:38:11 +0000
Subject: [PATCH v14 0/5] fetch: avoid fetching every branch of a new remote in a shallow repo
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
    Matt Hunter <m@lfurio.us>,
    Harald Nordgren <haraldnordgren@gmail.com>

In a shallow single-branch clone of a large repository, git remote add
upstream <url> sets up the default +refs/heads/*:refs/remotes/upstream/*
refspec. The next git fetch upstream then downloads every branch of that
remote, which defeats the point of a shallow clone.

This series lets a remote fetch only the branches that local branches track:

git remote add --limited-fetch upstream <url>
git fetch upstream main
git branch --set-upstream-to=upstream/main
git fetch upstream    # fetches only main from now on


 * Patches 1 and 2 add remote.<name>.fetchRefmap, a configured default for
   --refmap, and a small helper refactor.
 * Patch 3 makes a remote with a fetchRefmap and no fetch refspec work on
   its own. A plain git fetch fetches the branches whose @{upstream} is on
   that remote, and @{push} resolves through the refmap.
 * Patch 4 adds git remote add --limited-fetch to set up such a remote.
 * Patch 5 makes --limited-fetch the default for git remote add in a shallow
   repository.

Changes in v14:

 * Squashed the @{push} fix into "fetch: infer branches to fetch from a
   refmap-only remote", so the series no longer adds the bug in one patch
   and fixes it in a later one
 * Moved its test to t5586 using the refmap-only remote, so it no longer
   depends on --limited-fetch
 * Dropped the separate "remote: resolve @{push} through
   remote..fetchRefmap" commit

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

Harald Nordgren (5):
  fetch: add remote.<name>.fetchRefmap
  fetch: extract collect_upstream_from_remote() helper
  fetch: infer branches to fetch from a refmap-only remote
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository

 Documentation/config/remote.adoc |   9 ++
 Documentation/fetch-options.adoc |  10 ++
 Documentation/git-remote.adoc    |  14 ++-
 builtin/fetch.c                  | 100 +++++++++++++++-----
 builtin/remote.c                 |  31 +++++--
 remote.c                         |  62 ++++++++++++-
 remote.h                         |  20 ++++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  76 ++++++++++++++++
 t/t5510-fetch.sh                 | 151 +++++++++++++++++++++++++++++++
 t/t5586-fetch-refmap.sh          | 147 ++++++++++++++++++++++++++++++
 11 files changed, 588 insertions(+), 33 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh


base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v14
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v14
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v13:

 1:  07081828d1 = 1:  c63699b402 fetch: add remote.<name>.fetchRefmap
 2:  3f5808cbf3 = 2:  4ad94eefe9 fetch: extract collect_upstream_from_remote() helper
 3:  b02e0a5397 ! 3:  6724152e69 fetch: infer branches to fetch from a refmap-only remote
     @@ Commit message
          already on that remote. The refmap itself still only controls where
          those fetched refs land, not which branches are selected.
      
     +    Let @{push} use the refmap too, so a branch pushed to such a remote
     +    resolves to the remote-tracking branch the push updated, instead of
     +    failing with "has no local tracking branch".
     +
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/config/remote.adoc ##
     @@ remote.c: void collect_upstream_from_remote(struct repository *repo,
       __attribute__((format (printf,2,3)))
       static char *error_buf(struct strbuf *err, const char *fmt, ...)
       {
     +@@ remote.c: static char *tracking_for_push_dest(struct repository *repo,
     + 
     + 	remote = repo_remote_for_push_tracking(repo, remote);
     + 	ret = apply_refspecs(&remote->fetch, refname);
     ++	if (!ret)
     ++		ret = apply_refspecs(&remote->refmap, refname);
     + 	if (!ret)
     + 		return error_buf(err,
     + 				 _("push destination '%s' on remote '%s' has no local tracking branch"),
      
       ## remote.h ##
      @@ remote.h: void collect_upstream_from_remote(struct repository *repo,
     @@ t/t5586-fetch-refmap.sh (new)
      +	)
      +'
      +
     ++test_expect_success '@{push} resolves for a branch pushed to a refmap-only remote' '
     ++	(
     ++		cd client &&
     ++		git config push.default current &&
     ++		git checkout -b topic upstream/main &&
     ++		test_commit topic-1 &&
     ++		git push &&
     ++		echo refs/remotes/upstream/topic >expect &&
     ++		git rev-parse --symbolic-full-name topic@{push} >actual &&
     ++		test_cmp expect actual &&
     ++		test_cmp_rev topic topic@{push}
     ++	)
     ++'
     ++
      +test_done
 4:  3ee427de87 = 4:  6cff6786ba remote: add "git remote add --limited-fetch"
 5:  2cba4623ee = 5:  00f9d44a88 remote: default to --limited-fetch in a shallow repository
 6:  25eec8d967 < -:  ---------- remote: resolve @{push} through remote.<name>.fetchRefmap

-- 
gitgitgadget
