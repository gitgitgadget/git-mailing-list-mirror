Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F181FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 17:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932455AbdBIRcA (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 12:32:00 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:35902 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753524AbdBIRb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 12:31:26 -0500
Received: by mail-it0-f52.google.com with SMTP id c7so130310577itd.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 09:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2O2lcTKYU+U+710vXWubZQCXPpz1eqxKbaX3NfjSDdU=;
        b=DFVBA6Vvsa1KNSj82cY6x8k7p4QFVtkRdfhL1Bd/aemKta2LqEZaWd167TPbhob43L
         zUOqqaENoF9uQSlCjEC3VwObeA9/a3uqWzosgo5LI9R/Kjjpm/YMYEaj5D8L7uYCCK0n
         fBwTX/iLZ2VSn4iLBhRrvkOOv3PVIGv9mc+b8UJTasPFhqGZcD6/EaQbhVo0HGJXPLk4
         rejRX5H9EFHzvWzU+s/IbdKvrLvlVT/qifRbGus67LM5woaE8iq/IYE+DBjpCJb5lxSy
         2KGLLIJCzctxq/dXOz3y8ukzI4F25LCHPLTCJQb8PDRlLIKJTsFsIumePUQdDeOAVKUo
         EOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2O2lcTKYU+U+710vXWubZQCXPpz1eqxKbaX3NfjSDdU=;
        b=FghiIeLCdA3Ezm31LH+8xJKd/XF50fih2ytGJQ4U1lm9RLxe1qGq+HXKqQUyenO1vg
         ZBDyrJECZpnmOhWeyxldw9yrFq7x3BPETyytYEb/wrpE97tvIIepj3cdTngNsJyTOTb0
         TXj5Cz0LOFs5wR3ABwqSTyInxBubPttFdMAAvxqhSR1SS048OGWlHq0zGHcmuYGig9Pe
         10Q1znsXWmexDLKpMb4qyGWEhNY69nFMolGnT3K7Vo3UmhU0hoC+K+JzCwFvF0Qlpqdq
         b+eomB923XU9QCKc64uL2bLZqu0CTblRY/A8vmgN1TMUT1muIdK1OxY/rMRFfR2oCPVF
         9zaA==
X-Gm-Message-State: AIkVDXJpZXsgbiDYRlSz6IchrAMytuznd06Tq0FqWC7lWPZB7cVfEwKWCjQLXuUltlY+czIK7UTFJryn5Gqv+I/c
X-Received: by 10.36.65.4 with SMTP id x4mr23464580ita.69.1486660850084; Thu,
 09 Feb 2017 09:20:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 9 Feb 2017 09:20:49 -0800 (PST)
In-Reply-To: <ce326e17822184eff434b957d28f2233795162db.1486629195.git.mhagger@alum.mit.edu>
References: <cover.1486629195.git.mhagger@alum.mit.edu> <ce326e17822184eff434b957d28f2233795162db.1486629195.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Feb 2017 09:20:49 -0800
Message-ID: <CAGZ79kYrqfmNGE0A63iYaW=MSFwANRXnn3kkxHE8kpOtF2KeLA@mail.gmail.com>
Subject: Re: [PATCH 3/5] register_ref_store(): new function
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 5:27 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Move the responsibility for registering the ref_store for a submodule
> from base_ref_store_init() to a new function, register_ref_store(). Call
> the latter from ref_store_init().
>
> This means that base_ref_store_init() can lose its submodule argument,
> further weakening the 1:1 relationship between ref_stores and
> submodules.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---




> +
>  struct ref_store *ref_store_init(const char *submodule)
>  {
>         const char *be_name = "files";
>         struct ref_storage_be *be = find_ref_storage_backend(be_name);
> +       struct ref_store *refs;
>
>         if (!be)
>                 die("BUG: reference backend %s is unknown", be_name);
>
>         if (!submodule || !*submodule)
> -               return be->init(NULL);
> +               refs = be->init(NULL);
>         else
> -               return be->init(submodule);
> +               refs = be->init(submodule);
> +
> +       register_ref_store(refs, submodule);
> +       return refs;
>  }

This function is already very readable, though maybe it would be
more readable like so:

{
    const char *be_name = "files";
    struct ref_storage_be *be = find_ref_storage_backend(be_name);

    if (!be)
        die("BUG: reference backend %s is unknown", be_name);

    /* replace empty string by NULL */
    if (submodule && !*submodule)
        submodule = NULL;

    register_ref_store(be->init(submodule), submodule);
    return refs;
}

Well, I dunno; the function inside the arguments to register seems ugly, though.
