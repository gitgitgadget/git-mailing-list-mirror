Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070431F42D
	for <e@80x24.org>; Thu, 24 May 2018 22:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935877AbeEXWnA (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 18:43:00 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:38880 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935803AbeEXWm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 18:42:59 -0400
Received: by mail-yb0-f174.google.com with SMTP id w14-v6so1193333ybm.5
        for <git@vger.kernel.org>; Thu, 24 May 2018 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KanI/cz/X60/sL6/74p+VPQq1/MaasGLubkAwTYo9qk=;
        b=CjDU7l/euW2boPrjHojv3+9NLf+R3bY+XXC8Wd7w4Aot8QZGrljxyCvNNuRwfa/SIw
         oBP+KweJcrzEt1CTt6vThPjgHu55kGjihFF6TflIiTTtFz6bWjz+OTj9EV5t3/TckkZo
         aU7Yv5b3GXETl5wfdpXPmhFl+BTDyIQW5gTqsByAhs+Z1as4gyXn/C+401zLBT0JJ/ov
         mrWKutZPQ8TU9QkqEZr/GbMTsNzgvXR+wQCgc7vziFCV+gKGH3GFLU3/HHuL0eH4i1e+
         u5O1920H46l4VqyEDW69FuenDotDd6e78zY2AmU0i//xgLOD4XI9MsoqLgJbI5afRHY4
         LA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KanI/cz/X60/sL6/74p+VPQq1/MaasGLubkAwTYo9qk=;
        b=FItdJzuNuwDvwaQOL9ln2zp9XO3BUBFiXFpBngDJ+dMwYwn0IYqzx4UVuSjYFr1fZI
         8gC2r4MZF4ROAN+XUIadRaPXtbsaaBLWJJnd/77G2NEoPow9FbZbK4awo4Zgy+EygdHZ
         pkt0BEQzgOd4CGSMW5ov5zfHOhs1ZRg1JXuFdUX6KtVqaeNuDovex1OlnemirilhPxUn
         zAagfFtxM+iPSBGzqw6PFgNf90FwKX4E43PWdUj39O9m6u5VzL7SEjsQTwIBfU+o9CmX
         HYKfTjHnwtvigZVU7HxNmnSzBvJwjFOgDjxxTiCMyhZaMzXsONbBlVeDG9I85ulKW3AJ
         +EWA==
X-Gm-Message-State: ALKqPwc73aRQbjZgcdKs3LKEaktGlnr/pnD/lmK+4WdgH4dxRRLZ83Qa
        XaXtgxk/xHhIqECFJxREBx1OGdD35Ic3++BlAldurBOhcgs=
X-Google-Smtp-Source: AB8JxZrlODoewUhzr5TUoA/YHY7/UaLy9Wa8JkJC4ZJwmNHC+rsN8BQ+uNrEumr6Q+zhdtDdPriId9VII/phJjbuF8A=
X-Received: by 2002:a25:a526:: with SMTP id h35-v6mr5211168ybi.515.1527201778627;
 Thu, 24 May 2018 15:42:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 24 May 2018 15:42:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805240934010.12018@localhost.localdomain>
References: <alpine.LFD.2.21.1805240934010.12018@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 24 May 2018 15:42:58 -0700
Message-ID: <CAGZ79kY8CjLsTqY2YXJ8hPA41XrbYZrtK7yO59vrbA5M_vorVg@mail.gmail.com>
Subject: Re: why do "git log -h" and "git show -h" print the same thing?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 6:37 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   maybe this is deliberate, but it's confusing that, with git 2.17.0,
> the output of both "git log -h" and "git show -h" is exactly the same:
>
> $ git log -h
> usage: git log [<options>] [<revision-range>] [[--] <path>...]
>    or: git show [<options>] <object>...
>
>     -q, --quiet           suppress diff output
>     --source              show source
>     --use-mailmap         Use mail map file
>     --decorate-refs <pattern>
>                           only decorate refs that match <pattern>
>     --decorate-refs-exclude <pattern>
>                           do not decorate refs that match <pattern>
>     --decorate[=...]      decorate options
>     -L <n,m:file>         Process line range n,m in file, counting from 1
> $
>
> is that what's *supposed* to happen?

I would think so, show is just "log -p" with the range clamped
down to <object>^..<object>.

It's been in the code like that for a couple years by now,
e.g. see
e66dc0cc4b1a6 log.c: fix translation markings, 2015-01-06
