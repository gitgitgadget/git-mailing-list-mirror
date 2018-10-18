Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFCD81F453
	for <e@80x24.org>; Thu, 18 Oct 2018 23:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJSH0w (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 03:26:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33038 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJSH0w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 03:26:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id l14-v6so20836675edq.0
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 16:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2ie+lalkS1jUoCT+w3VkWWlAEnkqbaVa1wLAA+ijqs=;
        b=qAv5d36b1JOxD5JjCmrh64db7/7Y5j+a4uQwpM008GXvpCroQSVGGRjHjJQiLOvvgq
         CQNa1xyi3UVWXrY/F3Qv4L8ftP4SSlJgMmrgDCHumTXjaI0l2FYg58thz/zUAWHPgZXI
         tdL8yEv3g4+uPEul8G1TKLHQxrQFgtVFFhyLKAIf+ocZjkrWMc2WGi7yY195Wq/ZV38O
         puYFfqu9f+HoOKvpg2ZYpJYCappiO427xZrS1gY8iS5+ie9Y414fNeizxAMq7c0Puabr
         suF/VgKIfAyjKiNvMIwbFpYiLYZ/x7HnE3t5s3dmW7oefvY4uNr2VCgsut9NyJBtblIP
         Pp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2ie+lalkS1jUoCT+w3VkWWlAEnkqbaVa1wLAA+ijqs=;
        b=pc/yUmDwXIDJNAy/oesO6C0gWvrmGVZLnXVZQekx09ZUb7uearuqwrLhc5/oEulVoW
         dpOsepRB7nNY1K/U+ZsMc+aBFbUT4uvMcJSA5TdllcEfMZkgFmaZcuEc/SsYSUeVBbVR
         T+5kc8IaTKKgOYY2mB+2nFYU+sxGHiUma4oLFy8JCDL+T3DCeOA+S3WAAUkdUWcOnrpr
         2JUKQHc6ZbL8xuIE59jxFAV6+2tsGGx5Tc7TUezVEMjfkVlnKozVovtzBa6c4BdKUeQW
         Qah7+2KHdlyVf6yVwmU+sadGoPS2WOiGxm5m0ExYQVtXD01HBFC72asCiDn77eU336B5
         PUrQ==
X-Gm-Message-State: ABuFfoiDUQu++Ja0MtXL9YF/b8/btWPYF/r6/IzWilkwHTySMMEuv6HR
        ATWFJQHzvelNLzTA5cfkBwBWno3HVMXKjf29+m6x6A==
X-Google-Smtp-Source: ACcGV63sd3vSRkiPpDa5vHkMc74vFinInu5U74GwyYkvZyMAQDE27SzeQCemCI/s1S7z4Xdu3owPdwk0d36JBGZEgY4=
X-Received: by 2002:a50:9931:: with SMTP id k46-v6mr4642012edb.85.1539905014649;
 Thu, 18 Oct 2018 16:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181018183758.81186-1-sbeller@google.com> <20181018210119.149727-1-jonathantanmy@google.com>
In-Reply-To: <20181018210119.149727-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Oct 2018 16:23:23 -0700
Message-ID: <CAGZ79kZ8ER_EkuAySzvybg1Y35MtjHPEU-AS9zhCivw==+RyiA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Bring the_repository into cmd_foo
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 2:01 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > > Or instead we could accelerate the long term plan of removing a
> > > hard coded the_repository and have each cmd builtin take an additional
> > > repository pointer from the init code, such that we'd bring all of Git to
> > > work on arbitrary repositories. Then the standard test suite should be
> > > okay, as there is no special case for the_repository any more.
> >
> > Demo'd in this RFC series for git-merge-base.
> >
> > The core idea is found in patch 1,
> > and the proof of concept is found in patch 2.
>
> I don't think working around the_repository is sufficient, as there are
> other ways to access the same repository state (the_index, directly
> accessing files through file I/O).

Sure, but that would stick out like a sore thumb?

> Instead I would prefer a test like in
> t/test-repository.c - each patch set would probably only need one test
> for the last function converted, since typically the last function uses
> every other function converted.

I'll look into that.

>
> Also, even if we decided that working around the_repository is
> sufficient, I don't think this get_the_repository() is a good approach.
> If (or when) we decide to convert all builtins to not use
> the_repository, we would have to clean up all such calls.

Just like we have to cleanup the calls to the_repository or the_index
in general now (c.f. nd/the-index)

> Better would be to pass the_repository from the invoker of the cmd
> builtin, and reuse NO_THE_REPOSITORY_COMPATIBILITY_MACROS in the
> builtin. (I haven't thought much about how to transition to this, but
> one way might be to extend "struct cmd_struct" in git.c to also have a
> new-style function pointer, and #define GIT_CMD(c, f, o) {c, NULL, o, f}
> or something like that.)

This sounds like the next step to me.

> This doesn't directly address the fact that the builtin might call lib
> code that indirectly references the_repository, but I think that this
> won't be an issue because by the time we're ready to convert builtins to
> not use the_repository, most if not all of the lib code would have
> NO_THE_REPOSITORY_COMPATIBILITY_MACROS defined anyway.

And until then we double up on tests, one time the regular end-to-end tests
and additional tests for repository agnostic units in test-repository.c ?

The whole point of this approach is to keep the testing at the level
that we currently have and make the tests more powerful in doubling
for both (a) testing existing behavior, (b) getting fairly good coverage
of repository-fication of the code base by these 2 simple knobs.
