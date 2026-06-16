Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB62750ED
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 04:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585454; cv=none; b=Jwl+QS9Cbplp6EcQNqdHu5x0iZ8vuPHBYJ07bavji0U5o3uqCfWSKWCKQDRL74Wwky2DLASjDPuZ5qZArDQHzhYvlTl7BYUVNJeQ/V+6nJPt61f2vl+1yzR6plPb3x6JPoPTM8O7KvnnmfwCezdcuE9gINu2DUAajmbpL8jguL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585454; c=relaxed/simple;
	bh=QvOpgbyhtz9fEpAI3jFn0bI8pRDLlCyfd78hPq2Spu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3TUb7hgHTlZLtmJ96ayAvadDD4MC5/pFFGocXCCjwEBi+yaDvdczVaEa7UHkaAKyt+CYGSnXhY7uRL3qfYy5l6wh5e1Wp2tiV5OrV3afKWURTPaHwYFkuXjaaSANC7oPhxHqxyxXOxLCPmSJK5SBKajKwY4XmkBKejhtIdRjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ginOPs4B; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ginOPs4B"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8434840cea8so2463124b3a.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 21:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781585453; x=1782190253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZhNmVHd5ArDxV1DPtZuXeryPkwPpTpiFlRDIqjbPcI=;
        b=ginOPs4BSvUiUJOAgN9NvyCLL4V0ED3dFgOW4a9qCHUYQC23BFZFymVgtxX1Sh4UY1
         rbheO3h0x5LJBURDLIf7KJKY769zFDLb5y3XAovMxrbWxCoEWlEdUy9nqKlfRLCbPsBq
         tIzgIOknK/eZxEpE4eycpa1NnxfZMN8MhrgerCDxUTl/udN/brYTRPQDTGLa2I0fCInP
         Ow233uzpsWyio1+hZEMTTLajEe1mcDxRP3B0tzjuPXNGELRqkNAL/dSPgKH/ogqY9bar
         syoNiAjEbJ6WIz+sP2bJ/ngJW4BXTk1q0nmwq6Cxajb3BMX1JyNZ4H38b/i4dQA7QTqO
         tK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781585453; x=1782190253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZhNmVHd5ArDxV1DPtZuXeryPkwPpTpiFlRDIqjbPcI=;
        b=EKDlzlNQnW5EFJOHDcka9GNw5OmFHcP0P3JoqHIoyQAyA56PEIoOzYcCkSOm+eXElx
         005unq1iQjgKqjrGPh83ozIKUFixvaMnXgatIq0jjlg0qyPIhhw2JUoo9NnPtzOMdXSt
         xs06P4diSMgjUpKKXgeacQ4ABlPVaXKeguAzPnj3kTjk02iNiY4WEl2xLrEbaYEWJIE2
         VqBWSo9F7YsOTvfuWHD8EZVUhMA4dWo0Lasm/ENp+iloGWa5L3iwpsi7twT+dfNBI2gY
         h7qm1rCHImMzwsi61fm3/3/aVqRkJfSGACotoVDJYWR5Qvc6VOhEZQAmzyiIlF34CYtv
         JeFA==
X-Gm-Message-State: AOJu0Yzuz4zUiSnV7H9D1OTyQ5Daw3YQG5khjXklb7fVicKuM7iGraq4
	ybHCbIY9fXwtqu9kbk0iLIoG3MIhyBjiCY7kFiUrSYKwqu5+GvHpmLBOzd4/GA==
X-Gm-Gg: Acq92OEPnn6kYmbYoQZtIhk51my3xDEJc/dniuBr4VhPkpB0akpwgwLgMSq9rTXlinm
	FEiOQ0YEu3tVc8liWJipeNmiEGWBUVX0fmko98VluNO/fa3Lx0rzmsHJKzGldZ44jn8RAqevQFW
	1Dnmfwl8wvAMliUdUCL3gF5teL5VslsaUFCS8LyZFL78cnCI4QWroijUjaGD9WGhsMTE3YtU3P5
	uPACAytNfQ/P2pMVDsv1GOyjOK7ZGoVCjihZs0zebufOEeReqdYSUfYkWkZeSc9/n+wReQpq7pK
	kjoaqx5MbcbcjhrRIuTw6NcO6lvj0YcxfjCBG9tGGMGN0iRX6xcm1M15/FqBwOEAXWHxMcxNKQb
	nxtQkhj8I5UNBx2FflIdQRbk/IXEKAIQiJJzT2eg7IhhpDJXC4SYu0YNBTZ+T5cIcqMOR6sqOQe
	bAbCxJKBfzG66SEGhazC8t2o/ZCTxPiQI6geKw6aAnL2JymtqD2+K9ZSbqYS9g+c7vdjlKqvy+T
	GD556jOLdyLBMJEomWyjMQB8ij8NcL0jw==
X-Received: by 2002:a05:6a00:2c94:b0:842:5719:4552 with SMTP id d2e1a72fcca58-845155811c4mr1839046b3a.46.1781585452862;
        Mon, 15 Jun 2026 21:50:52 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b040718sm12122614b3a.51.2026.06.15.21.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:50:51 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v5 0/4] teach git repo info to handle path keys
Date: Tue, 16 Jun 2026 10:19:49 +0530
Message-ID: <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This series teaches `git repo info` to handle `path.*`
keys, allowing scripts to reliably discover core
repository paths without resorting to `git rev-parse`.

The patches are structured as follows:

1. path: Extract the localized path-formatting logic
   out of `rev-parse` and expose it globally via
   `path.h` using clear append semantics.

2. rev-parse: Refactor the command to leverage the
   newly shared path engine.

3. repo: Introduce `path.commondir.absolute` and
   `path.commondir.relative` alongside a robust,
   isolated test helper.

4. repo: Introduce `path.gitdir.absolute` and
   `path.gitdir.relative` using the same standardized
   formatting rules.

changes since v4:
* Simplified the `test_repo_info_path` helper by dropping the `repo_name` 
  argument and utilizing `test_when_finished "rm -rf repo"` to handle 
  repository setup/teardown inline. This ensures perfect test isolation.
* Condensed the redundant `expect_absolute_suffix` and `expect_relative` 
  test helper arguments into a single `expected_dir` argument, reducing 
  the helper signature to 4 arguments (Justin).
* Added a contextual comment in `builtin/rev-parse.c`'s `print_path()` 
  explaining why `PATH_FORMAT_DEFAULT` is intercepted and overridden with 
  a path-specific fallback (Justin).
* Trimmed the verbose test helper explanations from the commit messages 
  in patches 3 and 4.

K Jayatheerth (4):
  path: introduce append_formatted_path() for shared path formatting
  rev-parse: use append_formatted_path() for path formatting
  repo: add path.commondir with absolute and relative suffix formatting
  repo: add path.gitdir with absolute and relative suffix formatting

 Documentation/git-repo.adoc |  15 ++++++
 builtin/repo.c              |  50 +++++++++++++++++
 builtin/rev-parse.c         | 104 +++++++++---------------------------
 path.c                      |  70 ++++++++++++++++++++++++
 path.h                      |  36 +++++++++++++
 t/t1900-repo-info.sh        |  58 ++++++++++++++++++++
 6 files changed, 253 insertions(+), 80 deletions(-)

Range-diff against v4:
1:  a396b4f8e6 = 1:  a396b4f8e6 path: introduce append_formatted_path() for shared path formatting
2:  16198f96d1 ! 2:  16b42a51d2 rev-parse: use append_formatted_path() for path formatting
    @@ builtin/rev-parse.c: static void handle_ref_opt(const char *pattern, const char
     -	}
     -	free(cwd);
     +	struct strbuf sb = STRBUF_INIT;
    ++	/* If the user didn't explicitly specify a format, fallback to the path-specific default. */
     +	enum path_format fmt = (arg_path_format != PATH_FORMAT_DEFAULT) ? arg_path_format : def_format;
     +
     +	append_formatted_path(&sb, path, prefix, fmt);
3:  b45c6f0d12 ! 3:  38b733ea64 repo: add path.commondir with absolute and relative suffix formatting
    @@ Commit message
         Exposing explicit format variants rather than a single key with a
         default avoids ambiguity for scripts that require predictable output.
     
    -    Add a test helper test_repo_info_path that creates isolated
    -    repositories per test case to prevent state leaks, captures the repo
    -    root before changing directories to avoid eval, and accepts an optional
    -    init_command to cover environment variable overrides such as
    -    GIT_COMMON_DIR and GIT_DIR.
    -
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
         Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
    @@ t/t1900-repo-info.sh: test_expect_success 'git repo info -h shows only repo info
     +# Helper function to test path keys in both absolute and relative formats.
     +# $1: label for the test
     +# $2: field_name (e.g., commondir)
    -+# $3: unique repo name for isolation
    -+# $4: expect_absolute (suffix appended to repo root)
    -+# $5: expect_relative (the relative path string expected)
    -+# $6: init_command (extra setup like exporting env vars)
    ++# $3: expected_dir (the directory name, e.g., .git or custom-common)
    ++# $4: init_command (extra setup like exporting env vars)
     +test_repo_info_path () {
     +	label=$1
     +	field_name=$2
    -+	repo_name=$3
    -+	expect_absolute_suffix=$4
    -+	expect_relative=$5
    -+	init_command=$6
    -+
    -+	absolute_root="$repo_name-absolute"
    -+	relative_root="$repo_name-relative"
    -+
    -+	test_expect_success "setup: $label" '
    -+		git init "$absolute_root" &&
    -+		git init "$relative_root" &&
    -+		mkdir -p "$absolute_root/sub" "$relative_root/sub"
    -+	'
    ++	expected_dir=$3
    ++	init_command=$4
     +
     +	test_expect_success "absolute: $label" '
    ++		test_when_finished "rm -rf repo" &&
    ++		git init repo &&
     +		(
    -+			cd "$absolute_root/sub" &&
    ++			mkdir -p repo/sub &&
    ++			cd repo/sub &&
     +			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
     +			eval "$init_command" &&
    -+			expect_path="$ROOT${expect_absolute_suffix:+/$expect_absolute_suffix}" &&
    -+			echo "path.$field_name.absolute=$expect_path" >expect &&
    ++			echo "path.$field_name.absolute=$ROOT/$expected_dir" >expect &&
     +			git repo info "path.$field_name.absolute" >actual &&
     +			test_cmp expect actual
     +		)
     +	'
     +
     +	test_expect_success "relative: $label" '
    ++		test_when_finished "rm -rf repo" &&
    ++		git init repo &&
     +		(
    -+			cd "$relative_root/sub" &&
    ++			mkdir -p repo/sub &&
    ++			cd repo/sub &&
     +			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
     +			eval "$init_command" &&
    -+			echo "path.$field_name.relative=$expect_relative" >expect &&
    ++			echo "path.$field_name.relative=../$expected_dir" >expect &&
     +			git repo info "path.$field_name.relative" >actual &&
     +			test_cmp expect actual
     +		)
     +	'
     +}
     +
    -+test_repo_info_path 'commondir standard' 'commondir' 'commondir-std' \
    -+	'.git' '../.git'
    ++test_repo_info_path 'commondir standard' 'commondir' '.git'
     +
     +test_repo_info_path 'commondir with GIT_COMMON_DIR and GIT_DIR' 'commondir' \
    -+	'commondir-envs' 'custom-common' '../custom-common' \
    ++	'custom-common' \
     +	'GIT_COMMON_DIR="$ROOT/custom-common" && export GIT_COMMON_DIR &&
     +	 GIT_DIR="../.git" && export GIT_DIR &&
     +	 git init --bare "$ROOT/custom-common"'
     +
     +test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
    -+	'commondir-only-gitdir' '.git' '../.git' \
    ++	'.git' \
     +	'GIT_DIR="../.git" && export GIT_DIR'
     +
      test_done
4:  b5234ffe3e ! 4:  ead1117332 repo: add path.gitdir with absolute and relative suffix formatting
    @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
     
      ## t/t1900-repo-info.sh ##
     @@ t/t1900-repo-info.sh: test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
    - 	'commondir-only-gitdir' '.git' '../.git' \
    + 	'.git' \
      	'GIT_DIR="../.git" && export GIT_DIR'
      
    -+test_repo_info_path 'gitdir standard' 'gitdir' 'gitdir-std' \
    -+	'.git' '../.git'
    ++test_repo_info_path 'gitdir standard' 'gitdir' '.git'
     +
     +test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
    -+	'gitdir-env' '.git' '../.git' \
    ++	'.git' \
     +	'GIT_DIR="../.git" && export GIT_DIR'
     +
      test_done
-- 
2.54.0
