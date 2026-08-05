Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF2D2D949C
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954665; cv=none; b=gvbCo/ANrpcQvQP9kORig1Ow9JD9FHKpmAIPygYAlhfL+GElH4WGlZ2RhQXf7tq2xYdkzV1DLk2sX9f1qell0QlDCPu1kbMPaqr3xP4PGRiCq7KcBCRHQEEsg/H6vERUhd/sfHGlNGGUQ3T4GM7swclCRe6xVPM1gXUZIqaVyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954665; c=relaxed/simple;
	bh=hpVOvcvFZiglOn3tCCYH57Na+3vi7G3nlCAHtY8q/ls=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mkjWxvr+cu+vUjeQ6uD/SJuNqT9YxHfDPoYD8blfTWEcbCcKpnLDmjQJUu/6uNlUFav6y8YFYcu67iDjAW9lG3d5iPQQsYpUYAyVyTuAwayjLTHnCk2z+RzGouVCvhLIjXK9nPOshdtVoOzuH9Qy6n97Zanot5/kuJzwJAjbMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgA3gxKH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgA3gxKH"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceaf8a1265so21165905ad.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 11:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954663; x=1786559463; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n27tQxEkfUxV5TIlrlhLgccyIuyDefSqqWHZyn0vh6A=;
        b=NgA3gxKHTTj2/ptZJWZnhph+V1huoYgFx2PAFEtNaJZko+P4Xtp/4D7dil4pDheENv
         dZXmx732jC3qENgXh6vWdga6EarB5SksO8CVmTGrlUWtA6LH17FUAzBgPDRF358Mv9gQ
         d7aCWV+y9zBrjsF79wlYB+Tfa9A9NCEMgEWLZreKLlnBMmsdltTWECTSxf5Tb3xc8tew
         vJ0ExC7odknhii7SgvBsChshly48xO/+Pq7cbd2uuNEgZ5dRTrdSVA2QuAjnP0bybNdt
         IeIWYvscSwgA7bCPB8XUUZRdOKh3AijCeg0Ra7TwJ8itlO2ttRiTECaPqBB8l/P5MzFx
         Dkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954663; x=1786559463;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n27tQxEkfUxV5TIlrlhLgccyIuyDefSqqWHZyn0vh6A=;
        b=HtFSh/7OpR74OuxPr5AVxNx0jwBEJDOCae1abRxFnMNA3uPNCWsbFMJ6BvQTyUUj4b
         ZeIYN0tqk/qP+e/qoPZ/x20OjmzfiA6G1p9WVEU35IBRoRtMzj+wN5nslNM0MOtmmkGw
         CkhDURKHQcaNfkU7E7ayXG51WPvqQAYMFYoJrHlwE6x/Fn+YgIuFw5QMfSQXHy8nXgrT
         KlYZHK9N4PcC1Lt523hxeWJZ40vopGsOxLhlbOnWJMHtVh+li4LxS0zvVXBRH1uM8o1P
         fpEOZaJyDnf2AFz70+4V5Ne3IY8ZXRIDyFq6Ti6x2BmMb9tXS9BHDXGB6P0l2yhf2nEv
         7/Cw==
X-Gm-Message-State: AOJu0YxLs7/yJeedViIFHpejeQ5p/mcVgKLEUEc/lq3VhXTWprel6TjU
	naTDOIfNHnfBA5cI5QSPVVcHxpuchN2d5vKiYF369u76np2X1bW+0JdXuGKeaQ==
X-Gm-Gg: AR+sD10k7kp4L/nJ3cpJkpXVBsQN99X0sMaj/xJ8SINvCsxxtl394Lck+r9b4oOlsQ7
	GZqNX6KFCXICAPZG3h3Wdh6FwtdzXa4U+Msfn1twLAeEfjJZwZ6GbBTGGpPOqLF85yH4IVDNATN
	QpcLXOlzLTCEYrfn8OBymIOR+NqT81g5NCtphytlzEn9ZiLB4ilsy6XkAGLlOvAm68BoSu1BiyZ
	ycFhUXSZMpSpyxuU8yOW82hYkG41OOjR0Y4NBs7REhvsAJBonYIdGTASKxtFEd4rqCX8eI8Fz/A
	gy8w0VwoJI0i+R1n+6qEKj4NPDzr0gIdTySo8CKHsO7HLu+xoWbHkdzotAVJKeVk2hSM9kPw5ag
	6bf9gH918CAmTsTld2sdiD0nlLZ2Mo3m/eFv10Y1BuLdPy80RufrblctjI8Eb2+3Xw0276zowsK
	5+RnXEpvpzSqfWi7mc0Ed5aqJ9SzgRoz77Jn8exbNZz7cxbZ9ztjzG41A/5koz83BV0A==
X-Received: by 2002:a17:903:2290:b0:2c0:db23:4c4 with SMTP id d9443c01a7336-2d0ca78d505mr95526325ad.16.1785954662877;
        Wed, 05 Aug 2026 11:31:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f93726sm21332055ad.4.2026.08.05.11.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:31:02 -0700 (PDT)
Message-Id: <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:30:49 +0000
Subject: [PATCH v2 00/11] coverity: fix unchecked returns
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

This is the next batch of fixes in response to issues reported by Coverity.

Changes since v1:

 * The last-modified patch is now more careful to clean up a commit slab
   when parsing the commit failed.
 * When the "good" bisect term was read successfully, but not the "bad" one,
   the "good" one is now cleaned up.
 * Instead of detecting failed get_terms() calls indirectly, the return
   value is now checked.
 * Failures when bisect_run() calls dup2() are now handled properly, too.

Johannes Schindelin (11):
  http: die on curl_easy_duphandle failure in get_active_slot
  config: propagate launch_editor() failure in show_editor()
  reftable/block: check deflateInit() return value
  reftable tests: check reftable_table_init_ref_iterator() return
  last-modified: handle repo_parse_commit() failures
  compat/pread: check initial lseek for errors
  transport-helper: check dup() return in get_exporter
  transport-helper: warn when export-marks file cannot be finalized
  bisect: check strbuf_getline_lf return when reading terms
  bisect: check get_terms return at all call sites
  bisect: handle dup() failure when redirecting stdout

 bisect.c                        |  6 +++--
 builtin/bisect.c                | 42 +++++++++++++++++++++++----------
 builtin/config.c                |  5 +++-
 builtin/last-modified.c         |  9 ++++---
 compat/pread.c                  |  2 ++
 http.c                          |  2 ++
 reftable/block.c                |  3 ++-
 t/unit-tests/u-reftable-table.c |  6 +++--
 transport-helper.c              |  6 ++++-
 9 files changed, 59 insertions(+), 22 deletions(-)


base-commit: 55526a18268bbc1ddaf8a6b7850c33d984eac9e9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2179%2Fdscho%2Fcoverity-fixes-unchecked-returns-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2179/dscho/coverity-fixes-unchecked-returns-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2179

Range-diff vs v1:

  1:  e653255de1 =  1:  e653255de1 http: die on curl_easy_duphandle failure in get_active_slot
  2:  0692704d45 =  2:  0692704d45 config: propagate launch_editor() failure in show_editor()
  3:  9bf7e737c7 =  3:  9bf7e737c7 reftable/block: check deflateInit() return value
  4:  711671c3ab =  4:  711671c3ab reftable tests: check reftable_table_init_ref_iterator() return
  5:  f728be4dac !  5:  72a74c76be last-modified: handle repo_parse_commit() failures
     @@ Commit message
          Pointed out by Coverity.
      
          Assisted-by: Claude Opus 4.6
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/last-modified.c ##
     @@ builtin/last-modified.c: static int last_modified_run(struct last_modified *lm)
       		 */
      -		repo_parse_commit(lm->rev.repo, c);
      +		if (repo_parse_commit(lm->rev.repo, c))
     -+			continue;
     ++			goto cleanup;
       
       		while ((n = prio_queue_get(&not_queue))) {
       			struct commit_list *np;
  6:  b31e0326e7 =  6:  f0b1e13979 compat/pread: check initial lseek for errors
  7:  1792042098 =  7:  0facb9e8ca transport-helper: check dup() return in get_exporter
  8:  13ddcce053 =  8:  2b0e4f32fd transport-helper: warn when export-marks file cannot be finalized
  9:  17c382fdf4 !  9:  7f2b963103 bisect: check strbuf_getline_lf return when reading terms
     @@ Commit message
          Pointed out by Coverity.
      
          Assisted-by: Claude Opus 4.6
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## bisect.c ##
     @@ builtin/bisect.c: static int get_terms(struct bisect_terms *terms)
      -	strbuf_getline_lf(&str, fp);
      +	if (strbuf_getline_lf(&str, fp) == EOF) {
      +		res = -1;
     ++		FREE_AND_NULL(terms->term_bad);
      +		goto finish;
      +	}
       	terms->term_good = strbuf_detach(&str, NULL);
 10:  c0827a7947 ! 10:  9a9103096a bisect: check get_terms return at all call sites
     @@ Commit message
          empty term strings, producing nonsensical ref names (refs/bisect/
          with no suffix) and misleading error messages.
      
     -    Add checks at each call site so that a failed get_terms produces a
     -    clear "no terms defined" error, matching the pattern already used
     -    in bisect_terms() at line 512. The check tests the term pointers
     -    rather than the return value because some callers (bisect skip,
     -    legacy bad/good) call set_terms before get_terms, and the
     -    set_terms values should survive a get_terms failure.
     +    Let's not discard the return value, but handle an error with the same
     +    message `bisect_terms()` already uses when reading the terms failed.
      
          Pointed out by Coverity.
      
     +    There is one slight complication here: One caller _needs_ the return
     +    value to indicate an error when the `BISECT_TERMS` file is absent, all
     +    the other call sites are totally okay with a "missing" `BISECT_TERMS`
     +    file. To address that, extend the function signature of `get_terms()` to
     +    indicate which behavior the caller wants.
     +
          Assisted-by: Claude Opus 4.6
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect.c ##
     +@@ builtin/bisect.c: static int bisect_next_check(const struct bisect_terms *terms,
     + 	return decide_next(terms, current_term, !state.nr_good, !state.nr_bad);
     + }
     + 
     +-static int get_terms(struct bisect_terms *terms)
     ++static int get_terms(struct bisect_terms *terms, int file_missing_is_ok)
     + {
     + 	struct strbuf str = STRBUF_INIT;
     + 	FILE *fp = NULL;
     +@@ builtin/bisect.c: static int get_terms(struct bisect_terms *terms)
     + 
     + 	fp = fopen(git_path_bisect_terms(), "r");
     + 	if (!fp) {
     +-		res = -1;
     ++		res = file_missing_is_ok ? 0 : -1;
     + 		goto finish;
     + 	}
     + 
     +@@ builtin/bisect.c: finish:
     + 
     + static int bisect_terms(struct bisect_terms *terms, const char *option)
     + {
     +-	if (get_terms(terms))
     ++	if (get_terms(terms, 0))
     + 		return error(_("no terms defined"));
     + 
     + 	if (!option) {
      @@ builtin/bisect.c: static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
     + 	rev = word_end + strspn(word_end, " \t");
       	*word_end = '\0'; /* NUL-terminate the word */
       
     - 	get_terms(terms);
     -+	if (!terms->term_bad || !terms->term_good)
     +-	get_terms(terms);
     ++	if (get_terms(terms, 1))
      +		return error(_("no terms defined"));
       	if (check_and_set_terms(terms, p))
       		return -1;
       
      @@ builtin/bisect.c: static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
     + 	if (argc)
       		return error(_("'%s' requires 0 arguments"),
       			     "git bisect next");
     - 	get_terms(&terms);
     -+	if (!terms.term_bad || !terms.term_good)
     +-	get_terms(&terms);
     ++	if (get_terms(&terms, 1))
      +		return error(_("no terms defined"));
       	res = bisect_next(&terms, prefix);
       	free_terms(&terms);
       	return res;
      @@ builtin/bisect.c: static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUS
     + 	struct bisect_terms terms = { 0 };
       
       	set_terms(&terms, "bad", "good");
     - 	get_terms(&terms);
     -+	if (!terms.term_bad || !terms.term_good)
     +-	get_terms(&terms);
     ++	if (get_terms(&terms, 1))
      +		return error(_("no terms defined"));
       	res = bisect_skip(&terms, argc, argv);
       	free_terms(&terms);
       	return res;
      @@ builtin/bisect.c: static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix
     + 	int res;
       	struct bisect_terms terms = { 0 };
       
     - 	get_terms(&terms);
     -+	if (!terms.term_bad || !terms.term_good)
     +-	get_terms(&terms);
     ++	if (get_terms(&terms, 1))
      +		return error(_("no terms defined"));
       	res = bisect_visualize(&terms, argc, argv);
       	free_terms(&terms);
       	return res;
      @@ builtin/bisect.c: static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
     + 
       	if (!argc)
       		return error(_("'%s' failed: no command provided."), "git bisect run");
     - 	get_terms(&terms);
     -+	if (!terms.term_bad || !terms.term_good)
     +-	get_terms(&terms);
     ++	if (get_terms(&terms, 1))
      +		return error(_("no terms defined"));
       	res = bisect_run(&terms, argc, argv);
       	free_terms(&terms);
       	return res;
      @@ builtin/bisect.c: int cmd_bisect(int argc,
     + 			usage_with_options(git_bisect_usage, options);
       
       		set_terms(&terms, "bad", "good");
     - 		get_terms(&terms);
     -+		if (!terms.term_bad || !terms.term_good)
     +-		get_terms(&terms);
     ++		if (get_terms(&terms, 1))
      +			return error(_("no terms defined"));
       		if (check_and_set_terms(&terms, argv[0]) ||
       		    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
 11:  2da452e39c ! 11:  829cd82177 bisect: handle dup() failure when redirecting stdout
     @@ Commit message
          leaving the process with stdout still pointing at the temporary file
          for the remainder of the run.
      
     -    Treat a failed dup(1) as a fatal error for this bisect step: close
     -    the temporary file descriptor, report the error via error_errno(),
     -    and break out of the loop so the existing cleanup path handles the
     -    rest, just as on other failure paths in this function.
     +    Treat a failed dup(1) or dup2(..., 1) as a fatal error for this bisect
     +    step: close the temporary file descriptor, report the error via
     +    error_errno(), and break out of the loop so the existing cleanup path
     +    handles the rest, just as on other failure paths in this function.
      
          Reported by Coverity as CID 1508242 ("Improper use of negative
          value").
      
          Assisted-by: Opus 4.7
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect.c ##
     @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, co
       
       		fflush(stdout);
       		saved_stdout = dup(1);
     -+		if (saved_stdout < 0) {
     +-		dup2(temporary_stdout_fd, 1);
     ++		if (saved_stdout < 0 ||
     ++		    dup2(temporary_stdout_fd, 1) < 0) {
      +			res = error_errno(_("could not duplicate stdout"));
      +			close(temporary_stdout_fd);
      +			break;
      +		}
     - 		dup2(temporary_stdout_fd, 1);
       
       		res = bisect_state(terms, 1, &new_state);
     + 

-- 
gitgitgadget
