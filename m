Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA0F1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 22:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeJKFkz (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:40:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34273 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeJKFky (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:40:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so6405799eds.1
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 15:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=mu3KAdScN/FVTOuA6u2QMEF92R9XRu9wgPxB1E0rP1I=;
        b=tDxrP8kS3xeDxd2FVNMk5N4XIvs4Mr336Abg+5xnDnbNcodcbpZKZjuvBGGD97zFBf
         HDF+OknrulR1So5iz8TAQvaM/Iykp8nJH7DUjPhMiyT+Q9Lp1Xdj1taoy6bf17kVU+X7
         kPtmHcRcN/bN3kxvikvDjbcLnPbgfxY679FChWkEpaBQ2mSAowYTij3ah70Y7ScmqC5u
         /8DwPbDN7AarSlzz3K/pyosqTV7L8kemmFZ0Uc1XKsDlqqkeh6UtBwrBxCXL86hE96SM
         +rumhc22D9eO/5PAxXw4mctUpFYn039dKJ714jmJS6XjYp9w/mPBn054gao7v0dqXS6p
         oTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=mu3KAdScN/FVTOuA6u2QMEF92R9XRu9wgPxB1E0rP1I=;
        b=rMK4emyq+FHKSbXpPyZdz2vs+dq+0fek/rNcKD/zA0DDr14kPLDCwObG6hd0VM3Tn7
         i0+wvAnpzOj6MiIrhqY1Hzf4va9oCaczMl8SEgvgmP1u2Bt2U/5VyvUhrDiwm4iocySC
         8tYAU6Z3/JSIVuMUF5JNoz5lAoDFxX4hJNrr3ua6DaIPmciy59Ozv4gTaiZfcCAqBJqb
         rCu4dxn/F1UTNEIdffohg2kbhD4m2kLh0RqNwhojk/QEhMA4yUMltxKhMyCNyLFja0hw
         dnE6HqugW6gaV012B7braWETZo9yX8umkgLcUZx5g7uFxGWWwyBebvgiR5uVUBnQ2cxK
         qK3Q==
X-Gm-Message-State: ABuFfojddIwkZ0YbHS/6deEhhcsAOH6CW/+sBPzy+c/S3X/89L84huFE
        DMnl+Cy4vkc4tQzxT+DFnoX1CJlmtwI=
X-Google-Smtp-Source: ACcGV63yfyrgZPhadWqq4Q2xsKFGUoE3lkCq0xGBrPHrO/oyZN/YYwXWe8qQzJjC1GDzIBX30XGySA==
X-Received: by 2002:a50:d596:: with SMTP id v22-v6mr43854139edi.226.1539209802917;
        Wed, 10 Oct 2018 15:16:42 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id x14-v6sm8087938edb.84.2018.10.10.15.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 15:16:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: introduce an --auto-exit-code option for undoing 3029970275
References: <20181010174624.GC8786@sigill.intra.peff.net>
        <20181010192732.13918-1-avarab@gmail.com>
        <20181010205611.GA195252@aiede.svl.corp.google.com>
        <87sh1declw.fsf@evledraar.gmail.com>
        <20181010211428.GA231512@aiede.svl.corp.google.com>
        <xmqqin29lc0s.fsf@gitster-ct.c.googlers.com>
        <20181010215143.GB231512@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181010215143.GB231512@aiede.svl.corp.google.com>
Date:   Thu, 11 Oct 2018 00:16:40 +0200
Message-ID: <87o9c1e9br.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Jonathan Nieder wrote:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Perhaps this reporting could also print the message from a previous
>>> run, so you could write:
>>>
>>> 	git gc --detached-status || exit
>>> 	git gc --auto; # perhaps also passing --detach
>>>
>>> (Names still open for bikeshedding.)
>>
>> When the command is given --detached-exit-code/status option, what
>> does it do?  Does it perform the "did an earlier run left gc.log?"
>> and report the result and nothing else?  In other words, is it a
>> pure replacement for "test -e .git/gc.log"?
>
> My intent was the latter.  In other words, in the idiom
>
> 	do_something_async &
> 	... a lot of time passes ...
> 	wait
>
> it is something like the replacement for "wait".
>
> More precisely,
>
> 	git gc --detached-status || exit
>
> would mean something like
>
> 	if test -e .git/gc.log	# Error from previous gc --detach?
> 	then
> 		cat >&2 .git/gc.log	# Report the error.
> 		exit 1
> 	fi
>
>>                                              Or does it do some of
>> the "auto-gc" prep logic like guestimating loose object count and
>> have that also in its exit status (e.g. "from the gc.log left
>> behind, we know that we failed to reduce loose object count down
>> sufficiently after finding there are more than 6700 earlier, but now
>> we do not have that many loose object, so there is nothing to
>> complain about the presence of gc.log")?
>
> Depending on the use case, a user might want to avoid losing
> information about the results of a previous "git gc --detach" run,
> even if they no longer apply.  For example, a user might want to
> collect the error message for monitoring or later log analysis, to
> track down intermittent gc errors that go away on their own.
>
> A separate possible use case might be a
>
> 	git gc --needs-auto-gc
>
> command that detects whether an auto gc is needed.  With that, a
> caller that only wants to learn about errors if auto gc is needed
> could run
>
> 	if git gc --needs-auto-gc
> 	then
> 		git gc --detached-status || exit
> 	fi
>
>> I am bad at naming myself, but worse at guessing what others meant
>> with a new thing that was given a new name whose name is fuzzy,
>> so... ;-)
>
> No problem.  I'm mostly trying to tease out more details about the use
> case.

Likewise, so don't take the following as an assertion of fact, but more
of a fact-finding mission:

We could add something like this --detached-status / --needs-auto-gc,
but I don't need it, and frankly I can't think of a reason for why
anyone would want to use these.

The entire point of having gc --auto in the first place is that you
don't care when exactly GC happens, you're happy with whenever git
decides it's needed.

So why would anyone need a --needs-auto-gc? If your criteria for doing
GC exactly matches that of gc --auto then ... you just run gc --auto, if
it isn't (e.g. if you're using Microsoft's Windows repo) you're not
using gc --auto in the first place, and neither --needs-auto-gc nor
--auto is useful to you.

So maybe I'm missing something here, but a --needs-auto-gc just seems
like a gratuitous exposure of an internal implementation detail whose
only actionable result is doing what we're doing with "gc --auto" now,
i.e. just run gc.

Which is what I'm doing by running "gc --auto" across a set of servers
and looking at the exit code. If it's been failing I get an error, if
there's no need to gc nothing happens, and if it hasn't been failing and
it just so happens that it's time to GC then fine, now was as good a
time as any.

So if we assume that for the sake of argument there's no point in a
--detached-status either. My only reason for ever caring about that
status is when I run "gc --auto" and it says it can't fork() itself so
it fails. Since I'm using "gc --auto" I have zero reason to even ask
that question unless I'm OK with kicking off a gc run as a side-effect,
so why split up the two? It just introduces a race condition for no
benefit.
