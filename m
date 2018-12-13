Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_MIXED_ES,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594D420A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 20:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbeLMUod (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 15:44:33 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:35223 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMUod (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 15:44:33 -0500
Received: by mail-ed1-f44.google.com with SMTP id x30so3195578edx.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 12:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nODKiwJQJLsmxO0XTpfFJVQ5CXhNdRQxs4bXWrBFYUc=;
        b=j05fpHNKZ0+vjr8QXW7Y9AcEXz67Js7KSOnKcB+csIMDWks9a3wVitkyjuzv4lpuzd
         vOEldygtgYj/lVycMWPx39a24Q097X2WJ+AdhkeUj/fKjncmLQ8io70f+BAUjKUO3QsS
         E1Q7RRjy0mZUBN2zBX33F0/QBDWdNao2to3ZqUJR4V4Usu6g5go6rv0ZJjc20xoSvDMX
         8g6eQ/z6g8VNd4IDlo+stji9V6Hg9GszrXxeGZip2oYXicY83hXZZU0O+4rmmRLJAatF
         ZRI+yNlcRT29yC+z2WaZcq4EOsfNwPvXPKBOXupKL6Wb+jrBtfp/59/k4HJoj52pad26
         iGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nODKiwJQJLsmxO0XTpfFJVQ5CXhNdRQxs4bXWrBFYUc=;
        b=c35grjrYY6VqFy93Qo70QVeyPVKYAsfujPxcs4Fy6V7tTClRpStDMwbyusxDj8tkjL
         FQUYIs2SUlA3KgDQexwb0BdKnN+D5N4jJbRze/vj9Igg9ZB+DjlfA0TNUlCxZbfx2n01
         JLZCLXemeTh6Qzb6BMUn/VMlEiWmUUlRW35ssMzJKJj+7OV+6XeawNDHr9OcrMamlKpf
         0iDA++vOv/PSBmR87l+A3QCUJwTwKA3UF8FYy4xUmpMWY8iPafSxyXaKW1wug33c37cy
         RfWEdFm7Cmd1cRecRes2pss/GJedS1znO2uKYmAYKFkPtWJSYElxdE33PUVuiekhYisX
         CiWQ==
X-Gm-Message-State: AA+aEWaGk0+ScRi8f0mZIJm+NotSa/WdTKdMExlwOD5xLvhLYT/DUWVZ
        h/WEQ+ci99PjW2kOgP8yrl/oR4ATpk7vYPLZBbJlC7QZVT7Rzg==
X-Google-Smtp-Source: AFSGD/WX29YKgpA3JRNIjyYQfo93G3WraWWK54f5Gk1BQlknG1geEDnt3cUVCGa/ymLj73XcL73XMreIaY5fNgS+V6c=
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr614423edy.231.1544733870442;
 Thu, 13 Dec 2018 12:44:30 -0800 (PST)
MIME-Version: 1.0
References: <CAGZ79kYDa27EFk4A9uEzCnoW7scjb1U8fKwCo0P7rUZESto+Qg@mail.gmail.com>
 <20181211040839.17472-1-debian@onerussian.com> <20181211040839.17472-2-debian@onerussian.com>
 <CAGZ79kY17gmEh5Sawa+1fG5cXjOReOgCjDyEmGbbpJ5EE1APdw@mail.gmail.com> <20181213164217.GA4633@hopa.kiewit.dartmouth.edu>
In-Reply-To: <20181213164217.GA4633@hopa.kiewit.dartmouth.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Dec 2018 12:44:19 -0800
Message-ID: <CAGZ79kZb28bCvM7cOYHC4cpJWpA-3_gcbxS_g-rG0yy=9jXquw@mail.gmail.com>
Subject: Re: [PATCH 2/2] RF+ENH(TST): compare the entire list of submodule
 status --recursive to stay intact
To:     debian@onerussian.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 8:42 AM Yaroslav O Halchenko
<debian@onerussian.com> wrote:
>
> Thank you Stefan for the review and please pardon my delay with the
> reply, and sorry it got a bit too long by the end ;)
>
> On Wed, 12 Dec 2018, Stefan Beller wrote:
> > Thanks for the patches. The first patch looks good to me!
>
> Great!
>
> > > [PATCH 2/2] RF+ENH(TST): compare the entire list of submodule status --recursive to stay intact
>
> > The subject is a bit cryptic (specifically the first part before the
> > colon), maybe
>
> >   t7406: compare entire submodule status for --reset-hard mode
>
> > ?
>
>
> > > For submodule update --reset-hard the best test is comparison of the
> > > entire status as shown by submodule status --recursive.  Upon update
> > > --reset-hard we should get back to the original state, with all the
> > > branches being the same (no detached HEAD) and commits identical to
> > > original  (so no merges, new commits, etc).
>
> > "original state" can mean different things to different people. I'd think
> > we could be more precise:
>
> >    ... we should get to the state that the submodule is reset to the
> >     object id as the superprojects gitlink points at, irrespective of the
> >     submodule branch.
>
> ok, I will update the description.  But I wonder if there could be some
> short term to be used to describe the composite "git submodule status"
> and "git status" (refers to below ;)).
>
> > >  test_expect_success 'submodule update --merge staying on master' '
> > >         (cd super/submodule &&
> > > -         git reset --hard HEAD~1
> > > +        git reset --hard HEAD~1
>
> > unrelated white space change?
>
> I was tuning formatting to be uniform and I guess missed that this is in
> the other (not my) test.  I will revert that piece, thanks!

The tests in that file are not quite following the coding style that is
currently deemed the best. So if you want to clean that up
as a preparatory patch, feel welcome to do so. :-)
(c.f. t/t7400-submodule-basic.sh for good style, specifically
indentation by tabs and the cd <path> on its own line in
a subshell)
The latest style update I found is
80938c39e2 (pack-objects test: modernize style, 2018-10-30)
and submodule related test style
31158c7efc (t7410: update to new style, 2018-08-15)

So I was not opposed to have style changes, but to have
multiple unrelated things in one patch (feature work vs
cleanup).

> BTW -- should I just squash to PATCHes now?  I kept them separate primarily to
> show the use of those helpers:

That would make sense.

> compare_submodules_status  is already a compound action, so code would
> become quite more "loaded" if it is expanded, e.g. instead of
...
> it would become something like this I guess?
...
>          ! {git submodule status --recursive >actual &&

you could keep the status out of the negation.

>         test_i18ncmp expect actual;} &&
>          git submodule update --reset-hard submodule &&
>          {git submodule status --recursive >actual &&
>       test_i18ncmp expect actual;}
>         )
>
> IMHO a bit mouth full.  I was thinking also to extend compare_ with additional
> testing e.g. using "git status" since "git submodule status" does not care
> about untracked files etc.  For --reset-hard I would like to assure that it is
> not just some kind of a mixed reset leaving files behind.  That would make
> tests even more overloaded.

ok, that makes sense.

> On that point: Although I also like explicit calls at times, I also do
> like test fixtures as a concept to do more testing around the actual
> test-specific code block, thus minimizing boiler plate, which even if explicit
> makes code actually harder to grasp (at least to me).
>
> Since for the majority of the --reset-hard tests the fixture and test(s) are
> pretty much the same, actually ideally I would have liked to have
> something like this:
>
> test_expect_unchanged_submodule_status 'submodule update --reset-hard staying on master' \
>   super \
>   '(cd submodule && git reset --hard HEAD~1)' \
>   'git submodule update --reset-hard submodule'
>
> where I just pass
>   the path to work in,
>   the test setup function,
>   and the test action.
>
> The rest (initial cd, record, run setup, verify that there is a change, run
> action, verify there is no changes) is done by the
> test_expect_unchanged_submodule_status in a uniform way, absorbing all the
> boiler plate.  (I am not married to the name, could be more descriptive/generic
> may be)

The issue with submodules is that we're already deviating from the
'standard' git test suite at times (See the submodule test suite
lib-submodule-update.sh that is used via t1013, t2013 or t3906
and others).

I guess if we keep the test_expect_unchanged_submodule_status
as a file local function, it could be okay.

> Then we could breed a good number of tests with little to no boiler plate, with
> only relevant pieces and as extended as needed testing done by this
> test_expect_unchanged_submodule_status helper. e.g smth like
>
> test_expect_unchanged_submodule_status 'submodule update --reset-hard staying on master when I do a new commit' \
>   super \
>   '(cd submodule && git commit --allow-empty -m "new one"' \

In new tests we're a big fan of using -C, as that can save the
subshell, i.e. replace the whole line by

    git -C submodule commit --allow-empty -m "new one"'  &&


>   'git submodule update --reset-hard submodule'
>
> and kaboom -- we have a new test.  If we decide to test more -- just tune up
> test_expect_unchanged_submodule_status and done -- all the tests remain
> sufficiently prescribed.
>
> What do you think?

That is pretty cool. Maybe my gut reaction on the previous patch
also had to do with the numbers, i.e. having 2 extra function for
only having 2 tests more legible. A framework is definitely better
once we have more tests.

Stefan
