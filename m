Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E029E1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 16:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932710AbeFRQ0Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 12:26:25 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55394 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754136AbeFRQ0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 12:26:25 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so12886080itl.5
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0tgtSyDR9pmw6Z7AApIcCE9coY9hQcewrdwD9xC1zVQ=;
        b=i8cCg2TgAbJ9YoQx90CgYZz5zmHg+PtiIVMRk35aMX+kCbFRhr3NYSVVlNs8Gd/S6R
         3pBeTi4yLOy1fh31h9pKjXRrBugbwbEyNg4W/ffqIHnWu33qliZa6G3j4g32M3/w8HuM
         +/CaetTWCmnYSSUF3JfI9LSCtaJ3t7nIC7coJxnbhTJ93B7PIwUWDoAKm3ELog0wvhcJ
         MWB2Qpa1yli3KRHIqyuAv/drTI2ur3xpH09MjgtAYIT8rgmtl9i9LyQV3jTUQuTxafUn
         ANymINwOVTvDZ7V623LYMinECj2QyK/819MY6bVZVYqFz5IF6w7AR69vCVL7o7A3nQhr
         Et2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0tgtSyDR9pmw6Z7AApIcCE9coY9hQcewrdwD9xC1zVQ=;
        b=fEoL+qQI2EAm4FjAgmdgoKLUl6LYy262V/r42x92yUanWqjeM5L4OtOEJ7eZR/TFlU
         t0cwd101AYQjk6XkGXor3zVSw/twQcB1MmSfzSK0/0jc/KMbd6kRlCPh7GLhz12rX2kp
         py1wXbSXPKCqck9JI7YFCUgPwZBdjALe5edZuK7EvSoDwEtcgYB+rQXMh0yPtklGybRh
         LkFSwHFd2IahKIGonKx9FV2mrL9LlRpEdbfj3maXopudkNI5p0UKFxCIPeFju3CwQcJA
         1rnC6eEeXAZWkH2FnkGcRLOFRJXeExFipLN2UIsDjjAnqNxr02jQA7VHg7nsS+dH4hra
         +JTw==
X-Gm-Message-State: APt69E2XbZ+XmUaLQ1PaChcz3U34HVHa/Ebw5S1aNzdbNk6/oDADgnc1
        5TT3VVkQrA6Dl5UEUauSVyS4DpqJI9ScUCz7rQI=
X-Google-Smtp-Source: ADUXVKJe8PnTqzBdwriKFo6yaHUepz2YovXaHC3lbL9c422huc4XES03z3wsm3cZwAHpjQzW6GFnkMQNqyiauOvYDes=
X-Received: by 2002:a02:8a63:: with SMTP id e32-v6mr10924380jal.8.1529339184322;
 Mon, 18 Jun 2018 09:26:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22d0:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 09:26:23
 -0700 (PDT)
In-Reply-To: <20180618131844.13408-2-alban.gruin@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com> <20180618131844.13408-2-alban.gruin@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 18 Jun 2018 18:26:23 +0200
Message-ID: <CAP8UFD1PirEpeVwR=Zr4NAccrt_zGxjZkbDrjXNbQRp49zcjtg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/3] sequencer: add a new function to silence a
 command, except if it fails.
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Mon, Jun 18, 2018 at 3:18 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
> This adds a new function, run_command_silent_if_successful(),

He re the function is called run_command_silent_if_successful()...

> to
> redirect the stdout and stderr of a command to a strbuf, and then to run
> that command. This strbuf is printed only if the command fails. It is
> functionnaly similar to output() from git-rebase.sh.
>
> run_git_commit() is then refactored to use of
> run_command_silent_if_successful().

...here also...

[...]

> +static int run_command_silent_on_success(struct child_process *cmd)

...but here it is called run_command_silent_on_success().

Thanks,
Christian.
