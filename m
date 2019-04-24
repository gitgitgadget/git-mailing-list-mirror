Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C911B1F462
	for <e@80x24.org>; Wed, 24 Apr 2019 18:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbfDXS3V (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 14:29:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35828 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbfDXS3V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 14:29:21 -0400
Received: by mail-io1-f68.google.com with SMTP id r18so15879232ioh.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iyYl6VnIgZ+kKB2UbVYuk39g4mMs0S58hhqdJabDBgQ=;
        b=O9UMPQeRMGtuE4zXP+5NSTEM2kErOcMafsHD/au4DBbSaQ204xKr+J8dRlEnRB6TzK
         faH3SHwS99PPyk0b4bRJR1XBCWTwhMaTHMmeVRh5tGHf33fscsq1TARjdZFjLr9nhtzK
         mh6xnFN9pDFHJwcuPssi7DayonwcvZwU2xL0aTY108ManZERckaq49LT8kaA7YM2D3JU
         ffWQKOrKO7Jia7RIZjVM/ab9NArd3H8yOEi+M+E3dtS/QYPOtlduO7cyXjGhJ+A4EcS8
         wwl+oPcAq+KuVYhf6bssV3mTKfGhZ2LRvvqJWYlsULi7IYQ2LfYbpOSLpyO2pdNMsL6y
         UjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iyYl6VnIgZ+kKB2UbVYuk39g4mMs0S58hhqdJabDBgQ=;
        b=TUbw7oH2S5NVj5KqGq65N38UzbDUi+iVzoCqXP+qrADYuRJu2wmJr/CQV1aqte92XL
         1pdT9yT4K/3AMKIqy1N2oiAYrByz5PACGeCG8MIFBFozJh6/A6Rhh3SjZPUT5FS4rrha
         FW4HHVCHBb3+zNHcmSLhso6UNL4JX0BkhZ9YHAMPxylHICQ+9M37+we5QqkyTOa6GUlW
         6j49/KiLbgVMD4ftrpt/HAowfLYZiGCwXnsnQb6mZFUmmfms6dtQ5/MuuiO0f/2Hp/zP
         f1hPb6eNLvoFVlRVr98ziOM8GEYNBk3JZVkSo3mnio0FAskTKhfNyztLMrU0q6W657oF
         LOrg==
X-Gm-Message-State: APjAAAVoYOG62kXj2fA85s08w5JtYZZdXPgd08M8lV26la73FtKI0WHI
        oKFat5U4H4UrC+v9jr6NYOOqggifqhn1u2CrOJcSYA==
X-Google-Smtp-Source: APXvYqynmcOAMK87vVMQTHw9GXECc2ZcZL8jJCDRRX/sOBC2H949w2j7fCbg+CAlnE0QTyN2NdmKL7W5VMKLqCFzbwo=
X-Received: by 2002:a6b:9182:: with SMTP id t124mr20689349iod.182.1556130560353;
 Wed, 24 Apr 2019 11:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190424004948.728326-1-sandals@crustytoothpaste.net> <87tvensu1a.fsf@evledraar.gmail.com>
In-Reply-To: <87tvensu1a.fsf@evledraar.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 24 Apr 2019 11:29:09 -0700
Message-ID: <CAGyf7-E2tf7hymOOUSAO6325NyyADWmmMjSRx87-UKVhQd-ufw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Multiple hook support
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 24, 2019 at 1:10 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Apr 24 2019, brian m. carlson wrote:
>
> > Oftentimes, people want to use multiple of the same kind of hook. This
> > may be because software or a project they use requires a given hook, bu=
t
> > they would also like to have a custom hook, or because they're using
> > multiple pieces of software that both require involvement with the same
> > hook.
> >
> > This series introduces support for multiple hooks by using a ".d"
> > directory. For example, instead of using a single
> > ".git/hooks/post-checkout" file, you'd use multiple files within
> > ".git/hooks/post-checkout.d". This is the standard Unix paradigm for
> > multiple files and should be familiar to most people. Hooks are execute=
d
> > in sorted order.
>
> I think it's interesting if people can chime in with current in-the-wild
> implementations of this.
>

Bitbucket Server also uses trampoline scripts for pre-receive and
post-receive that loop over scripts in matching *.d directories and
run them.

* It passes --template to "git init" (new repositories) and "git
clone" (forks) to have Git copy hook structure into place as part of
creating the repository.
* To avoid looping over thousands or tens of thousands of repositories
if those scripts need to change, the scripts put in place (both at the
pre-receive/post-receive level and for *.d/20_bitbucket_callback) are
essentially placeholders that use environment variables exported when
running "git http-backend" and "git receive-pack" to delegate to
helper scripts that actually do the work.
* The helper scripts only exist in one place, so they can easily be
updated if they need to change.
* When looping over *.d scripts, the helper script stops after the
first non-zero return.

On Tue, Apr 23, 2019 at 7:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> One downside is that the transition from the old to the new world
> order becomes a bigger deal.  You could have been using a precursor
> of this series implemented entirely as a shell script
>
>         $ cat >.git/pre-commit <<\EOF
>         #!/bin/sh
>         for x in .git/pre-commit.d/*
>         do
>                 "$x" "$@" || exit 1
>         done
>         exit 0
>         EOF
>         $ chmod +x .git/pre-commit
>
> and with your approach, the user can keep using that set-up and then
> simply remove that single file once all the Git executables the user
> uses are natively aware of the multi-hook setup.  With "either a
> file or directory" approach, the transition would be removing the
> file *and* renaming pre-commit.d directory to pre-commit.
>

This would be true for Bitbucket Server, since its trampoline scripts
are really simple: It could just delete them and let Git loop over the
existing *.d directories itself, so the current approach offers a
really straightforward upgrade path.

Of course, since Bitbucket Server supports a range of Git versions on
the server, and for compatibility reasons the minimum is only raised
in major version releases, it would likely be quite some time before
that could happen; the minimum supported Git version would need this
series to have landed in or before it. That's a big part of why
Bitbucket Server doesn't use core.hooksPath; it's too new. (Bitbucket
Server 6.0 raised the minimum Git version on the server to 2.11.0, so
it's the first major series that could use core.hooksPath; Bitbucket
Server 5.x supported back to Git 2.2.0, which doesn't have it.)

Best regards,
Bryan Turner
