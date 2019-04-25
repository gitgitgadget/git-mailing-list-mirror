Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC05E1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 11:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfDYL6V (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 07:58:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36101 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfDYL6V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 07:58:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id u57so18930288edm.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=31riBHi5uXAgCmWMboOAKLiOQf+DW3r9eUOHDIJmWTU=;
        b=SfBjYZytYUbyRv0l94F/3FIunxwESwRUJgXQYw9c3qVC6MEYtyEA34MiPmu4RFU8D8
         hjOZQqnHctURkPYeeqCcdM9XbtTAO0enmD2x1BmxfsCMfjjF3yie+6gT4D7cED0NSplu
         iRLak+doB5mIuKCATfXwDu8I7bDSn8bYBvIUkb4ZVgqX7AK4w+yTSlx0Qz+3GUEyUDhM
         vCxIjBY3T6F6R2JPAB0poNOMcBtfoUc5PjUiM9W2yXs0OR2tiktmF7lm9mHG4lT9ZHk7
         ZX3S888eyFimK5j7nYQi9Co5jVOtq0wAKffR2MUv7mL+4bdPBC7MVBirghPwK205lyv9
         z/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=31riBHi5uXAgCmWMboOAKLiOQf+DW3r9eUOHDIJmWTU=;
        b=NrFo+MZz8HEPYkBtgWxQD+s/usCXiREFuUIOaZlAhBaiQGWwyDpxfqmXUCPGe++GUS
         KeGkDsd7J+wtOoAwAbacbSv6EQPw+D9Ex/iCKTZoaesafM+HXoYq1WlQv+lIUqeQkSmr
         /CeVTrr1zk3RGRUGF0+xiThVwZCVYrQdSO2uMoHZnaErYLSHcgPk1T/wHHinrFRg8AOm
         ZCSzJV8a6U2FivnRn5UOFJn4cYFEAicyEBpOKTuErz+PPPDNjoiyjO677XW54gk1uLxp
         9E//1ogaBTwjLIb1jjWW0Bqx7CG4MEaabLw5anAC6BCF69E+UEsx2sru/utLvKlnUTjo
         hwrg==
X-Gm-Message-State: APjAAAUELr8GrlhhtjWaPEL1XxGxxNS67gsoqEy1cnWtmlf1QcF2sNTt
        dMlliKpP4uj31G95SF+u0yY=
X-Google-Smtp-Source: APXvYqxfACFLNMatxb2Zj+f/KklzlLjJYgEJWePs+bAUKXSbVL3hD5HecVjioyujOmf5TLZHTiDHyA==
X-Received: by 2002:a17:906:e241:: with SMTP id gq1mr19494859ejb.5.1556193499266;
        Thu, 25 Apr 2019 04:58:19 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id q18sm3924291ejp.56.2019.04.25.04.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 04:58:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Subject: Re: How to undo previously set configuration? (again)
References: <20190424004948.728326-1-sandals@crustytoothpaste.net> <20190424023438.GE98980@google.com> <20190424230744.GL6316@genre.crustytoothpaste.net> <87k1fis8gq.fsf@evledraar.gmail.com> <CACsJy8DSvEPfqJVGBL=G147B-mqoXd-XDeNK7jQZLQgRftWRpQ@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8DSvEPfqJVGBL=G147B-mqoXd-XDeNK7jQZLQgRftWRpQ@mail.gmail.com>
Date:   Thu, 25 Apr 2019 13:58:16 +0200
Message-ID: <87imv2s3dz.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 25 2019, Duy Nguyen wrote:

> On Thu, Apr 25, 2019 at 5:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> >> Solving (1) without (2) feels like a bit of a missed opportunity to
>> >> me.  Ideally, what I would like is
>> >>
>> >>    i. A central registry of trustworthy Git hooks that can be upgraded
>> >>       using the system package manager to address (2).  Perhaps just
>> >>       git-hook-* commands on the $PATH.
>> >>
>> >>   ii. Instead of putting hooks in .git/hooks, put a list of hooks to
>> >>       run for each event in .git/config.
>> >
>> > The problem I had with this when discussing it was that our
>> > configuration system lacks a good way to control inheritance from outer
>> > files. I recently was working with a system-wide gitconfig file that
>> > referred to files I didn't have, and my Git installation was subtly
>> > broken in a variety of ways.
>> >
>> > If I have a system-wide hook to run for company code, but I have a
>> > checkout for my personal dotfiles on my machine where I don't want to
>> > run that hook, our configuration lacks a way for me to disable that
>> > system-wide configuration. However, using our current system, I can
>> > override core.hooksPath in this case and everything works fine.
>> >
>> > I mentioned this for completeness, and because I hope that some of tho=
se
>> > people will get some time to chime in here, but I think without that
>> > feature, we end up with a worse experience than we have now.
>>
>> I sent a proposal for this last year "How to undo previously set
>> configuration?":
>> https://public-inbox.org/git/874lkq11ug.fsf@evledraar.gmail.com/
>
> While reading that mail, it occurs to me that perhaps we can reuse the
> .gitignore idea.
>
> Instead of having a list of untracked files, we have a list of config
> keys. Instead of having .gitignore files associated to different
> directories to apply the rules to those dirs only, we have ignore
> rules that should apply on certain config files (probably based on
> path).
>
> A few differences from your reject/accept/priority example:
>
> - we don't redefine priority, inheritance rules apply the same way
> - reject/accept is handled the same way as positive/negative ignore
> rules. If we're lucky, we could even reuse the exclude code.
> - instead of special section names like
>
>     [config "section"]
>
> we have something more like
>
>     [config "/this/path"] # (or pattern)
>
> this lets us handle even other config files included by [include] or [inc=
ludeIf]
>
> So, some examples
>
> [exclude]            # exclude from all inherited files
>     key =3D core.*     # exclude core.*
>     key =3D !core.bar  # but keep core.bar
>
> [excludeIf "path:/etc/config"] # rules apply for only this file
>    key =3D ...
>
> [excludeIf "glob:/home/*"]     # rules apply for these config paths
>    key =3D ...
>
> [excludeIf "system"]           # special names for convenience maybe
>    key =3D ...
>
>> Obviously the main bottleneck is someone like me working on patching it,
>
> Yes, manpower is always the problem.
>
>> but in this case it would be very useful if those who are interested in
>> this could look that proposal over and bikeshed it / point out issues I
>> may have missed, i.e. "no, this categorically won't work with this
>> proposed syntax due to XYZ you haven't thought of...".

Thanks, I like this syntax/proposal much better than my initial one,
especially re-using the syntax we have in .gitignore. Also in that it's
more similar to the existing include syntax, which in retrospect with an
example is the obviously better choice both in terms of UI consistency
and flexibility.

I.e. I didn't want config files by globs, because depending on compile
options the /etc/gitconfig may be in /opt/etc/gitconfig, but as your
'[excludeIf "system"]' and '[excludeIf "path:/etc/config"]' examples
show we can have our cake and eat it too, and as you demonstrate there's
other reasons to do path globs that excluding the "git config
--{system,global,local,worktree}" file doesn't cover.

Re priorities: My "I don't really have a use-case for that" in 2018 is
still 95% true, just a couple of things:

 1. Having it would be a really nice smoke test for this working
    properly, i.e. now all the config parsing is "streamed" to its
    consumers via callbacks, having priorities would require the ability
    to pre-buffer and re-arrange it, the "pre-buffer" you'd need for any
    exclude mechanism anyway.

    Once we have that "priorities" should just be a quick sort of what
    order we loop over the files in.

 2. There is the use-case of "I don't want to exclude core.* from config
    file <A>, I just want file <B> to override it". I can imagine
    especially if/when we have in-repo .gitconfig that you'd want to
    trust say core.* from there, but have you ~/.gitconfig override it
    if you've bothered to set any of them yourself.

    But I think most of that use-case doesn't need priorities. It could
    just be another "exclude" syntax for common cases, e.g.:

        # ...Having done something else previously to opt-in to scary
        # in-repo .gitconfig...
        [excludeIf "repo"]
        key =3D core.* # exclude core.*
        [excludeIf "repo"]
        existingKey =3D true # exclude any existing key

    So e.g. you'd keep that .gitconfig's gc.bigPackThreshold or
    whatever, unless your ~/.gitconfig (parsed before, lower priority)
    had already set it.
