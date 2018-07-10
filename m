Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 530461F85B
	for <e@80x24.org>; Tue, 10 Jul 2018 15:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934207AbeGJPmG (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 11:42:06 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38025 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933737AbeGJPmF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 11:42:05 -0400
Received: by mail-ua0-f195.google.com with SMTP id o11-v6so653527uak.5
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AVM8mRD2jkBbP9qFRUPRNI1WUfTU0ezjDXyZT+dAf94=;
        b=INE8qx7v8ONn5QfpSou+ldpFyK234lTqGqAMdNqymeWMj0IkAmCQLKO4BfXOPhmBz8
         3DxhMHbqCsB5/ZqtID6RcZcMwIRjXyMfOdGiOQPcK6PXpFr0tCvkCbi5MlreGr/aQj5f
         FwRQHr/LFy/X5hwPQN1pCAdaJXb4w7oPgfab+rXEbQqspfgpZSUa4Gc7cEQp7ND49z6P
         JKnAYxq6qhvme6qpE0BhVWIO4PXbBfgvkLZGHy/RyeqYVaniVS1Q7qfPcvkkcqlAbFHs
         DxeEDc/pyeNU6xGirbLq46ThiEoUjRPdQNTl5pdA5KyciMhVtCka0zU4FKJjrCuE22ZO
         Tb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AVM8mRD2jkBbP9qFRUPRNI1WUfTU0ezjDXyZT+dAf94=;
        b=dUUpUUczDQNBEZ3wBHpo/A3c0u6axGNpd5Aj93agaCOb2ytX3TsQP/d5Jct2cX1UWC
         7Fzkpacc9PEFuLbAL+RfFKpOrevo5lFFfDMZlKXXsE9tDNuIzfj6Qh+SwZY8Wq6DmQsS
         OaJv+qfywrEWUqcmg2471WbGlGUUMkzM5lBvSJnpb6W1x86lzFmQFeLC/R07lSg2DPVd
         ZV8wTqEDwnArboteSpGXBriRPLUqxfjr2CDzAg6qLRM+rq9NVwcg3xE+2uMHhpQZ8QNn
         A4zsjzOWBgnaxa1SHIrgabZATnecCjpn0uqYBOJbxF6Hj5hxWfQ7BP/MSMLV48i3Qlos
         iZWA==
X-Gm-Message-State: APt69E0+PjMUGgJBXgq7rDShiLuMbYRQCxliRH0ansUnlJSdtjBovPgx
        Vlz2pGxlept3HYYeVjgqFhCmSRjIuensC6uuA7U=
X-Google-Smtp-Source: AAOMgpc83NxUc/B8gZsJjDIAO79MstmlCP5KBujT6VlZsm0V35W+hUvfAjH/FuAecQyE2tLDnyyG+bT4PR8+Lfa7riU=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr15655065uaf.199.1531237324532;
 Tue, 10 Jul 2018 08:42:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:42:04
 -0700 (PDT)
In-Reply-To: <20180710044456.GA1870@sigill.intra.peff.net>
References: <xmqqr2kce1mw.fsf@gitster-ct.c.googlers.com> <20180709202229.10222-1-newren@gmail.com>
 <20180710044456.GA1870@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Jul 2018 08:42:04 -0700
Message-ID: <CABPp-BG5Rn=3MBS+daSJ+2rLsZWcswP3=8zX-F=5ncdzc9y=SQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add merge recursive testcases with undetected conflicts
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 9, 2018 at 9:44 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 09, 2018 at 01:22:29PM -0700, Elijah Newren wrote:
>
>> Oh, I didn't know about test-lint.  Is there a place that documents
>> the various checks you run, so I can avoid slowing you down?  Ones I
>> know about:
>>
>> Already documented:
>>   * `make DEVELOPER=1` (from CodingGuidelines)
>>   * running tests (from SubmittingPatches)
>>
>> Stuff I've seen you mention in emails over time:
>>   * linux/scripts/checkpatch.pl
>>   * git grep -e '\<inline\>' --and --not -e 'static inline' -- \*.h
>>   * make -C t/ test-lint
>
> test-lint is supposed to be run automatically as part of "make test" (or
> "make prove"), unless you've specifically disabled it by setting
> TEST_LINT. And it does complain for me with your patches. If it doesn't
> for you, then we have a bug to fix. :)

Oh, this may be my bad.  Years ago someone pointed out that the
testsuite could be run under 'prove', which provided nicer output and
made sure to run the longest tests (e.g. the horrifically slow
t9001-send-email.sh) first.  So my test alias is:

   time prove -j7 --timer --state failed,slow,save t[0-9]*.sh ::
"--root=/dev/shm"

(with possibly different -j settings on different machines) and I just
stopped running make test.  Didn't learn about the 'make prove'
target, even though it's apparently now been there for nearly 8 years.

> I won't be surprised, though, if you just ran "./t6036" manually before
> sending, since your patches literally didn't touch any other files.

That may also be true, though I would have missed it even if I had
code changes due to not being aware of 'make prove'.

> In theory we could push some of the linting down into the test scripts
> themselves (some of it, like the &&-linter, is there already by
> necessity). But it might also end up annoying, since usually dropping
> down to manual single-test runs means you're trying to debug something,
> and extra linting processes could get in the way.
>
>> Are there others?
>
> I like:
>
>   make SANITIZE=address,undefined test
>
> though it's pretty heavy-weight (but not nearly as much as valgrind).
> You probably also need BLK_SHA1=Yes, since the default DC_SHA1 has some
> unaligned loads that make UBSan complain. We should maybe teach the
> Makefile to do that by default.
>
> I've also been playing with clang's scan-build. It _did_ find a real bug
> recently, but it has a bunch of false positives.
>
> Stefan runs Coverity against pu periodically. IIRC It's a pain to run
> yourself, but the shared results can be mailed to you, or you can poke
> around at https://scan.coverity.com/projects/git. That _also_ has a ton
> of false positives, but it's good about cataloguing them so the periodic
> email usually just mentions the new ones.

Cool, thanks for the pointers.
