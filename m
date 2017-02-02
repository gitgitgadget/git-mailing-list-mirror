Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335D81F4E2
	for <e@80x24.org>; Thu,  2 Feb 2017 19:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbdBBTOf (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 14:14:35 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33596 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdBBTOe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 14:14:34 -0500
Received: by mail-pg0-f68.google.com with SMTP id 194so2572114pgd.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 11:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E0+/b2DVTOFZ7d9WXXxM3z4/hP/0VZ/+cCmifClH6A8=;
        b=gJgFv9eobWEoY/sznlHebbuqsgsTCJOPB9exoJbq0fh/jIkqTeWqFzybS9CT0StjER
         1s25thjUxtgil5UDMWMgfBbX3X1PRcCTf5ta+sqrupy7g9Md+FUgZxIL3ID307QCwWxO
         benEr9xeBFaP0iQqy3CrEFSb9fs2j9qPVnPJPvi+Q/yrqkh/D4wnHsVTcw7pWEggbq/I
         8YqwcByiMbYDvgjnTzRSzHdMzi46TqjhQqTf1//nhM/Tbfbx6KsG7FfSXyX2j+fHVc56
         2UmAxGmI3WOIDEqa/EYFS2TnM/a0upqPU5S+ZOi3WvwMSau0/dyK8HxChiyqbR2x5cqV
         q2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E0+/b2DVTOFZ7d9WXXxM3z4/hP/0VZ/+cCmifClH6A8=;
        b=S3JeRV4zqR3+lE96QFsUgxhcFKplkFNlc7yTQN6zUPvbrzHbvU8hAEDU2zBYQ2X86Q
         08UcPNnXUlfEllUAJofwHxQqs4sWGkAbbPrWscuVDDoWaO/U1zJ8vpZ6ehuN+ZuLq3z9
         FxchgS8uucZZT5yLrJ5YBeFxFvTMD/1lCjXdo7ev0kg09T6s4nfosuFVLSGk5YM/L/Nv
         vUAwDoUsl+gisU+/QdCccZv1pY9w0mXtMNAXa0Y6GdSi0Re9VvqPNpOA2DJDuTHdWMJr
         UzlgMAqpTA+ZCAmVOJFCo2vez1MM+srNCLtuh/EfUwbyLu2lS3qsrmoPgJYHnv271wMi
         bXTA==
X-Gm-Message-State: AIkVDXJQre8DfLn7V71x2Y6cVaPt7FPL7x8YxxzCmZAp/IQi//2zvNi4p1SRE5+aMFTTKA==
X-Received: by 10.84.197.131 with SMTP id n3mr14664543pld.69.1486062873317;
        Thu, 02 Feb 2017 11:14:33 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:358d:de5e:fbec:baab])
        by smtp.gmail.com with ESMTPSA id 75sm60497575pfp.80.2017.02.02.11.14.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 11:14:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v3 00/27] Revamp the attribute system; another round
References: <20170123203525.185058-1-bmwill@google.com>
        <20170128020207.179015-1-bmwill@google.com>
Date:   Thu, 02 Feb 2017 11:14:30 -0800
In-Reply-To: <20170128020207.179015-1-bmwill@google.com> (Brandon Williams's
        message of "Fri, 27 Jan 2017 18:01:40 -0800")
Message-ID: <xmqqwpd8s8vd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Per some of the discussion online and off I locally broke up up the question
> and answer and I wasn't very thrilled with the outcome for a number of reasons.
>
> 1. The API is more complex....
> 2. Performance hit....
> ...
> Given the above, v3 is a reroll of the same design as in v2.  This is a good
> milestone in improving the attribute system as it achieves the goal of making
> the attribute subsystem thread-safe (ie multiple callers can be executing
> inside the attribute system at the same time) and will enable a future series
> to allow pathspec code to call into the attribute system.
>
> Most of the changes in this revision are cosmetic (variable renames, code
> movement, etc) but there was a memory leak that was also fixed.

I am OK with the patches presented in this round, but let me explain
why I still expect that we would eventually end up spliting the
question & answer into separate data structure before we can truly
go multi-threaded.

A typical application would do

	for path taken from some set:
		do_something(path)

and "do something with path" would be another helper function, which
may do

	do_something(path):
		ask 'text' attribute for the path
		switch on the attribute and do different things

With the original API, the latter would statically allocate an array
of <question, answer> pairs, with an optimization to populate
<question> which is immutable (because the codepath is always and
only interested in 'text' attribute, and you need a hash lookup to
intern the string "text" which costs cycles) only once, and make a
call to git_check_attr() function with the "path".  This obviously
will not work when two threads are calling this helper function, as
the threads both want their git_check_attr() to return their answers
to the array, but the <answer> part are shared between the threads.

A naive and inefficient way to split questions and answers is to
have two arrays, allocating the former statically (protected under a
mutex, of course) to avoid repeated cost of interning, while
allocating the latter (and some working area per invocation, like
the check_all_attr[]) dynamically and place it on stack or heap.
Because do_something() will be called number of times, the cost for
allocation and initialization of the <answer> part that is paid per
invocation will of course become very high.

We could in theory keep the original arrangement of having an
array of <question, answer> pairs and restructure the code to do:

	prepare the <question, answer> array
	for path taken from some set:
		do_something(the array, path)

That way, do_something() do not have to keep allocating,
initializing and destroying the array.

But after looking at the current set of codepaths, before coming to
the conclusion that we need to split the static part that is
specific to the callsite for git_check_attr() and the dynamic part
that is specific to the <callsite, thread> pair, I noticed that
typically the callers that can prepare the array before going into
the loop (which will eventually be spread across multiple threads)
are many levels away in the callchain, and they are not even aware
of what attributes are going to be requested in the leaf level
helper functions.  In other words, the approach to hoist "the
<question, answer> array" up in the callchain would not scale.  A
caller that loops over paths in the index and check them out does
not want to know (and we do not want to tell it) what exact
attributes are involved in the decision convert_to_working_tree()
makes for each path, for example.

So how would we split questions and answers in a way that is not
naive and inefficient?  

I envision that we would allow the attribute subsystem to keep track
of the dynamic part, which will receive the answers, holds working
area like check_all_attr[], and has the equivalent to the "attr
stack", indexed by <thread-id, callsite> pair (and the
identification of "callsite" can be done by using the address of the
static part, i.e. the array of questions that we initialize just
once when interning the list of attribute names for the first time).

The API to prepare and ask for attributes may look like:

	static struct attr_static_part Q;
	struct attr_dynamic_part *D;

	attr_check_init(&Q, "text", ...);
	D = git_attr_check(&Q, path);

where Q contains an array of interned attributes (i.e. questions)
and other immutable things that is unique to this callsite, but can
be shared across multiple threads asking the same question from
here.  As an internal implementation detail, it probably will have a
mutex to make sure that init will run only once.

Then the implementation of git_attr_check(&Q, path) would be:

    - see if there is already the "dynaic part" allocated for the
      current thread asking the question Q.  If there is not,
      allocate one and remember it, so that it can be reused in
      later calls by the same thread; if there is, use that existing
      one.

    - reinitialize the "dynamic part" as needed, e.g. clear the
      equivalent to check_all_attr[], adjust the equivalent to
      attr_stack for the current path, etc.  Just like the current
      code optimizes for the case where the entire program (a single
      thread) will ask the same question for paths in traversal
      order (i.e. falling in the same directory), this will optimize
      for the access pattern where each thread asks the same
      question for paths in its traversal order.

    - do what the current collect_some_attrs() thing does.

And this hopefully won't be as costly as the naive and inefficient
one.

The reason why I was pushing hard to split the static part and the
dynamic part in our redesign of the API is primarily because I
didn't want to update the API callers twice.  But I'd imagine that
your v3 (and your earlier "do not discard attr stack, but keep them
around, holding their tips in a hashmap for quick reuse") would at
least lay the foundation for the eventual shape of the API, let's
bite the bullet and accept that we will need to update the callers
again anyway.

Thanks.

