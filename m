Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AB5C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C8266109D
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbhJ0RL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:11:57 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:41478 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhJ0RL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 13:11:57 -0400
Received: by mail-ed1-f42.google.com with SMTP id h7so13678447ede.8
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d40CGBUqlKdbNQWvVBct1qWtdQJtNcGIk1U1rpOOPxQ=;
        b=dKTeKrVTap8n2nNmhmkT4CTDglgG92ireiYObbUDOFu6FXLH8dwnQgM9TQjGVhDwRt
         Yblmj6V2/PpKAywO4tmT/vmScfFupB7jcvOe/i8tHT0pyU1j+0Brr6LPX34PMRmFZLMB
         GUKmaQR/918ymUp19dPemvLJpEvYPl9BSFtOY+sefLW+leMiicTh4lqkcR7Alm70lugu
         58lI1ouTTpR0eqU5rngXgpt3XlqNB1GtLn7aAb/l7BxWb5+FqplM2AcMXQVoLeLW9dap
         RGwbrKvNFFJaQEGGhYQFHSGRTAXp2O8drw6g068J17QI6syKVprxWEMB2AbI7Tj+MYKZ
         ZlgA==
X-Gm-Message-State: AOAM531x3FBEVzDCBdyf1F6fjGSO03RRe1bfkh8VDEc+lZqUPJYeAvJb
        4SIZbuuMn5QbZN7gQ2jzeU8jzGEkkKmubV9mSvAPdZHv
X-Google-Smtp-Source: ABdhPJwDzsOJK2ZHrbHS6c+229WuukmvNDNpqmVgNzOll5/Sc/1LcG3ntbNceI3VGUBKCNQQQUQ8WFo6n0lu0WXBXoY=
X-Received: by 2002:a17:906:128d:: with SMTP id k13mr24543551ejb.517.1635354570561;
 Wed, 27 Oct 2021 10:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1063.git.1635343531.gitgitgadget@gmail.com> <33cd9b2e8a675bf79132d312da8b7d8f4a2b84a3.1635343531.git.gitgitgadget@gmail.com>
In-Reply-To: <33cd9b2e8a675bf79132d312da8b7d8f4a2b84a3.1635343531.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Oct 2021 13:09:19 -0400
Message-ID: <CAPig+cQxfJkV70sP8Ai3EQUrh3Y04WjkhjpG1zup7_gfg90jbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: add headers in MyFirstObjectWalk
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 10:05 AM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In several places, headers need to be included or else the code won't
> compile. Since this is the first object walk, it would be nice to
> include them in the tutorial to make it easier to follow.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> @@ -57,9 +57,14 @@ command). So we will send our debug output to `trace_printf()` instead. When
>  Add usage text and `-h` handling, like all subcommands should consistently do
> -(our test suite will notice and complain if you fail to do so).
> +(our test suite will notice and complain if you fail to do so). We'll need to include
> +the "parse-options.h" header.

Makes sense, but we should probably typeset these consistently with
backticks rather than double quotes...

> @@ -195,9 +200,13 @@ Similarly to the default values, we don't have anything to do here yet
> -Add a new function to `builtin/walken.c`:
> +Add a new function to `builtin/walken.c`. We'll also need to include the "config.h" header:

... just as `builtin/walken.c` is typeset with backticks (as are other
pathnames in this document).

> @@ -229,8 +238,14 @@ typically done by calling `repo_init_revisions()` with the repository you intend
> -Add the `struct rev_info` and the `repo_init_revisions()` call:
> +Add the `struct rev_info` and the `repo_init_revisions()` call. We'll also need to include
> +the "revision.h" header:

And so on through the remainder of the patch.

Thanks.
