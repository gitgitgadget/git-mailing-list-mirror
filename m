Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB3AECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 20:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiIFU0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 16:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIFUZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 16:25:58 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAD093531
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 13:25:55 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1279948d93dso11235357fac.10
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=5udPweozc5hAOR31glSVe1C43qFntkSJ+4BgeO8yy1M=;
        b=PVz0QwfIgzax7xuOfzDB3f2NJLoasF1PL1CIGseIwIdXTrFY5IEaqM93ZXolB3LB/t
         ZDef2aJTT7cPmh9Zq4D/FEpPch1VibEko3bGXE0hZdQGf2de3bxkGzdjySYftlUQcESr
         +lDS6Y70jlkSac3YRrCHD68T6D4uUUgi0HP/uPIo8BR3mDdgCZ5nehSchpZqY4ijjqZ+
         4F1enDe1ItzzEfSVzh5E1mamBax19kL5KdobB6uPmo255HyPg8w4WwJCZDb39Demq9Yg
         VMGOiLwXAUmZsmGSBbTuSSxEDUYk+W4uBdUHMfGh6Ql4W7SISA+WejE4Nybqyov7TGmu
         gJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5udPweozc5hAOR31glSVe1C43qFntkSJ+4BgeO8yy1M=;
        b=EsPRE9/Fs/Se0ROTAM0jkaB9flthDG0vI7jUlS1rXy+BNsWXmS23haFZS9UODgVxvL
         opd09AsFa8ZVdwpI7alG9X0OPU8o24zHrg34c3PRvGxCOyVQbffK8AQ/XWmeCJSQQgPQ
         uhudtlmtUb8a215Grsmn3fQkwgigeKZWK0+qfhtuUehU9Ct57tUx3p5WDs4bzi1wK57w
         DvAfSJOBfO+PG5zmTcbMHirlZlZpUpKsKnhTMXUGabUgRKmu6JSuSF1KwkCgZ+IuU1uM
         Hpfof1d9XYJvnsxSrOVvvf0XIZUuh4HkuSbx7bqbHS2017dF1UQMjdAjvLWxenPMm9Zk
         Yasw==
X-Gm-Message-State: ACgBeo0JzqsFyMiQU3wZJnOR+dKggXqts30JPyeaHKFYFYbvN/Coj6IR
        aH+/c5UcokOHkglQ3mZr5f0ZxPvJG9VXuRaFJZq3F78P
X-Google-Smtp-Source: AA6agR6TF42QdpuzWitPclcaIoWy7x/ArCuzsV9P0UCi2xW0lW16RzbLOHtJmYBqcT5xLRxg1qp46zbYM77zkYeROAo=
X-Received: by 2002:a05:6870:5488:b0:127:7a3d:bf27 with SMTP id
 f8-20020a056870548800b001277a3dbf27mr18059oan.101.1662495954227; Tue, 06 Sep
 2022 13:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOCSQxRJ_sPmL8d6FSYyEt0FytCLatxvrOYKCRV68gDVhzQNbA@mail.gmail.com>
In-Reply-To: <CAOCSQxRJ_sPmL8d6FSYyEt0FytCLatxvrOYKCRV68gDVhzQNbA@mail.gmail.com>
From:   =?UTF-8?B?RMOhdmlkIELDrXLDsw==?= <dbiro97@gmail.com>
Date:   Tue, 6 Sep 2022 22:25:43 +0200
Message-ID: <CAOCSQxSj_Bmn_9n+Vca_Q3L8hd4WUG6Lp7gneEFWKzHbJ27psQ@mail.gmail.com>
Subject: Fwd: Bug report (symlink, git stash)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi devs,

I found a bug (easy to reproduce):

What did you do before the bug happened? (Steps to reproduce your issue)
```bash
mkdir back
mkdir shared
touch shared/foo
ln -s shared/ back/shared
git init
git add .
git commit -m 'Initial commit'
unlink back/shared
mv shared/ back/shared
git stash
git stash apply
```

What did you expect to happen? (Expected behavior)
I expected to get back the same file structure as before git stash

What happened instead? (Actual behavior)
The shared folder was removed

What's different between what you expected and what actually happened?
I expected the back/shared folder to be a folder, but instead it was a
symlink which was marked for removal.

Anything else you want to add:
Nope.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.37.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.19.2-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 17 Aug 2022
13:48:51 +0000 x86_64
compiler info: gnuc: 12.1
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /usr/bin/fish


[Enabled Hooks]

Thanks,
David Biro
