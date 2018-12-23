Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF1A1F405
	for <e@80x24.org>; Sun, 23 Dec 2018 08:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeLWIFg (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Dec 2018 03:05:36 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53414 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbeLWIFg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Dec 2018 03:05:36 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so12705264ita.3
        for <git@vger.kernel.org>; Sun, 23 Dec 2018 00:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHxh8aTo58Hr4iwj0gdzY1I4+NNlZkCxt5MV/tQ212c=;
        b=Y/rZJTRFROqtl3einb130eWP9xeHwQQqk2W070n1yP/m332uhCc8nSaQm3CCIzog7P
         WQ1lBEA2F4ZUNPobxJvj2DagI2aM7PeoMu7nfKjyfTJcd6/g5PYWvPPzKq4/x8kg5h0C
         0b0/+P8S0FjMi3gXr6vdXP7uNG7BButrkJ+LaWwjta/a0q8Q8K7zXXuDbykkdv3z8LvW
         N+zTe8a/GAPRLyr62Rx3oPtCQBxNHUTQW1xeZVTVBUHhBTkIF9JwKdrRRR0jr/2TZS3j
         coYueyxq/QcXxS9nJl6mAscugxKhhVukF+1zadSWmmXznp8qdjhfGW+itmqFw5f82cQU
         LMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHxh8aTo58Hr4iwj0gdzY1I4+NNlZkCxt5MV/tQ212c=;
        b=OcGejimTOqFSFqHBTyMByfpYrjs5sn9agMyRgJpIPZPLTstl7/C1JO6k5ahTFjYYMF
         IENUoVDnkU4aSxpmSz3C9f97aEydBEup+XeOjO3swCUiNEzNBV/CZKxx8uMa1DSt2HEl
         ZuF+F9yZY49i7YsxRDXiRw8rS1x20aObcGZQXIWyV1qsHB2xOuOJIYGjoUcvxC7Qf3xz
         uYfIYZHlQLJUTAt3jdV7S8qMAATb+jQNLp15AicZOxwljRGgIm4TJ7MQTKkSrR/6pt2J
         bblqlnL+a2etencJcZtjkAZVMWfy/wCidD/zUDLRq/WNFhJlYzR1nxJnJlT0vzJiuDHE
         pdVg==
X-Gm-Message-State: AA+aEWbjIRNAnk3Nh4q0s6fNgYVZPQGYOywmRfukAwqLplf+ky3M5IHz
        r4MxYIWR1QAFxPyjmwCBJBevoh5k5usSBorvHgE=
X-Google-Smtp-Source: AFSGD/WKMGU6UXihXgj2LS+ChL7wJ0XsunGJSoxpdyZmCy2GnDZ/PtkL4/toK8ps43x0qQk9sF6Y+fMxEbb1TvNIB1Y=
X-Received: by 2002:a02:183:: with SMTP id 3mr5932315jak.130.1545552335047;
 Sun, 23 Dec 2018 00:05:35 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181220134820.21810-1-t.gummerer@gmail.com>
 <20181220134820.21810-8-t.gummerer@gmail.com>
In-Reply-To: <20181220134820.21810-8-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 23 Dec 2018 09:05:07 +0100
Message-ID: <CACsJy8B-jB6o2XYG_6UdTrhrGbos-+5rs98qqQQuJYYV+6W+SQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] checkout: introduce --{,no-}overlay option
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 2:48 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 801de2f764..4ac8c55865 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -260,6 +260,9 @@ the conflicted merge in the specified paths.
>  This means that you can use `git checkout -p` to selectively discard
>  edits from your current working tree. See the ``Interactive Mode''
>  section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
> ++
> +Note that this option uses the no overlay mode by default (see also
> +-`--[no-]overlay`), and currently doesn't support overlay mode.
>
>  --ignore-other-worktrees::
>         `git checkout` refuses when the wanted ref is already checked
> @@ -276,6 +279,13 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
>         Just like linkgit:git-submodule[1], this will detach the
>         submodules HEAD.
>
> +--[no-]overlay::
> +       In the default overlay mode files `git checkout` never

-ECANTPARSE. Maybe "files" should be removed from this line?

> +       removes files from the index or the working tree.  When
> +       specifying --no-overlay, files that appear in the index and
> +       working tree, but not in <tree-ish> are removed, to make them
> +       match <tree-ish> exactly.
> +
>  <branch>::
>         Branch to checkout; if it refers to a branch (i.e., a name that,
>         when prepended with "refs/heads/", is a valid ref), then that
-- 
Duy
