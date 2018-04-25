Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130881FAEA
	for <e@80x24.org>; Wed, 25 Apr 2018 00:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbeDYAGA (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 20:06:00 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44272 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDYAF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 20:05:59 -0400
Received: by mail-wr0-f196.google.com with SMTP id o15-v6so51580402wro.11
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 17:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Dp4MNcDT/EG/xM17zLq22RNCaOllxas9HQ392NgyuAc=;
        b=XFAXjQOdlmZCAS8VIUf1AddZg3UkQiW9qIefxdsbj1Jvi3MfDLWW8xryxB811n3EYx
         xUphyRiWtAf18aCN1VG4KQnSOrkRRcgixPZvb6GZUhbpEEh/SCgcEEeN2513iiR10hyO
         lEXTtMZMxpzUDCZ2LfaNduKW8jN4kJzarOBp/YoJ31keGUFVNH9JuUb1bgNDomMRWrrX
         fgsoJhSioxmI9HsqyV1km6mzK0gyt6pN018D1saiy7iU9OZAKDDiFpTkA7ZD/wiGHGkP
         71MwYPtJkEwUuPjRbNkQbTGQB+w4aTrv29zfusdagcMFyA+IUJriztKAzCTjVVbIbwPk
         LiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Dp4MNcDT/EG/xM17zLq22RNCaOllxas9HQ392NgyuAc=;
        b=umK0TyhIYQ0oziVEcCerfOep3S7s0Vh77zIHmbGdSFJPqyubKjA84oq2kYlBupvklR
         Y1MUUWyPZFO9DvSSUEL/elh5tVVZgcH2puF62Gi5w10Y5xCo2bpJN/0gkmQ9+DIkhxEC
         GVjeo3C7IBKrcipv/HDVUXs0Fl7Ml2q3o25oeiWz81jELHg6HPGHaX36zbptStrzBqz+
         RMSW/kR318wm4H7RiKYq3kZjT3B1ENRGFLC9WUy0Yz7y30j28cQR7frvWQwNZsIPGLiZ
         TL8MSHbJl9ZWZPnTNo648PuZbKYYR+/g/+nJDRE58wrVIyyXEzQLZYgmV6H4VRouno9B
         OPVw==
X-Gm-Message-State: ALQs6tCP/ILe01D1HRo+EOxTnABz+gf576Qno2xPi6zox3Fk35Ym6FJF
        oL/iuFRVFQwRIRv5RY/KifI=
X-Google-Smtp-Source: AIpwx49g8K7RHcbUyUydJs5vE0pJC2UturbF1q9sd0vXwcs+wU0AVDSVQ3ohiOYZ4YXsA5eM3ljXcQ==
X-Received: by 2002:adf:8672:: with SMTP id 47-v6mr18774498wrw.102.1524614757561;
        Tue, 24 Apr 2018 17:05:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l53-v6sm37278634wrc.80.2018.04.24.17.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 17:05:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git: add -N as a short option for --no-pager
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
Date:   Wed, 25 Apr 2018 09:05:56 +0900
In-Reply-To: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org> (Johannes Sixt's
        message of "Tue, 24 Apr 2018 18:59:39 +0200")
Message-ID: <xmqqh8o05evv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> In modern setups, less, the pager, uses alternate screen to show
> the content. When it is closed, it switches back to the original
> screen, and all content is gone.
>
> It is not uncommon to request that the output remains visible in
> the terminal. For this, the option --no-pager can be used. But
> it is a bit cumbersome to type, even when command completion is
> available. Provide a short option, -N, to make the option easier
> accessible.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

Heh, I used to append "|cat", which is four keystrokes that is a bit
shorter than " --no-pager", but that is only acceptable when you do
not care about colored output ;-)

I am not absolutely certain about the choice of a single letter. I
already checked we do not use "git -N cmd" for anything else right
now, so I am certain about the availability, but I am not sure if
capital 'N' is the best choice, when the other side is lowercase 'p'
(and more importantly, the other side 'p' has mneomonic value for
'pagination', but 'N' merely stands for 'no' and could be negating
anything, not related to pagination). But I agree that a short-hand
would be welcome.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 4767860e72..17b50b0dc6 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git' [--version] [--help] [-C <path>] [-c <name>=<value>]
>      [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
> -    [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
> +    [-p|--paginate|-N|--no-pager] [--no-replace-objects] [--bare]
>      [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
>      [--super-prefix=<path>]
>      <command> [<args>]
> @@ -103,6 +103,7 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
>  	configuration options (see the "Configuration Mechanism" section
>  	below).
>  
> +-N::
>  --no-pager::
>  	Do not pipe Git output into a pager.
