Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BEFC2092F
	for <e@80x24.org>; Tue,  3 Jan 2017 18:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760288AbdACSPm (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:15:42 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34971 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbdACSPk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:15:40 -0500
Received: by mail-qt0-f180.google.com with SMTP id c47so469898233qtc.2
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x1uUmuBpThIpkwGYVdmRnA5oYFE2ZnA7CiX7S3+wdM8=;
        b=qiFwCH0cSDN1T9yfq9Ad+8NkudFwT0HG+LxVkv2InVAF1S7TB/GA4tptoSosMnFU6+
         A8H9Rr4lEWGLFGWn25X7CcR7993LYM+OJV8vsDKshKmqckcH+hH7YRlleQWxe8qN+t3p
         X2fW+HdSdT0gzGKzknsveBrYISlZJSIr/CVaSKGYDVxFsHUmWucgZ4sFJyukWHExVcAY
         W1C7isDaYlIlEUWovDv2ZWkikb3OzIhIKndzClyvizG+puoizo31ke7Nnn690xQ5M3Ln
         +HztrFNdMWIcc1qeJnjuiOyF3g2XPqMK+ZWOG8h1xPog6JwKrPbxkJV2R47aHBcvrNcM
         ZeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x1uUmuBpThIpkwGYVdmRnA5oYFE2ZnA7CiX7S3+wdM8=;
        b=imQYzJ8syasBAV65PfbOTNBVeKPfHyaUCRpH0bbkc61u9F8zqrBmmzIq8twQaCqmPG
         6kapjR0ck9ixjMbDmxNMJuSeiHajiOQjpToELyafDi/dDfC6ZjGbnE0gGQtoWfKeE9e7
         iMulguabnmTpgfO1mT1sFpyJVjMfOWfEAMhwzFW2/6PHEL7Co3KKAFIFnQusUWpsYBbB
         5HHe9nQCAMHiApqIP3z7CB16b6r1+521br5gpf899wWvwFKOXauG5ZQ29SBYPHk0VL6W
         6r/769mo5lPImp4a/v9I+U6AXAJSZkIVjW38/ySgQD4TcrQ/XdTfIVdkVfW4nVTcGXDS
         lo2A==
X-Gm-Message-State: AIkVDXLsZomgXupAi76M5O9upAPdH9mHpHeAJEktdfHgBYLVHWehEq91U3PvEWa2B0+dDyVbe7KyUWMX+EqTKCVU
X-Received: by 10.200.44.217 with SMTP id 25mr54504471qtx.176.1483467339239;
 Tue, 03 Jan 2017 10:15:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 3 Jan 2017 10:15:38 -0800 (PST)
In-Reply-To: <xmqqh95j60uh.fsf@gitster.mtv.corp.google.com>
References: <20161229192908.32633-1-sbeller@google.com> <xmqqh95j60uh.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Jan 2017 10:15:38 -0800
Message-ID: <CAGZ79kZ5F46UzeNeVYQV1EKEEa6+az-Pe_jrT+wZF9X6b34CGA@mail.gmail.com>
Subject: Re: [PATCH] pathspec: give better message for submodule related
 pathspec error
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Every once in a while someone complains to the mailing list to have
>> run into this weird assertion[1].
>>
>> The usual response from the mailing list is link to old discussions[2],
>> and acknowledging the problem stating it is known.
>>
>> For now just improve the user visible error message.
>
> Thans. judging from the date: header I take this is meant as v3 that
> supersedes v2 done on Wednesday.

Yes, that is correct. Sorry for being sloppy not numbering the
patches correctly.

>
> It is not clear in the above that what this thing is.  Given that we
> are de-asserting it, is the early part of the new code diagnosing an
> end-user error (i.e. you gave me a pathspec but that extends into a
> submodule which is a no-no)?  The "was a submodule issue" comment
> added is "this is an end-user mistake, there is nothing to fix in
> the code"?

This is not a fix in the code, but purely improving an error message.
So far anytime someone run into this assert, it was related to submodules.
I do not know the pathspec code well enough to claim this condition
can be produced via submodules *only*, though.

So I proposed a more defensive patch, which diagnoses if it is the
"no-no, pathspec extends into a submodule" first and then throws
a generic error afterwards in case it is not the submodule issue.

> I take that the new "BUG" thing tells the Git developers that no
> sane codepath should throw an pathspec_item that satisfies the
> condition of the if() statement for non-submodules?

If we want to keep the semantics of the assert around, then we
have to have a blank statement if the submodule error message
is not triggered.

I assume if we print this BUG, then there is an actual bug.

>
>> diff --git a/pathspec.c b/pathspec.c
>> index 22ca74a126..b446d79615 100644
>> --- a/pathspec.c
>> +++ b/pathspec.c
>> @@ -313,8 +313,23 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>>       }
>>
>>       /* sanity checks, pathspec matchers assume these are sane */
>> -     assert(item->nowildcard_len <= item->len &&
>> -            item->prefix         <= item->len);
>> +     if (item->nowildcard_len > item->len ||
>> +         item->prefix         > item->len) {
>> +             /* Historically this always was a submodule issue */
>> +             for (i = 0; i < active_nr; i++) {
>> +                     struct cache_entry *ce = active_cache[i];
>> +                     int ce_len = ce_namelen(ce);
>> +                     int len = ce_len < item->len ? ce_len : item->len;
>> +                     if (!S_ISGITLINK(ce->ce_mode))
>> +                             continue;
>
> Computation of ce_len and len are better done after this check, no?

Yes, though I trusted the modern-day-compilers to get it right. Will
fix in a reroll.

>> +test_expect_success 'setup a submodule' '
>> +     test_commit 1 &&
>> +     git submodule add ./ sub &&
>
> Is this adding our own project as its submodule?

Yes it is.

>
> It MIGHT be a handy hack when writing a test, but let's stop doing
> that insanity.

I agree that this is not a good idea.

>  No sane project does that in real life, doesn't it?

If such a project was cloned with submodules, it would recurse endlessly. :)

> Create a subdirectory, make it a repository, have a commit there and
> bind that as our own submodule.  That would be a more normal way to
> start your own superproject and its submodule pair if they originate
> together at the same place.

I wonder if we want to have a helper function in test-lib.sh to be used
for that. This use case (have a repository and a submodule) happens in
a lot of tests, so we could make life easier by providing a function
in the library so it is even easier than this HACK.

> Better yet create a separate repository, have a commit there, and
> then pull it in with "git submodule add && git submodule init" into
> our repository.  That would be the normal way to borrow somebody
> else's project as a part of your own superproject.

The library function could do that, yes.

Thanks,
Stefan
