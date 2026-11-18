Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028881;
	b=enW/SjT7FPdQRtP6Pla+qVclZM5o6/TfoQd+fHjTAp7G7kjZfCHbYoqstEsWFzZPq0gU
	 ZeHpjGdJkFerLWd2liESC71FgGjDJwnw1pJdXiBtp+GDiw9J6yxyRiLtmAyrVLNrTRG9x
	 9zNJvm5VTUsYcFfIKq1ShtnAgxkN0tepH0IMkdRSLH9q9GWNQSvZ0/nDOKPE8CIRWk2k3
	 UQrNTB5afWPJeJKw6SI5Wyvznz7aEIMzKTbpIyvf4D2IyayFeHCTUddK9yACf0WFeXjP9
	 lhLpP7SB8YK6p4S/5EhlfzVJBLa2kINYUOxkarQMU+pXJJF4FrbgKecpuYFe4aIwS6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r2lXbNbg1s3Tr+C5sMkg5/FXlXRbInyNxEb7a6rAgCU=;
	b=PQdqTCyXxfOuB5GH5pfp40pnk9bnicF5zzH6k7PR9zU1ofz4jR+lo5ObcGuH75i0pMm5
	 Z8rQro3izt6o6r6+dshYQPOJCIPpAS1gnDScHU9I/kPxJo0C9Vjmai3KitCbm5J1CPRRz
	 R27mx5r0NsX2N9xoLismXDXcA14BxP6Nq1qFZy0oQ4TkrvbDPDnGEidy26Ia5mfTF9bt4
	 DU22ONMVttCWq2ErXleejxgy/xGMffZGQnibM1FYAvQzQNLhBJtPOKtA9M6pWwo/JpCna
	 gIPyOxB+SK6uNsayfUgd7pw+b8bvL7djnRPwuDL0zFmLoPgrq0JxjmDEBxZQAHvf+RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=raueeLpp;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94FC60A260A
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 19:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B94FC60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=raueeLpp
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-380b40312e2so3792774eec.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 11:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795028880; x=1795633680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r2lXbNbg1s3Tr+C5sMkg5/FXlXRbInyNxEb7a6rAgCU=;
        b=raueeLppPvAVILI5bJs4jejmF1VEP+ISJJOkCQh8Jov9FE/2xHVwAttqU5dhbx8vyt
         3yXrfFgmWB8h87ER+V2lr5Fe1L/Hkay6DUZkKeo2aK7EWm9ADwqSLkE4lS+8MApWVD95
         tvpD3yDKMAlh5GhLGkIUA39VVDMXqFY4KN/U7MjcbvdswE6ICotjrQCxnaqvsWCRj8Oi
         DI244uUlhVozr6KkorM6r0n1slUOJEfVilo2pu9Vw5rcT01gcvQH3qf/RInXS0u6ReKy
         MnvovhtkJpBbqg50zlkEYYiXv6V1aL/LmNs5UCoojeSTU37D8dlCkQmAW/2XC0+6wfkU
         2coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795028880; x=1795633680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r2lXbNbg1s3Tr+C5sMkg5/FXlXRbInyNxEb7a6rAgCU=;
        b=dSf9iTV4axs+4OBz7EjLRdiVjt5eOU6n4oGCOep6REu77dzqUaUet+waPRJMp4wF0g
         PYxEhUeyzid32wLa3bSwB7jBsXi62Q/3DmZFsUc+E3lU26yNL8fFD0OnLYvCn4krY3Rr
         YkX8lJ1pwF6P6DzzLowifc8mqC1Q/ANXgBECwuKPAGzMR+0uwJ7PNZdQjH7zvi2DLhXH
         UORnQ+urchGPhelr23jN3CNnxvqid+VJQREzPcXMnY2PJ7yZ6Km1Ie1/aaqLTmZbSetU
         p4ifrgcBD+WPauIv4GcxDlJCO6QV65ciK3PsJS4DHzICDxvOflhS12GAvlCM7M1q4l6F
         8DbQ==
X-Gm-Message-State: APuU4Z8qnsT9RzcOhm/hhscNle3N/BD/HnraVoVQrR596ClYpGTX5WF0
	mx2pyKohE+SKOb3cd5ua/9kUZKTUx5F6gU/XP1HRGBk4xbBxjJHA1YHs2HV2KA==
X-Gm-Gg: AZFdTZcfllFfqtETG30UZ8PYLT0B396+fjgEEUTl4jUt0+AxxdIiCZ44dj/eyBhApXB
	jWRFztbzUBJJv60y8IDbdSLB2Bm93egLeKCE7iXKfZ0x07JYUKcv71tlYpTRG7t7wKCQNaOB4Ok
	QjJQGDbv9iu5E/Ym7ZCoTPJwzPnAgXbQzUX7JWKR4VkSZ7aVYzMEhfjIQZH/xAxV/sMehDbvPLv
	vXR8uf85bwj8MAU5tlX7TaMsElh4sQpKGmdx9D9DdawiByd9NEBIGioDkBm4icJTS0nsgOy9Ifb
	h/9GjVkSl4D4sGTLmK6y1qyOJCvTK6yBuSU0TeW5h5BqSUEBDu0QsoPMi+XTIv/iAwDQM/ECBbi
	ORnpiaNLdG0Iq88Jdp0iH6mYr27WubK0gvRKVoGExQGAUgmEKClfxBt+7xWJTAfpVxKRP5AjPbJ
	KLi8thkt5yccwJGR57PaRFsyTQOm/bm2YVEmbPcN1sbiXsxvRDROkWx3X2uM+5N8XsRxi3tDyDb
	mYVGgDvkd5nhPWQTKnbBal+2EeOU/OBVekLE09V6oE3pHVh7bT+5rb3ynQUyo31t8dfLFBa9wWU
	knw1vvnbPsooFTftUazlqqo6PINixYes7/Bcpm4bjcxvPuyiaA==
X-Received: by 2002:a05:7301:3033:b0:36c:bf78:967e with SMTP id 5a478bee46e88-3827f991191mr3162394eec.10.1795028879425;
        Wed, 18 Nov 2026 11:07:59 -0800 (PST)
Received: from HP-V15.xu.edu.in ([125.22.10.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a680032dsm9065155eec.10.2026.11.18.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:07:58 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	mail@thomasbachem.com,
	ps@pks.im,
	ttaylorr@openai.com,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH v4 0/2] maintenance: improve lock acquisition failure handling
Date: Wed, 18 Nov 2026 19:07:33 +0000
Message-ID: <20261118190735.3928-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104173422.20725-1-pushkarkumarsingh1970@gmail.com>
References: <20261104173422.20725-1-pushkarkumarsingh1970@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This series improves how "git maintenance" handles failures to
acquire the maintenance lock.

The first patch makes lock acquisition failures behave differently
depending on how maintenance was invoked. Manual invocations report
an error and return a non-zero exit status, while automatic and
scheduled invocations skip non-fatally. It also prevents the prefetch
task from triggering nested automatic maintenance through its child
fetch process.

The second patch adds Trace2 instrumentation for automatic and
scheduled maintenance skips, making it easier to identify repeated
lock acquisition failures.

Changes in v4:
- Keep scheduled maintenance non-fatal when another process holds
  the maintenance lock.
- Prevent nested automatic maintenance in the prefetch task by
  passing --no-auto-maintenance to child fetch processes.
- Extend Trace2 instrumentation to cover scheduled maintenance skips.
- Add regression tests for scheduled runs and nested prefetch
  maintenance.

Thanks,
Pushkar

Pushkar Singh (2):
  maintenance: handle lock acquisition failures correctly
  maintenance: trace lock acquisition failures

 builtin/gc.c           | 27 +++++++++++++----
 t/t7900-maintenance.sh | 69 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 88 insertions(+), 8 deletions(-)

Range-diff against v3:
1:  ab33f1b432 ! 1:  dfebf3bea5 maintenance: report lock acquisition failures
    @@ Metadata
     Author: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
     
      ## Commit message ##
    -    maintenance: report lock acquisition failures
    +    maintenance: handle lock acquisition failures correctly
     
    -    When git maintenance run fails to acquire the maintenance
    -    lock, report the failure instead of silently succeeding.
    +    When git maintenance run fails to acquire objects/maintenance.lock,
    +    the failure should be handled appropriately depending on the invocation:
     
    -    For automatic invocations, print a warning while preserving
    -    the successful exit status. For manual invocations, report
    -    the failure as an error and return a non-zero exit status.
    +    - Explicit manual maintenance should report an error and return a
    +      non-zero exit status, or suppress the diagnostic when --quiet is set.
    +    - Automatic maintenance (--auto) and scheduled maintenance (--schedule)
    +      should remain non-fatal and exit successfully (0) to avoid failing
    +      routine background runs when another maintenance process holds the lock.
    +    - For automatic maintenance, print a warning diagnostic unless --quiet
    +      is set, while scheduled maintenance remains silent.
     
    -    Respect the --quiet option when reporting the failure.
    +    Use unable_to_lock_message() to format error and warning diagnostics,
    +    and check opts->schedule to distinguish scheduled invocations from
    +    manual runs.
    +
    +    In addition, pass --no-auto-maintenance to child fetch invocations in
    +    fetch_remote() to prevent the prefetch task from triggering nested
    +    automatic maintenance while the parent process holds the lock.
    +
    +    Add tests in t/t7900-maintenance.sh covering manual, quiet, automatic,
    +    and scheduled lock acquisition handling, as well as prefetch child fetch
    +    arguments.
     
         Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
     
      ## builtin/gc.c ##
    +@@ builtin/gc.c: static int fetch_remote(struct remote *remote, void *cbdata)
    + 	strvec_pushl(&child.args, "fetch", remote->name,
    + 		     "--prefetch", "--prune", "--no-tags",
    + 		     "--no-write-fetch-head", "--recurse-submodules=no",
    ++		     "--no-auto-maintenance",
    + 		     NULL);
    + 
    + 	if (opts->quiet)
     @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts,
      	enum auto_gc_hook_result auto_gc_hook_result = AUTO_GC_HOOK_UNDECIDED;
      
      	if (repo_hold_lock_file_for_update(r, &lk, lock_path, LOCK_NO_DEREF) < 0) {
    -+	    int err = errno;
    ++		int err = errno;
    ++
      		/*
      		 * Another maintenance command is running.
      		 *
    -@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts,
    - 		 * recursive process stack. Do not report an error in
    - 		 * that case.
    + 		 * If --auto was provided, then it is likely due to a
    +-		 * recursive process stack. Do not report an error in
    +-		 * that case.
    ++		 * recursive process stack. If --schedule was provided,
    ++		 * another scheduled run is already running. Do not
    ++		 * report an error in either case.
      		 */
     -		if (!opts->auto_flag && !opts->quiet)
     -			warning(_("lock file '%s' exists, skipping maintenance"),
     -				lock_path);
     +		if (!opts->quiet) {
    -+		    struct strbuf buf = STRBUF_INIT;
    ++			struct strbuf buf = STRBUF_INIT;
    ++
     +			unable_to_lock_message(lock_path, err, &buf);
     +			if (opts->auto_flag)
     +				warning("%s", buf.buf);
    -+			else
    ++			else if (!opts->schedule)
     +				error("%s", buf.buf);
     +			strbuf_release(&buf);
     +		}
      		free(lock_path);
     -		return 0;
    -+		return opts->auto_flag ? 0 : -1;
    ++		return (opts->auto_flag || opts->schedule) ? 0 : -1;
      	}
      	free(lock_path);
      
     
      ## t/t7900-maintenance.sh ##
    +@@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
    + 	test_commit -C clone1 one &&
    + 	test_commit -C clone2 two &&
    + 	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
    +-	fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
    ++	fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --no-auto-maintenance --quiet" &&
    + 	test_subcommand git fetch remote1 $fetchargs <run-prefetch.txt &&
    + 	test_subcommand git fetch remote2 $fetchargs <run-prefetch.txt &&
    ++	test_subcommand ! git maintenance run --auto <run-prefetch.txt &&
    + 	git for-each-ref refs/remotes >actual &&
    + 	test_must_be_empty actual &&
    + 	git log prefetch/remotes/remote1/one &&
    +@@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
    + 	git config remote.remote1.skipFetchAll true &&
    + 	GIT_TRACE2_EVENT="$(pwd)/skip-remote1.txt" git maintenance run --task=prefetch 2>/dev/null &&
    + 	test_subcommand ! git fetch remote1 $fetchargs <skip-remote1.txt &&
    +-	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
    ++	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt &&
    ++
    ++	git maintenance run --task=prefetch --no-quiet 2>err &&
    ++	test_must_be_empty err
    + '
    + 
    + test_expect_success 'loose-objects task' '
     @@ t/t7900-maintenance.sh: test_expect_success 'loose-objects task' '
      	test_cmp packs-between packs-after
      '
    @@ t/t7900-maintenance.sh: test_expect_success 'loose-objects task' '
     +	test_must_be_empty err &&
     +	test_path_is_file .git/objects/maintenance.lock
     +'
    ++
    ++test_expect_success 'scheduled maintenance skips with existing lock' '
    ++	test_when_finished "rm -f err .git/objects/maintenance.lock" &&
    ++	: >.git/objects/maintenance.lock &&
    ++	git maintenance run --schedule=hourly 2>err &&
    ++	test_must_be_empty err &&
    ++	test_path_is_file .git/objects/maintenance.lock
    ++'
     +
      test_expect_success 'maintenance.loose-objects.auto' '
      	git repack -adk &&
2:  b451682115 ! 2:  a1491d0123 maintenance: trace lock acquisition failures
    @@ Metadata
      ## Commit message ##
         maintenance: trace lock acquisition failures
     
    -    When git maintenance run --auto fails to acquire the
    -    maintenance lock, emit a Trace2 data event describing
    -    the reason for the failure.
    +    When git maintenance run fails to acquire the maintenance lock during
    +    automatic or scheduled execution, it skips running maintenance tasks
    +    non-fatally and exits successfully.
     
    -    This makes it easier to identify cases where automatic
    -    maintenance is repeatedly skipped.
    +    Emit a Trace2 data event with category "maintenance" and key
    +    "lock/skip" describing the OS error via strerror(err) when automatic or
    +    scheduled maintenance skips due to a lock acquisition failure. This
    +    makes it easier to identify situations where automatic or scheduled
    +    background maintenance is repeatedly skipped due to lock contention or
    +    stale locks, while preserving standard non-zero exit and error reporting
    +    for manual invocations.
    +
    +    Add tests in t/t7900-maintenance.sh to verify that automatic and
    +    scheduled maintenance emit the expected Trace2 event upon encountering
    +    an existing lock, and that explicit manual maintenance does not emit
    +    this skip event.
     
         Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
     
      ## builtin/gc.c ##
     @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts,
    - 		 * recursive process stack. Do not report an error in
    - 		 * that case.
    + 		 * another scheduled run is already running. Do not
    + 		 * report an error in either case.
      		 */
    -+		if (opts->auto_flag)
    ++		if (opts->auto_flag || opts->schedule)
     +			trace2_data_string("maintenance", r, "lock/skip",
    -+			    strerror(err));
    ++					   strerror(err));
     +
      		if (!opts->quiet) {
    - 		    struct strbuf buf = STRBUF_INIT;
    - 			unable_to_lock_message(lock_path, err, &buf);
    + 			struct strbuf buf = STRBUF_INIT;
    + 
     
      ## t/t7900-maintenance.sh ##
    -@@ t/t7900-maintenance.sh: test_expect_success 'manual maintenance with --quiet suppresses diagnostic' '
    +@@ t/t7900-maintenance.sh: test_expect_success 'scheduled maintenance skips with existing lock' '
      	test_path_is_file .git/objects/maintenance.lock
      '
      
    @@ t/t7900-maintenance.sh: test_expect_success 'manual maintenance with --quiet sup
     +	test_trace2_data maintenance lock/skip "File exists" <trace.txt &&
     +	test_path_is_file .git/objects/maintenance.lock
     +'
    ++
    ++test_expect_success 'scheduled maintenance traces existing lock' '
    ++	test_when_finished "rm -f trace.txt err .git/objects/maintenance.lock" &&
    ++	: >.git/objects/maintenance.lock &&
    ++	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
    ++		git maintenance run --schedule=hourly 2>err &&
    ++	test_must_be_empty err &&
    ++	test_trace2_data maintenance lock/skip "File exists" <trace.txt &&
    ++	test_path_is_file .git/objects/maintenance.lock
    ++'
    ++
    ++test_expect_success 'manual maintenance does not trace lock/skip' '
    ++	test_when_finished "rm -f trace.txt err .git/objects/maintenance.lock" &&
    ++	: >.git/objects/maintenance.lock &&
    ++	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
    ++		test_must_fail git maintenance run --quiet 2>err &&
    ++	test_must_be_empty err &&
    ++	! grep -e "\"category\":\"maintenance\",\"key\":\"lock/skip\"" trace.txt &&
    ++	test_path_is_file .git/objects/maintenance.lock
    ++'
     +
      test_expect_success 'maintenance.loose-objects.auto' '
      	git repack -adk &&

base-commit: 3ef89b7020c1f4add19622af30f40ecc937af610
-- 
2.53.0

