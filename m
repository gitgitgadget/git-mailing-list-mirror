Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE8C43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 16:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbiFAQuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 12:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245136AbiFAQui (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 12:50:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1334AA204B
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654102209;
        bh=dFGH8cV8R+94SERUwUXeo8VOd3Vx3ZAMa4uN5sj3L2o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZmRgXZXHPncglxNNIID2Ekrc/pP8RitzA/qVnoHfw+6e7Esglx97hKlKeRdUn//TE
         KPu4Pblbavnk43hSTzBJLUvynLJknUyHNYijmqxQYYkpnYAL4ItT4MULKDCrytkVxi
         KYgBh9Hb2wrGYKNKh4eWae0qceE8PiTySb87r66o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([89.1.212.145]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1oCk0i2ZS1-00J3EM; Wed, 01
 Jun 2022 18:50:09 +0200
Date:   Wed, 1 Jun 2022 18:50:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 2/2] hook API: fix v2.36.0 regression: hooks should
 be connected to a TTY
In-Reply-To: <patch-v4-2.2-8ab09f28729-20220531T173005Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206011827300.349@tvgsbejvaqbjf.bet>
References: <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com> <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com> <patch-v4-2.2-8ab09f28729-20220531T173005Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1331504414-1654101440=:349"
Content-ID: <nycvar.QRO.7.76.6.2206011850040.349@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:MRqtWGP+oKts+9e3uoBuKnndFhCSgdr//OFtZrwhmZjIpk0z1BZ
 E/bbU8BBFJ2MpMOXAz01DWGP4SXqCzvLgLKdA4SzyeALpxWFfzupWaLqLJXSd5wvvzw+gtT
 Ux0pUH+zGIpJirw9VVTYIkjuiTWKMNc23vnn8DXYEZTs438oNWed60Fs4wE/RrECWPCYc4D
 6HrUM+E0xoYrUAOUkTg4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lDXaumFxsww=:WvuGPPIHVz+ybaYsa1rq5R
 bMJBWHpJCdnnyAq8EaYEz8SeYbpMcPvetgCI8fgVsWUfRTf2KEt+1H8hIYlkrICOmzeoTwiMl
 IsPab7Dz74Xj2os3U8Mfayuq3JxKMZEo1DwyiIkbezB5pE9YT0vzlHeKPSi0q7E8mblVn0R7M
 7ILUub8XB0HAmjyQ2Aa4l1mZ/u4MzUDw3Pfecr9s/3La0q8Qo5MOu7EMCuHVxq7HvzbJMFbx9
 6PCLjvBYgk3rHS1PdqnI2V0x7K/7A1SBxFHeuN+9w6cEFl5M3XpPBx/Z8ncA+JUAaM+5UHxNS
 Fr+Apzx647tua0btR6uD2s00szSPeRBSCxbXOdqckfFuYZVWiefuy0240R/zNva5n2ZRceb2K
 G3S/pPieu8Ml6jYeoJcF2q8Uo42ZWqb84+kbKdo8uAX/fWj8QC61ORsDkbHyWuBv4JzRWR6A0
 yC2mrATDNborPHUdlZCVsPIFO06VKdVhZXuI1h5FAPTAJUtpV3PBfiU0sVlCAMT9TcNrkHqSW
 g9LnPNHzfrNN4v9i5o+Wr5urBxmdRdAaF7mj2dxFY6A7TRWTBsOsjh93fzf4WeZIHzXFCtWDh
 TlgUhqHFsNxOrBviS8JKCR/oVK0eCZVgWCURJRSbSt9yZ1LSxf19VSRPpN+FdizJSKTUv9QvJ
 bB42AuOf9LRm4Q6IrNsoTjGpynTPwixlZGoM1jGH7sAeMPrj+lNySTNqLyPYCKWNdBMBkpWZU
 yA8AjETtV37oT8fmGAshJhs83xauJM23RrHLXw1PRGkjIrJLNzxDZxDAdleb/uTK6sLFZ/zfM
 Iw7AbzWmhbWg9mrHp3KBKshABu8e36AMKR8KWvJerFNtPW80JS5OcXEpO06XfDSzeXGINwNTv
 4+Hc7YZk0/qIJRvrfXnHiloPoO4joLNcm/qVvS+/zsDS514eedy9MUwK0ec3y1VQDcIofSpnw
 3/Ip0f9irbG5Ekdc78HnLfEeZqmPFRig6Hpq0/D9G9sycnAlAfAXLHYGN8ybm4XymNz+21QiQ
 spcELUutntXjc5dgy+tkQCG0RyonGAcRRprzOy3jkvh3rjrnhA/ht5DKRaKJoL2ADs5JbcUSJ
 df6NxWeI+XP1r33HFJLDwiA8njEpJ6sxwydsQf0DPa/ywwHMkiVGrXenQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1331504414-1654101440=:349
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2206011850041.349@tvgsbejvaqbjf.bet>

Hi =C3=86var,

On Tue, 31 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Fix a regression reported[1] in f443246b9f2 (commit: convert

The regression was not reported in f443247b9f2.

> {pre-commit,prepare-commit-msg} hook to hook.h, 2021-12-22): Due to
> using the run_process_parallel() API in the earlier 96e7225b310 (hook:
> add 'run' subcommand, 2021-12-22) we'd capture the hook's stderr and
> stdout, and thus lose the connection to the TTY in the case of
> e.g. the "pre-commit" hook.
>
> As a preceding commit notes GNU parallel's similar --ungroup option
> also has it emit output faster. While we're unlikely to have hooks
> that emit truly massive amounts of output (or where the performance
> thereof matters) it's still informative to measure the overhead. In a
> similar "seq" test we're now ~30% faster:

It is an unwanted distraction to talk about the speed here, when the
entire purpose of the patch series is to fix the regression that stdio are
no longer connected when running hooks.

>
> 	$ cat .git/hooks/seq-hook; git hyperfine -L rev origin/master,HEAD~0 -s=
 'make CFLAGS=3D-O3' './git hook run seq-hook'
> 	#!/bin/sh
>
> 	seq 100000000
> 	Benchmark 1: ./git hook run seq-hook' in 'origin/master
> 	  Time (mean =C2=B1 =CF=83):     787.1 ms =C2=B1  13.6 ms    [User: 701=
.6 ms, System: 534.4 ms]
> 	  Range (min =E2=80=A6 max):   773.2 ms =E2=80=A6 806.3 ms    10 runs
>
> 	Benchmark 2: ./git hook run seq-hook' in 'HEAD~0
> 	  Time (mean =C2=B1 =CF=83):     603.4 ms =C2=B1   1.6 ms    [User: 573=
.1 ms, System: 30.3 ms]
> 	  Range (min =E2=80=A6 max):   601.0 ms =E2=80=A6 606.2 ms    10 runs
>
> 	Summary
> 	  './git hook run seq-hook' in 'HEAD~0' ran
> 	    1.30 =C2=B1 0.02 times faster than './git hook run seq-hook' in 'or=
igin/master'
>
> 1. https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR=
8rAeqUCCZw@mail.gmail.com/
>
> Reported-by: Anthony Sottile <asottile@umich.edu>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  hook.c          |  1 +
>  t/t1800-hook.sh | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/hook.c b/hook.c
> index 1d51be3b77a..7451205657a 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -144,6 +144,7 @@ int run_hooks_opt(const char *hook_name, struct run_=
hooks_opt *options)
>  		cb_data.hook_path =3D abs_path.buf;
>  	}
>
> +	run_processes_parallel_ungroup =3D 1;
>  	run_processes_parallel_tr2(jobs,
>  				   pick_next_hook,
>  				   notify_start_failure,
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 26ed5e11bc8..0b8370d1573 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -4,6 +4,7 @@ test_description=3D'git-hook command'
>
>  TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-terminal.sh
>
>  test_expect_success 'git hook usage' '
>  	test_expect_code 129 git hook &&
> @@ -120,4 +121,40 @@ test_expect_success 'git -c core.hooksPath=3D<PATH>=
 hook run' '
>  	test_cmp expect actual
>  '
>
> +test_hook_tty() {
> +	local fd=3D"$1" &&
> +
> +	cat >expect &&
> +
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +
> +	test_hook -C repo pre-commit <<-EOF &&
> +	{
> +		test -t 1 && echo >&$fd STDOUT TTY || echo >&$fd STDOUT NO TTY &&
> +		test -t 2 && echo >&$fd STDERR TTY || echo >&$fd STDERR NO TTY
> +	} $fd>actual
> +	EOF
> +
> +	test_commit -C repo A &&
> +	test_commit -C repo B &&
> +	git -C repo reset --soft HEAD^ &&
> +	test_terminal git -C repo commit -m"B.new" &&
> +	test_cmp expect repo/actual
> +}
> +
> +test_expect_success TTY 'git hook run: stdout and stderr are connected =
to a TTY: STDOUT redirect' '
> +	test_hook_tty 1 <<-\EOF
> +	STDOUT NO TTY
> +	STDERR TTY
> +	EOF
> +'
> +
> +test_expect_success TTY 'git hook run: stdout and stderr are connected =
to a TTY: STDERR redirect' '
> +	test_hook_tty 2 <<-\EOF
> +	STDOUT TTY
> +	STDERR NO TTY
> +	EOF
> +'

Instead of spreading the regression test out over so many lines, a single
test case that verifies what needs to be verified succinctly should be
plenty sufficient. Something along these lines:

	test_expect_success TTY 'hooks are conencted to stdio' '
		test_when_finished "rm .git/hooks/pre-commit" &&

		write_script .git/hooks/pre-commit <<-EOF
		test -t 1 && echo "stdout is a TTY" >out
		test -t 2 && echo "stderr is a TTY" >>out
		EOF

		test_terminal git commit --allow-empty -m hooks-and-stdio &&
		grep stdout out &&
		grep stderr out
	'

Not only is this much easier to review, not only is it more obvious what
is being tested, it is also much quicker to debug in case it fails.

Ciao,
Johannes

> +
>  test_done
> --
> 2.36.1.1103.g036c05811b0
>
>

--8323328-1331504414-1654101440=:349--
