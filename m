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
	by dcvr.yhbt.net (Postfix) with ESMTP id DCC401F453
	for <e@80x24.org>; Sat,  9 Feb 2019 14:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBIOGL (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 09:06:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34057 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfBIOGL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 09:06:11 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so5202089ede.1
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 06:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A0S8AY4tkLqMIVMJh3ZpFVVYafe9MCne9BpNrhabVaw=;
        b=Avklj+T8m5a9mi472U675kdTU6+Xb920t6cXqOEDXlDOLsTWrUAnaiNNDHaqQWKgTm
         GJAnAjOCGlXdB5tmsFskTLJocqx3G0LcRGB4UhQGZFTgEyiapQTNv8+Qu5X+QVppH1p9
         +jhKQ7U8x3JUZ5PSyvvkPWgXTi+rvrmtn8voOA6bbRgRXihHDXOoOaESVbE5Jhzj7rvw
         17f6PjKXOQa+XxVhabytkDVffqo3tAg96aTwgZrIZfzBMJbbfAfLWC0ioWKnTVii37Fa
         TLNTfR23inFToflrFboMAlIRnZ76bzeKzg3s+xiOahXs7Emr3gO5nONtPkJKvi6qQjWB
         vEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A0S8AY4tkLqMIVMJh3ZpFVVYafe9MCne9BpNrhabVaw=;
        b=eYJRgpePxeCph1z61vnDVCm019Fqz0SfpQoTpDsBdat0F4vfK8EuKxvaVh/r5WsQxJ
         fq3NY0EXB8IBn4V88I10l2NXL3AnRrJYVK/0O7MEPSzJEXSnQLb8HkF8Je/BGbJIkbuh
         1QNuFC85zbKZMJBHQJzkKN3kCR/10/dSEffqhc0fc0rSBKVS2ybzls7vwznt6/0wuqDv
         BT0aSeEfy1Y9Lfwcc4WpZds1u8fcEDn09g/eGRqQiqQs9NT81TxWt4+W3MGtglU3bQL6
         xmKYhi2cVOW76p7ahaVePKRVUfh4a+IydY0WEKHDqKK55FwAEP+idPQPSfE5mjrw2LdN
         uQQw==
X-Gm-Message-State: AHQUAuYE1jTU0r8fCVInNaZiqxN1ZkBS37l5FbluGrBcgdEjsiyO584Q
        Uv5dLg18gveIc82hAolA8yA=
X-Google-Smtp-Source: AHgI3IahKPUqsuqWG68B/NwDbN4xZTqqGDLsd54KIs22a9il37ytHRQ4lhP41au9AxhTe5n5W9jlAA==
X-Received: by 2002:a17:906:2596:: with SMTP id m22mr19965848ejb.249.1549721169169;
        Sat, 09 Feb 2019 06:06:09 -0800 (PST)
Received: from szeder.dev (x4db36840.dyn.telefonica.de. [77.179.104.64])
        by smtp.gmail.com with ESMTPSA id i7sm1125062ejc.62.2019.02.09.06.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 06:06:08 -0800 (PST)
Date:   Sat, 9 Feb 2019 15:06:05 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH 0/2] t/lib-gpg: a gpgsm fix, a minor improvement, and a
 question
Message-ID: <20190209140605.GE10587@szeder.dev>
References: <20190208031746.22683-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208031746.22683-1-tmz@pobox.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 07, 2019 at 10:17:44PM -0500, Todd Zullinger wrote:
> Looking through the build logs for the fedora git packages, I noticed it
> was missing the GPGSM prereq.

Just curious: how did you noticed the missing GPGSM prereq?

I'm asking because I use a patch for a good couple of months now that
collects the prereqs missed by test cases and prints them at the end
of 'make test'.  Its output looks like this:

  https://travis-ci.org/szeder/git/jobs/490944032#L2358

Since you seem to be interested in that sort of thing as well, perhaps
it would be worth to have something like this in git.git?  It's just
that I have been too wary of potentially annoying other contributors
by adding (what might be perceived as) clutter to their 'make test'
output :)


> Lastly, the GPG test prereq was failing in two of the tests where it was
> used, t5573-pull-verify-signatures and t7612-merge-verify-signatures.  I
> tracked this down to an annoying issue with gnugp-2¹, which recently
> became the default /bin/gpg in fedora².
> 
> Using gnupg2 as /bin/gpg means using gpg-agent by default.  When using a
> non-standard GNUPGHOME, gpg-agent defaults to putting its socket files
> in GNUPGHOME and fails if the path for any of them is longer than
> sun_path (108 chars on linux, 104 on OpenBSD and FreeBSD, and likely
> similar on other unices).
> 
> When building in the typical fedora build tool (mock), the path to the
> git test dir is "/builddir/build/BUILD/git-2.20.1/t."  That path then
> has "trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX" appended and a
> "gpghome" directory within.  For t5573 and t7612, the gpg-agent socket
> path for S.gpg-agent.browser exceeds the sun_path limit and gpg-agent
> fails to start.  Sadly, this is handled poorly by gpg and makes the
> tests fail to set either the GPG or GPGSM prereqs.
> 
> For the fedora packages, I decided to pass --root=/tmp/git-t.XXXX (via
> mktemp, of course) to the test suite which ensures a path short enough
> to keep gpg-agent happy.
> 
> I don't know if there are other packagers or builders who run into this,
> so maybe it's not worth much effort to try and have the test suite cope
> better.  It took me longer than I would have liked to track it down, so
> I thought I'd mention it in case anyone else has run into this or has
> thoughts on how to improve lib-gpg.sh while waiting for GnuPG to improve
> this area.

I stumbled upon this when Dscho inadvertently broke a test script on
setups without gpg last year; sorry for not speaking about it.  I
noticed it in our Travis CI builds on macOS, because it (macOS itself
or Homebrew? I don't know) defaulted to gpg2 already back then, and to
make matters worse its sun_path is on the shorter end, and the path
to the build dir on Travis CI includes the GitHub user/repo as well.

> A GIT_TEST_GNUPGHOME_ROOT var to set the root path for the GNUPGHOME
> dirs in the tests is one thought I had, but didn't try to put it into
> patch form.  Setting the --root test option is probably enough control
> for most cases.

A potential issue I see with GIT_TEST_GNUPGHOME_ROOT is that there are
several test scripts involving gpg, and if GIT_TEST_GNUPGHOME_ROOT is
set for the whole 'make test', then they might interfere with each
other when they happen to be run at the same time.

In the meantime I came up with a '--short-trash-dir' option to
test-lib, which turns 'trash directory.t7612-merge-verify-signatures'
into 'trash dir.t7612'.  It works, but I don't really like it, and it
required various adjustments to the CI build scripts, notably to the
part in 'ci/print-test-failures.sh' that includes the trash dir of
failed test scripts in the build log.


