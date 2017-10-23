Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB3D202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 22:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdJWWdO (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 18:33:14 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:50499 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdJWWdN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 18:33:13 -0400
Received: by mail-qt0-f172.google.com with SMTP id d9so21404683qtd.7
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SPwWheLJGF3DeTLoTchg/CBRog63dhNc+cyukf3Hmrw=;
        b=hHXBmnFisZWhtSUDF/u4VBKtrou+Aw8tK8EI5mwcH1GK6vML1g/hFT5im8yHYwmOA6
         8k6ocZlGLahtIMR8Ts/FPGzUlm7NqxSY5eFqPAuo7GhvaIQ/0NiJFJ0AgXpBoB+6xa8k
         33Q42N+eU/RrPHnSd9xgNeTXnJXFN+weKcFBcOlUqy44Lk3IpOoktswSpDNELBIMgveT
         1TZNRLt0VFMhhS+le090jc937QvxJizogAGyCAkkvwicUt/dkG/Lus2qpdri0isk7pxQ
         0a4/1M2vpwMLT9atE3s0UtEJFTxSNBmx/nB0n2rpq+BXWXKmeNagFpKs9waNF3PgUcwm
         Mwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SPwWheLJGF3DeTLoTchg/CBRog63dhNc+cyukf3Hmrw=;
        b=tHgQcwM4AQS8grpoNmYzc5613chvFGfOmkUpqIv0Bs+hENrpSJKCcogbfwtJltQpHm
         MNBt2nOqXQJAxRWMPzk94QaIeMifpLHHFdooCvw80hfgn2iuPgSYFRnFLtGDNPH07GzL
         QWZk81/WCBNA5bAeF5N4nSB330EPLoSPR15yxS6yDcm2GQuI3UCXTPqhTLBcoMIw7iRX
         ptwTi89nnudAGypTk9TLD4vjF3CVtxokFSwMy0Hxg/vHYuhp3ZrqPFJOztpyomj8AzC4
         76PVuEy8ouOIFBf/Tgq9HCrYRPxle57PJxJTwJbQvQqJsaosncoGfS4xgO7ZScG6496R
         9SIQ==
X-Gm-Message-State: AMCzsaXHhrrnNZV+gFh55EzIOvvgF2Q5Q6K4PjoH1joDPmjpCklF5EIw
        lAY6gVzubJKxI7LChCigp5F5n+exRkRlhpGGU1TRbg==
X-Google-Smtp-Source: ABhQp+Rs4Bm7Y/3VKNv9mdqC3eRq/5iGd49jslSYrCD3eDqfmTALqnmFGdohBM53APpflCvum6vQD4gmCLNKXvkFYf8=
X-Received: by 10.200.40.146 with SMTP id i18mr22016168qti.79.1508797992322;
 Mon, 23 Oct 2017 15:33:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 23 Oct 2017 15:33:11 -0700 (PDT)
In-Reply-To: <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com> <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com> <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Oct 2017 15:33:11 -0700
Message-ID: <CAGZ79kZTjUvcq_hKHCqTDoaBxt2x+9XcqYc6ao1bhcET2SM-PQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and 'simple'
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, William Yan <wyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 23, 2017 at 2:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>  1. First, check whether $GIT_SSH supports OpenSSH options by running
>
>         $GIT_SSH -G <options> <host>
>
>     This returns status 0 and prints configuration in OpenSSH if it
>     recognizes all <options> and returns status 255 if it encounters
>     an unrecognized option.  A wrapper script like
>
>         exec ssh -- "$@"
>
>     would fail with
>
>         ssh: Could not resolve hostname -g: Name or service not known

capital -G?


> -       if (variant == VARIANT_TORTOISEPLINK)
> -               argv_array_push(&conn->args, "-batch");
> +               detect.use_shell = conn->use_shell;

Why do we have to use a shell for evaluation of this
test balloon?

> +               detect.no_stdin = detect.no_stdout = detect.no_stderr = 1;

okay.

...
> +               argv_array_push(&detect.args, "-G");
...
> +               variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;

What if we have a VARIANT_SIMPLE, that doesn't care about -G
but just connects to the remote host (keeping the session open), do we need
to kill it after some time to have run_command return eventually?

Or can we give a command to be executed remotely (e.g. 'false') that
we know returns quickly?

>  '
>
> +test_expect_success 'OpenSSH-like uplink is treated as ssh' '
> +       write_script "$TRASH_DIRECTORY/uplink" <<-EOF &&
> +       if test "\$1" = "-G"

Reading this test (and the commit message) I realize, we do care
about the order of options, so this is fine.
