Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11C01F424
	for <e@80x24.org>; Thu,  5 Apr 2018 11:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbeDELVH (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 07:21:07 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:39210 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDELVG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 07:21:06 -0400
Received: by mail-wm0-f42.google.com with SMTP id f125so5962033wme.4
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oBzmvxVG2aVjAVC/iIQEOw+xYyT1RZRFv0eqCVo/ogs=;
        b=OjRVsfTEp+d+9ajbk1pXvaTlPYX0F7ixIwn+DLwgdF8ffXPtWoOBW/0hl5IUYIZRMe
         IGXRZS0BkrZVH3JwLjQMTLm26H1ybEQWLQhFaye1XPu9yDAGl0HtMXifOoqWzyGlQOc2
         s9DqqyVOyrB1OsgehLZN3X2Pm5PjfOHiETe5DB/J4UIC8AGRGN6hXU9/yahZ47HyUaIO
         SiRTXRBWtBi+yI15TjLBiYHxhPwfVJDfsfEW2cEzT3uH2MVEojNgZsXt8af6oGoLGaUR
         IREEcPoY9QiTi5EWDFNia9RcDp6PjYDRa6uoamlAS6wxdkOUIIhZIKwng55RE9FG2wDf
         MD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oBzmvxVG2aVjAVC/iIQEOw+xYyT1RZRFv0eqCVo/ogs=;
        b=I+LnhEadGjCrG16eCLl1RrvWUBw4TewhS9YjSLpkkBm8rT7QS2ixZbhqGkIGPixTET
         C72aWX+kjGokiNKnxqvPkW8B+HDVHilcQDjFKv+SkquAGcSmXoW6p+g/e4zBmbxdLgmN
         Kijj91QhSkozSjMz7haysFYZqSsxxr02rGeSk8Dls20VVFsTaELQm6s1T1NHJUB7Kflb
         PIyENoMuYxtzowREhvXAgrM5PihxZg8iWdStpfJOjudHITLoBbXzdVloROIlSqYboUHE
         o259zgz4/iMd/Qvm7zKA7QbHbj0qZmDohxGCu2nO1V7mhUwPqkYjHd6MqHsKcP7D+mpu
         C+kw==
X-Gm-Message-State: ALQs6tAwZ5R9kKrXCXjIwGxIHnRTebGoI/GfUX/wMCNi9wxg2VJF7GBF
        3PVNCd8nTV+SINo+B0HpSqc=
X-Google-Smtp-Source: AIpwx49rrWv8tPQbI22n9bz0hVPJmXwBT6XjuYTyBU4LvvocLgJwIMvfOIdIldFlM0xM9kVyEWKQhw==
X-Received: by 10.80.173.75 with SMTP id z11mr2605771edc.306.1522927264883;
        Thu, 05 Apr 2018 04:21:04 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id l1sm4590014edi.54.2018.04.05.04.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Apr 2018 04:21:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: How to undo previously set configuration?
References: <20180405092358.569e0315.olaf@aepfle.de> <874lkq11ug.fsf@evledraar.gmail.com> <20180405104948.276de0ca.olaf@aepfle.de>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180405104948.276de0ca.olaf@aepfle.de>
Date:   Thu, 05 Apr 2018 13:21:02 +0200
Message-ID: <8737092929.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 05 2018, Olaf Hering wrote:

> Am Thu, 05 Apr 2018 10:42:15 +0200
> schrieb Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
>
>> I've been meaning to work on this but haven't figured out a good syntax for it (suggestions welcome!).
>
> Just prefix the knob with something like "no." or "-" or whatever to indicate that it never happened.

Those wouldn't work, respectively, because:

 a) For 'no.' there would be no way to override three-level keys,
    because prefixing such a key with "no" would introduce a 4th nesting
    level, which would be incompatible with existing config parsers.

 b) Similarly a prefix of - dies in git now. Unless I misunderstand
    you. I'm assuming you mean something like:

        [user]
        # This is an error
        -email

    Although I see we don't ignore or error out on:

        [user "-email"]
        foo=bar

   But that's back to problem a), and also looks ugly since you need
   something like the extra foo=bar so we'll pay attention to it.

Also it's important that the syntax leaves room for item #1 that I
mentioned,

I.e. not just ignore stuff like user.email, but being able to specify
where from you'd like to ignore that. Sometimes your local sysadmin is
overzealous with his /etc/gitconfig settings and you'd like to
quarantine just that, but pay attention to everything else in
~/.gitconfig, or similarly in /some/repo/.git/config ignore your usual
custom sendemail.* from ~/.gitconfig but not /etc/gitconfig, so the
semantics can't just be "clear existing".

But of course, you might say that it *should* be a syntax error because
if you rely on this feature and downgrade, you don't want to suddenly
pay attention to the sendemail.* config again.

I think that's an acceptable failure mode, and better than the syntax
error, because that's exactly what we have now, so this is similar to
e.g. the conditional include directive which was understood but just
copmletely ignored by older versions.

So we're OK with getting different config between versions with new
releases, but at all costs don't want to have new releases introduce
constructs that older gits error out on, and let's say hypothetically we
supported something like:

    [user "-email"]
    [user]
        email = ...

Even `git config -l` on older version won't show that "user.-email", and
it's better if older tools at least understand the syntax, even though
they don't pick up on the magic.
