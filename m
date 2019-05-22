Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62BE01F462
	for <e@80x24.org>; Wed, 22 May 2019 00:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfEVALz (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 20:11:55 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:41803 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEVALz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 20:11:55 -0400
Received: by mail-io1-f47.google.com with SMTP id a17so401177iot.8
        for <git@vger.kernel.org>; Tue, 21 May 2019 17:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Js3Ne2PO6TjL+ZMt0qzH5+buddypo9QqNHLrsF+zYp8=;
        b=nwyc7QVFqpFcudBRybKHpS24ynOX4nWYBnV/YaWke5tyHilWUqg8BN598xOzCQADsH
         CR7ZooZcTuUaI9l0B9nndUXMa1TvQHwRwSwIOTY2ld+qyZ2yRhz1ZC9wTCZjmwyw+4t1
         DEERILYxmMf+ZyLkdszOzeJLdvTDWgj84vXtRqR30F1wdP63k1Zve44TK19iAbg/ygFS
         Pkiu/jPkVMBKlvdqZ9V1aCJkAi+CFdtwt4irS5IlbXB+lvRKmQC5tisQrH7O7VcFsDaY
         h65loe+Z2U+kHpHvJlV0jOmjEfrMD9ahDAp2/4q1uJnqL8o/pHbrSXDlwnauftx1fyvS
         zebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Js3Ne2PO6TjL+ZMt0qzH5+buddypo9QqNHLrsF+zYp8=;
        b=WPBp8K3hXz2aoPyi3s6zsKyH4tqYQA2l0OtiCoP/joMl7JrmQiQBP0flEsI3Yc3MR7
         QBOgDbi7XmZwRtSSFz1KSF/O1jG3N51hYFr9g2ILIkOmsHdSphkLYXLZHOpQtHHLHXM+
         SzlBHmH5yFYkMInOHomMmIWV6Wf4vwHVvUKHIpSGlGRe6S+e5L/8JnTaH1L+EW5ASQLU
         10ntjQwmRNwKT9PvK1+uSVH0Cqg4A78g+I3AlKMBS35aueMqP80hYseF0yckJfrX3jAz
         c1BswODTAkCaAjfPGkK2O1oMm8bcEvjGJtdXzMC9O6px+LbDirI8u3mX2HDLw/i0Qqro
         7uOQ==
X-Gm-Message-State: APjAAAWlxg7hoH59EVMPW7zx2jIQ7anPagDirxOZ0b/qwjbklgHMQuIZ
        h+YiA3PHgXFHa6Jmc83WwxpIDun7whfDnL+qJEpahQ==
X-Google-Smtp-Source: APXvYqy386w6XZcfcKb5c5l9/vDNXbZNNqngGKMFP27rPfp3878PUY9dQ4zpEzMrk6r5JxXvmqGZTLyNPqx7IKn4RnQ=
X-Received: by 2002:a6b:b907:: with SMTP id j7mr26344244iof.17.1558483914295;
 Tue, 21 May 2019 17:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <82f79cd9-5273-b9a4-744d-f5fa95dd1f47@ramsayjones.plus.com>
In-Reply-To: <82f79cd9-5273-b9a4-744d-f5fa95dd1f47@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 22 May 2019 07:11:27 +0700
Message-ID: <CACsJy8BHeVDDnEYXaOAPtEoesTVNCiPGSgnJYjtL6aYSU0-J5A@mail.gmail.com>
Subject: Re: Incorrect diff-parseopt conversion?
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 22, 2019 at 2:56 AM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Hi Duy,
>
> I am in the middle of rebasing a long running branch onto
> current master (v2.22.0-rc1) and noticed something odd with
> commit af2f368091 ("diff-parseopt: convert --output-*",
> 2019-02-21).
>
> As part of the branch I am rebasing, I have defined a new
> OPT_LL_CALLBACK() macro[1], which I had intended to apply to
> the 'output' option to diff. However, commit af2f368091
> defines that option thus:
>
> +               { OPTION_CALLBACK, 0, "output", options, N_("<file>"),
> +                 N_("Output to a specific file"),
> +                 PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
>
> Note that the 'option type' is given as OPTION_CALLBACK, not
> as OPTION_LOWLEVEL_CALLBACK. Is this intended?

Yeah I think this is correct (phew!).

OPTION_CALLBACK can take two different callback types, the "lowlevel"
one allows more access to parseopt context data while still does
common parsing for us. OPTION_LOWLEVEL_CALLBACK, on the other hand,
calls ll_callback directly and leaves it to the callback to handle
everything. We want OPTION_CALLBACK here so we will not have to do all
the work, we just need extra info (the prefix to be specific).

>
> ATB,
> Ramsay Jones
>
> [1] Yes, the reason my branch is long running is because
> we keep changing the same files! We have both defined new
> OPT_() macros, some with the same name ... ;-)
>
>


-- 
Duy
