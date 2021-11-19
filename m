Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D3BC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 04:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A7061246
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 04:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhKSEE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 23:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhKSEE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 23:04:58 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35711C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 20:01:57 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id l19so9009109ilk.0
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 20:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HeB4vrjJobDEcBffGlHRXkML+7Bk+h24vFpJymBWLR0=;
        b=HBHGX3enQ7hfI4GMqhglOYaRP+ku4JqiLqL7k9WJx3rjEGhvTk4bMiYrIuXRTodTam
         sLKqJlYEAxIWhF2se//ChW59kPVvvbMvhE4wa/IoXypbgJC6YZxVyFOzmSI+Gp42quRm
         ttabnXw3tn1FvsTjiMtITLh7jmJPMod5DssMkXfsvXXD/ApRCGIY8tFAiJ2l+FKFBEix
         3FKzuIFS2YUm7Rt3WtnrzJdwVcKi+l9SrG0BmkIzHKnBXWwDQ8SHiSo4WXU8kTy3u990
         SHZkouyL7sAcezr2nND151WfZaHGc2EMMOVELRQ/OKOoA5uBFhfltE6l29Kg5vpUX1pu
         x4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeB4vrjJobDEcBffGlHRXkML+7Bk+h24vFpJymBWLR0=;
        b=q1XuXuikMOBjWtSB8opt7t2Xxoq3hle1IaqQi8F/ko0UMakUFqo+axdjF8KRTZMaVQ
         Ylk1tu/ddFJOQUVFIn4pmrhPRgP5c/+DaR4x+Z7pNYEZLkphy0Itm4AVFKKfMA9SS/Qo
         JpvTmPsfJekZ57dO7imRCLTL0Fp5yi1Q5aZQbRDNlUOeboVJReFmGq288FVMXZrubXir
         rP2o1oq/YK3S4Q/OhE7GOgPmAYZE443D/vgtyHeGSom9fQDj4fQ1OhzhSz92vWZc4PAY
         pOOQeRr2mXcLFM2Tyhbm1u5vz57VV4xe5S7Q8JXAZoyYTOkvEigAdG6K7GFFE6e/0RoE
         sZkw==
X-Gm-Message-State: AOAM531wvZwrfy5UPPH5XKTxfUX5aVrtyXUElxR30lC1l2pCfUwThvTd
        kSIxlGlNdsuvBkaU0mXalG00ZaOOzYrn20fPRyg=
X-Google-Smtp-Source: ABdhPJxxeAzeXydrgEhIlYAFsZxitgK8y+Oir3UhJF0+ULP3OLT3996XP7ATM1FOOSkp3JNBbQcpGJ9VaW558p/D/sc=
X-Received: by 2002:a92:ca0b:: with SMTP id j11mr2594825ils.289.1637294516567;
 Thu, 18 Nov 2021 20:01:56 -0800 (PST)
MIME-Version: 1.0
References: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
 <YZaHpJKeyDEY8qKW@coredump.intra.peff.net> <2bd2269f-c7f1-7afb-7052-48fac148dffd@gmail.com>
In-Reply-To: <2bd2269f-c7f1-7afb-7052-48fac148dffd@gmail.com>
From:   Danial Alihosseini <danial.alihosseini@gmail.com>
Date:   Fri, 19 Nov 2021 07:31:45 +0330
Message-ID: <CACLOEFbY3LwMa2uhc=9jmcGFf0mvWzEM=YityLyFcuGWXVmqbw@mail.gmail.com>
Subject: Re: git 2.34.0: Behavior of `**` in gitignore is different from
 previous versions.
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your follow-up.

I wanted to ignore all files in the "data" folder except ".txt" ones.

As mentioned in the gitignore doc, there should be a difference
between "**" and "**/".

> A trailing "/**" matches everything inside. For example, "abc/**" matches all files inside directory "abc", relative to the location of the .gitignore file, with infinite depth.

and,
>
> A slash followed by two consecutive asterisks then a slash matches zero or more directories. For example, "a/**/b" matches "a/b", "a/x/b", "a/x/y/b" and so on.

and also,
>
> It is not possible to re-include a file if a parent directory of that file is excluded.

So, I excluded all files by "data/**", re-included just directories
(at any depth) by "!data/**/" and, re-included ".txt" files (at any
depth) by "!data/**/*.txt".
However, if I wanted to re-include a directory and all of its
contents, I could use something like "!data/data1/**", without
trailing slash.
As I see, there is no separation between "**" and "**/" in the current version.

I think there is another point that the previous behavior test case
should be like this:
test_expect_success 'directories and ** matches' '
    cat >.gitignore <<-\EOF &&
    data/**
    !data/**/
    !data/**/*.txt
    EOF
    git check-ignore file \
        data/file data/data1/file1 data/data1/file1.txt \
        data/data2/file2 data/data2/file2.txt >actual &&
    cat >expect <<-\EOF &&
    data/file
    data/data1/file1
    data/data2/file2
    EOF
    test_cmp expect actual
'
Thanks
Danial


On Fri, Nov 19, 2021 at 1:40 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/18/2021 12:04 PM, Jeff King wrote:
> > On Thu, Nov 18, 2021 at 08:11:04PM +0330, Danial Alihosseini wrote:
> >
> >> What did you do before the bug happened? (Steps to reproduce your issue)
> >> Consider the following project structure
> >> - data
> >>   - data1
> >>     - file1
> >>     - file1.txt
> >>   - data2
> >>     - file2
> >>     - file2.txt
> >> - .gitignore
> >>
> >>
> >> `.gitignore` is as follows:
> >> ```
> >> data/**
> >> !data/**/
> >> !data/**/*.txt
> >> ```
> >> What did you expect to happen? (Expected behavior)
> >>
> >> I expect all files in `data` folder to be ignored except `.txt` files.
> >>
> >> What happened instead? (Actual behavior)
> >>
> >> `file1` and `file2` are not ignored.
> >> Here is the `check-ignore` output:
> >> ```
> >> $ git check-ignore -v data/data1/file1
> >> .gitignore:2:!/data/**/ data/data1/file1
> >> ```
> >
> > Thanks for an easy reproduction. It looks like this changed in
> > f6526728f9 (dir: select directories correctly, 2021-09-24). Author cc'd.
>
> Thanks for the bisect and CC.
>
> > The key thing seems to be that the second line of your .gitignore should
> > match only directories (because of the trailing slash), but no longer
> > does.
>
> Doesn't "matching only directories" mean it would match everything
> within that directory? (It also means that "data/file" is not matched,
> which is still correct.)
>
> My interpretation of these patterns is that everything in data/data1/
> and data/data2/ should not be ignored, making it seem like the change
> fixed a bug (it definitely changed behavior).
>
> Just for extra clarity, this test currently passes:
>
> test_expect_success 'directories and ** matches' '
>         cat >.gitignore <<-\EOF &&
>         data/**
>         !data/**/
>         !data/**/*.txt
>         EOF
>         git check-ignore file \
>                 data/file data/data1/file1 data/data1/file1.txt \
>                 data/data2/file2 data/data2/file2.txt >actual &&
>         cat >expect <<-\EOF &&
>         data/file
>         EOF
>         test_cmp expect actual
> '
>
> but the previous behavior would have passed this test:
>
> test_expect_success 'directories and ** matches' '
>         cat >.gitignore <<-\EOF &&
>         data/**
>         !data/**/
>         !data/**/*.txt
>         EOF
>         git check-ignore file \
>                 data/file data/data1/file1.txt \
>                 data/data2/file2.txt >actual &&
>         cat >expect <<-\EOF &&
>         data/file
>         EOF
>         test_cmp expect actual
> '
>
> I seek more clarity on this. Specifically: if we match a directory
> then should we not also match the contents within?
>
> Thanks,
> -Stolee
