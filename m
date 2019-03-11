Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCDCD20248
	for <e@80x24.org>; Mon, 11 Mar 2019 15:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfCKPes (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 11:34:48 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:45505 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfCKPes (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 11:34:48 -0400
Received: by mail-vs1-f50.google.com with SMTP id n14so2954529vsp.12
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x56mkxZt/tjR8JPaSr3AhxFFsUsEiZvsS2Om37+dXVc=;
        b=Q7FJyr5idNrYRRwX8J+VsJ54DzKmsVhchlHUeT1mc3OxVSe4k07omU6WzvLs/qgb3K
         aj2ntjWam2N7T2Wgf0lpmuT9oSM/fee8ETuddoi6AT1N18RFGAdxGi03yNH0xZBGWUzc
         Zf4Lj6cgj9YtUeUNGbL2y9cd65+0H5WDGXLkyyllJywJz1I5MSm4mzH+gI2j94U3PabR
         XvIHGILHaNTeuVzqQ2GzfL6C7g3aW7HoM5x3cFWjaOD9QFiRTTs9+WeZW/kb4A9cM3/I
         +Kp5Bcjk4FkU9UCxC1SuTkDRMYgjUXJHIk5fFC23/l/KJv8t/XC0+SZ2u7MVs/z06EFL
         N3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x56mkxZt/tjR8JPaSr3AhxFFsUsEiZvsS2Om37+dXVc=;
        b=NuomYT+Ua59AMwU+fB+LljiLEKOUDyrQVfFUqAo40dCQ8MMgxXualqd9lq4QIwWLAq
         wtIIhY92mWj7trirk9uWaq06bGnPhHamGyXdYUd5GZTmUnwY1pxtFR6z/SEMPj4jHXyN
         CVbu7fFWyuZZRx1MLl9KCipEtEolSw4BeiHIQ1HwWQMPdMmtBDsfsM1LV0oUgKF84qjQ
         AFzJg5t8a/HkEhG0xubvqi56RkcJKpUSHPPv815/lHTryaJ/tPi2H0VhGcyFpjqFXVHi
         AYgYq3dAH+GRZetRQijuwGQl2Ue2v++zcrkhM3oBJ/zixxaEl2An2IUwTaFgO/yyisD5
         S0Fw==
X-Gm-Message-State: APjAAAXQRHoiav6jdQVP+TLC5ewEA9VCOKodfVXfqfGueRBCogRajoe2
        PSG2MLPqSzgyDkorSNSEUxaTEBLJJeBqyz4II9g=
X-Google-Smtp-Source: APXvYqyuEfC6K2xi6Ni20FnB1ATzWmhKzhBlfRVDYixrf4skd2ip8AUdQPzojTh6n5xDbIgkWzLA4JzhB9N3iNt+XGE=
X-Received: by 2002:a67:eb97:: with SMTP id e23mr18029427vso.175.1552318486498;
 Mon, 11 Mar 2019 08:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190311093751.GA31092@archbookpro.localdomain>
In-Reply-To: <20190311093751.GA31092@archbookpro.localdomain>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Mar 2019 08:34:34 -0700
Message-ID: <CABPp-BEfNa88bc6rb7xWxJNOiGdTpc-9+=_1od52kDxOfK3XEA@mail.gmail.com>
Subject: Re: Deprecating git diff ..; dealing with other ranges
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Mar 11, 2019 at 2:37 AM Denton Liu <liu.denton@gmail.com> wrote:
>
> Hello all,
>
> I was in the process of deprecating `git diff <commit>..<commit>` as
> discussed here[1]. However, I ran into a weird case that I'm not sure
> how to deal with.
>
> In t3430-rebase-merges.sh:382, we have the following test case which
> invokes git diff:
>
>         test_expect_success 'with --autosquash and --exec' '
>                 git checkout -b with-exec H &&
>                 echo Booh >B.t &&
>                 test_tick &&
>                 git commit --fixup B B.t &&
>                 write_script show.sh <<-\EOF &&
>                 subject="$(git show -s --format=%s HEAD)"
> =>              content="$(git diff HEAD^! | tail -n 1)"
>                 echo "$subject: $content"
>                 EOF
>                 test_tick &&
>                 git rebase -ir --autosquash --exec ./show.sh A >actual &&
>                 grep "B: +Booh" actual &&
>                 grep "E: +Booh" actual &&
>                 grep "G: +G" actual
>         '
>
> It gets caught in my attempt to only deprecate ..'s. Technically, it's
> undocumented behaviour and it only happens to work because git-diff
> accept ranges but it doesn't operate in an intuitive way.
>
> I was just wondering what we should do about this case? Should we
> deprecate all invocations of `git diff <range>` except for the special
> case of `git diff <commit>...<commit>`, or should we _only_ deprecate
> `git diff <commit>..<commit>` and allow all other forms of ranges, even
> though it was undocumented behaviour?

There's a few angles I can think of to view this from:

First, commit^! is somewhat of a degenerate "range"; it includes only
one commit and for non-merge commits, is equal to both
commit~1..commit and commit~1...commit.  The fact that those ranges
are equal means that "git diff commit~1..commit" and "git diff
commit~1...commit" will also give equal results, i.e. that this is not
a case where confusion between '..' and '...' will cause any problems
for the user.  (Admittedly, I'm ignoring usage of ^! with a merge
commit here; I've never seen anyone use it in such a case.)

Second, ^! is unlikely to cause confusion for users the way '..' vs
'...' will, because the syntax makes no sense with diff anyway.  It's
totally magical, and when I came across it being used with diff
instead of log, I had to test it out to determine what it did.  (I do
now find it handy and use it occasionally.)  It's fairly difficult to
explain to beginners -- I tried once and quickly gave up and used
longer but more straightforward alternatives.  So, IMO, this is only a
convenience syntax for experts, and a syntax that won't be confused
with other syntax out there, so there's no need to deprecate it.

Third, we have good reason to deprecate explicit usage of '..' with
git diff, but even with those reasons some folks probably aren't
convinced it's worth the effort.  I want to avoid expanding scope, for
fear of moving some people from the sidelines of "not worth the
effort" to "this is a bad idea".  So if there are other range syntax
cases used in the wild (maybe 'git diff merge_commit^@' ?!?), we
should just leave them be and allow them to continue working.


Hope that helps,
Elijah
