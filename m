Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B591F461
	for <e@80x24.org>; Thu, 11 Jul 2019 16:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfGKQZo (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:25:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44703 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbfGKQZo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 12:25:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so3274866plr.11
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=W+3i6P84eF0U6Avk4Tlf49oGOdU1EoCLLcxPiACgKkQ=;
        b=woP+MTktXSTmC6DxmZU3TslinpxBuC7yOm/pZE1lX2lKNK29vvJn69GSros2d+NFQ4
         EZbQVLlav/39poqOCyX+xTq5sgkQVPxqiK5uxhvTOOF3eiSLnXOJOHqUAQROBCTp1DM9
         hWYDixHOnOjY/4kxAFECy8jCFtZ1cOvyMYRQQaeRGY5X/OUWFSX5+qAgaE7qTH0JUVlD
         8wsAdElrZweIJSOCqMa47Lq3T7MxwiazpcPsxRsvsM0W9tHpzT/tsHYHimRCGaBJaXIH
         L0LuA6aHW4X2j414kBkf6xuQGGhq7vL1ecMJBXmXh2AR4WXSVmfE20BXHU0w37zV9XFo
         EMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=W+3i6P84eF0U6Avk4Tlf49oGOdU1EoCLLcxPiACgKkQ=;
        b=bwNZF9VbGcX3u0HuldAWwnUyqt4Vn2w47TTB/ADTuPR/PHyPx9zWt6SxSwrCOqksw4
         s280lI3Qr7o+7MHcJgZeLZR0x9SEyU1CwHqyuRWHGH5+nNGBzFY3LxlZFA0203bpQfDd
         ZPXmvXlSBEYQH6jFq35Kl54CrrnKFlnmUL4ANJmBjVe/6b5LzXZzze/Ti7tpZXi4ts//
         JTdxKlPmeOc4f3W4xdySnxbLpgEV3TvSe8Pt3QOADB9yKzlM7Yqr71QneU6gSfViOMbN
         T0sDpS4dQECpYvI/HduupjS9oCw08WeV3Ugy39g4AZM8cZLlRSLT0RkKv5KLFIAKDCAJ
         gmaQ==
X-Gm-Message-State: APjAAAWSUhkv34DI8r3w6NzduHZpKkbS2q/rR7uKbDLJFUQKfvot52o1
        rSHGd6b+qgldKrsnLN6bpl7Ib/cnt10JEAC2Oof8iBGI
X-Google-Smtp-Source: APXvYqx/fBDfzQS26BMOFKA/o0cq0LyPFLz20IG1qklHWSrl7KASqhJY8kEe5Aklk+L3KqIPWJuEG6TxQFIVtkkDvSg=
X-Received: by 2002:a17:902:24a2:: with SMTP id w31mr5742976pla.324.1562862343588;
 Thu, 11 Jul 2019 09:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190711081958.2201-1-ariadne@dereferenced.org> <20190711151900.GI9224@genre.crustytoothpaste.net>
In-Reply-To: <20190711151900.GI9224@genre.crustytoothpaste.net>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Thu, 11 Jul 2019 11:25:32 -0500
Message-ID: <CAAOiGNzXreYk9xoVOFkcivrXK4QkH495T7Lq76j3oz593rSzDQ@mail.gmail.com>
Subject: Re: [PATCH] log: use mailmap by default
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ariadne Conill <ariadne@dereferenced.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Thu, Jul 11, 2019 at 10:19 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2019-07-11 at 08:19:58, Ariadne Conill wrote:
> > The `git log` command shows the author and committer name recorded in
> > the git repository itself, while other commands respect `.mailmap`
> > by default.  I believe this is a bad design: it causes log entries to
> > reflect inaccurate information: anyone who changes their name or
> > e-mail address will not have that change (recorded in mailmap file)
> > reflected when using `git log` by default.
> >
> > Anyone who explicitly wants the current behaviour can clearly request
> > it by setting the `log.mailmap` setting to `false` in their
> > `.gitconfig` file.
>
> While I'm in favor of using the mailmap by default, typically we want a
> way people can override a default setting from the command line.
>
> So in this case, we have "--use-mailmap", but we don't have a
> "--no-use-mailmap" (at least, it's not documented in the manpage). I
> think we'd want to add such an option so that people can set it if they
> need non-default behavior.

I agree that there is probably some useful reasons to have this
option, so I can add an option that forces mailmap usage off to
supplement the --use-mailmap option.  It's no problem.  I will
generate a new patch series in a few minutes.

Thanks for reviewing!

Ariadne
