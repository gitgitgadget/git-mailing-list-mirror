Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EFDC433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAB16146D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380991AbhCDAW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:27 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:34465 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357157AbhCCITT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 03:19:19 -0500
Received: by mail-ej1-f53.google.com with SMTP id hs11so40457766ejc.1
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 00:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YeoKnQlTR9qIj/EAC84Fhfw8PZb1EgVlHbDxxtl0Kc=;
        b=kmx8Qtpvt2U6AHq1ZHHzYA1TKknnAPINHfSzPtbgZT2HMmSwzZzIqBNd+4C/e6F1HP
         MyTRDVJB75og2OkfNGlG/aSzAVN0WqA5LEBEP8/brEzf36mdY3Bh2gbIlyE8yRWoaw4O
         R9IMbOHUUcHWntUSEFuo3VGxZZhtDXUm7tt6tgcsINpZ7zvLM0gnSQVAdb57RwKd0j78
         kd3EVQn3ZpOsQdmzrexMoVFVFds9C2E0DAUIJi7SKY81vTbsz7emSsl9FEZ6P6yi4zz9
         oR0aEYDggWMcFTCzGk3sESvw/10i816CBOutHskn2PkMwpEWGgzCR82SMjAOTVirzFg3
         /bSQ==
X-Gm-Message-State: AOAM532rMvng+1ghaxIxU6l4OlcrQCBfP1QIv+UqiO0wCSKgwAOp750O
        tK7fS6EmypzP0cZ+f8QLaImWP4EI+oiohF5w40I=
X-Google-Smtp-Source: ABdhPJwsooxZDlfyxzH3zuqNYnJbQTRPd8vQ2CyF6WXCWAwFNoNCEcp8AjSNf1bLJ0VWd8WeU6IFO794YIXnqqIHjUo=
X-Received: by 2002:a17:906:7c48:: with SMTP id g8mr1293140ejp.138.1614759516979;
 Wed, 03 Mar 2021 00:18:36 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-7-charvi077@gmail.com>
 <CAPig+cRvwvT7QrO0-aLZX-2vsBPJSq6WO-O7g5A0OjDMNAYmCQ@mail.gmail.com> <CAPSFM5c1zR6yz=gATGxih0wL-W18AWgCHQhL_SPno5SeTzGQGg@mail.gmail.com>
In-Reply-To: <CAPSFM5c1zR6yz=gATGxih0wL-W18AWgCHQhL_SPno5SeTzGQGg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Mar 2021 03:18:25 -0500
Message-ID: <CAPig+cRiiQyavaMGzgBkXOoGFPhMBC7GbpB61ziFMrckReFbcQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 3, 2021 at 2:44 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> On Tue, 2 Mar 2021 at 12:09, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Mon, Mar 1, 2021 at 3:52 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> > > +       Without `amend:` or `reword:`, create a `fixup!` commit where
> > > +       the commit message will be the subject line from the specified
> > > +       commit with a prefix of "fixup!'". The resulting "fixup!" commit
> > > +       is further used with `git rebase --autosquash` to fixup the
> > > +       content of the specified commit.

By the way, now that you explained in the other thread that "short"
prefix-matching of "amend" and "reword" are allowed, I realize that
the documentation doesn't mention it (or at least I don't remember
reading it).

(Nevertheless, I still feel uncomfortable about supporting short
prefix-matching in the initial implementation without any evidence
that users will demand it, since we can't change that decision once
it's in the hands of users.)

> > > +       When the commit log message begins with "squash! ..." (or "fixup! ..."
> > > +       or "amend! ..."), and there is already a commit in the todo list that
> >
> > Should this also be mentioning `reword!`?
>
> No, as both `amend` and `reword` suboptions create "amend!" commit
> only. I think it seems a bit confusing but I will try another attempt
> to reword the document.

Hmm, I see. So "reword!" is really just an "amend!" with only commit
message but no patch content. That makes perfect sense from an
implementation standpoint, but it makes me wonder if it would be
easier for users to understand if it created a "reword!" commit which
would be recognized as an alias of "amend!". (But maybe that's getting
too confusing, and my musing should be ignored.)

This also answers an unasked question I had regarding the duplicate
"amend! amend!" check. I was wondering why it wasn't also checking for
"reword! reword!".
