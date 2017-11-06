Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D4A720A10
	for <e@80x24.org>; Mon,  6 Nov 2017 20:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933006AbdKFUgU (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 15:36:20 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:56210 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932796AbdKFUgT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 15:36:19 -0500
Received: by mail-ua0-f178.google.com with SMTP id b11so7317476uae.12
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 12:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nh56CVm6rOVMLp46iXW/0dyplUPqtMHrR0WB5T8pjJo=;
        b=uhEp64dUWV5PKP07fnOVWjj3b/nMaOED9L+4kBsky2vEUZvpctzwldDW8S4z7faz2Y
         OfcRt9VJ84yrT9/LGX1VmKm/J4OQBNpJI3EVDcg3tAvsVKclj6PY0Y4Gs3d7xEeU3jL5
         WWQPVJjooDJhy/5yS9QWM0k/ToSUDxNZktJoGWH4a3Dhdrz5eBp+2GeKOqxqylKEqnpL
         PDeZOG9RJFdw/RG3lDY8w8fvg9TqbGz1EXPzegN9DY3axmNdrIweVbbTnQausYHLRjqR
         vXmwMMBxhEv7q1Ph4hpG55STK8rVF+AfYtxxS55q+Bgc1g7xVmnZ7K4gLyvNrwqyZx9f
         KrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nh56CVm6rOVMLp46iXW/0dyplUPqtMHrR0WB5T8pjJo=;
        b=sRe9Pql+kUoxwNC5bhrSNd+ub4Q2NF66hoCGpgrVolY+Di2IQJkLwdz9KMpDgQluZ5
         2sBpEixE6tsIlBVoT54qTc1RG+HBpKCxrKP1+B6vNuS4msJqM6vL+Y8DUjNM4h0ikQkN
         1M/TWX6rUheRDNiyfZNvAb0m59rPToP9rR72LRKAQ59nPD/Zb0NsbaWmK4Xm1I9Ok5yb
         QAS/MnPBOn3PY+x7fHxyq0uT2cwK8wMsJXM+njD1LXbGkv5yivfHxZ7KKyIl5eOlhZX6
         SrLRT+C0hw+lfjU04N6Bh9wzDRb/11o6MvPA/+r9oFx/rRjh8BgGqVsbFAPFAouvDmSZ
         onAQ==
X-Gm-Message-State: AJaThX5ueOexPPstzxj7k6QYYo/RPXbh+0UuWQ5NFUW2jPcrtB2UH+0y
        6EXzv64QS1CmjoXiftI1G5jVA+YrmG9xbV25GOk=
X-Google-Smtp-Source: ABhQp+TJ+PvJ3B/Hx2C4VE0808FIlGLYki/jx8NlGdjXFWvvhsTK+H1NdqITbGSkMLdjbXJWvKY0NyoBcYlRPPvoy+s=
X-Received: by 10.176.71.78 with SMTP id i14mr13965622uac.13.1510000578784;
 Mon, 06 Nov 2017 12:36:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.56.100 with HTTP; Mon, 6 Nov 2017 12:36:18 -0800 (PST)
In-Reply-To: <20171106183702.GA131418@google.com>
References: <CAGHpTBJTm=3f_VCnNLeE=V4CwvC6dM8qCmGRPDap6rszcpb65A@mail.gmail.com>
 <alpine.DEB.2.21.1.1711031658190.6482@virtualbox> <alpine.DEB.2.21.1.1711031711530.6482@virtualbox>
 <CAGHpTB+23H=iC_uv0K=GajnCBHSVRsUYgGFUn9-bAdcX=azL-w@mail.gmail.com>
 <CAGHpTBJFR2Y+Sg-xQzBpC6qu+NKPDSYyMwSe9Py9FtD2-bRAXg@mail.gmail.com> <20171106183702.GA131418@google.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Mon, 6 Nov 2017 22:36:18 +0200
Message-ID: <CAGHpTBJ9QpEeumzZuO2DeNS-6a6oL2Vn0WNZrm1nt0qFcLfJyw@mail.gmail.com>
Subject: Re: Regression[2.14.3->2.15]: Interactive rebase fails if submodule
 is modified
To:     Brandon Williams <bmwill@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 6, 2017 at 8:37 PM, Brandon Williams <bmwill@google.com> wrote:

> After reading your bug report and the fact that you weren't able to
> reproduce it outside of your project I think i figured out what is
> happening.  Before ff6f1f564c the gitmodules file wasn't being loaded
> unless a codepath explicitly wanted to work with submodules.  Now they
> are being lazy-loaded so if you call into the submodule config subsystem
> it'll work without having to have initialized it before.  I suspect
> that the submodule which is causing the failure has a
> "submodule.<name>.ignore" entry in the .gitmodules file or somewhere in
> your repositories config (I actually suspect the latter based on the
> code path).
>
> When rebase calls into the diff machinery to see if there are unstaged
> changes it explicitly requests that submodule's be ignored, but this
> desired gets overridden by your repository's config, clearing the
> ignored flag and making rebase actually pay attention to the fact that
> the submodule has changes in it.
>
> I don't have a patch available to for you to test just yet (but I'll
> have some time later today to write one up) but could you verify that
> (1) you have an ignore entry for the submodule in question in your
> config and (2) removing it from your config avoids the failure?  If
> that's the case then we would be able to put together a reproducible
> recipe for this failure.

You're right. Thanks for the info. I have ignore = dirty, and removing
it from the config solves the problem indeed.

The following script reproduces the bug (it's the same as before, only
added git config):

rm -rf super sub
mkdir sub; cd sub; git init
git commit --allow-empty -m 'Initial commit'
mkdir ../super; cd ../super
git init
git submodule add ../sub
git config submodule.sub.ignore dirty
touch foo; git add foo sub
git commit -m 'Initial commit'
touch a; git add a; git commit -m 'a'
touch b; git add b; git commit -m 'b'
cd sub; git commit --allow-empty -m 'New commit'; cd ..
git rebase -i HEAD^^

- Orgad
