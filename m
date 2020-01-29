Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FC5C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 12:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9631F20720
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 12:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSyCy/dC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgA2MKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:10:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36029 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgA2MKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 07:10:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so18392309edp.3
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 04:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=406wi64eAAK39XIDtXviArCvHMrBYgybqqnoSGcGa8Q=;
        b=nSyCy/dCms4VMKRfYxmi9nJmXetsuxl7kIv1eavNMtSIwX+6ZbdeMLLTE7Mfc+ASXR
         UOaG/Rk0WKhH//AVKOmxOUTATXS3LscEw63OHFL2tRfg/hzcGGkrkcMWZE6TPTNFSDT8
         EtDxs2hVJiuQDxwvOQLe2iruUC8QopO0b+CC28+bmOV+oa5hwIwoO9Lv2oSEX6qkZ771
         NhkqxS/XUq6FZtMJrLfDsTW+opymawHiW/3Eh+/s8PcfqOFa6Ega+Vvpk7AqsljNhm2c
         mV6TCjHJMdcCGfWvNadGooYRy/daAXuLA05PPAJPvNMofce/A5OVuiiKyjZO5IFf/6f/
         Agug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=406wi64eAAK39XIDtXviArCvHMrBYgybqqnoSGcGa8Q=;
        b=GiK5IiymBvLuIPheAMT0t6XZUbsd3+TIB7dGce7Fx2ywke9KMB0e9FKUQOA+RE/vyG
         /fv0LbD5AvDhD4xG2tiTYJqCWlBwb+fidfBdpMhWUhJtwCtGhfW2eIsanOoopHvJLP1a
         1We8g9/wuHlpfG8v229sICVZ8VyUv5uqsAVpPYcEnAnuYcXxx1bkrYfkxMkj7hzAN9Zz
         6hRhj/Uws0g1EYkviK40e7/yBUjwwsnyHTP+BCKIbiZZll/niSwnU2RMR0yZbOnEGpNB
         F9he7z4TQ/TIBIAOfwouZObtinOoTcvkDzOrfV2xJsT2s1aGermXAxm4+UTbAuPYpFRi
         rQtg==
X-Gm-Message-State: APjAAAVNbhiqH50rHW8qbXAzFNlmy89OxR8lsHVYjIGAB0ufAbKIbdqV
        YSa/d2gR9CY6x/lAxz6E8KBeV2EIfpNnvn7moYYQkQ==
X-Google-Smtp-Source: APXvYqxBFpbjBXX3qaZYzDvNBqaV8kUUiG51vTNhTFTBvckGcc9i9MRGy7Jf+BXKebq9owHpB7ffZQ+MCoLX9DTj3N0=
X-Received: by 2002:a05:6402:17f2:: with SMTP id t18mr7716633edy.9.1580299814374;
 Wed, 29 Jan 2020 04:10:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.537.v2.git.1580091855792.gitgitgadget@gmail.com>
 <pull.537.v3.git.1580185440512.gitgitgadget@gmail.com> <xmqq7e1b8jyq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e1b8jyq.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Thu, 30 Jan 2020 01:10:03 +1300
Message-ID: <CACg5j26EEMYkbp4F0AoVSKE5BWwYXvxRqJSovRdzNitqbHzzqQ@mail.gmail.com>
Subject: Re: [PATCH v3] git: update documentation for --git-dir
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 8:22 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  --git-dir=<path>::
> > -     Set the path to the repository. This can also be controlled by
> > -     setting the `GIT_DIR` environment variable. It can be an absolute
> > -     path or relative path to current working directory.
> > +     Set the path to the repository (".git" directory). This can also be
> > +     controlled by setting the `GIT_DIR` environment variable. It can be
> > +     an absolute path or relative path to current working directory.
> > ++
> > +Specifying the location of the ".git" directory using this
> > +option (or GIT_DIR environment variable) turns off the
>
> Consistently quote, like `GIT_DIR`, here?
>

Ok

> > +repository discovery that tries to find a directory with
> > +".git" subdirectory (which is how the repository and the
> > +top-level of the working tree are discovered), and tells Git
> > +that you are at the top level of the working tree.  If you
> > +are not at the top-level directory of the working tree, you
> > +should tell Git where the top-level of the working tree is,
> > +with the --work-tree=<path> option (or GIT_WORK_TREE
>
> Likewise.  We may probably want to say `--work-tree=<path>` inside a
> bq pair, and definitely `GIT_WORK_TREE` inside a bq pair.
>

Ok

> > +environment variable)
> > ++
> > +If you just want to run git as if it was started in <path> then use
> > +git -C.
>
> This is the best part of this patch, I would think.  But you said
> <path> in the "if" part of this "if--then", so (unless your Git
> magically can read users' minds some magic), I'd expect to see the
> same <path> to appear somewhere in the "then" part.
>

By <path> here I'm referring to the path parameter of git --git-dir=<path>.
And by mentioning `git -C` without any parameters, my intention is to point the
user to scroll up and read about git -C and its parameters. Given that was
confusing to you, I don't mind stating the command in its simplest form as
you suggested: `git -C <path>`

>         If you just want to run git as if it was started in `<path>`
>         then use `git -C <path>`.
>
> perhaps?

Thanks,
Heba
