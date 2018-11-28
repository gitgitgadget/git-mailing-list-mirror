Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4DE1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 16:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeK2DeN (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 22:34:13 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35896 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2DeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 22:34:13 -0500
Received: by mail-vk1-f194.google.com with SMTP id t132so5297842vkc.3
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 08:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4z4f/GkktrfjZ91Tp6CV8bk9bbU+NXRUUXJNHyoAw7M=;
        b=hDMR2SpC7mGm+UTL7BacFxytJxqEOLDmRSmpGGpbRVoLSR/omXXZHITvA7Eh+qFV90
         KlDiMVCyemNAeT3RUV20Ro7z+YO2ekeoKRQexTLbDiytaKnlzKdRtKVCspRDDJ3IBszv
         LRRKMH2jp82mqX2jAeu3h8FWb0+7OLidvyz/uZ41J8chaMVdhBDK2GRbS6PT9UyyfNaM
         q92To3jI0G+rHKrpI3Rzl9Ujr+mRYG7cFmENcLLUmNMMJjEvVxO2MRMh62I8tDvjiQm7
         zKEHj8c0DeD/ahaF7EztKQHbRXKTwtRSowSuNJ6Urq8IbkSOQXk+EZ2p9qLQm6oCxwHI
         U8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4z4f/GkktrfjZ91Tp6CV8bk9bbU+NXRUUXJNHyoAw7M=;
        b=BNXfuUqOUFtW90EScjWB64RJufkZpxGct/GmRgqN82TH51bBq8szkBPY9Rr45n2UvQ
         DJwnYRw9XW1qzUvtkZgGac/fy0XbXCu0JEKs23acYuiddsUwmIrZDo8HSkWHQjsaEyv4
         T1Jl/vHAH70aC2i9yQ5IMYdhlS9DQBi4yvXzYZE9DZW9JTpr2dRTr9u3LFG74ZEOkqET
         mtEHDZiMDU2ICyFYvPTSUi92TAmdj5/pmpFG0HrNK8x8iqxahGWvkuibT57UT9PU/WGk
         3FuSz6udWP62t9uM0Fip5c5tRJxD6ubiEWfiNiY3y4eZQ+UFRpReMYkTd8e7AzpRZRV2
         Xk2A==
X-Gm-Message-State: AA+aEWajyAdFUabxVLVP5fAIQlQrCLKP3McTgLqqG6385T1NhaQ4wY31
        h5XvN7NkzoRrBXzj3yxix7KRj33L22k55ZNpS5g=
X-Google-Smtp-Source: AFSGD/Uv4lHEq5ymOFsZpwM3xObq/L8NvxfIoH4ulUWOc3een+uPfmC1Tg8TuRvutvgBZOEg8R6QZkrlx3Di0YQTQTU=
X-Received: by 2002:a1f:97d1:: with SMTP id z200mr15265244vkd.15.1543422718084;
 Wed, 28 Nov 2018 08:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20181108060158.27145-1-newren@gmail.com> <20181122044841.20993-1-newren@gmail.com>
 <20181122044841.20993-2-newren@gmail.com> <CACsJy8BpVgTaE0EM9qkj5dK68x85ZbMmDZ-S7Jvf_KDqYrAW=A@mail.gmail.com>
In-Reply-To: <CACsJy8BpVgTaE0EM9qkj5dK68x85ZbMmDZ-S7Jvf_KDqYrAW=A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 28 Nov 2018 08:31:45 -0800
Message-ID: <CABPp-BHAaap05w0e3d5k5tTHbbmba2OT=3k+=_hWvcZz5fh17A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] rebase: fix incompatible options error message
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 8:12 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Thu, Nov 22, 2018 at 7:32 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > In commit f57696802c30 ("rebase: really just passthru the `git am`
> > options", 2018-11-14), the handling of `git am` options was simplified
> > dramatically (and an option parsing bug was fixed), but it introduced
> > a small regression in the error message shown when options only
> > understood by separate backends were used:
> >
> > $ git rebase --keep --ignore-whitespace
> > fatal: error: cannot combine interactive options (--interactive, --exec,
> > --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with
> > am options (.git/rebase-apply/applying)
> >
> > $ git rebase --merge --ignore-whitespace
> > fatal: error: cannot combine merge options (--merge, --strategy,
> > --strategy-option) with am options (.git/rebase-apply/applying)
> >
> > Note that in both cases, the list of "am options" is
> > ".git/rebase-apply/applying", which makes no sense.  Since the lists of
> > backend-specific options is documented pretty thoroughly in the rebase
> > man page (in the "Incompatible Options" section, with multiple links
> > throughout the document), and since I expect this list to change over
> > time, just simplify the error message.
>
> Can we simplify it further and remove the "error: " prefix? "fatal:
> error: " looks redundant.

Sure, I can do that.  Looks like there are a few other cases that need
fixing as well:
$ git grep error: builtin/rebase.c
builtin/rebase.c:                       die(_("error: cannot combine
interactive options "
builtin/rebase.c:                       die(_("error: cannot combine
merge options (--merge, "
builtin/rebase.c:                       die(_("error: cannot combine
'--preserve-merges' with "
builtin/rebase.c:                       die(_("error: cannot combine
'--rebase-merges' with "
builtin/rebase.c:                       die(_("error: cannot combine
'--rebase-merges' with "

Perhaps, for consistency, I should also change the error message in
the git-legacy-rebase.sh script to use 'fatal' instead of 'error'?:

$ git grep error: *rebase*.sh
git-legacy-rebase.sh:                   die "$(gettext "error: cannot
combine interactive options (--interactive, --exec, --rebase-merges,
--preserve-merges, --keep-empty, --root + --onto) with am options
($incompatible_opts)")"
git-legacy-rebase.sh:                   die "$(gettext "error: cannot
combine merge options (--merge, --strategy, --strategy-option) with am
options ($incompatible_opts)")"
git-legacy-rebase.sh:           die "$(gettext "error: cannot combine
'--signoff' with '--preserve-merges'")"
git-legacy-rebase.sh:           die "$(gettext "error: cannot combine
'--preserve-merges' with '--rebase-merges'")"
git-legacy-rebase.sh:           die "$(gettext "error: cannot combine
'--rebase-merges' with '--strategy-option'")"
git-legacy-rebase.sh:           die "$(gettext "error: cannot combine
'--rebase-merges' with '--strategy'")"
