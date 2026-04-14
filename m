Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C723E358
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198055; cv=none; b=cXZEuONV+0H5zVvkVMto9GkICOo07NjEP2qC3knmf7oPoDW/baEvfuOH2KxFBgyLYzCbMJKOccbFOuUKFrKHC4FQpyMvqyOvYHtCw1VVGLiLeQvR9paM6RVHQamVPuMus8UjqBjvZ5z5Xu0PS+AmtBm2MPe+8MDs2PBs8WZSgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198055; c=relaxed/simple;
	bh=MJv1Rcww/S5C5pbf3jwF3s4Galg3xpNlnzNlZCKlZs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pl+Y6V29lmJOxqnVH2HfWtXnUe4RTvmt6l+hbO9AMdUC6ToaBboZb/6vlbMrBD2GD1kUSFh2iKA9gQxP4WMRDGz8NYiC/lfm0jQbFpPNQFAefoHzRakRxX2acnyMoHAd6sWpMXtfV8/AZXnkqKoWabJB1uZtZnWfMP+kvtglXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKrCLms8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKrCLms8"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so6053164f8f.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776198052; x=1776802852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsr4kCdpYj41pkrrrVjDIncopagxioB2XTc1y7jTjIU=;
        b=tKrCLms8ZYajOX8eMHLrwNUiHoUhNi/CKUZ9k08v6P+AD40bySpiJEtPRy4Ow1Vodk
         ELIzUoB72l7lE9l/HJa1cHYbBScIOyOp2YTbj5vwU0I6ksqvAD8jWF3PhOw+RhBBxw2d
         V2YV6N28ND874y9PlZdJNL8SmUwtomXDMd76JhG+bRi5eCJ1GNpBVw4qGf7/95u1WEKG
         2g+z/i2XP5GDA8rj0JjerwP0GLk19CkPgBXoYLjzwFD8giE7r5mpgnYMmg3jq9MVNSP2
         +g+H4idY/8XBTlfnC24cqcEW+6CZEw3+ZPMAKxusbqS1OhTs2Ktlujx5weDCiZTS8dCt
         JShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776198052; x=1776802852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hsr4kCdpYj41pkrrrVjDIncopagxioB2XTc1y7jTjIU=;
        b=fcND2iyjbUeyZd/7wTkX8wCK8SediGptgd4nJMgmdfxZvIqQSZz1rsAh30KzajZa3q
         sx4inAYoXoyLL1dMftNxAuj+V97F1Nd+j8lYkweoytJ4hITo/kcNQcjn17y4zfwz2HP4
         0wSOT+kMb2oEPeSI5ASBtZdVbyPJRxaGJr4Tt6VkzxFrh0GZ/QyhJ2r3RtVclz+mWEbT
         32k1EaygOyshsea6+HBxvHDE1yWmr5aXEoLXsMrS+oYE12P+iW/lGy3YZuLeHd2OWyUT
         NeH0YA5f3tn8QZh4xBx73L8kZpVPQ6nLrmm1qJfZHhUS96JyPNx7Qc9kBlCcQuBeKTT/
         w96A==
X-Gm-Message-State: AOJu0YwS+TXzpTS1aztdarI2BZcmE/UHoQ2oiLSnRvciqoW0sqp+3r12
	MQJAahJYgk/6coFZu9Sw3Mu9f62tOKtTn4xZOYa8+oWSIxX5Q9xgmfJF
X-Gm-Gg: AeBDiesH8p/nt7CCNxJq1OfCHSW9sxHDDURef81pt/XLzgBbByYNWMFk/Q80QiwnOVU
	m+Qfp7iM/r3Braizxk0EpUEWmmCfeikafRhKKeLb+cyO6jxuIaxGMCK5HIVNrbX+SMQIuml34Ot
	xzN/0YWex9t5/0AglijhdcBSB0yDGQK2gGFBFCYwot5OuIFg3oijWTFG65x8D4JQ8aQc69vdWA2
	qoijC7ffkOhTlEjjzSmSvJzAd+iPld8pHB741gQDoLZPx1xgipp2+88JHpyvGp6x7c4eYrzTw+q
	UL8Vg5fUBWgmq5xawQJo1NuCrG25zmwBGPhjuQNkRTFLSwmxIgwBRIEfalrvtlXA9aHYMcf/eE6
	2aNy7WHJb8iXrLcvci9ibUwwAF8lOYXW5fQqdTBrJpUUm5g+IuxBOIbOZDHdou9cxBAMdrUOcD3
	hXNTlUbVroCPPqGOwz0/iTJ0uQvGJY5/ZB2c+v6s1tTVN3yTp8vOJr
X-Received: by 2002:a05:6000:41c1:b0:43d:70de:1c70 with SMTP id ffacd0b85a97d-43d70de343amr15480478f8f.32.1776198052043;
        Tue, 14 Apr 2026 13:20:52 -0700 (PDT)
Received: from localhost (94-21-146-148.pool.digikabel.hu. [94.21.146.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7b543057sm16525381f8f.6.2026.04.14.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:20:51 -0700 (PDT)
Date: Tue, 14 Apr 2026 22:20:50 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Paul Tarjan <paul@paultarjan.com>,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v14 12/13] fsmonitor: add tests for Linux
Message-ID: <ad6hovxCkwMTG11U@szeder.dev>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
 <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
 <f85983ca93761bf6cec115d680af8c7d2938505d.1775710775.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f85983ca93761bf6cec115d680af8c7d2938505d.1775710775.git.gitgitgadget@gmail.com>

On Thu, Apr 09, 2026 at 04:59:34AM +0000, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>
> 
> Add a smoke test that verifies the filesystem actually delivers
> inotify events to the daemon.  On some configurations (e.g.,
> overlayfs with older kernels), inotify watches succeed but events
> are never delivered.  The daemon cookie wait will time out, but
> every subsequent test would fail.  Skip the entire test file early
> when this is detected.
> 
> Add a test that exercises rapid nested directory creation to verify
> the daemon correctly handles the EEXIST race between recursive scan
> and queued inotify events.  When IN_MASK_CREATE is available and a
> directory watch is added during recursive registration, the kernel
> may also deliver a queued IN_CREATE event for the same directory.
> The second inotify_add_watch() returns EEXIST, which must be treated
> as harmless.  An earlier version of the listener crashed in this
> scenario.
> 
> Reduce --start-timeout from the default 60 seconds to 10 seconds so
> that tests fail promptly when the daemon cannot start.
> 
> Harden the test helpers to work in environments without procps
> (e.g., Fedora CI): fall back to reading /proc/$pid/stat for the
> process group ID when ps is unavailable, guard stop_git() against
> an empty pgid, and redirect stderr from kill to /dev/null to avoid
> noise when processes have already exited.
> 
> Use set -m to enable job control in the submodule-pull test so that
> the background git pull gets its own process group, preventing the
> shell wait from blocking on the daemon.  setsid() in the previous
> commit detaches the daemon itself, but the intermediate git pull
> process still needs its own process group for the test shell to
> manage it correctly.
> 
> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>  t/t7527-builtin-fsmonitor.sh | 89 +++++++++++++++++++++++++++++++++---
>  1 file changed, 82 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 409cd0cd12..774da5ac60 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -10,9 +10,58 @@ then
>  	test_done
>  fi
>  
> +# Verify that the filesystem delivers events to the daemon.
> +# On some configurations (e.g., overlayfs with older kernels),
> +# inotify watches succeed but events are never delivered.  The
> +# cookie wait will time out and the daemon logs a trace message.
> +#
> +# Use "timeout" (if available) to guard each step against hangs.
> +maybe_timeout () {
> +	if type timeout >/dev/null 2>&1
> +	then
> +		timeout "$@"
> +	else
> +		shift
> +		"$@"
> +	fi
> +}
> +verify_fsmonitor_works () {
> +	git init test_fsmonitor_smoke || return 1
> +
> +	GIT_TRACE_FSMONITOR="$PWD/smoke.trace" &&
> +	export GIT_TRACE_FSMONITOR &&
> +	maybe_timeout 30 \
> +		git -C test_fsmonitor_smoke fsmonitor--daemon start \
> +			--start-timeout=10
> +	ret=$?
> +	unset GIT_TRACE_FSMONITOR
> +	if test $ret -ne 0
> +	then
> +		rm -rf test_fsmonitor_smoke smoke.trace
> +		return 1
> +	fi
> +
> +	maybe_timeout 10 \
> +		test-tool -C test_fsmonitor_smoke fsmonitor-client query \
> +			--token 0 >/dev/null 2>&1
> +	maybe_timeout 5 \
> +		git -C test_fsmonitor_smoke fsmonitor--daemon stop 2>/dev/null
> +	! grep -q "cookie_wait timed out" "$PWD/smoke.trace" 2>/dev/null
> +	ret=$?
> +	rm -rf test_fsmonitor_smoke smoke.trace
> +	return $ret
> +}
> +
> +if ! verify_fsmonitor_works
> +then
> +	skip_all="filesystem does not deliver fsmonitor events (container/overlayfs?)"
> +	test_done
> +fi
> +
>  stop_daemon_delete_repo () {
>  	r=$1 &&
> -	test_might_fail git -C $r fsmonitor--daemon stop &&
> +	test_might_fail maybe_timeout 30 \
> +		git -C $r fsmonitor--daemon stop 2>/dev/null

"test_might_fail" only allows a few select commands and functions, and
the "maybe_timeout" helper function introduced in this patch is, of
course, not one of them, so it returns with error and without running
the given command.  Consequently, after this test script is finished I
have still two fsmonitor daemon processes running in the background.

Alas, this went unnoticed, because this patch broke the &&-chain and
redirected "test_might_fail"'s

  test_must_fail: only 'git' is allowed: maybe_timeout 30 git -C test_explicit fsmonitor--daemon stop

error messages to /dev/null.  With the &&-chain restored over 40 test
cases fail because of this.

>  	rm -rf $1
>  }
>  
> @@ -67,7 +116,7 @@ start_daemon () {
>  			export GIT_TEST_FSMONITOR_TOKEN
>  		fi &&
>  
> -		git $r fsmonitor--daemon start &&
> +		git $r fsmonitor--daemon start --start-timeout=10 &&
>  		git $r fsmonitor--daemon status
>  	)
>  }
> @@ -520,6 +569,28 @@ test_expect_success 'directory changes to a file' '
>  	grep "^event: dir1$" .git/trace
>  '
>  
> +test_expect_success 'rapid nested directory creation' '
> +	test_when_finished "git fsmonitor--daemon stop; rm -rf rapid" &&
> +
> +	start_daemon --tf "$PWD/.git/trace" &&
> +
> +	# Rapidly create nested directories to exercise race conditions
> +	# where directory watches may be added concurrently during
> +	# event processing and recursive scanning.
> +	for i in $(test_seq 1 20)
> +	do
> +		mkdir -p "rapid/nested/dir$i/subdir/deep" || return 1
> +	done &&
> +
> +	# Give the daemon time to process all events
> +	sleep 1 &&
> +
> +	test-tool fsmonitor-client query --token 0 &&
> +
> +	# Verify daemon is still running (did not crash)
> +	git fsmonitor--daemon status
> +'
> +
>  # The next few test cases exercise the token-resync code.  When filesystem
>  # drops events (because of filesystem velocity or because the daemon isn't
>  # polling fast enough), we need to discard the cached data (relative to the
> @@ -910,7 +981,10 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
>  start_git_in_background () {
>  	git "$@" &
>  	git_pid=$!
> -	git_pgid=$(ps -o pgid= -p $git_pid)
> +	git_pgid=$(ps -o pgid= -p $git_pid 2>/dev/null ||
> +		awk '{print $5}' /proc/$git_pid/stat 2>/dev/null) &&
> +	git_pgid="${git_pgid## }" &&
> +	git_pgid="${git_pgid%% }"
>  	nr_tries_left=10
>  	while true
>  	do
> @@ -921,15 +995,16 @@ start_git_in_background () {
>  		fi
>  		sleep 1
>  		nr_tries_left=$(($nr_tries_left - 1))
> -	done >/dev/null 2>&1 &
> +	done >/dev/null 2>&1 3>&- 4>&- 5>&- 6>&- 7>&- &
>  	watchdog_pid=$!
>  	wait $git_pid
>  }
>  
>  stop_git () {
> -	while kill -0 -- -$git_pgid
> +	test -n "$git_pgid" || return 0
> +	while kill -0 -- -$git_pgid 2>/dev/null
>  	do
> -		kill -- -$git_pgid
> +		kill -- -$git_pgid 2>/dev/null
>  		sleep 1
>  	done
>  }
> @@ -944,7 +1019,7 @@ stop_watchdog () {
>  
>  test_expect_success !MINGW "submodule implicitly starts daemon by pull" '
>  	test_atexit "stop_watchdog" &&
> -	test_when_finished "stop_git; rm -rf cloned super sub" &&
> +	test_when_finished "set +m; stop_git; rm -rf cloned super sub" &&
>  
>  	create_super super &&
>  	create_sub sub &&
> -- 
> gitgitgadget
> 
