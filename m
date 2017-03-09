Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6974D20135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932165AbdCIBac (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:30:32 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36486 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754742AbdCIBaa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:30:30 -0500
Received: by mail-pg0-f44.google.com with SMTP id g2so2384925pge.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yaxspo/PEgkbPABk/VyHyZeczzfPkjMUAL3YxwdJqrM=;
        b=b0N+mdBYymGxcrlwcXlhd5uFRmrl8fkxw3CKHCEvkZ4lAyquKr3L4SfL9pX/nxMo+u
         ub7Vjf0FwnXeAW3rWgCndDU9SlPFjhxNmQqMQ9w8RsdZS0Hn7P1mZ9CtsKJg1eec0Rf/
         NGpAwix3FhCgswYJ7lWl6rXn5/hL2RRVUBvJwZIwLDNXxddP2+0JLBP9g0/j12QZFHtp
         Jt6aSNa1NMAwAYdugTYXQXzsiM1L3agZFRKHxhLF65ucBIaZYN2DhDbA4HJG1M4Tmqsj
         +9jgs8uQ4XyryfDblKUYHw+eZpknPYKOPPUfxFth9rrm7NWk2NZ0NqQKXosfMTmHRCGg
         nULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yaxspo/PEgkbPABk/VyHyZeczzfPkjMUAL3YxwdJqrM=;
        b=ZulHPJMGxOsjUgdLz4Oou7jUQrt5icorPbWoonkayfYSNu5zhXUKmyuy7u3sxVolox
         521mB1GsNi0ajBSMZ9/RrhjmnG6S3mncsqG1xJk5b6nVY41AVipgB3nfIVs+PmAhAW/b
         Ywg3xD26WKpUGTImWZ7X8WwAVTIT+OuXiPMzD0rch/7sW9yx0XoVT9x0kTMLV5a7JEnG
         DcIWpS9Xfz8dEGpTvIA9Wn+lvl8NsFmpISMSfpA4wVxW8aC2cp6ThUFHJXltlHPsVJNc
         t62tn37dtSocEij35w1x45N8blw8lL+/RI8rFDnRlTSOXG37j/nGAE8RPt96pilorcHL
         e6qg==
X-Gm-Message-State: AMke39k1tYic8DeFxT5y1FRPSlZ3BJFXvKEsryCXPow75SVrDGLgrG/jXbDPgYIjEFraFN38ScomjCDHAX8GgBlH
X-Received: by 10.84.128.74 with SMTP id 68mr13252353pla.111.1489023029274;
 Wed, 08 Mar 2017 17:30:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 8 Mar 2017 17:30:28 -0800 (PST)
In-Reply-To: <xmqqa88v1i5f.fsf@gitster.mtv.corp.google.com>
References: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com>
 <20170308133348.2ovfsi44vq2rpgom@sigill.intra.peff.net> <CAHGBnuM3iM-kHdxdox_1i56uLbv7gQ5ZUY9Xqf4BG7G_kTf+jQ@mail.gmail.com>
 <20170308140110.wgdedquqwm75zws2@sigill.intra.peff.net> <CAHGBnuPGPcWwbrZX_92XDJu47bpH=kj2PZ7yWHK=MRfZ_RHXrQ@mail.gmail.com>
 <CAGZ79kbwMhL-ZnL-iYwPH=tWa8cNQbEGOYYQBw6OzFCMhOWE-w@mail.gmail.com>
 <xmqq8tof32x9.fsf@gitster.mtv.corp.google.com> <CAGZ79kZFGP0zMP5CtOH3poU9vx8FoT25UVr8ridQo0_VdH2cmA@mail.gmail.com>
 <xmqqa88v1i5f.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Mar 2017 17:30:28 -0800
Message-ID: <CAGZ79kZwiwhP-skEd6K+osXkX47fF-eN=psP88DBzjca7n85DQ@mail.gmail.com>
Subject: Re: diff.ignoreSubmoudles config setting broken?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Yeah the .gitmodules file is a good hint.

And by that I meant that I am not sure if we're going
down the right rabbit hole here. So before we take action
maybe Sebastian can tell us more about his project (and all
configurations and settings involved)

>>
>> Here is my understanding of the precedence:
>>
>>   command line options > .git/config (in various forms) > .gitmodules
>>
>> where in the .git config we have precedence levels for different files
>>
>>   .git/config > ~/.gitconfig
>>
>> as well as different settings:
>>
>>   submodule.<name>.ignore > diff.ignoreSubmodules
>
> I've never understood why people thought it a good idea to let
> .gitmodules supplied by the upstream override the configuration
> setting the end user has like this.  This is quite bad.

Apart from from the name <-> path mapping, the .gitmodules
file is a collection of suggestions, some more severe than
others.

I think the issue here is to define the correct
and clear order of precedence, specifically between along these
2 different dimensions (different configuration settings vs different
files with configuration), such that the .gitmodules file is only ever
consulted when the user has obviously nothing configured that
would contradict the .gitmodules file.

>
> Perhaps this is a good starting point?
>
>  diff.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index a628ac3a95..75b7140c63 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -273,8 +273,11 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>         if (!strcmp(var, "diff.orderfile"))
>                 return git_config_pathname(&diff_order_file_cfg, var, value);
>
> -       if (!strcmp(var, "diff.ignoresubmodules"))
> +       if (!strcmp(var, "diff.ignoresubmodules")) {
>                 handle_ignore_submodules_arg(&default_diff_options, value);
> +               DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);

s/options/&default_diff_options/ makes it compile. (I did not think
whether that is
correct though.)

In other occurrences of handle_ignore_submodules_arg, the DIFF_OPT_SET
is set before the handle_ignore_submodules_arg, though.

When trying these suggestions, ./t4027-diff-submodule.sh breaks.
log on that file yields e.g. 302ad7a9930 (Submodules: Use "ignore" settings
from .gitmodules too for diff and status), which tells us that in 2010 people
were not as concerned by this, but the user had to use the exact option to
override the upstream default-suggestion.

Thanks,
Stefan
