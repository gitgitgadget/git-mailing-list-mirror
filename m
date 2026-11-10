Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309476;
	b=dNSohfq4aPmkWYMKkFXH2u+UVOpJQn/8ad2uhhwW+pVpfncJn9fCCusA++I5r9Wg9BCA
	 /jUg+bhrPm/T39PAtDOHhr4p5PXJarMe4piF6wm0WWT2Gqpce2O3UivRimbMrRNWE82RO
	 GPj/pKTJMvo8hU7tGsSpeBB1YctXuzR9gyeCbWUiX6TRs57QiYbBHaKf0rS9l9RNOWVSD
	 UAS9VYS16zRE5A4dP6P6EAEfG8Lq13znnU3tRbmCPiwT2zOcrdiCTNUr5jzv7NvraJ6MP
	 SqJ5lUVvfVb2IEZ/5r/0waGZgXTcs2PBxluVMF0O48zV/R1+LRs0eeCS2YZqNt9CG2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XkaU4fzrqPSDFurJIb7MYVOi5U9w0joZe5754qvPESw=;
	b=yNzhaM80WBLFKL3mOyrhCjGF5+DPVnDqmohutmH1Z/qCQWVM5Ht+IB4SSf2Wtm8ouyW2
	 hGvaTQY7dZ8MBObZ83Zi/vtaFbtZNIxJoXE9v3L7C8u+ZxaQZDHQSmm8xnMPhQs5KzP5R
	 16YFlMbOqbRlLs4BobswnzytxwIetg7GDfpbr5ujkmeu+9h6Ocf8C/Ms/t5LAJpwCHeUY
	 BER1Lv2JKWAY3sqpNUNVclTp9oWdm1WOwjcMtMio0SN/rTb5ZT3rzG+LmUb5xl1LaEPvq
	 A+h0EYYS1JVG+ZHQXEfgQexGUUYDdB6rm/uo7JyXb0JhxLdIN72dHUHNd4RK9n06M3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6jgBixM;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31DC606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A31DC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6jgBixM
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so2480320a12.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309474; x=1794914274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XkaU4fzrqPSDFurJIb7MYVOi5U9w0joZe5754qvPESw=;
        b=F6jgBixMAH2lRsVdG8qqqDKdcFHkvBPa9N7nff7WrtDTUnQ5WYElPTAtF92oJCqGa6
         3+cGLL8xX7Y6asddjos/SXEmDD/4h9fCtg3rDALsLqJwloF+ooFPwnmhLX2yrIWdIECc
         dl2ptHjMXa5jAyHMYMWHl5tTkfZDMwJaEzNOo2p4GJvjCWI3TtsNEr+6lsDXeY9I+tlR
         zgrc7+sCd7V9ZOjLCHrMv7OkoQ/PghaI28BBMo3WymMN+zkjXw+kp8CfKWsgTiZj97Ln
         bXuLA4w+LaiKr05nqI32XBBGs8MToHQjA8xUJFvtDFsNKBCNJbPYerw6qOD4TMhDFIyH
         GbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309474; x=1794914274;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XkaU4fzrqPSDFurJIb7MYVOi5U9w0joZe5754qvPESw=;
        b=P2D35ivYygqsLI451rau8tDJKBJi5IDWpH4vpf9r8gUly4HAgu7mAOX3Stnn7n6VDr
         eMKumsoE6ksjBwh0m0akM+6Vth5961X1szXgGHs1Lq2BcYM2bV86AgTLHNSU36FYS4mi
         jXBtfAds1cFwZirdZtJlwL9obUYAMYZBSYf8WtRW8vPSPfPUMK8XVH6js+ZqwpP7Zoz5
         8QnIopToweMuqjJma9TNcWuK+HzhoZKiYXfBwZAf844GZZeJ2yO7RJxjDBEXC+1khf8y
         kFxMT5Ou/NzD2sgoelxpbK4WHkCOBC3PHuAnOrzTJkXdejTb8euaqmWJ8971gTWitsyb
         ix3Q==
X-Forwarded-Encrypted: i=1; AL+hErH0rXWCO/x4YuclaaAXlRIYDOVNKoq6kQsXgC9EVI05JIbZc1CPf95b3b/vxy21HfNQep4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dghbYOfkVfy089jqjZ3GksJGFuXkUFqmBoSZ+z+Vout1JGUs1
	MC9jerIilBlsL/6w4WDgTDxDYzJnotdzBv6rQxda6T4C3+4pWAwG28U5
X-Gm-Gg: AYBFou3PeANTHwWc2VlNJjtq3YkY6v6O+7JYuzJHQ6ZwgztN1hH5Tevyf5FlwJBBhOR
	onj3rK1PieveRxaiqBB/AADRlZUtpSn0B8M0UXRRag3pZM08LUkePe7cqmPkQCGCch2/iSHqhB0
	FUdADUgaIW6eyAjxzGBvlJCQzKZiZ8z+6NLAChSYlqGAaaORJGNWFzDo9yzyiwv/GqcbBbVb9UM
	+eJRU14lndDiF2/LMgVmnGPRSXAwYvtCxJLRmquo9w9ysJeEuL3GlDxyAK22xdmvJ3GN5tbKYYV
	skPm2p6oWWUOJ9+FdZrPtgX7oCDLmORe9TwbA08QU2RXEHXd64/uZFHBQ/4dIVchzzih9q4k5bh
	6yYQFM0N+nx2abtyjUYqdXIW6FFEIR106SyP6KTNmF52HRlaUtz09CedY3Hn2P+CzWQzSo635Ii
	DRYcM7tEUicGralrBJ7DcveQblVDwX7HuLc54tq3fCaElmTFBrsgwCPU+NgAYzU2xNq7Fruo0Jp
	6vIR3Zokqy8wFwttABrpp81N8bWszv1HBeh37t3Gns8Qpq6KxxbD4wlh3J9SuE5hzKnga9EK34t
	ADDj0gdhKGePZDbI+DOp6+HqzMkLJ1tH6UHwwRNKv+qp4kjeSOdnizxghXK0LpZI6KQGNSVebTH
	5WnZytFg=
X-Received: by 2002:a05:6402:5484:b0:6b4:1916:965c with SMTP id 4fb4d7f45d1cf-6b7568dbf09mr1894675a12.18.1794309473770;
        Tue, 10 Nov 2026 03:17:53 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b757902dbasm966254a12.30.2026.11.10.03.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:17:53 -0800 (PST)
Message-ID: <b68da114-ec84-402d-90ff-bdd1740d5338@gmail.com>
Date: Tue, 10 Nov 2026 11:17:52 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 00/15] Fix segfaults on settings given without a value
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Colin Hinton <colinlewishinton@gmail.com>,
 Matt Hunter <m@lfurio.us>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

I've left a few comments on the test for the first patch and on the 
later patches that I didn't look at yesterday. There are several places 
where we now treat a NULL value as an error, but we ignore empty or 
invalid values. Having said that this series is clearly an improvement 
because we no longer segfault.

Thanks

Phillip

On 10/11/2026 07:36, Thomas Bachem via GitGitGadget wrote:
> A setting given without a value, as in "git -c foo.bar" or a bare "bar"
> under "[foo]", is passed as NULL to the code that reads it. In these places
> git does not check for that and segfaults:
> 
>   * rebase.missingCommitsCheck in "git rebase -i"
>   * core.alternateRefsCommand and core.alternateRefsPrefixes in "git fetch",
>     "git receive-pack" and "git rev-list --alternate-refs", in a repository
>     with an alternate
>   * the color slots of "git add -p", "git add -i" and the other interactive
>     patch modes
>   * fetch.bundleCreationToken in "git fetch" and "git clone --bundle-uri",
>     with a creationToken bundle list
>   * grep.patternType in "git grep", "git log" and "git show"
>   * remote.*.tagOpt in "git fetch", "git remote" and "git status"
>   * color.blame.repeatedLines and color.blame.highlightRecent in "git blame"
>   * branch.*.mergeOptions in "git merge" on that branch
>   * remotes.* in "git fetch" and "git push" of that remote group
>   * safe.bareRepository in any bare repository that git discovers
>   * bitmapPseudoMerge.*.pattern when writing a bitmap, as in "git repack
>     -adb"
>   * scalar.repo in "scalar reconfigure --all"
>   * remote.*.url in nearly every command, when an includeIf
>     "hasconfig:remote.*.url:..." section exists
>   * mode, heuristic, uri and creationToken in a bundle list, in "git clone
>     --bundle-uri" and "git fetch"
>   * any key at all in "git config list --type=color" and "--type=expiry-date"
> 
> Changes since v1:
> 
>   * Patch 1 no longer rejects a rebase.missingCommitsCheck without a value.
>     It warns and falls back to "ignore", as for a value that git does not
>     recognize (Phillip, Junio).
> 
>   * Rebased onto master, where iw/connected-deepen-fetch-no-alternate-refs
>     now adds tests at the end of t5618, as patch 2 does.
> 
> These turned up in a check of every config callback and every caller of
> repo_config_get_value(), and in runs of two dozen common commands with each
> key that "git help --config" lists set without a value. There may be more in
> code that neither method reached.
> 
> Most patches reject the missing value with config_error_nonbool(), as
> ba176db511 (config: handle NULL value when parsing non-bools, 2023-12-07)
> did for other settings. Four accept it without an error: a missing
> rebase.missingCommitsCheck warns and falls back to "ignore" like a value
> that git does not recognize (patch 1), a missing fetch.bundleCreationToken
> counts as 0 (patch 4), a remote URL without a value matches no includeIf
> condition (patch 13), and "git config list" leaves the key out (patch 15).
> The crash fixed in patch 14 can also come from a server, through a bundle
> list it advertises to clients that use bundle URIs. It is still a plain NULL
> dereference. Only patch 15 fixes a regression, which came in with 2.54.0.
> 
> remote.*.followRemoteHEAD without a value crashes the same commands. This
> series leaves it alone, as ch/remote-defer-follow-remote-head-validation in
> 'seen' already makes it safe, checking the value only where fetch uses it.
> 
> The series is now based on 3c60ef1e38 (The 17th batch, 2026-11-08) and
> merges cleanly into 'next' and 'seen' too.
> 
> Thomas Bachem (15):
>    rebase -i: handle NULL value for rebase.missingCommitsCheck
>    odb: handle NULL values for core.alternateRefs* config
>    add-patch: handle NULL value for color slots
>    bundle-uri: handle NULL value for fetch.bundleCreationToken
>    grep: handle NULL value for grep.patternType
>    remote: handle NULL value for remote.<name>.tagOpt
>    blame: handle NULL values for color.blame.* config
>    merge: handle NULL value for branch.<name>.mergeOptions
>    remote: handle NULL value for remotes.<group>
>    setup: handle NULL value for safe.bareRepository
>    pseudo-merge: handle NULL value for bitmapPseudoMerge.<name>.pattern
>    scalar: handle NULL value for scalar.repo
>    config: handle NULL value for remote URLs in hasconfig includes
>    bundle-uri: handle NULL values in bundle lists
>    config: handle NULL values when listing colors and expiry dates
> 
>   add-patch.c                     |  2 +-
>   builtin/blame.c                 |  4 ++++
>   builtin/config.c                |  4 ++--
>   builtin/merge.c                 |  2 ++
>   bundle-uri.c                    | 12 +++++++++++-
>   config.c                        |  3 ++-
>   grep.c                          |  2 ++
>   odb.c                           |  4 ++--
>   pseudo-merge.c                  |  4 ++++
>   rebase-interactive.c            | 10 ++++++++--
>   remote.c                        |  7 ++++++-
>   scalar.c                        |  5 ++++-
>   setup.c                         |  2 ++
>   t/t0035-safe-bare-repository.sh |  6 ++++++
>   t/t1300-config.sh               | 32 ++++++++++++++++++++++++++++++++
>   t/t3404-rebase-interactive.sh   | 12 ++++++++++++
>   t/t3701-add-interactive.sh      | 12 ++++++++++++
>   t/t5333-pseudo-merge-bitmaps.sh |  5 +++++
>   t/t5505-remote.sh               |  5 +++++
>   t/t5506-remote-groups.sh        |  5 +++++
>   t/t5558-clone-bundle-uri.sh     | 20 ++++++++++++++++++++
>   t/t5618-alternate-refs.sh       |  9 +++++++++
>   t/t5750-bundle-uri-parse.sh     | 16 ++++++++++++++++
>   t/t7600-merge.sh                |  6 ++++++
>   t/t7810-grep.sh                 |  5 +++++
>   t/t8012-blame-colors.sh         |  7 +++++++
>   t/t9210-scalar.sh               |  5 +++++
>   27 files changed, 195 insertions(+), 11 deletions(-)
> 
> 
> base-commit: 3c60ef1e38ee80337025a1b908327f7879386329
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2297%2Fthomasbachem%2Fconfig-null-value-segfaults-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2297/thomasbachem/config-null-value-segfaults-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/2297
> 
> Range-diff vs v1:
> 
>    1:  a9a3f4b705 !  1:  47224a9893 rebase -i: handle NULL value for rebase.missingCommitsCheck
>       @@ Commit message
>            segfault as it writes the todo list: get_missing_commit_check_level()
>            passes the NULL value to strcasecmp().
>        
>       -    The setting takes "ignore", "warn" or "error", not a bool. Read it
>       -    with repo_config_get_string_tmp(), which rejects a missing value with
>       -    config_error_nonbool(), as ba176db511 (config: handle NULL value when
>       -    parsing non-bools, 2023-12-07) did for other settings.
>       +    The setting takes "ignore", "warn" or "error". An unrecognized value,
>       +    perhaps one meant for a newer version of Git, gets a warning and is
>       +    treated as "ignore". Treat a missing value the same way.
>        
>       +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>            Assisted-by: Claude Fable 5.1
>       +    Assisted-by: Claude Opus 5.5
>            Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
>        
>         ## rebase-interactive.c ##
>       @@ rebase-interactive.c: static enum missing_commit_check_level get_missing_commit_
>         	const char *value;
>         
>        -	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value) ||
>       -+	if (repo_config_get_string_tmp(the_repository, "rebase.missingcommitscheck", &value) ||
>       - 			!strcasecmp("ignore", value))
>       +-			!strcasecmp("ignore", value))
>       ++	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value))
>       ++		return MISSING_COMMIT_CHECK_IGNORE;
>       ++	if (!value) {
>       ++		warning(_("missing value for option "
>       ++			  "rebase.missingCommitsCheck. Ignoring."));
>       ++		return MISSING_COMMIT_CHECK_IGNORE;
>       ++	}
>       ++	if (!strcasecmp("ignore", value))
>         		return MISSING_COMMIT_CHECK_IGNORE;
>         	if (!strcasecmp("warn", value))
>       + 		return MISSING_COMMIT_CHECK_WARN;
>        
>         ## t/t3404-rebase-interactive.sh ##
>        @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
>         	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>         '
>         
>       -+test_expect_success 'rebase -i rejects rebase.missingCommitsCheck without a value' '
>       ++test_expect_success 'rebase -i warns about and ignores rebase.missingCommitsCheck without a value' '
>        +	rebase_setup_and_clean missing-commit &&
>       -+	test_when_finished "test_might_fail git rebase --abort" &&
>       -+	test_must_fail git -c rebase.missingCommitsCheck rebase -i --root 2>err &&
>       -+	test_grep "missing value for .rebase.missingcommitscheck." err
>       ++	(
>       ++		set_fake_editor &&
>       ++		FAKE_LINES="1 2 3 4" \
>       ++			git -c rebase.missingCommitsCheck rebase -i --root 2>actual
>       ++	) &&
>       ++	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
>       ++	test_grep "missing value for option rebase.missingCommitsCheck" actual &&
>       ++	test_grep ! "commits may have been dropped" actual
>        +'
>        +
>         test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
>    2:  74ab5bfc62 !  2:  9170c4162f odb: handle NULL values for core.alternateRefs* config
>       @@ odb.c: static void fill_alternate_refs_command(struct repository *repo,
>         		}
>        
>         ## t/t5618-alternate-refs.sh ##
>       -@@ t/t5618-alternate-refs.sh: test_expect_success 'log --source shows .alternate marker' '
>       +@@ t/t5618-alternate-refs.sh: test_expect_success 'refs of a shallow alternate are ignored' '
>         	test_cmp expect actual
>         '
>         
>    3:  1b5f243294 =  3:  d3fd6290e0 add-patch: handle NULL value for color slots
>    4:  4eb7085084 =  4:  a822cbb844 bundle-uri: handle NULL value for fetch.bundleCreationToken
>    5:  88df66ab7e =  5:  6c2a671a92 grep: handle NULL value for grep.patternType
>    6:  e95249fb51 =  6:  d4b49d1363 remote: handle NULL value for remote.<name>.tagOpt
>    7:  260b90a4a2 =  7:  25843b43bf blame: handle NULL values for color.blame.* config
>    8:  e10f1fc0ba =  8:  d8681a8560 merge: handle NULL value for branch.<name>.mergeOptions
>    9:  0faf4e884f =  9:  51f8eba073 remote: handle NULL value for remotes.<group>
>   10:  0991a1b80c = 10:  a5b6436943 setup: handle NULL value for safe.bareRepository
>   11:  3f4cbf4494 = 11:  1533ef9cc6 pseudo-merge: handle NULL value for bitmapPseudoMerge.<name>.pattern
>   12:  b4bcaf19ec = 12:  6219e9fd7f scalar: handle NULL value for scalar.repo
>   13:  5c12b13d90 = 13:  080106d5ea config: handle NULL value for remote URLs in hasconfig includes
>   14:  ce4c190ea2 = 14:  fb9e63541b bundle-uri: handle NULL values in bundle lists
>   15:  7ac4e3a3d9 = 15:  12f841e5ff config: handle NULL values when listing colors and expiry dates
> 

