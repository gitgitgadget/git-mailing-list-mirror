Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9EC71F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 10:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCXKjH (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 06:39:07 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:45612 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeCXKjF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 06:39:05 -0400
Received: by mail-io0-f170.google.com with SMTP id 141so17975400iou.12
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 03:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UY9Sgp0gbUdzi/z2tOidjdQUMvUwdct11DtzHIN4As4=;
        b=KXNQTegPg+gTXwGs/mqg4AT0fBDj0RiPnmBDyHyM0XvfV2T/teyPtDjavNsazbzZEP
         CfT6VNbLNHACD/nNQ0XRcNqzWE/U2PlcRO+71xUjqWc0ZTpjy4w6LK05u5oH26loqUq7
         ju1apn7sG2u3srrhrlU/jtCr8byhUnGA0I5yllQPXxElxUEetGhn0HduqLPjxNw9TOOl
         pBLVsdNNiAaIhY9WZ8afX3pAVQcereO8tU0UzBdRAMHTBVO7P6Na0qG3NmDXqMpZVV1Q
         FOmdlKeGodvRvPws6WeLejUgfqtD9mOfRMqq8GbelnYiGkQc6XLU60Hdo1C0/a4TW1sp
         TdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UY9Sgp0gbUdzi/z2tOidjdQUMvUwdct11DtzHIN4As4=;
        b=FKCX0Ny4t1O54TDMfDQ81MSs7EOJ/wkk0awy3JKomVPo61vQJOsRjAvlXMtB4npjDd
         /U7PUkf0g/eokElU/Nikz6/9epWAiiKIsPx68oxo1+60rJsUhlEITfP4LKcBrK9R5n3s
         vXkUhK9gTd02qCOgSaZiFOQl/LJ+fQVdOZixv6P0dxZfvm989YD7F4cHmAkFowTmW6X5
         vp+5xbeT+krr8FOxZF2zQK6AjBOmMU3fJe3xpq/CDcLQObueJmr+mHmSEvOS1nIpdrd5
         ISQzfHAATUg5RJZWg2ILm4VDKQA/TmgzIAmmH/OZf3QrDtW17OH+9+qO63UksD9Lsikq
         mu+w==
X-Gm-Message-State: AElRT7GF3DH40D4vMZ3EoYhkualia1bqta3+/aWP3rPlj9SAxT+ECvRX
        +5eH7fr2l3kUAX7Wzxd6PkhUabWGHyLDlGT3kNU=
X-Google-Smtp-Source: AG47ELtT2lrI+hjPAvhEpIp3orvsUV1OOMoipe5eD2z8jAWggx0YraHGfUjZGXehHQJZuhkjs50QkaQLgcbofmYfRkU=
X-Received: by 10.107.93.20 with SMTP id r20mr32551346iob.53.1521887944507;
 Sat, 24 Mar 2018 03:39:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sat, 24 Mar 2018 03:39:03 -0700 (PDT)
In-Reply-To: <20180321061605.27814-1-predatoramigo@gmail.com>
References: <nycvar.QRO.7.76.6.1803201616290.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180321061605.27814-1-predatoramigo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 24 Mar 2018 11:39:03 +0100
Message-ID: <CAP8UFD2k6ROC51zHob+HnqqKL0fgM=xLgUk3LmOJTTEuoHBijQ@mail.gmail.com>
Subject: Re: [RFC] [GSoC] Project proposal: convert scripts to builtins
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Mar 21, 2018 at 7:16 AM, Pratik Karki <predatoramigo@gmail.com> wrote:
>
> Thanks for the feedback. Thanks to you, I realized my proposal was
> a bit ambitious. Both git-stash and git-rebase are big
> commitment. After much analyzing, I found out I cannot complete
> both in the given time frame. So, I decided to stick to one and
> complete it.

Great.

[...]

> There has been some development in `git-stash` as seen on
> [<https://public-inbox.org/git/20171110231314.30711-1-joel@teichroeb.net/>]
> (https://public-inbox.org/git/20171110231314.30711-1-joel@teichroeb.net/).
> To maximize the productivity, the findings from the patch submitted can
> be used. Since, there are already much discussions regarding the
> rewrite.

In general it would be nice if you summarized what has already been
done, how you can reuse it and what is needed to complete it.

I see that you talk about some of that below, but a more general
overview might be nice too.

It could be interesting also to put the author(s) of the work that you
will reuse in Cc.

[...]

> Timeline and Development Cycle
> ------------------------------
>
> -   Apr 23: Accepted student proposals announced.
>
> -   Apr 23 onwards: Researching of all the test suites. Discussion of
>     possible test improvements in for `git-stash`.
>
>     Firstly, the test suite coverage of every command will be reviewed
>     using gcov and kcov.

I don't think it is necessary to spend a lot of time on the test suite coverage.

> The test suite might not be perfect or
>     comprehensive but must cover all the major code paths and
>     command-line switches of the script. For the tests which seem
>     inadequate, minimum required tests are written and developed
>     incrementally. The minimum tests must provide safety net for
>     migration of scripts to built-ins. The tests would be sent as a
>     separate patch for parallel development and review process so that
>     development of built-ins can happen at the same time productively.

Nice.

>     The tests will be written for every code changes and will be worked
>     throughout the summer.
>
> -   May 1: Rewriting skeleton begins.
>
>     The shell scripts are translated on a line-by-line basis into C
>     code. The C code will be written in a way to maximize the use of git
>     internal API. In git-stash `parse-options` API can be used for
>     implementing parsing argument of command-line. This would be way
>     better than parsing via the scripts. Firstly, I will start
>     implementing `stash --helper`from respective scripts to C code. Then
>     increment it further more. Then I'll start converting git-stash.sh
>     on a line-by-line basis.

Not sure what you mean by line-by-line basis.

>      Again for git-stash some work seem to be done
>     [<https://public-inbox.org/git/20171110231314.30711-1-joel@teichroeb.net/>]
>     (https://public-inbox.org/git/20171110231314.30711-1-joel@teichroeb.net/).
>     Now, to maximize the output I'll be taking findings from the
>     previous patch and use it for my patch. As seen from the comments in
>     the patch some tests for checking branch when `git stash branch`
>     fails needs to be written.

Nice. Maybe writing those tests can come earlier in you schedule.

> New tests will be written and code
>     coverage tools will be used for the written code.

Not sure that code coverage tools need to be used.

> -   May 13: Making minimal `builtin/stash.c` with `stash--helper` ready
>     for review process. (This goes on for some time.)
>
>     The initial review of minimal builtin would be ready for git-stash.
>     The result C code at this stage may not be necessarily be efficient
>     but would be free from obvious bugs and can serve as a baseline for
>     the final patch. This is sent for review process which can take some
>     time. The code will ofcourse be tested using the test suite with
>     some additional tests.

How does that relates with the existing work? Will this be one or
several patch series? What will each patch do?

[...]

> -   June 10 - Jul 20: Start optimizing `builtin/stash.c`. Benchmarking
>     and profiling is done. They are exclusively compared to their
>     original shell scripts, to check whether they are more performant or
>     not and the results are published in the mailing list for further
>     discussion.

Will the performance tests be added to the t/perf tests?

> The C code will be optimized for speed and efficiency in this stage. The
> built-ins will now be profiled using the new efficient test suites to
> find hot spots. Bench-marking is also done in comparison to original
> scripts.The performance for stash can be measured by making it stash
> large number of changes in another working directory and measuring the
> time for completion of the task. After finding out, a graphical
> representation of performance findings will be published to git mailing
> list and discussions will commence on more optimization.
>
> -   Jul 20 - Aug 5: More optimizing and polishing of `builtin/stash.c`
>     and further polishing of tests series written and send them for code
>     review.
>
> After discussions with the git community, optimization is done further
> and the code and tests at this stage are polished for final submissions.

Often there is not much time for optimization and a lot more time is
spent on improving the structure of the patch series and the patch
themselves through many review rounds. We also expect that many of the
early patch series have been already polished and submitted many times
before the last weeks of the GSoC.

[...]

> -   Apr 24 - Aug 14: Documentation is written.

What kind of documentation is that? In the Git project we expect that
the documentation for the work done comes with the work itself. It can
be in the form of the cover letter of a patch series, or the commit
messages of the patches that are sent to the mailing list, or in
patches that change files in Documentation/.

> "What I'm working on" is
>     written and posted in my blog regarding GSoC with Git.
>
>     The documentation of the code written is done in the whole summer.
>     Additionally, a blog series will be written in a weekly basis of my
>     current findings and will write about "What I'm working on" to
>     further provide information about my development of summer project.

Nice.

> About me
> --------
>
> I'm Pratik Karki and am studing bachelors in Computer Engineering in
> Advanced College of Engineering and Management (Affiliated to Institue
> of Engineering, Tribhuvan University). I've been writing C, C++, Ruby,
> Perl, Clojure, Lisp, Java, JS, Erlang, Rust for 3 years, and contributed
> to some projects which can be seen in
> [Github](https://github.com/prertik). I've been doing independent
> contract works for small upcoming start-ups in Nepal.
> I have been planning to contribute in Git for a long time. Thanks, to
> GSoC I've submitted small patch as a microproject: [test: avoid pipes in
> git related commands for test
> suite](https://public-inbox.org/git/20180319173204.31952-1-predatoramigo@gmail.com/).
> I am looking forward to submitting more patches to Git on a long time
> basis.

Thanks.
