Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6441F597
	for <e@80x24.org>; Fri,  3 Aug 2018 20:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeHCWlM (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 18:41:12 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38861 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbeHCWlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 18:41:12 -0400
Received: by mail-yw1-f66.google.com with SMTP id r3-v6so1457674ywc.5
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mx4oO2TVF1M8yPWjpBeRHZQOAjEfwicvMDaXJpDLmkk=;
        b=vYzKl7Z9mqxbhZ8lS4Q/ThP1a3VIwOSLl0MsraQaFJUMnPY9p2vMSfEx7l4yQT+fLX
         jJ7j9pZk335GNXKvdbjlVLxqZICtBNUFMwfTFWXE6L4GHPzijGs43os9gJTaQlKzVMrw
         FRBzFMSiSC1XqvDLHNCrCOJSf7vMcIOeqai/QFc0M1QeDbSVUY6g3juRNGY9MYbxHIhg
         gsbOP3GGi2WGuek1ox4uyQGZILYqObxU8S2xABq8har+Ocx18nIQq3Rw48+3vNzt/+jS
         ZUaG64ON3sXbyVisBk5d0MvYIdLESVr8xFFhTSEtznrJxrlQZ3x3gIew7PpeGRJ+VN37
         3pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mx4oO2TVF1M8yPWjpBeRHZQOAjEfwicvMDaXJpDLmkk=;
        b=pHpGtkhL9bi8ESJDc7dSN4Nbszp4dqXtvdKENbh9+mZr6qFFVGX6zO4sENkJlHYYB3
         JXn5ypB1/jLWtYSjVtecqVgE1aApONLYMOuG/RsoxVOppJvRG9lUUEGZ+A+ZQW2FtGic
         SyKzsWH4arPKG+pukU+r37zt7WLmumamPMKW0i8j5o1BwO7n0TaQgaMjdPGD9yMONaXN
         oPVhretmV7f/WKSpxStJz2I+/qQLI1jCWoiLGXjaS5DedidZfszB/8WtUmW1f8C8ZmqP
         NW+9ZBId0e9khkZ6NMnQ2Bla0QVXrpuO7oz8rVt+ZcXQ4d6bzpR/VgDinVl9rOm6VjrZ
         e5Tg==
X-Gm-Message-State: AOUpUlGH/4RmU5jqRXmHN6wEQGv9I+1fZ85GxIU55JzSD05y70A7T9wP
        AjQF9PdJapLhlilrPabyCfwN1WpwBJW0rinhqR+3jg==
X-Google-Smtp-Source: AAOMgpcEMqt0FvXPUhEaxyR3Olt10aqirziro5Fr6rT48fFwV0Z2p9Vxukti4SG+B7XIwCbIVUt2hk6AU1of94J1JGc=
X-Received: by 2002:a81:ae41:: with SMTP id g1-v6mr2943174ywk.345.1533328998397;
 Fri, 03 Aug 2018 13:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com> <20180803180912.GD106068@genre.crustytoothpaste.net>
 <xmqqwot7wayf.fsf@gitster-ct.c.googlers.com> <20180803184508.GE106068@genre.crustytoothpaste.net>
 <xmqqo9ejwag9.fsf@gitster-ct.c.googlers.com> <xmqqk1p7wa7t.fsf@gitster-ct.c.googlers.com>
 <20180803193256.GA164578@google.com> <xmqqftzvw6xi.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftzvw6xi.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 3 Aug 2018 13:43:07 -0700
Message-ID: <CAGZ79kZdPP+q9iuQioUU+2JkfH4n1mkkHrXaJzxGVwhxvbKZ1Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 1:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Brandon Williams <bmwill@google.com> writes:
>
> > [1] https://public-inbox.org/git/CAGZ79kYGS4DvoetyGX01ciNrxxLCqgXoVSpLhmgYZ8B51LzhSg@mail.gmail.com/
> > This mail seems to counter that indicating that the "What's Cooking"
> > emails should not be used as a status update.
>
> You are the second one who were negatively affected by Stefan's
> "summary" that reads a lot more in what I said than what actually
> was said by me.  Stop paying attention to that message, but do go to
> the original if you want to hear what I actually said.

Please note that I put that one out to "in a deliberatly
outrageous way"[1] so that I get more arguments on why
this workflow is the best we have.

Personally I think the mailing list workflow could be improved
by having less manual work on your side.

That would (a) make the whole process from one end (of writing
the patch) to the other (of seeing its effect in a shipped binary
by a distribution) more transparent, as then DScho could build
his amlog consumer more easily for example.
And (b) it would be less work for you, though different work.
(i.e. instead of resolving conflicts yourself, you'd tell 2 people
to resolve conflicts between their series and you'd then fetch
from them; c.f. Linus lieutenants).

[1] https://public-inbox.org/git/xmqqo9ejwag9.fsf@gitster-ct.c.googlers.com/

I did miss the first person who was negatively affected?

> The mention of "discussion thread on the list is the authoritative"
> was said in the context where somebody refuted these "cf. <msg>" on
> a topic and I got an impression that it was done in the belief that
> doing so for each and every "cf. <msg>" would be enough to exonerate
> the topic of all the issues.  I was explaining that they were not
> meant to be exhaustive list, but rather are my personal reminder so
> that I can go back to the thread to recall why I said things like
> "Waiting for review to conclude", "expecting a reroll", etc.; as I
> do not need to point at all the review comments that matter for them
> to serve that purpose, these "cf. <msg>" must not be taken as the
> "clear these and you are home free" list.  To cover all the issues
> pointed out in the review process, you must go to the original.
>
> "What's cooking" primarily serves two purposes.
>
>  - After list of patches in a topic, I try to summarize what the
>    topic is about.  This is to become merge commit message for the
>    topic when it is merged to various integration branches, and also
>    to become an entry in the release notes.
>
>  - Then an immediate plan like "Will merge to 'next'", etc. for the
>    topic is announced, optionally with comments like "cf. <msg>" to
>    remind me why I chose to label the topic as such.
>
> The former is outside the topic of this thread, but both are *not*
> obviously written by everybody; the former is my attempt to
> summarize, and people are welcome to improve them.  If my attempted
> summary is way incorrect, that might be an indication that the
> topic, especially its log messages, is not clearly done.
>
> If my immediate plan contradicts the list concensus, it likely is an
> indication that I missed the discussion, and it is very much
> appreciated for those involved in the discussion to correct me.
> That may result in my dropping a "cf. <msg>" when an issue I thought
> to be blocking (or to require the topic to be fast-tracked) turns
> out to have been resolved already, or adding another one when it is
> pointed out to me that I missed an important issue to block (or
> fast-track) the topic.

Thanks for explaining the thoughts behind the cooking emails.

- The first part is very nice to have on the mailing list, but it is
  not strictly needed as you could just write the release notes
  and then people could send patches to the release notes as
  usual.

- The second part of having an immediate plan is *very* nice
  to see, though I would argue that it could be improved
  by having these updates in the thread instead of summarized
  unrelated to that thread.

  We do not do this for now due to tooling issues, I suppose.

  But I would think it makes the threads more discoverable if
  we'd have the status updates in each thread as then people
  would keep the discussion there and not jump on the cooking
  email to continue discussion there.

> Hope this clarifies a bit of the confusion caused by that summary.

I am sorry that this seems as if I would stir up the community
and cause troubles intentionally, but all I really want is a better
workflow process. And as I do not know what is better, I think out
loud trying to get a discussion going that point out things that are
good or bad.

Is there a better way to start a workflow discussion?

Thanks,
Stefan
