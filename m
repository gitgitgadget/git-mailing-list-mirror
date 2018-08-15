Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79AD51F428
	for <e@80x24.org>; Wed, 15 Aug 2018 16:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbeHOTvJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:51:09 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45315 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbeHOTvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:51:09 -0400
Received: by mail-yw1-f66.google.com with SMTP id 139-v6so1295551ywg.12
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vGJy5CfmPsjokqqJudJIGL4NUxd8rWDgIq8d293JXr8=;
        b=WznRwjkIb8x36zQoqvymEkcBnKYUpEIWKw7O8LRWVpdWwg6aI16VKRmP6UVvpuWkRb
         +X8HKkraL5TEudrH1ifHYVpgwLH/mfkNJ9YSdno9FzHIml2FAt43OeSx/D1ijrSgPP0U
         FT3R+U4/BOEVNWGvv2PaQrozvmrvL+JoEa68jjSAPY8+8ogJvBDSzhPwxQt95xqA1xMt
         1qky7FXzKaDg0KA3yj038urIyPBKJojhNdFjV2eTZ+e5BT1h7zFKLPuNPWaLih5LYnx7
         NvsaL76+xh9LM1HR5sYchakjn0PJ6YIylmSt4cxt8dQUp2qKqcfvjMJ3TXVRqNq2JLiw
         5KfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vGJy5CfmPsjokqqJudJIGL4NUxd8rWDgIq8d293JXr8=;
        b=UEFFXI7IjWd8J3NIW9vuyYhHWvvtEU/ouvOSoVNYtDwzHS9SRgF9pV7UKhJepnWoov
         DPu174+d0wQDjUBhZ7IjS65m29G82pJZhPdTP8q49WYOw01l+BGiedZuLxjb3MQPuMJb
         usmg1RDIr6NpP5KJr9YAfr47ygXe+6v2EsaW5sfhaVMmCjfTBtuk3mE3NSSLtaN+/jpp
         0+XpNDGD41awQsQCPb06YpZmo9rM1DVIN3Mf/TgQqCiZVG0SHYm00jdtNY8PMde5jFrb
         mZVI6WciU3ezubDpHQOl70Xsijxx3+ZtQrCATQVFlzoGXTC/xO+Y8GMQtebHSXAkdxAp
         LQEA==
X-Gm-Message-State: AOUpUlHzS/HGOGiJa9D8GnDcDLNH/LRgrp9UoFgVUZ8dYu0xj2WatxQU
        YfJ717YBhwHGLU5sRfJWVPHR69v7RN2m/fuASSRluA==
X-Google-Smtp-Source: AA+uWPybGpzRnZncykoxrjBMtGlY+xwRdLOAKxQU8B09ERQlPtMSpUbAlDMo7Vskj0WVYIM5CrWhDvsco9TP69toMwg=
X-Received: by 2002:a25:3624:: with SMTP id d36-v6mr15394969yba.292.1534352292064;
 Wed, 15 Aug 2018 09:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180815162308.17747-1-pclouds@gmail.com> <CABPp-BEC45snMzGeCre-dD1rtqGok-RKuLGbMaV=VJhwx1ceew@mail.gmail.com>
 <CACsJy8B3ip+_sDrpvaZ32a35-6hWkY=eE6g4RObWgbHnf6g8uw@mail.gmail.com>
In-Reply-To: <CACsJy8B3ip+_sDrpvaZ32a35-6hWkY=eE6g4RObWgbHnf6g8uw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Aug 2018 09:58:00 -0700
Message-ID: <CAGZ79kbSa2chcUj_2=v7iE59R6_0m==ecYkB86+-4Fd_Zgd5_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] branch.c: remove explicit reference to the_repository
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 9:53 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Aug 15, 2018 at 6:48 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Wed, Aug 15, 2018 at 9:24 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> >
> > The patch looks good, but since this touches multiple .c files, I
> > think I'd s/branch.c/branch/ in the subject line.
>
> It is about removing the_repository from branch.c though. As much as I
> want to completely erase the_repository, that would take a lot more
> work.

What is your envisioned end state?

1) IMHO we'd first want to put the_repository in place where needed,
2) then start replacing s/the_repository/a repository/ in /
3) builtin/ is not critical, but we'd want to do that later
4) eventually (in the very long run), we'd change the signature of
  all commands from cmd_foo(int argc, char argv, char *prefix)
  to cmd_foo(int argc, char argv, struct repository *repo)

you seem to be interested in removing the_repository from branch.c,
but not as much from bultin/ for now, which is roughly step 2 in that plan?
