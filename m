Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827281F453
	for <e@80x24.org>; Thu, 27 Sep 2018 04:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeI0Kgq (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 06:36:46 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43725 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeI0Kgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 06:36:46 -0400
Received: by mail-vs1-f68.google.com with SMTP id y22-v6so707666vsj.10
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 21:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Gf2GcyiuUMgbVp+NdPI6xrwpN7hTL2yJAnvMcVKwwM=;
        b=CM99BzmEfgiRM5O8inQqbaqacqGU6MCbfzJ0QlgHWCTaNKxmUZJfffLWjdll/ePYyN
         dQw1HaqnN40YIulzGjmk+4AjhWEffoXIl1/lgNrFS/fZERQQeI3pTAKvNVGiWTNFt4q0
         1O1EY/W7Qm51isX6OhpiBB6p+7dF3r8VWKsTPtQH85KszqbM9Hv+ch/8PYrmxMZPbbli
         CuoaD2sZv4NaHwPcmr78UGcQODO1i0GWoOtGQ3OshjfUXCkbGfT5edxhPKfRaoH2oCxu
         lWedgyiUcE8Ra8RN2ugfuleXl2eDusn4uMsWsKSTkBPC8UIJG7Ld/WS3i3zx2khge3uv
         2iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Gf2GcyiuUMgbVp+NdPI6xrwpN7hTL2yJAnvMcVKwwM=;
        b=rSoDBG1S6x/SRJ8IYX8YlfkRjD8GQHNr8Z5X10qtBwcb+YEgoP4bNUXrxW+JVp0dko
         ErJ9SmySU5XF5dXkw30C0CtpjFReljqRv77cNcySw0JlwKS33ac/yhyx4RvviFfwP9Ji
         mLr8CHoeIN1yDxt1c/+J+Taks/+JO6VmvDTpmVDI7WAd9x0USt8Ojwt3ASTCXPr9b7tC
         xmrYYvdyXcBnuGMYERVoUPiM7+ySPTae7TXo5DG8ZFmp3wVayBRQhnD6GhAekaiqyPRT
         Bng70cGYTtAmOn9gC+3RhKuYEaMiwZg+wm1ZZoBrgftiiISrOZIj3c97gCtZY6BobLsb
         1INQ==
X-Gm-Message-State: ABuFfohCau8E/ZDWitUU9ww+/r9oz9iOtwGXxDQO+2swuYJ+ENAfAYds
        95vxz9Wpr5tIW+UvnGI+dN1nCQIbGBvwbVcD6ng=
X-Google-Smtp-Source: ACcGV60KO5xCP+H+5MmRnwwaMlvJwbLahpuyRetPyOdxILRUMgPk3lHqTHvLuYFsttTP+Pkg1ssOF1vsBtY+87YRhF4=
X-Received: by 2002:a67:7f13:: with SMTP id a19-v6mr2875806vsd.175.1538022033234;
 Wed, 26 Sep 2018 21:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <3c11c193-a978-69be-4b8e-4b59b270338e@gmail.com>
 <877ej8j7uf.fsf@evledraar.gmail.com> <d2a8619b-5110-0a03-5559-fd84cb7509b6@gmail.com>
 <875zysj6fq.fsf@evledraar.gmail.com>
In-Reply-To: <875zysj6fq.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 Sep 2018 21:20:22 -0700
Message-ID: <CABPp-BEMTn2LEq8pB7Yenudnp0rSRfXCzeej4p3SE0BGovosmA@mail.gmail.com>
Subject: Re: Triggering "BUG: wt-status.c:476: multiple renames on the same
 target? how?"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Cc:     andreastacchiotti@gmail.com,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018, 2:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
> On Wed, Sep 26 2018, Andrea Stacchiotti wrote:
>
> > I'm very sorry, I indeed forgot the `diff.renames=3Dcopies`.
> >
> > The following script can reproduce the bug even with a blank config:

Thanks for the bug report and the simple testcase.

> > ---------------------
> >
> > # Make a test repo
> > git init testrepo
> > cd testrepo
> > git config user.name A
> > git config user.email B
> > git config diff.renames copies
> >
> > # Add a file called orig
> > echo 'a' > orig
> > git add orig
> > git commit -m'orig'
> >
> > # Copy orig in new and modify orig
> > cp orig new
> > echo 'b' > orig
> >
> > # add -N and then commit trigger the bug
> > git add -N new
> > git commit
> >
> > # Cleanup
> > cd ..
> > rm -rf testrepo
>
> Thanks. Bisecting shows that the bug is in dc6b1d92ca ("wt-status: use
> settings from git_diff_ui_config", 2018-05-04) first released with
> 2.18.0.

The bisect is slightly misleading; the bug was introduced in 2.17.0
for renames, and when copy detection became a thing in 2.18.0 it also
incidentally would trigger with copies.  I'll post a patch soon.
