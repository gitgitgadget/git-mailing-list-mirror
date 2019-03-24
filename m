Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F045420248
	for <e@80x24.org>; Sun, 24 Mar 2019 07:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCXH6t (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 03:58:49 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39222 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXH6t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 03:58:49 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so9588115ita.4
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V17Fw0py4xqS0JSBq8BuSiPVROigL1dS41OEF1cNvjU=;
        b=glZw1K9Ft60s0oe/ACwXpmpXBUj/yNAvQ/Ktpfg2oBnnVjrjypGiHqarcAvNt8DVLC
         zPTk70qVfg+7HvTnh+bOTawGtnshEP1SYhC1PlpuC1asIX7WCoTWYLit7svxYWyKxstM
         ZApEUP7L2ZW35Jk1RuUIFGVvwtx0PvoUpZskvVhKX+S4xHn5RUIR4gi1d4j7iRU5Rsyb
         AWCg3296AFTgPLRXZcHK/ZYXtcTHiQ+g/ThL/omCvW6GqKYwVFujdYLo4hCDeGAhjlK/
         7PoRXXSkuSy1t4pd3xIwMPeZ2k3B6b8i+r46tJ4yAFBLQ/mUAoZpzJ8jjz9GDPVvRu9d
         0l+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V17Fw0py4xqS0JSBq8BuSiPVROigL1dS41OEF1cNvjU=;
        b=UrEvX5/E37WvCO4H9pQF4sWUC4g3b0bds6p30xzafpRS+hzsK2jQALXCeWQeLa/PWG
         zmlmQVUD5E9kT8qAlr+PlQfB+nL9fMLEHchp57O7zuKz47V8bG+hxSELD373YL5hA0Cg
         ZHVS+T9atyQWd8cSCHHSwDEmffc0cSa6jgh5s+mHrQ1YG5Oe2Jxaxoqj0pLWB1/OP5kr
         j/MAzCtEBQahS3ABJEvHaNsjbCu/BN5lQDWwReipo2JuT9jQ/HtOAt4Pf+sC9eRNf9hg
         BmdG+i5Kcyf2BOQt6HH49Fvin9uAJRHniFjmDazrnTtKXrjtesuatNDJmuLbTwktYrOC
         A9ow==
X-Gm-Message-State: APjAAAU9UalFhba1FysrF44rWu1pQAHXYN60/1drXLoSR0sgTmgWNqCQ
        jpCGw61K3RGQnJ5q+zPPLu3MvFYO4U6YuikJCXPNMA==
X-Google-Smtp-Source: APXvYqwVQej6vP9Q8B1m37QMMamS3tp9TXPn6r6utr+d0ULOCL938NM0nG1s4wKrW+d1mL2H4QQ4gCDY3Ze8/HANOsI=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr4225059itf.123.1553414328679;
 Sun, 24 Mar 2019 00:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <5352115.zUM9HkL6VV@beast>
In-Reply-To: <5352115.zUM9HkL6VV@beast>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 24 Mar 2019 14:58:22 +0700
Message-ID: <CACsJy8Dhio4C6p-ZtJ1ZOq-6UP9GiBg3sXsy4YDKamm5p-zqbw@mail.gmail.com>
Subject: Re: Git excludes fails to avoid git submodule warning
To:     Klaatu <klaatu@member.fsf.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 24, 2019 at 6:01 AM Klaatu <klaatu@member.fsf.org> wrote:
>
> Working with Git 2.21.0 on Linux:
>
> The git-add(1) man page says:
>
> "The optional configuration variable core.excludesFile indicates a path to a
> file containing patterns of file names to exclude from git-add"
>
> But if I do this:
>
> $ echo "docs/themes/*/.git >> .gitexcludes
> $ git config core.excludeFiles .gitexcludes
> $ git add docs
>  warning: adding embedded git repository: docs/themes/foo
>
> It seems to me that this goes against what the git-add(1) man page says.
>
> A workaround I found on stackoverflow is to add any file within the target
> directory:
>
> $ git add docs/themes/foo/README
>
> And then add everything:
>
> $ git add docs
>
> In which case the contents of .gitexcludes is honoured. But that seems like a
> hack.

That's because you're not supposed to add files inside another
repository. The "git add docs/theme/foo/README" should have failed.

This kind of sharing part of worktree between two repositories (the
top dir and one in docs/themes/foo) has never been officiaily
supported if I remember it correctly.

> Am I experiencing the intended result of Git's exclude function? If so, I'll
> happily submit a patch to the man page to clarify this behaviour. If not, I
> guess I'm submitting a bug report here.
>
> Thanks for all the amazing work.
-- 
Duy
