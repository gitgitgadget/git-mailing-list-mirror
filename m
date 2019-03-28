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
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF7120248
	for <e@80x24.org>; Thu, 28 Mar 2019 09:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfC1J6q (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 05:58:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40940 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfC1J6p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 05:58:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so6407535wre.7
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Qb/JffqJQg2iYPd105pHz5jCN6wdoxkW7rDHbZCT+u4=;
        b=Q2Zv6BDmSHxMqUI5xgXNDTu93BWFGhu4yg8sL7TP+qHsPVGWx2qDLvF9oUcPAAFC2i
         Y/IJaYSeSMD4k39ACQWiZC4D3MKhrPWr/WXD0+5MfJoLwajUNbQph/obJ/dQi2qHCJ3O
         oiwrDTXzWoM5hxZbTuR/2jEJJbz598Ye6xp8MW89lCnn1Rw7D1tPRmNvNL4uaQuRFPNN
         3Ro1s9HNmiQ1K/FInV7RhBSZqgVquRVZZzLaom1M5C58lXQriNGOECh6csPK080ihN1K
         sgo5v1TgLARsX8wlC7S1m+CIq+0k7LUo8aPsTJbFN+le18Ejq1wMGYcA01vOXdauQ6Q0
         5S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qb/JffqJQg2iYPd105pHz5jCN6wdoxkW7rDHbZCT+u4=;
        b=og4LUgBsbi1zYl/E/RdkeYGPu4Oac8p3ygvYKRb3Us6uaOwr8Q5Z0B+gOVSBVNL8yi
         yoYOThEvYXQ0EMQHkOKFRVj9Rp2Nw6ykAJtPJnFl126pCiOVd9CDFLKCAw2GgPfowMBB
         /lpd9nal+6nLZ2UXyPpjJ47h0Oz08J0XcPFWzJrr8i81IvNfjACc6QNCsAnTCLvXybCd
         LHt2AhY/VDhf4oWqi1iDXrJRF77/IvIWmqkrWAK5ZDHnZwODjwVLHxwBe0E5r55Mato+
         IME9OYL87F0IVR15WYI+2O9NCiGbST5JrNLGT7f9dNeQaP7aC64MHjLtdH/uD8eqmdoQ
         kiQQ==
X-Gm-Message-State: APjAAAWYxUPGIEXiWEb+HetBK5OyoaO9PxKH/EzWZLiAPvrqG8A1hSDp
        RIMVe5BoTKDZJdSQTjOLr5XdcyuZJMk=
X-Google-Smtp-Source: APXvYqyVHlAiZgGyuG0ngrTmem+QzKDBObVge/+io/lrmR+FdKNuL5pP/UBLhp7F+qWFhg+6Wr5bMQ==
X-Received: by 2002:a5d:4801:: with SMTP id l1mr25795372wrq.318.1553767123408;
        Thu, 28 Mar 2019 02:58:43 -0700 (PDT)
Received: from szeder.dev (x4dbe3e45.dyn.telefonica.de. [77.190.62.69])
        by smtp.gmail.com with ESMTPSA id j3sm2962473wre.51.2019.03.28.02.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 02:58:42 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:58:39 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Mooga <contact@m-mooga.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [GSoC] microporject test_path_is_*
Message-ID: <20190328095839.GF32732@szeder.dev>
References: <38B8E527-2338-485E-8840-29121F259687@m-mooga.com>
 <CABPp-BHwUoqk79Kf=ynna5x+mCJyOLz66v6pDieyEeM7YCRS+g@mail.gmail.com>
 <877eckbpdd.fsf@evledraar.gmail.com>
 <20190327104935.GD32732@szeder.dev>
 <874l7obm0c.fsf@evledraar.gmail.com>
 <20190327121411.GE32732@szeder.dev>
 <8736n8be71.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736n8be71.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 03:10:42PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Mar 27 2019, SZEDER Gábor wrote:
> 
> > On Wed, Mar 27, 2019 at 12:21:55PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >>
> >> On Wed, Mar 27 2019, SZEDER Gábor wrote:
> >>
> >> > On Wed, Mar 27, 2019 at 11:09:18AM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> >> > There are likewise several that use one of
> >> >> >    ! test -e path/to/filename
> >> >> > or
> >> >> >    ! test -f path/to/filename
> >> >> > or
> >> >> >   test ! -f path/to/filename
> >> >> > which could be replaced by
> >> >> >   test_path_is_missing path/to/filename
> >> >>
> >> >> Interesting that for some we use the 'test_is_there/test_is_not_there'
> >> >> pattern and for others 'test_is_there [!]'. E.g
> >> >> test_path_exist/test_path_is_missing v.s. test_i18ngrep.
> >> >
> >> > It's unclear what the '!' should negate in case of 'test_path_is_file
> >> > ! file'.  What if 'file' does exists, but it's not a file but a
> >> > directory, socket, fifo, or symlink?  'test ! -f file' returns success
> >> > in these cases as well.
> >> >
> >> > OTOH, it's quite clear what the negation should mean in case of
> >> > 'test_i18ngrep'.
> >>
> >> *Should* we make it better? Yeah sure, maybe. I'm just pointing out for
> >> context to someone poking at this for the first time that now we
> >> sometimes do "! foo <arg>" v.s. "foo <arg>" as "foo_is <arg>" and
> >> "foo_not <arg>" and other times "foo [!] <arg>".
> >>
> >> So yeah, maybe we should improve things to disambiguate the cases you
> >> mentioned, but right now e.g. "test_path_exists" and
> >> "test_path_is_missing" are just "test -e" and "! test -e", respectively.
> >
> > I'm not sure why 'test_path_exists' exists, as I don't readily see a
> > valid reason why a test should only be interested in whether the path
> > exists, but but not whether it's a file or a directory.
> 
> In the general case the same reason we use "test -e". While the test
> would pass in all sorts of unexpected cases, those probably aren't
> plausible and we're just e.g. checking "did the thing create a file
> it'll create in XYZ mode?"....

When I look at a test using 'test -e' I can't readily tell what that
reason might have been, i.e. whether there really was a compelling
reason for using 'test -e' instead of 'test -(f|d|...), or the dev
writing the test was just "meh, we could let it slide".

> > Luckily it
> > haven't caught on, and it's only used twice in the whole test suite.
> 
> Well, we have some >100 "test -e" though ... :)

Hopefully they will be turned into 'test_path_is_file' or
'test_path_is_dir' instead of 'test_path_exists'...  eventually, maybe
a decade or two worth of GSOC microprojects later... :)

> > However, as shown above, the existend of 'test_path_is_missing' is
> > very much justified.
> >
> >> The same caveats you've mentioned also apply to "test_i18ngrep" b.t.w.,
> >> there we squash the 3x standard exit codes of grep[1] into a boolean,
> >> and thus e.g. ignore the difference between <file> not matching an
> >> <file> being a directory or whatever.
> >
> > I'm not sure I understand, 'test_i18ngrep' handles the missing file or
> > not a file cases reasonably well:
> >
> >   expecting success:
> >           test_i18ngrep ! foo nonexistent-file
> >
> >   error: bug in the test script: test_i18ngrep requires a file to read as the last parameter
> >
> > or
> >
> >   expecting success:
> >           mkdir dir &&
> >           test_i18ngrep ! foo dir
> >
> >   error: bug in the test script: test_i18ngrep requires a file to read as the last parameter
> 
> Yeah you're right, I didn't read it carefully enough and it does handle
> *that* particular case, but e.g. a grep of "file" where we can't read it
> due to a permission error is the same as "didn't contain the string".
> 
> I'm not saying that's a bad thing, but the opposite. We assume a certain
> base level of sanity, e.g. we do "test_must_fail <cmd>" only for git,
> but "! <cmd>" for everything else, even though e.g. the system "grep"
> may be segfaulting.

That's kind of the point: this is not about the sanity of the system,
but rather about the sanity of the developers :)

'test_i18ngrep' does handle that particular case, because,
unfortunately, paths do get misspelled (or downright forgotten!) every
now and then, but 'test_expect_failure', '! cmd', a pipe downstream,
or some other circumstances can still hide those errors.  I fixed
several issues with bogus filenames in the past.

However, since we assume that the system we are testing on is sane,
there is indeed not much point in preparing for cases that could only
go wrong if the system was not sane, e.g. the lack of permissions to
read a just written file.  I don't recall that we had any such
permission-related issues in the past (but I didn't actually check).
Having said that, I agree that checking whether 'grep' exited with 2
would have been more robust.


And these are the cases where using test helper functions that know
about the negation like 'test_path_is_missing', 'test_must_be_empty',
or 'test_i18ngrep !' instead of '! test -(f|d|s|...)' etc. starts to
pay off, as they can protect us from our own mistakes.  Case in point:
the last remaining '! test -s' in our test suite is definitely wrong.

So I think if such a helper function is available, then we should use
it, and we might want to consider adding even more, e.g. we have a
couple of instances of '! test_cmp', '! has_cr'.  And these functions
don't have to be perfect and catch every case that could possibly go
wrong, they just need to do a reasonably good job at catching those
cases that would be our own fault if they were to go wrong.


> >> 1. http://pubs.opengroup.org/onlinepubs/009695399/utilities/grep.html
