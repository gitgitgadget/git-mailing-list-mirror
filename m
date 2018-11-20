Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD131F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 18:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeKUEgH (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 23:36:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42591 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeKUEgH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 23:36:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so2710631edp.9
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 10:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vuXVjuPeY0hnSxCA22JVrat0LkQmxgSVVheVB8t9iKc=;
        b=HeTKxYXMco6sYqekU/cjXB9ANLCjwKDjR27luU5hcPD1U5e621jxUk9JgHT3en/SsZ
         nzyo/FanbLvY3LW9kJFBLc5bT+5jZxpqNNtr8sMy8+LjNbpT2Vj4uKuKIIrbYHAgNukI
         HpUaF+Vnmhn4H74mXfqGFd4PLcMXJTtwNs7vO3Iz5B3XU7vDhFeOxnDBakY9hM840DTD
         4DqdKuMVMqdb0ibzo66QPblkugWqYadoLE8TUJcWlUihbE1Py1nzocnlwUimFNLcEuPM
         Q1E90TFT9ySMN0ZDRLKsshWIBgrlMK6XAOHj0B0yf3Fyb2tyrqDBia/sMuv3On54xSbf
         HoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vuXVjuPeY0hnSxCA22JVrat0LkQmxgSVVheVB8t9iKc=;
        b=faFNA9RligD0Iq5eqRvZksCOcSJIfWoeMGmnsZKKGx4NPHg2Z4c3UWPRgWFs09KfNv
         krHo/PkYh2DDVPfa6FY/26Cgpm/LuIuZdF+Zu+IJ7byT4+b9fSAuIdQzyoe03GOAVT56
         O9mSq+67HRpuRawtJXUg9gwaRjDKmTpMHgMUQbfIPGg4Mtbe40eF+Prt2G7a0lQEsYil
         U+D8LFTtep02IfaQwj2nkdCmn/jKSgZpB3DntqdKZbinytJpsO6yXnxxZNhDOOvNYNcm
         Hx5h1H2wLi5CDht45bdGTaV+iWQ0IBdYeVh2VN57T9WF+ay/UM00nGqxLlBJwCXTbZKi
         kppg==
X-Gm-Message-State: AGRZ1gLYEhpbJ3WgvF9tSXFdsjR1aPEo03624roR7H/yd5JhwY3YMgnN
        1NNXZ5dkpoArCj2nsloGYpzR65oE23T613TC7Kwh3ulC9YQ=
X-Google-Smtp-Source: AJdET5fMfuaB6iyijLs/7tgnz2dv/TWLkpcyHzRAtO7ajwUXrEPOIUaAjoLSJA5HZRFFWqZXX4+GLVHNJ7amVGMa2pY=
X-Received: by 2002:a17:906:3712:: with SMTP id d18-v6mr2694520ejc.126.1542737141388;
 Tue, 20 Nov 2018 10:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net> <20181116110356.12311-10-phillip.wood@talktalk.net>
In-Reply-To: <20181116110356.12311-10-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Nov 2018 10:05:29 -0800
Message-ID: <CAGZ79kYm-uNWi-3=0fG=PfA3HbT7tKwER=r8fm6UFiy3P=JEmA@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] diff --color-moved-ws: handle blank lines
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 3:04 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When using --color-moved-ws=allow-indentation-change allow lines with
> the same indentation change to be grouped across blank lines. For now
> this only works if the blank lines have been moved as well, not for
> blocks that have just had their indentation changed.
>
> This completes the changes to the implementation of
> --color-moved=allow-indentation-change. Running
>
>   git diff --color-moved=allow-indentation-change v2.18.0 v2.19.0
>
> now takes 5.0s. This is a saving of 41% from 8.5s for the optimized
> version of the previous implementation and 66% from the original which
> took 14.6s.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> Notes:
>     Changes since rfc:
>      - Split these changes into a separate commit.
>      - Detect blank lines when processing the indentation rather than
>        parsing each line twice.
>      - Tweaked the test to make it harder as suggested by Stefan.
>      - Added timing data to the commit message.
>
>  diff.c                     | 34 ++++++++++++++++++++++++++++---
>  t/t4015-diff-whitespace.sh | 41 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 68 insertions(+), 7 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 89559293e7..072b5bced6 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -792,9 +792,11 @@ static void moved_block_clear(struct moved_block *b)
>         memset(b, 0, sizeof(*b));
>  }
>
> +#define INDENT_BLANKLINE INT_MIN

Answering my question from the previous patch:
This is why we need to keep the indents signed.

This patch looks quite nice to read along.

The whole series looks good to me.
Do we need to update the docs in any way?

Thanks,
Stefan
