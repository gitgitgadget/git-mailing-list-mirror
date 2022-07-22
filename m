Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECF6C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 10:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiGVKtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 06:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbiGVKtT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 06:49:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B6BB8C4
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 03:49:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r186so4140463pgr.2
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 03:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SUxB0IftdniIh/MiHuUabU9szr05bHmX6LcWehIY5rA=;
        b=D5swnkp0fu00eePHKzyXrllSn/xK8n19oqC4n2JHx4UaIPpJnnjnRTLp6goO6GM5nj
         7/qFvBN+5vl5diUld+KdwItpNZ2HNggv/kN4qHQzGB0yAUzgiPj2SVSEjzM34WhhBGrc
         Ciepp21Vby9tUQnuMFW+WV2Cx2wh8EOD5XinlHbubZkKTNKVdXN+OrP/NdkYzvi6mMl4
         gZg3Pw/sb502z9ljyu0KJcRHMaF2um34VcsXUKvorWkUWqKy8jQMhbWJsET8+aRFax1O
         fpsz360VHkZOS2/Nkp7Tiu1lvFsrouDlRmq9R0f+lhDjQyi/darMAPbC0rvkPQOdkuwe
         a2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SUxB0IftdniIh/MiHuUabU9szr05bHmX6LcWehIY5rA=;
        b=ey0KFoTXCeLgN1FsSIzYnezhbY8NNLBuv+2IZ/elFmrccf+yLsXeWBn8gF5qiUWE+P
         GZS9uaYDuHolTTZmjO+8e0MwMtxxbQzR2kzCaR57I60sDUYWHA+oJNms9D4mdZP9Q9Yy
         aEfEzo3OSP9WrUNbDde5XyPoAYUM4efjNFjoUCM5nydtXG9XrF9YBKz9DTZbAGFCj9M6
         lfy1VNU7J4X2D3l5tSaCf9L8eA87CwBLtcsfzg0JASWEwBWWMzbCOkFRPU5gHqpw3P1h
         G81yHIf8uOSBUXwpP3qoupwvZSZNiPvODMW1lHAW5b2qEXuAV4e8AkZ3j9rxbPTzv+mt
         LYkA==
X-Gm-Message-State: AJIora9WPzr3vnHh1zZKHYqIMWRvD983E08G64A8/p2odKa+bep/AuG4
        EcqtShxC4zM2FAoDm39cHIsmOKln9eiFE3w36GcdMQFCk1E=
X-Google-Smtp-Source: AGRyM1uYrc5vUhD+gu0xe4b/5DNfWXvegUayFoosCJhqNK6rqp3Q4uuPgybAxaZ2ztZkBpCkwuHQfLU6lCOYxY291Oo=
X-Received: by 2002:a63:3f43:0:b0:41a:5e8f:b084 with SMTP id
 m64-20020a633f43000000b0041a5e8fb084mr2695464pga.145.1658486952756; Fri, 22
 Jul 2022 03:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <99c80fc2-0f94-a607-ca71-c45961c07e2b@web.de>
In-Reply-To: <99c80fc2-0f94-a607-ca71-c45961c07e2b@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 22 Jul 2022 12:49:01 +0200
Message-ID: <CAN0heSrCocuKA+8UvU8dH_bsM4Xg8L3M8O4W0buXkUc3uCxpGA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Changed_diff3_view_from_2=2E36_=E2=86=92_2=2E67_for_vimdif?=
        =?UTF-8?Q?f?=
To:     Claudio Ebel <claudio.ebel@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Fernando Ramos <greenfoo@u92.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Claudio,

On Fri, 22 Jul 2022 at 10:40, Claudio Ebel <claudio.ebel@web.de> wrote:
>
> when solving a merge conflict using Git and Vim as mergetool, I get a tot=
ally different view than I expected and am used to. In the past, I followed=
 this blog post (https://www.rosipov.com/blog/use-vimdiff-as-git-mergetool/=
), where the result is a view with four windows: LOCAL | BASE | REMOTE and =
then the file below. Now I get four windows as well, but LOCAL at the top a=
nd then LOCAL | LOCAL | file.
>
> First I was not able to figure out if the problem lies within Git or Vim.=
 I removed my global .gitconfig as well as the .vimrc but neither helped. W=
hat finally helped was to disguise the HOME directory for Git via this comm=
and:
>
> $ git merge octodog
> $ HOME=3D  git mergetool
>
> My git version:
>
> $ git --version
> git version 2.37.1
>
> Then I tried older Git versions, 2.37.0 showed the same behavior but Git =
2.36.1 showed the old view.

I'm not a vimdiff expert by any means, but having three windows
containing LOCAL seems like a bug to me... For what it's worth, I can't
reproduce -- everything looks good to me.

There was some work on vimdiff in the v2.37.0 cycle -- I'm cc-ing the
author of those patches. (He also wrote about the work at [1].)

There exists at least one vimdiff bugfix [2] in git.git's current
'master' branch that is not yet in any released version. If you are able
to build Git from source, you could try that version to see if it fixes
your problem. As far as I understand, that patch relates to end-user vim
settings, and you did write that you nuked your .vimrc, so maybe that
patch doesn't quite match your problem, although from the original
report [3], it does seem similar.

Since redirecting HOME works, I wonder if you do have some other config
file after all. Do you have a ~/.config/git/config file? Maybe,
similarly, you have more than just one vimrc?

There's also a patch to handle whitespace in paths [4], but it's not yet
in git.git's master branch (it's only in the 'next' branch so far). From
your description, it doesn't quite sound like the failure mode that
patch author described, though. If you're interested in trying it out,
you could either `git am` the patch in [4], or you could try `git merge
ccc7b5148` into, e.g., current master.

[1] https://u92.eu/blog/git-vimdiff/
[2] https://lore.kernel.org/git/20220708181024.45839-1-greenfoo@u92.eu/
[3] https://lore.kernel.org/git/CACRpdvnuAYY0U1_3uD8zKgtq05+bgwjzXpZKomro6g=
qYDNrjGg@mail.gmail.com/
[4] https://lore.kernel.org/git/pull.1287.v2.git.1657809063728.gitgitgadget=
@gmail.com/

Martin
