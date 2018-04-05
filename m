Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B89D1F424
	for <e@80x24.org>; Thu,  5 Apr 2018 08:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeDEImW (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 04:42:22 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38114 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEImT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 04:42:19 -0400
Received: by mail-wm0-f49.google.com with SMTP id i3so4614458wmf.3
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Rmp7hZ/XhOTVIUPa8pnlM0Z1tow0DtcE20gGQ0lwz8k=;
        b=sOSh80wEB+ZU1Wr1YNXyHYr9A5Cy0MmgY5pO2yLzVZ+3hDm0EVwqKoPZ4kyUzkE1+S
         kf/Qx03A5FR1ZWFDfRJEGHZjQvc3YJBQyw3dJc3auJvmef/bdRsZoF4qgs12Y6bTOicO
         +CFWjHuGHKLFEESW1OsBvRTj1lDdfv+TuxEYwahREqVnJNvdmdaN0vfhvRR8PLKiTVqR
         Qgxl5KLZ+nmdoMXW1+ylPX/Vp4OaK8mw32ctCUcwKE0Y+h5H7wySaiNZmezIm+5McwV3
         Ajj9wct6TDnTpGgzFferMtUHZlhe6d6z7yxv3WAKGd2a5pBRljj8X5puDbOKXWYTPyZC
         frdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Rmp7hZ/XhOTVIUPa8pnlM0Z1tow0DtcE20gGQ0lwz8k=;
        b=qkzuUMPgfLvAgSfsTWUq0KtV8zuTWZiplIFafns+K6BbDTKdZNKJpR6WeriKtY8v1v
         1UBH9Whxn6xTSAgjOqn8uPC8OJlFOxAebpVxqY0PjiUUVyOS2vj1/HZSQ8YI8/RDBzwX
         pHD7LcJvac2/R5h6wGl6CUrRPfPOFy8nMk722fhaGD7wwM/ts0FOX/eU77vXlVmx+cqt
         4FnIb1wh8idLSDG2sxM8AakGjnMpdWa4pNSUsp6V2/QU+qGdhKcqDxUTFLqIuYWkJObN
         kyMMI+2MEB/nxTlDznDGv1rNLZv8NaJiEx/eVTUoqpsaMNlOjDLOE+E7hU2uQihhgQe2
         IPXA==
X-Gm-Message-State: ALQs6tB3CLBWqfLxmxejESQt/fm3fxtcqFEEcHkbrChsd9HM4PuCGmbG
        flO1qpYiVj4Do82cngml4nSo+4yo
X-Google-Smtp-Source: AIpwx48ClcgvxP/X0oEIoTadWpBweyTHsThLDarJhZYRPiHDNhFjnZspKKAf825Q6A5qpvX6BgX21Q==
X-Received: by 10.80.135.164 with SMTP id a33mr2099958eda.34.1522917737695;
        Thu, 05 Apr 2018 01:42:17 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 4sm4524055edx.8.2018.04.05.01.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Apr 2018 01:42:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: How to undo previously set configuration?
References: <20180405092358.569e0315.olaf@aepfle.de>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180405092358.569e0315.olaf@aepfle.de>
Date:   Thu, 05 Apr 2018 10:42:15 +0200
Message-ID: <874lkq11ug.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 05 2018, Olaf Hering wrote:

[Changed subject]

> My ~/.gitconfig looks like this, because all cloned repositories require these settings:
> [sendemail]
>         from = Olaf Hering <olaf@aepfle.de>
>         envelopesender = olaf@aepfle.de
>         chainreplyto = false
>         ccover = yes
>         smtpencryption = tls
>         smtpdomain = sender
>         smtppass = smtppass
>         smtpAuth = PLAIN
>         smtpserver = smtp.strato.de
>         smtpuser = smtpuser
>         confirm = always
>         assume8bitEncoding = yes
>         transferEncoding = 8bit
>
> Now there is that one repo that requires this:
>
> [sendemail]
>         from = Olaf Hering <a@b.c>
>         envelopesender = a@b.c
>         smtpserver = otherhost
>
> That "otherhost" does just plain oldstyle unencrypted SMTP.
>
> How do I undo the global sendemail settings for that one repo?
> Setting the knobs to empty strings does not help:
> Command unknown: 'AUTH' at /usr/lib/git/git-send-email line 1455.
>
> It seems the global smtpuser is causing the error.

There isn't any way to do this, the only way out is the hack of using
conditional includes and placing this repository in some special
location.

In general it would be very nice if git learned to conditionally pay
attention to config from various places, I've been meaning to work on
this but haven't figured out a good syntax for it (suggestions
welcome!). Things I'd like to do:

1) Set some config in e.g. ~/.gitconfig saying that I want to ignore
   everything from /etc/gitconfig, or in /some/repo/.git/config saying I
   want to ignore ~/.gitconfig but not /etc/gitconfig.

2) Ditto #1 but more granular, e.g. for your use-case saying you're OK
   with grabbing ~/.gitconfig, but you'd like to ignore all sendemail.*
   values from there, or say in your local .git/config that you'd like
   to ignore all previously set sendemail.* no matter where it came
   from.

3) Ability to re-arrange the config priority, right now it's hardcoded
   that we look at /etc/gitconfig, then ~/.gitconfig then your
   .git/config. You can add a config for ~/work with the conditional
   includes, but it would be nice (just as a general thing) to also
   re-arrange things so /etc/gitconfig gets parsed last or whatever.

   I don't really have a use-case for that, but adding such priorities
   would be simple once we had support for #1 and #2, just some
   "priority" integer you could override for each file, and we'd set
   default values for them, e.g. 10 for /etc/gitconfig, 20 for
   ~/.gitconfig, 40 for .git/config etc.

For any of this to work we'd need to re-arrange the config code so that
we'd fully parse all the config files first, and consider any such
"ignore the thing before me" rules in each file, and then make a second
pass over the config data

The ulterior motive I want this for is to eventually support some
facility where we can safely load a .gitconfig from clone repos, since
once we have this for other reasons (and as noted above, it would be
useful for that in its own right) we can load .gitconfig from some
untrusted source, because we're going to be able to say that we only
trust the repo's .gitconfig to set sendemail.to or whatever, but nothing
else.

Previous ramblings from me on this subject:
https://public-inbox.org/git/87zi6eakkt.fsf@evledraar.gmail.com/

So maybe something like this in a .git/config

    # Reject all previous such [config] overrides, by default we'd add
    # them (as default in git config)
    [config]
    reject = *
    [config "system"]
    priority = 50
    reject = *
    accept = sendmail.*
    [config "global"]
    reject = *
    accept = sendmail.*

And eventually have git itself mark up each config option on some scale
of least harmful (sendmail.to & friends) to most harmful (executing
shell aliases), and:

    # Remote maintained untrusted config
    [config "repo"]
    acceptLevel = least-harmful

Or whatever toggle to include some default policy shipped with
git. Actually we could just do that with more generally with config
includes if we learned some syntax for including some templates shipped
with git itself.
