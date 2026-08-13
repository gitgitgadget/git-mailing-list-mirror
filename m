Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D003A2D3733
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786583143; cv=none; b=G1/gVpd7YsMEqMTsjg2iacfQ1ygc5n+LZSXxvxPXg+W9qRiCo7IBIztuFvNWR/3yVhg+uSByDlNB+HG4GYaOrWnfceZQN1prF+/5+N8IIQAbH9HgMDNcCxxCqm6W3ZWmV90BRgjdK8iTFk+6Polq/7OVAobpPqbwcI09+/h6tFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786583143; c=relaxed/simple;
	bh=y7JuN7rPl7MtqEmtKqKifZ8r4YEgVfqQfQ+cezuzP78=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mHWPNLTlltaF97KOuDHBfls+5tFSMk81TUb/GJPO0gvQ+q9X8de4xrjjmr14pIdhnlvwXL2uzpDdxDRMVOCAAtAb9GOyaaIKV9ELpTdqLdCBnfJ7wKFUtYAXWFR9BmIYJklKZalOcCSHdDsNJ73KdJ4cTtzee0tRyWwNbeVjfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7gA5YKq; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7gA5YKq"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e7c6ec9dbso65078985a.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 18:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786583140; x=1787187940; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Dfft5dcJFGdAwQteEM8YgrIxryggJQev8NSc4ztQcQ=;
        b=r7gA5YKqxsBjJbWbu27Mhxgt7LhREmE1QKAL41yGqSnKhFS1DeBMfVogjkAt3buUBp
         G9tf552ni5SOaN0Ol0BSvKkdr6wBLu3b0vJeodvwY054pjhOSxAW70kJ+dzgFZQuvJnn
         sVdgsTtQbemfCpn8yqzhg0sjyLkKUA+D1+0bt3rGkWnKSy5nOeQFmyPAA7Q61PNOFYfZ
         8GYOKLhvbn+ce9YNgrO+RU6n8jzO6cFlY4aMaKH2Xw9bw6YXuJweYW5kl7RemifZqxhi
         b8CrLixYrwwcAh6K20bL5e+q7WXZMpD8ydp6EzVombi69kUx0bxAUMM5PfsHqYSMmHDG
         PXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786583140; x=1787187940;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Dfft5dcJFGdAwQteEM8YgrIxryggJQev8NSc4ztQcQ=;
        b=rRqJWV2WAiKZ0tYwNRiFM/1OttYhfsHz8wncQG9HPrugE33Z5bNwQ7el8/j0UOdKii
         0f9q+yItvA1CHfrp7hLQ1UuXtm5cBR8uTSti5vLsea4YBfrmP4bCC9o2GH0ErGoqOcdS
         72b4mSakOt41pUUb+pNl04InjIQIcHlziViu3AhqtsmHnTB5xk81xfMFv617BfybcTwZ
         xt81ly+SbO7BzQBjKwFvSwVZBxTNOOEjcUWrmwp11+KZbL+con7hok7lHPqPOZlPXNKj
         vyhHjE5ZdFl9T1mbX5JPE5EKq6aJ26MFSjn17y205d4S2Uaw5P5wiC9ufixcctMclM4F
         v4OQ==
X-Gm-Message-State: AOJu0Yzrl64BUHbc5u5crM+LqjZGOY0nllSj7wH4T1MeM7IxTYbyj8hp
	/1i6/PUlmbyOUMadUjXnaGHhgDazTVtBMU6D6WPduqY7zYxAQIqAQQLwx3wvrg==
X-Gm-Gg: AR+sD11uLneO/oNEC8vc4j8JLaL4vax3s7vAB/GCQSnsf10lrOF1rD9r8pDREYODqPe
	gXoOFgP2QKMpb9qGNceM/MDiLGeW8J3a51ppRwnS98flQbYTrvBGo0lUEZjS5RmW3bwlIRQ9sR7
	sHvwjM8F8tLn+JYXjhE1LZe2G/koCUeplAO7l1EPKnAorUiaeEHeownESMbz1fl9RaULrqM7rWU
	WJHShFdSbvpmWYvP5K55ePXHvXUW4u4OtCdyYrGArK3en6Y7TM+aYTWg81uayKa/ITEgUSpZM/N
	AHRMnAvoOdesklJ3Od8E3qZfvmw8BRG/x8LtOFpRGoXjM5F4jxbIt497BDnO3GWo6APil5MxThN
	GQ3OssYFwdkPj6IVX8UIST3cLCSXXSrvBY5AKWXvzBgySzjf1JtEPvT9kpGsGeH1rqcER81MES/
	MYzssE67/08V6RGWLjSSaoUTwoo8FeYdsvEDSNQNE26DscPlVbPijoc0NErK/xMfM=
X-Received: by 2002:a05:620a:2552:b0:934:8232:ed2b with SMTP id af79cd13be357-936bfa0803amr226860385a.28.1786583139387;
        Wed, 12 Aug 2026 18:05:39 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1b1290fsm33693485a.31.2026.08.12.18.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 18:05:38 -0700 (PDT)
Message-Id: <pull.2171.v3.git.1786583137.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 01:05:33 +0000
Subject: [PATCH v3 0/3] t/lib-httpd: make CGI test helpers concurrency-safe
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
    Michael Montalbo <mmontalbo@gmail.com>

The httpd tests share a handful of CGI helper scripts under t/lib-httpd. Two
of them keep state between requests in the shared HTTPD_ROOT_PATH, on the
assumption that the web server hands them one request at a time. It does
not: Apache serves requests concurrently, and a single Git operation can
open more than one request to the same endpoint at once. For example, a
partial fetch that receives a REF_DELTA against a missing promisor object
lazily fetches that base while the first response is still being served.

Under that overlap apply-one-time-script.sh fails. Two requests both pass
its "test -f one-time-script" check; one removes the marker; the other then
fails to exec it, emits an empty body, and the server answers HTTP 500. In
the field this is an occasional failure[1] of

t5616.47 tolerate server sending REF_DELTA against missing promisor objects

on the macOS CI runners, with

fatal: ... The requested URL returned error: 500 fatal: could not fetch from
promisor remote

I could not reproduce it against a live server, since the window is tiny and
timing-dependent, but the macOS CI error log names the exact failure and the
new test reproduces the helper's shell error.

http-429.sh keeps its "already returned 429 once" state with the same
non-atomic check-and-set. Its retry flow is mostly sequential, so it seems
less likely to fail, but it is the same latent race.

Each helper replaces a non-atomic "test -f" check and separate follow-up
action with a single atomic operation whose exit status decides the outcome:
apply-one-time-script.sh consumes its one-shot marker with "rm" (without
"-f"), and http-429.sh elects the first request with "mkdir".

 * Patch 1 fixes apply-one-time-script.sh (the actual flake) and adds t5567,
   which drives the helper directly with no web server so the overlap can be
   forced deterministically.
 * Patch 2 makes http-429.sh atomic.
 * Patch 3 documents the atomic idioms next to where t/lib-httpd.sh installs
   the CGI scripts, so the guidance is in front of anyone adding another
   helper.

Changes since v2:

 * Patch 1 now consumes the marker with a plain "rm" (without "-f") instead
   of a rename. "rm" without "-f" already fails once the marker is gone,
   which is the atomicity the helper needs. A new comment explains why the
   helper discards the one-time script's stderr: a losing request can find
   the marker already removed.

 * Patch 3 is now specific to the lib-httpd CGI helpers and lives beside
   their install site in t/lib-httpd.sh, rather than as a general section in
   t/README.

 * Reworded several helper comments and the patch 1 and 2 log messages for
   clarity and to match the code; no behavior change.

[1]
https://github.com/gitgitgadget/git/actions/runs/28756172690/job/85263916762?pr=2169

Michael Montalbo (3):
  t/lib-httpd: fix apply-one-time-script race under concurrent requests
  t/lib-httpd: make http-429 first-request check atomic
  t/lib-httpd: document writing concurrency-safe CGI helpers

 t/lib-httpd.sh                       | 13 ++++
 t/lib-httpd/apply-one-time-script.sh | 50 +++++++++++----
 t/lib-httpd/http-429.sh              | 30 +++++----
 t/meson.build                        |  1 +
 t/t5567-one-time-script.sh           | 96 ++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+), 26 deletions(-)
 create mode 100755 t/t5567-one-time-script.sh


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2171%2Fmmontalbo%2Fmm%2Flib-httpd-cgi-safe-proto-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2171/mmontalbo/mm/lib-httpd-cgi-safe-proto-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2171

Range-diff vs v2:

 1:  79b56402c0 ! 1:  862c4258e5 t/lib-httpd: fix apply-one-time-script race under concurrent requests
     @@ Metadata
       ## Commit message ##
          t/lib-httpd: fix apply-one-time-script race under concurrent requests
      
     -    apply-one-time-script.sh checks for the "one-time-script" marker, runs
     -    it, captures the git-http-backend response in the fixed-name files "out"
     -    and "out_modified", and removes the marker only after it has finished
     -    serving the modified response. Because the client receives the response
     -    body before that removal, it can start its next request while the marker
     -    still exists. Apache can then run this CGI for two requests at once: a
     -    partial fetch that receives a REF_DELTA against a missing promisor
     -    object lazily fetches that base while the first response is still in
     -    flight. The second request passes the marker check, the first request
     -    then removes the marker, and the second fails to exec the now-missing
     -    marker, emits no output, and the server answers HTTP 500:
     +    apply-one-time-script.sh is a CGI helper that, when the file
     +    "one-time-script" is present, runs it to rewrite the git-http-backend
     +    response. If "one-time-script" generates a response that differs from
     +    git-http-backend, the modified response is returned and
     +    "one-time-script" is deleted. Requests after the deletion return normal
     +    git-http-backend responses.
     +
     +    The deletion is not safe under concurrency. The helper serves the
     +    modified body first and deletes "one-time-script" only afterward, so a
     +    client can issue its next request while the file still exists. Apache
     +    runs the CGI for both requests at once, for example when a partial fetch
     +    lazily fetches a missing promisor base while the first response is still
     +    in flight. Both requests find the file and try to run it; the first
     +    deletes it; the second then fails to exec the now-missing file, produces
     +    no output, and the server returns HTTP 500:
      
            fatal: ... The requested URL returned error: 500
            fatal: could not fetch <oid> from promisor remote
      
     -    This has been seen as a flaky failure of t5616.47 on the macOS CI
     -    runners.
     -
     -    Claim the marker atomically with a rename, and only once the one-time
     -    script has succeeded and actually changed the response; give the scratch
     -    files per-request names. A request that loses the rename, or whose
     -    script fails or leaves the response unchanged, serves the unmodified
     -    body and keeps the marker for a later request. No path emits an empty
     -    body, so the HTTP 500 no longer occurs.
     +    This is the flaky failure of t5616.47 on the macOS CI runners.
      
     -    Running the one-time script more than once is fine; the only thing to
     -    avoid is serving a second, racing request's modified output. Two
     -    requests can both find the marker and run the script before either
     -    renames it away, but the rename is atomic, so exactly one of them wins:
     -    it serves its modified body and consumes the marker. The loser's rename
     -    fails because the marker is already gone, so it discards the modified
     -    output it produced and serves the unmodified body instead. The rename,
     -    not running the script, is what is serialized.
     +    Fix it by removing the file with "rm" only after the script has actually
     +    changed the response. Because "rm" without "-f" fails once the file is
     +    gone, exactly one request removes it and serves the modified body. Any
     +    other request serves the unmodified body. Running the script more than
     +    once is harmless; only its deletion is serialized, so exactly one
     +    request's modified response is ever served. Per-request scratch file
     +    names keep concurrent runs from overwriting each other, and no path
     +    emits an empty response body.
      
     -    Add t5567 to lock this down. The overlap depends on timing, so a live
     -    httpd test such as t5616.47 (the real code path) passes almost every
     -    time even against the buggy helper; t5567 instead drives the helper
     -    directly with a fake git-http-backend and forces the overlap with FIFOs.
     -    Against the pre-fix helper it fails with the same shell error seen in
     -    the field:
     +    t5616.47 exercises the real code path but, being timing-dependent,
     +    passes against the buggy helper almost every time. Add t5567, which
     +    drives the helper directly with a fake git-http-backend and forces the
     +    overlap with FIFOs; against the pre-fix helper it fails with the same
     +    shell error seen in the field:
      
            ./one-time-script: No such file or directory
      
     @@ t/lib-httpd/apply-one-time-script.sh
      -	LC_ALL=C
      -	export LC_ALL
      +#
     -+# Apache can run this CGI for concurrent requests (for example a partial fetch
     -+# that lazily fetches a missing object while the first response is still in
     -+# flight), so the helper claims the marker atomically with a rename, and only
     -+# once it has decided to modify the response. A request that loses the race
     -+# finds the marker already gone and serves its response unchanged; no request
     -+# is left emitting an empty body, which the server would report as HTTP 500.
     -+# Scratch files are per-request ($$) so concurrent requests do not clobber each
     -+# other.
     ++# Apache can run this CGI for several requests at the same time. For example, a
     ++# partial fetch lazily fetches a missing object while the first response is
     ++# still in flight. To stay correct, the helper removes the marker only after
     ++# the response changes, and only with "rm" (without "-f"). The "rm" fails for
     ++# every request except the one that removes the marker first. That request
     ++# serves the modified body. Every other request serves its response unchanged.
     ++# No request emits an empty body, which Apache would report as HTTP 500.
     ++#
     ++# A scratch file name includes the process ID ($$), so concurrent requests do
     ++# not overwrite each other's files.
      +#
     -+# The script may run more than once: the marker is consumed when the response
     -+# actually changes (the rename after "cmp"), not when the script runs, so a
     -+# request whose response is not the targeted one runs the script, sees no
     -+# change, and leaves the marker for a later request. That is safe because the
     ++# The helper can run one-time-script more than once. It consumes the marker
     ++# when the response changes (the "rm" after "cmp"), not when it runs the
     ++# script. A request whose response is not the target runs the script, finds no
     ++# change, and leaves the marker for a later request. This is safe because the
      +# scripts are stateless filters over the captured response.
       
      -	"$GIT_EXEC_PATH/git-http-backend" >out
     @@ t/lib-httpd/apply-one-time-script.sh
      +modified=out-modified.$$
      +"$GIT_EXEC_PATH/git-http-backend" >"$out"
      +
     ++# one-time-script can be gone here: a concurrent request may have consumed it
     ++# since the "test -f" above. Then "./one-time-script" fails, the exit status
     ++# selects the unmodified body, and "2>/dev/null" discards the expected
     ++# "no such file" message.
      +if ./one-time-script "$out" 2>/dev/null >"$modified" &&
      +   ! cmp -s "$out" "$modified" &&
     -+   mv one-time-script one-time-script.$$ 2>/dev/null
     ++   rm one-time-script 2>/dev/null
      +then
      +	cat "$modified"
       else
      -	"$GIT_EXEC_PATH/git-http-backend"
      +	cat "$out"
       fi
     -+rm -f "$out" "$modified" one-time-script.$$
     ++rm -f "$out" "$modified"
      
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
 2:  5f56f32a74 ! 2:  8ed22c02a1 t/lib-httpd: make http-429 first-request check atomic
     @@ Metadata
       ## Commit message ##
          t/lib-httpd: make http-429 first-request check atomic
      
     -    http-429.sh records "already returned 429 once" with a "test -f"
     -    followed by a "touch" of a shared state file. That check-then-act is not
     -    atomic: Apache can run this CGI for several requests at once, and two of
     -    them can both pass the "test -f" before either "touch"es, so both treat
     -    themselves as the first request. The retry flow that drives this
     -    endpoint is mostly sequential, so this has not been seen to fail, but
     -    the race is latent.
     +    http-429.sh returns 429 to the first request for an endpoint and
     +    forwards later ones to git-http-backend so the retry succeeds. It
     +    remembers that it has already answered 429 by checking for a shared
     +    state file with "test -f" and creating it with "touch".
      
     -    Decide whether this is the first request with a single atomic mkdir,
     -    which fails if the directory already exists, so exactly one of any
     -    concurrent requests is rate-limited and the rest are forwarded.
     +    That "check-and-set" is not atomic. Apache runs the CGI for several
     +    requests at once, so two of them can pass the "test -f" before either
     +    "touch"es the file, and both then answer as the first request. The
     +    retry flow is mostly sequential, so this has not been observed to fail,
     +    but the race is latent. Replace the check and the "touch" with a single
     +    atomic "mkdir", which fails if the directory already exists, so exactly
     +    one of the concurrent requests is rate-limited and the rest are
     +    forwarded.
      
     -    Skipping state for "permanent" is required for correctness, not just an
     -    optimization. The marker tells a later or concurrent request that a 429
     -    has already been served, so that it forwards to git-http-backend instead
     -    of rate-limiting. Since "permanent" must return 429 to every request,
     -    that marker must never become visible to another such request.
     +    The "permanent" mode needs one extra step, for correctness rather than
     +    tidiness. The marker means "429 already served, now forward", so it must
     +    never be visible to a request that must itself return 429. Since
     +    "permanent" returns 429 to every request, it must leave no marker. The
     +    original did not manage this. It ran the "touch" unconditionally and
     +    removed the file with "rm -f" in the "permanent" case, and that
     +    "create-then-remove" has the same racy window: a concurrent "permanent"
     +    request can see the marker before the "rm -f" and be wrongly forwarded.
     +    Skipping the "mkdir" entirely for "permanent" (the "!= permanent" guard)
     +    leaves no marker at all, so every "permanent" request rate-limits.
      
     -    The original did not achieve this by staying stateless: its "touch" of
     -    the marker ran unconditionally, and the "permanent" case removed it
     -    afterward with "rm -f". That create-then-remove leaves a window in which
     -    a concurrent "permanent" request sees the marker and is forwarded. It is
     -    the same class of check-then-act race this patch removes from the
     -    first-request check, latent for the same reason: the flow is mostly
     -    sequential. This version fuses the check and the mark into one atomic
     -    mkdir and, rather than recreate the pattern as mkdir-then-rmdir, skips
     -    the mkdir for "permanent" with a "!= permanent" guard. No marker is ever
     -    created, so there is no window and every "permanent" request
     -    rate-limits.
     -
     -    There is no accompanying regression test. The check and the set are
     -    adjacent commands with no external step in between to synchronize on, so
     -    the overlap cannot be forced deterministically, only reproduced
     -    probabilistically; the fix is preventive.
     +    There is no regression test. The check and the set are adjacent commands
     +    with nothing in between to synchronize on, so the overlap cannot be
     +    forced deterministically, only reproduced by chance; the fix is
     +    preventive.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
       ## t/lib-httpd/http-429.sh ##
     +@@
     + # Script to return HTTP 429 Too Many Requests responses for testing retry logic.
     + # Usage: /http_429/<test-context>/<retry-after-value>/<repo-path>
     + #
     +-# The test-context is a unique identifier for each test to isolate state files.
     ++# The test-context is a unique identifier for each test to isolate state directories.
     + # The retry-after-value can be:
     + #   - A number (e.g., "1", "2", "100") - sets Retry-After header to that many seconds
     + #   - "none" - no Retry-After header
      @@ t/lib-httpd/http-429.sh: repo_path="${remaining#*/}"  # Get rest (repo path)
       # The repo name is the first component before any "/"
       repo_name="${repo_path%%/*}"
     @@ t/lib-httpd/http-429.sh: repo_path="${remaining#*/}"  # Get rest (repo path)
      -# Use current directory (HTTPD_ROOT_PATH) for state file
      -# Create a safe filename from test_context, retry_after and repo_name
      -# This ensures all requests for the same test context share the same state file
     -+# Use current directory (HTTPD_ROOT_PATH) for state.
     -+# Create a safe name from test_context, retry_after and repo_name so that all
     -+# requests for the same test context share the same state.
     ++# Store state in the current directory (HTTPD_ROOT_PATH). Build a safe name
     ++# from test_context, retry_after, and repo_name, so that all requests for one
     ++# test context share the same state.
       safe_name=$(echo "${test_context}-${retry_after}-${repo_name}" | tr '/' '_' | tr -cd 'a-zA-Z0-9_-')
      -state_file="http-429-state-${safe_name}"
      +state="http-429-state-${safe_name}"
       
      -# Check if this is the first call (no state file exists)
      -if test -f "$state_file"
     -+# This endpoint returns 429 to the first request and forwards later ones to
     -+# git-http-backend, so the retry succeeds. Apache can run this CGI for several
     -+# requests at once, so a single atomic "mkdir" elects that first request: the
     -+# one whose mkdir succeeds returns 429 and leaves the directory behind as the
     -+# "already rate-limited" marker; every later request finds the directory (mkdir
     -+# fails) and is forwarded.
     ++# This endpoint returns 429 to the first request. It forwards every later
     ++# request to git-http-backend, so the retry succeeds. Apache can run this CGI
     ++# for several requests at the same time. A single atomic "mkdir" selects the
     ++# first request, because only one "mkdir" succeeds. That request returns 429
     ++# and leaves the directory as the "already rate-limited" marker. Every later
     ++# "mkdir" fails, so the endpoint forwards those requests.
      +#
     -+# "permanent" is the exception: it must return 429 to every request and never
     -+# succeed, so it skips the mkdir and records no state. A leftover directory
     -+# would make its own later requests find the marker and be forwarded, which is
     -+# exactly what "permanent" must not do.
     ++# "permanent" is the exception. It must return 429 to every request, so it
     ++# skips the "mkdir" and records no state. A leftover directory would let a
     ++# later "permanent" request find the marker. The endpoint would forward that
     ++# request, which "permanent" must not allow.
      +if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null
       then
       	# Already returned 429 once, forward to git-http-backend
 3:  f158e1f92e ! 3:  374d148f43 t/README: document writing concurrency-safe helpers
     @@ Metadata
      Author: Michael Montalbo <mmontalbo@gmail.com>
      
       ## Commit message ##
     -    t/README: document writing concurrency-safe helpers
     +    t/lib-httpd: document writing concurrency-safe CGI helpers
      
     -    The apply-one-time-script.sh and http-429.sh fixes addressed the same
     -    underlying problem: a test helper assuming it has exclusive access to a
     -    file when the web server can run it for several requests at once. The
     -    atomic idioms that avoid this are not specific to CGI or to HTTP, so
     -    document them generally, alongside the other guidance for writing tests,
     -    and leave a pointer from the lib-httpd helper list rather than a local
     -    comment. The note covers the anti-pattern (a "test -f" then a separate
     -    act) and the two safe operations (mkdir to elect a winner, rename to
     -    consume a one-shot marker), citing Git's own lockfile machinery and
     -    make_symlink() as precedent.
     +    The apply-one-time-script.sh and http-429.sh fixes share a root cause: a
     +    CGI helper assumed it had a file to itself, when Apache can run the
     +    helper for several requests at once. Document the atomic idioms that
     +    avoid this next to where lib-httpd.sh installs the CGI scripts, so the
     +    advice is in front of anyone adding another one.
      
     -    Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
     +    The note describes the anti-pattern, a "test -f" check followed by a
     +    separate action, and the two atomic alternatives these helpers now use:
     +
     +     - "mkdir", which fails if the directory exists, to elect the first
     +       request (http-429.sh); and
     +     - "rm" without "-f", which fails once the file is gone, to consume a
     +       one-shot marker (apply-one-time-script.sh).
      
     - ## t/README ##
     -@@ t/README: from the test harness library.  At the end of the script, call
     - 'test_done'.
     - 
     - 
     -+Writing concurrency-safe helpers
     -+--------------------------------
     -+
     -+Some test code runs concurrently: a test may background work with '&',
     -+and the helper scripts installed for the web server (in t/lib-httpd) are
     -+run once per request, so the same script can execute for several
     -+requests at once.  Such code cannot assume it has exclusive access to a
     -+file.
     -+
     -+When exactly one of several concurrent processes needs to "win" a
     -+decision, a single atomic filesystem operation can make it, rather than
     -+a check followed by a separate action.  A "test -f X" then "touch X"
     -+(or "rm X") races: two processes can both pass the check before either
     -+acts.  Two atomic operations avoid this:
     -+
     -+ - "mkdir dir", which fails if the directory already exists, so that
     -+   exactly one caller wins, electing a first or only request (see
     -+   t/lib-httpd/http-429.sh).
     -+
     -+ - "mv src dst" (rename), which fails if the source is gone, so that
     -+   exactly one caller consumes it, claiming a planted one-shot marker
     -+   (see t/lib-httpd/apply-one-time-script.sh).
     -+
     -+A "$$" suffix on per-request scratch files keeps concurrent invocations
     -+from clobbering each other's fixed-name files.
     -+
     -+This is a standard shell locking idiom, and the same reasoning behind
     -+Git's own lockfile machinery, which creates its lock with O_CREAT|O_EXCL,
     -+and make_symlink() in t/test-lib.sh, which uses an mkdir lock: an atomic
     -+operation whose failure indicates that another process got there first.
     -+
     -+
     - Test harness library
     - --------------------
     - 
     +    Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
       ## t/lib-httpd.sh ##
      @@ t/lib-httpd.sh: prepare_httpd() {
       	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
       	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
       	cp "$TEST_PATH"/proxy-passwd "$HTTPD_ROOT_PATH"
     -+	# The web server can run any of these CGI scripts for two requests at
     -+	# once; a helper that keeps state between requests must do so with an
     -+	# atomic operation. See "Writing concurrency-safe helpers" in t/README.
     ++	# Apache runs each of these CGI scripts once per request. Apache can run one
     ++	# script for several requests at the same time. A helper that keeps state
     ++	# between requests must update that state with one atomic operation. A check
     ++	# and then a separate action is not safe: two requests can both pass the
     ++	# check before either one acts. Test the exit status of one atomic operation
     ++	# instead:
     ++	#   - "mkdir dir" fails if the directory exists, so only one request
     ++	#     succeeds. http-429.sh selects the first request this way.
     ++	#   - "rm marker" (without "-f") fails if the marker is gone, so only one
     ++	#     request consumes it. apply-one-time-script.sh claims its one-shot
     ++	#     marker this way.
     ++	# A scratch file name includes the process ID ($$), so concurrent requests
     ++	# do not overwrite each other's files.
       	install_script incomplete-length-upload-pack-v2-http.sh
       	install_script incomplete-body-upload-pack-v2-http.sh
       	install_script error-no-report.sh

-- 
gitgitgadget
