Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F8A1FA21
	for <e@80x24.org>; Tue, 10 Oct 2017 10:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754416AbdJJKaw (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 06:30:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34758 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdJJKav (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 06:30:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id b85so14232318pfj.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D4FGoc7MnRHkrjpGlna606cvaK6dt2B8Ts8tUpMlz4o=;
        b=V1/51oDf+gPsTqltAd74oqs0NRC2U8DoWfA/0fJew0bd/vuJI7HbfJ7uGqi8siLatR
         MO/Vkwd2fXgPryfRQhgAsMoFz1p34JDQMOeUXv2k8Q4RHtHr4cyKsFtCXEWi10BZwQk3
         xHL3mZFpzovRx/qzs64PPTogTSruDvstniEKO9X8BHkZRAqHchQWvOjxHEBK5SI3SR2V
         QmRD5a2v7PUFVeYZbM+N9BfVHVQV5974h2L8rpoQPZfuS0lfkDyg88eWRoneP93tAMfi
         9mquwjG9pSsp4ix2dVo/+d3pqzlE/A44IskudhGbe+XHoslwjMuA3UJrOZIE2OWJ9FXB
         V4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D4FGoc7MnRHkrjpGlna606cvaK6dt2B8Ts8tUpMlz4o=;
        b=jB0vGfwyB5y0yWbMhUOYagV+TLldd3qZx4Hfb6PMG196pi0s94G5doq236lgVbkjKm
         UhskL9U4rS4gWE6qo3KnVsM8OZWdQXeVIwXsHtcz3YIhF53vKOpA9jVAAgNF+Jfu4qON
         dlZTC0GdbnDf9SwnAiSGFHf9LVmIM7lcIDrTH58SxAImQt8cr5xRGT85oigF859ZRk0H
         nPwZrkMJbXjuDjP0EXOniHWESB8n3j4vz0iQj1Hr/cqp29sqQ94cJNTYTDzSpDLw5P6t
         NjFy4zPu5oh6Pqq/QJJ1kbnjzh3hS+on5vinjSex76xrHGvUu2PyXT9bKa71THaAbzb7
         Rj8A==
X-Gm-Message-State: AMCzsaUpGEpVi6XLNLDBKdZybvdFFO3/1AgWpB0y6YKV4osNd5UjfjtV
        kCVgGks3kheI/YGq6TiO+AcBBM8aOV0fa1eHIwYEx2J/
X-Google-Smtp-Source: AOwi7QAnFGbC93KFArzwI5k9tGGuju3B1IV8vpoG7y4iVHflMN+HSmuVqfKDjO+esrqKAuSg3mmqbedfM0+LpNVV1Zo=
X-Received: by 10.84.185.106 with SMTP id e39mr11578952plg.333.1507631450582;
 Tue, 10 Oct 2017 03:30:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Tue, 10 Oct 2017 03:30:49 -0700 (PDT)
In-Reply-To: <20171009214543.12986-1-me@ikke.info>
References: <20171009214543.12986-1-me@ikke.info>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Oct 2017 12:30:49 +0200
Message-ID: <CAN0heSoWTpVZXmJkoEQtc_rjFj3PdPWV_37B9LukxxsYy5ox1w@mail.gmail.com>
Subject: Re: [RFC] column: show auto columns when pager is active
To:     Kevin Daudt <me@ikke.info>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 October 2017 at 23:45, Kevin Daudt <me@ikke.info> wrote:
> When columns are set to automatic for git tag and the output is
> paginated by git, the output is a single column instead of multiple
> columns.
>
> Standard behaviour in git is to honor auto values when the pager is
> active, which happens for example with commands like git log showing
> colors when being paged.
>
> Since ff1e72483 (tag: change default of `pager.tag` to "on",
> 2017-08-02), the pager has been enabled by default, exposing this
> problem to more people.

Oh. :( I didn't know about "column" to be honest.

> finalize_colopts in column.c only checks whether the output is a TTY to
> determine if columns should be enabled with columns set to autol. Also ch=
eck
> if the pager is active.
>
> Helped-by: Rafael Ascens=C3=A3o <rafa.almas@gmail.com>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> ---
> This came to light when someone wondered on irc why
> column.tag=3D[auto|always] did not work on Mac OS. Testing it myself, I
> found it to work with always, but not with auto.
>
> I could not get the test to work yet, because somehow it's not giving
> any output, so feedback regarding that is welcome.

I had slightly more success with PAGER=3D"cat >actual", but the test is
flaky for some reason. In any case, it might make sense to test an
actual use-case also. Of course, the code should be largely the same,
but in builtin/tag.c, it's quite important that `setup_auto_pager()`
and `finalize_colopts()` are called in the right order. In other words,
there is some regression-potential. This is a whitespace-damaged and
hacky attempt to test. Maybe it helps a little. I hope I'll have more
time later today.

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index f0f1abd1c..91f2b5871 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -214,6 +214,19 @@ test_expect_success TTY 'git tag as alias
respects pager.tag with -l' '
        ! test -e paginated.out
 '

+test_expect_success TTY 'git tag with column.tag=3Dauto' '
+       test_commit second &&
+       test_commit third &&
+       test_commit fourth &&
+       test_when_finished "git reset --hard HEAD~3" &&
+       cat >expected <<\EOF &&
+fourth   initial  second   third
+EOF
+       rm -f paginated.out &&
+       test_terminal git -c pager.tag -c column.tag=3Dauto tag &&
+       test_cmp expected paginated.out
+'
+
 # A colored commit log will begin with an appropriate ANSI escape
 # for the first color; the text "commit" comes later.
 colorful() {
