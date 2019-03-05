Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C439620248
	for <e@80x24.org>; Tue,  5 Mar 2019 05:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfCEF5f (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 00:57:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38054 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfCEF5f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 00:57:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id a188so1261017wmf.3
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 21:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=68wlqlqE0JajaGs2lLCFSFLFZhmA4XAooTOhZrEQbfo=;
        b=qX7DDoQ9Y/ZozxMpKFgWk/30yNd0Hyibk2NJfJZfaVsd2y6yhgi0qeeC9QYChQLBfG
         iGJdSs9D9TJwh0F3RMDrB4CSlCg3UdCjsYWzqEWkKYLoza+McN0lTyoPck6WtcG+L90N
         Zdx8NP55vkFu5cFLD4/LxZd6wOfa2sKiEd0fkXpUrVqd/T0x3c6FnviIZ5uqs2ansvMt
         xBocpAzuUlKt/F15ZTiEVG5I9je15bu0+195zpxaZHp9q4pHW7KNCTxp3qFr4N2FTCx9
         Q6XkuXQ2q9Xz6LOlnYJ08/0m8FtTVuW5Y6lFdkXqEiT4HGpP1+5pws7gQEV7x92tSZDs
         kAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=68wlqlqE0JajaGs2lLCFSFLFZhmA4XAooTOhZrEQbfo=;
        b=m4NKmpLaAkR2vp+8aMbtM12gfPUa/3OIseI1UP9EJykhLKF4bJevtMat9nHHY9wPPZ
         r+UZwI4Nc3iB+laa0J9z9CwyDdzP0s50BspPf9aDk6NMkAyHnz3Df0FrMZlSrtJkzWFo
         H2BauR8e3lk5X7lKrBB6vksQFv7+eGJADEvY4KCdiSgebGCDU61eAPgUdkhxo5BT/W6/
         Ho9nPQwEI9UfvuDFa8sx+DNq8p3bBZzIg0d0XyENPtx6SL3IK0ZGyupg99td3cyd8uHO
         o9DXOYCNub8KiwmfI4BI8FtN0drNNqgoXxADpshLKBUKLx0jSxkkW4+Uw9t4R7lmufh9
         7ycg==
X-Gm-Message-State: APjAAAV51qN566ZPjc2G5FjF/LBBTS5LIJuv4UFxkfEdt3PwD3BpPiQR
        yeyJBgPWgYsxFEBsbnQ1x7w=
X-Google-Smtp-Source: APXvYqxTMIovcizT0mKWeCOsUayLYJgPe+Gl4oGRkUxNokN8/3eQ2mU/AuqalDXODf0Ih7mwbu8n2w==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr1603660wmh.153.1551765453517;
        Mon, 04 Mar 2019 21:57:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 132sm27650532wmd.27.2019.03.04.21.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 21:57:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
        <xmqqtvgk69ik.fsf@gitster-ct.c.googlers.com>
        <20190303174214.GF23811@sigill.intra.peff.net>
        <xmqqlg1vw9f2.fsf@gitster-ct.c.googlers.com>
        <xmqqh8cjw7ob.fsf@gitster-ct.c.googlers.com>
        <20190305042050.GE19800@sigill.intra.peff.net>
Date:   Tue, 05 Mar 2019 14:57:32 +0900
In-Reply-To: <20190305042050.GE19800@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Mar 2019 23:20:51 -0500")
Message-ID: <xmqqva0xvp6b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do wonder, though, if we're digging ourselves a hole with the
> inconsistency between different --types that will bite us later. Given
> that it's not that hard to chomp the output (and as you noted, the shell
> does it fairly transparently), and given that the caller has to switch
> between "--get-color" and "--type=color", it's not that hard to handle
> the output differently if you know to do so.
>
> Mostly I was just surprised by the new behavior. Perhaps the right
> solution is not a patch to the code, but to the documentation. Something
> like:
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 495bb57416..61f3a9cdd7 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -252,7 +252,9 @@ Valid `<type>`'s include:
>  	output.  The optional `default` parameter is used instead, if
>  	there is no color configured for `name`.
>  +
> -`--type=color [--default=<default>]` is preferred over `--get-color`.
> +`--type=color [--default=<default>]` is preferred over `--get-color`
> +(but note that `--get-color` will omit the trailing newline printed by
> +--type=color).
>  
>  -e::
>  --edit::

Yup, that would be a very sensible first step, regardless of what
the next step is.

After that, choices are

 (1) we'd introduce new inconsistency among --type=<type> by
     matching what --type=color does to what --get-color does, to
     allow us to revert that documentation update, or

 (2) we'd drop LF from all --type=<type>, that makes everything
     consistent and risk breaking a few existing scripts while doing
     so, and get yelled at by end users, or

 (3) we stop at this documentation update and do nothing else.

