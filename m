Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68531CCA48D
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 20:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiGVUJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiGVUJB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 16:09:01 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20799A8777
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 13:08:58 -0700 (PDT)
Received: from host-78-147-187-217.as13285.net ([78.147.187.217] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oEyxE-0009Te-5z;
        Fri, 22 Jul 2022 21:08:57 +0100
Message-ID: <6426b5c3-0a09-f641-9876-3534b0abd96d@iee.email>
Date:   Fri, 22 Jul 2022 21:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Feature request: provide a persistent IDs on a commit
Content-Language: en-GB
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Susi <phill@thesusis.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stephen Finucane <stephen@that.guru>,
        Git Users <git@vger.kernel.org>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
 <87a692e8vj.fsf@vps.thesusis.net>
 <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/07/2022 19:58, Hilco Wijbenga wrote:
> On Thu, Jul 21, 2022 at 9:39 AM Phillip Susi <phill@thesusis.net> wrote:
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>> This has come up a bunch of times. I think that the thing git itself
>>> should be doing is to lean into the same notion that we use for tracking
>>> renames. I.e. we don't, we analyze history after-the-fact and spot the
>>> renames for you.
>> I've never been a big fan of that quality of git because it is
>> inherently unreliable.
> Indeed, which would be fine ... if there were a way to tell Git, "no
> this is not a rename" or "hey, you missed this rename" but there
> isn't.
>
> Reading previous messages, it seems like the
> after-the-fact-rename-heuristic makes the Git code simpler. That is a
> perfectly valid argument for not supporting "explicit" renames but I
> have seen several messages from which I inferred that rename handling
> was deemed a "solved problem". And _that_, at least in my experience,
> is definitely not the case.

Part of the rename problem is that there can be many different routes to
the same result, and often the route used isn't the one 'specified' by
those who wish a complicated rename process to have happened 'their
way', plus people forget to record what they actually did. Attempting to
capture what happened still results major gaps in the record.

It's nice to believe that in software we could perfectly capture the
copy/edit/rename processes between revisions, but with humans in the
loop it just doesn't work as planned.

Hence the value of Git is that it does record faithfully the end points,
and allows a moderately standardised way of viewing the perceived rename
process. It also removes the external attempts at 'control' of the
revision record that bedevil other approaches.

Philip
