Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6A6C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 08:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4491723435
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 08:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbhAHIUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 03:20:07 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:36341 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbhAHIUH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 03:20:07 -0500
Received: by mail-ed1-f43.google.com with SMTP id b2so10377770edm.3
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 00:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQ4gBO9QrUbLzBgmNHr0+M4vO5g26Er8Ts8abfY5OeQ=;
        b=hlJib0pcYpX4FBvcE9X+KolUHg+bd0mTlSmoWzXrWOWlaG0gJTZDXhgU7X+MF0I5DT
         HPv0nNYEOOsDAeSOF1BDxU1pTIZNDUG1xEmnsUnDhE4tUJFuWjhaqogsejloAivWu3yg
         2u6QuatkyFNTJqBIi6Dp/j3Xi1lDJndUvlNMQ8kKT92Nzr3+CHV+QvouLHFRt6ElQNOq
         mp7mK/jzteLbNeKaCuEBfg1DZCI73zpE7LXdRPug+h0hTXUTsuXWUpp4Ga1Otia+MCgY
         IKLYO9idpHJEbbryK3AQDXNGKNM9FQG3QMNsF8MPid3kjCoR/0MQbixhjoKwVNQEVeQo
         uVGA==
X-Gm-Message-State: AOAM530VVDNDTKxXMBtEe/3USUsj7OXIrPb9IWzEOsPTnmfSPvuGsxEN
        ySrkI5kJc5Uu8AicGFfyNDLxpOEJ/LEfiQdLUpc=
X-Google-Smtp-Source: ABdhPJwfLkjbyqTloHIbHAeews0T4MqEwJMUMqTzrZRlwZhvJKXW0SrPA8vuvBTg4I4H5ION/z5rCD1nrDoz3TC5/TY=
X-Received: by 2002:a50:ab51:: with SMTP id t17mr4430478edc.89.1610093965649;
 Fri, 08 Jan 2021 00:19:25 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <CAPig+cSMA0J9fBvG=L0ojWvd5ePwxb6ya67umX1HdOy4LEiZpg@mail.gmail.com> <gohp6kpn2gsepd.fsf@gmail.com>
In-Reply-To: <gohp6kpn2gsepd.fsf@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Jan 2021 03:19:14 -0500
Message-ID: <CAPig+cQSvX2EEGa5h8=kJJkNr2buBiDObN948nx_LaMT4jn3tg@mail.gmail.com>
Subject: Re: [PATCH 0/7] teach `worktree list` verbose mode and prunable annotations
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 8, 2021 at 2:38 AM Rafael Silva <rafaeloliveira.cs@gmail.com> wrote:
> Eric Sunshine writes:
> > On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
> > <rafaeloliveira.cs@gmail.com> wrote:
> >> The fifth patch adds worktree_escape_reason() that accepts a (char *)
> >> text and returned the text with any LF or CRLF escaped. [...]
> >
> > Perhaps I misunderstand, but I had envisioned employing one of the
> > codebase's existing quoting/escaping functions rather than crafting a
> > new one from scratch. However, I'll reserve judgment until I actually
> > read the patch.
>
> Agreed. It make sense to reuse one of the already implemented functions
> from the code base. for some reason I was not able to find it. I believe
> this was cleared out in one of the patches replies by you and Phillip Wood.

No need to apologize. It's a big project and it can be difficult to
discover existing utility functions. Fortunately, reviewers can often
point out useful alternatives.
