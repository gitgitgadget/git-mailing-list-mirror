Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620FCC5519F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 13:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCA0206F9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 13:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgKYNZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 08:25:14 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:54209 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbgKYNZO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 08:25:14 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1khunI-000AWw-3x; Wed, 25 Nov 2020 13:25:12 +0000
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is not
 set either
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?V=c3=adt_Ondruch?= <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
 <20201125020931.248427-2-alexhenrie24@gmail.com>
 <CAMP44s18Sd=DWMhFWCSDyGEz74ZKVF2kukr_=Exe1CjnPULCoA@mail.gmail.com>
 <CAMP44s3-fJ=mrYjGTW3AUACBmEhyrdD0dRktdaKHK9b1MTbk2A@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <67e55d85-63a4-9a47-e633-52b2ece23758@iee.email>
Date:   Wed, 25 Nov 2020 13:25:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAMP44s3-fJ=mrYjGTW3AUACBmEhyrdD0dRktdaKHK9b1MTbk2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/11/2020 03:47, Felipe Contreras wrote:
> On Tue, Nov 24, 2020 at 9:45 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Tue, Nov 24, 2020 at 8:14 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>>
>> Before making this the default we need a solution *right now* that is
>> a sane default.
> This mail was sent by mistake. I was going to say:
>
> We need a warning like:
>
>   The pull was not fast-forward, please either merge or rebase.
>
> When the default (pull.ff=only) is set.
>
> It is the current status that is more urgent to fix.
>

Maybe this could also, as an interim measure, be a doc change right in
the first paragraph of the `git pull --help` description section to warn
that its current default may not be suitable for most users, and to see
the `--ff-only` option (and variants) and its matching config variable.

e.g. "In its default mode, git pull uses the --ff option and is
shorthand for git fetch followed by git merge FETCH_HEAD. The --ff-only
option may be more suitable for modern usage. It can be set using `git
config pull.ff only`."
 (then once v3.0 arrives the discussion can be flipped)

It's worth making sure that the manuals are easy to read.

Philip
