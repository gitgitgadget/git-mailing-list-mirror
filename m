Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEFAF1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 13:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbfJANa7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 09:30:59 -0400
Received: from mail-vk1-f174.google.com ([209.85.221.174]:38810 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388330AbfJANa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 09:30:58 -0400
Received: by mail-vk1-f174.google.com with SMTP id s72so3496332vkh.5
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2R1nt7XJ/VoLw1PixVneiACe/HNMk8S8AYQDjNoF2lI=;
        b=X/4m3yFv7xbY0yUX8Ad7cgK0qxV0TczclKlJMCxLh+yZ1awtDDnwcH7ArA+YtJwSOA
         O9OxVdAl26KY6drtKa3VbdujtSVd+SVasX2tv0uyEZ0oqm5Nf0UTjKMFzMbNcHtcTOOr
         E2IFRDZgHfLwut2PqRClCyOypvLHgLfRLmTs4vLgUuXUZO0+CwB+ghPwb/saUiObBXH1
         FWvUeKe2zPh8GpoGxRZUAVmoB843thbA53oAogLI8ENq1xwVqcxNuX+o7Y9nT3Vs+7g6
         4cj35WL9cLk4SvXFFHnj8vYwZsSqrGEDYm9V0lgB4U9XsJrDjCZVALhKIEh9om0OpK7u
         ys4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2R1nt7XJ/VoLw1PixVneiACe/HNMk8S8AYQDjNoF2lI=;
        b=KgMYfwTcoPvd7hSJSTnVGaVYeFy2S5tQYJOTTlFNdSImc+G3htkXpfoVGdEwMswjX2
         xOjHNp+X8BDRwukwXdZ1m7lZPQdl8p5sCH0h8p0EJLgNXkJUPBauzPFWhUjQRxzbvw3c
         Br6pr9NJZZ1NZyU+BwyYGx2GRwnZyr+9yOChQUvBJ7MjeAPzpfqHHvVSsOhQP+Xh6s6g
         3aotOxoEy9N4Vuas/QCNbpXKanN6zWO/rMHUqc7nG9pmc+r8+IXGLPGS6xDN5IjuhzXP
         fBp+PaqB6kMZDC18uxWp7gu6KsY0Oodrom0LAHTtbqlaZ+qtksYjUIkOE7K5ZAq6Kwk2
         AgNg==
X-Gm-Message-State: APjAAAXm9I3Pqt9XsUw8mm56BOlP3uTqeIhYgT6vItnmQ+QHOXdqK8q5
        tNibheFdql+5aWHsu5iwJ4mmvfSK/yvVCp6YM2SIUQ==
X-Google-Smtp-Source: APXvYqxxQ0eAN8MhUYj0yWJvOmKIPKI2mLbVb+qQmcphBVdp2Dh3AQdRnw+sovTkbRy1B342DisEjO6808sTyeudh0I=
X-Received: by 2002:a1f:53c5:: with SMTP id h188mr7673381vkb.33.1569936657572;
 Tue, 01 Oct 2019 06:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com>
In-Reply-To: <CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 1 Oct 2019 15:30:45 +0200
Message-ID: <CAKPyHN3G-j6p8YZmk+07Sb3tL9vua_R-hJ=W81O7vCYr07AkxA@mail.gmail.com>
Subject: Re: git-grep in sparse checkout
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Oct 1, 2019 at 3:06 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> Hi,
>
> During Git Summit it was mentioned that git-grep searches outside
> sparsity pattern which is not aligned with user expectation. I took a
> quick look at it and it seems the reason is
> builtin/grep.c:grep_cache() (which also greps worktree) will grep the
> object store when a given index entry has the CE_SKIP_WORKTREE bit
> turned on.
>

I also had once this problem and found that out and wrote a patch. I
was just about to send this patch out.

Btw, ls-files should also learn to skip worktree files.

Stay tuned.

Bert

> From what I understand, this bit is used exactly for sparse checkouts
> (as described in Documentation/technical/index-format.txt[1]). But
> should we perhaps ignore it in git-grep to have the expected behavior?
> I'll be happy to send the patch if so, but I wanted to check with you
> first.
>
> Grepping with --cached or in given trees objects would still grep
> outside the cone, but that is what one would expect, right? Or should
> we filter out what is outside of the cone for cached grep as well?
>
> Thanks,
> Matheus
>
> [1]: https://github.com/git/git/blob/master/Documentation/technical/index-format.txt#L101
