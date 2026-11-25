Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795633782;
	b=fI68vpIe0y/k2vgwQETHqH1yiK94syri37o/23tq7/zw/I1KUG1dIUUfQBzOXE+JPn6f
	 m+29WximTHGvmShuG39x1cAay0b83C3oe6uE7EOcgezzP5ExVthwzF8mEoc+/CJ0GpHk4
	 q9uY2evbfv042h5kiK1h1AmAH/6BEbsrJOKt3zwKugSq69ni5UzH51KUv9pKzqWDKlyH/
	 gZaFPSVWCJLN6PCviQvzvNMS3i5VKN4LI/RqOiW3Tr/xgTViKzbRFHfRipU3GUUOxJ/62
	 EM8Ax66Q9eHicQM7pnd+3cMswPxXKR/8y61G33+SIwwV4BU/+n67222pI1BtXQhXdCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=BJ7INbFooR7em1w5qKUdv1VXkTgwRbOhsKIVZVe6EPE=;
	b=kCf6176mIKRhq2WlEOOXBQWeZDo9U4bqb3pvlIKUZZ0ZLnaVZyJsu38o9PG4I4Cp0/mp
	 +4xOXWcBCRj1sFSTcUvLzAmbXkRNI/i65VSPUQYUfCwfbNIg7X/B9E85WNe4zfGBLlUTs
	 nf32QweH6CEUISYZWRMymdXp9jjk/qsL6eaDX+5to+gIVtqEE2zDncoB4ryiaN5g9Isxd
	 ZhKcuGb0ih7Lu2WGW2+A63inho3Dwsftx0OMvk26fs0KsfzqxMZvkRV7WgqMrmtHmnSdi
	 4OkSKrbQfhvjBP1rwb0XPKwJDhdcJgSdkWyCrMhyhdzjy9HwsQNQQ6bi3konbmTSdxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FeWqNsEU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665F606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4665F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FeWqNsEU
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b87a240de3so7799636a12.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:09:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795633781; cv=none;
        d=google.com; s=arc-20260327;
        b=UGZoeMNICS2D2r1t7EFCc4ianK9j15HmmWo+Z+Jsd+wkMpoO/Bw2N9E2af8YQepjmQ
         DqU/dnuNzuN3itC+a6WmSnKkj6YB228JUBlMdZ6C1nVEDhY444SUlxZtIeE3Pqmddfqb
         W+9xNYaySJDJDYU2aS1om2KQOKqnOd/NLZ4sTm3ccLrjiLV8XZDCFTRL8Ks04RLxWDAZ
         b80Pxl2E81/Uz5tE1XBwfbcSKq7Xcut5apPqtB2pIPuYVogjDKBCL6wUcsRDnubUc/L6
         aX4kZMDrcBGRkuO9iaL0MNb078krnDsB4mrgoPVOoT/x7cMqUnQTyTnAsMoG2oK/90Gw
         0u8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BJ7INbFooR7em1w5qKUdv1VXkTgwRbOhsKIVZVe6EPE=;
        fh=1phDC3yz1lxe32tPkWHEVzddhF4Zqux1hAbeDwm4P5Q=;
        b=mVdzCmimOPDRYMJ7q+7FE8D91DtAliFcImmPXW0n8iihCRYI2ZY7AnfDIoKTR1a9Ku
         XCyrsiKgP1ZLJFxAOYEm4XAMMukOxYiRkThkFsWfvzvLv9Lw9nRQPw72v9ujfYhSZRri
         wRQ5xWJ4g4JB/bwD9ZtIOfqSJanmutQv8Mgf5ZkZEqd3+JQWZ2PWiYZsy2wtknYLPKjO
         ruk/ofNcQrTzhRie6g+yaU1iETkhU7O+dS+CNIpMi6jPH9ELdoSSzpiXs+SQv8rL9ZOc
         RlLacQyFkc7xejC/+IfnZadn8XmBees3OnxJiudPc6cAyvLHUWImni42d0pdy3TChkU/
         dHBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633781; x=1796238581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BJ7INbFooR7em1w5qKUdv1VXkTgwRbOhsKIVZVe6EPE=;
        b=FeWqNsEUK349eRIHpYPfTPCIViWei7tn/33mQ0pEYsOILhLph8TrNpj/ItRYa24sgS
         lUr+VJYGwJ1z/uDyEs+VG6Mzi1BdLfdl47CFtgmRjOGXTChDNp2ekQ+N8zF/tYOQHSf9
         B+IbH5QREiFklGCHVc26d0EiQUyqXIA3yN50+wiVNtzltz2BuZILEgIFI14TkIYb34X1
         wmVlZJM12sLS5jW/uzXfnRBI7vQqzkahrEvjQGiCMALzrpygSn9lzw+V/SyV8oeinFNF
         4exmEW6jfGy2IF178UdvGuljfBOqJhSUUTB0R1F17M/ga6JI891k3pAeTCfIk2Ttv9nz
         gRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633781; x=1796238581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJ7INbFooR7em1w5qKUdv1VXkTgwRbOhsKIVZVe6EPE=;
        b=vaYKCJgA/Yz/r6EJnOKhGvSTukKeTEcLtG/6Wkg3B+tnd0ogPcJnv1pe9KpyBSHHDq
         D8gMNysZcuWS1g4ANGt7BdYd4iLw0W1NGZXU22U9fwe9z0z1UUptw+1bFFAP5AkipdOh
         fDCq2ttuu4IChkeo0XD12BiCqGt5sOWCy8sWWpfdrTRojH4XFz2yhFeelfa/2a8pj04N
         plRkchacQXW5Cdija08YcPt6wifmOAzz07bWw3tZrqdOl3jp70cTxHgO6vsU7gcH7cFX
         ATXVWls113O3nIuGR+QtSCINETMQsRi34Kk4toMaCWYx2Q4xtqrt9zRhQtLl+rWaxELn
         wuZA==
X-Gm-Message-State: APuU4Z/ZEUwDdnsQcm2mlvgoyPcY8eM4MiwTY6E1IYJCIc85JSNuviiz
	l3CVum0IEwg22JUDBnuGS5wEgb3e69QCLbaC3qASjflU7N+PXZ7jm0kyug52oKuMPVZ/QAKC/m+
	jVt11/OxaRSWkcw+K9gQKUFZYv6sOeANiWA==
X-Gm-Gg: AZFdTZeU3vNq4wBXSmwGEZ2eoyb6fDGemBoioooqMV72XI8IQfaaJ/7cCzbyAh06sgJ
	tF/Pgo7cVoP619413boVso2WdzP1nMlKAkso6A/EGtsPWT45m9IuF3m74I9/6C5Lp26EA6TjfC9
	/swOed8G+QYLHVhQWTHDbAVQNA2j0frod18VHxcpu70l6RQbVTbKA+x1mlu+AwpMD5YM00qxrWH
	cduIOBX5jC9DyZDbvL3Z6XjJITwjGusvOVQhWUf4iO5Ul9fDZ1MLCO/miBR5FrPwZ1VW7si71ca
	LgQoF4W+D+3VugCdt/CYwk1nKZk0MmaofEE5eUUPOeZXI5jNHezJB6BdiH8IX/AebwJpFZoBfI6
	yyaF5LWvRQz8rGY167CKHygf1/HIFB8uZAkI77Q==
X-Received: by 2002:a05:6402:4028:b0:6bb:791:ff67 with SMTP id
 4fb4d7f45d1cf-6bb079203damr4540099a12.5.1795633780306; Wed, 25 Nov 2026
 11:09:40 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com> <20261119-ks-ci-long-test-hang-fix-v2-1-37011c08380d@gmail.com>
In-Reply-To: <20261119-ks-ci-long-test-hang-fix-v2-1-37011c08380d@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 25 Nov 2026 20:09:03 +0100
X-Gm-Features: Aa3M54oX1xljZc8gZL522FG-btTJBDtbHRGVGponDgWaavwGwOhLFINwEuo6qBk
Message-ID: <CAHwyqnXT=WP8PuY5hfuLzvfBu23P8z_PF3Jv60gTuOHRwY+6GQ@mail.gmail.com>
Subject: Re: [PATCH v2] test-lib: run EXPENSIVE tests one at a time
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Great idea! Hopefully we can get this merged soon to unbreak the
GitHub CI pipeline.


Harald

On Wed, Nov 25, 2026 at 8:08=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Recently, we've acquired quite a few expensive tests in our test suite.
> For instance, these commits add several tests that require
> multi-gigabytes of memory:
>
>   - 9048b48fb (t1600-index: add expensive tests for over-long
>     tree paths, 2026-10-16) added tests to t1600
>
>   - 288266c11d (xdiff: use size_t for merge buffer size computations,
>     2026-10-16) added tests to t4300
>
>   - 55c54fd375 (apply: reject binary patches greater than MAX_APPLY_SIZE,
>     2026-03-25), added tests to t4141
>
> We also have the memory hungry 5GB filtered hash-object test in t1007.
>
> When GIT_TEST_LONG is set, "prove --jobs" happily runs several of these
> at once. On the 16GB GitLab CI runners this exhausts memory: the
> sanitizer jobs have been hanging in t1007 until they hit the job
> timeout ever since the new EXPENSIVE tests in t1600 started running
> alongside it. Running the two under a 16GB memory cap reproduces it,
> with the t1007 git process getting OOM-killed.
>
> GitHub CI runners are no exception and observe the same behaviour.
>
> Take a lock shared by all test scripts around each EXPENSIVE test, so
> only one of them runs at a time. The lock is a directory in
> TEST_RESULTS_DIR, created with mkdir(1) like the existing valgrind
> symlink lock. It records the holder's PID so that a lock left behind by
> a script that was killed with SIGKILL gets taken over by the next
> waiter. It is released after the test and its cleanup finish, and from
> the EXIT trap when a script dies or is interrupted while holding it.
>
> Cheap tests in the same scripts keep running in parallel. Only the
> expensive ones wait for each other.
>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> In recent times, we've been noticing the sanitizer jobs (linux-leaks,
> linux-reftable-leaks, linux-asan-ubsan) hang and fail with timeout in
> our GitLab CI runners. On some digging, it turns out that this is
> because of multiple memory hungry tests running in parallel.
>
> So, I thought of suggesting this patch to serialize the expensive tests
> at least to avoid the putting the CI runners under memory pressure.
>
> The GitHub CI runners also observed the same behaviour.
>
> Both CI runners are happy with this change.
>
> GitHub: https://github.com/sivaraam/git/actions/runs/43281285339
> GitLab: https://gitlab.com/gitlab-org/git/-/pipelines/3079929506
> ---
> Changes in v2:
> - Corrected commit messages as per Patrick's suggestions
> - Tweaked the shell function comment to avoid mentioning 'prove --jobs'
> - Made the owner and waiting variables local within acquire_expensive_loc=
k_
>
> Link to v1: https://patch.msgid.link/20261119-ks-ci-long-test-hang-fix-v1=
-1-45c2fff6d9f0@gmail.com
> ---
>  t/README      |  4 +++-
>  t/test-lib.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/t/README b/t/README
> index fd7e8504b5..c156dd3af6 100644
> --- a/t/README
> +++ b/t/README
> @@ -117,7 +117,9 @@ appropriately before running "make". Short options ca=
n be bundled, i.e.
>  -l::
>  --long-tests::
>         This causes additional long-running tests to be run (where
> -       available), for more exhaustive testing.
> +       available), for more exhaustive testing. These tests can use a
> +       lot of memory and disk, so only one of them runs at a time, even
> +       when several test scripts run in parallel (e.g. "prove --jobs").
>
>  -r::
>  --run=3D<test-selector>::
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index c56654b7c5..193bf06aea 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -784,6 +784,7 @@ die () {
>         # test script run with '--immediate' fails, or when the user hits
>         # ctrl-C, i.e. when 'test_done' is not invoked at all.
>         test_atexit_handler || code=3D$?
> +       release_expensive_lock_
>         if test -n "$GIT_EXIT_OK"
>         then
>                 exit $code
> @@ -1089,6 +1090,43 @@ fail_117 () {
>         return 117
>  }
>
> +# EXPENSIVE tests may need many gigabytes of memory or disk, so two of
> +# them running at the same time can exhaust the machine.
> +#
> +# Allow only one at a time across all test scripts that share
> +# this TEST_OUTPUT_DIRECTORY.
> +expensive_lock_=3D"$TEST_RESULTS_DIR/expensive.lock"
> +have_expensive_lock_=3D
> +
> +acquire_expensive_lock_ () {
> +       local owner waited=3D
> +       mkdir -p "$TEST_RESULTS_DIR" || return 1
> +       while ! mkdir "$expensive_lock_" 2>/dev/null
> +       do
> +               owner=3D$(cat "$expensive_lock_/pid" 2>/dev/null)
> +               if test -n "$owner" && ! kill -0 "$owner" 2>/dev/null
> +               then
> +                       # The holder was killed without releasing the loc=
k.
> +                       rm -rf "$expensive_lock_"
> +                       continue
> +               fi
> +               if test -z "$waited"
> +               then
> +                       say >&3 "waiting for another EXPENSIVE test to fi=
nish"
> +                       waited=3Dt
> +               fi
> +               sleep 1
> +       done
> +       echo $$ >"$expensive_lock_/pid"
> +       have_expensive_lock_=3Dt
> +}
> +
> +release_expensive_lock_ () {
> +       test -n "$have_expensive_lock_" || return 0
> +       rm -rf "$expensive_lock_"
> +       have_expensive_lock_=3D
> +}
> +
>  test_run_ () {
>         test_cleanup=3D:
>         expecting_failure=3D$2
> @@ -1103,6 +1141,12 @@ test_run_ () {
>                 fi
>         fi
>
> +       case ",$test_prereq," in
> +       *,EXPENSIVE,*)
> +               acquire_expensive_lock_
> +               ;;
> +       esac
> +
>         setup_malloc_check
>         test_eval_ "$1"
>         eval_ret=3D$?
> @@ -1115,6 +1159,7 @@ test_run_ () {
>                 test_eval_ "$test_cleanup"
>                 teardown_malloc_check
>         fi
> +       release_expensive_lock_
>         if test "$verbose" =3D "t" && test -n "$HARNESS_ACTIVE"
>         then
>                 echo ""
>
> ---
> base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
> change-id: 20261117-ks-ci-long-test-hang-fix-008e72fd40c6
>
>
