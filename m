Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175A4C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 16:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9C861153
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 16:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhDOQxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 12:53:34 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:38673 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbhDOQxd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 12:53:33 -0400
Received: by mail-io1-f52.google.com with SMTP id f15so16138655iob.5
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 09:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QINiuDjtJtuVAsJNl40BbTyG+Lm/Jc6HoXaxnMlgmUI=;
        b=J0DzSkCAXfMrY6UVmICiwCymKZrn0uWW5s+tq19ZFNqp5tnUE0RrM0beFO4nCb46DD
         csn2J/qaHWApcXgwPBO9Btrc5HYRJ/17H8yoBFjo5rex+Y9mxk+W1VaAp03NlmwVNbBG
         i+/X2W7fo7s4S/wx5vwnXB+IeDZSYNV8Td24al2UWZIYwPOdffJrF4SmZ89ZcG3wV/Xh
         TzMZpnPU/xkRfgduLvpGDGS18KAuzrnbaEhuzsbT5l3ez/WPrUFkhamL0FlrPPHPAyGC
         sJZqjQx1EEBp9K89TvW1kB/THFlooQRvPoOtjBjqolqzsWI/eBDe/ZCwHJbHEe7rqIxn
         j69g==
X-Gm-Message-State: AOAM533Veqdsyj+jZ4bDuphOccMGSD4U0XYDR7swPHRTyEkO8dooSUa1
        wNbr0nOFIWhMxNILulL3Db37rbCX7v7LuIQwxUyuCteSF3c=
X-Google-Smtp-Source: ABdhPJzZPFJb+XmgkDDIv9NrEORevj4addz2Jfjr1XA4xXDHPvY1w0TDx+nAneFlFxOTVzMICH9twDT93rLbFXQ//t8=
X-Received: by 2002:a5e:8717:: with SMTP id y23mr138489ioj.111.1618505590348;
 Thu, 15 Apr 2021 09:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com> <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
 <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
 <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net> <87tuoijzsy.fsf@evledraar.gmail.com>
 <9af3770f-204b-253b-d7f2-c9d5e7cf2fdb@gmail.com>
In-Reply-To: <9af3770f-204b-253b-d7f2-c9d5e7cf2fdb@gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Thu, 15 Apr 2021 12:52:48 -0400
Message-ID: <CAPyFy2A25EApYOivqhD_-sUNpep9c98DXHh0tXLd7T17qQLFLg@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Albert Cui <albertqcui@gmail.com>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Mar 2021 at 21:29, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> > +* Works across Windows/Linux/macOS
>
> Git supports other platforms as well.

In particular, FreeBSD is an example of a platform that is not in the
above list, but included in Git's CI. Is there an explicit list of
supported platforms (and perhaps a notion of support tiers)?

On Wed, 7 Apr 2021 at 09:09, Derrick Stolee <stolee@gmail.com> wrote:
>
> Here are the hard lines I draw:
>
> 1. This should not happen in "git clone" (other than maybe a message
>    over stderr that hooks are available to be configured through a
>    different command).
>
> 2. Hooks should not update in "git checkout" (other than a message
>    that hooks have updated).
>
> 3. Whatever document triggers a hook configuration should live at
>    HEAD and should not be configured or updated until HEAD has been
>    updated by one Git command (git clone, git checkout), time
>    passes for the user to inspect the worktree, then _another_
>    command (git hooks?) is run manually to reconfigure the hooks.
>
> I think there is a potential way forward if these items are followed.
>
> But I'd like to ask a different question: What problems are these
> custom hooks solving, and can Git solve those problems in-core?

I was looking for repository-provided local hook support for the
FreeBSD repositories, and came across this proposal. I'll explain our
desire, in case it can provide some insight. (We started migrating
from Subversion to Git some time ago and finished the last repo a
couple of weeks ago.)

We use one hook today, and would like developers to keep it up to
date: prepare-commit-msg. We have some standard commit message
trailers like Reviewed by: and Differential Revision: that are
provided as templates, and our prepare-commit-msg adds these to the
default git-provided message that lists changed files and such. These
trailers are updated occasionally - for example, we recently adopted
"Fixes:" and added it to the template.

For us, I think a message that hooks are available or updated, and a
command to install or update them would be fine. I can foresee some
usability concern when switching branches - for example, to an older
release branch, but it's probably not a large concern.

> There is always the extreme option of requiring users to use a
> specific fork of Git in order to work with your repository.

FreeBSD effectively did this when we used Subversion - the modified
commit message template was provided by a patched Subversion via our
ports collection. As you suggested it's workable, but not great.
