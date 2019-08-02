Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3E51F731
	for <e@80x24.org>; Fri,  2 Aug 2019 22:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfHBWCj (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 18:02:39 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:41410 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbfHBWCj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 18:02:39 -0400
Received: by mail-vk1-f201.google.com with SMTP id r4so32745226vkr.8
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mizWkH45U967rDIAhIRlUb/Dwez5JBrDxIz53w+PsJM=;
        b=T6/Lk2Sx0CSaBdaIekKhav7cq7qEPSAwBr0l5SIneYlKa/JvVVha/LNl4Ml5m2PZ8S
         frINevptvJADkIjH8YBharFV2XIpCYDOeuMhmWgEWRoRCDksRSmNEUBMKBupLgnHyKFy
         WPUh6WXM7Jgj9SJJCNgRUTXW0FjpN008lz8zSlleMhUUN/urGUf4Zz6LF9cVqZ4SGBbL
         myc9NdZv1XTqk13zuoPIbhm2iczqvTSHVAl7+mmkoOiAGFWTDkEyoZ7wQ1GLWydeQ67a
         XhSvXdSb4nBJNP+mk7ufL6GN+k3UX/QcAdiyNThr1KHxOeL//+QIul4i1sYGoam1lvG2
         okGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mizWkH45U967rDIAhIRlUb/Dwez5JBrDxIz53w+PsJM=;
        b=a+hGKrpRDjlFAVK7iUykX3HJPJJTTYEcZjEATdZwXCcvY72aQ7ZSijg26vBXo3RIRS
         1GPXLuMQ/xUHExZNK5mUq1kMUHB4tYNEMUvT3Bj28R29Qp5PgAv6AghCu1nKDdmQVtIc
         BiNYuZQbenEYj/PoSzDdTeQ7ArPGt996Z39SzzKQW9FHkvFYOKslUJUlbi6N4m3DiUyq
         argO4vH1QWvOn4AVmM7gf8wO0b28pFiYFTEiNhmqMRh3RtNMyuna1n0YlBdUWy7+FDJJ
         Ji6JQFXqJnF1QaXCwCSpw8ewHq6GJ9NdsXpnYVk5Yx1PnYdKiGqqosoZQj/U8fXkfQdP
         V6og==
X-Gm-Message-State: APjAAAWk+TAmxFcD0E3u9yn3ZLN3DV81SsAtO/lD6WpqR3oH6yOQ7dqT
        qGAmUVD3u8CH7iVaD/PAo1DFca9KzcUn0uEijxGe7u/xDkxkEpYzcI8VsSrIdgJiCC66WjRpCDB
        kiu79JbyjHQ8sCAkDn18f9HvySJDH5S+yzXcR8IVwcYrGCSe+rb/1PABF2TDFw9s=
X-Google-Smtp-Source: APXvYqzSVFv95sP0EENUZd59Nrthgh41RtYRGh5RL/rbr7zAQmhEK29Fy6//GgHGA1YV5LZg4lbwofx+MdULmQ==
X-Received: by 2002:a67:e40a:: with SMTP id d10mr59978615vsf.17.1564783358061;
 Fri, 02 Aug 2019 15:02:38 -0700 (PDT)
Date:   Fri,  2 Aug 2019 15:02:33 -0700
In-Reply-To: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
Message-Id: <cover.1564771000.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [RFC PATCH v2 0/2] trace2: don't overload target directories
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm sending out V2 still as an RFC because I haven't yet had time to
check that directory contention doesn't create problems with multiple
processes sharing the same target directory. I'll be on vacation for the
next couple of weeks, so I wanted to get the new config variable version
out before then.

I noticed that git-config doesn't currently mention target directories,
so I've included a patch to fix that as well.

Changes since V1:
* Adds a new patch that includes a description of trace2's
  target-directory mode in the git-config documentation.
* Moves the file count threshold from a #define constant to a config
  option.
* Renames the threshold override envvar to be consistent with other
  trace2 envvars.
* Simplified the new test case in t0210.

Josh Steadmon (2):
  docs: mention trace2 target-dir mode in git-config
  trace2: don't overload target directories

 Documentation/config/trace2.txt        |  6 ++
 Documentation/technical/api-trace2.txt |  7 +--
 Documentation/trace2-target-values.txt |  4 +-
 t/t0210-trace2-normal.sh               | 19 ++++++
 trace2/tr2_dst.c                       | 86 ++++++++++++++++++++++++++
 trace2/tr2_sysenv.c                    |  3 +
 trace2/tr2_sysenv.h                    |  2 +
 7 files changed, 122 insertions(+), 5 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  65e05a3db5 docs: mention trace2 target-dir mode in git-config
1:  99e4a0fe40 ! 2:  a779e272df trace2: don't overload target directories
    @@ Commit message
     
     
    + ## Documentation/config/trace2.txt ##
    +@@ Documentation/config/trace2.txt: trace2.destinationDebug::
    + 	By default, these errors are suppressed and tracing is
    + 	silently disabled.  May be overridden by the
    + 	`GIT_TRACE2_DST_DEBUG` environment variable.
    ++
    ++trace2.maxFiles::
    ++	Integer.  When writing trace files to a target directory, do not
    ++	write additional traces if we would exceed this many files. Instead,
    ++	write a sentinel file that will block further tracing to this
    ++	directory. Defaults to 0, which disables this check.
    +
      ## t/t0210-trace2-normal.sh ##
     @@ t/t0210-trace2-normal.sh: test_expect_success 'using global config with include' '
      	test_cmp expect actual
      '
      
     +test_expect_success "don't overload target directory" '
    -+	GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT=100 &&
    -+	export GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT &&
    -+	test_when_finished "rm -r trace_target_dir" &&
     +	mkdir trace_target_dir &&
    -+	test_seq $GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT | sed "s#^#trace_target_dir/#" | sort > expected_filenames.txt &&
    -+	xargs touch < expected_filenames.txt &&
    -+	ls trace_target_dir | sed "s#^#trace_target_dir/#" > first_ls_output.txt &&
    -+	test_cmp expected_filenames.txt first_ls_output.txt &&
    -+	GIT_TRACE2="$(pwd)/trace_target_dir" test-tool trace2 001return 0 &&
    -+	echo "trace_target_dir/git-trace2-overload" >> expected_filenames.txt &&
    -+	ls trace_target_dir | sed "s#^#trace_target_dir/#" > second_ls_output.txt &&
    ++	test_when_finished "rm -r trace_target_dir" &&
    ++	(
    ++		GIT_TRACE2_MAX_FILES=5 &&
    ++		export GIT_TRACE2_MAX_FILES &&
    ++		cd trace_target_dir &&
    ++		test_seq $GIT_TRACE2_MAX_FILES >../expected_filenames.txt &&
    ++		xargs touch <../expected_filenames.txt &&
    ++		cd .. &&
    ++		ls trace_target_dir >first_ls_output.txt &&
    ++		test_cmp expected_filenames.txt first_ls_output.txt &&
    ++		GIT_TRACE2="$(pwd)/trace_target_dir" test-tool trace2 001return 0
    ++	) &&
    ++	echo git-trace2-overload >>expected_filenames.txt &&
    ++	ls trace_target_dir >second_ls_output.txt &&
     +	test_cmp expected_filenames.txt second_ls_output.txt
     +'
     +
    @@ trace2/tr2_dst.c
     +#define OVERLOAD_SENTINEL_NAME "git-trace2-overload"
     +
     +/*
    -+ * How many files we can write to a directory before entering overload mode.
    -+ * This can be overridden with the envvar GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT
    ++ * When set to zero, disables directory overload checking. Otherwise, controls
    ++ * how many files we can write to a directory before entering overload mode.
    ++ * This can be overridden via the TR2_SYSENV_MAX_FILES setting.
     + */
    -+#define OVERLOAD_FILE_COUNT 1000000
    ++static int tr2env_max_files = 0;
     +
      static int tr2_dst_want_warning(void)
      {
    @@ trace2/tr2_dst.c: void tr2_dst_trace_disable(struct tr2_dst *dst)
      
     +/*
     + * Check to make sure we're not overloading the target directory with too many
    -+ * files. First check for the presence of a sentinel file, then check file
    -+ * count. If we are overloaded, create the sentinel file if it doesn't already
    -+ * exist.
    ++ * files. First get the threshold (if present) from the config or envvar. If
    ++ * it's zero or unset, disable this check.  Next check for the presence of a
    ++ * sentinel file, then check file count. If we are overloaded, create the
    ++ * sentinel file if it doesn't already exist.
     + *
     + * We expect that some trace processing system is gradually collecting files
     + * from the target directory; after it removes the sentinel file we'll start
    @@ trace2/tr2_dst.c: void tr2_dst_trace_disable(struct tr2_dst *dst)
     + */
     +static int tr2_dst_overloaded(const char *tgt_prefix)
     +{
    -+	int file_count = 0, overload_file_count = 0;
    -+	char *test_threshold_val;
    ++	int file_count = 0, max_files = 0, ret = 0;
    ++	const char *max_files_var;
     +	DIR *dirp;
     +	struct strbuf path = STRBUF_INIT, sentinel_path = STRBUF_INIT;
     +	struct stat statbuf;
    @@ trace2/tr2_dst.c: void tr2_dst_trace_disable(struct tr2_dst *dst)
     +		strbuf_addch(&path, '/');
     +	}
     +
    ++	/* Get the config or envvar and decide if we should continue this check */
    ++	max_files_var = tr2_sysenv_get(TR2_SYSENV_MAX_FILES);
    ++	if (max_files_var && *max_files_var && ((max_files = atoi(max_files_var)) >= 0))
    ++		tr2env_max_files = max_files;
    ++
    ++	if (!tr2env_max_files) {
    ++		ret = 0;
    ++		goto cleanup;
    ++	}
    ++
     +	/* check sentinel */
     +	strbuf_addstr(&sentinel_path, path.buf);
     +	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
     +	if (!stat(sentinel_path.buf, &statbuf)) {
    -+		strbuf_release(&path);
    -+		return 1;
    ++		ret = 1;
    ++		goto cleanup;
     +	}
     +
    -+	/* check if we're overriding the threshold (e.g., for testing) */
    -+	test_threshold_val = getenv("GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT");
    -+	if (test_threshold_val)
    -+		overload_file_count = atoi(test_threshold_val);
    -+	if (overload_file_count <= 0)
    -+		overload_file_count = OVERLOAD_FILE_COUNT;
    -+
    -+
     +	/* check file count */
     +	dirp = opendir(path.buf);
    -+	while (file_count < overload_file_count && dirp && readdir(dirp))
    ++	while (file_count < tr2env_max_files && dirp && readdir(dirp))
     +		file_count++;
     +	if (dirp)
     +		closedir(dirp);
     +
    -+	if (file_count >= overload_file_count) {
    ++	if (file_count >= tr2env_max_files) {
     +		creat(sentinel_path.buf, S_IRUSR | S_IWUSR);
    -+		/* TODO: Write a target-specific message? */
    -+		strbuf_release(&path);
    -+		return 1;
    ++		ret = 1;
    ++		goto cleanup;
     +	}
     +
    ++cleanup:
     +	strbuf_release(&path);
    -+	return 0;
    ++	strbuf_release(&sentinel_path);
    ++	return ret;
     +}
     +
      static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
    @@ trace2/tr2_dst.c: static int tr2_dst_try_auto_path(struct tr2_dst *dst, const ch
      	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
      		if (attempt_count > 0) {
      			strbuf_setlen(&path, base_path_len);
    +
    + ## trace2/tr2_sysenv.c ##
    +@@ trace2/tr2_sysenv.c: static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
    + 				       "trace2.perftarget" },
    + 	[TR2_SYSENV_PERF_BRIEF]    = { "GIT_TRACE2_PERF_BRIEF",
    + 				       "trace2.perfbrief" },
    ++
    ++	[TR2_SYSENV_MAX_FILES]     = { "GIT_TRACE2_MAX_FILES",
    ++				       "trace2.maxfiles" },
    + };
    + /* clang-format on */
    + 
    +
    + ## trace2/tr2_sysenv.h ##
    +@@ trace2/tr2_sysenv.h: enum tr2_sysenv_variable {
    + 	TR2_SYSENV_PERF,
    + 	TR2_SYSENV_PERF_BRIEF,
    + 
    ++	TR2_SYSENV_MAX_FILES,
    ++
    + 	TR2_SYSENV_MUST_BE_LAST
    + };
    + 
--
2.22.0.770.g0f2c4a37fd-goog

