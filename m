Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437358;
	b=NMQkAV8XcMtYfDMxIu6/NX0bOh2GWjx2SFJcaxgnngm1agFdmiUQfnJiy4fDRMhWpmoF
	 lqhKb8UYnEjnnOaMHKGR1O7k+8cWkvu/huVN0Hc2vbdn3XOPRUc2lhnM6eNi2BM/8EYmv
	 Mo9b2GhfA9MqfnmZ3NJoLiBn6AndYQO/1m4qfjHRaWLMpNrITsHue3F8i7cPqQSl4GiJj
	 +HYmwtN3k/Rg/UsguvHrmJLjXPGwDIDvVyI3+TlEX48GbwX71511iA6D6Rt1OBf/qw8tG
	 SMgmouA/JuvxVwCVO1kdF7+U8FXN3H2r/F7RXR1+RTTulGPCnhlrE+sGWaJKdl6qpbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=mte/HFyV/TaU+vnKvkA24DjTlOqDxnAMvz5Q+zpY8Zs=;
	b=Eab1bwGEE0PgTtu5XWO94eS+/j9Y2BP4iBgJ2b0AkFV9NwyRR7spIZ88pPpaT3T+AOkE
	 DKeReWW7HoudRfUT+JcglVdhtVRxV2T9z7HPnD8/D9nmkBQA1qU7xtK4v5lttL4y+HWmH
	 TJ63fWF6tvOs7mNno+mjaBWbuEdUWHexAYIeen7TXthPqJm2RsfqUxwd44g43c3+lzquI
	 BInjndY+S4rryfJ0quHMGXrTGykPyZdHs8JpkkHqyUsxhYeggUiLG3wFhv0J4Xbp1Md2Y
	 k7qR652OvD3FfuxBqy9JZ21ImcBej8LC514qM0lxt7errQZJDpI5GW/zc0XfQTdLO1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BgNjIt9Z;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32D606AEDA
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B32D606AEDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BgNjIt9Z
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6fe4372c5f3so2108554eaf.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437357; x=1795042157; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mte/HFyV/TaU+vnKvkA24DjTlOqDxnAMvz5Q+zpY8Zs=;
        b=BgNjIt9ZBdP6Zr3kXf4A+XFdEh4EIgDBwzTTf10tME8kJJEpGRXqH2w5uiUXoYMebq
         dfqoPZ5F4DN09q049kRCG8lDbDh9KwWGyBfV/i4SWPspgL9qMLpp7HecaFgyY6ffW0AC
         Odr+HS1OMxw7xDh8nHt/Hp/PsGvhjqBnn2kBzWDEpiL9tih4/UpbvL9QL5SZYiHQTtqy
         pHMYnx8FfYkdqKQXBG+BdBzzA/EPwcTTeZOvjXFFIXcEyJKiwH+YCxE5t/GFIDJLM9ea
         5hsoomObK3AscfFMrhH4m3jgFWCFs9hIpioyXbWyU7+efXj6z7ogeG5Hw0m8GC63HN27
         rBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437357; x=1795042157;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mte/HFyV/TaU+vnKvkA24DjTlOqDxnAMvz5Q+zpY8Zs=;
        b=ejjJi89Q898XKjYe8mE3ZIu4pZRvsEPkOEQ+wQIoeSlFJbl+QKRoHSXhQI/KBG8Grl
         R3HTFkIOlBzXgmFJ4WeB984jcNHKuQQcb4xWavq1KIdY03GBNNOoJm7Z+s3koBd+NVs/
         NbV/9oMcBiyxF9YaF0Qne3/077NRB5shOaiXim0ez/PdmDKRpSb91PDfyPDpkzJbzm86
         MpsL5SUTQQsBzyYUYO8cpbqYJ13j9vhNrnKJGdPraAS+khQuJpussr5hyhYn+ZbzHNUL
         e1Fd+N41zTzR4UKag5dboR/LjixD03HQ3TKQcCmDBpuvF8gGSQa36Sdw847ZEwNuIbhN
         ViSw==
X-Gm-Message-State: APuU4Z/jdb7TU/7jYel7onSbOGlyE/zXKsa3VI7IHlAY4OjmoXIEHPjE
	6lnnBMb5xpgC/79jD7iIxZPdQ1TivTjEkQsCCQxL7etdqOoWXiT2sPNbWY065Q==
X-Gm-Gg: AYBFou3LQ9jLMGjuSPuxvP4mXy8Ggmqg33LyTM9g/H54WDJhDg0QPJlgKW9fKbKOd6o
	kPEi4OIM0v0Zwp+U8gUAM65cekDdEt5lYgHvKxxAq4wAx3UVA4sO9FFHtTOHS0AAyODkMbPOacp
	LORFa544hJu6hGS42tDVh8UxJLExYgQToP6Wg7YAgObNOokoaF+CatmUCJTsseHB+lhwvZzi13/
	uKw9BG69xYcH32/g8cMEhWnR7c3xY0WOYtRfU72Q8dGISPLIhxIwOf9EaD/3ScHTzhifzZND8Wx
	XmIaL3I36ZUHhLRHbz0nLuqqYRfrW72PnITp/D4ywV7s4VUTq3DC9ianpcOjIkSVmJil4uf+56x
	HU0H/IQBdhkaWaIHjta3dIE3Mn68q0DhEgxZx5P3Jd4gEiaPl2NHvHLr0920se2xc4V35/5yRSx
	7JbGZ9eow0jGtc/DUDB/ZL5wwlapid6gwhw/qK3IRjYcDCdeuODlE0gfy4zYn6UiFgZQGvNrTqU
	lZ+/bk/G4WDsYjZ749DtdkjqAdPKetdRCQ3bBy9S6GR3oPaBUvvFlzb8hMjO5tC4TA4hx0YP+U9
	iDOBtiLsyK4HgxdednAUe1/SFaaez4excsM=
X-Received: by 2002:a05:6820:c453:10b0:716:c485:eba4 with SMTP id 006d021491bc7-719179c7cdamr1716474eaf.85.1794437356780;
        Wed, 11 Nov 2026 14:49:16 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a945ceebsm4871214eaf.8.2026.11.11.14.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:16 -0800 (PST)
Message-Id: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:00 +0000
Subject: [PATCH v3 00/15] Fix segfaults on settings given without a value
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

Changes since v2:

 * Where an invalid value is ignored, a missing one now is too, with a
   warning: remote.*.tagOpt (patch 6) and color.blame.repeatedLines (patch
   7). v2 rejected them (Phillip).

 * The test in patch 1 rebases onto HEAD~3 and checks the result with
   test_commit_message (Phillip).

These turned up in a check of every config callback and every caller of
repo_config_get_value(), and in runs of two dozen common commands with each
key that "git help --config" lists set without a value. There may be more in
code that neither method reached.

Most patches reject the missing value with config_error_nonbool(), as
ba176db511 (config: handle NULL value when parsing non-bools, 2023-12-07)
did for other settings. Where git ignores an invalid value, it now ignores a
missing one too, with a warning: rebase.missingCommitsCheck (patch 1),
remote.*.tagOpt (patch 6) and color.blame.repeatedLines (patch 7). The
exception is a bundle list, where patch 14 rejects a missing heuristic or
creationToken even though an invalid one is accepted, as Derrick would
rather make the bundle URI code stricter about malformed lists than more
lenient. A missing fetch.bundleCreationToken counts as 0 (patch 4), a remote
URL without a value matches no includeIf condition (patch 13), and "git
config list" leaves the key out (patch 15). The crash fixed in patch 14 can
also come from a server, through a bundle list it advertises to clients that
use bundle URIs. It is still a plain NULL dereference. Only patch 15 fixes a
regression, which came in with 2.54.0.

remote.*.followRemoteHEAD without a value crashes the same commands. This
series leaves it alone, as ch/remote-defer-follow-remote-head-validation in
'seen' already makes it safe, checking the value only where fetch uses it.

The series is still based on 3c60ef1e38 (The 17th batch, 2026-11-08) and
merges cleanly into 'master', 'next' and 'seen'.

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
 builtin/blame.c                 |  7 +++++++
 builtin/config.c                |  4 ++--
 builtin/merge.c                 |  2 ++
 bundle-uri.c                    | 12 +++++++++++-
 config.c                        |  3 ++-
 grep.c                          |  2 ++
 odb.c                           |  4 ++--
 pseudo-merge.c                  |  4 ++++
 rebase-interactive.c            | 10 ++++++++--
 remote.c                        |  9 ++++++++-
 scalar.c                        |  5 ++++-
 setup.c                         |  2 ++
 t/t0035-safe-bare-repository.sh |  6 ++++++
 t/t1300-config.sh               | 32 ++++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh   | 12 ++++++++++++
 t/t3701-add-interactive.sh      | 12 ++++++++++++
 t/t5333-pseudo-merge-bitmaps.sh |  5 +++++
 t/t5505-remote.sh               |  7 +++++++
 t/t5506-remote-groups.sh        |  5 +++++
 t/t5558-clone-bundle-uri.sh     | 20 ++++++++++++++++++++
 t/t5618-alternate-refs.sh       |  9 +++++++++
 t/t5750-bundle-uri-parse.sh     | 16 ++++++++++++++++
 t/t7600-merge.sh                |  6 ++++++
 t/t7810-grep.sh                 |  5 +++++
 t/t8012-blame-colors.sh         | 12 ++++++++++++
 t/t9210-scalar.sh               |  5 +++++
 27 files changed, 207 insertions(+), 11 deletions(-)


base-commit: 3c60ef1e38ee80337025a1b908327f7879386329
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2297%2Fthomasbachem%2Fconfig-null-value-segfaults-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2297/thomasbachem/config-null-value-segfaults-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2297

Range-diff vs v2:

  1:  47224a9893 !  1:  1262222ccd rebase -i: handle NULL value for rebase.missingCommitsCheck
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i respects rebase.mi
      +	rebase_setup_and_clean missing-commit &&
      +	(
      +		set_fake_editor &&
     -+		FAKE_LINES="1 2 3 4" \
     -+			git -c rebase.missingCommitsCheck rebase -i --root 2>actual
     ++		FAKE_LINES=1 \
     ++			git -c rebase.missingCommitsCheck rebase -i HEAD~3 2>actual
      +	) &&
     -+	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
     ++	test_commit_message HEAD -m C &&
      +	test_grep "missing value for option rebase.missingCommitsCheck" actual &&
      +	test_grep ! "commits may have been dropped" actual
      +'
  2:  9170c4162f =  2:  ec9d7fd183 odb: handle NULL values for core.alternateRefs* config
  3:  d3fd6290e0 =  3:  c071e79d11 add-patch: handle NULL value for color slots
  4:  a822cbb844 =  4:  8773aaef0b bundle-uri: handle NULL value for fetch.bundleCreationToken
  5:  6c2a671a92 =  5:  123f03f024 grep: handle NULL value for grep.patternType
  6:  d4b49d1363 !  6:  339590cd4b remote: handle NULL value for remote.<name>.tagOpt
     @@ Commit message
          "git remote" and "git status" segfault: handle_config() passes the
          NULL value to strcmp().
      
     -    Reject a missing value with config_error_nonbool(), as handle_config()
     -    already does for remote.<name>.url and remote.<name>.pushurl.
     +    The setting takes "--no-tags" or "--tags", and any other value is
     +    ignored. Ignore a missing value too, but warn about it.
      
     +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Assisted-by: Claude Fable 5.1
     +    Assisted-by: Claude Opus 5.5
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
      
       ## remote.c ##
     @@ remote.c: static int handle_config(const char *key, const char *value,
       		else
       			error(_("more than one uploadpack given, using the first"));
       	} else if (!strcmp(subkey, "tagopt")) {
     -+		if (!value)
     -+			return config_error_nonbool(key);
     ++		if (!value) {
     ++			warning(_("missing value for '%s'"), key);
     ++			return 0;
     ++		}
       		if (!strcmp(value, "--no-tags"))
       			remote->fetch_tags = -1;
       		else if (!strcmp(value, "--tags"))
     @@ t/t5505-remote.sh: test_expect_success 'remote information for the origin' '
       	)
       '
       
     -+test_expect_success 'tagOpt needs a value' '
     -+	test_must_fail git -C test -c remote.origin.tagOpt remote 2>err &&
     ++test_expect_success 'tagOpt without a value only warns' '
     ++	git -C test -c remote.origin.tagOpt remote >actual 2>err &&
     ++	echo origin >expect &&
     ++	test_cmp expect actual &&
      +	test_grep "missing value for .remote.origin.tagopt." err
      +'
      +
  7:  25843b43bf !  7:  ad50c4b35b blame: handle NULL values for color.blame.* config
     @@ Commit message
          value makes "git blame" segfault: git_blame_config() passes the NULL
          value to strlen() or to parse_color_fields().
      
     -    Reject a missing value with config_error_nonbool(), as
     +    An invalid color.blame.repeatedLines gets a warning and is ignored.
     +    Treat a missing value the same way.
     +
     +    An invalid color.blame.highlightRecent makes "git blame" die, so
     +    reject a missing value there with config_error_nonbool(), as
          git_blame_config() already does for blame.date and blame.coloring.
      
     +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Assisted-by: Claude Fable 5.1
     +    Assisted-by: Claude Opus 5.5
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
      
       ## builtin/blame.c ##
     @@ builtin/blame.c: static int git_blame_config(const char *var, const char *value,
       		return 0;
       	}
       	if (!strcmp(var, "color.blame.repeatedlines")) {
     -+		if (!value)
     -+			return config_error_nonbool(var);
     ++		if (!value) {
     ++			warning(_("missing value for '%s'"),
     ++				"color.blame.repeatedLines");
     ++			return 0;
     ++		}
       		if (color_parse_mem(value, strlen(value), repeated_meta_color))
       			warning(_("invalid value for '%s': '%s'"),
       				"color.blame.repeatedLines", value);
     @@ t/t8012-blame-colors.sh: test_expect_success 'blame color by age: new code is di
       	test_grep qfunc colored
       '
       
     -+test_expect_success 'color.blame.repeatedLines and highlightRecent need a value' '
     -+	test_must_fail git -c color.blame.repeatedLines blame hello.c 2>err &&
     -+	test_grep "missing value for .color.blame.repeatedlines." err &&
     ++test_expect_success 'color.blame.repeatedLines without a value only warns' '
     ++	git blame --color-lines hello.c >expect &&
     ++	git -c color.blame.repeatedLines blame --color-lines hello.c >actual 2>err &&
     ++	test_cmp expect actual &&
     ++	test_grep "missing value for .color.blame.repeatedLines." err
     ++'
     ++
     ++test_expect_success 'color.blame.highlightRecent needs a value' '
      +	test_must_fail git -c color.blame.highlightRecent blame hello.c 2>err &&
      +	test_grep "missing value for .color.blame.highlightrecent." err
      +'
  8:  d8681a8560 =  8:  90209dc754 merge: handle NULL value for branch.<name>.mergeOptions
  9:  51f8eba073 =  9:  f30ecf07b4 remote: handle NULL value for remotes.<group>
 10:  a5b6436943 = 10:  bb6eecd20c setup: handle NULL value for safe.bareRepository
 11:  1533ef9cc6 = 11:  510dc56c9b pseudo-merge: handle NULL value for bitmapPseudoMerge.<name>.pattern
 12:  6219e9fd7f = 12:  751fae34b2 scalar: handle NULL value for scalar.repo
 13:  080106d5ea = 13:  4d5d2ce04e config: handle NULL value for remote URLs in hasconfig includes
 14:  fb9e63541b = 14:  474aebd572 bundle-uri: handle NULL values in bundle lists
 15:  12f841e5ff = 15:  f6f3295ff5 config: handle NULL values when listing colors and expiry dates

-- 
gitgitgadget
