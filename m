Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B377C433FE
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 16:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiC0QH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 12:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiC0QHz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 12:07:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C412635
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 09:06:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso13217867pjb.5
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGr0Y35lCuqUOrKa4WUwCN9J6CzltEfvjqrg7gFEK+g=;
        b=qgpPYDk6Jz/3TzkhP/b0oTeHZTj/PCL62ZgBHltHHP9bHVu79NThIaker6JwPpDi4p
         6MFsOF/q84WpA4c7IcSovkFqPxY9ArWzb6sLXaTnzgnYaJZHJnyTPvz2DumwobNgxFSh
         Xl8YIz0zTyPCE2EgQBU7A2FNzmSaJqpn9idAb82HH0pyUUkqdXDqHLhTh7gCC8mnutZg
         BcCqg2lLAz2FgvXPtvllWpkx19ChtI2kF0FVMI/9On99BnS0q2ZFIswhN58sCLNVOrF2
         /NYzuiPQ5aB3JiWSrBdqIV3CeyjvdKcdmnlBX5FvLwlh5zyiOLmumfft3mNzkQanmo+c
         71AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGr0Y35lCuqUOrKa4WUwCN9J6CzltEfvjqrg7gFEK+g=;
        b=t97Lvm4nAJxODG6rdz6lrW3G4vxhZdvTn/Qeoz3ork0IQXkFM7fsjiFyN7QwvSot+I
         djyQbva4dhTFwmK+B6H67havyMbUtNryxJAXYv9dZ0dx/gnf/Wr+fZD0TuPUCghEV1IC
         pK1VpmzpDF/VqLKVmktoAfTMflbUF/MKJmj8NQ7VRo341dZMYHYDfB2SrbKmdC1E01Mh
         dDRUKtJaFPHDvBMlvzgwrdyt9Of4w99dI4Ar24x1RSY7qEeplvH27Wi+c4Bb7XYNLIkU
         FkN1g1EkKr48/VB5KJtEwt3NxJkidoNMlawotJgamwQ3aPujOjpg53TlcGSzdvQNpXBh
         crYA==
X-Gm-Message-State: AOAM533ZS0hCCq45bjczfK6HcH9yNHxjbREg1+ihXzrj6vwqlxhFHKbr
        E7LCqmk3ixeiLyC9VDA/GGcO/xs7eqwwi2Qqol/1bYGg
X-Google-Smtp-Source: ABdhPJwR2ri0Ns8+Q4/nP6PrNnBCm2ioMWi90YZatlcS+Ae75CcFZ321jMoQz8rh0cEd6hpGkY1NS1ysIwMJVKReUEI=
X-Received: by 2002:a17:902:8203:b0:153:2e8:aaae with SMTP id
 x3-20020a170902820300b0015302e8aaaemr21990193pln.14.1648397176609; Sun, 27
 Mar 2022 09:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCc5YXmegAV-sSpLLpY19rXhnxYEgM+RzZHJ=saG8nD5HsGKg@mail.gmail.com>
 <xmqqzglc5ih8.fsf@gitster.g>
In-Reply-To: <xmqqzglc5ih8.fsf@gitster.g>
From:   Tone Kastlunger <users.giulietta@gmail.com>
Date:   Sun, 27 Mar 2022 19:06:05 +0300
Message-ID: <CAHCc5YV2Bn5NOfZvdSu6c=nERizmKrPbmGoFWkB=T58BjQ=9UQ@mail.gmail.com>
Subject: Re: Path differences between git status & git status --porcelain
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh Sorry,
the --porcelain=v2 went by unnoticed (not mentioned in the docs).

Thanks for the clarification!
Best,
tk

On Sun, Mar 27, 2022 at 2:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tone Kastlunger <users.giulietta@gmail.com> writes:
>
> > "git status --porcelain"  output from the same location:
> >
> >     ....cutted stuff to keep things clean...
> >        M src/api/db.py   <---- Notice the missing ".." in front of the
> > (modified) file path.
> >
> > Is this intentional/expected behaviour; and if not, we were wondering
> > if this is a known issue?
>
> Yes, this is working as designed and any future versions of Git will
> not change it.  Scripts can forever rely on the fact that it can get
> paths relative to the root of the working tree regardless of where
> in the working tree they start.
>
> You can add this:
>
>     [status]
>         relativepaths=no
>
> to your ~/.gitconfig and "git status" (without --porcelain option)
> will also show paths relative to the root of the working tree
> (i.e. without ugly ../ prefix).
>
> We made --porcelain=v2 to get affected by the status.relativepaths
> configuration, which may probably have been a mistake, but that is
> also too late to fix now.  It defaults to show paths relative to the
> directory the command happened to be run, and in order to get a
> reliable output, the calling script must override status.relativepaths
> configuration variable the end-user may have, e.g.
>
>     git -c status.relativepaths=no status --porcelain=v2
>
>
>
>
>
