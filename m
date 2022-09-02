Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8543AECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiIBQFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbiIBQFA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:05:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF4CDEB7E
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 08:58:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay12so1494178wmb.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=t/0l+T2W3GdG5kw9LSoxDr9uXM4vYf55om7ue+z/Jo0=;
        b=d4uaN1HV3UBYZRFm7puMTc6bl08LdYAiWtAN3YbAzy33kYdZpd3JSxj+4N/YChEU6Q
         lkKbeqhUTSkbpzGrlMTCW6iuXPY7wnjes8sql1tzqvzT8nDkA93G2Q1H1ZPApUIRRUA6
         y+6iYLHMBG+cUYXLAeML/QlPj0F6vVoVTGNMZ4RSbrDEkGX1kyDFZ4aW1KC2DFMiDRiZ
         ixicG4jpUepSuKKi7vxwu3723d4PGINTmaD3Kn0b+wDUDZVxfPq5kfi1j4Niep/JU28j
         o+XN75PLd2W1zrPtqVtmXlAMP73eVR+f5RQsv7e5gxJehxEraoU/A+1V/3mJ/9VerbhV
         8KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=t/0l+T2W3GdG5kw9LSoxDr9uXM4vYf55om7ue+z/Jo0=;
        b=MmDUNn49xjNtvcb7y/bpZor4v8AHwd89JyJxEeBH+hsg6oB3/LGlBlDIjRUjqOwvnU
         wL2kg8QIv8nivLQ506kwzhZXgT4xkQOZdS/XNZ8w2fIX7yAblhe+tLNS55JVjWZ96Jdp
         tD1LbvTNw6YOU1yRHWUf8L8ol/+D/p/xQbxwldUB6yIbM7hO+JLavU/+u6+sioLLUgTM
         evSxMpPdgxC1+4VGdR3iIzpuy2XPwhQ/0hrxlsc2qa2GIbNYMJNEdEcyqq9o8Gn5CHcP
         P95GgIIx/5uYwtIs+m1PFhjy4g3cMTCGeAS5EfEupXkUOs8r+mAvzvu3KaSDi5zfQ5I7
         AG1A==
X-Gm-Message-State: ACgBeo17TqvSdJTEiI1WfMlK27rhXsJnHjwjHfePqVG5IMUZjz5jnwaR
        ueGS5mxw+DEzimZrhLlWeOxKCniM5ck=
X-Google-Smtp-Source: AA6agR5N6ovLpoht1AzfnqjswY0OTmaFOmK+UPOtM862XHks70+IMbYk0LbufVhERDhvtVijCPfNiQ==
X-Received: by 2002:a05:600c:490:b0:3a5:a6aa:bf2f with SMTP id d16-20020a05600c049000b003a5a6aabf2fmr3339603wme.17.1662134212579;
        Fri, 02 Sep 2022 08:56:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11-20020a1cf30b000000b003a8434530bbsm8722170wmq.13.2022.09.02.08.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:56:51 -0700 (PDT)
Message-Id: <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 15:56:41 +0000
Subject: [PATCH v2 0/9] scalar: integrate into core Git
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series completes the initial implementation of the Scalar command as a
core component of Git. For readers new to the topic of Scalar, the
roadmap/design doc [1] provides some background information including how
the project started & evolved, as well as its current intent & high-level
design.


Changes since V1
================

 * Updated 'scalar.txt' description from "Associated with [git]" -> "Part of
   [git]".
 * Fixed Dscho's "Signed-off-by" and author emails on patches 3 & 4.
 * Added 'scalar' to 'git help -a' command list.
 * Removed translation tag for literal 'scalar help' usage string.
 * Updated 'scalar clone' tests to clone to unique targets and clean up only
   when test passes.
 * Changed 'p9210' perf tests to invoke 'git' and 'scalar' with '-C', rather
   than creating a subshell to run commands.
 * Fixed use of 'test_env_bool' with 'GIT_PERF_USE_SCALAR', locally tested
   to make sure it was working as-intended.


Goals
=====

The goal of this series is, as noted in the roadmap linked earlier, to
integrate Scalar as a core user-facing component of Git. There's no
individual existing precedent that the integration is 100% based on; it's
more of an amalgam of the approaches used with builtins installed directly
to the bindir (e.g. 'git-upload-pack'), contributed tools (e.g. 'gitk'), and
the 'git' executable itself. The resulting behavior is:

 * Scalar is built & installed unconditionally (like a builtin).
 * Scalar is included in 'bin-wrappers/' and is installed into the 'bin/'
   directory (like 'git-upload-pack').
 * Scalar's documentation is installed as 'man1' docs (like 'gitk').
 * Scalar is not invoked via the 'git' executable (it's called directly,
   like 'git' itself).

The move out of 'contrib/' is also intended to mean that the relationship
between Git and Scalar should no longer be a strict one-way dependency. In
this series, this architectural change is what permits making a change to
'help.c' specifically for the sake of Scalar. Future contributions can and
should (where appropriate!) share code between Scalar and non-Scalar parts
of Git.


Organization
============

The series is broken up as follows:

 1. Fix a CI-breaking documentation error in 'scalar.txt' (patch 1).
 2. Move Scalar code out of 'contrib/' and into core Git, including changes
    in build definition(s) to build & install Scalar and its resources
    (patch 2).
 3. Make 'git help scalar' open the 'scalar' command documentation,
    introduce 'scalar help' as an alias. This is done after moving out of
    'contrib/' due to it involving Scalar-related changes to the non-Scalar
    file 'help.c' (patches 3-4).
 4. Expand test coverage, including perf testing (patches 5-6)
 5. Add a perf test configuration allowing users to register standard perf
    test repos with Scalar (patch 7).
 6. Remove the internally-focused Scalar roadmap from
    'Documentation/technical/scalar.txt', include it as one of the HTML
    technical docs (patch 8).


Prior series
============

 * Add 'scalar' command in 'contrib/':
   https://lore.kernel.org/git/pull.1005.v10.git.1638538470.gitgitgadget@gmail.com/
 * Introduce 'scalar diagnose':
   https://lore.kernel.org/git/pull.1128.v6.git.1653145696.gitgitgadget@gmail.com/
 * Add '-c/-C' compatibility:
   https://lore.kernel.org/git/pull.1130.v2.git.1643380317358.gitgitgadget@gmail.com/
 * [DROPPED] Integrate Scalar into CI builds:
   https://lore.kernel.org/git/pull.1129.git.1654160735.gitgitgadget@gmail.com/
 * Document Scalar's role in Git & plan remaining work:
   https://lore.kernel.org/git/pull.1275.v2.git.1657584367.gitgitgadget@gmail.com/
 * Generalize 'scalar diagnose' into 'git diagnose' builtin & 'git bugreport
   --diagnose':
   https://lore.kernel.org/git/pull.1310.v4.git.1660335019.gitgitgadget@gmail.com/
 * Add FSMonitor support to Scalar, refactor enlistment search:
   https://lore.kernel.org/git/pull.1324.v3.git.1660858853.gitgitgadget@gmail.com/

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/65eda9755d2a29e222bf7e6cc719921b24377cc6.1657584367.git.gitgitgadget@gmail.com/

Johannes Schindelin (2):
  git help: special-case `scalar`
  scalar: implement the `help` subcommand

Victoria Dye (7):
  scalar: fix command documentation section header
  scalar: include in standard Git build & installation
  scalar: add to 'git help -a' command list
  scalar-clone: add test coverage
  t/perf: add Scalar performance tests
  t/perf: add 'GIT_PERF_USE_SCALAR' run option
  Documentation/technical: include Scalar technical doc

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   2 +
 Documentation/cmd-list.perl                   |   2 +-
 {contrib/scalar => Documentation}/scalar.txt  |   4 +-
 Documentation/technical/scalar.txt            |  61 -------
 Makefile                                      |  31 ++--
 builtin/help.c                                |   2 +
 command-list.txt                              |   1 +
 contrib/buildsystems/CMakeLists.txt           |   9 +-
 contrib/scalar/.gitignore                     |   2 -
 contrib/scalar/Makefile                       |  35 ----
 contrib/scalar/t/Makefile                     |  81 ----------
 contrib/scalar/scalar.c => scalar.c           |  20 +++
 t/perf/README                                 |   4 +
 t/perf/p9210-scalar.sh                        |  39 +++++
 t/perf/perf-lib.sh                            |  13 +-
 t/perf/run                                    |   3 +
 .../t/t9099-scalar.sh => t/t9210-scalar.sh    |  10 +-
 t/t9211-scalar-clone.sh                       | 151 ++++++++++++++++++
 19 files changed, 264 insertions(+), 207 deletions(-)
 rename {contrib/scalar => Documentation}/scalar.txt (99%)
 delete mode 100644 contrib/scalar/.gitignore
 delete mode 100644 contrib/scalar/Makefile
 delete mode 100644 contrib/scalar/t/Makefile
 rename contrib/scalar/scalar.c => scalar.c (98%)
 create mode 100755 t/perf/p9210-scalar.sh
 rename contrib/scalar/t/t9099-scalar.sh => t/t9210-scalar.sh (96%)
 create mode 100755 t/t9211-scalar-clone.sh


base-commit: d42b38dfb5edf1a7fddd9542d722f91038407819
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1341%2Fvdye%2Ffeature%2Fscalar-toplevel-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1341/vdye/feature/scalar-toplevel-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1341

Range-diff vs v1:

  1:  fcf73e77574 !  1:  614cbdc629d scalar: fix command documentation section header
     @@ contrib/scalar/scalar.txt: SEE ALSO
      -Scalar
      +GIT
       ---
     - Associated with the linkgit:git[1] suite
     +-Associated with the linkgit:git[1] suite
     ++Part of the linkgit:git[1] suite
  2:  4d69e5eaccb !  2:  bc2092a7a7a scalar: include in standard Git build & installation
     @@ Makefile: XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
       	--keyword=__ --keyword=N__ --keyword="__n:1,2"
       MSGMERGE_FLAGS = --add-location --backup=off --update
      -LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
     -+LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) \
     - 	        $(GENERATED_H))
     +-	        $(GENERATED_H))
     ++LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(GENERATED_H))
       LOCALIZED_SH = $(sort $(SCRIPT_SH) git-sh-setup.sh)
       LOCALIZED_PERL = $(sort $(SCRIPT_PERL))
     + 
      @@ Makefile: bin-wrappers/%: wrap-for-bin.sh
       	$(call mkdir_p_parent_template)
       	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
  3:  969160650aa =  3:  eb8663e0300 git help: special-case `scalar`
  4:  46d0fddfe8f !  4:  55aba052c34 scalar: implement the `help` subcommand
     @@
       ## Metadata ##
     -Author: Johannes Schindelin <johasc@microsoft.com>
     +Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
          scalar: implement the `help` subcommand
      
          It is merely handing off to `git help scalar`.
      
     -    Signed-off-by: Johannes Schindelin <johasc@microsoft.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## scalar.c ##
     @@ scalar.c: static int cmd_delete(int argc, const char **argv)
      +		OPT_END(),
      +	};
      +	const char * const usage[] = {
     -+		N_("scalar help"),
     ++		"scalar help",
      +		NULL
      +	};
      +
  -:  ----------- >  5:  070f195f027 scalar: add to 'git help -a' command list
  5:  a3b7cb0a3bd !  6:  15acf20274b scalar-clone: add test coverage
     @@ Commit message
          scalar-clone: add test coverage
      
          Create a new test file ('t9211-scalar-clone.sh') to exercise the options and
     -    behavior of the 'scalar clone' command.
     +    behavior of the 'scalar clone' command. Each test clones to a unique target
     +    location and cleans up the cloned repo only when the test passes. This
     +    ensures that failed tests' artifacts are captured in CI artifacts for
     +    further debugging.
      
     +    Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## t/t9211-scalar-clone.sh (new) ##
     @@ t/t9211-scalar-clone.sh (new)
      +}
      +
      +test_expect_success 'creates content in enlistment root' '
     -+	test_when_finished cleanup_clone cloned &&
     ++	enlistment=cloned &&
      +
     -+	scalar clone "file://$(pwd)/to-clone" cloned &&
     -+	ls -A cloned >enlistment-root &&
     ++	scalar clone "file://$(pwd)/to-clone" $enlistment &&
     ++	ls -A $enlistment >enlistment-root &&
      +	test_line_count = 1 enlistment-root &&
     -+	test_path_is_dir cloned/src &&
     -+	test_path_is_dir cloned/src/.git
     ++	test_path_is_dir $enlistment/src &&
     ++	test_path_is_dir $enlistment/src/.git &&
     ++
     ++	cleanup_clone $enlistment
      +'
      +
      +test_expect_success 'with spaces' '
     -+	test_when_finished cleanup_clone "cloned with space" &&
     ++	enlistment="cloned with space" &&
     ++
     ++	scalar clone "file://$(pwd)/to-clone" "$enlistment" &&
     ++	test_path_is_dir "$enlistment" &&
     ++	test_path_is_dir "$enlistment/src" &&
     ++	test_path_is_dir "$enlistment/src/.git" &&
      +
     -+	scalar clone "file://$(pwd)/to-clone" "cloned with space" &&
     -+	test_path_is_dir "cloned with space" &&
     -+	test_path_is_dir "cloned with space/src" &&
     -+	test_path_is_dir "cloned with space/src/.git"
     ++	cleanup_clone "$enlistment"
      +'
      +
      +test_expect_success 'partial clone if supported by server' '
     -+	test_when_finished cleanup_clone cloned &&
     ++	enlistment=partial-clone &&
      +
     -+	scalar clone "file://$(pwd)/to-clone" cloned &&
     ++	scalar clone "file://$(pwd)/to-clone" $enlistment &&
      +
      +	(
     -+		cd cloned/src &&
     ++		cd $enlistment/src &&
      +
      +		# Two promisor packs: one for refs, the other for blobs
      +		ls .git/objects/pack/pack-*.promisor >promisorlist &&
      +		test_line_count = 2 promisorlist
     -+	)
     ++	) &&
     ++
     ++	cleanup_clone $enlistment
      +'
      +
      +test_expect_success 'fall back on full clone if partial unsupported' '
     -+	test_when_finished cleanup_clone cloned &&
     ++	enlistment=no-partial-support &&
      +
      +	test_config -C to-clone uploadpack.allowfilter false &&
      +	test_config -C to-clone uploadpack.allowanysha1inwant false &&
      +
     -+	scalar clone "file://$(pwd)/to-clone" cloned 2>err &&
     ++	scalar clone "file://$(pwd)/to-clone" $enlistment 2>err &&
      +	grep "filtering not recognized by server, ignoring" err &&
      +
      +	(
     -+		cd cloned/src &&
     ++		cd $enlistment/src &&
      +
      +		# Still get a refs promisor file, but none for blobs
      +		ls .git/objects/pack/pack-*.promisor >promisorlist &&
      +		test_line_count = 1 promisorlist
     -+	)
     ++	) &&
     ++
     ++	cleanup_clone $enlistment
      +'
      +
      +test_expect_success 'initializes sparse-checkout by default' '
     -+	test_when_finished cleanup_clone cloned &&
     ++	enlistment=sparse &&
      +
     -+	scalar clone "file://$(pwd)/to-clone" cloned &&
     ++	scalar clone "file://$(pwd)/to-clone" $enlistment &&
      +	(
     -+		cd cloned/src &&
     ++		cd $enlistment/src &&
      +		test_cmp_config true core.sparseCheckout &&
      +		test_cmp_config true core.sparseCheckoutCone
     -+	)
     ++	) &&
     ++
     ++	cleanup_clone $enlistment
      +'
      +
      +test_expect_success '--full-clone does not create sparse-checkout' '
     -+	test_when_finished cleanup_clone cloned &&
     ++	enlistment=full-clone &&
      +
     -+	scalar clone --full-clone "file://$(pwd)/to-clone" cloned &&
     ++	scalar clone --full-clone "file://$(pwd)/to-clone" $enlistment &&
      +	(
     -+		cd cloned/src &&
     ++		cd $enlistment/src &&
      +		test_cmp_config "" --default "" core.sparseCheckout &&
      +		test_cmp_config "" --default "" core.sparseCheckoutCone
     -+	)
     ++	) &&
     ++
     ++	cleanup_clone $enlistment
      +'
      +
      +test_expect_success '--single-branch clones HEAD only' '
     -+	test_when_finished cleanup_clone cloned &&
     ++	enlistment=single-branch &&
      +
     -+	scalar clone --single-branch "file://$(pwd)/to-clone" cloned &&
     ++	scalar clone --single-branch "file://$(pwd)/to-clone" $enlistment &&
      +	(
     -+		cd cloned/src &&
     ++		cd $enlistment/src &&
      +		git for-each-ref refs/remotes/origin >out &&
      +		test_line_count = 1 out &&
      +		grep "refs/remotes/origin/base" out
     -+	)
     ++	) &&
     ++
     ++	cleanup_clone $enlistment
      +'
      +
      +test_expect_success '--no-single-branch clones all branches' '
     -+	test_when_finished cleanup_clone cloned &&
     ++	enlistment=no-single-branch &&
      +
     -+	scalar clone --no-single-branch "file://$(pwd)/to-clone" cloned &&
     ++	scalar clone --no-single-branch "file://$(pwd)/to-clone" $enlistment &&
      +	(
     -+		cd cloned/src &&
     ++		cd $enlistment/src &&
      +		git for-each-ref refs/remotes/origin >out &&
      +		test_line_count = 2 out &&
      +		grep "refs/remotes/origin/base" out &&
      +		grep "refs/remotes/origin/parallel" out
     -+	)
     ++	) &&
     ++
     ++	cleanup_clone $enlistment
      +'
      +
      +test_done
  6:  42ab39f2121 !  7:  d5b68c65163 t/perf: add Scalar performance tests
     @@ Commit message
          9210.6: test_commit --append --no-tag A (scalar)       0.08(0.02+0.03)
          9210.7: test_commit --append --no-tag A (non-scalar)   0.13(0.03+0.11)
      
     +    Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## t/perf/p9210-scalar.sh (new) ##
     @@ t/perf/p9210-scalar.sh (new)
      +'
      +
      +test_compare_perf () {
     -+	command="$@"
     -+	test_perf "$command (scalar)" "
     -+		(
     -+			cd scalar-clone/src &&
     -+			$command
     -+		)
     ++	command=$1
     ++	shift
     ++	args=$*
     ++	test_perf "$command $args (scalar)" "
     ++		$command -C scalar-clone/src $args
      +	"
      +
     -+	test_perf "$command (non-scalar)" "
     -+		(
     -+			cd git-clone &&
     -+			$command
     -+		)
     ++	test_perf "$command $args (non-scalar)" "
     ++		$command -C git-clone $args
      +	"
      +}
      +
  7:  96e08a95265 !  8:  2e6dd03beba t/perf: add 'GIT_PERF_USE_SCALAR' run option
     @@ t/perf/perf-lib.sh: test_perf_create_repo_from () {
       			# a copy it's fine to remove the lock.
       			rm .git/index.lock
      +		fi &&
     -+		if test_bool_env "$GIT_PERF_USE_SCALAR" false
     ++		if test_bool_env GIT_PERF_USE_SCALAR false
      +		then
      +			"$MODERN_SCALAR" register
       		fi
     @@ t/perf/perf-lib.sh: test_perf_fresh_repo () {
       		cd "$repo" &&
      -		test_perf_do_repo_symlink_config_
      +		test_perf_do_repo_symlink_config_ &&
     -+		if test_bool_env "$GIT_PERF_USE_SCALAR" false
     ++		if test_bool_env GIT_PERF_USE_SCALAR false
      +		then
      +			"$MODERN_SCALAR" register
      +		fi
  8:  8bbe913dccf =  9:  6bedd80c398 Documentation/technical: include Scalar technical doc

-- 
gitgitgadget
