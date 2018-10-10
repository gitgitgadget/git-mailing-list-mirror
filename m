Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60AEA1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 22:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeJKGNl (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 02:13:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35578 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKGNl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 02:13:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id y19-v6so6461315edd.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gNRd1S4BH96VMJ+oeMUjw3ryjtWE/ypI/A+65ZXzmc=;
        b=tc2iatTt2o8Qktxc9v46uZatVay1+594unTIuLDd4ND1d457HaZPzgBRYVgwoaHc3H
         YnO5bmTd7X7gmACtb3laWZO2hZKj25x6Wi6OxKdrZjxVO6PP6G9+ovLwdHVUfFcROWL2
         +GToktllrIOrdM3iYdxjM8qP+Qn5XxACwfvSJ7SPAjMB7t2+GZEoJYrX5w2iaxjsqiqB
         kTOqFc1dSrx6yFg90eqeALbOd2jlQntDv1hemptpzb9DbYJ6IGuMWLjcnkEj/tpomi3T
         EbWcUp07K1+RvV8DYY1l4xyiPtUtptlH93M2Z9BKNgvm7hoxL4RqvjbapBhoLNy7yV0I
         zLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gNRd1S4BH96VMJ+oeMUjw3ryjtWE/ypI/A+65ZXzmc=;
        b=pQ1OE6ycbj8ggKKjESoeX7yQzhu33MGEGlRHu2oU2QaOD//3vqaXz2SyXMSitgzmbg
         ysXcGm+mA5FisJzEhXII3VZipIit9mIgtQeg49FJTESnfLFBax2MzLUGtUbISDVVCnYq
         +pEPUtlUTZVPnyuq5bwXnUekGVaWR8XcQRCDnO4GMVWS15AF5wTk5mO2Thv6BDlRDpPj
         bW57MwKcI16BF/lErAg/Vjp5DRe514Np4/8vVSr6n7L7kp5bJru5RNgmjPTNUmwUwnPs
         XIBjEuxCy6OcIbLaqQ9euIvUtZhPn0eSNzWeo07SLXO1kiAiHj+XK72jpvXODOd1jCKw
         yDrw==
X-Gm-Message-State: ABuFfohndQa1mpQp/Y5lp1+KHelNk0rfPiEnwVl1YSVJ6WTHWAdPBRpQ
        cXJlEGGYS2mz9GJ20wq9fJtZOZIJZALW+To+6LNOPnY7gGuHAw==
X-Google-Smtp-Source: ACcGV60kGDnchPJBoRXz6FquznNypzjsgaHEMpJ7vTh0rvlWxGmaHnxgtZK+HGtq/FW3dNHCmy+8t9+pLltIRRh8hVI=
X-Received: by 2002:a50:bc12:: with SMTP id j18-v6mr22884518edh.154.1539211764389;
 Wed, 10 Oct 2018 15:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181009183549.195316-1-sbeller@google.com> <20181010001037.74709-1-jonathantanmy@google.com>
In-Reply-To: <20181010001037.74709-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 10 Oct 2018 15:49:13 -0700
Message-ID: <CAGZ79kbZ35OEh=2JiZuOHgG-P3a3PeSP5hgrXX-tQh9feOQsjQ@mail.gmail.com>
Subject: Re: [PATCH] builtin/grep.c: remote superflous submodule code
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Antonio Ospite <ao2@ao2.it>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 9, 2018 at 5:10 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > It claimed that grep would still need some explicit handling, but that is
> > not the call to repo_read_gitmodules (applying this patch on top of
> > ff6f1f564c4 still keep the test suite happy, specifically
> > t7814-grep-recurse-submodules, which contains a test
> > "grep history with moved submoules")
>
> Firstly, spelling of "remove" and "superfluous" in the commit title.
>
> I don't think the "grep history with moved submodules" test exercises
> much. That test only tests the superproject > submodule case, but we
> need a superproject > submodule > sub-submodule case, because what is
> being removed is a call to repo_read_gitmodules() on a repository
> ("struct repository submodule") that has a superproject ("struct
> repository *superproject"). In other words, we need a submodule that has
> its own gitmodules.

Right; we do have a test 'grep and nested submodules', which still passes.
I added another test, that would grep through nested submodules in
the history (not checked out), but that would not work on nested submodules
with or without this patch applied. (As the nested submodule is not checked
out, is_submodule_active(repo, path) would return false and we'd not dive
into the nested submodule.

I looked into ao/submodule-wo-gitmodules-checked-out, as that touches
this area of code as well and promises to allow working with submodules
when .gitmodules is not checked out, it doesn't help this use case, either.

That is (as Antonio diagnosed), due to get_oid not working with a repository
handle, yet.

> > The special handling is the call to gitmodules_config_oid which was added
> > already in 74ed43711f (grep: enable recurse-submodules to work on
> > <tree> objects, 2016-12-16), but then was still named
> > gitmodules_config_sha1.
>
> If you're stating that gitmodules_config_oid() is where the .gitmodules
> file is lazily loaded, it doesn't seem to be that way, because that
> function works only on the_repository (at least on 'master' and 'next').

yes, that is why nested submodules do not work currently when they
are not in the working tree.

>
> > This is a resend of origin/sb/grep-submodule-cleanup,
> > and I think picking ff6f1f564c4 as the base for the series would
> > also be appropriate.
>
> Any particular reason why you suggest that commit (which is more than a
> year old)? It seems that basing this on 'master' is fine.

After more analysis, I think we'd want to wait for Antonios series to land
and then build on top of that, while also getting get_oid converted.

Regarding this patch, let's retract it for now and revisit it once we have
more submodule infrastructure working.

Thanks,
Stefan
