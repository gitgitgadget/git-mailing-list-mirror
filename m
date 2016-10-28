Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB7D20193
	for <e@80x24.org>; Fri, 28 Oct 2016 00:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943045AbcJ1A7j (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 20:59:39 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36510 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935453AbcJ1A7i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 20:59:38 -0400
Received: by mail-qk0-f179.google.com with SMTP id o68so69161543qkf.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 17:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5ZUr8DuuDHH88z5m20OoFfgquDlS9OERWCzcgPaiyPk=;
        b=n5aGvc1iBDYSyX8udACGVs1O4DPJWz0ekMmouJd6V+tfhB1wz1ob3kJjRr7k3jzP8w
         Id9YLgBuZFYT99zT/ToUAGCrv+pbRqysQ4bCOzG+rKZZSiGJitBDsGZqxRxyB26mek60
         /ShyrhY0URy/4zajgx77zLJEQ2l1NCj+4bZneGJMePdBntWZvcDg10usW9TK3BdjkyRf
         vQYRNkHETkaHMLCGSW8F0xWIl63dGcdiEPJWav2nVZIg7nr+lNJg305EfFnVlqrft6OY
         3qodPb2jErf5z6yAzpDpiC6IuoN0CfnvfYSKCmUzTLBOzl9PMaXqfM8Uf2cTZPWUhWXv
         f+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5ZUr8DuuDHH88z5m20OoFfgquDlS9OERWCzcgPaiyPk=;
        b=K7PeDfsPAsGdTxjgnti74/cIaLYnHHPYyGgZY/UlexPzXQBoZFlp8rnuqb5eJv4+Ru
         stujMcFE+xt+HnT47SfKB+tg9dWnmb4jN50TzBon6XEK+n25J2GZ1MZ6rAgoDa5MfLGQ
         uY3dKUpzY8flXdxNWEGT19Z0dsaf4t1QOz6BO5yNB+9WcGdH9u3ts6WV9wAd+ihZWlV7
         LbcWYteHTNLztZufjl+wZxGJsMokhMPyrJvaY9E/BBr/y9DtRYGkMWNQVWpyRIVHXZQT
         bleZVy8vFqYWYts1TmugvbZfrfYYudKgXNDEmoi108oPIFtQVEtXwSCSeTL6fNBNNWD2
         CeRA==
X-Gm-Message-State: ABUngveIzpK0qDlbcem5NdOkBTuUU34bFHpqP2aEWIHb6Wmxx+N1Hl79PxTI95nQCUI9PXkxiRb3KcDoWDkv8cee
X-Received: by 10.55.56.11 with SMTP id f11mr7990891qka.255.1477616376932;
 Thu, 27 Oct 2016 17:59:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 27 Oct 2016 17:59:36 -0700 (PDT)
In-Reply-To: <xmqqk2ct4bmr.fsf@gitster.mtv.corp.google.com>
References: <20161027223834.35312-1-bmwill@google.com> <xmqqk2ct4bmr.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Oct 2016 17:59:36 -0700
Message-ID: <CAGZ79kYm1txscyBpmfJQceCLFrZAN09y-2nV1zCjE2a1+_jrLA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] recursively grep across submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 4:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> As for the rest of the series, it should be ready for review or comments.
>
> Just a few brief comments, before reading the patches carefully.
>
>  * It is somewhat surprising that [1/5] is even needed (in other
>    words, I would have expected something like this to be already
>    there, and my knee-jerk reaction was "Heh, how does 'git status'
>    know how to show submodules that are and are not initialized
>    differently without this?"

The issue with much of the existing code is that it is submodule centric,
i.e. it is written to not care about the rest.

git status for example just calls "git submodule summary" to
parse and display the submodule information additionally.
It doesn't integrate submodules and treats them "just like files".

git submodule summary then proceeds to use "submodule--helper list"
that lists submodules *only* ignoring all files.

>
>    The implementation that reads from the config of the current
>    repository may be OK, but I actually would have expected that a
>    check would be "given a $path, check to see if $path/.git is
>    there and is a valid repository".  In a repository where the
>    submodules originate, there may not even be submodule.$name.url
>    entries there yet.

My reaction to 1/5 was that the implementation is sound,
but the design may need rethinking.

Instead of asking all these question, "Is a submodule
* initialized
* checked out (== have a working dir)
* have a .git dir (think of deleted submodules that keep the
  historical git dir around)
(* have commit X)
we would want to either extend the submodule-config API
to also carry these informations just like
name/path/sha1/url/shallow clone recommendation.

Obtaining the information above is however not as cheap,
because we'd need to do extra work additionally to parsing
the .gitmodules file. So the submodule-config would need to learn
an input that will tell the submodule-config what informations should
be evaluated and which can be omitted.

>
>  * It is somewhat surprising that [4/5] does not even use the
>    previous ls-files to find out the paths.  Also it is a bit
>    disappointing to see that the way processes are spawned and
>    managed does not share much with Stefan's earlier work, i.e.
>    run_processes_parallel().  I was somehow hoping that it can be
>    extended to support this use case, but apparently there aren't
>    much to be shared.

I think there are 2 issues here:
* The API I designed runs processes in parallel and the order or
  output is non-deterministic. git-grep uses threads and output is
  alphabetically sorted. The order is fixable though (by e.g. adding
  a flag that indicates which parallel processing output the caller
  wants).

* git-grep already has its own thread pool; integrating/combining
  2 worker pools doesn't sound trivial even to someone who wrote
  one of them.
  Maybe we could extend/rewrite the run_processes_parallel
  API to not just run processes, but instead you could also provide
  a function pointer that is used in a thread instead.
  Then we'd have one machinery that e.g. keeps track of the
  number of parallel processes/threads.

Thanks,
Stefan
