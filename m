Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76DF81F453
	for <e@80x24.org>; Sat, 29 Sep 2018 06:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeI2NDy (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 09:03:54 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54908 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbeI2NDy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 09:03:54 -0400
Received: by mail-it1-f196.google.com with SMTP id f14-v6so5269404ita.4
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 23:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zg4It3cs6wrU/op/15dBxSQ4Jbh30VquVL3UjfOnIqw=;
        b=PwS9bcLNpbCMR/U5TJk19AcTKrN6hCouDRoO985ml52jCS3MvA/C17eXORp24vCK4q
         djqYWM1lW9DO+F4M/iMIs0gd9CSTkgdAIAH6SwHno1sDhiCbqZS0Z67GdOHNIde5Jp3U
         kw1BKZtswzojU/44E7vTK3ub2lzlUsqCYzawhdCbxBv8djVoAQFXLn/9rZ7S3L0hBqWZ
         pe1clc/GCoZLe3R1CngdSIGNnGF52yR8h3Cc6c4pAFxW6X54xwdNZVrJ3/1oPhgaI9Ai
         7vnPsyJSvV5OvkohVBJDZJaQGGlSu0TUd9vMNlfPlE2n6mQLf9MI/x9pfVMZnmxcEesf
         RYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zg4It3cs6wrU/op/15dBxSQ4Jbh30VquVL3UjfOnIqw=;
        b=VJvyKtSqEXyG+kR2ELNVnrdwDM6qtWR1yaLog2lryUvsAILXCsRwdB7e+KH/tjwlHT
         GsnxTGdQ14XF/N7qVd4P3tjrmkJJtbamWYPhRLWo69hyo/NQGdS4tuOMFVcbcQj/LD/h
         i5f6OrorM0JLZgwE/m2J2+eledUsG2eaUclsuNZkZ95v+/cXQf0IUK9LQRW1x5zkpU1H
         TelxFUALl/ynD/bqBNp9bzNaSdobjIW3F7DRWgN+ZK75jhui8whMwWwNJxF7S9YSUWXb
         ouDaEJOQcJ13j2khXa1nGcHkFtrPHx/xll8pV2R0oya7wMNhDQyho1H9FVq/tDj9Wg9q
         xkBQ==
X-Gm-Message-State: ABuFfoh9UbxgO5/SHpr5N7IFbR4gb8kkDrUB5lJebvKkGbBTtuUagDq5
        n6ycB4IyyGqeQoAlIkkXzm8QOPNTmrWdLSHr4phfSlEr
X-Google-Smtp-Source: ACcGV61b6EofU9W45OxzXEjCKgerN22i+Ir00WZ3H0FhFDp1QKHhVB+JQlTZuZQRQ9rOjSfYNVnjCc/2d8AgzzF0YVE=
X-Received: by 2002:a24:aa41:: with SMTP id y1-v6mr4117560iti.91.1538203000763;
 Fri, 28 Sep 2018 23:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com> <87bm8kjeu5.fsf@evledraar.gmail.com>
 <CACsJy8Dwo_cBEQeqttj3G=RGaJT7bmVb=ABnV2916swgYQnyrw@mail.gmail.com> <87r2heiybu.fsf@evledraar.gmail.com>
In-Reply-To: <87r2heiybu.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 29 Sep 2018 08:36:14 +0200
Message-ID: <CACsJy8DKG3dh-TxzdJPUJxZRMuV8+UpYoSTp7hyk8koZ0+Raeg@mail.gmail.com>
Subject: Re: [PATCH] worktree: add per-worktree config files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 8:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I see I'm misremembering most of the details here. I thought that if I pu=
t:
>
>     [remote "whatever]
>     url =3D ...
>
> Into my ~/.gitconfig that it wouldn't work, but it does, e.g. here in my
> ~/g/git:
>
>     $ grep -A1 whatever .git/config
>     $
>     $ grep -A1 whatever ~/.gitconfig
>     [remote "whatever"]
>         url =3D git@github.com:test/git.git
>
> But there's still some special casing for .git/config going on,
> e.g. here:
>
>     $ git config remote.origin.url
>     git@github.com:git/git.git
>     $ git config remote.whatever.url
>     git@github.com:test/git.git
>     $ git remote get-url origin
>     git@github.com:git/git.git
>     $ git remote get-url whatever
>     fatal: No such remote 'whatever'
>
> And:
>
>     $ git remote set-url whatever git@github.com:test2/git.git
>     fatal: No such remote 'whatever'
>
> So there is some special casing of .git/config somewhere. I looked into
> this ages ago, and don't remember where that's done.

To conclude this thread. Yes some code does know about where the
config variable is from and it looks like only "git remote" and "git
upload-pack" takes advantage of it [1] [2].

I considered documentation improvement for the git-remote part, but I
don't see anywhere I can fit "some remote attributes can be shared
from ~/.gitconfig, but a remote can only be added from repo-level
config" in. Jeff already documented it well. I found one minor problem
there in the documentation, which I will send separately.

Thanks again for making me aware of this.

[1] e459b073fb (remote rename: more carefully determine whether a
remote is configured - 2017-01-19)
[2] 20b20a22f8 (upload-pack: provide a hook for running pack-objects -
2016-05-18)
--=20
Duy
