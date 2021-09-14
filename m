Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930B2C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684A461056
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhINXYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 19:24:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33907 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229746AbhINXYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 19:24:06 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18ENMW4W018433
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 19:22:33 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9790515C3424; Tue, 14 Sep 2021 19:22:32 -0400 (EDT)
Date:   Tue, 14 Sep 2021 19:22:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: Train station analogy, was Re: [PATCH v3 00/15] [RFC]
 Upstreaming the Scalar command
Message-ID: <YUEuuFTSZkxB86cC@mit.edu>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
 <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <87r1dydp4m.fsf@evledraar.gmail.com>
 <87ilz44kdk.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
 <87mtofnzv1.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet>
 <xmqqilz32hhr.fsf@gitster.g>
 <87ilz3nhfg.fsf@evledraar.gmail.com>
 <5ae0c3fe-52a4-49b2-32c2-17feab2dd2d5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae0c3fe-52a4-49b2-32c2-17feab2dd2d5@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 04:35:42PM -0400, Derrick Stolee wrote:
> 
> We should definitely work to find a better way to describe our
> vision for how _the ideas in Scalar_ can be adopted into Git proper.
> ..
> 
> But the way I see Scalar being fully incorporated into Git is not as
> a "git scalar <foo>" command or even having "scalar" be included by
> default.

I agree 1000%.  It may be convenient for existing scalar users to have
a way they can stick with the CLI that they are used to, but before we
add this functionality to git proper, let's please make sure git users
get a CLI which makes sense and not dictated by history.

We already have enough people who complain that the git interface
design is hard to understand but which can't be changed because we
bias our UI design in favor of existing users as opposed new users.
Given that I'm an existing user, I'm actually not complaining, but I
do recognize the validity of the complaints that for example, git
reset does three different, mostly unrelated things.

Given that the existing scalar users are used to "scalar <foo>" and
not "git scalar <foo">, I'd gently suggest that it's better that there
be an existing compatibility program which translates "scalar <foo>"
to whatever git command(s) makes sense, as opposed to optimizing for
the simplicity of said program so that all forms of "scalar <foo>"
should get translated to "git scalar <foo>".

So for example, if we are inside a mono repro, it would seem to me
that "git commit" should automatically do the right thing, as opposed
to imposing cognitive load on the user to know when they are supposed
to type "git commit ..." versus "git scalar commit ..." versus "scalar
commit".

Please, let's design the UI for scalar integration into git with deep
sympathy for the users, and *not* the convenience of the compatibility
script for the existing scalar CLI users.

						- Ted
