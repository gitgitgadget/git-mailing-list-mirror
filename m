Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58524E4C6
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704662; cv=none; b=HVg2eL475IMbfmZtD+DVxRWOs0qzFcv3hMKS5hc+U2SginA92GAR6mutsNZb+stjtFS9S4/wrvtIfOGWTiifKfdi6W6WbS9r1u8+yvO7YaGxfVphhSsw5Uwj4cN1EW88GZvrW0HdFRugmBXimVCUdb/HJu6YuGJHISPSJn/Se3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704662; c=relaxed/simple;
	bh=JBXOm9mSbSJK07csTw5d4IYUZH0eDFn/htZTkLRONDg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b1u5/eLsVuSLCvs9ykZw+RhgyZSOIw1Bvt6jejuhRhgAtB18LILLsUfqoCBHIpfIOW9i0fNvBSxUjBqBaILaS9/Tmdmtg1EKVtVqGz0W5W77j0Ee9WwpDdOjk1sakmsfi4QoHKORA/XcfRGa0cBpf8N+yckKKnjJef0SI+3k/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnSDRbj5; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnSDRbj5"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8f0d6853360so9846856d6.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783704659; x=1784309459; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cWUmER5E6GeBN+F0I6/19aQ5MiaC4ZvokL3c2d6Hn/0=;
        b=qnSDRbj58GSNDeJ8LYOWUIzls0+fvZ51/WB/bWjzPfKmvlyjE3h5TSFhwboq8IgRvW
         yBb+3uac4MFtQsRxMeqoupVUjfB/nSuq4z9H8wNYU9XONs9j1XWZYGv+CTBfQx0VqbGj
         GUp275Tq2NS4gMZWBjtfz38Ktzt8df8xUYQFcGp32jdj3tvDwR4hdVucBb1Pn04NRDSs
         NcK67G6Tp23G12preDA9gqTp7fuMnI8T9LTZ7d3NTlySWqHtdB67bEAhEI4m+61itAEC
         us/qfzlZ0p537NT70WbT4WFvIVSQfEAd4mQ0GtSeqApxIIi14JP3plZzNsemrrMUVT7Q
         dcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704659; x=1784309459;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWUmER5E6GeBN+F0I6/19aQ5MiaC4ZvokL3c2d6Hn/0=;
        b=nOb1f8zhaZNsqio4u3mItRQ41frr4pyUHK5W9KbsSNehA0VPL0IFwhdHkffaHtYwwu
         VW8M/TyAMZlTmb5CF3YwkHdK2DgVr0Eindgjnak3VdpZik/muyzT0JnmOVmkDpJYNEtz
         mXjQJ0yxi3kfVfJSWtOulCelaOzzZl6uLRFCE68BiaWE7GUkUlO7YtU25IYoNHk09aJT
         fCCucx/prhqS5Qz4sfF+qbKIoGwMTuh9bTFNhYgQfprzL/D5rgr9X72sHVMUnNdV2KAM
         F+rw+D87wJAn5TIR7MGb3t0lHrR1EiWe1m4V9wmzhGtx89Anx2jCA7kKtjpOanJh/EZP
         kunA==
X-Gm-Message-State: AOJu0YzxtXdUGeb++UQiAC1G1D+Kf+ZeU9SCBDsU98Vq2MPmqWlKIin7
	kqGTdy2oftmJTzdkuO/lEPVMRNWdRf3kZUeyNQDpNc4xIoMBfGmCd4IYRdcmPA==
X-Gm-Gg: AfdE7cnf/Gc2zZ0Mz7FsX+XQF1kPmhrDK/rR/AYKT/5Gq/S5C9cB3AxPuB7MXvO3A0S
	f9CVrWi+SVGKDEpRidPwfEGSZ+7v71DI4GjFCo1ZhfHCyiwxezTzWyhFnxsmcm8/kus32TE7dTv
	ii3nWq5NAeTg1UVa1OnoKzXGxPV317HpAR8LabSLmFZiZY4Hobpsw3UP1ekftTbuhJLn5cRS9Nq
	l3k43BKlLlndE8jGv9g1UXncBnzPoMlKr1lWkD4BeTBQzbUreGWvnQUXh/nb0Opou/ubMmaKJ9R
	WEaOnoLumOye0oXKBH5shWQj/796+hN3rYTM6POdmqW2P2t4ezZuUyczrMb0tWzmpznv7Em0JhO
	qKuj/p+dm/Se+u5Xz/VeLVJsQAbrWskmozqkvfgdHMzfxIgGNpzXhCfCPrrLZlYdtIovGiSXQBN
	SNV6DlN4MqqUAypnqM
X-Received: by 2002:a05:6214:3187:b0:8ba:3fc9:88ca with SMTP id 6a1803df08f44-8fec693a6d4mr144090836d6.39.1783704659005;
        Fri, 10 Jul 2026 10:30:59 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.127.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e10e9sm45925696d6.7.2026.07.10.10.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:30:58 -0700 (PDT)
Message-Id: <pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 17:30:54 +0000
Subject: [PATCH v2 0/3] t/lib-httpd: make CGI test helpers concurrency-safe
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
Cc: Michael Montalbo <mmontalbo@gmail.com>

The httpd tests share a handful of CGI helper scripts under t/lib-httpd. Two
of them keep state between requests in the shared HTTPD_ROOT_PATH on the
assumption that the web server hands them one request at a time. It does
not: Apache serves requests concurrently, and a single Git operation can
open more than one request to the same endpoint at once. A partial fetch
that receives a REF_DELTA against a missing promisor object lazily fetches
that base while the first response is still being served.

Under that overlap apply-one-time-script.sh loses: two requests both pass
its "test -f one-time-script" check, one removes the marker, and the other
fails to exec it and emits an empty body, which the server answers as HTTP
500. In the field this is an occasional failure[1] of:

t5616.47 tolerate server sending REF_DELTA against missing promisor objects

on the macOS CI runners, with:

fatal: ... The requested URL returned error: 500 fatal: could not fetch from
promisor remote

I could not reproduce it against a live server (the window is tiny and
timing-dependent), but the macOS CI error log names the exact failure, and
the new test reproduces the helper's shell error.

http-429.sh keeps its "already returned 429 once" state with the same
non-atomic test-and-set. Its retry flow is mostly sequential so it seems
less likely to fail, but it is the same latent race.

Each fix is local: claim/consume the one-shot marker with an atomic rename,
and elect the first request with an atomic mkdir, rather than a "test -f"
followed by a separate remove or touch.

 * Patch 1 fixes apply-one-time-script.sh (the actual flake) and adds t5567,
   which drives the helper directly with no web server so the overlap can be
   forced deterministically.
 * Patch 2 makes http-429.sh atomic.
 * Patch 3 documents the atomic idioms generally in t/README (they are not
   specific to CGI or HTTP), citing Git's own lockfile machinery and
   make_symlink(), with a pointer from the lib-httpd list.

Changes since v1:

 * Clarify that one-time-script.sh can and should be able to run more than
   once. Explain that the constraint on the script execution is that one and
   only one modified response is guaranteed to be returned to the client.

 * The existing behavior w.r.t. inconsistent use of locale C vs. inherited
   locale when executing t/lib-httpd/apply-one-time-script.sh has been
   retained from the original version, and is left as future potential
   cleanup.

 * Spell out why the logic changes to the "permanent mode check" in
   t/lib-httpd/http-429.sh are needed for correctness, rather than an
   optimization opportunity.

[1]
https://github.com/gitgitgadget/git/actions/runs/28756172690/job/85263916762?pr=2169

Michael Montalbo (3):
  t/lib-httpd: fix apply-one-time-script race under concurrent requests
  t/lib-httpd: make http-429 first-request check atomic
  t/README: document writing concurrency-safe helpers

 t/README                             | 32 ++++++++++
 t/lib-httpd.sh                       |  3 +
 t/lib-httpd/apply-one-time-script.sh | 44 +++++++++----
 t/lib-httpd/http-429.sh              | 28 ++++----
 t/meson.build                        |  1 +
 t/t5567-one-time-script.sh           | 96 ++++++++++++++++++++++++++++
 6 files changed, 179 insertions(+), 25 deletions(-)
 create mode 100755 t/t5567-one-time-script.sh


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2171%2Fmmontalbo%2Fmm%2Flib-httpd-cgi-safe-proto-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2171/mmontalbo/mm/lib-httpd-cgi-safe-proto-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2171

Range-diff vs v1:

 1:  9f48aa6d6d ! 1:  79b56402c0 t/lib-httpd: fix apply-one-time-script race under concurrent requests
     @@ Commit message
          body and keeps the marker for a later request. No path emits an empty
          body, so the HTTP 500 no longer occurs.
      
     +    Running the one-time script more than once is fine; the only thing to
     +    avoid is serving a second, racing request's modified output. Two
     +    requests can both find the marker and run the script before either
     +    renames it away, but the rename is atomic, so exactly one of them wins:
     +    it serves its modified body and consumes the marker. The loser's rename
     +    fails because the marker is already gone, so it discards the modified
     +    output it produced and serves the unmodified body instead. The rename,
     +    not running the script, is what is serialized.
     +
          Add t5567 to lock this down. The overlap depends on timing, so a live
          httpd test such as t5616.47 (the real code path) passes almost every
          time even against the buggy helper; t5567 instead drives the helper
     @@ t/lib-httpd/apply-one-time-script.sh
      +# is left emitting an empty body, which the server would report as HTTP 500.
      +# Scratch files are per-request ($$) so concurrent requests do not clobber each
      +# other.
     -+
     -+test -f one-time-script || exec "$GIT_EXEC_PATH/git-http-backend"
     ++#
     ++# The script may run more than once: the marker is consumed when the response
     ++# actually changes (the rename after "cmp"), not when the script runs, so a
     ++# request whose response is not the targeted one runs the script, sees no
     ++# change, and leaves the marker for a later request. That is safe because the
     ++# scripts are stateless filters over the captured response.
       
      -	"$GIT_EXEC_PATH/git-http-backend" >out
      -	./one-time-script out >out_modified
     -+LC_ALL=C
     -+export LC_ALL
     ++test -f one-time-script || exec "$GIT_EXEC_PATH/git-http-backend"
       
      -	if cmp -s out out_modified
      -	then
     @@ t/lib-httpd/apply-one-time-script.sh
      -		cat out_modified
      -		rm one-time-script
      -	fi
     ++LC_ALL=C
     ++export LC_ALL
     ++
      +out=out.$$
      +modified=out-modified.$$
      +"$GIT_EXEC_PATH/git-http-backend" >"$out"
 2:  efd34c1715 ! 2:  5f56f32a74 t/lib-httpd: make http-429 first-request check atomic
     @@ Commit message
          which fails if the directory already exists, so exactly one of any
          concurrent requests is rate-limited and the rest are forwarded.
      
     +    Skipping state for "permanent" is required for correctness, not just an
     +    optimization. The marker tells a later or concurrent request that a 429
     +    has already been served, so that it forwards to git-http-backend instead
     +    of rate-limiting. Since "permanent" must return 429 to every request,
     +    that marker must never become visible to another such request.
     +
     +    The original did not achieve this by staying stateless: its "touch" of
     +    the marker ran unconditionally, and the "permanent" case removed it
     +    afterward with "rm -f". That create-then-remove leaves a window in which
     +    a concurrent "permanent" request sees the marker and is forwarded. It is
     +    the same class of check-then-act race this patch removes from the
     +    first-request check, latent for the same reason: the flow is mostly
     +    sequential. This version fuses the check and the mark into one atomic
     +    mkdir and, rather than recreate the pattern as mkdir-then-rmdir, skips
     +    the mkdir for "permanent" with a "!= permanent" guard. No marker is ever
     +    created, so there is no window and every "permanent" request
     +    rate-limits.
     +
          There is no accompanying regression test. The check and the set are
          adjacent commands with no external step in between to synchronize on, so
          the overlap cannot be forced deterministically, only reproduced
     @@ t/lib-httpd/http-429.sh: repo_path="${remaining#*/}"  # Get rest (repo path)
       
      -# Check if this is the first call (no state file exists)
      -if test -f "$state_file"
     -+# Apache can run this CGI for concurrent requests, so the script decides
     -+# whether this is the first call with a single atomic "mkdir": it succeeds for
     -+# exactly one of any racing requests and fails for the rest. "permanent"
     -+# always rate-limits and records no state.
     ++# This endpoint returns 429 to the first request and forwards later ones to
     ++# git-http-backend, so the retry succeeds. Apache can run this CGI for several
     ++# requests at once, so a single atomic "mkdir" elects that first request: the
     ++# one whose mkdir succeeds returns 429 and leaves the directory behind as the
     ++# "already rate-limited" marker; every later request finds the directory (mkdir
     ++# fails) and is forwarded.
     ++#
     ++# "permanent" is the exception: it must return 429 to every request and never
     ++# succeed, so it skips the mkdir and records no state. A leftover directory
     ++# would make its own later requests find the marker and be forwarded, which is
     ++# exactly what "permanent" must not do.
      +if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null
       then
       	# Already returned 429 once, forward to git-http-backend
 3:  771d264d29 = 3:  f158e1f92e t/README: document writing concurrency-safe helpers

-- 
gitgitgadget
