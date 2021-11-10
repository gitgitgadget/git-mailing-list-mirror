Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17DCC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 13:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70EE61211
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 13:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhKJNjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 08:39:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:57121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhKJNjh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 08:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636551396;
        bh=i4REs2j78Ot1BtO5MWDW9k11Kmmh+/0A4mdY4Puk0js=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AvBbQk1qzAQfaea9yKS9c0xWBtT22HP66ZJZcHodnxiOBsr9p177H+Pr69x079jAC
         EwCc/ITE7fR6eV7X4c0WCiq04WGHFfB7NbgfxyyiQ5nMofNacds2Lt/5LO3XWljJpY
         Xy8M1Sl6YMU/MsAOIgYY31PhXkjxWYkWqGm6VLH4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlTC-1mKqsU21B8-00jsux; Wed, 10
 Nov 2021 14:36:36 +0100
Date:   Wed, 10 Nov 2021 14:36:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?L=C3=A9na=C3=AFc_Huard?= <lenaic@lhuard.fr>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] maintenance tests: fix systemd v2.34.0-rc* test
 regression
In-Reply-To: <patch-v2-1.1-44f0cafa16e-20211110T035103Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111101422030.21127@tvgsbejvaqbjf.bet>
References: <patch-1.1-90172a8ddcc-20211102T142351Z-avarab@gmail.com> <patch-v2-1.1-44f0cafa16e-20211110T035103Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-601884668-1636551396=:21127"
X-Provags-ID: V03:K1:2DjITNE/QwrqzrzK69/+d6NubY29hXrdnmhP9J0MM2E4G6SMVQb
 rW5uxUkGQvLDS9x2DEQwOXvTc4Gk9FqpK9iTy6YfBT1iv8nIJh9RGgAWOEwqFOOiG78XUat
 I3KMoh9A6Excl7W7CBjFRy228AmKmf71PIXHWC9Y9oIOfDLnCuKldUI9JiCMHnQkOad9Eow
 UoPNYKQWYp7zQ21Nh4W1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2LxanTbWKxQ=:8qrcmCKGP6QluPAUfNRSih
 TKOVrnCLNZpLKhqZ0qoTuahZzar48fBbNN6SKOxzNtL1QWKncn7hjk0yHIkWulQV9lia8rIIa
 ZXYLaC2jA2Cn2W9IbBgDmhvkKO/OenszprINnLVKZgoY3Pfn8FYEVLUllYo8miTXmzfMtsR4Z
 8SQ1yA9taEuzQJl8VQWODlJcnbxswsPvgMcRmyBtU5QfXxFKlaBTlBNso1Ly3r2h4NZwroSgr
 nrrnUjjIO7Icxqdo00Id+y+ipLSZ5g5JLt6cQrp+MAXR8GDcK22jrEC9P1nacVt/QBjVVxTrR
 yKr1U8u1qEwp0UUT9Kk7j2ovSkDW9h8El4qbTqfEYFb5kEYcMTT/wrQT+v8TeawgdIi/yHr+b
 wKjmZLEOG1OwEK06CT5bGR/lW3CE4hqyPM0F+ZxQ3GTbjOab2H9e2QjxacQv3uED4f2fEuDM/
 40cD3sz/bZ0xLNQiAtsI1ZWi2rGuWHMUJ13sU2CTvxdv8IgBUPGp2Z6Y77G8QiD7OEzXtwzDb
 IoFkIdqJuSE0mCTv6ekORr56hrkudzSiA4Wf39rSC1xRpd4gTd35QN4GLb1q5VWSpO/al65im
 Muejd9hBZ4DNRK3yMC2cyIr/kk3wqBdus86IbeBHuvEKjK4U6tACqw3qxnE/df/ZqD9Vozdwb
 Z4Qf4FYanoUEr7S7nrIDcyslxQX2dNe2VJNSzLREFywF7ote3U+IZ9jAJ5Wo+K3uDqYRDdWip
 EiLLRYHNLW+9Wp7AhntMJYYAPcLfefm+MjbnQd0x49Jq4hGp/UVIRCe8XyadQyuOrmofSe1Qw
 MLXr9yFek13cjx0KHclxtA21A0zvikesjy6fFz4ImmZWt1cE5Lk5GpYn9NIvQI5/sRDXcF9jO
 +lGKkDikT8EcGTwu+MVDiWyOl0a1A0t+7X2oJVHYPJLKOUzTBBKs8cBMyD3H6iHaQMWO3c3Q0
 NDxJgQQENbKNbckQvsU9lFjeCVbM4NiGfRurF4wflNhcqKWB56QPmicJOUNRMZ98GT3NsRiDZ
 shE8vSRtqjOSyJYKpnQWU5F/vS4PRt3D09yIqN0sG2HmnB9SgfFCtJGmnwmHHWfqARZ88vJwq
 wF4CW/SBaWBZE8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-601884668-1636551396=:21127
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 10 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Fix tests added in b681b191f92 (maintenance: add support for systemd
> timers on Linux, 2021-09-04) to run successfully on systems where
> systemd-analyze is installed, but on which there's a discrepancy
> between a FILE argument of "/lib/systemd/system/basic.target" and
> "systemd/user/git-maintenance@.service" succeeding.

Could you try to rephrase `there's a discrepancy between a FILE argument
of "/lib/systemd/system/basic.target" and
"systemd/user/git-maintenance@.service" succeeding` more clearly?

Also, commit messages in git.git should not assume that every reader has a
profound knowledge of `systemd`. The commit message needs to do a better
job at explaining what is broken in the first place. The CI runs pass,
after all, so it is unclear that there is anything broken that would need
fixing to begin with.

> There was an attempt to work around previous breakage in these tests
> in 670e5973992 (maintenance: fix test t7900-maintenance.sh,
> 2021-09-27), as noted in my [1] that commit is wrong about its
> assumption that we can use "/lib/systemd/system/basic.target" as a
> canary.argument.
>
> To fix this let's adjust this test to test what it really should be
> testing: If we've got systemd-analyze reporting anything useful, we
> should use it to check the syntax of our just-generated
> "systemd/user/git-maintenance@.service" file.

What is "anything useful" here? And how can we use the output of
`systemd-analyze` to check the syntax of the generated `.service` file?
This is all very unclear.

> Even on systems where this previously succeeded we weren't effectively
> doing that, because "systemd-analyze" will pass various syntax errors
> by and exit with a status code of 0, e.g. if the "[Unit]" section is
> replaced with a nonsensical "[HlaghUnfUnf]" section.
>
> To do that ignore whatever exit code we get from "systemd-analyze
> verify", and filter its stderr output to extract the sorts of lines it
> emits on note syntax warnings and errors. We need to filter out
> "Failed to load", which would be emitted e.g. on the
> gcc135.fsffrance.org test box[1].

The domain name is not as interesting as the verbatim error message would
be.

> We also need to pipe this output to FD's 5 & 6, to avoid mixing up the
> trace output with our own output under "-x".

We do not need to pipe to file descriptors 5 and 6. Other file descriptors
would do, either. We need to redirect away from 1 and 2, is what this
sentence should say.

And the hint about `-x` suggests that even that is not true that we need
to redirect 1, either, just 2. And we would only need to redirect 2 with
shells that do not understand `BASH_XTRACEFD`. It would be best not to
mention `-x` at all.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 74aa6384755..5fe2ea03c1d 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -20,15 +20,16 @@ test_xmllint () {
>  	fi
>  }
>
> -test_lazy_prereq SYSTEMD_ANALYZE '
> -	systemd-analyze verify /lib/systemd/system/basic.target
> -'
> -
>  test_systemd_analyze_verify () {
> -	if test_have_prereq SYSTEMD_ANALYZE
> -	then
> -		systemd-analyze verify "$@"
> -	fi
> +	# Ignoring any errors from systemd-analyze is intentional
> +	systemd-analyze verify "$@" >systemd.out 2>systemd.err;

The semicolon is superfluous.

It is a bit sad that we're now doing unnecessary work when
`systemd-analyze` does not even exist.

> +
> +	cat systemd.out >&5 &&
> +	sed -n \
> +		-e '/^Failed to load/d' \

Lines starting with the prefix `Failed to load` are now deleted. Okay.
Nothing in the commit explains why we can safely ignore those messages,
though.

> +		-e '/git-maintenance@i*\.service:/x' \

Lines containing `git-maintenance@.service:` (or the same pattern with an
arbitrary number of `i`s after the `@` character???) are exchanged with
hold space.

That does not look right.

Since this is a `sed -n` call, we would need an explicit `p` command to
print anything. Therefore, the current code is a pretty expensive
equivalent to calling `true >&6`: it succeeds, and it does not print
anything.

> +		<systemd.err >&6 &&
> +	rm systemd.out systemd.err
>  }
>
>  test_expect_success 'help text' '
> @@ -697,7 +698,11 @@ test_expect_success 'start and stop Linux/systemd m=
aintenance' '
>  	# start registers the repo
>  	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
>
> -	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" &&
> +	# If we have a systemd-analyze on the system we can verify the
> +	# generated file.
> +	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" 5>=
out 6>err &&
> +	test_must_be_empty out &&
> +	test_must_be_empty err &&

Since the function name has the suffix `_verify`, the verification part
should be _inside_ that function, not outside.

This patch is not clear enough to tell whether it actually fixes a
regression worth fast-tracking into v2.34.0 or not.

Ciao,
Johannes

>
>  	printf -- "--user enable --now git-maintenance@%s.timer\n" hourly dail=
y weekly >expect &&
>  	test_cmp expect args &&
> --
> 2.34.0.rc2.791.gdbfcf909579
>
>

--8323328-601884668-1636551396=:21127--
