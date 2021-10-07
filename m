Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74926C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 14:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530B161090
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 14:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241983AbhJGOMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241937AbhJGOMP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 10:12:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9636C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 07:10:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i20so7863109edj.10
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CoIS3P4NFdoaZK8kNuWGtndvzQ5pjWxSW+icmraHNrA=;
        b=OCuR5Oac5ZjEecbCs6b2pEfd9Xrgg2NFfP/qRJUF3Jk7X2rl2aYa2xFNcfdpjADZQr
         UBGSC+OjtND3r6JQ3rjulgikEmOgBlluf6nyfnWiZ4ypntmBvtIfzlef4cPsraeZGSMk
         dPCIIDIcW0/jHuHFSPRHjSByjJOlVUJuWyNpWi61C0uEjYYf8uTW1RpOG29S/8OXf9iC
         CNAu9E8iqbRCMsoGFrH7lxS02mSrSX3j4fBRSGqTvL8BOWKx9UF6qTqjd+rhzx2gzP9E
         sv8mes9Fw27oZpwhDVv9NLt/Jg0bKUpQIqWr3PRYRS0FcC9u/fyxAXUGFCmy5dbfy9QV
         U6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CoIS3P4NFdoaZK8kNuWGtndvzQ5pjWxSW+icmraHNrA=;
        b=BHMxA3EsJ0wqXRxbCJ0oA8Qk7rHwNdxQrjGF/lfcG1aSOEKXO3zbZeCpCY1mNO8wNv
         usjtj7iWyMJIG8Doz6N49B9qQQQFh4bZL47GT/7xlh2ALm7JNQafHQCC418ywMj+isNh
         75BkNNlnz6H4hDGAIFdNTmi1bv0mbMGWfGXZW5bUiOYFb+xdu1MSgsSoRh0xQk/ZErWK
         UCAKLwSP4LWs1pm0uqKXDNA8K9fykXCF5KwKWStHAyUueXwsmMfR7wySEuo3SNp932fG
         Xf1nTsfCKf4kYQ35LTxCO3zE3is0/ajT7AW2suLLxh8YOPqAiLGnLxTYmtqWOkGCqpca
         +8iw==
X-Gm-Message-State: AOAM531p0DF3jrSG0zjfhBAv3b6B2CX7gGxAaUo4p6z6zK5RjMkv7iPr
        k9+2AHTMH86SPGPmLd5yc4IMMfmchRVg/JymMAA=
X-Google-Smtp-Source: ABdhPJxhNJrBvoQAOiJKTZQfBs/AcSQn8Ti8WG1cQ4juOOIQzfpCAGbj8zM70TMCITazT0AVkxaDsRVpi2NJS41m3wg=
X-Received: by 2002:a17:906:c1da:: with SMTP id bw26mr5942741ejb.253.1633615806737;
 Thu, 07 Oct 2021 07:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com>
 <CABPp-BH0U9+KEHTuMdfu-jhL+y3eRzjyfuRzWy9-jGxka8PH+Q@mail.gmail.com> <nycvar.QRO.7.76.6.2110062238540.395@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2110062238540.395@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Oct 2021 07:09:53 -0700
Message-ID: <CABPp-BFmyuQYbUbCVjJfNhyZYwDrG_anZDKdFjy78oeK4zn+Ew@mail.gmail.com>
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 6, 2021 at 1:40 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Mon, 27 Sep 2021, Elijah Newren wrote:
>
> > On Mon, Aug 30, 2021 at 2:36 PM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > ...
> > >  COMMANDS
> > >  --------
> > >
> > > +Clone
> > > +~~~~~
> > > +
> > > +clone [<options>] <url> [<enlistment>]::
> > > +    Clones the specified repository, similar to linkgit:git-clone[1]. By
> > > +    default, only commit and tree objects are cloned. Once finished, the
> > > +    worktree is located at `<enlistment>/src`.
> > > ++
> > > +The sparse-checkout feature is enabled (except when run with `--full-clone`)
> > > +and the only files present are those in the top-level directory. Use
> > > +`git sparse-checkout set` to expand the set of directories you want to see,
> > > +or `git sparse-checkout disable` to expand to all files (see
> > > +linkgit:git-sparse-checkout[1] for more details). You can explore the
> > > +subdirectories outside your sparse-checkout by using `git ls-tree HEAD`.
> >
> > Should this be `git ls-tree [-r] HEAD`?  Do you expect people to just
> > add directories that are found immediately under the toplevel, rather
> > than some that are a bit deeper?
>
> I fear that `git ls-tree -r HEAD` in any monorepo might be a bit too
> overwhelming for any reader.

Oh, right...

> But I agree that just looking at HEAD is probably not enough. Maybe we
> should use `git ls-tree HEAD[:<dir>]`?

Sounds good.
