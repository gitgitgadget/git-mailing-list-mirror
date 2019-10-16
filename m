Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0BB71F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 19:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436659AbfJPTBD (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 15:01:03 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46962 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436617AbfJPTBC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 15:01:02 -0400
Received: by mail-vs1-f66.google.com with SMTP id z14so16309864vsz.13
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4EYsDoHIhxrg2rFMd+uENiLA+5EhpoQzDr/1XsYUPOo=;
        b=KXVrOnemp2QeNm5goGJBYnmyRA65bUNFs8R81dMUGLkzLeRMXFy4Gw+WSXf43CnIxF
         wAmPyp9wXrD7PMLLgP1HOECqkELf+tJsZDjGHmLKfWlwUytgZ5yp002Lx9nrq+N1DG9H
         ki8gAUd+SILIzJPgjZ1MXinNVEb4vqFrkmlhkJ0Pn3xgGyXnavGWLFS1dQCLPUeAYIxd
         5GVrqyXXXBYz61fyIHOdsDKXVLGHeCX7+p9VqIOpv7SObfNKM2ZkAx1d/6uPKJIqgt7n
         ZUt9Rkd8Kb4xCxERRsNOL4dgjirdy3BmlImgkd5NfzLlnj21BbyfNjluDUHXBZEmEJaX
         zyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4EYsDoHIhxrg2rFMd+uENiLA+5EhpoQzDr/1XsYUPOo=;
        b=lTRshjZ4VL2zaoF0MG5T34Y3mJAbH7Y6TLsSjVXyAPtEhBHn48B5uqsEU4l/D2hlm6
         N/KwGbSH/wuWPVKZ3N9fIY+gjl5jC6FZz3YzSNC9FAa1N00ge+V3Ws7IAQnGAoPRk0rZ
         3WQb8+zybMZj2lMEaJ2pIU2Yd77PatdP1hR8yk6ojG7KgfM6yvc2RKAr0hRif1+/dQKs
         0E4djctnYYtTbXepAICCSkYVBqHQX02cqrMs3kzbdUyS60RBuPrmYd7NiVX0PPPHGwcR
         V/Frwrn0cL2D+kzIQ8isgu3fHhfPLqqFZn7pUBW6/Vy0FzvbN5YWQBZogWePlXomINxD
         ZFBw==
X-Gm-Message-State: APjAAAUY/Dnx3XuF6v6YoXQrIvtnE/ltR7VUyHlD0g5f73M2dL+f0Svr
        AhK9KvQS+wz1cn+z2LaPxEXgSfR2Uweh5fXfkxp4W9gn
X-Google-Smtp-Source: APXvYqy5na67wih/6VN5bXiQ/nYQgnmTxOGwQUKR1RNtNGit7v//Aop7P9nMPfcO/9lzNJCRY+4R7A9oYg6ezh0SWe4=
X-Received: by 2002:a67:f84d:: with SMTP id b13mr24003606vsp.136.1571252461462;
 Wed, 16 Oct 2019 12:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v3.git.gitgitgadget@gmail.com> <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <63626e109767c268ee81b50abd21b95b1f1b5bfb.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <63626e109767c268ee81b50abd21b95b1f1b5bfb.1571147765.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Oct 2019 12:00:49 -0700
Message-ID: <CABPp-BEryfaeYhuUsiDTaYdRKpK6GRi7hgZ5XSTVkoHVkx2qQA@mail.gmail.com>
Subject: Re: [PATCH v4 01/17] sparse-checkout: create builtin with 'list' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 6:56 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> +DESCRIPTION
> +-----------
> +
> +Initialize and modify the sparse-checkout configuration, which reduces
> +the checkout to a set of directories given by a list of prefixes.
> +
> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.

I think the wording needs to be a bit more detailed; you copied the
wording from git-switch.txt, but usage of git-switch is not expected
to modify the behavior of other commands.  sparse-checkout, by
contrast, is designed to affect other commands: at the very least
checkout & switch, and likely will affect grep, diff, log, and a host
of others.  Perhaps something like:

THIS COMMAND IS EXPERIMENTAL.  ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
THE FUTURE.
