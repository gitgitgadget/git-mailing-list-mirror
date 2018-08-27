Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAA871F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeH0XBF (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:01:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45175 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeH0XBF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:01:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id p52-v6so15897eda.12
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvv+RSKMevC+aIu4t4oIVWh8wqxY+4f0uyVNaqaSD5k=;
        b=O3e+8Esgz8UQSMa5NmrCJZY/CeI4gT8CsDG5hohKS++0LHoDN8hOGCvWf60vHBD6wc
         UVQErDMOIThV2ItoW6B5F8r9SIthOfKmmn/4f9fXIuOAFTeq0hekb+tEO1jsHZINq0M1
         UL/PPRt3E88Ny5IrUjWzALsTDJkcWvWyh1d6im+17/oWQRy943VDHZ0WrI7jAhsbEI1r
         b/ge9zNNWqMN35gdZlIligEb3GzVs8dBvwPoudLiXCenCTdVwIH1SOBR9YWeB4+vn8bh
         cSz0VKwIsKOEjs8d3mYSm/MgQ8q2ivGnaMI+Ixfj1PLPzU5siu0t8XsWKflCv+NhTMzA
         qPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvv+RSKMevC+aIu4t4oIVWh8wqxY+4f0uyVNaqaSD5k=;
        b=kx7cVTOw+c13yKqyjNubyS2EBOFW6Hg6/Pue3RhDqw3Y9xHni0eSPML0BNRJKivr2t
         NjeAacxWdhnGHHZ20cjdKS7hUY47DCBbjeWtGOrxm+hrDDIHz/O4kyd5U7jo8o7MlsEw
         orY2bQGOtbGNFQ0P3Kwig0vFTTVO9TYS2cImPYkZcLHmjjNMQs1n8vxlkHLOFAJtQw3A
         W9k/0OVQjwGgKacNMqcSuyDGs7MOd6WtE3kHnu3gL+XVm6Du0uQBXYCPZz5LVcFJ4alu
         AjGJgVAdFbdKH2S7vW9XPqKoJDl5fczGLo0viSsJAEQCSiPxLmzs+NVQze8iTkA1dDs8
         XG8Q==
X-Gm-Message-State: APzg51CbHp9sEfTXNx3+kOPCDRylzTAdw3IvNcfPNwM4yINdIaLXRooV
        dsakLh2FdrAHUF4mFTfbQbUzhaUnpD2VzyNPV+WfjA==
X-Google-Smtp-Source: ANB0VdZ7w0tEmVcVjIntNAiclspiIE8s6eE02D0H1IRtR4mKI6n3ECEcyVXJhO/C9UKy7nH/C1KBLnL1Kr87glkFm24=
X-Received: by 2002:a50:cc0a:: with SMTP id m10-v6mr18056963edi.81.1535397190049;
 Mon, 27 Aug 2018 12:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180826100314.5137-13-pclouds@gmail.com>
In-Reply-To: <20180826100314.5137-13-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 27 Aug 2018 12:12:59 -0700
Message-ID: <CAGZ79kb=gcmEDGmTS-j-veFj8BgKup0g96i0Gm1P+j8eyX8_mQ@mail.gmail.com>
Subject: Re: [PATCH 12/21] patch-ids.c: remove implicit dependency on the_index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -int init_patch_ids(struct patch_ids *ids)
> +int init_patch_ids(struct patch_ids *ids, struct repository *repo)
>  {
>         memset(ids, 0, sizeof(*ids));
> -       diff_setup(&ids->diffopts, the_repository);
> +       diff_setup(&ids->diffopts, repo);

Just realized when looking at this diff, though it applies to
other patches as well. (and reading Documentation/technical/api-diff.txt
confirms my thinking IMHO)

What makes the repository argument any special compared
to the rest of the diff options?

So I would expect the setup to look like

    memset(ids, 0, sizeof(*ids));
    ids->diffopts->repo = the_repository;
    diff_setup(&ids->diffopts);

here and in diff_setup, we'd have

  if (!options->repo)
    options->repo = the_repository;

or even put the_repository into default_diff_options,
but then I wonder how this deals with no-repo invocations
(git diff --no-index examples for bug reports)
