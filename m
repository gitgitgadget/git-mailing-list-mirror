Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75CC21F453
	for <e@80x24.org>; Mon,  4 Feb 2019 18:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfBDS0d (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 13:26:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40325 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDS0c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 13:26:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so911501wrt.7
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 10:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XZxidXuwdsbMfqPEzWH43rGN+KoiNKYgOpVY2q+yHOA=;
        b=Sm5wUrHc42H84RBTUECpHERmGl/3SI34fSzg2e36HRJzzxajWOWr64vYWX1t4APnyO
         fTCStHLUdSrGCR3/Hh/NbXFPz3y5BhiMBZa6c/exMtP9Hs85jQpXFkP+jgeaXzXJ7bin
         TOEOVGylFPomXmoisHNHYrUwMRHOcYnij0cCRpAub4rOHF9PeHmubDHE8mw/t8tuNNH6
         OT9OZGGECl3ImrbylTm8WFCbG3aX9NqPHTNZ+eNa3AiUooDW+9qmsnUO4MeqVscbxONH
         DRU8aaUDVMN2IVquaZow2KDms5qGIUCLXVuy27YlVdcb8Q1sqBxi8+T5GWZ3g6KVKSex
         c7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XZxidXuwdsbMfqPEzWH43rGN+KoiNKYgOpVY2q+yHOA=;
        b=SNefn6bFxzG77ifipQnZzmutFlHbTTqhLm/N7suGFH2HvncylZXbpPs9zt7FqiNAIo
         A3Lj0kGBcqyZdhO322lVLTVe2pwnDVTx7JobBo6G74AGU7zkWherOwVDOz1ddxatI6zl
         3PeQ5fgJQxjdTsrr0V+rE9BUr3DXINVXt5wkqQcAXCj2WmvIKfoMT2eI2yKL/vQa8dCq
         2WUAzyQFrvT0ZOvFeMhNrcr0ShKxVswhqSXhuckm9hr/uYDlq4RDrNoV4/PZLM8OQAnV
         wHbH+DtLBv3RoLoahpq4bHzU7NWMp7/K7KYeLubSObuVTjg9Q62Upe7/YqZDS+yumfHP
         jLgA==
X-Gm-Message-State: AHQUAuauMij+PCVwgeAN5c90PB97I6RjuVZKSeZLInH4zZnZfRSLhLH/
        /Te5vmLG0VMjjan5QNAKNiQ=
X-Google-Smtp-Source: AHgI3IaiaX8ZflokMJ7OuAON+/so4B8PvMCLPgps9TD5AkiDreled7qDITQ3x544MQ3AnLs0s1oMog==
X-Received: by 2002:adf:fd03:: with SMTP id e3mr535507wrr.280.1549304790617;
        Mon, 04 Feb 2019 10:26:30 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b13sm5303658wmj.42.2019.02.04.10.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 10:26:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: make the OSX build jobs' 'brew update' more quiet
References: <20190202163421.19686-1-szeder.dev@gmail.com>
Date:   Mon, 04 Feb 2019 10:26:29 -0800
In-Reply-To: <20190202163421.19686-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sat, 2 Feb 2019 17:34:21 +0100")
Message-ID: <xmqqk1ifv296.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Before installing the necessary dependencies, our OSX build jobs run
> 'brew update --quiet'.  This is problematic for two reasons:
>
>   - This '--quiet' flag apparently broke overnight, resulting in
>     errored builds:
> ...
>     I belive that this breakage will be noticed and fixed soon-ish, so
>     we could probably just wait a bit for this issue to solve itself,

Yuck.  Well, an external influence that can break the automated
build job overnight should be capable of fixing it overnight ;-)

>     but:
>
>   - 'brew update --quiet' wasn't really quiet in the first place, as
>     it listed over about 2000 lines worth of available packages that
>     we absolutely don't care about, see e.g. one of the latest
>     'master' builds:
>
>       https://travis-ci.org/git/git/jobs/486134962#L113
>
> So drop this '--quiet' option and redirect 'brew update's standard
> output to /dev/null to make it really quiet, thereby making the OSX
> builds work again despite the above mentioned breakage.

Sounds good.

>     There is no conflict with Dscho's Azure Pipelines patch series; the
>     patch contexts overlap a bit, but the auto-merging results look good
>     to me.

Thanks for extra careful.

If this is truly urgent, I could merge this to 'maint' and merge the
result upwards to 'pu' and it would hide the issue on my four
integration branches.  But one thing that makes me wonder is if we
can (or want to) do anything to help other people who test build
with pull requests.  I guess they need to rebase on top of whatever
commit that has this fix?  That sounds more like a tail wagging a
dog, though.  I dunno.

>  ci/install-dependencies.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 06c3546e1e..5968efdbbe 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -34,7 +34,7 @@ linux-clang|linux-gcc)
>  	popd
>  	;;
>  osx-clang|osx-gcc)
> -	brew update --quiet
> +	brew update >/dev/null
>  	# Uncomment this if you want to run perf tests:
>  	# brew install gnu-time
>  	brew install git-lfs gettext
