Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78E961F453
	for <e@80x24.org>; Mon, 11 Feb 2019 19:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbfBKTvq (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 14:51:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37079 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfBKTvq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 14:51:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id c8so136365wrs.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 11:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FPC9C1wl40yrKgHnJnKHA1qnDGR6XGN3hWfLiY1vp5A=;
        b=S8FTSDKtJqOWOd5QSwuGXijC5nlxVugxY7q75bNy+KHZ4pbjVBlEWHhiOW5PFVy/9S
         In6eEEDyexmqkbC4ET23NEKGQ1dNkjkmC4WZ5hK1ZeicY9NuGrKPb4/vSqL3ZgQXZwKv
         FPX9vsvq4kx7GcB+zgSLEUHHNkm4HbI6fhLrEj3pugc/evlY+H2VKMbbHPaEeA+5rt1G
         uRmaWF5FzkuoGKgHqY0swcepsPP20N82EJBjtix8bdUoC3+z7h72wPPWd/vzE2eio02U
         RXI+AcSamouHG6SnTErFiyd56Dw+iBCrVKUgz0sGvm+i6xd6iVv3Na3YmUYfnqQtxDr2
         dYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FPC9C1wl40yrKgHnJnKHA1qnDGR6XGN3hWfLiY1vp5A=;
        b=m9j1Gweu2VW85mHOGqQVpdIfuVzWeiCfXK0xXB6pn2c5Rv9ih/qDMbJru5CdP9W9Du
         UTPuc4rQYcByE0sFNkeS0Rct1m6DdBHvB+OQzR9pJyzxpxUUumYmsN8PijOSH/Qj4idn
         sNJhW68WgMZsoIW1fw2R+/YNit2oukZi+hGDNFBP/O2TYOycO6hUotjGYE/6ZNqff7F1
         soQfm1pgZV2Ua6YQKNeWvdCNtxm6wcU0nQPWQJVgY7LxU3vXK8tvs+mFCuXil4n7mOpU
         XQxOgTUVo5Ev2f8IP6KV3FJcZitJnvRRjkj1+Df+FvJl5YsVjD72LvIyyvsObdpcFvKZ
         mbOA==
X-Gm-Message-State: AHQUAuai/GL1+mPqbONlfT1pJOtjJuzsk88O587oWWqcljbPwxzIZCSB
        AxrMw/cHqUOVeBYGsDJJuHE=
X-Google-Smtp-Source: AHgI3IYLlbdIi9r5WYuB6PQQqmKtG+bP25L/qGfKsTbRpH2tHzOCmSku3t2aOm6oPVex1USjqfz+ew==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr8618992wru.75.1549914703910;
        Mon, 11 Feb 2019 11:51:43 -0800 (PST)
Received: from szeder.dev (x4dbe9d5f.dyn.telefonica.de. [77.190.157.95])
        by smtp.gmail.com with ESMTPSA id h62sm440955wmf.11.2019.02.11.11.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:51:43 -0800 (PST)
Date:   Mon, 11 Feb 2019 20:51:40 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH 0/2] t/lib-gpg: a gpgsm fix, a minor improvement, and a
 question
Message-ID: <20190211195140.GB31807@szeder.dev>
References: <20190208031746.22683-1-tmz@pobox.com>
 <20190209140605.GE10587@szeder.dev>
 <20190209230553.GI30548@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190209230553.GI30548@zaya.teonanacatl.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 09, 2019 at 06:05:53PM -0500, Todd Zullinger wrote:
> SZEDER Gábor wrote:
> > Just curious: how did you noticed the missing GPGSM prereq?
> 
> I just grep the build output for '# SKIP|skipped:' and then
> filter out those which I expect (thing like MINGW and
> NATIVE_CRLF that aren't likely to be in a Fedora build).
> 
> Far more manual than the slick method you have below. :)

Yeah, but yours show the SKIP cases, too, i.e. when the whole test is
skipped by:

  if check-something
  then
        skip_all="no can do"
        test_done
  fi

I didn't bother with that because in those cases the prereq is not
denoted by a single word, but rather by a human-readable phrase, and
becase 'prove' runs those skipped test scripts at last when running
slowest first, so I could already see them anyway.

> > I'm asking because I use a patch for a good couple of months now that
> > collects the prereqs missed by test cases and prints them at the end
> > of 'make test'.  Its output looks like this:
> > 
> >   https://travis-ci.org/szeder/git/jobs/490944032#L2358
> > 
> > Since you seem to be interested in that sort of thing as well, perhaps
> > it would be worth to have something like this in git.git?  It's just
> > that I have been too wary of potentially annoying other contributors
> > by adding (what might be perceived as) clutter to their 'make test'
> > output :)
> 
> Indeed, I think that would be useful.  At the very least,
> the .missing_prereqs files look quite handy.  I wouldn't
> mind the output from 'make test' either, but building
> packages surely shifts my perspective toward more verbose
> build logs than someone hacking on git regularly and reading
> the 'make test' output.

The problem with those files is that a successful 'make test'
automatically and unconditionally removes the whole 'test-results'
directory at the end.  So a separate and optional 'make test ; make
show-missed-prereqs' wouldn't have worked, that's why I did it this
way.

I think it would be better if we kept the 'test-results' directory
even after a successful 'make test', there are some interesting things
to be found there:

  https://public-inbox.org/git/CAM0VKjkVreBKQsvMZ=pEE0NN5gG0MM+XJ0MzCbw1rxi_pR+FXQ@mail.gmail.com/


> >> A GIT_TEST_GNUPGHOME_ROOT var to set the root path for the GNUPGHOME
> >> dirs in the tests is one thought I had, but didn't try to put it into
> >> patch form.  Setting the --root test option is probably enough control
> >> for most cases.
> > 
> > A potential issue I see with GIT_TEST_GNUPGHOME_ROOT is that there are
> > several test scripts involving gpg, and if GIT_TEST_GNUPGHOME_ROOT is
> > set for the whole 'make test', then they might interfere with each
> > other when they happen to be run at the same time.
> 
> Yeah, I was envisioning that var as something which set the
> base dir, under which the normal test directories would
> live.  Basically, like setting --root, but only for the
> GnuPG bits.
> 
> I'm not impressed by that idea (and I'm even less so after
> realizing how it would most likely make it harder to gather
> up the results in the CI scripts).  I mainly tossed it out
> in the hope someone would reply with a better method. ;)
> 
> > In the meantime I came up with a '--short-trash-dir' option to
> > test-lib, which turns 'trash directory.t7612-merge-verify-signatures'
> > into 'trash dir.t7612'.  It works, but I don't really like it, and it
> > required various adjustments to the CI build scripts, notably to the
> > part in 'ci/print-test-failures.sh' that includes the trash dir of
> > failed test scripts in the build log.
> 
> I can certainly live with setting '--root' to a shorter path
> and waiting to see if GnuPG upstream will come up with
> something a little more friendly to users like us - running
> gpg in a test suite.

Are they aware of the issue?

  https://lists.gnupg.org/pipermail/gnupg-users/2017-January/057451.html

suggests to put the socket in '/var/run/user/$(id -u)', but that's for
the "regular" use case, and we should take extra steps to prevent the
tests' gpg from interfering with the gpg of the user running the
tests.  Not sure it would work on macOS.  And ultimately it's not much
different from your GIT_TEST_GNUPGHOME_ROOT suggestion.

Then I stumbled on these patches patches:

  https://lists.zx2c4.com/pipermail/password-store/2017-May/002932.html

suggesting that at least one other project is working around this
issue instead of waiting for upstream to come up with something.

> Though if we do just wait it out,
> maybe we could/should add a note in t/README or t/lib-gpg.sh
> about this to warn others?

Well, a comment could help others to not waste time on figuring out
this "path is too long for a unix domains socket" issue...  but now
they will be able to find this thread in the list archives as well :)



On a related note: did you happen to notice occasional failures with
gpg2 on Fedora builds?  I observed some lately in tests like
'./t7004-tag.sh' or 't7030-verify-tag.sh' on the Travis CI macOS
builds: it appears as if the gpg process were to die mid-verification.
Couldn't make any sense of it yet, though didn't tried particularly
hard either.


