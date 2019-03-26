Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D3C202BB
	for <e@80x24.org>; Tue, 26 Mar 2019 06:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfCZG3D (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 02:29:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43913 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZG3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 02:29:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so4898374wrx.10
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 23:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XFpvZpRcZooXA5/u/XQbLmpGPAopihRpkmjlGfPNpuQ=;
        b=sOaDoA0gKX42qXw3cZb4gsLfmtgnVbllzMVlPd4WAul7QtqlzjTaLL2WJqLHhRQl23
         yYWdDpSVulR1q3vZXXB7SrSFzcUbE/mNPF4b66AfTf+wHyzxX/hunTdi7pJ6Uhj9pDvA
         87R+cIain6EpoviHNT2nr/7B+yv/fQ1vvebjFMCMAjiPxDbDO3Lu/dy7LmnvJ8yZkXVj
         XwvIoIYY48CryykoARC3CgrIElJx0un62OqTfl88rFYOqUFQ1lBOTq++Z0UzxzydLWmT
         Ut1t3WbFnRd5RBEDq5NLX0StmriLPHMjjoU4qH3jcrx1T/dJJhA20kqvsk9nLn/AwFyw
         RMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XFpvZpRcZooXA5/u/XQbLmpGPAopihRpkmjlGfPNpuQ=;
        b=Uksf/2AypEeFFQBAMvVIiF5BbqeXrHWZxLXGdVVMazJPkvTb5Z3HthXfkMcFNoeH0S
         i6C8EfrPPD5R1XQRExHSoDBozb7CeqKU58qG2oT1RVw5xiu2dHT8NylDOmIp5CKSUn0o
         vUKuLI9ZA60WMHpTSDCYf/pEczT2UBFCHvb6juI0xAzVBzg0AftTKlbRu3vZSl4mV4fv
         odGuimvpV65Y83C2cNBp9lqRTFioDWH0p6y2zwB02rZ/7vH+0a/oZ9n9RqpzldFcoPCl
         +UNecHaOw+e3+PtWUMGfHbikfoshBVD4OPXpytvVL90aubK1150RhpIgKSSBxfgK9rNK
         UHoA==
X-Gm-Message-State: APjAAAW6viGxT6+3ggS54sVFq7qYJCQHZyHvj7Uzyc2LCenKfuQRMYmx
        V44WxugOcZPTyebKAEODzl3IpEG6eBY=
X-Google-Smtp-Source: APXvYqxdEPiN+PhKDBH7iQOFXiKh5/f2K6Aan8txtB5V8oYiPBG1bY/v0sP2NPi82s1ldF2e4SpHtg==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr18832921wrs.139.1553581740639;
        Mon, 25 Mar 2019 23:29:00 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id u12sm16423176wrt.2.2019.03.25.23.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 23:28:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: allow for configuring option abbreviation
References: <pull.167.git.gitgitgadget@gmail.com> <20190325202329.26033-2-avarab@gmail.com> <CAPig+cR0Ldt3EpQ683ZFNFXggfsTrdeZ3R-V6pDBZNA1N3c+xg@mail.gmail.com> <87o95ybmgf.fsf@evledraar.gmail.com> <CACsJy8Bk=Z8BaVeAhKzF4PWYLLG76cADooHKNw+Xy3EztZL1DQ@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8Bk=Z8BaVeAhKzF4PWYLLG76cADooHKNw+Xy3EztZL1DQ@mail.gmail.com>
Date:   Tue, 26 Mar 2019 07:28:58 +0100
Message-ID: <87lg12b13p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 26 2019, Duy Nguyen wrote:

> On Tue, Mar 26, 2019 at 5:48 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Mon, Mar 25 2019, Eric Sunshine wrote:
>>
>> > On Mon, Mar 25, 2019 at 4:23 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > <avarab@gmail.com> wrote:
>> >> diff --git a/Documentation/config/core.txt b/Documentation/config/cor=
e.txt
>> >> @@ -1,3 +1,15 @@
>> >> +core.abbreviatedOptions::
>> >> +       Defaults to `true` which allows options to be abbreviated as
>> >> +       long as they aren't ambiguous, e.g. for linkgit:git-init[1]
>> >> +       the `--bare` option can be abbreviated as `--bar`, `--ba` or
>> >> +       even `--b` since no other option starts with those
>> >> +       prefixes. However, if such an option were added in the future
>> >> +       any use of these abbreviations would break.
>> >> ++
>> >> +By setting this to false (e.g. in scripts) you can defend against su=
ch
>> >> +future breakages by enforcing that options must always be fully
>> >> +provided.
>> >
>> > I don't get why having a configuration option is better for defending
>> > scripts against this problem than a simple environment variable. It
>> > seems easier for the script prologue to contain:
>> >
>> >     GIT_TEST_ABBREVIATED_OPTIONS=3Dfalse
>> >     export GIT_TEST_ABBREVIATED_OPTIONS
>> >
>> > than for it to muck about with git-config or use "git -c
>> > core.abbreviatedOptions=3Dfalse ..." everywhere. The commit message
>> > doesn't do a good enough job of justifying the configuration option
>> > over the environment variable.
>> >
>> > Also, if this is now intended to be more general (aiding script
>> > writers) than just being for our test suite, then dropping "TEST" from
>> > the name seems warranted:
>> >
>> >     GIT_ABBREVIATED_OPTIONS
>>
>> If we want to make something user-configurable we tend to add config
>> variables. The GIT_TEST_* variables are only intended for our own test
>> suite, see t/README.
>>
>> I don't mind documenting this, but it's a well-established pattern, so
>> if we're going to describe how this works/why use one or the other it
>> should probably be some other series to t/README and/or git-config.txt
>>
>> We traditionally *only* expose this sort of thing to users via config,
>> and not via env variables.

FWIW I replied so quickly to this with patches since I had something WIP
to do this, it's annoyed me as a user in the past that I couldn't turn
this off, IIRC some upgrade of git broke my "bad" muscle memory /
scripts.

> If this is mostly useful for scripts then I agree with Eric an
> environment variable is the way to go. A configuration variable does
> not make it more convenient.

I think both of you might be assuming that when you want to configure
something it's as easy to tweak every run time environment (set an env
var) as it is to set a global config. See the trace2.* config discussion
for similar use-cases.

> And no we don't only export via config. There are a bunch of public
> env variables in git.txt. "core" namespace is already very crowded. If
> this one is only rarely used, I'd rather not add a new config
> variable.

I don't see how a new "abbreviatedOptions" is plausibly going to crowd
out anything else, sounds pretty unambiguous to me.

By my count out of the the existing GIT_* variables in git.txt around
1/3 are already configurable via config, another 1/3 (all the GIT_TRACE
stuff) is something we've wanted to have configurable in the past (but
nobody's gotten around to writing patches for).

I think it's fair to say that when we normally add user-configurable
stuff we do it as config, not as new env vars.
