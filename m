Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF7BC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973EA60F46
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhHaGZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:25:44 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:34546 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhHaGZn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 02:25:43 -0400
Received: by mail-ej1-f44.google.com with SMTP id u3so36094200ejz.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 23:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OLnQEjzqH6dmNkczAotmmF6GTOU1TKXiOAzf/AH1bc=;
        b=c2K8dC2IzfECoWRNXIM+s2Mb9Z9wK0GyfZDFdXgqjlMn1q6I/TEWBCWjF4dbXpAFj0
         uT/nohjWArPmftoVYD0c4frfSE15jSa+ifVIGEDZn2oolfCt7ZX2Um/JGO5o45xqBwCC
         i3zj3uFgAU3z4AZENDgp4UnLCrhKdLaEmzniQsXXUQ9LCspIXMF2TIrouCkzPHX1xhGr
         DNMfRuJvTrx8m4bFN7/CIfGj/DCmhKpqsdR4geiu+jqOCAFpasTmszujsdJ6+iSOX3Yq
         7nnQnNxLT3hGDyzomccZv48Ud9kEuzVej7i+nnLFKxicVyDecV5ffFev1gOAGbC/qwO7
         HawA==
X-Gm-Message-State: AOAM5303p/ULW5GHfeAa9OXUkmR8iQQgsFl3x31jlvJi4Yzm0evTcp2A
        7hBM4fxqDsqYNai3CffmkmfUPWJVxIvE3CuvmQUQSgby
X-Google-Smtp-Source: ABdhPJxGNgfLRbH32Zn0i6N+nsX6FYQTvqBVwnt7LQC2Dx1PIftDN4/Mu5TjKxQNuKw2xHhsvjMQP8UIkoiTmXShosg=
X-Received: by 2002:a17:906:6808:: with SMTP id k8mr29763426ejr.138.1630391088295;
 Mon, 30 Aug 2021 23:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <73d08c0c8948340f6c08c1689b40900062db5b4a.1630359290.git.gitgitgadget@gmail.com>
In-Reply-To: <73d08c0c8948340f6c08c1689b40900062db5b4a.1630359290.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Aug 2021 02:24:37 -0400
Message-ID: <CAPig+cQAGxRrLUcPZtZqGEJ9RggRsDt0WJK+dgWmXtfCnZihOQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] scalar: implement the `version` command
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 5:35 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The .NET version of Scalar has a `version` command. This was necessary
> because it was versioned independently of Git.
>
> Since Scalar is now tightly coupled with Git, it does not make sense for
> them to show different versions. Therefore, it shows the same output as
> `git versions`. For backwards-compatibility with the .NET version,

s/versions/version/

> `scalar version` prints to `stderr`, though (`git version` prints to
> `stdout` instead).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
