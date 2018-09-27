Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D251F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeI1AyG (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:54:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44969 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeI1AyG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:54:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id t11-v6so5931180edq.11
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gfPjZ8738FHQ6lTCXZAbX5Ji2Id7IAk4v6w3r4RBK4I=;
        b=Km6ZEZAYrPoDwTh90a4yTxgZirlHNJl/DvsZ+EcL6yELT5lPnTGI2vMPaU1h1sS2IA
         rbqvWDF1QZr1ssyHko4hCfbDVEg6C92CU2QshrEMwfrSk2qDVcY2uj7tAmfvDWJdQX7W
         D9pr1+HdGPS+ofB1qzQ6TpxhCQXmRZhK2C84V5PiyciDP4T+9RfnMwpdxTtdVrYxQBqj
         KtLYYCcl+rjbNDsfdsUvQcPRWpoZocvZWA2szNkeKySjbx9+zdS6/hQnpyEEOsrrFTA+
         8HkkfyfD2BLOuW5PElcedN0/dF3OOTFTUcEIcGiYh+k0qOSpKt/wuDy43PCrFojWutTR
         523g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=gfPjZ8738FHQ6lTCXZAbX5Ji2Id7IAk4v6w3r4RBK4I=;
        b=XLHbAdO2A1cHl4RZo6/POOjH31ECKZX7rv6lcPT6LcHB9YIsLrMLGNbfhLoGp7giL8
         4qQPV9fY262IFBSg68xyUF84+dxY37eoTp+ZOMCTdDvJZQB0gzdI1/Gf8xQAYkvjwqJm
         A+7p4o5BWTUYyktOtsn0sifw3V/yP08vNS5w1Xnpz/9TueNDZ4RV4xYLSfr7tKSC9oz7
         PdwGtMfHrtO/Of+R0+GHVaAI+4WNzXUQPbWe5HfQzTxh5qQ/6Bfxmw97URmuTbHIDjpY
         9qtDp8bsd4Kd4nZo9R+8OVDZNKtX4MDXx4pfrVdIwg7GmSBf2Z9swiJ2ombweDZqQv6X
         tHLg==
X-Gm-Message-State: ABuFfohFdDULJ6I9aKNB6ZZGclYnQQh8ThwJ1mBSRcBoYlib8ADxKv8g
        gx7ZLSURn0U/CckOPIIkWxs=
X-Google-Smtp-Source: ACcGV63o+9y+9TS/k65HMC1iw90JdRudr/pfSm2qlpPLNfLLXBpsya3i6eNPFzsMg0jcT7uq0VuEqg==
X-Received: by 2002:a50:8d86:: with SMTP id r6-v6mr19134825edh.125.1538073270624;
        Thu, 27 Sep 2018 11:34:30 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id a12-v6sm221258ejr.46.2018.09.27.11.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:34:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] worktree: add per-worktree config files
References: <20180923170438.23610-1-pclouds@gmail.com> <87bm8kjeu5.fsf@evledraar.gmail.com> <CACsJy8Dwo_cBEQeqttj3G=RGaJT7bmVb=ABnV2916swgYQnyrw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8Dwo_cBEQeqttj3G=RGaJT7bmVb=ABnV2916swgYQnyrw@mail.gmail.com>
Date:   Thu, 27 Sep 2018 20:34:29 +0200
Message-ID: <87r2heiybu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, Duy Nguyen wrote:

> On Wed, Sep 26, 2018 at 8:25 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> On Sun, Sep 23 2018, Nguyễn Thái Ngọc Duy wrote:
>>
>> > +extensions.worktreeConfig::
>> > +     If set, by default "git config" reads from both "config" and
>> > +     "config.worktree" file in that order.
>>
>> How does this interact with config that's now only used if it's in
>> .git/config? E.g. you can't set remote.<remote>.<url> in ~/.gitconfig,
>> will that be inherited across the two of these?
>
> Er... we can't? If I remember correctly we don't have any enforcement
> on where what config vars must or must not go. The only exception is
> core.bare and core.worktree which is only read from $GIT_DIR/config
> because of the way they are involved in .git directory discovery. If I
> put remote "foo" in ~/.gitconfig, "git remote" happily reports remote
> "foo" to me.
>
> To sum up, we always inherit config from higher levels, with
> /etc/gitconfig being the highest and $GIT_DIR/config the lowest. It's
> up to the user to share config between repos responsibly. This patch
> only adds one more level, $GIT_DIR/config.worktree which is now the
> lowest level.

I see I'm misremembering most of the details here. I thought that if I put:

    [remote "whatever]
    url = ...

Into my ~/.gitconfig that it wouldn't work, but it does, e.g. here in my
~/g/git:

    $ grep -A1 whatever .git/config
    $
    $ grep -A1 whatever ~/.gitconfig
    [remote "whatever"]
        url = git@github.com:test/git.git

But there's still some special casing for .git/config going on,
e.g. here:

    $ git config remote.origin.url
    git@github.com:git/git.git
    $ git config remote.whatever.url
    git@github.com:test/git.git
    $ git remote get-url origin
    git@github.com:git/git.git
    $ git remote get-url whatever
    fatal: No such remote 'whatever'

And:

    $ git remote set-url whatever git@github.com:test2/git.git
    fatal: No such remote 'whatever'

So there is some special casing of .git/config somewhere. I looked into
this ages ago, and don't remember where that's done.

I was wondering if these patches introduced any unwanted edge cases in
this regard, e.g. if you're using the per-worktree config, and you have
remotes in .git/config, does "git remote get/set-url" do the right
thing?

Then if we have remotes in .git/config, should we add new remotes to
.git/config or the per-worktree file? I'd lean towards .git/config,
since remotes are orthagonal to worktrees, and closely tied with refs
which are shared no matter what this extension says, but maybe there's a
good argument for doing it the other way around.



>> > In multiple working
>> > +     directory mode, "config" file is shared while
>> > +     "config.worktree" is per-working directory.
>>
>> "But then how will it work with more than one?" I found myself thinking
>> before reading some more and remembering .git/worktree. Shouldn't we
>> consistently say:
>>
>>     [...]"config" and "worktrees/<worktree name>/config"[...]
>>
>> Or something like that?
>
> Point taken. Maybe I'm trying to hide implementation details too much.
