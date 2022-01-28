Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDC5C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 08:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiA1Iec (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 03:34:32 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:39710 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347325AbiA1Ie2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 03:34:28 -0500
Received: by mail-pf1-f172.google.com with SMTP id a8so5497274pfa.6
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 00:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xroIpXNqezcp/aS2tXnHhyQubHoEPOh7PyJWyTjtxBE=;
        b=MCX7+xPcqx04S2BzWm+PWMWQAreT2SaQP35q/k08NbLlpiKieAoZ69IWSokOQr6zCm
         87UIOrm106Zpc6kN1GpuZZRRcNAeiCfP/S4rwEvKZoPuc+ChZZfidzT5SzwTA1IpYMBI
         UY7rZG8Kszu7/ybNeweHDAOCdJ9JGN7XfEZwpXLicmQcWepirACcZ30cmzWK6hdxG++Y
         EMb6/6FPtCBNv3Lljcs4nUti4Ets07oMuyMwuPahFjAEPpbXCXLX3bw6NClbbgWFbphy
         IaJCGWi8zIEfPEKl0mHfhmtWpq9VfDpX3NWIMnEUsvEyMvn+tbIXJ5Zjt1WAjGd7KeAI
         0Ihw==
X-Gm-Message-State: AOAM533/3EG+r/KaeYohlapRBx4EMdM0jZ5VDT55oK6oPVlQWn7rOrbp
        46IczkB7q8wpjxTfsOZwO/vQSrJjiIKx8LVnTNt2MruZbuQ=
X-Google-Smtp-Source: ABdhPJx8I359oyNh1b/5tQBLRDmWOnpAwNStY/VmEW0BYPh7vAMXYtDY9eTe5TPPN10R7PBH7eqRb2l7FvSX7SXSCPA=
X-Received: by 2002:a62:1b90:: with SMTP id b138mr6921006pfb.4.1643358867567;
 Fri, 28 Jan 2022 00:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
In-Reply-To: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 28 Jan 2022 03:34:16 -0500
Message-ID: <CAPig+cS5tOr2NRJmAC1BNQPKYyeLXy0iy36q35-y7rFkrWewJw@mail.gmail.com>
Subject: Re: [GSoC][PATCH] lib-read-tree-m-3way: modernize a test script (style)
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 1:37 AM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
> lib-read-tree-m-3way: modernize a test script (style)

Prefixing the subject with "t/" would help better explain which part
of the project this patch is touching. Perhaps:

    t/lib-read-tree-m-3way: modernize style

> As a microproject, I found another small fix regarding styling to do.

Everything above the "---" line below your sign-off will become part
of the permanent project history; everything below the "---" is mere
commentary for reviewers. Reviewers may be interested in knowing that
this is a microproject, but it likely won't be meaningful to future
readers of the project history. As such, place this sort of commentary
below the "---" line.

> I changed the old style '\' (backslash) to new style "'" (single
> quotes).

Not sure what this means. I _think_ you mean that you changed:

    test_expect_success \
        'title' \
        'body'

to:

    test_expect_success 'title' '
        body
    '

Sometimes you can convey such a meaning more clearly by a simple
example as illustrated above.

> And I also fixed some double quotes misuse.

Again, it is unclear what this means. Providing an example can help
readers understand what you changed.

> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
> Other than that, I forgot to introduce myself in the last patch and
> here it goes:
>
> I'm Shaoxuan Yuan, currently a sophomore majors in Computer Science and Engineering
> (CSE) @ University of California, Irvine.
>
> I have prior open-source experience in which I was [maintaining|contributing to] the
> Casbin community. My main language is Python, and I'm a C newbie
> because I'm quite interested in contributing to git (since it is in my main daily
> toolkit and it is a charm to wield :-) ).
>
> And for now I'm still taking baby steps trying to crack some test script
> styling issues. After getting more familiar with the git contribution
> process, I will try something bigger (though not THAT big) to get a
> firmer grasp of git.

Welcome. Please understand that all review comments (above and below)
are meant to be constructive and help familiarize you with the local
customs of the Git project; they are not meant as any sort of
criticism.

> diff --git a/t/lib-read-tree-m-3way.sh b/t/lib-read-tree-m-3way.sh
> @@ -8,16 +8,16 @@ do
>         echo This is Z/$p from the original tree. >Z/$p
> -       test_expect_success \
> -           "adding test file $p and Z/$p" \
> -           'git update-index --add $p &&
> -           git update-index --add Z/$p'
> +       test_expect_success 'adding test file $p and Z/$p' '
> +           git update-index --add $p &&
> +           git update-index --add Z/$p
> +    '

Taking into consideration the difference in behavior of single-quoted
strings and double-quoted strings, changing this test's title from
double- to single-quoted is undesirable since `$p` is supposed to be
interpolated into the title; the title should not contain a literal
"$p". (Unlike the test title which is simply echo'd/print'd, the test
body gets eval'd, which is why `$p` in the body is acceptable even
though the body is in single-quotes.)

> -test_expect_success \
> -    'adding test file SS' \
> -    'git update-index --add SS'
> +test_expect_success 'adding test file SS' '
> +    git update-index --add SS
> +'

Since you're touching this anyhow as part of fixing style issues, you
should also fix the indentation to use tabs rather than spaces. The
same comment applies to the rest of the patch, as well.

>  for p in M? Z/M?
>  do
>      echo This is modified $p in the branch A. >$p
> -    test_expect_success \
> -       'change in branch A (modification)' \
> -        "git update-index $p"
> +    test_expect_success 'change in branch A (modification)' '
> +        git update-index $p
> +    '
>  done

In this case, the indentation of the entire body of the for-loop needs
to be fixed to use tabs rather than spaces, however, fixing all the
indentation problems together with the other problems can make for a
too-noisy patch for reviewers to really see what is going on. As such,
it may be better to make this a multi-patch series in which one patch
fixes indentation problems only.

As mentioned above, changing the body of the test from double- to
single-quoted string should (presumably) be okay since the body gets
eval'd and `$p` will be visible at the time of `eval`, however, mixing
this sort of change in with all the other changes being made makes it
hard for reviewers to spot such little details, let alone reason about
correctness. As such, switching of quote types is also probably the
sort of change which should be split out into its own patch. The same
comment applies to other changes following this one.

Overall, with the exception of the test title which needs to
interpolate `$p`, the rest of the changes are probably reasonable and
benign. It's important to understand that lengthy patches like this
full of mechanical changes tend to be quite taxing on reviewers, so
it's a good idea to help in any way you can to ease the review burden.
This can be done, for instance, by making only a single type of change
per patch (i.e. indentation fixes), or by limiting the scope or
breadth of the changes, which is especially important for this sort of
"noise" change -- a change just for the sake of change -- which
doesn't have any immediate practical benefit.
