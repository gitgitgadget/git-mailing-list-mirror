Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1EDA1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 07:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeDUHnz (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 03:43:55 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:41243 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeDUHny (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 03:43:54 -0400
Received: by mail-wr0-f169.google.com with SMTP id g21-v6so819852wrb.8
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 00:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SYuByEj4I25OSeGhqaFxaqNChvIFSMj05WS8CsUjCFs=;
        b=CEkUHh2KGJBbv5vniYZ0Qkvuf5JT4TRQZc8E4mGPICH7ADkvj3KuZftM4oaF77coWQ
         8cLc0aV6X3SCdW8RnCiUuUTZGmBQjlFA4xd1ZKgRNWOtGQ6EbA0LQYeiEeYkusFffkAp
         M/1qO3J//FdCU8AvTowZ4GPoTu6e8rVjmRzNnVDbZrNiRYR0vqAI1KCXnXRpVHnUiZOY
         QU7ug37v3JxYZKoMHZtu9/onZI2XT3eTHnpJzwOWFMW2C7qv8BnO/stMo7KjtmeqpRgA
         hO+Ld3iXGxG9w7HdfzuX0lLbz2N3oZG97WAcTAjUwz7GDcZLNBSXrkOXZVBerrjL85aJ
         sspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SYuByEj4I25OSeGhqaFxaqNChvIFSMj05WS8CsUjCFs=;
        b=sdzpQ6KigtidgG4ug58CsaHDVTpjuzYvbBJY9pdIBgmVcV/K6jm+zxJhTyAIs6By+6
         LaXsIJgkllHl37c+oWP4TUjkWfU/zLhefRuJUfVTE0dJth09TEpHx5mbwuGLaRmyIwX6
         WL9mSgPuHpGTprv78hh58BZeip6ptWN13L7w1y6s0mpwoXbMj9SE2nPk6Gb4AdJWNKw7
         RuoORKsTgD1krYFxhWLkKdwvugQRwuo5C6oU1l0MpBJor8No2haA7myO0hp9ngs4q5As
         JSexjk6qwYid1W9OUZZTE1ATg9aeA2bCEJOIRGERKJmVqNGV5x4cfv0tcmzDcVgN5/+5
         tsSw==
X-Gm-Message-State: ALQs6tBZUfqoMqq5iOSd3KyIDzNmcJXGQBzxWHzfj5xqPo845AnxkxYw
        +pX8Sbz9N11mcxAYnV204/Q=
X-Google-Smtp-Source: AIpwx4+ZGw0fZ4bA/n1749S52ZC7rQyg/f+1/7QVed7iWzattspI26nHevB+hBSkEO8b8Q+PIfOMrQ==
X-Received: by 10.80.141.5 with SMTP id s5mr17703635eds.238.1524296632778;
        Sat, 21 Apr 2018 00:43:52 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id d17sm4645382ede.65.2018.04.21.00.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Apr 2018 00:43:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>
Subject: Re: [PATCH 1/3] gettext: avoid initialization if the locale dir is not present
References: <cover.1524211375.git.johannes.schindelin@gmx.de>
        <6be8678b7d6b4d9116ea4666a0b28ff4dd938690.1524211375.git.johannes.schindelin@gmx.de>
        <87o9iedwqn.fsf@evledraar.gmail.com>
        <CAN0heSpda1ZnFXgoCEgxGdBk-JYUSPAV0A=mQYMtOq7w8x+5=w@mail.gmail.com>
        <87lgdidt30.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1804202110550.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1804202110550.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Sat, 21 Apr 2018 09:43:50 +0200
Message-ID: <87efj9dmx5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 20 2018, Johannes Schindelin wrote:

> Hi Ævar,
>
> On Fri, 20 Apr 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> On Fri, Apr 20 2018, Martin Ågren wrote:
>>
>> > On 20 April 2018 at 11:59, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> >>
>> >> On Fri, Apr 20 2018, Johannes Schindelin wrote:
>> >>
>> >>> The runtime of a simple `git.exe version` call on Windows is currently
>> >>> dominated by the gettext setup, adding a whopping ~150ms to the ~210ms
>> >>> total.
>> >>>
>> >>> Given that this cost is added to each and every git.exe invocation goes
>> >>> through common-main's invocation of git_setup_gettext(), and given that
>> >>> scripts have to call git.exe dozens, if not hundreds, of times, this is
>> >>> a substantial performance penalty.
>> >>>
>> >>> This is particularly pointless when considering that Git for Windows
>> >>> ships without localization (to keep the installer's size to a bearable
>> >>> ~34MB): all that time setting up gettext is for naught.
>> >>>
>> >>> So let's be smart about it and skip setting up gettext if the locale
>> >>> directory is not even present.
>> >
>> >> If you don't ship git for windows with gettext or a podir, then compile
>> >> with NO_GETTEXT, then we won't even compile this function you're
>> >> patching here. See line 30 and beyond of gettext.h.
>> >>
>> >> Are you instead compiling git for windows with gettext support with an
>> >> optional add-on package for i18n, so then this podir conditional would
>> >> pass?
>> >>
>> >> In any case, if this is actually the desired behavior I think it's worth
>> >> clearly explaining the interaction with NO_GETTEXT in the commit
>> >> message, and if you *actually* don't want NO_GETTEXT I think it's useful
>> >> to guard this with something like MAYBE_GETTEXT on top, so this code
>> >> doesn't unintentionally hide installation errors on other
>> >> platforms. I.e. something like:
>> >>
>> >>         int have_podir = is_directory(podir);
>> >>         if (!have_podir)
>> >> #ifdef MAYBE_GETTEXT
>> >>                 return;
>> >> #else
>> >>                 BUG("Broken installation, can't find '%s'!", podir);
>> >> #endif
>> >
>> > Is it fair to say that such a broken installation would function more or
>> > less well before and after Dscho's patch, and that your approach would
>> > render such an installation quite useless?
>>
>> Yes my thown out there for the purposes of discussion suggestion may
>> break things for Dscho, or not. I'm just saying that we should document
>> *what* the use-case is.
>
> I think you underestimate the scope of your willful breakage. It is not
> just "break things for Dscho". It is breaking things for every single last
> user of Git for Windows. If we ever do that, I will make sure to announce
> that together with your name and your postal address on it.
>
>> Because it's not just important to massage the code so it works now, but
>> to document what the use-case is, so someone down the line who things
>> "oh why are we doing that" has a clear answer.
>
> Let's face it: if gettext would ever fail to work in case of a missing
> podir, then it would fail for every installation using a locale for which
> we just happen not to have any translation.
>
> So we know that your patch would not only break things, but break things
> totally without reason!
>
>> > Do we have some other similar
>> > cases where we go BUG("I could not find a resource. I could manage
>> > fairly well without it, but you seemed to want it when you installed
>> > me.")? I wonder what other well-respected software do if they can't find
>> > their translations.
>>
>> E.g. my recent 1aca69c019 ("perl Git::LoadCPAN: emit better errors under
>> NO_PERL_CPAN_FALLBACKS", 2018-03-03) does similar things, we *could*
>> carry on in certain cases instead of dying there (or not, depending on
>> the codepath).
>>
>> But in general, I don't think there's any reasonable use-cases for git
>> needing to repair from a broken or semi-broken installation that aren't
>> so specific that they can be explicitly declared, e.g. in this
>> hypothetical MAYBE_GETTEXT case.
>
> Ævar, you need to understand one thing, and you need to understand it
> right now: the vast majority of Git users will not compile their Git. Not.
> Ever. Really, I am not kidding. They use whatever built version they can
> get most conveniently.
>
> It is even more true on Windows, where it may be easier to build Git for
> Windows now (what with all the work I put into the Git for Windows SDK),
> but it is still an expensive endeavor.
>
> And that is even assuming that every Git user is at liberty to build their
> own software, which is completely untrue in a large chunk of our business.
>
> So in order to give users who want localization what they want, without
> burdening users who do not want localization, we use the exact same build
> of Git for Windows for both, and the entire difference is that one comes
> with the podir, and the other without.
>
> Okay, I am lying, at the moment we do not even have anything end-user
> facing that ships with the podir. But I distinctly want to leave the door
> open for that.
>
> And if you think that this is out of sheer laziness on my part, then I
> hate to break it to you that this is for *very* good reasons: maintenance
> cost.
>
> It probably has not crossed your mind that the entire Git test suite fails
> to pass if you run it on Git for Windows when built with NO_GETTEXT
> defined?
>
> Yep. It fails. With a honking
>
> 	BUG: your vsnprintf is broken (returned -1)
>
> And if you build it without NO_GETTEXT, it passes without that error.
> Crazy, huh?
>
> So unless you acquire quite a bit more experience with maintaining Git on
> a common platform, I would like to implore you to stop trying to break it.
> Thank you very much.
>
>> Otherwise if it's not conditional, e.g. my git on Debian that won't ever
>> need this is going to just subtly regress because the FS is broken or
>> whatever, and I don't think we should have such code in git running
>> unconditionally.
>
> I have not the faintest idea what the heck you are talking about.
>
> If the podir exists, then it is used. No change from before.
>
> If the podir does not exist (which is unlikely in your setup, but there
> you go, it might happen), the *only* difference you might notice is that
> things get slightly faster (but probably not even noticably so, on your
> platform). That is literally the only difference you could possibly notice
> with vs without my patch. Seriously.
>
>> > I suppose the logic could be the other way round, i.e., with a flag
>> > REALLY_REQUIRE_GETTEXT_AT_RUNTIME. But I also wonder if a user who does
>> > not notice that the installation is broken without us screaming BUG in
>> > their face, really minds the "brokenness" that much.
>>
>> Without the BUG(...) that user is going to spend time fiddling with his
>
> Don't exclude half of humanity, for your own sake.
>
>> i18n settings before finally realizing that his package is broken, much
>> better to just emit an error so it's obvious that things are broken,
>> rather than taking the fallback path.
>
> And then you will also add code to output BUG BUG BUG when the actual
> *language* subdirectory is missing?
>
> You would *need* to do that, and you know this as well as I do, because
> even if your Git installation is "broken" and does not bring its l18n
> stuff, *another package will have it*, and therefore podir *exists*! And
> therefore your suggested change would not only break Git for Windows, it
> would also totally not do what you want it to do!
>
> And even then, I totally, utterly hate to break it to you: even on Ubuntu,
> it is quite, quite common to have the git package installed *without* the
> language-pack-de-base or whatever you need for your locale.
>
> The reason is the same as for Git for Windows: we want to save on space,
> so you do not get localization files that you are not even interested in,
> instead you get a leaner download.
>
> And in this case -- even on Ubuntu -- your patch does not make sense, but
> simply breaks things for no reason other than some well-intended but
> horribly broken idea that you should force the user to have a
> /usr/share/locale/ even if they may never even want it, and even if things
> work very well without it, thankyouverymuch.
>
> In short: I totally disagree with your reasoning to break things that work
> very well, with a BUG() that is prone to confuse and scare end users no
> less.

You raise a lot of good points, although I wish you could phrase them
without the threats of doxxing.

The suggestion of doing that BUG(...) assertion was, to be clear, not
mentioned as a "we should definitely do this", but "why don't we do
this?".

I still stand by the observation that the "why don't we" isn't clear at
all from your patch's commit message and that should be fixed. It
doesn't mention any of the actual reasons for the change which have been
revealed in this follow-up thread.

I.e. that you're aiming to compile a version of git that has a
hot-swappable "locale" directory, and don't want to slow down those
users who don't have it with pointless gettext setup.

I know that the "vast majority of Git users will not compile their
Git". I'm not talking about that, but that there are certainly packagers
who know that they're building for an installation where
/usr/share/locale is expected never expected to just disappear.

Asserting this particular thing isn't going to be that useful, since
gettext has fallback behavior anyway. It just looks suspicious to me
that git at runtime has fallback behavior for stuff not existing that we
*know* we installed during 'make install'.

That's why I mentioned that we should consider doing something similar
to NO_PERL_CPAN_FALLBACKS. I.e. that there's a 1=1 mapping between what
the packager declared was going to happen, and what fallback behaviors
the runtime package is using.
