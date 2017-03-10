Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E7B1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 18:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbdCJSyX (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 13:54:23 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:34738 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932461AbdCJSyV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 13:54:21 -0500
Received: by mail-io0-f180.google.com with SMTP id g6so54078250ioj.1
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 10:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=h9sGb9pfk6/HezaEXjz53IWvz6n3t7ONFRJ1d7Hd1iY=;
        b=kfpRnR+XomDYNv7Gc2kOKL6m3FWZHGorPkbL2/p7hMIaBY77GE4E++9sv7/KUbYFYe
         hkG2igt5UdBggP9jhx/bIXIm6QBcaB/YtiisB+fsHwnJDba8rSODRbg56iFM9phRxyh0
         eOMzGSIA6lJBd4ue8DzPV3h3a2mS6x7ulivKOsbffdYuqxP4DQfJzW1NRdzhA1VgHtpE
         lDEgOQk+FZAD9+vl3u3VLtuQ6Yr4Hc792toFdMQarPaRb3mgQb8tyqtWNbBlfW73hRFn
         Vn64SgZqU1gRKQB9PE7EOhUhb9aqnUaCemjEHT6s1yEPSGDdL5ZKY+POyoPWCeyEwkW9
         6prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=h9sGb9pfk6/HezaEXjz53IWvz6n3t7ONFRJ1d7Hd1iY=;
        b=Vs0gwSUGqb2e/tKgCGdikdcVOplfKe4lZuvdWRkXABqvN0MCkqaTCQBX6kvI7HkzTT
         uNO7BQuvwWfa2sEF1BLikBAwJAKkH4IYUIhg0uvX+/ZdxTFe6V1TberxQIDdswvfOW5n
         4rnc0wQoPb8zia6wnZt6Io9sIoBmtEdbRAAJccVA3KwQnC2QCTt7PWc6e7wmSDGiwh8h
         /hX8Sz/yBCDp0EmeFNJcrTSAuDtafnf7PZG6a6evxnZtY9gQiXi7LYSE8uWo68tmBVGn
         zv2s8wx0NRVb1NHctBMKJkDjttqRmT5+SBVc2rSZ3gTyT9/UzpRDkpqaD8pNPpFjxKtf
         DgWw==
X-Gm-Message-State: AMke39nH3GaoMsWrl6xdagtYzwB5gpP91B+gVhw/fLJVsOc1UMJ/VrF/gntoF/aOXffZjNSj/+1xxgC1xjuoRA==
X-Received: by 10.107.136.93 with SMTP id k90mr17462494iod.224.1489172059950;
 Fri, 10 Mar 2017 10:54:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.136.102 with HTTP; Fri, 10 Mar 2017 10:54:19 -0800 (PST)
In-Reply-To: <201703101100.15214.bernhard.reiter@intevation.de>
References: <201703101100.15214.bernhard.reiter@intevation.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Mar 2017 10:54:19 -0800
X-Google-Sender-Auth: xKuxzFaUoj28328JuJT-AvJqC84
Message-ID: <CA+55aFxk7F103LADnmwc8wFySYQNiK6TcCQ0WSj+UTP-GihgcQ@mail.gmail.com>
Subject: Re: Stable GnuPG interface, git should use GPGME
To:     "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
Cc:     Git Mailing List <git@vger.kernel.org>, gnupg-devel@gnupg.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 2:00 AM, Bernhard E. Reiter
<bernhard.reiter@intevation.de> wrote:
>
> git uses an pipe-and-exec approach to running a GnuPG binary
> as writen in the documentation [1]:
>
>     gpg.program
>            Use this custom program instead of "gpg" found on $PATH when making
>            or verifying a PGP signature. The program must support the same
>            command-line interface as GPG
>
> please consider using libgpgme interfacing to GnuPG, because the gpg
> command-line interface is not considered an official API to GnuPG by the
> GnuPG-devs and thus potentially unstable.

Quite frankly, I will NAK this just based on previous bad experiences
with using "helpful" libraries.

Maybe you can lay my worries to rest, but the problems with libraries
in this context tend to be

 - hard to personalize.

   At least right now, we just allow people to set their gpg binary.
I'm betting that the library would pick whatever random preferred
version, and in the process possibly screwed us.

   Example: what if somebody is actually using another pgp
implementation entirely for some reason, and is just scripting around
it?

   Or maybe he's using the regular gnupg, but using different keys for
different projects (using "--homedir"). That's trivial with the
current model. How trivial is that with a library?

 - existing configuration

   This is the main problem I've seen in the past. Using the "ssh"
_program_ is easy. You add your keys, your config files, whatever, and
it "just works" (or rather, you fight it once and it definitely
doesn't "just" work, but then you copy your .ssh directory around for
the rest of your and forget how it ever worked, but it does).

   Using "libssh2" is an exercise in futility, and you have to do a
crazy amount of stupid "look up keys" and simple configuration in your
.ssh/config (like per-host keys, hostname swizzling etc) just don't
pick up the configurations you already did for the program.

 - UI

   For things like gpg, the UI is traditionally horrible. But there
tends to be various things like password agents that help with caching
passwords and/or add a graphical UI to get the password when
necessary.

 - library versioning.

   I don't know why, but I've never *ever* met a library developer who
realized that libraries were all about stable API's, and the library
users don't want to fight different versions.

   And to make matters worse, the different versions (particularly if
you end up having to use a development version due to bugs or required
features etc) are always made horribly bad to even detect at
built-time automatically with simple #ifdef etc, so now you have to do
autoconf crap etc.

Now, it may be that the pgpme library "just works" across
architectures and handles all of the above situations as gracefully as
the external program does. In that case - but _ONLY_ in that case -
would a switch-over to the library possibly be a good thing.

I'd be pleasantly surprised. But I *would* be surprised, because every
time I've seen that "library vs program" model, I've seen the above
issues.

In fact, we have those exact issues very much in git itself too. Yes,
I've used libgit2 (for subsurface). It's a pain in the arse to do
*exactly* the above kinds of things, and the thing is, that isn't
git-specific.

So I'm very down on using external libraries unless they are stable
and have no need for configuration etc. Things like zlib is fine -
there just isn't much to configure outside of the "just how hard do
you want me to try to compress". Nobody has a ".zlib/config" file that
you need to worry about accessing etc.

Of course, maybe pgpme is a world first, and actually does read your
.gnupg/config file trivially, and has all the gpg agent integration
that it picks up automatically, and allows various per-user
configurations, and all my worries are bogus.

But that would literally be the first time I've ever seen that.

                   Linus
