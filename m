Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549DE1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 06:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfBSGpe (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 01:45:34 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:42313 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfBSGpe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 01:45:34 -0500
Received: by mail-ed1-f46.google.com with SMTP id j89so6367083edb.9
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 22:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gsZGkGKy4Oa+gOd7H2HljEdoO5hWwBOVfxFX5Z9I5NY=;
        b=hjdF9SEE2JKxLgEfv6u4hFZd0Ll58vab+8ZKAGroWxW3j4CQ2xQEZi30GWTzPQVQhk
         vaCYAUAwOLh7xv2edCEMYJTpZO0anB4UAYBzVwzepfA+rOSST69cAq4pQ3w6nKFoqXim
         KR4GfStM3eQkxzFEME+in9ahrFB22dqW6W5DkBdH0noegtRRQ02c6GJWIodQifTgWcpj
         XXSWcML32VCnVR12ts3IM9tMeTfpd0WWiaBuNJlGCl6sXW35sZdSJFmHaf8OxIJsE9hp
         r8wAzzgy1gpCvwkIOfvHgSSAM6C/s19k5Phg/n89Z9qLpgdndlMRxJcnZgcBr6Iw1VDs
         xiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gsZGkGKy4Oa+gOd7H2HljEdoO5hWwBOVfxFX5Z9I5NY=;
        b=INChRdZv3CkrufVItd+yuvZnADCQwF4ZMd5h+uyb1X29dJQWoSHGJ0OZb5PWTXC2pz
         dGW3o2Ez1IyOaqflEpnO83JA8CsDoIqBPkV18J5LrB24oVWFCvtAFwTwVTyWvUt4XXc4
         cju9Ux5K2fiTP+Z/I3q4UkJd+V1sFB9Oqx+aU76Dbn4ywR+y4w1CTfXAaH5QHHlv4ny9
         lAsHLV0m0E++Bu4CjKbjDAi2fI+0ob7vUOQ1VhtFNNENZGjsese3G7vSt0yJMfW8qDuG
         bZKMjxQpTKTKjGoTlWVLjpsZ5PNd6PnDOHrTL6JaeAYwE11fjcFjxWFh0E53/RHzJnBB
         +ouA==
X-Gm-Message-State: AHQUAuYKOKjPt6LeVAMWAt8v0vpFuXfYuYpeEUO+vEYeQv7gLd/3Kcg9
        e59Hm0hIKJT13AeQc69Exr/+hFF0v49kufzKndhZLvFS6Uk=
X-Google-Smtp-Source: AHgI3IZSsAKLJzVLZA4Kvjo6+Dwd/lsOjpWM/7XMj8fV4SxmhA4sCCEtyCV569xly/Qo/WwDqGeaox6M118mFJmMGCs=
X-Received: by 2002:a50:d98a:: with SMTP id w10mr22677215edj.81.1550558732599;
 Mon, 18 Feb 2019 22:45:32 -0800 (PST)
MIME-Version: 1.0
References: <CAJPSwc1GuifK9BdssWQsf+oVY0Aw+PLM1pgAiis7UdV1tZrpew@mail.gmail.com>
In-Reply-To: <CAJPSwc1GuifK9BdssWQsf+oVY0Aw+PLM1pgAiis7UdV1tZrpew@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 19 Feb 2019 07:45:21 +0100
Message-ID: <CAP8UFD22QMJyiJmQO1YVFmBkZuzex58+QBbTbdCCVHa8OGCQJA@mail.gmail.com>
Subject: Re: git rebase --continue after solving conflicts doesn't work anymore
To:     =?UTF-8?Q?Sebasti=C3=A1n_Mancilla?= <smancill.m@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 5:20 AM Sebasti=C3=A1n Mancilla <smancill.m@gmail.c=
om> wrote:
>
> I've always used "git rebase --continue" as the help shows:
>
>     Resolve all conflicts manually, mark them as resolved with
>     "git add/rm <conflicted_files>", then run "git rebase --continue".
>
> and Git would apply the conflicted commit without issues and the rebase w=
ould
> continue.
>
> But since Git 2.20.x it doesn't work anymore. Now after solving the confl=
icts
> and running "git rebase --continue" I get this error most of the time:
>
>     error: unable to dequote value of 'GIT_AUTHOR_DATE'

It looks like this can happen only when an "author-script" file (most
likely .git/rebase-merge/author-script) is read by the sequencer
mechanism. Could you show us the content of this file on your machine?
It could also help if you could give us information about your OS and
locale.

>     error: you have staged changes in your working tree
>     If these changes are meant to be squashed into the previous commit, r=
un:
>
>       git commit --amend
>
>     If they are meant to go into a new commit, run:
>
>       git commit
>
>     In both cases, once you're done, continue with:
>
>       git rebase --continue
>
>     error: could not commit staged changes.
>
> Now I have to run "git commit" first to commit manually and then do the "=
git
> rebase --continue".
>
> I've compiled 2.18.2 and 2.19.2 to check and the error doesn't happen.
>
> It is present in 2.20.x and current master v2.21.0-rc1-9-gca1b411648.
>
>
> Is it a regression because of the new rebase written in C?

That's possible.

Thanks for the report,
Christian.
