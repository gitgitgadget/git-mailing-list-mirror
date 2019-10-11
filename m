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
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6721F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 22:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfJKWBW (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 18:01:22 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37374 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfJKWBV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 18:01:21 -0400
Received: by mail-vk1-f195.google.com with SMTP id v78so2458059vke.4
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wqd3iGhFgAyeAqutK7nTywgv1clkXbJOWT7Gt7L97EM=;
        b=U7IWJT6Znikktyk7M5xTzfsn31abqtPV5v0O2JEBmNzDfGoJuGjV1bGa/ersmkvcVs
         VlwpZFZl+pfgDWPOefUveNNAQueBOO0jx2L+XiIzws/izEG7uO1XYYAItDBInnP5QLhi
         EMynyBCTVO0G0eTCNLNsVO8u3ZqZClC6T4ZnJ3Hg6hjnuqDsc0q+tvLqZwmMc/L6jbuy
         mU/nmfp1HYbNnJST8t5H9zXT8HrQvb/ImhdKhA/rkN/Kx7KrxeKrLflO1kt45UIIAVCn
         VfnIhTqNDJCp6xmOh4itMA4ioe9jHdO3BeYwhlUW34XSjctGTdH2zxVpSOROUbMjv/Fg
         oEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wqd3iGhFgAyeAqutK7nTywgv1clkXbJOWT7Gt7L97EM=;
        b=cAdG5VZAbL/0F35rG0MFn4izDMy48ZpUVYoKcUw9JCjNptoueeUrKefFzXWZemnmsK
         eVhPNE6Mp0aJJNDwsRkU1fJvPLQjcPE0kG45ICM9rO1kWaGBtA59I038bafRmIWJbrDH
         bQNv7mPbin+XU//dFzlh/26vwWkMl47Eylk9f8s1CHKXZO6mLucxUanyg2sPUPS6osbk
         rMYS/P46tYz8tz4GnIbmwBxFEKzEVGMJnR+AA+IbvE9zkKtNLEAITiNioq+jBk2J/aGF
         IDfhi4m59twNS8kSUmDNnnGjtlPPMTl7w+wyMgvLX9oC95JhnmZoUO2D7MEJVaJin0zF
         XvvQ==
X-Gm-Message-State: APjAAAWLuu77ySBycU2QgM3EwjTnLPbf0UI/QoAMtC669LwCsglZtfx3
        GMUAaxPz363HsH7fiOUShMb8kkgxtZ7SeheikAE=
X-Google-Smtp-Source: APXvYqwv766e+OyWfor3coAyaEYhzNYopw61Z9iCvSx4xVD79rTnDEOk6T0YWj+aCdbVresoHrAxSZslWvC4RA4iN44=
X-Received: by 2002:a1f:cac2:: with SMTP id a185mr9498202vkg.49.1570831278978;
 Fri, 11 Oct 2019 15:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v2.git.gitgitgadget@gmail.com> <pull.316.v3.git.gitgitgadget@gmail.com>
 <30a0db68cd141bab5a9fb63e26e767579a42249c.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <30a0db68cd141bab5a9fb63e26e767579a42249c.1570478905.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Oct 2019 15:01:07 -0700
Message-ID: <CABPp-BEc3s6UhMN2d+K7xbMCGG=QSP3cQSCob47OWcuFzzw6Zw@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] sparse-checkout: create builtin with 'list' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> +SPARSE CHECKOUT
> +----------------
> +
> +"Sparse checkout" allows populating the working directory sparsely.
> +It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
> +Git whether a file in the working directory is worth looking at. If
> +the skip-worktree bit is set, then the file is ignored in the working
> +directory. Git will not populate the contents of those files, which
> +makes a sparse checkout helpful when working in a repository with many
> +files, but only a few are important to the current user.
> +
> +The `$GIT_DIR/info/sparse-checkout` file is used to define the
> +skip-worktree reference bitmap. When Git updates the working
> +directory, it updates the skip-worktree bits in the index based
> +ont this file. The files matching the patterns in the file will

s/ont/on/

> +appear in the working directory, and the rest will not.
> +
> +## FULL PATTERN SET
> +
> +By default, the sparse-checkout file uses the same syntax as `.gitignore`
> +files.
> +
> +While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
> +files are included, you can also specify what files are _not_ included,
> +using negative patterns. For example, to remove the file `unwanted`:
> +
> +----------------
> +/*
> +!unwanted
> +----------------
> +
> +Another tricky thing is fully repopulating the working directory when you
> +no longer want sparse checkout. You cannot just disable "sparse
> +checkout" because skip-worktree bits are still in the index and your working
> +directory is still sparsely populated. You should re-populate the working
> +directory with the `$GIT_DIR/info/sparse-checkout` file content as
> +follows:
> +
> +----------------
> +/*
> +----------------
> +
> +Then you can disable sparse checkout. Sparse checkout support in 'git
> +checkout' and similar commands is disabled by default. You need to
> +set `core.sparseCheckout` to `true` in order to have sparse checkout
> +support.

Looks like these disappear by the end of the series, so no need to
comment on them.  Thanks for all the fixes, other than the trivial
typo above, this patch looks good.
