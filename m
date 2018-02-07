Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2AA1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 20:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754466AbeBGU1d (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 15:27:33 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36317 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbeBGU13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 15:27:29 -0500
Received: by mail-yw0-f176.google.com with SMTP id t129so995763ywc.3
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 12:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OR9HXfolBuhyuMJawoEG71CWGc9xXSnHrz9id1sG54k=;
        b=jaS/u3s0IdubrQArjLOn5xjvi9gvGJbsd8P8ekr0N7dvwXeWfQ2PflkiU3SqcYA2+L
         pv7RwOzJKUwlgddDZ2eSTFkDd2ZTmwhL40nm/L1CdBlMd94ZPKtPKary8pZOlmNzmoss
         4uiSyB89vLcMmSlAIYiNZgTWS0vPPXEtEylkfv6wiqmermAaEUklRMZzwhWjtfDBPfsh
         YpOakO3EcWw9C+4TgqTtX0XdFdlZ1aiVcGXXIg9hIerTBCODopCCff80G3Y9pNAhAcwO
         FFJMX+/pmKR8tp0P9H4NuETjihfCJ+Jcbx5nNotkEbhiCIvtFqsaO6r5y+4v2NZY/Epd
         A0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OR9HXfolBuhyuMJawoEG71CWGc9xXSnHrz9id1sG54k=;
        b=Pv4EENj6zSoYzWxzAW1//FUuW4A0OsWTVWBYb0Sg96XPCF6yqFYoMwtRuvp0S8JMDD
         4zRlQBj1Cbf5DsSElBgGHSOhD9g35UMGWGbAUwtmzmUIOGKMEmdxm9TRd8q8H1Pc6hHv
         1Dm8bdLWrInaMWJWuLtz83qJTycrWoZVuUp+YMCVWrc31+TKt5n8eH6kO/OR+eypjjTw
         8nxj56/5LvQglhE9igKhqyDYVPhiaFjPBVTF2l2Dd60M+7LyqCM445k6rAtNLQRjKZj8
         CcGgbAko6VXPkjXeA6LcILbq6AvgJNSOPEyQMc4IFV/bsvVZgYYe1IrrqjLudYu3bt8U
         nwzg==
X-Gm-Message-State: APf1xPCnWaTVZPdVYlbQLaVFu9Li3W+0d9JtYtPLZOK77xTv/hL48Or8
        TkNPkLSIovWPFfbb9ppNNfVBmYSgDjyFO+T5YFKBlQ==
X-Google-Smtp-Source: AH8x227lqJ95Xrh/rDt7dKc/07fBVp8hxxe6M7Cc6DGZlBu9M/dTvjIwebb7ZKnlGh8O4rBSjk833pSBRIse9z/IcVc=
X-Received: by 10.37.101.11 with SMTP id z11mr4315453ybb.201.1518035248405;
 Wed, 07 Feb 2018 12:27:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Wed, 7 Feb 2018 12:27:27 -0800 (PST)
In-Reply-To: <xmqqinb87f70.fsf@gitster-ct.c.googlers.com>
References: <20171216013130.GB188893@aiede.mtv.corp.google.com>
 <20171231191156.28359-1-stefanmoch@mail.de> <xmqqinb87f70.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Feb 2018 12:27:27 -0800
Message-ID: <CAGZ79kbX4uhDpdp0kH=8+5tj_zLWZbtbMUb5WWtOeXWRQz8K3Q@mail.gmail.com>
Subject: Re: feature-request: git "cp" like there is git mv.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Moch <stefanmoch@mail.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Simon Doodkin <helpmepro1@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 11:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Moch <stefanmoch@mail.de> writes:
>
>> * Jonathan Nieder <jrnieder@gmail.com> [2017-12-15T17:31:30-0800]:
>>> This sounds like a reasonable thing to add.  See builtin/mv.c for how
>>> "git mv" works if you're looking for inspiration.
>>>
>>> cmd_mv in that file looks rather long, so I'd also be happy if someone
>>> interested refactors to break it into multiple self-contained pieces
>>> for easier reading (git mostly follows
>>> https://www.kernel.org/doc/html/latest/process/coding-style.html#functions).
>>
>> I looked at builtin/mv.c and have a rough idea how to split it
>> up to support both mv and cp commands.
>>
>> But first I noticed and removed a redundant check in cmd_mv,
>> also added a test case to check if mv --dry-run does not move
>> the file.
>
> I guess these two patches went unnoticed when posted at the end of
> last year.  Reading them again, I think they are good changes.
>
> As a no-op clean-up of a127331c ("mv: allow moving nested
> submodules", 2016-04-19), the attached would also make sense, I
> would think.
>
> Thanks.
>
>  builtin/mv.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 9662804d23..9cb07990fd 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -266,10 +266,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                 const char *src = source[i], *dst = destination[i];
>                 enum update_mode mode = modes[i];
>                 int pos;
> -               if (show_only || verbose)
> -                       printf(_("Renaming %s to %s\n"), src, dst);
> -               if (show_only)
> +               if (show_only) {
> +                       if (verbose)
> +                               printf(_("Renaming %s to %s\n"), src, dst);
>                         continue;
> +               }

This is actually changing behavior to

    if (show_only && verbose)
        print(...)

    if show_only
        continue

The second part is already there as is, only the printing behavior
actually changes.

So I might be missing the obvious here for the claim of no-op?

Looking up further we have (line 177):

    if (show_only)
        printf(_("Checking rename of '%s' to '%s'\n"), src, dst);

which prints regardless of verbosity.
