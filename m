Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FF221F404
	for <e@80x24.org>; Sat, 24 Mar 2018 18:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeCXSTo (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 14:19:44 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36867 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbeCXSTn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 14:19:43 -0400
Received: by mail-it0-f47.google.com with SMTP id p67-v6so6238853itc.2
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 11:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AkcP11S8AbZIo8+IfEROs2CjoVovYTjo7BuIyhZGSWg=;
        b=ZnYZQcgQ29BAEt+BNzOtM+xUFMcsXCUa1e5dTSxeBbDlVl0aLuJ/s1QWxNqrYbXXdw
         pmdS4FUZx/w0Ss2FhWMBZYe2F3CaT1ig7RpkD8W34mU5lyr0TIN79aBsXxgNc8h27kfD
         0hv1jvS5DCKJZwhoYycux5A+qDG+5O/lzmFsYIdeWZU9L9yts2IotuPO9xo3qdfTBEEW
         RI9HPZOJogDufcxWT9dookFZyCgMvy/mDH8IzqLgmlMWZg0ir45juQfDGO0+BhIhhU/I
         H0A9q08rVoV2SkfFjwgHGapbD8QARKWqR4S6dBplbqJYs7Fk55bTYVRu1kfe08yf1Cci
         vIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AkcP11S8AbZIo8+IfEROs2CjoVovYTjo7BuIyhZGSWg=;
        b=UrpFaO8YWQqANB0P4lg+GLpUitGpm5R0whVGaWeksSf1aEzpajegt8ZFcW3Z/UiT3e
         Wii4YHzrFda+Rd/NjyuLFDv1UdsiktPWrALTaGSJQEzuWjYg582cVqcQtNo5P1QpFcrT
         6Orz8viqYUxY/tzSDI6fgZFd4/4ifP6HMMXIE6eKdugKPgsHnWCU5jNL0aqJf3XNDpfx
         QDG+I98Lwz8xNqJUW7RelODYL5bCzcv0L29WuDc0C38/X8ZGgrpEWGA/DvrNwi//9YNH
         714CtKFsrzwNpzXo0unCIKAIxXJRtr3qMpyANZSJJ83p6bi+EXMFrIDBL23yN3LSs0x2
         h1jw==
X-Gm-Message-State: AElRT7GHznAaaCJ9RJCbHQ5/p6AgoBw6UFbeRkSuicZRW0hHTgz5ISk7
        1GZR+aRiBHWGwxcHdefOxuiIbAg6ookqc38GNAk=
X-Google-Smtp-Source: AG47ELtUglMWlAiBF/nEf/qUDcxmFv+PUNIUdKJTlpwbPZbk7yAm0f+TSR7gOYA3EbJEBY5BK4vaO37VEkH3r6vUOG8=
X-Received: by 2002:a24:eec5:: with SMTP id b188-v6mr16906104iti.96.1521915583001;
 Sat, 24 Mar 2018 11:19:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sat, 24 Mar 2018 11:19:42 -0700 (PDT)
In-Reply-To: <20180324173707.17699-2-joel@teichroeb.net>
References: <20180324173707.17699-1-joel@teichroeb.net> <20180324173707.17699-2-joel@teichroeb.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 24 Mar 2018 19:19:42 +0100
Message-ID: <CAP8UFD37DgfQ63pPrN2CBH0VjTUuc-N4fq-34bTuyQTH0fR9mA@mail.gmail.com>
Subject: Re: [PATCH 1/4] stash: convert apply to builtin
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +       if (unpack_trees(nr_trees, t, &opts))
> +               return -1;
> +
> +       if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK)) {
> +               error(_("unable to write new index file"));
> +               return -1;

Maybe: return error(...);

> +       }
> +
> +       return 0;
> +}

[...]

> +       argc = parse_options(argc, argv, prefix, options,
> +                       git_stash_helper_apply_usage, 0);
> +
> +       if (argc == 1) {
> +               commit = argv[0];
> +       }

The brackets are not needed.

> +       if (get_stash_info(&info, commit))
> +               return -1;
> +
> +

Spurious new line.

> +       return do_apply_stash(prefix, &info, index);
> +}
