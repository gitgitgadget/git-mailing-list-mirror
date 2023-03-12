Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C32C6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 11:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCLLxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCLLxI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 07:53:08 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3A913D4E
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 04:53:06 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id p10so1266278qvo.2
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=adamj.eu; s=google; t=1678621986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nBXSxziUTV80UwUXHtmND5KwxoGVz0X+quvE/iBbQiM=;
        b=U0VQ+0b3rLVpalCVJROIRmsCKDTJE4tMGXf0A6Q0Z1YKhheutqshLMOL/Sy4nZU+Yv
         ZpZbNOVvU97xsb5523IOiXXhv7JKl0yW9UdVoBUGEyX/tj7G9MHAtspz0HbR03/1+CiW
         xFXEEJt0SU20HRiPOKgSq01ZB5eQRD6YuF7yLX/55buT4TUfqAcBgOBWmL6Gw+8HZ9Gm
         5N9GNhA7Iy2DIAYmv5oXypwWruxw2ZYV65/HiEKrFuo8GOedKqZ7b1ODrkrJFEoNWdP8
         Eg60FwRLG8scbvJY8Y6aIItUSny2nIUOfhbh/T2QayvsazlW8Nd5aZc1CvosTFox5aml
         Zadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678621986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBXSxziUTV80UwUXHtmND5KwxoGVz0X+quvE/iBbQiM=;
        b=wer1S3IpgAbjD7znl4QP2eomJ/I8W1bOG8kJokWfnk6AP2vL3qoxYOWhuP8f5KPwuD
         XyeC2AgI8NtoQsB70zuSE+mihmPwvXb9U1+sjhKCowcEowcHA2WKr9yTXczlUt9MzLAL
         HIOV5UDeN849JRzNyF/9aYHdf4EgZh9shfY1FtikSsCyIrHB1UpdNHF1Hb6UvJiaUgM3
         CgxJRPjcvYjww3pGtVkZDNQONrEt/ykn+kJ+gYHWMXORSP47np+TDr/5Ev93i+CHbYZI
         RJDwAoCCAi1I9QvWSKjwFVwfhYJzHVJkrXbTH0tTbBwIifnGdAvJvFkAWIuk8w8r5JNb
         2Riw==
X-Gm-Message-State: AO0yUKUE6MiG9n2JgpEn7sUuM8pRp0trESRIlWePyG+M0HHeZrhwl3Fk
        GnjgdpxiI/ye53exCnvWMrShXlD8/ul8nmtzijGRw385tYU=
X-Google-Smtp-Source: AK7set+19jMFAv30iIzZ2mP+yTmyzSstnkZCCwhfy2cuOOMVqsY0bu2/PbNAD0i4NqbEvx3gwKvEoQOojjY7xuEMvQ0=
X-Received: by 2002:a05:6214:8c9:b0:571:1539:9440 with SMTP id
 da9-20020a05621408c900b0057115399440mr1210964qvb.0.1678621985701; Sun, 12 Mar
 2023 04:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1466.git.git.1678526355280.gitgitgadget@gmail.com> <xmqqzg8jxc2r.fsf@gitster.g>
In-Reply-To: <xmqqzg8jxc2r.fsf@gitster.g>
From:   Adam Johnson <me@adamj.eu>
Date:   Sun, 12 Mar 2023 11:52:54 +0000
Message-ID: <CAMyDDM3VyCdwOLhay0PC8G6azoWCFpxoB1K76mvo5nd2C+sfCg@mail.gmail.com>
Subject: Re: [PATCH] ls-files: document that pathspecs are supported
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Johnson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Junio, that's very good review feedback. Thank you for
finding the correct past commit. I am submitting an updated patch now.


On Sat, Mar 11, 2023 at 8:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Adam Johnson <me@adamj.eu>
> >
> > The command has taken pathspecs, not just filenames, since f0096c06bcd
> > (Convert read_tree{,_recursive} to support struct pathspec, 2011-03-25).
>
> Isn't that commit about ls-tree?  The commit does change how the
> tree overlay (i.e. the --with-tree=<tree-ish> option) interacts with
> the given pathspec arguments but that is only because that commit
> changes how read_tree_recursive() has to be called.  The support of
> pathspec matching in ls-files dates back to 56fc5108 ([PATCH]
> git-ls-files: generalized pathspecs, 2005-08-21), arguably even
> before the commit "generalized" the already existing path pattern
> match feature.
>
> > diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> > index 1abdd3c21c5..2f62374062c 100644
> > --- a/Documentation/git-ls-files.txt
> > +++ b/Documentation/git-ls-files.txt
> > @@ -21,7 +21,7 @@ SYNOPSIS
> >               [--exclude-standard]
> >               [--error-unmatch] [--with-tree=<tree-ish>]
> >               [--full-name] [--recurse-submodules]
> > -             [--abbrev[=<n>]] [--format=<format>] [--] [<file>...]
> > +             [--abbrev[=<n>]] [--format=<format>] [--] [<pathspec>...]
>
> Good.
>
> >  DESCRIPTION
> >  -----------
> > @@ -127,12 +127,12 @@ OPTIONS
> >       in each directory, and the user's global exclusion file.
> >
> >  --error-unmatch::
> > -     If any <file> does not appear in the index, treat this as an
> > +     If any <pathspec> does not appear in the index, treat this as an
> >       error (return 1).
>
> This is no longer correct.  "If no path that matches <pathspec>
> appears in the index".  When we are given <pathspec>, say '*.txt',
> a path whose string is literally '*.txt' may not appear in the index,
> but as long as there is a path that matches the pattern exists,
> this option does not lead to an error.
>
> > -<file>::
> > +<pathspec>::
> >       Files to show. If no files are given all files which match the other
>
> The description also needs to be updated.  "Limits the files to show
> to only those that match the given pathspec" or something along that
> line.
>
> Thanks.
