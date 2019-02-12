Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAB41F453
	for <e@80x24.org>; Tue, 12 Feb 2019 14:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfBLOPI (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 09:15:08 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52681 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbfBLOPI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 09:15:08 -0500
Received: by mail-it1-f193.google.com with SMTP id r11so7490004itc.2
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 06:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxwzuXNK51rBvI3tbaXvtoazQyT6vSIxrWZjxIUuU10=;
        b=Ik4EjGnR3r4Mieso/0HTtcaVVhy4nbCjKcxdAGHd4naPCLw9V7sDCP3mNBCBkKtCSo
         h2eky6mPij4gS7qIkzw4gwBjnpikdQkGqG+OYfAKXHi0pvOkMzUS6PlxK2rgmkDnfi1v
         V5sdetElIMJt9iNklnbtEmf2+g/HiJ0QmFpVuMMqJYmgKoxEZQfB8eG3NGgsvjXJVWpO
         3VQQWzEYlyA/JCCRIe6x/5tJO7tIVkKoSPvdJjWuAZpVJLZ7Kst3J8n+5bTvhG3nK3IM
         CSAaKEECk05q3aHzyKtV5IvEhjUiq2m+h6tXdOXhBr9Ru9zOOW/58cxYkzYqMoverMbM
         7zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxwzuXNK51rBvI3tbaXvtoazQyT6vSIxrWZjxIUuU10=;
        b=IBnGJVrItOuupPLAjXC4iiRYoYtjJaX4IyVVNk515794hdZ4RjIsNU61W27RsG7dPL
         ztS2WuJRX20TwaLWEqaGn4o0kFWBibR348elG1dRAfI4hvI/xFLIYGzJLaiuI+AOfv3Y
         Ic/AqZjt5AOavaaceQiNUSAsayMcFyGcOh03/328XB0yIlktgTnr0y9+LYbYJ84NVu8d
         /HEg/w7fAbzNOuOwnMiF4AqS/UzQia9QpPHW3s57/C4cyxyGBq60Ws1SUyEGmi1pOaEP
         93xc2LB2Svqx6iR3yzUDHxY4jN2ggZe+/SaQijokbVQTwqWuz+sPAnVwpsrdOKLXj2tZ
         xkBQ==
X-Gm-Message-State: AHQUAubvbbD9pktSGNnhtYnomdbRUi4qjuGZzPchueL1GrwXBdIb/YqX
        SCfHZB16x/4ihdalOC6KRiCv5sWM1qfpNcaz5LEkfj8g
X-Google-Smtp-Source: AHgI3Iam9gT7HlAm64Hpj6dEoXLKlBNeI+5QItBnZY8+oliDU4pB2mC9V79wuVZVqqcoGQmxQNXaLfEfY4ydRUW5b+4=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr1809025ioc.282.1549980907615;
 Tue, 12 Feb 2019 06:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20190201193004.88736-1-dan.mcgregor@usask.ca> <20190209023621.75255-1-dan.mcgregor@usask.ca>
 <20190212134537.GA26137@ash>
In-Reply-To: <20190212134537.GA26137@ash>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 12 Feb 2019 21:14:41 +0700
Message-ID: <CACsJy8Dp+PV-Y=WGbr4bfNdK6zi+qBE5b6Etc+8ZvgDBYWBLjA@mail.gmail.com>
Subject: Re: [PATCH v2] git-compat-util: undefine fileno if defined
To:     Dan McGregor <dan.mcgregor@usask.ca>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 12, 2019 at 8:45 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Feb 08, 2019 at 08:36:21PM -0600, Dan McGregor wrote:
> > Commit 8dd2e88a92 ("http: support file handles for HTTP_KEEP_ERROR",
> > 2019-01-10) introduced an implicit assumption that rewind, fileno, and
> > fflush are functions. At least on FreeBSD fileno is not, and as such
> > passing a void * failed.
> >
> > All systems tested (FreeBSD and NetBSD) that define fineo as a macro
>
> OpenBSD or NetBSD? From this [1], it looks like OpenBSD fails while
> NetBSD compiles ok (and fails to run some tests)

According to this [2] looks like NetBSD is affected too, but only in
no-thread mode. With pthreads, fileno is not redefined as a macro.
That probably explains why it's ok from git-ci.

#define fileno(p) __sfileno(p)

#define __sfileno(p) \
    ((p)->_file == -1 ? -1 : (int)(unsigned short)(p)->_file)

[2] http://cvsweb.netbsd.org/bsdweb.cgi/src/include/stdio.h?rev=1.97&content-type=text/x-cvsweb-markup

> For the record, at least fbsd also defines feof, ferror, clearerr,
> getc and putc in the same way. But at least I don't see how something
> like feof(fp++) could cause bad side effects.

... and __sfileno (and other friends) can cause bad side effects,
sigh. It's probably best to avoid fancy function calls.
-- 
Duy
