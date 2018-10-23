Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369841F453
	for <e@80x24.org>; Tue, 23 Oct 2018 16:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeJXBJs (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 21:09:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40562 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJXBJs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 21:09:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id r1-v6so2279863edd.7
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pJxW835vXredttv2125hLh+wTBSDwNFHqEY2L7Dc24o=;
        b=HvnxAkLD7X3rOY29teogAYUBFyqT4SVHlVUYioLL4jNXC8Y2LmqmAf4MT5NS1/UyvV
         yRpjNb5bmqPtvqDsv4m4jzkBVXut4IJraVjVfWsJIesIk1UPthGeFLRht2BY/jALD0Lk
         RjO5PARxAY2EGphO9WxA6tlKUgOeSeSjBDIOXYOKQHGYxWct1SP02piVCEJ/33dZC38e
         vNquJ/irFhW18emEALwyVFet6vT8AYp/yzhurhPLlU1OaU+is+nSvFI5Qj0Fh7tnJirC
         BlNhStkHWK4Sggix7botGE6Bh90/3hf+TIKLIHf9OyUqTYaJ0i87sj0BvsQtVzbTdSPv
         D2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=pJxW835vXredttv2125hLh+wTBSDwNFHqEY2L7Dc24o=;
        b=bs5J889WpfXy8835P4wv2EAn+8kb3NUki1kX9dcHtRtMOXedNiafsuIqxL3HEoNSr1
         6cXHkfzIn0CR92BcAaNPzw5Wb9bNTl1bXUcX83no6J4LdH85ecU1XoRT8Dhxqs2Nkwsk
         jqOJxLM63akh0lVgiw1Drw1i9D/Fi1oPpQCZODArIwhomI41M4KB9DqJGI1MbonhZ9Zz
         XRtp3beMxxCycsyPTXR11lthqyo55KGtmTbj6BS7NoZtTFqmZkr6gI/L9+e+cynNEVUr
         CRV6y4vCEVvEYYeDBbv7vNTHO/35zibzXZ/4u5fymFqloNG7aUY7RjyPtSwyfxrv9bCI
         spWQ==
X-Gm-Message-State: ABuFfojjbveaqBeOoze5fTlelNjFxtgG0cfX/8v39D96evtsSkj2CjHN
        pZ0yEXAQrdeg75PxdgB8E3c=
X-Google-Smtp-Source: ACcGV63OXr64OfnfrlNTzlOTa9vyBsJtkXrd3uKT7wSvZ3l9wgvtjLIaBhJbHpuvZTEZgjlFCltaDw==
X-Received: by 2002:a50:e38d:: with SMTP id b13-v6mr16743804edm.263.1540313136879;
        Tue, 23 Oct 2018 09:45:36 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id q15-v6sm456499eju.51.2018.10.23.09.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 09:45:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
References: <20181022153633.31757-1-pclouds@gmail.com>
        <878t2pd6yu.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1810231126470.4546@tvgsbejvaqbjf.bet>
        <8736sxc6gt.fsf@evledraar.gmail.com>
        <CACsJy8CX78EbANbv8a354djJaO6dKRpXshHhHJTspJvOSewgpA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8CX78EbANbv8a354djJaO6dKRpXshHhHJTspJvOSewgpA@mail.gmail.com>
Date:   Tue, 23 Oct 2018 18:45:34 +0200
Message-ID: <871s8gd32p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 23 2018, Duy Nguyen wrote:

> On Tue, Oct 23, 2018 at 12:17 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Tue, Oct 23 2018, Johannes Schindelin wrote:
>>
>> > Hi Ævar,
>> >
>> > On Mon, 22 Oct 2018, Ævar Arnfjörð Bjarmason wrote:
>> >
>> >> So I think the only reason to keep it [GETTEXT_POISON] compile-time is
>> >> performance, but I don't think that matters. It's not like we're
>> >> printing gigabytes of _() formatted output. Everything where formatting
>> >> matters is plumbing which doesn't use this API. These messages are
>> >> always for human consumption.
>> >
>> > Well, let's make sure that your impression is correct before going too
>> > far. I, too, had the impression that gettext cannot possibly be expensive,
>> > especifally in Git for Windows' settings, where we do not even ship
>> > translations. Yet see the commit message of cc5e1bf99247 (gettext: avoid
>> > initialization if the locale dir is not present, 2018-04-21):
>> >
>> >       The runtime of a simple `git.exe version` call on Windows is
>> >       currently dominated by the gettext setup, adding a whopping ~150ms
>> >       to the ~210ms total.
>> >
>> > I would be in favor of your change to make this a runtime option, of
>> > course, as long as it does not affect performance greatly (in particular
>> > on Windows, where we fight an uphill battle to make Git faster).
>>
>> How expensive gettext() may or may not be isn't relevant to the
>> GETTEXT_POISON compile-time option.
>
> If a user requests NO_GETTEXT, they should have zero (or near zero)
> cost related to gettext. Which is true until now (the inline _()
> version is expanded to pretty much no-op with the exception of NULL
> string)

I'm assuming by "until now" you mean until my RFC patch in
https://public-inbox.org/git/875zxtd59e.fsf@evledraar.gmail.com/

Yeah it's more expensive, but I don't see how it matters. We'd be
nano-optimizing a thing that's never going to become a
bottleneck. I.e. the patch is basically taking the commented-out
codepath in this test program:

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int have_flag(void)
    {
        return 0;
        /*
        static int flag = -1;
        if (flag == -1)
            flag = strlen(getenv("GIT_TEST_FOO"));
        return flag;
        */
    }


    int main(void)
    {
        while (1) {
            const char *out = have_flag() ? "foo" : "bar";
            puts(out);
        }
    }

When I test that on my laptop with gcc 8.2.0 I get ~230MB/s of output on
both versions, i.e. where have_flag() can be trivially constant folded,
and where we need to call getenv() for both of:

    GIT_TEST_FOO= ./main | pv >/dev/null
    GIT_TEST_FOO=1 ./main | pv >/dev/null

We don't have any codepaths where we're calling gettext() to output more
than a screenfull or two of output, so optimizing this doesn't make
sense.

>> The effect of what I'm suggesting here, and which my WIP patch in
>> <875zxtd59e.fsf@evledraar.gmail.com> implements is that we'd do a
>> one-time getenv() for each process that prints a _() message that we
>> aren't doing now, and for each message call a function that would check
>> a boolean "are we in poison mode" static global variable.
>
> Just don't do the getenv() inside _() even if you just do it one time.
> getenv() may invalidate whatever value from the previous call. I would
> not want to find out my code broke because of an getenv() inside some
> innocent _()...

How would any code break? We have various getenv("GIT_TEST_*...")
already that work the same way. Unless you set that in the environment
the function is idempotent, and I don't see how anyone would do that
accidentally.

> And we should still respect NO_GETTEXT, not doing any extra work when
> it's defined.

This is not how any of our NO_* defines work. *Sometimes* defining them
guarantees you do no extra work, but in other cases we've decided that
bending over backwards with #ifdef in various places isn't worth it.

E.g. grep_opt in grep.h is a good example of this. Even if you don't
compile with PCRE you're pointlessly memzero-ing out members of the
struct that'll never be used in your config, because it's easier to
maintain the code that way (types always checked at compile-time).

(And no, despite my involvement in PCRE I didn't introduce that
particular pattern)

For the reasons noted above I think NO_GETTEXT is another such
case. Just like GIT_TEST_SPLIT_INDEX (added in your d6e3c181bc
("read-cache: force split index mode with GIT_TEST_SPLIT_INDEX",
2014-06-13)) etc.
