Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6C130E2E
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983572; cv=none; b=VdZzsVgs59M3L6LTSz7AjcUkOdsT7TxlaKwFXnzibDRwLOzuDhJDiTvyVX+gg34hQvCKkBiZGCDo788Qa5EiZjscV6bWwysUQj4fTpv3dvEWYws480Euq40jeDSiV3A7OBpX7ItQ5dcszveR5TXNkOw53KRqfM6oJ0hoGuC395s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983572; c=relaxed/simple;
	bh=eEcYX1Fz6N4pRXW2AwRu9s4s9Smv5AO7cGlFo6FKHVY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eTFWjtEzgkOsqfQu/M1+IjK+hjfNm5VGGSJ9mbPiQinIqwU3ObxWUskuHFqgcR16WJh7xgfwTEbFxUovAwpvU82iM83rM6dy1uySCY0ArCvPwxgrMfxt1VzqpghYEtChHuZmnjxRa+sA3AJmo0TyVW8ZMKrq3A+C2Pn8NFdjl6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxFvPA/1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxFvPA/1"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso1907499f8f.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983568; x=1709588368; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFiSwoZWOPMNC+DmJUBra5eUYe1OJb6XtOvM41mD6+U=;
        b=kxFvPA/1sVaXuq617Z501A+PO/ArDOnR6EdtDKNPJOPM3c2FAg4H/rTaAyBpvJoTgL
         y9IZIF/HlEKXTzBFwLfEV5VX7D8DRn0jNuY/rOTRqmpNUD4sJfo1Yz4yiOvuy2C5Ru3X
         fhHPDwnp+MlWRIW6Bq/HKUijiKaNo++Z5V3bhlJ4RZWiGUckDQn/RwFatwhtyBs3pUv5
         fdr8GEFFlxSWF/MGIPAQi/uyRHjl7wAsxeXyiIxk1+S+haw6Dx/SPTDxclmphzmb1Eoi
         ml0ITUGUK2D7ZoM/F14CQw9/OezVrB/uyhCAf8o+hcXDX9VeAeq3+Ivre6/PrPxhRHee
         16pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983568; x=1709588368;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFiSwoZWOPMNC+DmJUBra5eUYe1OJb6XtOvM41mD6+U=;
        b=KDaTiiHCkh4aUKgHgN1NLCyLV4O8ry8RO2Vs8sy/6KkHVKxz5BkOV8GZ1YQxWlMK4b
         ylhbCOt2zBkxEfXRL/Wwp2i38tiXM3IsHZILoDWo3hALWuwBN6vcw33zu0B2BPcwbCl2
         OEIGqkoLUIhhURhqgJ/54omZxE+4l0+RJ3pDwECqyqOmsGB5JeRMs0chNdjIYMNW3RFH
         qW/n5TMu1AsOM1mmk0EE49uPEo1wJhJMlmiiUdxkjbGBj+b0xOI35OOj0rdGy9hzyJtV
         3PU2tzQD+7YdLFTk4PA9DwVYbTizij4kHn0ttoTNGB8ViYL7QO4BWnDExfqgO8FuOKM7
         i87Q==
X-Gm-Message-State: AOJu0Yx754Ztegf1VVaqRd5dqhT30IUqS4bkwIENS+mIdVJAMa2Ll7pA
	KTEGN6UtE9uf8pSiC/nClT0cSHMYcjZ5gVXuv4MpEh8AEya2oFCIt5lcPWjB
X-Google-Smtp-Source: AGHT+IEykffrTmX6h/Qpi9IfPdzKHBCG2yF05CCUoILQ0UNue2msaNvLfX569zPsoRUbFgUCGOvTxw==
X-Received: by 2002:adf:e652:0:b0:33d:d82e:85c7 with SMTP id b18-20020adfe652000000b0033dd82e85c7mr2604145wrn.47.1708983567387;
        Mon, 26 Feb 2024 13:39:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4d06000000b0033d873f08d4sm9297868wrt.98.2024.02.26.13.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:26 -0800 (PST)
Message-ID: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:11 +0000
Subject: [PATCH v3 00/14] FSMonitor edge cases on case-insensitive file systems
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
    Jeff Hostetler <git@jeffhostetler.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>

Here is version 3. I think I have addressed the remaining comments.

I cleaned up the test code to use the test_expect_failure at the beginning
and squashed in the test_expect_success version of tests into the final
commit in the series.

I moved the invalidate_ce_fsm() commit earlier in the series, so that the
final commit actually uses all of the up-to-this-point changes to fix the
problem.

I converted a few "should not happens" to BUG()s.

Thanks to everyone for their time and attention reviewing this. Jeff

Jeff Hostetler (14):
  name-hash: add index_dir_find()
  t7527: add case-insensitve test for FSMonitor
  fsmonitor: refactor refresh callback on directory events
  fsmonitor: clarify handling of directory events in callback helper
  fsmonitor: refactor refresh callback for non-directory events
  dir: create untracked_cache_invalidate_trimmed_path()
  fsmonitor: refactor untracked-cache invalidation
  fsmonitor: move untracked-cache invalidation into helper functions
  fsmonitor: return invalidated cache-entry count on directory event
  fsmonitor: remove custom loop from non-directory path handler
  fsmonitor: return invalided cache-entry count on non-directory event
  fsmonitor: trace the new invalidated cache-entry count
  fsmonitor: refactor bit invalidation in refresh callback
  fsmonitor: support case-insensitive events

 dir.c                        |  20 +++
 dir.h                        |   7 +
 fsmonitor.c                  | 312 +++++++++++++++++++++++++++++------
 name-hash.c                  |   9 +-
 name-hash.h                  |   7 +-
 t/t7527-builtin-fsmonitor.sh | 223 +++++++++++++++++++++++++
 6 files changed, 522 insertions(+), 56 deletions(-)


base-commit: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1662%2Fjeffhostetler%2Ffsmonitor-ignore-case-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1662/jeffhostetler/fsmonitor-ignore-case-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1662

Range-diff vs v2:

  1:  03b07d9c25e !  1:  64ae07aaeaa name-hash: add index_dir_find()
     @@ Metadata
       ## Commit message ##
          name-hash: add index_dir_find()
      
     -    Replace the index_dir_exists() function with index_dir_find() and
     -    change the API to take an optional strbuf to return the canonical
     -    spelling of the matched directory prefix.
     +    index_dir_exists() returns a boolean to indicate if there is a
     +    case-insensitive match in the directory name-hash, but does not
     +    provide the caller with the exact spelling of that match.
      
     -    Create an index_dir_exists() wrapper macro for existing callers.
     +    Create index_dir_find() to do the case-insensitive search *and*
     +    optionally return the spelling of the matched directory prefix in a
     +    provided strbuf.
      
     -    The existing index_dir_exists() returns a boolean to indicate if
     -    there is a case-insensitive match in the directory name-hash, but
     -    it doesn't tell the caller the exact spelling of that match.
     -
     -    The new version also copies the matched spelling to a provided strbuf.
     -    This lets the caller, for example, then call index_name_pos() with the
     -    correct case to search the cache-entry array for the real insertion
     -    position.
     +    To avoid code duplication, convert index_dir_exists() to be a trivial
     +    wrapper around the new index_dir_find().
      
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
  2:  7778cee1c10 !  2:  beeebf55963 t7527: add case-insensitve test for FSMonitor
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'split-index and FSMonitor wor
      +#
      +# The setup is a little contrived.
      +#
     -+test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
     ++test_expect_failure CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
      +	test_when_finished "stop_daemon_delete_repo subdir_case_wrong" &&
      +
      +	git init subdir_case_wrong &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'split-index and FSMonitor wor
      +	grep -q " M AAA" "$PWD/subdir_case_wrong.out" &&
      +	grep -q " M zzz" "$PWD/subdir_case_wrong.out" &&
      +
     -+	# However, with the fsmonitor client bug, the "(pos -3)" causes
     -+	# the client to not update the bit and never rescan the file
     -+	# and therefore not report it as dirty.
     -+	! grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
     ++	# Expect Breakage: with the case confusion, the "(pos -3)" causes
     ++	# the client to not clear the CE_FSMONITOR_VALID bit and therefore
     ++	# status will not rescan the file and therefore not report it as dirty.
     ++	grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
      +'
      +
     -+test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
     ++test_expect_failure CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
      +	test_when_finished "stop_daemon_delete_repo file_case_wrong" &&
      +
      +	git init file_case_wrong &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'split-index and FSMonitor wor
      +	grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try3.log" &&
      +	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try3.log" &&
      +
     -+	# Status should say these files are modified, but with the case
     -+	# bug, the "pos -3" cause the client to not update the FSM bit
     -+	# and never cause the file to be rescanned and therefore to not
     -+	# report it dirty.
     -+	! grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
     -+	! grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
     ++	# Expect Breakage: with the case confusion, the "(pos-3)" and
     ++	# "(pos -9)" causes the client to not clear the CE_FSMONITOR_VALID
     ++	# bit and therefore status will not rescan the files and therefore
     ++	# not report them as dirty.
     ++	grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
     ++	grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
      +'
      +
       test_done
  3:  dad079ade7f <  -:  ----------- t7527: temporarily disable case-insensitive tests
  4:  5516670e30e =  3:  518cb4dd5df fsmonitor: refactor refresh callback on directory events
  5:  c04fd4eae94 =  4:  9a4b5bf990b fsmonitor: clarify handling of directory events in callback helper
  6:  7ee6ca1aefd !  5:  348b9b0c94e fsmonitor: refactor refresh callback for non-directory events
     @@ Metadata
       ## Commit message ##
          fsmonitor: refactor refresh callback for non-directory events
      
     -    Move the code handle unqualified FSEvents (without a trailing slash)
     -    into a helper function.
     +    Move the code that handles unqualified FSEvents (without a trailing
     +    slash) into a helper function.
      
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
  7:  99c0d3e0742 !  6:  ed735e3f1cb dir: create untracked_cache_invalidate_trimmed_path()
     @@ dir.c: void untracked_cache_invalidate_path(struct index_state *istate,
      +	size_t len = strlen(path);
      +
      +	if (!len)
     -+		return; /* should not happen */
     ++		BUG("untracked_cache_invalidate_trimmed_path given zero length path");
      +
      +	if (path[len - 1] != '/') {
      +		untracked_cache_invalidate_path(istate, path, safe_path);
  8:  f2d6765d84f =  7:  2a43c6cbe0d fsmonitor: refactor untracked-cache invalidation
  9:  af6f57ab3e6 !  8:  6e87ea6deaf fsmonitor: move untracked invalidation into helper functions
     @@ Metadata
      Author: Jeff Hostetler <jeffhostetler@github.com>
      
       ## Commit message ##
     -    fsmonitor: move untracked invalidation into helper functions
     +    fsmonitor: move untracked-cache invalidation into helper functions
      
     -    Move the call to invalidate the untracked cache for the FSEvent
     +    Move the call to invalidate the untracked-cache for the FSEvent
          pathname into the two helper functions.
      
          In a later commit in this series, we will call these helpers
          from other contexts and it safer to include the UC invalidation
     -    in the helper than to remember to also add it to each helper
     +    in the helpers than to remember to also add it to each helper
          call-site.
      
     +    This has the side-effect of invalidating the UC *before* we
     +    invalidate the ce_flags in the cache-entry.  These activities
     +    are independent and do not affect each other.  Also, by doing
     +    the UC work first, we can avoid worrying about "early returns"
     +    or the need for the usual "goto the end" in each of the
     +    handler functions.
     +
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## fsmonitor.c ##
 10:  623c6f06e21 =  9:  5fea8b9476e fsmonitor: return invalidated cache-entry count on directory event
 11:  1853f77d333 = 10:  3fa7536cf80 fsmonitor: remove custom loop from non-directory path handler
 12:  f77d68c78ad ! 11:  53f73c1515d fsmonitor: return invalided cache-entry count on non-directory event
     @@ Metadata
       ## Commit message ##
          fsmonitor: return invalided cache-entry count on non-directory event
      
     -    Teah the refresh callback helper function for unqualified FSEvents
     +    Teach the refresh callback helper function for unqualified FSEvents
          (pathnames without a trailing slash) to return the number of
          cache-entries that were invalided in response to the event.
      
 13:  58b36673e15 = 12:  0148319aea5 fsmonitor: trace the new invalidated cache-entry count
 15:  3a20065dbf8 ! 13:  04867eccfcd fsmonitor: refactor bit invalidation in refresh callback
     @@ Commit message
          it to help debug edge cases.
      
          This is similar to the existing `mark_fsmonitor_invalid()` function,
     -    but we don't need the extra stuff that it does.
     +    but it also does untracked-cache invalidation and we've already
     +    handled that in the refresh-callback handlers, so but we don't need
     +    to repeat that.
      
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## fsmonitor.c ##
      @@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
     - static size_t handle_path_with_trailing_slash(
     - 	struct index_state *istate, const char *name, int pos);
     + 	return result;
     + }
       
      +/*
      + * Invalidate the FSM bit on this CE.  This is like mark_fsmonitor_invalid()
     -+ * but we've already handled the untracked-cache and I want a different
     -+ * trace message.
     ++ * but we've already handled the untracked-cache, so let's not repeat that
     ++ * work.  This also lets us have a different trace message so that we can
     ++ * see everything that was done as part of the refresh-callback.
      + */
      +static void invalidate_ce_fsm(struct cache_entry *ce)
      +{
     -+	if (ce->ce_flags & CE_FSMONITOR_VALID)
     ++	if (ce->ce_flags & CE_FSMONITOR_VALID) {
      +		trace_printf_key(&trace_fsmonitor,
      +				 "fsmonitor_refresh_callback INV: '%s'",
      +				 ce->name);
     -+	ce->ce_flags &= ~CE_FSMONITOR_VALID;
     ++		ce->ce_flags &= ~CE_FSMONITOR_VALID;
     ++	}
      +}
      +
     - /*
     -  * Use the name-hash to do a case-insensitive cache-entry lookup with
     -  * the pathname and invalidate the cache-entry.
     -@@ fsmonitor.c: static size_t handle_using_name_hash_icase(
     - 
     - 	untracked_cache_invalidate_trimmed_path(istate, ce->name, 0);
     - 
     --	ce->ce_flags &= ~CE_FSMONITOR_VALID;
     -+	invalidate_ce_fsm(ce);
     - 	return 1;
     - }
     + static size_t handle_path_with_trailing_slash(
     + 	struct index_state *istate, const char *name, int pos);
       
      @@ fsmonitor.c: static size_t handle_path_without_trailing_slash(
       		 * cache-entry with the same pathname, nor for a cone
 14:  288f3f4e54e ! 14:  ec036c04d1b fsmonitor: support case-insensitive events
     @@ Commit message
          Update event handling to optionally use the name-hash and dir-name-hash
          if necessary.
      
     +    Also update t7527 to convert the "test_expect_failure" to "_success"
     +    now that we have fixed the bug.
     +
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## fsmonitor.c ##
     @@ fsmonitor.c
       #include "run-command.h"
       #include "strbuf.h"
       #include "trace2.h"
     -@@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
     +@@ fsmonitor.c: static void invalidate_ce_fsm(struct cache_entry *ce)
       static size_t handle_path_with_trailing_slash(
       	struct index_state *istate, const char *name, int pos);
       
     @@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
      +			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
      +			 name, ce->name);
      +
     ++	/*
     ++	 * NEEDSWORK: We used the name-hash to find the correct
     ++	 * case-spelling of the pathname in the cache-entry[], so
     ++	 * technically this is a tracked file or a sparse-directory.
     ++	 * It should not have any entries in the untracked-cache, so
     ++	 * we should not need to use the case-corrected spelling to
     ++	 * invalidate the the untracked-cache.  So we may not need to
     ++	 * do this.  For now, I'm going to be conservative and always
     ++	 * do it; we can revisit this later.
     ++	 */
      +	untracked_cache_invalidate_trimmed_path(istate, ce->name, 0);
      +
     -+	ce->ce_flags &= ~CE_FSMONITOR_VALID;
     ++	invalidate_ce_fsm(ce);
      +	return 1;
      +}
      +
     @@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
      +		 * ICASE match, so we should never get an exact match,
      +		 * so we could promote this to a BUG() here if we
      +		 * wanted to.  It doesn't hurt anything to just return
     -+		 * 0 and go on becaus we should never get here.  Or we
     ++		 * 0 and go on because we should never get here.  Or we
      +		 * could just get rid of the memcmp() and this "if"
      +		 * clause completely.
      +		 */
     -+		return 0; /* should not happen */
     ++		BUG("handle_using_dir_name_hash_icase(%s) did not exact match",
     ++		    name);
      +	}
      +
      +	trace_printf_key(&trace_fsmonitor,
     @@ fsmonitor.c: static void fsmonitor_refresh_callback(struct index_state *istate,
       	if (nr_in_cone)
       		trace_printf_key(&trace_fsmonitor,
       				 "fsmonitor_refresh_callback CNT: %d",
     +
     + ## t/t7527-builtin-fsmonitor.sh ##
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'split-index and FSMonitor work well together' '
     + #
     + # The setup is a little contrived.
     + #
     +-test_expect_failure CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
     ++test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
     + 	test_when_finished "stop_daemon_delete_repo subdir_case_wrong" &&
     + 
     + 	git init subdir_case_wrong &&
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_failure CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
     + 
     + 	grep -q "dir1/DIR2/dir3/file3.*pos -3" "$PWD/subdir_case_wrong.log1" &&
     + 
     ++	# Verify that we get a mapping event to correct the case.
     ++	grep -q "MAP:.*dir1/DIR2/dir3/file3.*dir1/dir2/dir3/file3" \
     ++		"$PWD/subdir_case_wrong.log1" &&
     ++
     + 	# The refresh-callbacks should have caused "git status" to clear
     + 	# the CE_FSMONITOR_VALID bit on each of those files and caused
     + 	# the worktree scan to visit them and mark them as modified.
     + 	grep -q " M AAA" "$PWD/subdir_case_wrong.out" &&
     + 	grep -q " M zzz" "$PWD/subdir_case_wrong.out" &&
     +-
     +-	# Expect Breakage: with the case confusion, the "(pos -3)" causes
     +-	# the client to not clear the CE_FSMONITOR_VALID bit and therefore
     +-	# status will not rescan the file and therefore not report it as dirty.
     + 	grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
     + '
     + 
     +-test_expect_failure CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
     ++test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
     + 	test_when_finished "stop_daemon_delete_repo file_case_wrong" &&
     + 
     + 	git init file_case_wrong &&
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_failure CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
     + 	GIT_TRACE_FSMONITOR="$PWD/file_case_wrong-try3.log" \
     + 		git -C file_case_wrong --no-optional-locks status --short \
     + 			>"$PWD/file_case_wrong-try3.out" &&
     ++
     ++	# Verify that we get a mapping event to correct the case.
     ++	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir3/FILE-3-A.*dir1/dir2/dir3/file-3-a" \
     ++		"$PWD/file_case_wrong-try3.log" &&
     ++	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir4/file-4-a.*dir1/dir2/dir4/FILE-4-A" \
     ++		"$PWD/file_case_wrong-try3.log" &&
     ++
     + 	# FSEvents are in observed case.
     + 	grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try3.log" &&
     + 	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try3.log" &&
     + 
     +-	# Expect Breakage: with the case confusion, the "(pos-3)" and
     +-	# "(pos -9)" causes the client to not clear the CE_FSMONITOR_VALID
     +-	# bit and therefore status will not rescan the files and therefore
     +-	# not report them as dirty.
     ++	# The refresh-callbacks should have caused "git status" to clear
     ++	# the CE_FSMONITOR_VALID bit on each of those files and caused
     ++	# the worktree scan to visit them and mark them as modified.
     + 	grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
     + 	grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
     + '
 16:  467d3c1fe2c <  -:  ----------- t7527: update case-insenstive fsmonitor test

-- 
gitgitgadget
