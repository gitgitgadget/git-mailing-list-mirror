Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35F3F20248
	for <e@80x24.org>; Fri, 22 Feb 2019 14:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfBVOEN (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 09:04:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37130 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBVOEN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 09:04:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so2059057wmg.2
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 06:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=CCRdVcjE0nUhSWW+4Pw6bzzenkZKehAappVxm8cWdck=;
        b=bQ8+8F7hxQWmeOrFsRytZvawlnAXz9fx1WQyYkedwc2jYXu9fTw0pyjD+jGlRau963
         L+QQK0+dHxWlIN3rDySk9/+xBaHJMHfRlWXgzTViFyA4q7rPtR1vRkmEMEUn8Yh//vvl
         LO0QwS8xrVMq8SfLBZ+YUZtuwIuIzFXGliMMotO/XM/I1ltebHHsFWpjj2+bNS6BtSz9
         Td4u63xPoOybfIkyIHsNuUglVvw16VxaQo+AX0ghuSW9PdVSjlzJ/7Wvgl613ovCiqsq
         JxBaq0Nc0+mvXsp2k/2s09v8u/Cxg5WHkrXL2OI5e44QVXOLCZnC/WOLm+b7xl5tbRdD
         kYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=CCRdVcjE0nUhSWW+4Pw6bzzenkZKehAappVxm8cWdck=;
        b=fzwWcYMA8pYMN3Hqg+/sF42rnulboyiPFAB+zoAK6nFuV8AkhhRBmnqGM4lcYx3/7V
         gSP0qy3ctXpkjrO73qCAOZ/dNy5XsCQj4+o+iPGOPj+lcgrBJaGiaJ5cfz/27pFr4OL4
         TTSscKDskE5WMp14nd/zP3JdOZ8hMevHBQR/kjAMXcxL3tF22KKApD6QVL0I2clfeh0b
         TE+dXGqRZFhEiR5mtV6RB80OVDAbFH9tAhxjgMlaXo5jlLADrngxZ62nnFE6UIR7Xet/
         4OTLAQVpDprye/obWnXXNDXvhft4VbweTIPr3EqIkQMXUISmcAjEWKQdl/hG5iJUUUCq
         HktQ==
X-Gm-Message-State: AHQUAubhi2r4q5FrTwSmOuvgovyvGuNXLD2OA1I0uSKiSX5e3bPyo2dj
        UaNWqXPJ2p5BmsGPOvaNBAqkpHcxQEI=
X-Google-Smtp-Source: AHgI3IaM06fKWdRto+Iig45RRACEU9gDZ35UV3xIp+EWrtuHHMH/0iMZcua8XOV2zDp9xY4VmODiNQ==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr2624618wmc.109.1550844251294;
        Fri, 22 Feb 2019 06:04:11 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id n14sm2682068wrx.24.2019.02.22.06.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:04:10 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how does one interpret "git diff <commit> ^<commit>"
References: <alpine.LFD.2.21.1902220816010.6353@localhost.localdomain>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <alpine.LFD.2.21.1902220816010.6353@localhost.localdomain>
Date:   Fri, 22 Feb 2019 15:04:08 +0100
Message-ID: <874l8v6ht3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 22 2019, Robert P. J. Day wrote:

>   was perusing the git FAQ and ran across this:
>
>   How do I obtain a list of files which have changed in a given commit?
>
>      $ git diff --name-only <commit>^!
>
>
> after playing with "git rev-parse", i figured out that the above was
> equivalent to (using kernel "v4.19" tag as an example):
>
> $ git diff v4.19 ^v4.19^
> diff --git a/Makefile b/Makefile
> index bf3786e4ffec..69fa5c0310d8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2,8 +2,8 @@
>  VERSION = 4
>  PATCHLEVEL = 19
>  SUBLEVEL = 0
> -EXTRAVERSION = -rc8
> -NAME = Merciless Moray
> +EXTRAVERSION =
> +NAME = "People's Front"
>
>  # *DOCUMENTATION*
>  # To see a list of typical targets execute "make help"
> $
>
>   but i get exactly the same output if i reverse the arguments:
>
> $ git diff ^v4.19^ v4.19
> diff --git a/Makefile b/Makefile
> index bf3786e4ffec..69fa5c0310d8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2,8 +2,8 @@
>  VERSION = 4
>  PATCHLEVEL = 19
>  SUBLEVEL = 0
> -EXTRAVERSION = -rc8
> -NAME = Merciless Moray
> +EXTRAVERSION =
> +NAME = "People's Front"
>
>  # *DOCUMENTATION*
>  # To see a list of typical targets execute "make help"
>
>   so i'm confused as to how to "git diff" interprets and processes
> those two arguments, as "v4.19" is, of course, a reference to a
> specific commit, but "^v4.19^" appears to define all those commits not
> reachable from "v4.19^". how should one read this?

I'm not sure if it answers your question, but search for "Jon Loeliger"
in "man git-rev-parse". It shows an example of a graph and what the ^REV
syntax means.

^v4.19^ looks cutsey, but just means:

    first_parent_of_v4.19_is_X = v4.19^
    not_reachable_from_X = ^$first_parent_of_v4.19_is_X
