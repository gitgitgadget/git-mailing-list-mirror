Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D75F1F404
	for <e@80x24.org>; Thu, 12 Apr 2018 02:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeDLCT0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 22:19:26 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:52240 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeDLCTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 22:19:25 -0400
Received: by mail-wm0-f51.google.com with SMTP id g8so8065294wmd.2
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 19:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=N1a4kG4bJOGRWSEZxfJdASHWhORSjo2Plg96O7yCUMg=;
        b=bCMtqMpMaVoepTOf2+g9QxMrQ3mdRKgBEgn3VuFwOfVQiIg9FFN0L7A9vKvaChoRs2
         f4dZ6VCDnSFeHlTvVmoc4ogJ6vUiG8foLu0Bxwn5QYUyX5BWpp5nCnNz0693RvA7OFak
         bapCzdp+cDFaqHn6pQQ+/N0764YdNJzEKLBnPXLNaxwBGhckPrzLqZmXVddYlWIUhc8I
         WdXIDTFr+Tf8PDWEwTBPipVZl/3tK9BM0x2zdO5EyEAewgGKm4vwjyizLYx7SbyZkFaK
         NA6QxMS/9CaBe8ncmRXEAQWLn2fU02CsSuf4B1oJ4W2MFy+cZHhYVh/jLN+3S/0/2wwG
         Ro+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=N1a4kG4bJOGRWSEZxfJdASHWhORSjo2Plg96O7yCUMg=;
        b=tsnQi3ROYwDp/SVagq+AOxixgY7NsWB/PqE3rbrpQnVMvGQmxdLysmPvrGhchpFHgy
         CE01PlMlDRncUW5E3terdDmBj+ApTE/3R9TsdeiKDUO/9ORjxBypuiQ/FgU+m9RkJ4Go
         zDwlm+H7hZ1zVb+WUdWkD3Gogu/6hDG4NN1IXan8kZ/IHj+aefSSoMQ4GBVU3TlhdKTo
         ik6b5BysX7En9+rNrN80BCHYEQp1biisXwiKuCUoC0T40P9h9qq1gjpFB7RhC1nVlcqR
         rCwUL6Gf9SUw5LPNvg3U+2s1ZyYVGr+LBX6mrmfWB/1e8K2QOOKqcXHiQ3qnl98jgH4r
         KiUg==
X-Gm-Message-State: ALQs6tDS/CggTgqDFydJN2Ypa70b/ZeKhPnK9dLsLfzPgFHs4iQSTVJX
        VxbwNKN3Zh12w4V9NoNlQ9aZkU5T
X-Google-Smtp-Source: AIpwx4/MaKvn73ehZKwi9EdzNcK27g9e5/shfS9xibT/zIBxFcn2c7M2wbhg5Lh0C9FY8atNKF/TiQ==
X-Received: by 10.28.139.18 with SMTP id n18mr3875217wmd.26.1523499563708;
        Wed, 11 Apr 2018 19:19:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q7sm2249475wrf.92.2018.04.11.19.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 19:19:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
        Kyle Meyer <kyle@kyleam.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ami Fischman <fischman@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] git{,-blame}.el: remove old bitrotting Emacs code
References: <20180327165751.GA4343@aiede.svl.corp.google.com>
        <20180411204206.28498-1-avarab@gmail.com>
Date:   Thu, 12 Apr 2018 11:19:21 +0900
In-Reply-To: <20180411204206.28498-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 11 Apr 2018 20:42:05 +0000")
Message-ID: <xmqqk1td2ml2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> However, since downstream packagers such as Debian are packaging this
> as git-el it's less disruptive to still carry these files as Elisp
> code that'll error out with a message suggesting alternatives, rather
> than drop the files entirely[2].
>
> Then rather than receive a cryptic load error when they upgrade
> existing users will get an error directing them to the README file, or
> to just stop requiring these modes. I think it makes sense to link to
> GitHub's hosting of contrib/emacs/README (which'll be updated by the
> time users see this) so they don't have to hunt down the packaged
> README on their local system.
> ...
>
>  contrib/emacs/.gitignore   |    1 -
>  contrib/emacs/Makefile     |   21 -
>  contrib/emacs/README       |   32 +-
>  contrib/emacs/git-blame.el |  489 +----------
>  contrib/emacs/git.el       | 1710 +-----------------------------------
>  5 files changed, 25 insertions(+), 2228 deletions(-)
>  delete mode 100644 contrib/emacs/.gitignore
>  delete mode 100644 contrib/emacs/Makefile

I know I am to blame for prodding you to reopen this topic, but I am
wondering if removal of Makefile is sensible.  Is the assumption
that the distro packagers won't be using this Makefile at all and
have their own (e.g. debian/rules for Debian) build procedure, hence
*.el files are all they need to have?

The reason why I am wondering is because I do not know what distro
folks would do when they find that their build procedure does not
work---I suspect the would punt, and end users of the distro would
find that git-el package is no longer with them.  These end users
are whom this discussion is trying to help, but then to these
packagers, the reason why their build procedure no longer works does
not really matter, whether git.el is not shipped, or Makefile that
their debian/rules-equivalent depends on is not there, for them to
decide dropping the git-el package.

On the other hand, the 6-lines of e-lisp you wrote for git.el
replacement is something the packagers could have written for their
users, so (1) if we really want to go extra mile without trusting
that distro packagers are less competent than us in helping their
users, we'd be better off to leave Makefile in, or (2) if we trust
packagers and leave possible end-user confusion as their problem
(not ours), then we can just remove as your previous round did.

And from that point of view, I find this round slightly odd.

