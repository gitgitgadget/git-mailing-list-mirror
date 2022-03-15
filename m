Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FA8C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 02:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344430AbiCOCaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 22:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiCOCae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 22:30:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDB847069
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 19:29:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b28so18854470lfc.4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 19:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4saizn9eVWvBsw4mJlzhB/JMYU6MbZkb89iGlpfCos8=;
        b=kGIJmQ19OWyWxNBpQ/HEJUHigtXV2d9i5R86z7WrV6p/djZmthczo5bPry/LJMZGs9
         fPjW9XdTL8C4fxTZKlfLtJcBPlOAjXy6oM28OUYdKlt9cwi1pN3Dfxc+yOCx5SIcRbQ6
         TNGD4nOecnfRV0pfTBZRiRhQmz7d7o0nccx2kPpT3WyNV9vFHb03z4HbPJqSkGtYUq5k
         lRvp5CpC9uhr93CTozcKNnGaQEzGtkexdPHxjPF8f5cPsNhQ3ro4hJOZqzfMIhwManU/
         rm3VSsy76mIF9sB0yOkzyxE5szO5uBpjPjvgru8jRWo4BnKVzHzNJxmga1iZC+XGdr1W
         NI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4saizn9eVWvBsw4mJlzhB/JMYU6MbZkb89iGlpfCos8=;
        b=PlPfhHHaYDbec43V9aybBDyxEZ5a7wyzR0/1aBnpcJnjdcIPrvvRRJbOYmQ/lQ4nfW
         XHhRyZbNSSG7hSF8JN38xw1xtDrzERfmPAPEvUX0yodcB2EjFf5047MXRCM1VMStghFv
         6sEcTOw59V972cVp9witG8nF0yJdcl4G1uhhev7iHqj/uvvBb93wB1tT4Dz6+9w/mv9v
         H87SC0lNVVLL59m88kbiYG/YFyfbnwSuxaO7zEb7qj+SM/AyicI4BXRpD9F3YW8P1t/N
         z/26FzY0OoXu5injdUb8bS1/JlY9geLkPpfijqyWZ3o6qBHl9BAIr+QAUIBZPfdfZSPI
         HIGA==
X-Gm-Message-State: AOAM533WzNNl+EwpKQvBq94WpyVqrbfungZ+5pKX7NAs3ILgibh/T+Pg
        IXTtTlQHYeX3jeT3Ykpcs+ILGEkwSmNyK+9G3q2vMa/sIg==
X-Google-Smtp-Source: ABdhPJzm3tEW7/VCp+/dmZb9zCQK1vOJS0wATVNsgZS1TTNrnTssfo3ifuUYmywK53rEwOEvsj4JwLngg9dh32WN4og=
X-Received: by 2002:ac2:4f03:0:b0:443:5d9d:819d with SMTP id
 k3-20020ac24f03000000b004435d9d819dmr14301613lfr.165.1647311360895; Mon, 14
 Mar 2022 19:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJYFCiPw6VPPKpiC0f1iwdYf0LCFCbfrpNSHFs1qbwtGXX6pUA@mail.gmail.com>
 <xmqqee34m8kz.fsf@gitster.g>
In-Reply-To: <xmqqee34m8kz.fsf@gitster.g>
From:   Yubin Ruan <ablacktshirt@gmail.com>
Date:   Tue, 15 Mar 2022 10:29:09 +0800
Message-ID: <CAJYFCiOMV6P=jDOJ-yM4d4wvkkziKmXWcnZjEdahENUAeeFocQ@mail.gmail.com>
Subject: Re: git cherry-pick with --no-verify option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 15, 2022 at 7:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Yubin Ruan <ablacktshirt@gmail.com> writes:
>
> > Is there any version of Git that supports the cherry-pick command with
> > "--no-verify"?
> >
> > It is supported in "git commit" command but not in "git cherry-pick"
> > command, and I always have to move .git/hooks/pre-commit away to work
> > around this in case of "git cherry-pick".
>

<...>

> Ahh, I think the user is fooled by a bad advice in the message.
> (all conflicts fixed: run "git cherry-pick --continue") is wrong and
> misleading advice added by those who did not think things through.
>
> After fixing all conflicts, run "git commit" to record it and then
> you run "git cherry-pick --continue" if there are more steps to
> cherry-pick (i.e. "git cherry-pick A..B").  "git commit" takes not
> just "--no-verify" but other options like "--reset-author" to let
> you take over authorship if the conflict resolution (actually,
> adjusting the original commit to the different context it is being
> cherry-picked to) is so involved that a change of authorship is
> warranted.  "cherry-pick --continue" does not have all the necessary
> flexibility and conceptually it is a separte operation (i.e. "please
> continue the stopped sequence" is what it means) from concluding the
> current step in the sequence.

Yes, in case of conflict when doing cherry-pick, "git commit" should be used
to resolve conflict and then "git cherry-pick --continue" if necessary.
The help message of "git status" in the middle of "git cherry-pick" is quite
misleading.

Thanks~
Yubin
