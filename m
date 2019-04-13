Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DF4A20248
	for <e@80x24.org>; Sat, 13 Apr 2019 20:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDMUjj (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 16:39:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39834 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDMUjj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 16:39:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id k45so11286568edb.6
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 13:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=yrKhmLdeutAB6Od0bdh/2foVICou4X/E6HarRkDpZlE=;
        b=c3wZb+bYT1AMu+WNN5sNZU2km7syzmqaT5p4Hm4Oe79awABxD8m50cB7x2RM1iB9Er
         FFOh8kvxmUKYp3IGj8eS0sEkFq+bm0euAn46TJC0ya9+f2nqI0taOeY7cLJZpDXvtaHL
         QCgCOXLPh25BDQX3x1/SZ36FfKLgFrPAEIh6+dgDaGRyP0wuxHunHmLW3IFD0cQV2pBd
         SBst/8QNhHiBCzyw9k2MxibEN8bFW6xyjC6dnilJL5DUPCrhhFsjVWX1/3ilTJQ2dtje
         4zv2m34EsQPjxy7rLvlepI8T0LDG1+J7WUS+1CSq7fpwEFqLz0PHc4yn/xYwd5Fg0JjN
         MB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=yrKhmLdeutAB6Od0bdh/2foVICou4X/E6HarRkDpZlE=;
        b=UM0O0RWxdfKEA4nVDMPMOqSuaxcaU5m/r2xqLkDFIPoAR05FqhuM9piM32hEPbD0bj
         KqKcuRbbwwg7AjH0FV447yffkCR5RjDVQl9+8Iu0iNJDzyCI8zxBq+TVLUKZC7J29eod
         D7vehLBa6bmOG+0B9Rv4gDNi1SXaon2wknD4WbYVSx6A3ljowpJpdynn4H0htTHZi8sh
         QVdY9DDuRIFd6ldQJPb9Q9ZuoglACc7ambf2dda8ACVhUjzyK++c13Y1/F1N1pQBQArE
         LsTB/3uRG15wln3UJcbZKIZBV3Gl5Jmq5pPqDIzlWPtm9/uj7lFdF8eHWfQ+L9yk1lFg
         eaJw==
X-Gm-Message-State: APjAAAX+R/Povp+VhtJWJnVz1cYf9gU6l0gSKvydieRYWizgOTc6/xr9
        8y4oTBkmfVTx/77/NGRrFNl6foN1
X-Google-Smtp-Source: APXvYqyDH1yLFrW4OaJKT6TuRBVHp9O9H/Y4UrGoI1vxMcN3P1Pbz507pIwhE2BmtCYgK/ktYzTmbA==
X-Received: by 2002:a17:906:2cd1:: with SMTP id r17mr35627252ejr.101.1555187977768;
        Sat, 13 Apr 2019 13:39:37 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id h11sm7100675eds.44.2019.04.13.13.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 13:39:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] GIT_SSH_COMMAND is not being decomposed
References: <000d01d4f237$5cf2dc10$16d89430$@nexbridge.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <000d01d4f237$5cf2dc10$16d89430$@nexbridge.com>
Date:   Sat, 13 Apr 2019 22:39:35 +0200
Message-ID: <874l71fxmg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 13 2019, Randall S. Becker wrote:

> I am encountering a problem on one of our NonStop platform variants where
> the GIT_SSH_COMMAND string is not being broken into constituent parts. This
> is causing SSH to not run properly. As background, SSH is not in a standard
> location and has non-standard required arguments. This also occurs with
> core.sshCommand. The situation is:
>
> git config --global core.sshCommand '/G/system/zssh/sshossz5 -Q'
>
> which correctly sets .gitconfig as:
>
> [core]
>         sshCommand = /G/system/zssh/sshossz5 -Q
>
> When git is run with GIT_TRACE=true GIT_PACKET_TRACE=true git fetch
>
> We get the partial trace:
> 14:19:56.027088 trace: built-in: git fetch
> 14:19:56.029895 trace: run_command: '/G/system/zssh/sshossz5 -Q' -G
> user@host
>
> The same trace on our systems that actually do work results in:
> 14:19:56.029895 trace: run_command: '/G/system/zssh/sshossz5' '-Q' -G
> user@host
>
> I need help resolving why this is happening (as in where to look and debug
> the situation).

This doesn't seem to be documented *explicitly* (except between the
lines & inferred), but it's only supported to pass a *command* there,
i.e. the path of the ssh binary. See the code around get_ssh_command()
in connect.c. The whole env/config value we look up gets passed as one.

So if you need arguments you need to create a wrapper script and set ssh
command to that script.
