Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB5561F461
	for <e@80x24.org>; Fri, 30 Aug 2019 20:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfH3UQo (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 16:16:44 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:39271 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfH3UQn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 16:16:43 -0400
Received: by mail-wm1-f42.google.com with SMTP id n2so7276441wmk.4
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 13:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bR2tkSh6s7t24uOXRa95i2l5Qz0hUtsOM6ZWVDli9jU=;
        b=GsRs/0QZ2sAb4JVxGH9L4ysPCLSE+3c5VvAoWtSmdTyG46l3uV/lmYqVpZJ0caLXoc
         xOz/DxhGtyV/vToPw+J+gE1Y50486XUVVryejm42MzFXkhHubdQ47dZd8rgPOlh6NRHN
         vAJA5A2p7TGTftTzBsZO3jlKIlrWppXiys/k3QuunbkKEeQLM4g+eZpQh4Oaef6qNokf
         ug/hCz4uZSp8u3CrJk37eMgPgBG+/d0+fJ23gVwes8OXnbpL+J/UTcczRqa18ikjAG2p
         scx3adx+jf5mJvRFSchyUkH0IDNgO3gR/sHr2+UT97XUed1+4+/TQ4L12jpIlyDO1LGG
         w9Yg==
X-Gm-Message-State: APjAAAVVjwFBxblweopAtiv2ytJB+zTgJXjM7oLfffYpuMFu/6oBf3w7
        XIAaZWxpUCXhcJfZh1z5baljIceARVSPT6WgNLA=
X-Google-Smtp-Source: APXvYqwN0Go39th93xQkDTnG+p68RphqKzpAgiccVW59XgIt14hMh9sgT0FlkDH/HYSqUknBMWUAtXEKe76N2TrSwTQ=
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr19914939wmh.129.1567196201525;
 Fri, 30 Aug 2019 13:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com>
 <20190828225712.20041-1-newren@gmail.com> <xmqq7e6uxw7r.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e6uxw7r.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 30 Aug 2019 16:16:30 -0400
Message-ID: <CAPig+cRPGY4wEbUin3mDj0+nHigtndNWj6o-FHjKeCzgqY9Y5Q@mail.gmail.com>
Subject: Re: [PATCH v3] merge-options.txt: clarify meaning of various
 ff-related options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, Git List <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 30, 2019 at 3:57 PM Junio C Hamano <gitster@pobox.com> wrote:
> If we want to dedicate one paragraph for each of these options, we
> can and should make the introductory paragraph lighter by saying
> something like
>
>         Specifies how a merge is handled when the merged-in history
>         is already a descendant of the current history.  `--ff` is
>         the default unless merging an annotated or signed tag that
>         is not stored in the `refs/tags/` hierarchy, in which case
>         `--no-ff` is the default.
>
> Alternatively, we could sprinkle the actual option name in the first
> paragraph and drop the last three paragraphs, while fattening the
> description as necessary, e.g.
>
>         Whether to prefer resolving the merge as a fast-forward and
>         update the branch pointer to match the merged branch without
>         creating an extra merge commit (`--ff`), never allow fast-forward
>         and always creating an extra merge commit (`--no-ff`), or to
>         only allow fast forward updates and reject when a merge
>         commit needs to be created (`--ff-only`).  The default is ...
>
> I think either approach shown above would reduce the redundancy.  I
> do not care too deeply which one of these approaches is used myself,
> but the redundancy feels a bit disturbing.

I have not been paying close attention to this thread, but upon
reading your suggested rewrites, I find the lighter paragraph (the
first of your options), followed by the three short paragraphs -- each
dedicated to a distinct option -- easier to follow and grok. I think
that's because the lighter/shorter arrangement keeps the three cases
reasonably separate -- thus the reader is able to absorb and
understand each distinct option in isolation -- rather than having to
manually pluck out the meaning of each option from one long, run-on
sentence.
