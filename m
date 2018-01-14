Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5C61F406
	for <e@80x24.org>; Sun, 14 Jan 2018 10:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeANKhJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 05:37:09 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:47038 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeANKhI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 05:37:08 -0500
Received: by mail-ua0-f169.google.com with SMTP id j23so1409091uak.13
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 02:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cVl+WMbw3aa1gX4JJvT1aLR6YsZoufVLm9BHx4gTmBE=;
        b=ugvbKJcQrYAG4YYmWqu+EECX/u1QGTNbMSf6mS1w9OEXC0qljb5msJwNQT2XgBPW4F
         SWxRf21u6i4rmgSqGgdFZF2BpjGXWfwnt0lhXCKuORCzL34ABfyMpVPhWNKz+aBFfE1W
         KxYz+E/b99F+Wj9/eSsuZNgxXw4AykpzGLG5fq46t+uakD0TFU3hIgBBHDryahbcN2k0
         W7J2bud0AlreOJAtN0k4MQMzAgl2rg5pdLE49DaS4qXp4MaMipv7fwk+5Zt0d47dlhDU
         OG5EnrOarUn9SV5yBVtzCR4ms0wr+hsMrqjGsu/Iz3s2sqQhDjn3spkMOqxIeRrL7/Dy
         T37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cVl+WMbw3aa1gX4JJvT1aLR6YsZoufVLm9BHx4gTmBE=;
        b=UYAlTjsDYHsyxmLeLFvJQu0LYdK+Qm5i+Nz2+ATlbnbVPk9MfDqDBcgwR0xTCKHOqb
         jufSGGgxU8CkiY97afvPolIOlm2cyHnSv8i+5IM3ApSoyOVlyNrHS8m8faBEEcfHi/aj
         lww3r/ViHGT3VYbQJa0ZsAs/dGDfb8/6OpqtZxAUIGl7O371B+R4W6TuV6oCxYVrWphg
         D0qYWoXvOK+pbnz0uxiUAcgJnuUAIJ0/Ld4oFVqbDtImfOnw4N2mqOSVPL2+RP7eTe8l
         Tu+PqwIyvV91wds/l8sw7njxPJ0Z7YxzU/t/WZYx0Azh8OkDXGal6VpVtGKv6D8f31WD
         4pkA==
X-Gm-Message-State: AKwxytfTSGe1fhqyPiagBRnVlzWtDiisopP+wfVnHOhBgV3dKxT1OYQa
        YiPfMzFL6r1bwJlV5kCsXL6nxCBFybZRmmhwOHI=
X-Google-Smtp-Source: ACJfBovPYmVqJrd5da2PK0kFAwatxAfU0sWmy2xxjeLZd1qqiYRsIUEUtQ6AIiQnEcxwCGtkC019XOhmB//FVTsoaXE=
X-Received: by 10.176.96.4 with SMTP id j4mr16454019ual.180.1515926227761;
 Sun, 14 Jan 2018 02:37:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.10.140 with HTTP; Sun, 14 Jan 2018 02:37:07 -0800 (PST)
In-Reply-To: <20180113103255.GA31117@sigill.intra.peff.net>
References: <20180108172214.23615-1-szeder.dev@gmail.com> <xmqqvagc6m42.fsf@gitster.mtv.corp.google.com>
 <5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com> <CAM0VKjnSzoc+E408ifKCg+qPTaGRNL3e3JVdRN573kdcBSzbHw@mail.gmail.com>
 <20180113103255.GA31117@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sun, 14 Jan 2018 11:37:07 +0100
Message-ID: <CAM0VKj=QrDr9671uMGKSSZUczB-Soc5mmoijiBsx8t_WkQa6+w@mail.gmail.com>
Subject: Re: [PATCH] travis-ci: build Git during the 'script' phase
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 13, 2018 at 11:32 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 12, 2018 at 02:32:54PM +0100, SZEDER G=C3=A1bor wrote:
>
>> That's the just beginning of a looong list of executed test scripts in
>> seemingly pseudo-random order.  IMHO that's very rarely the interesting
>> part; I, for one, am only interested in that list in exceptional cases,
>> e.g. while tweaking the build dependencies or the 'prove --state=3D...'
>> options.
>
> Aren't folds supposed to do this? I.e., record all the output but only
> show it to the user if the command exited non-zero.
>
> According to:
>
>   https://blog.travis-ci.com/2013-05-22-improving-build-visibility-log-fo=
lds
>
> they auto-fold individual commands _except_ the ones in the script
> section. Is there a way to manually mark folds in the output?
>
> Hmph. I could not find an answer from travis, but googling seems to turn
> up that something like this would work:

Oh.  I did look for something like this in the Travis CI docs, found
nothing and then didn't bother with Google.  Rookie mistake, I know :)

But indeed, have a look at the raw trace log at:

  https://api.travis-ci.org/v3/job/328418291/log.txt

It starts with that "travis_fold:start:..." thing right away.

> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index 07f27c7270..8c830aa3c0 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -77,6 +77,23 @@ check_unignored_build_artifacts ()
>         }
>  }
>
> +fold () {
> +       printf 'travis_fold:start:%s\r' "$1"
> +}
> +
> +unfold () {
> +       printf 'travis_fold:end:%s\r' "$1"
> +}
> +
> +fold_cmd () {
> +       local name=3D$1; shift
> +       fold "$name"
> +       "$@"
> +       local ret=3D$?
> +       unfold "$name"
> +       return $ret
> +}

We don't have to fiddle with the return value, because we run (almost
all of) our build scripts with 'set -e', i.e. if the command fails then
the script will exit immediately.

> +
>  # Set 'exit on error' for all CI scripts to let the caller know that
>  # something went wrong.
>  # Set tracing executed commands, primarily setting environment variables
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index d3a094603f..12b2590230 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -7,8 +7,8 @@
>
>  ln -s $HOME/travis-cache/.prove t/.prove
>
> -make --jobs=3D2
> -make --quiet test
> +fold_cmd compile make --jobs=3D2
> +fold_cmd test make --quiet test
>
>  check_unignored_build_artifacts
>
>
> I've queued a CI job to see if this actually works. :)
>
> -Peff
